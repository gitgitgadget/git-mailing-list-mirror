From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs/git-mailinfo: Mention the manual separator (---)
Date: Tue, 30 Sep 2014 14:12:58 -0700
Message-ID: <xmqqiok4rew5.fsf@gitster.dls.corp.google.com>
References: <28b04f1c17f2cc2fe252948bc0b7bb10df24b489.1411571629.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Sep 30 23:13:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZ4jL-0002td-U4
	for gcvg-git-2@plane.gmane.org; Tue, 30 Sep 2014 23:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbaI3VND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2014 17:13:03 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57207 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760AbaI3VNB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2014 17:13:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7DE003FB7F;
	Tue, 30 Sep 2014 17:13:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=zLua9BpdHMn/wo7sXfXf2sy1138=; b=RHgKzZkh+TAO1J7sZuAG
	P7Yxqlug1gzxD/8RgJimpdMylRrlT0G5APxh1vkrGsonKgudmtNncXrLkLBNTyT+
	Iy2q3jno79+ioe6NbVI5pXzePke2E7EzjiQqDVUcDp22X6h1vw0i6meMlcE5riZP
	IUL9GQ1+luynN4taBtQ089Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=hmvdMpgYuvcQdjEx1fVJndXb11Ahb/662E4dFHM0uxDo+K
	WOVYBZUxAcZFRB8WxSpIF03jL3HCLHyw4av36h36m8ZIqRgSwMmTYe63GFW9HGAT
	3p0UUWKS63K8AROhKl37mY0Y5atvUK2rQLYD7ox7nYy6gmNXP4eblj+NPvg1s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 700153FB7B;
	Tue, 30 Sep 2014 17:13:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CDC183FB7A;
	Tue, 30 Sep 2014 17:12:59 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8E81F83C-48E6-11E4-8C8A-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257683>

"W. Trevor King" <wking@tremily.us> writes:

> And explain how it interacts with the scissors setting.
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
> The three-dash limit comes from f0658cf2 (restrict the patch
> filtering, 2007-03-12), but I couldn't find any associated
> documentation.  Since the effect is so similar to the scissors line, I
> thought about adding the information to the --scissors entry.  The
> manual separator is really independent from the scissors though, so I
> settled on explaining both separators in the DESCRIPTION.
>
> This patch is against 'maint'.
>
>  Documentation/git-mailinfo.txt | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
> index 164a3c6..6c6c527 100644
> --- a/Documentation/git-mailinfo.txt
> +++ b/Documentation/git-mailinfo.txt
> @@ -21,6 +21,29 @@ written out to the standard output to be used by 'git am'
>  to create a commit.  It is usually not necessary to use this
>  command directly.  See linkgit:git-am[1] instead.
>  
> +The commit message extracted from the e-mail depends on the scissors
> +setting (see '--[no-]scissors' in the OPTIONS section). ...

It encourages a wrong way to look at it to phrase it like this.

The scissors marker is not about commit log message alone, as you
can have in-body headers like From: and Subject: to override them
after the marker, and also in-body headers before the scissors are
ignored (it is not even "We read From: from the part before the
scissors but then let it be overriden with another From: after the
scissors" ).  The right way to look at it is this: "The scissors
line will cause everything before it discarded and Git pretends as
if the body of the message begins after it".

If we are extending the documentation on "---", it should also
mention the caveats, namely, it is encouraged to indent the extra
message by a SP or something to make sure that it is not mistaken as
part of the patch.  I suspect that this omission from this patch
stems from "content after the separator is discarded", which is not
the case.  Content after the separator is fed to "git apply" as a
patch.  "apply" may "discard" non-patch and the end result may be
that the garbage disappears, but that is not the primary reason why
it does not appear in the resulting log message.  If anything, "---"
separates between the log part from patch part.

The second example concentrates too heavily on log message which
makes it a not-very-good addition as-is.

> +Besides the
> +scissors option (which discards content before the scissors), you can
> +also use '---' as a separator (which discards content after the
> +separator).  For example, without scissors you can have a body like
> +this:
> +
> +------------
> +Your commit message.
> +---
> +Comments that aren't part of the commit message.
> +------------
> +
> +With scissors, you can have a body like this:
> +
> +------------
> +Comments that aren't part of the commit message.
> +--->8---
> +Your commit message.
> +---
> +More comments that aren't part of the commit message.
> +------------
> +
>  
>  OPTIONS
>  -------
