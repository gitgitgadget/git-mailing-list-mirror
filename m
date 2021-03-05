Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF366C433E6
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 16:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9256865074
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 16:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhCEQrt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 11:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhCEQrU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 11:47:20 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE53FC061574
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 08:47:19 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id b18so2803279wrn.6
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 08:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=QH+au7VRimP7lMDw8pDsxWSpN2vEnl9cL+F9edwZssQ=;
        b=gcPARdABkCZDg0yOlLVbepvcfSXav7CN4cGJSYqWh5QvHr/yK+IQBtTzKuoDObs223
         KXEX+eSb6htey+RaiplxqJrmbNEfQ132oGrV3bXuoaCYsUd0MrA+5zM9eCDHP/5y2Tmc
         9UCK/oCgIQ1ICkn214RsMjjAg5oee54wPQaV5/Ya8nRN7plQteXmKhVBApK0jiQQZJQ/
         L6+9lfqc2cphLo6ncDa6f8qmJINZR5pMb+s0VyNDHYWMlVW1DpC1HsV+D7WumyHmmSeI
         3jVii33cubf/7jCNFrRGQhtvwl2tc3y5opslOOY+G/3pOVphbUEdBLGA9yeTVTIWDjOz
         +epw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:from:subject:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=QH+au7VRimP7lMDw8pDsxWSpN2vEnl9cL+F9edwZssQ=;
        b=om99n42qE7XcUsMg1B/oyKd3J7lBYr1fEGHfZtBgrcZr8iwW69/Sydg6gZKlRLvjv8
         Jj2cAouLHsyrF4Lk/IPhi15te3PO5pk41MT2LJZwtapa0mC5HmzouqD3HNs4lYNhie1D
         AARxYqr1k5X+UJDu3AbR2l8mhmww/ryMr3Qp/93U5ehwR8nNa1XmLEDKy3XuK9Rt/Fa0
         Ab2zvOI3H2qpKO7Keea8opOV2cTEfoEv8/wKDCA5MtBgbdwxqC/lU/afr0MpK9cFPoi5
         QhBwnaoeX4GqR2WPcE/ExYFyCeWmznXtViJb9CcWU3BBUWuygQLD8yCn00oB/M5bFp5K
         2Tdw==
X-Gm-Message-State: AOAM533YtsTsXgenOITOms+9ayQAh8AVSgedlkAhz6jrKJNOKYpGCYJu
        Phk30rUT31tXWXLM7KnIvGzsdSLDHNs=
X-Google-Smtp-Source: ABdhPJznercnccOOyCdLPsvccdabI9mkx/m5MQNcrwev2SQGZtIqELgu+KahFKkXxqJBNJZRzmE46g==
X-Received: by 2002:a05:6000:18a:: with SMTP id p10mr10502707wrx.166.1614962838469;
        Fri, 05 Mar 2021 08:47:18 -0800 (PST)
Received: from ?IPv6:2804:431:d77c:4285::536f:6e69? ([2804:431:d77c:4285::536f:6e69])
        by smtp.googlemail.com with ESMTPSA id q15sm5354443wrr.58.2021.03.05.08.47.17
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 08:47:18 -0800 (PST)
Sender: "Soni L." <fakedme@gmail.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   "Soni L." <fakedme+git@gmail.com>
Subject: Cross-signing commits
Message-ID: <355bb5d1-f661-4ac2-d536-d1c56ec5e408@gmail.com>
Date:   Fri, 5 Mar 2021 13:47:14 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a somewhat unusual use-case where we need to cross-sign commits. =

Is there any way to do this in git? As far as one can tell, attempting=20
to cross-sign a commit would cause its hash to change, and creating a=20
signed child commit would break fast-forward merges. So these are a no-go=
=2E

Thanks.

