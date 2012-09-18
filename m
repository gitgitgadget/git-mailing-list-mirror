From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff across submodules
Date: Tue, 18 Sep 2012 12:28:48 -0700
Message-ID: <7vobl3m8pb.fsf@alter.siamese.dyndns.org>
References: <1347937959.96154.YahooMailClassic@web39403.mail.mud.yahoo.com>
 <5058C53B.5040401@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kenny Simpson <theonetruekenny@yahoo.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 18 21:29:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE3Tg-0005nk-Nf
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 21:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754481Ab2IRT2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 15:28:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37673 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754427Ab2IRT2v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 15:28:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 995DA9916;
	Tue, 18 Sep 2012 15:28:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9sjQy4Mm7Sj6U4emMEQOgYcH9RY=; b=NMSBQ/
	VjX1nzOFl+aYOkVfAPWkRmIw0uq/tjKhCaMprjl1z7nn90RP244Kh7F1WSn+cH/s
	LrPKWSUTGCZ+RmzT+cPgsgSsKLzVrz5Wno55YBSXwClmkX0O5oiBhSg8c0WoWjnX
	RA/PJoXmEJfTg5VDxrYJmjfCzrxWXDQpWfZrs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TgMQER6Rg3KsMFd9s+OdL4JyXyoKrGQp
	+2iND6qsE60h0vTGleLn5pHB8NfOlQZhfnJO280gtwSRUCyb7rU8dE67n/EDjmlu
	QPZgwRRd4IXirUVE79/jZiT/HQ6Arr+vqZ7nR7DY3y0CbcVI0fuIPsc1KH/2qshy
	Q8arIITHDK0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85DA09915;
	Tue, 18 Sep 2012 15:28:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA4A79913; Tue, 18 Sep 2012
 15:28:49 -0400 (EDT)
In-Reply-To: <5058C53B.5040401@web.de> (Jens Lehmann's message of "Tue, 18
 Sep 2012 21:02:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12BCF96C-01C7-11E2-857F-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205854>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 18.09.2012 05:12, schrieb Kenny Simpson:
>>   Is there any nice way to get a diff and/or diffstat of both a project and its submodules between two revisions of the main project?
>> 
>> Something like 'git diff --stat tag_a tag_b' but also including the diffstat on the submodule from the revision tied to in tag_a to the revision tied to tag_b.  A few shell backflips will do it, but this seems like I'm missing something.
>
> Unfortunately that isn't possible yet, "git diff" still has to learn the
> --recurse-submodules option. And as far as I know, nobody is currently
> working on that.

I do not think it is _that_ unfortunate, at least for two reasons.

When I made something a submodule, not a plain vanilla directory, I
did want it to be treated differently from a collection of files in
random states (which is what a directory is), but as a logical unit.
If I bind another project 'frotz' at my path 'lib/frotz' and ask for
diff of two versions of my superproject, e.g.

    $ git diff v1.0 v1.1

I am more interested in finding out that we used to use v2.5 of
'frotz' back when we were at v1.0 but in our v1.1 we downgraded it
to v2.4, perhaps because we found a regression in the 'frotz'
library, rather than the whole reverse differences between v2.4 and
v2.5 of the frotz project.  That difference, when I want to, I can
get by going to that submodule and grab it myself with

    $ cd lib/frotz &7 git diff v2.4 v2.5

I also suspect that you do not have to change "git diff" at all to
show the patch recursively by using the attribute mechanism (look in
Documentation/gitattributes.text for a string GIT_EXTERNAL_DIFF).
It might be just as simple as doing this:

	echo >.gitattributes "/lib/frotz diff=subrecurse" 
	git config diff.subrecurse.command $HOME/bin/diff-subrecurse
        cat >$HOME/bin/diff-subrecurse <<\-EOF
	#!/bin/sh
        path=$1 old_hex=$3 new_hex=$6
        unset GIT_DIR
        cd "$path" || exit 1
        git diff "$old_hex" "$new_hex"        
        EOF
        chmod +x $HOME/bin/diff-subrecurse

The corner cases like "new submodule", "removed submodule" are left
as an exercise to the reader ;-)
