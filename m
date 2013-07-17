From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] git diff -q option removal
Date: Wed, 17 Jul 2013 10:04:08 -0700
Message-ID: <7vvc496ruf.fsf@alter.siamese.dyndns.org>
References: <20130714220739.GC13444@google.com>
	<1373970487-32595-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com, trast@student.ethz.ch
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jul 17 19:04:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzV9E-0006ZW-Jt
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 19:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932703Ab3GQREM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 13:04:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59855 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932641Ab3GQREL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 13:04:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABABB31971;
	Wed, 17 Jul 2013 17:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GpDozH3ZPYbq/OyG0RbdGzjIRYQ=; b=hOnAAY
	IKznIPGK0cOyiV97qoPfMc+3EekbXaNk0O+Z+DYkTlRhpTR5ilnOgpGtqkQTgnqo
	lGTpJCPb3EjDZrzTb1Cbh+LunsT7Y0t5qt4QIyrg/4t6+5k2yHYnEl4+t5ja1NdJ
	ISRKOM74/MV6tIuFCXfY+ixqpWbT9JM9D2VAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w5y7YXxeDE3X78Qc33VGKH1GNks6PHMl
	YL8KV8L+SrchSLYNwNaOCCM3MlRkjvaqS01Phj0XPvi0W43vF9CKOYzIpZSDik2l
	VaP/TPIVekmAwWBVME46UCO093mvCh7bqKLaSJ1bQuhcZKpqCxlFqYE9Affv+WVr
	UO3U9BtoZGM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F97C31970;
	Wed, 17 Jul 2013 17:04:10 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFA5D3196F;
	Wed, 17 Jul 2013 17:04:09 +0000 (UTC)
In-Reply-To: <1373970487-32595-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Tue, 16 Jul 2013 12:28:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E5BDD1AA-EF02-11E2-AD2A-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230634>

Stefan Beller <stefanbeller@googlemail.com> writes:

> The changes in the following patch are in diff_no_index.c, but the
> diff_no_index(...) is called from cmd_diff, which is in builtin/diff.c
> That cmd_diff is actually called from git.c having the
> { "diff", cmd_diff }, entry in handle_internal_command.
>
> My question now is this: Why is the builtin/diff.c relying on stuff
> outside of builtin/ ? Wouldn't it be better to move all these files
> (such as diff_no_index.c) into the builtin folder as well?

Builtins link all sorts of stuff from outside, e.g. diff.c and
diffcore-*.c at the toplevel.  I do not see diff_no_index.c is any
different, so I am probably not understanding your question.

> Regarding the removal of the -q option, I tried it in the second patch.
> Is it as easy as that, or am I missing the point?
> 
> The first patch doesn't change the behavior, so I'd assume it's safe to 
> apply it to origin/sb/misc-fixes, whereas the second patch will make 
> git diff complain about the -q option, so I'd assume it would wait for the
> next major release?
>
> Before:
> 	touch actual_file
> 	git diff -q  actual_file no_file
> 	error: Could not access 'no_file'

Hmm, do you really get that error message?  I think you would get

    fatal: ambiguous argument 'no_file': unknown revision or path not in the working tree.

> 	echo $?
> 	1

The command line parsing infrastructure has changed vastly since
"show-diff" days (see below for a history lesson); I think your
"Before" should read more like this

	git diff -q -- actual_file no_file

and it should not show removal of no_file in its output.  E.g. in
git.git

	$ git reset --hard
        $ rm COPYING
        $ git diff -q -- COPYING

should show nothing.

I personally think "-q" no longer makes sense in today's codebase,
but I am not convinced that removal of '-q' from the proper "git
diff-files" and the "git diff --no-index" (aka "I am too lazy to
teach our diff enhancement to other people's diff implementations,
so let's throw in a "files do not have to be tracked in Git
repository at all" mode") is the right direction to go.

The "-q" option is a remnant from the "show-diff" command, the
precursor of today's "git diff-files" (back then, we didn't even
have "git" potty.  The user literally typed "show-diff", not "git
show-diff").

ca2a0798 ([PATCH] Add "-q" option to show-diff.c, 2005-04-15) added
that option.  Back then, we did not have pathspec matching, and we
iterated over command line arguments, and required all of them exist
as filesystem entities.  "-q" was a way to defeat that "you name a
file, it must exist in the working tree" safety, and also at the
same time not give output for such a file that was removed from the
working tree.

These days, the former "safety" is enforced by the generalized
revision parser ("is it a path or is it a rev?") code and the "--"
delimiter on the command line is the way to defeat it.  The latter
is done by giving a filtering specification that lack D to the
"--diff-filter".

If we wanted to make "-q" follow the spirit of its original addition
to "show-diff" again, we could internally add a diff-filter when the
"-q" option is parsed.

"git diff -q ..." is "git diff --diff-filter=ACMRTUB ...", and "git
diff -q --diff-filter=AD" is "git diff --diff-filter=A".  That would
let us remove the special case for SILENT_ON_REMOVED, and also make
"-q" work across various commands in the "diff" family.  It might
even make it work for "diff --no-index", but I didn't bother to
check.

> After:
> 	touch actual_file
> 	git diff -q  actual_file no_file
> 	fatal: invalid diff option/value: -q
> 	echo $?
> 	128
>
> Thanks,
> Stefan
>
> Stefan Beller (2):
>   diff --no-index: remove nonfunctional "-q" handling
>   git diff: Remove -q option to stay silent on missing files.
>
>  Documentation/git-diff-files.txt | 6 +-----
>  diff-no-index.c                  | 5 -----
>  2 files changed, 1 insertion(+), 10 deletions(-)
