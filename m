From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] merge: release strbuf after use in suggest_conflicts()
Date: Tue, 23 Dec 2014 18:11:55 -0800
Message-ID: <20141224021155.GD29365@google.com>
References: <549A065E.8060008@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Dec 24 03:12:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3bQh-0005Ce-8F
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 03:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbaLXCL7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Dec 2014 21:11:59 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:52577 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbaLXCL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 21:11:58 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so7014284ier.0
        for <git@vger.kernel.org>; Tue, 23 Dec 2014 18:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=q2QVbBucR3ymitqGZuUkGR+mvJh3yyprEOiiTs0gOJY=;
        b=gLgiwcmnDSZGMoyRI9B2Pf2pL24jO9LY0+R+xk4sG5QhzcQ3g6n7J8TkyUecehsG/L
         ivMk4DxNRHWlBrTK4/EGU0e8zG5GOh46/eiy7Z6skTh9Qb9nYHkE5+TAzvpa6UHmTYBP
         wnAo3y/zwgQpXV0rCqs03ecyOdxf/xgUXypG6VHDhh0Sulg81pOc4cggzd9fvlQXIxVE
         WP2FlAdGwezgi78X9TLITBGGga+y4vVLoX9qwDRClshfy7BxD8PclU2gg4SG/iIW5lJp
         gLLsopEdr69UanJiErbG18+9HpNyIWjB/hmAzL4bxPVOjaGPYyXkaQ16zz45/Eg5yDaf
         NH+g==
X-Received: by 10.50.176.129 with SMTP id ci1mr23168116igc.40.1419387117958;
        Tue, 23 Dec 2014 18:11:57 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:f575:2fb0:789a:eca0])
        by mx.google.com with ESMTPSA id u31sm6727821ioi.33.2014.12.23.18.11.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Dec 2014 18:11:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <549A065E.8060008@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261790>

Ren=E9 Scharfe wrote:

> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  builtin/merge.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 215d485..d722889 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -894,6 +894,7 @@ static int suggest_conflicts(void)
> =20
>  	append_conflicts_hint(&msgbuf);
>  	fputs(msgbuf.buf, fp);
> +	strbuf_release(&msgbuf);
>  	fclose(fp);
>  	rerere(allow_rerere_auto);
>  	printf(_("Automatic merge failed; "

The caller is about to exit so this is a small one-time leak, but
freeing it doesn't cost much and makes analysis by valgrind
a little easier.  So this seems like a good change.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
