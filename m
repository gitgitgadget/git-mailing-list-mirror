From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git log doesn't allow %x00 in custom format anymore?
Date: Thu, 07 Oct 2010 19:40:18 +0200
Message-ID: <vpqy6a952bh.fsf@bauges.imag.fr>
References: <D9157D2F-31D5-44EF-8FB4-F0E62BBF8017@jetbrains.com>
	<20101007141015.GB8162@sigill.intra.peff.net>
	<5BA0D807-C5C0-4797-82CD-5D5087496D6F@jetbrains.com>
	<4CADE232.8030801@viscovery.net>
	<FF2FF369-0B1C-457E-A86E-8651BF0A82CB@jetbrains.com>
	<20101007172939.GA12130@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 07 19:40:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3uSL-0006YO-8u
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 19:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581Ab0JGRkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 13:40:31 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41006 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972Ab0JGRka (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 13:40:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o97HQath002855
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 7 Oct 2010 19:26:36 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1P3uS2-0001Sb-D6; Thu, 07 Oct 2010 19:40:18 +0200
In-Reply-To: <20101007172939.GA12130@sigill.intra.peff.net> (Jeff King's message of "Thu\, 7 Oct 2010 13\:29\:39 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 07 Oct 2010 19:26:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o97HQath002855
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1287077197.20871@ZD5sPlrqrdts45krHeZ0dA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158412>

Jeff King <peff@peff.net> writes:

> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index efe9360..3b2dca0 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -147,8 +147,10 @@ static void show_commit(struct commit *commit, void *data)
>  			}
>  		} else {
>  			if (revs->commit_format != CMIT_FMT_USERFORMAT ||
> -			    buf.len)
> -				printf("%s%c", buf.buf, info->hdr_termination);
> +			    buf.len) {
> +				fwrite(buf.buf, 1, buf.len, stdout);
> +				putchar(info->hdr_termination);
> +			}
>  		}
>  		strbuf_release(&buf);
>  	} else {

Sounds like a sane thing to do, yes.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
