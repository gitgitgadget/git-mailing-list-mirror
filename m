From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] hooks/update: Add a hooks.denyunsignedtags option
Date: Mon, 21 Dec 2015 10:13:31 -0800
Message-ID: <xmqq37uvhdpw.fsf@gitster.mtv.corp.google.com>
References: <1450719124-10558-1-git-send-email-jak@debian.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Julian Andres Klode <jak@debian.org>
X-From: git-owner@vger.kernel.org Mon Dec 21 19:13:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB4xn-0006Bh-9g
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 19:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbbLUSNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 13:13:35 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60248 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750914AbbLUSNe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 13:13:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 79C013392B;
	Mon, 21 Dec 2015 13:13:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xpVr6SEjsPNcljXyQ8CNxgwybbw=; b=UY+WsY
	XAtGjZb4FpHgtiptnh95U37tuVDxeE8u7Hh2UfC7Qk6Re9RpIoXhU/TXnkmNFDQW
	h4e7pZLCggS2xB/djMC2o6ihSDOOIrfkFf/ap9o3DEoZ6mjsmTDDk6CaSQKRdxYa
	cOC+QohicoQt7ed7P7NlZUwe6EufOdjndY20E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jJjLl9w2fddNbAvgAf/uLHH4tC/1HWqX
	Q461sfOJYmhSDlk2L132JZS0sh45/821UCBugc+DA1ApxyENtP43zwygeyP/O+5T
	qjF6OcAtT7TeiwFRf7Pua4fUjyWr+qsegVe+tzkTGEqz2JQqyMW0szi/FoEGDOY7
	kFR7w8BM+q8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 70D913392A;
	Mon, 21 Dec 2015 13:13:33 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DA59D33929;
	Mon, 21 Dec 2015 13:13:32 -0500 (EST)
In-Reply-To: <1450719124-10558-1-git-send-email-jak@debian.org> (Julian Andres
	Klode's message of "Mon, 21 Dec 2015 18:32:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8B8F1F64-A80E-11E5-A62A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282805>

Julian Andres Klode <jak@debian.org> writes:

> Introduce an option to deny unsigned tags from entering
> a repository. This is useful in teams where members forget
> to sign their release tags.
>
> It does not actually check whether the signature is actually
> complete or valid, it just checks for the beginning of a
> signature, as further checks would be too involved.
>
> This effectively also denies un-annotated tags, as those
> are unsigned by definition.
>
> Signed-off-by: Julian Andres Klode <jak@debian.org>
> ---
>
> Note: Submitted for review on Sep 12, re-asked on Sep 22, but
> no feedback, so I assume it's good to go,

You assumed wrong.  No response merely means that the patch did not
find anybody who is interested enough to even comment on it.

> see http://thread.gmane.org/gmane.comp.version-control.git/277722
> for details

There aren't much details there, but thanks for the pointer.  It
gave me a good guess as to why nobody commented on it.  You said
"locally fixed" without showing the fixed result and then asked "any
comments?"  People didn't have anything to comment on.

Anyway, let's see what we have here.

> Subject: Re: [PATCH] hooks/update: Add a hooks.denyunsignedtags option

See "git log --oneline --no-merges" and notice the local
convention.  s/Add/add/; 

> @@ -71,7 +75,7 @@ case "$refname","$newrev_type" in
>  	refs/tags/*,commit)
>  		# un-annotated tag
>  		short_refname=${refname##refs/tags/}
> -		if [ "$allowunannotated" != "true" ]; then
> +		if [ "$allowunannotated" != "true" ] || [ "$denyunsignedtag" = "true" ]; then

Somehow this combination of "allow-unannotated" and "deny-unsigned"
bothers me.  Would it make the resulting code and logic more
consistent and easier to follow if this new setting is renamed to
"$allowunsigned", I wonder...

Can we do something with the overly long line, by the way?

>  			echo "*** The un-annotated tag, $short_refname, is not allowed in this repository" >&2
>  			echo "*** Use 'git tag [ -a | -s ]' for tags you want to propagate." >&2

When $denyunsignedtag is in effect, isn't the user saying that _all_
tags _must_ be signed?  In other words, isn't it a configuration error
if allowunannotated and denyunsignedtag are both set to true?

And if you reject that configuration error early, then perhaps you
can even only check allowunannotated here without touching anything
in this hunk, perhaps doing something like this upfront:

    allowunannotated=$(git config --bool hooks.allowunannotated || echo false)
    allowunsigned=$(git config --bool hooks.allowunsigned || echo true)

    case "$allowunannotated,$allowunsigned" in
    true,false)
            echo >&2 "*** inconsistent setting"
            exit 1
    esac

Then at this point of the code, if your new condition holds true,
i.e. $allowunsigned is set to "false", $allowunannotated must be
something other than "true", so you do not have to touch the "if".

> @@ -86,6 +90,14 @@ case "$refname","$newrev_type" in
>  		;;
>  	refs/tags/*,tag)
>  		# annotated tag
> +		if [ "$denyunsignedtag" != "true" ] || git cat-file -p $newrev | grep -q 'BEGIN PGP SIGNATURE'; then
> +			:

Again, can we do something with the overly long line?

Use of "cat-file -p" is a bad manner in scripts, as we reserve the
right to change what "-p" output looks like purely on human
usability.  "cat-file tag", perhaps?

Also,

	$ git grep ' PGP '

in our source tells me that we use a bit tighter pattern even when
we are casually trying to see if the thing looks like a PGP signed
payload.

	if test "$allowunsigned" = "true" ||
           git cat-file "$newrev" |
           grep -q '^-----BEGIN PGP SIGNATURE-----$'
	then
		...

or something?


> +		else
> +			echo "*** Tag '$refname' is unsigned"
> +			echo "*** Unsigned tags are not allowed in this repository." >&2
> +			exit 1
> +		fi
> +
>  		if [ "$allowmodifytag" != "true" ] && git rev-parse $refname > /dev/null 2>&1
>  		then
>  			echo "*** Tag '$refname' already exists." >&2
