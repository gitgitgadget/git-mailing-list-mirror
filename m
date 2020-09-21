Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BA0C4346E
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 18:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E4722262
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 18:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g55EkgEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgIUSV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 14:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgIUSV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 14:21:29 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238F1C061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 11:21:29 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m13so8742427otl.9
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UbgAcOLv9s1RlpGMrvoDyf2lbPXO/dPqgzNzuGUosFE=;
        b=g55EkgEMjHDZlF6Nb/HuWH3W6aVULSVNQxiWCreQ390q2VVpK0KC4RMdAHugcgMrbJ
         jQbeltWWbGskv+yrgvwt5ZNDSQBAYuZL/Yx2eCYsAur2TC2ORll/nNpoo416lhveVyCZ
         bv5Bcbg39lfUTxgiwCk4Bi9Le5XLjvtqFRpooyOgAxjqCnZadyqZan+6xyVkRZOvHv5F
         b7n8xw2/gIR2sNHxFQAYUywUDug/jctWKnpqIciAoJ2Vw5/hta/qND93Enc2srZ7Egpy
         K3XQzT2tD+2UCAaISIF3wEUvR6jpe2y9pEn3gn5EvpGOM76PQhEEnkXhmcNsW0BpzCam
         2YYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UbgAcOLv9s1RlpGMrvoDyf2lbPXO/dPqgzNzuGUosFE=;
        b=MmzCFfPlWtlNQOYK8YOHe5j28nPPu8mmDc3xBjPJsinu0tkqJFb9SF/wkEys3o4Ouz
         2qC5i72FNCqhOUq2U3onK53zatoQTfqxnqwdMdto/v682PqBZTBXFnSKOYc6i8eMD/ha
         cgVlZgi/oZpChmUWJwUnL3g+JsaNgEu9J8b4y76eofiTOygiU3dFA1kDvYd5h2HeI26e
         rDAp8invaAn/y9FOIHNEKTP8ihqW2m0lALC4lG+BMh5nRU3UjtS5BLXhHgOuU4RVufsq
         ozsAxWrjmPP5VADCtTbL1x3eGMyRegnqmCA01hd+1ZPm3q63SNWFSdm/gnoI9TkAVA1N
         qIuw==
X-Gm-Message-State: AOAM532BQY4gyrg/GjFmC3uWT7ERswb9cV/BW7JSmVW/tLny1ngMsXnQ
        UJLlmQH82NZ5wdWEz19vAiw=
X-Google-Smtp-Source: ABdhPJyzQ40HbhkXMXCpNwfy+2/Tfz4lOB2Yp9Ehn5sDv4W3IsdM132Zzq4fiE8VxfDVjt4RJkvydQ==
X-Received: by 2002:a9d:1:: with SMTP id 1mr485856ota.81.1600712488402;
        Mon, 21 Sep 2020 11:21:28 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with ESMTPSA id i7sm6251787oto.62.2020.09.21.11.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:21:27 -0700 (PDT)
Subject: Re: [PATCH] pack-write: use hashwrite_be32() in write_idx_file()
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <4c561e04-7edc-448f-46ca-4d4ac33e9ab3@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a074b239-95c0-3b95-338d-4b8b0c23d7da@gmail.com>
Date:   Mon, 21 Sep 2020 14:21:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <4c561e04-7edc-448f-46ca-4d4ac33e9ab3@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2020 2:26 PM, René Scharfe wrote:
> Call hashwrite_be32() instead of open-coding it.  This shortens the code
> a bit and makes it easier to read.

LGTM. Thanks!

-Stolee
