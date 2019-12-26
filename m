Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D433C2D0DA
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 14:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F1B2075E
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 14:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ok5fEQNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfLZOgp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 09:36:45 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44749 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfLZOgp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 09:36:45 -0500
Received: by mail-qt1-f193.google.com with SMTP id t3so22406315qtr.11
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 06:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xGiQ+U98bnKVyIDsCxe/uqF7K5rzRbYiC+ve0ev3N/0=;
        b=ok5fEQNL1vBw0Abb2F0PmICjkpKUZa7q0hfAG7hsFVUjouEqL5ocs0saNeudXPjoxd
         gaf+0d2FnqvGQMQsDVjFU895/HF8TfleNustuJmnTLs0OmEx2gyFbTxtcMb4uq3L6i4U
         g4FKySU6VHZTlRWIxbuEThmJ4lxHAVnhxvnDLTtm2zzKfqmUlAW7po3HZ3bKzLg01jJC
         2NmmFETDr1oJiyENPUsHXj3sMOsWTkI9zoGJDJzS2rY5XnxAJOHIrSzoxteQOTFlhlX4
         5E5KwTwVbaMUWcfxhSPNxtXiNlgv8sbVCIawuLeAd6xK0fi1Qip2ElZZKk9ugldTsFCd
         oerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xGiQ+U98bnKVyIDsCxe/uqF7K5rzRbYiC+ve0ev3N/0=;
        b=mwuOyBvH/7UEwh6avp70YS2MJpm3r38SdwXJMOnI2jV3bNCF3KgDJOjyRGZrD7F+vk
         OkaJK9aHDNHne96INopHwZGI25K63eEBq5y3YcH/grvGjgo/YNyGor4j8lg/l/0BNHrR
         ynF1BUTnFO9iwpxUOPVFO3eJgF7dGX9+GPE34kwCbdO1VwJ5jvXAiBVNVKDyfcFmOTy2
         skvfBd4IEUafmmFMP3a87p92QOSd0LetG+I3UT/RiAt9gldUJrCJdpAH91tRyLlAPDdS
         frRkuvZq9CHAcsV1jR9e5pTD6CO/QUXdjnniZvA/aYtSdPMHnSUf3Y+aadc5XhGJ32kV
         0USg==
X-Gm-Message-State: APjAAAULp5HVsibwBjG042XPwc44B2LDMD2Z2sg8qg+MfgHNGDfFILgY
        EM3Fs/R/e+ClqwKzP1vHLOHN/6d7
X-Google-Smtp-Source: APXvYqyRSwTGN+lTjMOoN6eD5bMxfrgmjt9k/8xFy7cIpZGBuhuD8T4mdYhDgRzWA4X3PzKkMGAPhA==
X-Received: by 2002:ac8:2d30:: with SMTP id n45mr33140103qta.203.1577371004545;
        Thu, 26 Dec 2019 06:36:44 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:d596:b1c5:69e0:b2e5? ([2001:4898:a800:1012:86ca:b1c5:69e0:b2e5])
        by smtp.gmail.com with ESMTPSA id n4sm9467939qti.55.2019.12.26.06.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2019 06:36:44 -0800 (PST)
Subject: Re: [PATCH 09/20] t5319: change invalid offset for SHA-256
 compatibility
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
 <20191221194936.1346664-10-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f7d99f77-cf25-398b-49df-137fb7ff44ca@gmail.com>
Date:   Thu, 26 Dec 2019 09:36:43 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20191221194936.1346664-10-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/21/2019 2:49 PM, brian m. carlson wrote:
> When using SHA-1, the existing value of the byte we use is 0x13, so
> writing the byte 0x07 serves to corrupt the test and verify that we
> detect corruption.  However, when we use SHA-256, the value at that
> offset is already 0x07, so our "corruption" doesn't work and the test
> fails to detect it.

Huh. What a coincidence.

> To provide a value that is truly out of range, let's use 0xff, which is
> not likely to be a valid value as the high byte of a two-byte offset in
> a multi-pack index this small.

Good future-proofing. Thanks!
