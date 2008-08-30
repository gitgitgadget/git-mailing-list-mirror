From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Start conforming code to "git subcmd" style
Date: Sat, 30 Aug 2008 13:49:17 -0700
Message-ID: <7vwshyfctu.fsf@gitster.siamese.dyndns.org>
References: <20080830111253.GA9148@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heikki Orsila <heikki.orsila@iki.fi>
X-From: git-owner@vger.kernel.org Sat Aug 30 22:50:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZXOy-0002Gq-Ew
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 22:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194AbYH3Ut0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 16:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753827AbYH3UtZ
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 16:49:25 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbYH3UtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 16:49:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4A24E6D8A9;
	Sat, 30 Aug 2008 16:49:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0ED1A6D8A7; Sat, 30 Aug 2008 16:49:18 -0400 (EDT)
In-Reply-To: <20080830111253.GA9148@zakalwe.fi> (Heikki Orsila's message of
 "Sat, 30 Aug 2008 14:12:53 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1FB14186-76D5-11DD-B9F7-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94422>

Heikki Orsila <heikki.orsila@iki.fi> writes:

> User notifications are presented as 'git cmd', and code comments
> are presented as '"cmd"' or 'git's cmd', rather than 'git-cmd'.

Thanks.

The part I will _not_ comment on in your patch looked all good, so to
reduce further back-and-forth, I'd apply them to 'maint', excluding the
parts I did comment on in this message.

> diff --git a/builtin-apply.c b/builtin-apply.c
> ...
> @@ -506,17 +506,17 @@ static char *gitdiff_verify_name(const char *li
> ...
> -			die("git-apply: bad git-diff - expected /dev/nu...
> +			die("git apply: bad git-diff - expected /dev/nu...
> ...
> -			die("git-apply: bad git-diff - inconsistent %s ...
> +			die("git apply: bad git-diff - inconsistent %s ...
> ...
> -			die("git-apply: bad git-diff - expected /dev/nu...
> +			die("git apply: bad git-diff - expected /dev/nu...
> ...

I'd vote for doing "s/git-diff/patch/" here.  After looking at
builtin-apply.c, there is no other error/die messages that would become
ambiguous, so such a rewording won't make it harder to help people who saw
any of these error messages (or other error messages from the "git-apply"
program).

> diff --git a/builtin-blame.c b/builtin-blame.c
> ...
> @@ -2299,12 +2299,12 @@ int cmd_blame(int argc, const char **argv, co...
> ...
> -		OPT_BIT(..."Use the ... as git-annotate (Default: off)"...
> +		OPT_BIT(..."Use the ... as git annotate (Default: off)"...
> ...
> -		OPT_STRING(..."Use ...instead of calling git-rev-list"),
> +		OPT_STRING(..."Use ...instead of calling git rev-list"),
> ...

A two-word command name in a prose is hard to read; "rev-list" is not a
word and that makes the problem less serious, but it would be easier to
read if these two word command names are quoted or grouped together in
some way to make it clear they form a single noun and the sentence is
talking about a single "thing".

The old "git-foo" spelling was good for that purpose, but it will invite
user confusion so we cannot use it anymore.  Perhaps we can say "instead
of calling 'git rev-list'"?

The command name at the beginning of die message does not have this issue.
E.g. the colon in:

	die("git foo: I hate you");

is sufficient to make it clear that these two words form a single noun;
i.e. "I'm 'git foo' program, and I am telling you that I hate you".

But it might be just me, so before asking you to reroll another round, I'd
like to hear opinions from the list.

 (1) No, JC is worrying too much about readability; Heikki's patch is good;

 (2) JC's right -- "instead of calling 'git rev-list'" is much better;

 (3) Something else?

> diff --git a/builtin-branch.c b/builtin-branch.c
> @@ -526,7 +526,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
> ...
> -		OPT_GROUP("Specific git-branch actions:"),
> +		OPT_GROUP("Specific git branch actions:"),
> ...

Likewise.
