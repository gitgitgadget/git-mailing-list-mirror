Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B1AC43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 02:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240810AbiGOCed (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 22:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiGOCeb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 22:34:31 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391491BEB9
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 19:34:30 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b2so2046354plx.7
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 19:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jZCzMMmsBaRvRqtIafGo+jgscFLGdn8RjpbuAWnQU4Y=;
        b=JogSXnNnJyNXR1CSU6Uud1fyg39giDCEQaKtUhvQqEEfFimlx1wNRspeo8LwSvx2FN
         imUTLcDcOD+sYeQSNXzZmzS7fGizWxOiBCA8lUPRX7v/OkoUlQ1nXhPkt+k8uYkyL3nj
         30LmK/kIkoYJPukWZQ0c+MUbmApnqoDkF5Wk2cfsBrto6bgexdsb8wMei5OV69SZDsO1
         BUVQwS7YWjz2Uc6sBQirapRjj33QxECtMOGOWmZz2sFuJ1l6oRkij64PvjW8yvZl9ylZ
         Wy95qD58JNzR0blyPLt2DoZ5Ar77sGP4A1wFat+sC0dz5byoWWqKk4kG/nx5EMP2Y9I0
         BRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jZCzMMmsBaRvRqtIafGo+jgscFLGdn8RjpbuAWnQU4Y=;
        b=AWOPRXoeIHTi+NTDFEp2Xm6W/qE+qLN3yPtY/fOoQZ6pQnTLte4Ib2dxMGBbDqgrEA
         hmUcxbN8ekLdqwUyMkpkMcB4yrG+E5Zbn5KM7jkGGTnPJLG4QD6YiYQyYMP4a24gBMKV
         ErjY229M/nBeTpjzrJQ3jpQtSDtqLsNZ1IC2XI12vdBiyFL6C4yoGNY6N5LLVMurWHDV
         mSQU+oSOLps98sEBrhPT2/wy0qW7bG+qidNb8taFlAuCJ0wFX8YIq+zcbFTZfY5d5srQ
         x81IHn+ZmX2rtJ3icHrBX7ZcLM5jsHrJ5bl2sjujVbwSVDImgqUcV7ObxupZMor2ZT8U
         WK0g==
X-Gm-Message-State: AJIora+v1oUFZ3gjKgLTVMppQcYv6gRnG+ojeeo4ewEXouLGWEYx9qQd
        Mnim+Ohjx6azHGEnsJZFEaI=
X-Google-Smtp-Source: AGRyM1ueIGVcYmannJNe+NJmCp6vcDDO2yz1DxsD+zvDlU24BUNPpf5p//roCQ4Lwy9b4jOc3EJ0zA==
X-Received: by 2002:a17:90b:38c2:b0:1f0:59c0:55c with SMTP id nn2-20020a17090b38c200b001f059c0055cmr13219734pjb.166.1657852469556;
        Thu, 14 Jul 2022 19:34:29 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.99])
        by smtp.gmail.com with ESMTPSA id l13-20020a170903120d00b0016bedecdd65sm2223299plh.159.2022.07.14.19.34.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jul 2022 19:34:28 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     avarab@gmail.com
Cc:     derrickstolee@github.com, dyroneteng@gmail.com,
        git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v6 5/7] pack-bitmap.c: using error() instead of silently returning -1
Date:   Fri, 15 Jul 2022 10:34:22 +0800
Message-Id: <20220715023422.6257-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.679.gacb6c2f483
In-Reply-To: <220711.86bktv7l5v.gmgdl@evledraar.gmail.com>
References: <220711.86bktv7l5v.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason writes:


> This is a logic error, as fstat() failed, but you're reproting errno()
> after our call to close(), at which point it's anyone's guess what
> "errno" is. It's only meaningful immediately after a system call.
>
> So either:
>
>     error_errno(....);
>     close(fd);
>     return -1;
>
> Or even better:
>
>     error_errno(...)
>     if (close(fd))
>         warning_errno("cannot close() bitmap file");
>     return -1;
>
> Although that last one may be too pedantic.
> ...
> Same issue here.


Yes, this will be fixed in next patch.

Thanks.
