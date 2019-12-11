Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98707C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 19:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6593020836
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 19:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BK+fLk04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfLKTBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:01:51 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41401 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfLKTBu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 14:01:50 -0500
Received: by mail-qk1-f195.google.com with SMTP id l124so8640629qkf.8
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 11:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=87rh84+Ptc6dAKg1ZnXGjYUkTRSpHsHIqRk0CMBx2f8=;
        b=BK+fLk046F8RlY0BCBgPbJ27HPxutrBt2C1KzCUpJUJY8jWnnOLBAKr8MhWIQBOHx2
         CzIj9NmjC5uTfIKm5WC24Y1Y2BCtlVJYFTgFCEuRRtPlwjg1fYqU3jm2aLovJUGa3TT7
         dFlDJH1TD+T4z41yVCgNDC2Q9t4D3eFgYWSFbPg1i+7dAXa0hECMX30e7s0d7hCBo5dJ
         GuxMLJfM/k9KwT7bFQq68Gcdd4FCpHxrNlVPzyuY3M809hQ84qrAQIiPagaiLt5UCu+D
         rgbCauFjTYFbbDsGR1PMdA4udSPfDGUS8Xg2yvPvH3900JzVIn5TR306byhCFnqwnX2+
         bmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=87rh84+Ptc6dAKg1ZnXGjYUkTRSpHsHIqRk0CMBx2f8=;
        b=ej6vQ6vpTHlCDt9GPC35fSrGCSSzrruR+EeGzhPrMWMUKRPYOYYmCVWQctXlHzk457
         CKMVRGbDOCGk2qAtKfyBDuzqQ277UMFhIlrN4Umy/tEY6lJHDCf8OeEVyCrX25mo20ZM
         aANQSPWezwwBuzvIGa/AVqwmQDDqy14hc791fDgcwBiQvhQBhbdA7lhpxymgddsMdZWQ
         QRCtTM+8K5k48h8/PEH9vqLyAP7QKMD/g6oTyIv5/Rd/kaSla0SIT1Zq5TM1jFF6t/qI
         IDzDA3XYi2CSv4iJVhDp9xL0+Q++uI2lLY1cPBl9OlWiayizDwsdQunc6nHuq2ecAzPG
         fnew==
X-Gm-Message-State: APjAAAW9FoZB6yGdMNrKuOkw2ot8qoKjxzZuDl9vjF7lcz+a3Gj2030x
        WOItXRR7kWz8wUVEYlj446k=
X-Google-Smtp-Source: APXvYqzDPWszEWUKsaWh5kAowrRKZkeDI8nyMntOz6j7Zg+qj87WE4DQJn+qbgk3P94m8VE1/Cd06w==
X-Received: by 2002:a05:620a:796:: with SMTP id 22mr4325004qka.419.1576090909880;
        Wed, 11 Dec 2019 11:01:49 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:3126:c1d8:6135:a84d? ([2001:4898:a800:1012:e259:c1d8:6135:a84d])
        by smtp.gmail.com with ESMTPSA id 16sm950055qkj.77.2019.12.11.11.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 11:01:49 -0800 (PST)
Subject: Re: [PATCH] refs: pass NULL to refs_read_ref_full() because object ID
 is not needed
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <a762958e-324b-f9a5-96e4-fab0b4b91df8@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3f39d0f8-adfb-5f25-a724-f37f26904fa6@gmail.com>
Date:   Wed, 11 Dec 2019 14:01:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <a762958e-324b-f9a5-96e4-fab0b4b91df8@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/11/2019 1:46 PM, René Scharfe wrote:
> refs_read_ref_full() wraps refs_resolve_ref_unsafe(), which handles a
> NULL oid pointer of callers not interested in the resolved object ID.
> Pass NULL from files_copy_or_rename_ref() to clarify that it is one
> such caller.

I suppose this could have been grouped/threaded with the other
similar patch, but still correct. Thanks!

-Stolee
