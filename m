Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F99C48BE8
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 21:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04EDB61357
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 21:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhFMV0z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 17:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbhFMV0y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 17:26:54 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64575C061574
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 14:24:53 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id l15-20020a05683016cfb02903fca0eacd15so8933184otr.7
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 14:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=T09FZGa3Ya7GkiRfoJ1LEApr5cgGKJiUV4Og+IBEbOY=;
        b=WBO3SSe7RBmyQx4bo8jnkePhR4a8hgMgMcX1g/TcLupFncRm+Fpy+fcxrlfEJ4rNe4
         0RQGvHG9XE2pwBxqhC5AVg1Y5khkcz1L5jO8COpK9zdeyAkJYba2RJJ6tM/umK53Utt1
         DTdLKhK1nCwmdFpIVh2zWfwRsDKsstafYxU4P/cfO32AcrLsBo5Rnf9Ik8qHVSTzJgBz
         q545DDp23SwPWMCi2vQtsNqAIpKHuULGDKVBIQxXUxVv+5rhv0SdV1gG4Bgyniy3Uk3s
         692gDv1M8IXxDsX1+pQngu+5dp21ecr2DklgwfwI2Qh2/rQOJ6DZvoAX2xiNIRpmxYwp
         Uyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=T09FZGa3Ya7GkiRfoJ1LEApr5cgGKJiUV4Og+IBEbOY=;
        b=BsMt7waONPeUf01zEGCQB6e7i0tELRq4JBTrElYqUrM/tvbCGmQQUKHvvSYB1KTpJR
         P8eYxLTyBu3roXPSmUCQeEktscqfE2IQnzkftbgzAnhPI54DINb5bde7hH0XyFK2+n8Q
         9Q8eNcfjYRxtyi/NhFHVNcTlG85fzZQyfFxPSiHe3v+CEiVNl0SK0i8b9eA2rA963M+J
         PzzLKJuC0JJbRplzAAdoflwzaXqoqRu1fsl0191VZII2xLPw7g8imVD15yhjQxtbbdu/
         Y0LLmkpIqKCcnt1/UOTPwsc3eb4XJLxllkzmT13WV9pmmiQWJpSWwtuxInNEXa5vKVlV
         6DJw==
X-Gm-Message-State: AOAM531hL68hqvh/WzvtC/0EdkEbh3djqy6chpBMBGZLTjOSWwHDnQff
        ovm7u8iJBep7CRMzu0IKPjo=
X-Google-Smtp-Source: ABdhPJyS4eCq7G46NqguNE0l1GI1NPfxb/wF8pegA5s5rvTlcV8UOByO3YXIR/OnC7sIRcmOQIAUaA==
X-Received: by 2002:a9d:7453:: with SMTP id p19mr10897913otk.164.1623619492711;
        Sun, 13 Jun 2021 14:24:52 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id s2sm2614772oom.17.2021.06.13.14.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 14:24:52 -0700 (PDT)
Date:   Sun, 13 Jun 2021 16:24:50 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <60c677a2c2d24_f5651208cf@natae.notmuch>
In-Reply-To: <60c647c1d9b5c_41f452089@natae.notmuch>
References: <20210613143155.836591-1-felipe.contreras@gmail.com>
 <YMYnVWSEgxvKRU9j@coredump.intra.peff.net>
 <60c647c1d9b5c_41f452089@natae.notmuch>
Subject: Re: [PATCH] xdiff: implement a zealous diff3
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> Jeff King wrote:
> > Try this:
> > 
> >    commit=a5170794372cf1325710a3419473c91ec4af53bf
> >    for style in merge diff3 zdiff3; do
> >      git reset --hard
> >      git checkout $commit^1
> >      git -c merge.conflictstyle=$style merge $commit^2
> >    done
> > 
> > The first two are fine; the zdiff3 one segfaults within the xmerge.c
> > code.
> 
> I can reproduct the segfault, and here is a simpler way to reproduce it:

I found the problem, m->chg0 was not initialized in xdl_refine_conflicts.

I'm not familiar with the area so I don't know if the following makes
sense, but it fixes the crash:

--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -333,7 +333,7 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
                mmfile_t t1, t2;
                xdfenv_t xe;
                xdchange_t *xscr, *x;
-               int i1 = m->i1, i2 = m->i2;
+               int i0 = m->i0, i1 = m->i1, i2 = m->i2;
 
                /* let's handle just the conflicts */
                if (m->mode)
@@ -384,6 +384,8 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
                        m->next = m2;
                        m = m2;
                        m->mode = 0;
+                       m->i0 = i0;
+                       m->chg0 = 0;
                        m->i1 = xscr->i1 + i1;
                        m->chg1 = xscr->chg1;
                        m->i2 = xscr->i2 + i2;


-- 
Felipe Contreras
