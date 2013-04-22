From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] zlib: fix compilation failures with Sun C Compilaer
Date: Mon, 22 Apr 2013 09:48:16 -0700
Message-ID: <7vfvyipl4f.fsf@alter.siamese.dyndns.org>
References: <97eabaedd6cd7d876812474a35fa2d3d63dfec4a.1366647415.git.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 18:48:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUJui-0005VK-4g
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 18:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942Ab3DVQsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 12:48:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60875 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753642Ab3DVQsT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 12:48:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10DE5184BE;
	Mon, 22 Apr 2013 16:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n/FHxQWMAB8p48ftIwJ6apza3ks=; b=j2InQF
	Iy97IcelIvu3f+s0eXU6ikPai6GLIL1wW4+KcwuCaV8dnDodH6gKEFyaGKvi+7wM
	fshGqOnzQ1qvHxOEAaZnvIwoEfPCfcMoVOCELA7Xp0McqxVdHuNwF7uVEYyA1A/q
	1M58N+8nP5YVG7A6BYwViImhkvOqLN9lM2wew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PIcYjGGzeg0qWuDWlyj9NbkJuZ/S20HR
	5gZeTWj3nuvFCMycMlYJ3TsEgq42A7SAGcwE7h6BRFFF+pUvXvtNXIlZviWFQtBO
	mEVHX/GhX0njkQmBJocrjJCoQl3NOmfbkv2KrKGOLVQnUE7k37GmeewIBJ4+K/ib
	32zczr3xG9U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05607184BC;
	Mon, 22 Apr 2013 16:48:19 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E31D184BA;
	Mon, 22 Apr 2013 16:48:18 +0000 (UTC)
In-Reply-To: <97eabaedd6cd7d876812474a35fa2d3d63dfec4a.1366647415.git.stefano.lattarini@gmail.com>
	(Stefano Lattarini's message of "Mon, 22 Apr 2013 18:18:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6F2D2362-AB6C-11E2-802C-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222038>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> Do this by removing a couple of useless return statements.  Without this
> change, compilation with Sun C Compiler 5.9 (SunOS_i386 Patch 124868-15
> 2010/08/11) fails with the following message:
>
>   "zlib.c", line 192: void function cannot return value
>   "zlib.c", line 201: void function cannot return value
>   cc: acomp failed for zlib.c

Thanks for catching a recent regression in the mainline before any
tagged release is made out of it.  Very much appreciated.

>
> Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
> ---
>  zlib.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/zlib.c b/zlib.c
> index bbaa081..61e6df0 100644
> --- a/zlib.c
> +++ b/zlib.c
> @@ -189,7 +189,7 @@ void git_deflate_init_gzip(git_zstream *strm, int level)
>  	 * Use default 15 bits, +16 is to generate gzip header/trailer
>  	 * instead of the zlib wrapper.
>  	 */
> -	return do_git_deflate_init(strm, level, 15 + 16);
> +	do_git_deflate_init(strm, level, 15 + 16);
>  }
>  
>  void git_deflate_init_raw(git_zstream *strm, int level)
> @@ -198,7 +198,7 @@ void git_deflate_init_raw(git_zstream *strm, int level)
>  	 * Use default 15 bits, negate the value to get raw compressed
>  	 * data without zlib header and trailer.
>  	 */
> -	return do_git_deflate_init(strm, level, -15);
> +	do_git_deflate_init(strm, level, -15);
>  }
>  
>  int git_deflate_abort(git_zstream *strm)
