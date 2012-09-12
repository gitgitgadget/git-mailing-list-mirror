From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] sha1: update pointer and remaining length after
 subfunction call
Date: Wed, 12 Sep 2012 11:35:56 -0700
Message-ID: <7vhar3ccmr.fsf@alter.siamese.dyndns.org>
References: <cover.1347442430.git.ydroneaud@opteya.com>
 <e6f0051409811fc57385ae712d3256772044bf09.1347442430.git.ydroneaud@opteya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 20:36:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBrnI-0003Y0-R1
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 20:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610Ab2ILSgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 14:36:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58213 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752042Ab2ILSgC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 14:36:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54F269A2A;
	Wed, 12 Sep 2012 14:36:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=51HJ9tOXmIf5Zx8m711MYkej15M=; b=EuRwbz
	K4dwhodgyEO0LcHYbmn05cvdweE5QbGdtOz4x7pPkENny3dVPJ9orMnimx5a99lG
	P+VEt/VYEfEwsajfIon/kPCrpJcyy0DcSXWHgY060OMedIog5ecQLTFaWdHopv7U
	IF9qp8Oi6wxTbRPXncjSIbHVjPVr8+RKP3/ZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eh0fn+A0EJ0gu3XU5Z2vF4QpwW0ZHYqf
	dzLy2fTVBdGPw67BIEvcMwVgEniQGv/wNWxiiihylHSg8RMOM4rWs6gMdi23M14z
	1PxDyQd0nLDgDOJ0UP2rRzd8kQfIMXcTiwWIC/1bzq2lrh1AiMvBF4X8Lav6TKN/
	3TjkO1UCMTg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40D6E9A29;
	Wed, 12 Sep 2012 14:36:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE2719A25; Wed, 12 Sep 2012
 14:35:58 -0400 (EDT)
In-Reply-To: <e6f0051409811fc57385ae712d3256772044bf09.1347442430.git.ydroneaud@opteya.com> (Yann Droneaud's message of "Wed, 12 Sep 2012 12:01:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B23E98A6-FD08-11E1-AB7F-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205321>

Yann Droneaud <ydroneaud@opteya.com> writes:

> There's no need to update the pointer and remaining length before
> leaving or calling the SHA1 sub function.
>
> Additionnaly, the partial block code could be looking more like
> the full block handling branch.
>
> Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
> ---
>  block-sha1/sha1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
> index a8d4bf9..c1af112 100644
> --- a/block-sha1/sha1.c
> +++ b/block-sha1/sha1.c
> @@ -248,11 +248,11 @@ void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
>  			left = len;
>  		memcpy(lenW + (char *)ctx->W, data, left);
>  		lenW = (lenW + left) & 63;
> -		len -= left;
> -		data = ((const char *)data + left);
>  		if (lenW)
>  			return;
>  		blk_SHA1_Block(ctx, ctx->W);
> +		data = ((const char *)data + left);
> +		len -= left;
>  	}
>  	while (len >= 64) {
>  		blk_SHA1_Block(ctx, data);

It is not wrong per-se, but doesn't the compiler optimize it out if
this is worth doing?  Just being curious.
