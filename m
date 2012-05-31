From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/6] reflog: remove i18n legos in pruning message
Date: Thu, 31 May 2012 08:45:38 -0500
Message-ID: <20120531134538.GA10523@burratino>
References: <1338463242-10618-1-git-send-email-worldhello.net@gmail.com>
 <1338469482-30936-1-git-send-email-pclouds@gmail.com>
 <1338469482-30936-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 15:46:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa5hN-0004kn-SC
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 15:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758041Ab2EaNpy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 09:45:54 -0400
Received: from mail-gh0-f180.google.com ([209.85.160.180]:62583 "EHLO
	mail-gh0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757948Ab2EaNpx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 09:45:53 -0400
Received: by ghbz12 with SMTP id z12so926308ghb.11
        for <git@vger.kernel.org>; Thu, 31 May 2012 06:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OIwE77/HcBRl1iUsC5psKkQkoHgIAV3kkH0gYZrfCZs=;
        b=Ri8FHKVwIbeUW7wzSk7AFl4+IadZPOiuewM7BAz2as29Toylw6S68Utyb6MvtpDgBO
         wmgrZ2vMFQvJ0iZVzVts+uJV60h8iNwQ7UG+4TzEiO8ih7JKOpxGv9mtPdXeXNC4vXkr
         Yu11Xp0PivA5fqLOPb/l84ysC6/z3R7pw68xiZYgI/8WQSRKEDH9KnnHBNEjFM9Dhb0D
         oucZwvR5B0wpQVQu2aiQRr3ZoHW1YHmBXcpGTa6q4yr02/Bb1sOiJiWALTDhkOZ1tH8Y
         dot6Z1Hq66i1GEmNofleMDubE0rpI4sNTLcdHG9+ULbwesAjiA7doq90yQK/KL0FgWby
         jcrw==
Received: by 10.60.3.40 with SMTP id 8mr19287099oez.31.1338471952334;
        Thu, 31 May 2012 06:45:52 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id lo6sm2413754obb.0.2012.05.31.06.45.49
        (version=SSLv3 cipher=OTHER);
        Thu, 31 May 2012 06:45:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1338469482-30936-3-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198899>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -330,8 +330,12 @@ static int expire_reflog_ent(unsigned char *osha=
1, unsigned char *nsha1,
>  		printf("keep %s", message);
>  	return 0;
>   prune:
> -	if (!cb->newlog || cb->cmd->verbose)
> -		printf("%sprune %s", cb->newlog ? "" : "would ", message);
> +	if (!cb->newlog || cb->cmd->verbose) {
> +		if (cb->newlog)
> +			printf("prune %s", message);
> +		else
> +			printf("would prune %s", message);
> +	}

Thanks.  Style: how about

	if (!cb->newlog)
		printf("would prune %s", message);
	else if (cb->cmd->verbose)
		printf("prune %s", message);

?  I think that would be more readable than the lego original.

BTW I'm not sure if this message would be a good candidate for
translation.  Especially in the --dry-run case, it feels like output
that is intended to be simple enough for scripts to parse.  (Though on
the other hand, I don't know of any scripts or use cases that actually
parse it, so maybe nobody would mind.)
