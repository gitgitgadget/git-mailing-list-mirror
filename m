Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4E7C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 19:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243448AbiAFTuN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 14:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243475AbiAFTuM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 14:50:12 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8C7C061201
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 11:50:11 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id bp39so3365545qtb.6
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 11:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bUUwA0sfxARyJ4Xzk5WjUoBTptlAsjNBJBv6h+sLA0s=;
        b=8Rpxhc8MZbFhjz6/jZzkgyT3Qsa7MmTkJVmqiW/DRc/7bgxUEcLnESFxS3vHZBP2sC
         4IK/bEwTJIp3BO3aqgsSsukJcPbqcztf4d5d09fL0fiOPC6lgOnQ0T9U3bY8h4m3O/C0
         jkfPcbtG1ueP+dHDOjELYKDynP/6fdBK8UMF3JkJ/FtiRA8v9hVdvOr0hZqmZsoN5b23
         KUb10xEyJhH7d5NmIceGHnqM/zje2JQfCmoFltSd37TGgnhZQrAJlm8jSkjehrq1waE/
         o5g3h92/a9/8r2wdDQixoxELiuSCp+FAUPh6W1XpavYNIydVQ76qKuwwZvcunKZke7MP
         D7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bUUwA0sfxARyJ4Xzk5WjUoBTptlAsjNBJBv6h+sLA0s=;
        b=AR+OSQCcohuCz7IkWkel1AtWMRAW739O/ExzLicFvRhYNSJyayGraCWOCygMV47O4i
         suS51ZKuJvWECuWUxRG6hYrJLVYpCAFyPSkV+NGvN5WxVcqYfwop1l9govsihkczlqcL
         LF3L+B9JUecMDuyYNZINZxLzVxYPXMMWtWlQ4LG8oXuPGGLXNsV5YBKJUyUxq99IL/sy
         A7e0L8hK4cWB/0R3skdgjoo62nF7BYpVFnhQ8Ckj7nvox3J/+fu5ZNWWzgz129jGpzes
         wy+LXWgXSRHg202FlgrRCTFoCjLevlRFrDr0lZjMc2b1yHuzfZgcNd1cDgAjn9FZ4Dx1
         ioeg==
X-Gm-Message-State: AOAM531vYC9RZDESy3hjtsTem7jRSVWalsxN/V6tGRQ7pJ1czKhG70Yj
        DSpmgeWdq+qaAwC4qHGrxdNAozUBc1GZng==
X-Google-Smtp-Source: ABdhPJw5h7ca5VaeJSa4Nid9CvQpvMYHEZRr3ex0tGVoaeq+pJV7s+QqpaSFhMbKlo4U26pJy9i/JQ==
X-Received: by 2002:ac8:7c50:: with SMTP id o16mr5348352qtv.258.1641498610828;
        Thu, 06 Jan 2022 11:50:10 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j9sm2033305qkp.111.2022.01.06.11.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 11:50:10 -0800 (PST)
Date:   Thu, 6 Jan 2022 14:50:09 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     l.s.r@web.de, gitster@pobox.com
Subject: [PATCH 0/2] grep: introduce and use grep_and_expr()
Message-ID: <cover.1641498525.git.me@ttaylorr.com>
References: <ea01f9b6-2ce3-57e8-533f-4cc29937f700@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea01f9b6-2ce3-57e8-533f-4cc29937f700@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René,

Here are a couple of extra patches on top of your series which introduce
and use a new grep_and_expr() function.

Like the final patch says, this isn't about reducing code duplication,
but rather about adding visual consistency with the other
`compile_pattern_xyz()` functions.

Taylor Blau (2):
  grep: extract grep_binexp() from grep_or_expr()
  grep: use grep_and_expr() in compile_pattern_and()

 grep.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

--
2.34.1.455.gd6eb6fd089
