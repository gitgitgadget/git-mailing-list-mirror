Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DF7C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 16:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4780C613D4
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 16:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhGPQmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 12:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGPQmH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 12:42:07 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFCFC06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 09:39:11 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 42-20020a9d012d0000b02904b98d90c82cso10448266otu.5
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 09:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=rsTnUEjBxqickECGT3n/A6lTQj+U+LHXo9b4PjXlamY=;
        b=NDH6RaLn6VnNfXIcZV3FGH7pzUIAygnkGwMmSOOcQcPnP8GMXd2q9bvCVlHpkRgG+/
         4g+S+bGaaSzIFGmFi24sonaBkom4iLdPEUmjVnM1MiSQFcvDwnvrA63famrDV/rG8kCS
         y3NK+p0BAaz5DQ4PXb7XysCYJKOMV8J7NfXy91emociBxHOcvyYY0GXFe9W/fUdaAlcY
         J3ZFh+Z6v825cRpqo+X04F5j4+8FLGbbc4pPvdZ2tE5MFf722XU6D5H6Uo17j8lWFLmS
         pFUCbbH4LmakUq/NFmMoKIZHkd5AWFu/Nu4PSXA3VMjEDrrhfzBGiByxCl7I7G5YNMN/
         g2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=rsTnUEjBxqickECGT3n/A6lTQj+U+LHXo9b4PjXlamY=;
        b=WlGoCEQEIv5pqvJSZmqbIfowCUww+T+OphWquUFBmAXCAN8yZZoDUyZSpFfyjSzdQK
         czK3nF9zcJmZqfSjXa9kisLCCsveojnGwvt1rMmkbsR/xpt8jQ1+zwNGaljdSPKQ9Z16
         4YsiCjhYIXrudKEPFGDq1UpkZ5wWEmGXCW5rmvi/S/XOUoPyzt+Vf5CcX2k2mujeTZS3
         qJdyqCvQiw5jRgAqUzvTslHsNEUi0ku+itSDp82/KUsAoiS268iL6I2YE6gDNebWnCYr
         863OSXKBBHCNgsNzFuhKK47Y4xhEa3u4JyFNKpTedL5NBf//wE8/ZryoECyeyAEWv71V
         Pvwg==
X-Gm-Message-State: AOAM531Hu3sfMK1y/gY58iC4k43c1Qj6uzeApFB7qWXNpebAV0xb209G
        vS7Gr2FaTvCBml6/yrmR7DZIdy0EpBBpLw==
X-Google-Smtp-Source: ABdhPJyHH7u6cWyVLQYcpcF/2O1InZ7k5yXt3i3F5ZeUPwOsD5QYcZdrNekZHjFJ+WY5n1YbQwrQiA==
X-Received: by 2002:a9d:651a:: with SMTP id i26mr8903747otl.148.1626453550720;
        Fri, 16 Jul 2021 09:39:10 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id 48sm1981754otf.13.2021.07.16.09.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 09:39:10 -0700 (PDT)
Date:   Fri, 16 Jul 2021 11:39:08 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <60f1b62c7531c_ade9208d8@natae.notmuch>
In-Reply-To: <c62933fb-96b2-99f5-7169-372f486f6e39@aixigo.com>
References: <c62933fb-96b2-99f5-7169-372f486f6e39@aixigo.com>
Subject: RE: pull.rebase config vs. --ff-only on command line
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Matthias,

Matthias Baumgarten wrote:
> this is my first time contacting you guys and girls so I hope this mail 
> achieves the expected standard. I've discovered the following behaviour 
> of git:
> 
> If pull.rebase is configured to true and git pull --ff-only is executed 
> it seems like the config wins, i.e. issuing "Successfully rebased and 
> updated refs/heads/...", which is not what I would expect. I always 
> believed that command line options would overwrite configured options.
> 
> Is my assumption that command line options always win wrong or is this a 
> bug?

Yes, your assumption is correct, but the equivalent of that combination
is:

  git pull --rebase --ff-only

But --ff-only is only meant for the merge mode of `git pull`
(git pull --merge), not the rebase mode, so it's ignored. You can see
that from the documentation [1]:

  With --ff-only, resolve the merge as a fast-forward when possible.
  When not possible, refuse to merge and exit with a non-zero status.

Note the *merge* part.

[1] https://git-scm.com/docs/git-pull

-- 
Felipe Contreras
