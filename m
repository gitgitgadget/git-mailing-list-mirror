Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295ECC2BA19
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 01:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 044D420736
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 01:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn8hksLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgDXBEb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 21:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgDXBEa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 21:04:30 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44692C09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 18:04:29 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id y6so3271515pjc.4
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 18:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iEu9ae90KaivJDfYz9hKm2rUt+0n9HGYTQJ7MqvdGj4=;
        b=Mn8hksLIvlXhcb5GHsMFmFAKXvng/9j7b2+bnj8vmLwKyKkiOyAJAPVuQp9pexilws
         oMrif1G7CDSwhAhDqaOIfRe7lR39JvpLE+GkhvCXR02Wgi81eOT+4zqfONhS/EgtsWvO
         kznwau9oBFRcN8E5/45t3WWJ7IhtqSoy45SaCEx7Mck7uYXh9P9Y3GmA3JP5xxKz7rPY
         aVZ7jFcrtMcmFZmY0+uboHfT+8nGu2tlhzLg6wcFEPtSvJ3P/fpGoIfrXlD6F8m78XN7
         2YQaMRS7WPsiOWWeXIBMw+T4nsLFWROKbqbvn93ZurpMc1WIkGdDcHN71tvqGIyS+QaK
         Kf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iEu9ae90KaivJDfYz9hKm2rUt+0n9HGYTQJ7MqvdGj4=;
        b=gqtfzXk10Wa4Qgr3Xwm3Et+hphMmqmHLjuJlhWFl+5j8OvOBtb8yNpCOT9MjoDTEN8
         fp33qV6dqk74LUiRFT2F3q6WOgPJ1JJvBx8Ql19dijsl2dXQ3XXNGoJ3ipp8xqW/Zpf3
         JJCG2XekVgsYWV1KIWQvzn8sxAZfG97Tc58dnLY0zGEb4e/aphysRm/zpk5GP9qukRpo
         9VIkyqaII2NtEOAciGg2g2niHTkik9DlTAs0Aa4qABj8gfz8InPaEWzJrAnzQ2iR6GI2
         T0SVJ2fmaJ72WvQpd0SKLX5nELhZABQFslJ2VQv7oAv/PvQI7ptsMZA4oP99ZVM8eYaE
         zZug==
X-Gm-Message-State: AGi0Pub4IzqmKi2TSFYx1iXs/ATUf16mrmhJP5UOvai6SHDZi7clt8if
        fT3eTi64XukDwM7Uu0JkoKw=
X-Google-Smtp-Source: APiQypIEweRRc/iotM4qi+7oGbWvr7sIOL13oyA75cveqOoNIn9CdRXFmVhQs/XW2INvJrkVt6eweg==
X-Received: by 2002:a17:90a:24e7:: with SMTP id i94mr3677844pje.117.1587690268656;
        Thu, 23 Apr 2020 18:04:28 -0700 (PDT)
Received: from localhost ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id u15sm3394374pjm.47.2020.04.23.18.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 18:04:27 -0700 (PDT)
Date:   Fri, 24 Apr 2020 08:04:25 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 2/4] compat/regex: silence `make sparse` warning
Message-ID: <20200424010425.GE1949@danh.dev>
References: <cover.1587648870.git.congdanhqx@gmail.com>
 <25f595f56f7f895ab31bf7269aabad9142c0590c.1587648870.git.congdanhqx@gmail.com>
 <62642f8c-e885-9fb6-f13b-a9960a2172a5@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62642f8c-e885-9fb6-f13b-a9960a2172a5@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-24 01:51:40+0100, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
> 
> 
> On 23/04/2020 14:47, Đoàn Trần Công Danh wrote:
> > * alloca: somewhere later in the code, we indirectly include alloca.h
> > which will define alloca again, include it prior to define alloca in
> > order to not define it against.
> > 
> > * Copy all attributes from the header to source file, and move the
> >   attributes prior to function name. cgcc is very picky on the position
> >   of attribute.
> 
> This patch is no longer needed (iff you use a bleeding edge version of
> sparse), since this was fixed in commit 172f6a98 ("let function definition inherit prototype attributes", 2019-11-19).
> 
>   $ git describe 172f6a98
>   v0.6.1-37-g172f6a98
>   $ 
> 
> Ah, so this fix is not in any released version of sparse (v0.6.1 is the
> current release - I always build/run the tip of the 'master' branch from
> the sparse git repo).

Correct, when I saw your bleeding edge, I check my sparse version. It
says 0.6.1

> I starred at this warning for years (on cygwin, I don't build with NO_REGEX
> on Linux), but I didn't send a patch for it because it was a sparse fault.

It's sparse' fault, of course, I talked about its pickiness in the
commit message after all.

But, we still need the alloca part of this patch.

-- 
Danh
