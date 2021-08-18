Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB92C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 12:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5451E6108B
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 12:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbhHRMxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 08:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbhHRMxK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 08:53:10 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55205C061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 05:52:36 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g14so2029587pfm.1
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 05:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Dm1QTVq62LPZwPPP0+i+ibWnCZH9j8fQONgYEO7jpyI=;
        b=eRuuhLhO6xEIRt1WO5BBmSpYdzqjiWuKuMlWqEZCNMAuB2mAoLU0Sb3EKeMBClb8SB
         LwLgk30trjMlHMH1ZPtA1HMtPGrIIkpe5Siqo+PJ7S/laGjL6Klfjp0dF1okZAZaGk4T
         pNPIApJeUoqEZxr0jzHLp7iyr83qjkXJAzPTPwasZQNXs8M17ufyEfaGt2vMU2VyHXBH
         Ryl9OH7Y3tHefGVhSYOqVfCbu4BxrUsOCyZWtIRgJ5Vx2ufXPU/kv7zJNNxKjKHeqY+e
         XRH4BLXdhTsKKpwtbIgdbD0pl6CQFgUdSmasVBklrmNk/fbWpQuWI+v/3dXu5pvA3CC2
         wiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Dm1QTVq62LPZwPPP0+i+ibWnCZH9j8fQONgYEO7jpyI=;
        b=T+2oWRUHmo98uVOWebAtWZK3aYhKYmYOi26xnBMWSngYhbVQMbtId6hUGSoIiPclpO
         WzueS17y7qPYbsmKyMPbzUJmclQLZ4aHBNXz8Pn8BaKhyyzUIulGntUg1YkdLMAcUprh
         LrtqSX60tbCJCHQUmh+44b+LhlJA2FcntCJmZ117b9L6txzO+Bea4dOf8c3XBkX/3CHG
         ByawUFJNuf1SF6ze+48GVo+yZYrGqvX1jMFa+f1CBgQGPn+8hisTSXI2BXlH1VMPEaye
         7AR4ohmALaDBW7rrPDJawZgigsAijr7izxZvCySp+6E0HnwY3HXvTEp8EfiCvsJwN9oA
         JoMQ==
X-Gm-Message-State: AOAM533q8i//9kn1/Oh+tAGEfI9mEuaB/n7kgLW61aMYnPe/OHJzljzm
        nuQ9G/kupCRPqomMJVDHyMWmJrePrIw=
X-Google-Smtp-Source: ABdhPJykjfDL9ryrsO+zsSZWwaEbpEdWUo6eSwG8eTR6DEf4aQA1zw5o7WUf7vlcDWTVqYWDqAE6ag==
X-Received: by 2002:a63:1962:: with SMTP id 34mr8965479pgz.14.1629291155863;
        Wed, 18 Aug 2021 05:52:35 -0700 (PDT)
Received: from localhost ([2402:800:63ed:4478:964c:2b9b:388e:4b0])
        by smtp.gmail.com with ESMTPSA id f11sm5799333pfc.23.2021.08.18.05.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 05:52:35 -0700 (PDT)
Date:   Wed, 18 Aug 2021 19:52:33 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Thomas De Zeeuw <thomas@slight.dev>
Cc:     git@vger.kernel.org
Subject: Re: Bug: Segmentation fault in git diff
Message-ID: <YR0CkdVNVKa65vbo@danh.dev>
References: <40BE2EF2-0AF3-45BA-9880-8A6011B38D03@slight.dev>
 <YRzkq47gOGfn8zsw@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YRzkq47gOGfn8zsw@danh.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-08-18 17:44:59+0700, Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> On 2021-08-18 10:42:45+0200, Thomas De Zeeuw <thomas@slight.dev> wrote:
> > Hello,
> > 
> > This is my first bug report to Git mailing list so let me know if more information is needed.
> > 
> > Running the following command results in a segmentation fault on macOS arm64
> > $ git diff --name-only --diff-filter=U —relative
> > Segmentation fault: 11
> 
> MVCE:
> 
> ---- 8< ---
> #!/bin/sh
> 
> rm -rf /tmp/diff-bug
> git init /tmp/diff-bug
> cd /tmp/diff-bug
> mkdir -p dir
> 
> printf '%s\n' one two three >file
> printf '%s\n' inner >dir/file
> git add file dir/file
> git commit -m first
> 
> git branch side
> 
> printf '%s\n' one two >file
> git add file
> git commit -m checkpoint
> git tag checkpoint
> 
> git switch side
> printf '%s\n' two two four >file
> git add file
> git commit -m side
> 
> cd dir
> git rebase checkpoint
> 
> git diff --name-only --relative
> ---- >8 -----
> 
> It's NULL pointer dereference bug because pair is NULL.
> I haven't check further:
> 
> ---- 8< -----
> #0  run_diff_files (revs=revs@entry=0x7ffcc85ae270, option=option@entry=0)
>     at diff-lib.c:196
> 196                                     pair->two->mode = wt_mode;
> ----- >8 -----

This diff could fix the issue, and the test suite still passes:

---- 8< ----

diff --git a/diff-lib.c b/diff-lib.c
index f9eadc4fc1..8f303958dd 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -192,7 +192,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			 * from the desired stage.
 			 */
 			pair = diff_unmerge(&revs->diffopt, ce->name);
-			if (wt_mode)
+			if (pair && wt_mode)
 				pair->two->mode = wt_mode;
 			if (ce_stage(ce) != diff_unmerged_stage)
 				continue;
---- >8 -----

-- 
Danh
