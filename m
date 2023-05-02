Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377ADC77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 18:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjEBS5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 14:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBS5H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 14:57:07 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222D2E73
        for <git@vger.kernel.org>; Tue,  2 May 2023 11:57:05 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6a606135408so3859759a34.0
        for <git@vger.kernel.org>; Tue, 02 May 2023 11:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683053825; x=1685645825;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jimW3Tx7VSGj35+fbrSOPFezqdP9ycsjoCgI6norlXA=;
        b=XleAn4zLAn15h7z4LISGzLGSr1D8e/94/npb6BUgxa9SyEXeRQWQ66ZJMBzB7JZ3W1
         P4C53BwVSIdfCRti0JB/a3kSvFxNddIit1cIrM0+iW7pZlWDGb7zCdR4gvTctGEGR2ro
         Ep1b7zseA/CvRFEOnBPDrXOhr5N1oJ63E8a2uO+v1blgTaekvXTpPyYBoFNzorMX054y
         WDglla3oxXsZ0/4thBeanWT7Ca/c609d+vjG5djMQRROKdSmOO4HiQ6DUFWL9AsT9E2h
         GQWrdzkBKGN8EZWol/TwUU2dqm8IethQPdYXx+w7merJcken0EY8eTJFne+33WMSg0cR
         obzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683053825; x=1685645825;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jimW3Tx7VSGj35+fbrSOPFezqdP9ycsjoCgI6norlXA=;
        b=cK6exh8MyMORWy2yTd1GEw/wbpAQZIi2RCEZksDUtYV3ptsmsfCwnhfhQ4kaVE8/z8
         gNGKT47s5Q00iCrownP/3sIV+P2jM/LZkkV9gT4xq+JN4uC/1t80LnhSjZcBmSeOE8Br
         XqU/EZHGb84pujQ17w8dFihOGD82nVTIV33u3B9Wakn6JzctWK4B/xTmEuKmk+zKkaPO
         skIfRRvhwxHAWXJEVewyNAu+ZHh8QX51/8F1rbtT7T5zNJBQQjetWo5Ty2lHpgt61KZX
         ddHZPZKuSLevniexi1WbViU9F0lU0g666Ubh/cm6B+47CTl6C5mtmy5xUQjTpwpcqfFE
         ZmbA==
X-Gm-Message-State: AC+VfDxVXT6XKCXLu7yI4A+QlyTzd0MaPmNdx7Bou3IxDGrsMimu33Es
        dBQegdrtvwYbpJPKBkJ1UUY=
X-Google-Smtp-Source: ACHHUZ6n+bmV7Ha/VfFEjmee+d/mWsHt+c8iGArgqVXRfQsq1OwRh9F3LdRB5P4Q5Xv2Yk1taOugEg==
X-Received: by 2002:a05:6830:2:b0:6a6:5e17:73db with SMTP id c2-20020a056830000200b006a65e1773dbmr9604049otp.8.1683053824977;
        Tue, 02 May 2023 11:57:04 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id n17-20020a9d6f11000000b006a5d7d7f6c3sm13059698otq.7.2023.05.02.11.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 11:57:04 -0700 (PDT)
Date:   Tue, 02 May 2023 12:57:03 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren <newren@gmail.com>
Message-ID: <64515cff45e03_1ba2d29458@chronos.notmuch>
In-Reply-To: <ZEr4VKMPSYZZxgIM@ugly>
References: <20230323162234.995514-1-oswald.buddenhagen@gmx.de>
 <ZEorMhPZRL/w4yKM@ugly>
 <xmqqmt2thvuu.fsf@gitster.g>
 <ZEr4VKMPSYZZxgIM@ugly>
Subject: Re: [PATCH] sequencer: rectify empty hint in call of
 require_clean_work_tree()
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen wrote:
> if i wanted to be super-pedantic about it, i'd assert that non-null 
> strings are non-empty.

I would disagree. "" is empty but not null, not just in C but in many
other languages, including shell.

-- 
Felipe Contreras
