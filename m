From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/subtree: fix linefeeds trimming for cmd_split()
Date: Mon, 04 May 2015 14:14:08 -0700
Message-ID: <xmqqpp6goxjz.fsf@gitster.dls.corp.google.com>
References: <CAMbsUu4aCntGYW4iy+awx2WA89rUcPHZQYQFK0+FRyp9DQB6Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Danny Lin <danny0838@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 04 23:14:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpNgv-0003Me-Pf
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 23:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbbEDVOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 17:14:12 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60604 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751507AbbEDVOL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 17:14:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EF99A4F056;
	Mon,  4 May 2015 17:14:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gRjukzpzx2/tvNmMdJB6w8qCscs=; b=cXYPBI
	uEF6hR2zlpbBi95Qq2/uMpkzGH/8neeuxTDefVWiTPyC7WpoKFhX3+7vS0NJ8Rol
	N7o63qtYZhwB0jQBKk52VMhT4R7qA7bpN1MnUMJYcBrjgZhJp/VaDpNxuSQpJc/2
	vwdjyEjNZ3TIIIARcO4KoZthwY48NXr+x16+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WPwFz5Ew01mYdxT6+e5mfLPfjk13t51o
	JdSS/wl6AorQCsy5O4nvqOBL7XeRmGIEU9L4jfBtao0wB7itpffzpVSSsDG5yh77
	hrsGNgrNItDYpzYST6DvX1BVa5XrtCsnvPchPVpR+IRb5XyQUr0RGTMeLA+v9ukH
	amA6SOlb3/c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E94B34F055;
	Mon,  4 May 2015 17:14:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 651A94F054;
	Mon,  4 May 2015 17:14:10 -0400 (EDT)
In-Reply-To: <CAMbsUu4aCntGYW4iy+awx2WA89rUcPHZQYQFK0+FRyp9DQB6Fw@mail.gmail.com>
	(Danny Lin's message of "Mon, 4 May 2015 14:13:56 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 81CCA70C-F2A2-11E4-B074-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268354>

Danny Lin <danny0838@gmail.com> writes:

> From dc549b6b4ec36f8faf9c6f7bb1e343ef7babd14f Mon Sep 17 00:00:00 2001
> From: Danny Lin <danny0838@gmail.com>
> Date: Mon, 4 May 2015 14:09:38 +0800
> Subject: [PATCH] contrib/subtree: fix linefeeds trimming for cmd_split()

Please do not use multipart/mixed attachments, but instead inline
your patch.  When doing so, please drop all these four lines above.

>
> cmd_split() prints the info message using "say -n", which
> makes no sense and could cause the linefeed be trimmed in
> some cases. This patch fixes the issue.

I think this was written knowing that "say" is merely a thin wrapper
of "echo" (which is a bad manner but happens to be correct) and
assuming that everybody's "echo" understands "-n" (which is not a
good assumption) to implement "progress display" that shows the "N
out of M done" output over and over on the same physical line.

So,... contrary to your "makes no sense" claim, what it tries to do
makes perfect sense to me, even though its execution seems somewhat
poor.

> ---
>  contrib/subtree/git-subtree.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index fa1a583..28a1377 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -599,7 +599,7 @@ cmd_split()
>  	eval "$grl" |
>  	while read rev parents; do
>  		revcount=$(($revcount + 1))
> -		say -n "$revcount/$revmax ($createcount)"
> +		say "$revcount/$revmax ($createcount)"
>  		debug "Processing commit: $rev"
>  		exists=$(cache_get $rev)
>  		if [ -n "$exists" ]; then
