Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42A5C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8301C61177
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbhEFPVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 11:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbhEFPU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 11:20:58 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD33C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 08:19:59 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id v191so5355431pfc.8
        for <git@vger.kernel.org>; Thu, 06 May 2021 08:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xUXB01sZolPtZJPEJXgddeYrFjTZu86sKY6ToogUlqE=;
        b=OXgbjGxVaW0Ghd4jA6PAP+ClIdCx9niGFmmecUp7WjGJDcm4pcFwRa9rkGFl6t0PTM
         iGNDZ+XVqe5VgiaVMkvT2kJweDjbqE7CtcPfl278roywLa+nXPH51CsQOl+lIKgJI3qk
         DB/o+Gr3hCfcRjIKNPR2RdXqPLKFj8S2bK0mdN2MOwGwZpAYKhBOFMWB06pyYaPTlFWH
         Hc6VKm/97rdYPVrRVnQ3Ry/jE5TZXcPO5w8bwt4NGGI2GvjDoRLjpkmys1MRCpkbcIzD
         q8UdQbmNpy6KFbUsOh1mdfG6ZuO69fphHxWCXmgSP4GRdtVRiKBydwPtK1BPgogoyXgh
         ojcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xUXB01sZolPtZJPEJXgddeYrFjTZu86sKY6ToogUlqE=;
        b=dpRpn+KfhQsIe7S/h47y4YzfG4Z+ES4WoytnVHc97F9ofSfu6z1hgyCFF6fTSsf1Tq
         eDPAd4G8eCLfGIAxtDtOz6xzFVXnM9Hqaz6kMeARW1h0sjAJXa8M/iW2oaznNtU9H3fB
         jy77qlKX69/cyzh0g2FHicZfey2ubjMimSymHNP6oXS/PHv7IHxdCMbIFDC54Mma3kki
         v/sEEtyCT+TflzA1vJok1psLeIBntr49XpjeRKxxpJc3SjUcsb8735MdV4R0BeBN8+B2
         glxbVVQfI40I5u5KPl6UaQ4Zoz3wM7Hm4m4Zoeg+X+1WgrV0VLMWINXk0rX4Dqlqo+d/
         vXAA==
X-Gm-Message-State: AOAM531j5TDfp7ExKK28kx+Isp3adIWI9gfh+lOxv5eryRr9ODKNav+4
        EMfQXZt7sbZp3GdTVkXZhgTmoGPgRxwvYg==
X-Google-Smtp-Source: ABdhPJwUUls/g2KgDZll/TI4zkkqtHxu9z078qknvn1UCX1QAcdKbGuzB0+nlXQ7jBMlYe0lVZ+3pA==
X-Received: by 2002:aa7:8201:0:b029:27b:9b59:8676 with SMTP id k1-20020aa782010000b029027b9b598676mr5230754pfi.47.1620314398601;
        Thu, 06 May 2021 08:19:58 -0700 (PDT)
Received: from localhost ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id l10sm2167790pjy.42.2021.05.06.08.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 08:19:58 -0700 (PDT)
Date:   Thu, 6 May 2021 22:19:56 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 2/6] mailinfo: stop parse options manually
Message-ID: <YJQJHK04CSv17Jtw@danh.dev>
References: <20210421013404.17383-1-congdanhqx@gmail.com>
 <cover.1620309355.git.congdanhqx@gmail.com>
 <ba8ac434189ce91314562d93004b2d2b37fe6868.1620309355.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba8ac434189ce91314562d93004b2d2b37fe6868.1620309355.git.congdanhqx@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-06 22:02:19+0700, Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> In a later change, mailinfo will learn more options, let's switch to our
> robust parse_options framework before that step.

Please ignore this email. The correct patch is down-thread with
 subject:

* [PATCH v3 2/6] mailinfo: stop parsing options manually

-- 
Danh
