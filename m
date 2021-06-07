Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF42C47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 15:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6CBE611AD
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 15:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhFGPdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 11:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhFGPdI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 11:33:08 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766B5C061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 08:31:03 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id t140so13186969oih.0
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 08:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kEpaLRr6JyZ2EmemFaesUHrrysD8BU+4AF9Dw+wtyrk=;
        b=dAfGtHYdlzTTj+Sh8+Ac8U4BLck62acVV3+5vFZ9i04NccdlZ/GlkRs8qW95CkFU9G
         QmJzgtW8VxZMEFRKVKUiwJRKgIxznXtH5aJ1oqEm2X2v8r2KP/3C8npvC2ri07hD13p4
         hVcLJ7hfZ32BnYByvONuJt0otrVWyoWk29vE6wuhYJuUssXP+pAx26HRFDkI3SaHxo5v
         6TrahPMfzmRtUlj5LEtUDbpDZ7+7Q9Jv6oNOAPBIEiRWL66k3hMpgucFRur8sSej4tJt
         BlexzAyXPq11pBxqvGEgy3FxfHnjVkCcMMNaSRcCeugkjfPZoXIxWNltnVKQAm4iSOzq
         QbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kEpaLRr6JyZ2EmemFaesUHrrysD8BU+4AF9Dw+wtyrk=;
        b=Xr9uJFXNozxKfQTDmgNCEvei2aFk68xe2LYto6WCFY0v1GIubnfOnZcOZZKqKKYP/h
         TEn0adAa3/9+y1KHgmamwxgSANZo997bH7m+TEKofu5G57jgIzHWpQK9BkjDGl3ZjUhn
         zi/7P1XTFFcaFIbMRtp5dOOl+sX2SI5W1D1Q7gn410yC3B9tdQojp0cEuXwAWL2L49h5
         oYL1MFfkFmcaqq7ucHrm7xQc8BkqJiXo2q4RELOB2sNv3Tdf67QpKd840zccly6AcDug
         HKnS4tfh6OnemotpHKnYZHdGG4QHxarwronOlTJ6waXquiGn6W9n7/qhNqt7+CqS7mjg
         gitg==
X-Gm-Message-State: AOAM533kQRjYLAB51jQCgvOSWuAF+WNd/9dAUuZfGT7jfr6W7b9MK04A
        E3p5W5m4YygB5gxt4WwDE5Q=
X-Google-Smtp-Source: ABdhPJws4FToJYp1eeFD0jsGzWcNRCUweVLM426hyuxas1syeLu1kyk2SG0oEMZ3GMvaT5KF1SwTug==
X-Received: by 2002:aca:b145:: with SMTP id a66mr3879999oif.177.1623079862737;
        Mon, 07 Jun 2021 08:31:02 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:58fa:fc7:3955:c1d5? ([2600:1700:e72:80a0:58fa:fc7:3955:c1d5])
        by smtp.gmail.com with ESMTPSA id w186sm2304464oib.58.2021.06.07.08.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 08:31:02 -0700 (PDT)
Subject: Re: [PATCH 2/2] read-cache: fix incorrect count and progress bar
 stalling
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com>
 <patch-2.2-042f598826-20210607T144206Z-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8f336b1b-6cb7-8277-79d5-0f331159b00c@gmail.com>
Date:   Mon, 7 Jun 2021 11:31:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <patch-2.2-042f598826-20210607T144206Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/7/2021 10:43 AM, Ævar Arnfjörð Bjarmason wrote:
> Fix a potential incorrect display of the number of items (off by one)
> and stalling of the progress bar in refresh_index().
> 
> The off-by-one error is minor, we should say we're processing the 1st
> item, not the 0th. This along with the next change also allows us to
> remove the last display_progress() call outside the loop, as we'll
> always have reached 100% now.

This "pre-announce the progress" seems correct and is unlikely
to have a user sitting at "100%" while the loop is actually doing
work on that last cache entry.

Thanks,
-Stolee
