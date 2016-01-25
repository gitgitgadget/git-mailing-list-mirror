From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v7 01/11] dir: free untracked cache when removing it
Date: Mon, 25 Jan 2016 11:16:47 -0800
Message-ID: <CAGZ79kYoQFWQCxpGxze=v36PTrC7+EgVOwtfm0kgE_kQoekq1g@mail.gmail.com>
References: <1453649304-18121-1-git-send-email-chriscool@tuxfamily.org>
	<1453649304-18121-2-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 20:16:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNmdG-0001xT-1P
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 20:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758138AbcAYTQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 14:16:52 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:34177 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758129AbcAYTQs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 14:16:48 -0500
Received: by mail-ig0-f169.google.com with SMTP id ik10so41362555igb.1
        for <git@vger.kernel.org>; Mon, 25 Jan 2016 11:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jhZV7WS00qeUh+A8KxOkJj0KkGWsl+XLbDKH2hDbj3E=;
        b=nxu1O6csGIwIdchvH51JhBWMjVs3v18W9hPu9UvH9HyAN9Xb5m2fdf01qoRDC2GAHg
         NRAlym6abQWv8jRYW8B1RvPA7bjJRpqb7ldZEi6HBEPYTbYiQG81vKYVUvsIuRI8Ds9G
         7C75FqZ4clWy36xaP7CLSQ9kN4kBhPyfFR3rwSfn99aLwew9xY73uy/Tanp60exA2rJ1
         T/WBROy5TmFEvXAIWBq5qhuKtMdGUPZYTCWvNgScUapkP2Yh/boezyIG9tPKxBrJFrYD
         9T00m09K+MIwKQ6Ba6LnDhTAoK5VgIgVvMSZE+gVFXijXVu5ZVWm8Is2J3XatXmDtUtf
         ZETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=jhZV7WS00qeUh+A8KxOkJj0KkGWsl+XLbDKH2hDbj3E=;
        b=HDJ2CuMm2qVCWakkqtn4fphaUnib/v+70fN/uQWi973awBihYBp4J+08oquzuLYhgp
         5GjNdea6nm2OKqieljgp+bATj/x+PAMTT55EfSOws5jzCk6A+t4rjSQIrezKx/0W7dhW
         EOT25ws1QXs/SyYowUj9JuDtZ3ICmPXE6/iXrj8ZB4b3ePLq7ke9MI0YGxt6sm2v7ypY
         eRSLYnKLl2DuMUaqTFaLuUHxDMl/Oc2+EbEPNsqsiOjve/wSXKtqcSS8TCWG7hWCPXVd
         ZhuMSXCAWW+tfTkS91Mc17lu8Bmr2pYBFiygsHZf6gfqe4g6U9TV8Wi++iFXl18LSN1b
         1C7Q==
X-Gm-Message-State: AG10YOROipYY/MgR4AAa8CDESzKMA/siP9f39qM7c+s3MK8no7BmO31ISFHQKQmQZ/jWioO4ZYH7xJCpXnoLqPiS
X-Received: by 10.50.88.74 with SMTP id be10mr17348811igb.93.1453749407559;
 Mon, 25 Jan 2016 11:16:47 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Mon, 25 Jan 2016 11:16:47 -0800 (PST)
In-Reply-To: <1453649304-18121-2-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284749>

On Sun, Jan 24, 2016 at 7:28 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/update-index.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 7431938..a6fff87 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -1123,6 +1123,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>                 add_untracked_ident(the_index.untracked);
>                 the_index.cache_changed |= UNTRACKED_CHANGED;
>         } else if (!untracked_cache && the_index.untracked) {
> +               free_untracked_cache(the_index.untracked);

Do we need to free its members, too? (Or is it empty enough here,
that there are no memleaks in there? If this were the case a hint in
the commit message would be helpful)

>                 the_index.untracked = NULL;
>                 the_index.cache_changed |= UNTRACKED_CHANGED;
>         }
> --
> 2.7.0.181.gd7ef666.dirty
>
