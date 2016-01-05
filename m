From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/subtree: Remove --annotate
Date: Tue, 05 Jan 2016 09:33:33 -0800
Message-ID: <xmqqsi2cj5hu.fsf@gitster.mtv.corp.google.com>
References: <1451963101-4901-1-git-send-email-greened@obbligato.org>
	<1451963101-4901-2-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, techlivezheng@gmail.com,
	alex.crezoff@gmail.com, davvid@gmail.com, cbailey32@bloomberg.net,
	danny0838@gmail.com, prohaska@zib.de, th.acker@arcor.de,
	sschuberth@gmail.com, peff@peff.net, gitter.spiros@gmail.com,
	nod.helm@gmail.com
To: David Greene <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Tue Jan 05 18:33:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGVUK-0007J3-LG
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 18:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbcAERdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 12:33:37 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63146 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751487AbcAERdg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 12:33:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EA55236899;
	Tue,  5 Jan 2016 12:33:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UGphH3MfX5R3THJ0sHFXmmRpHVc=; b=ctSYSg
	HQeOjVj/bJC9LnxaGKKCBla8/i4v4uJpKxBXF4KLNEphsmQ+gAH4Yeg4HLlPFv5Q
	4g5JYA+CRNGpz1su7f1ojHfgEDB2uBO+ejdjQXZga+21VN4FrezH6lyAMH+sjaTc
	8ULE/Ce0+UyMl9COwjxDkptiyUXopt1UqAfqE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EdWEtLwBkvta/v97KdOaIP6I9/tQuej6
	10nVynR278ENe8HVp5zESbdBqOt3GikzPQ1GcEx6U+gRB0R6BWEEBMXhaQOzswOz
	BwufeW4jKqJX0xtTDOlOPoRXnQxeSDWWQk1yMpAlbA1LrGImk3yoYnLJlz/5LWaP
	OrekBZc44YQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DD89C36898;
	Tue,  5 Jan 2016 12:33:34 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3E5D536897;
	Tue,  5 Jan 2016 12:33:34 -0500 (EST)
In-Reply-To: <1451963101-4901-2-git-send-email-greened@obbligato.org> (David
	Greene's message of "Mon, 4 Jan 2016 21:05:01 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7219C4A6-B3D2-11E5-AA01-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283388>

David Greene <greened@obbligato.org> writes:

> From: "David A. Greene" <greened@obbligato.org>
>
> Remove --annotate.  This obviates the need for an --unannotate
> command, which is both an obvious addition and difficult to define
> due to the numerous ways one might want to specify how to edit
> commit messages.  git has other tools more suited to rewriting
> commit messages and it's easy enough to use them after a subtree
> split.  Such tools include filter-branch, rebase -i and
> commit --amend.

I do not think that "there are other ways to do this" is a good
justification for removing a feature, unless it can be shown that
nobody is using it, of course.

> @@ -319,7 +315,7 @@ copy_commit()
>  			GIT_COMMITTER_NAME \
>  			GIT_COMMITTER_EMAIL \
>  			GIT_COMMITTER_DATE
> -		(printf "%s" "$annotate"; cat ) |
> +		(echo -n ""; cat ) |

I can see that by changing "printf something" with 'echo -n ""', you
are making it clear that we are stopping to add that something to
the pipeline, but (1) I think the intended effect of running 'echo
-n' on an empty string is to do nothing, and (2) 'echo -n' is not
portable [*1*], so this leaves a puzzling code that makes future
readers scratch their heads.

I wonder why this cannot be simply the removal of the entire line,
making the resulting implementation more like this:

                git log -1 --pretty=format:... "$1" |
                (
                        read ... various variables ...
                        export ... various variables ...
        -		(printf "%s" "$annotate"; cat ) |
                        git commit-tree "$2" $3 # reads the rest of stdin
                ) || die "cannot copy"

That is, just feed the remainder of what is coming directly to the
command?

[Footnote]

*1* http://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html

says """Implementations shall not support any options."""; '-n'
comes from BSD and SysV way of supressing the final newline is to
end the string with "\c".
