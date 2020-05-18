Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB87C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 14:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E94AA207D8
	for <git@archiver.kernel.org>; Mon, 18 May 2020 14:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbZZlkJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgERONP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 10:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgERONO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 10:13:14 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE40C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 07:13:13 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m7so4272115plt.5
        for <git@vger.kernel.org>; Mon, 18 May 2020 07:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ciIfOZqTThYltbNMXzTuRzR9iv7Dlzdh54ZiR0QPGgM=;
        b=nbZZlkJYhXTtKNBZESfQpWjQ4u3ax0yaBJq+oKF81JCEf914wG4DmpsooWuaUdc3LV
         s2WHh6gOiwS2uYBSaylbV7QutUuz4KHW1cEldgzNzmxn1ZHYnltAUkBQQUz69j3z5owT
         Hjr0oD+cbt+o3gKUpewInVB/WMygTpiCaLUeChS3VBoHG44F7+653sj7BsBLESvaz42S
         w+/q4IBp0jMkx3yo2ZvD2Ik17D7VmFIHHRzFnYJYUViNH5oTnXpELbJjuRmlwUA4jOS9
         /AEMnXjgBPNG310M0Dhh53S1/CBwez0e28CKSdxkMW1W3wesazSnkveQoY9ZrInM9IOx
         zBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ciIfOZqTThYltbNMXzTuRzR9iv7Dlzdh54ZiR0QPGgM=;
        b=YKGYysVWrbZN9YLCceHRsfRXYcv5Y3XSkUpEwH7NKaWcocRWW77QyW+uGD9WfaQWPy
         XVnuPTjqP+m7ZUHNmw+debPuEDntkgtbK6x4HHmOsZ+4adASPXSHRx5qdqda38EhqbZl
         dCgfBFq+O62FaqH/epZy9jnIdKpnHhUrnRCXpjOJ1Qss65+dCqAwXQaTGSuYbL9ec4Kg
         +gtuFqQrUV9AjXGpqqB0eaAwkwkQZKdkjl0j3+ci+wXYi+AmqDGlz2yZo2h7dtbRysGK
         gVFmDOLU88oBwRj5oIigLQMjFi8Abp4ZewYZ2Wpdg2bkgkiOaSQyZKQrT4LEggkt4OGc
         IIog==
X-Gm-Message-State: AOAM532v6Kh536uEKrstiDleE5np/XCoNGuhJUG1IwDRPjJ5D0kMToZk
        +ARVoahVVvvuq6XyV7iBg/8N1uTQ
X-Google-Smtp-Source: ABdhPJySOv7oJMU7A96X1cK615gHAuM7lI7KuuhSHjS1HkTDw42kKZjhjv5eMTdSoXAf+Yt7PKqfxA==
X-Received: by 2002:a17:90b:3444:: with SMTP id lj4mr19429294pjb.37.1589811193375;
        Mon, 18 May 2020 07:13:13 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id 28sm8857767pjh.43.2020.05.18.07.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 07:13:12 -0700 (PDT)
Date:   Mon, 18 May 2020 21:13:11 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Darren Tucker <dtucker@dtucker.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/7] Redirect grep's stderr top null too.
Message-ID: <20200518141311.GC1980@danh.dev>
References: <20200518100356.29292-1-dtucker@dtucker.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518100356.29292-1-dtucker@dtucker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Darren,

On 2020-05-18 20:03:50+1000, Darren Tucker <dtucker@dtucker.net> wrote:
> Prevents pollution of configure output on platforms that don't have
> grep -a.

From your other's patch, I think you're in HP-UX,
would you mind also run the test.

Since t5703 also uses "grep -a"

> 
> Signed-off-by: Darren Tucker <dtucker@dtucker.net>
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 66aedb9288..4effc82b76 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -526,7 +526,7 @@ if test -n "$ASCIIDOC"; then
>  	esac
>  fi
>  
> -if grep -a ascii configure.ac >/dev/null; then
> +if grep -a ascii configure.ac >/dev/null 2>&1; then
>    AC_MSG_RESULT([Using 'grep -a' for sane_grep])
>    SANE_TEXT_GREP=-a
>  else
> -- 
> 2.21.3
> 

-- 
Danh
