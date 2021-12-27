Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D47C433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 01:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbhL0BHd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 20:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbhL0BHc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 20:07:32 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B68BC06173E
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 17:07:32 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id g132so8807877wmg.2
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 17:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dW1s+s28h7tKMBd6hsoo//uyHLSISji3DqC1LFG/71I=;
        b=esSblGYlWcu+Ap6UdrYRSoose758z56BenFrVRfF0AJ5bWn6OoqCVkciHuV7Vrz0//
         BfQ+Xf2WFQpxQePBb0ipGC5978e5l7+6yg7iATthRYDTYGhXoJ+Xt8kdMb5qJwiKmBMg
         udiV1hasHyggN4ptKxy4CFcMk9nab4VXmz0CQkgV1UqqlKCA7gMTDQEd67Z6ICATcs/p
         8KNVj4T6jawxVIwhTsmYxYOOGin91vnGJkje8htTzItfzHf/X15BeNQH0r9uUJczYsyN
         hmi0buFYLKTJ3JOdpYXwZ+mZtYrpyePgd1T8uWAGzf5xLnxTwhhIKB9HTYKIaxhIS1SJ
         Jlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dW1s+s28h7tKMBd6hsoo//uyHLSISji3DqC1LFG/71I=;
        b=h4ZvkZsUzzd/Jm/We0L53osozeBFy41VwlOaIJf26vhYamQiQJZztkuxqqqItvdBOx
         52golHjM8i8HzgZzDhie9prOlJd4qXYWCfiwrkl7H5T5wwVHlNZ9TK3b5QsurotNFf6o
         5tYSw94df/fRrx28apjzw7CzrBgyLWYUSHExDj7cpymrJL5RlPC7Eyl7xjxB0LvrpVV1
         1wY0YH0OdPFw+IuEXpJ5WNH6u6fPwXePot6haTr+NZY3rKK20ZEkB9Zaml0hOpJnn4VO
         hE8iQf7c7DdVKYj5YB7BiVq/P5nR3IXRVpPVo9HwZSXMsqrvEfLmis0adfkw7fEzFGMM
         ghsg==
X-Gm-Message-State: AOAM530JPtA0RQk9K6HVVlsd8h9q4qTnnMYa/ValmS2Q2p4H1GlmcZqA
        wViXZn5SiIead5n0aPIef9DLmkcUwZnjLw==
X-Google-Smtp-Source: ABdhPJziD4sfLvb79AejVYuz0k0DHISFJtwE3qGhqwxg+8VMCZeX9uIC52nKOW65s1qAp+5/brsqNA==
X-Received: by 2002:a05:600c:1c90:: with SMTP id k16mr11551036wms.40.1640567250936;
        Sun, 26 Dec 2021 17:07:30 -0800 (PST)
Received: from gmail.com (62-47-14-33.adsl.highway.telekom.at. [62.47.14.33])
        by smtp.gmail.com with ESMTPSA id l4sm15553540wry.85.2021.12.26.17.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 17:07:30 -0800 (PST)
Date:   Mon, 27 Dec 2021 02:07:27 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v7 1/7] leak tests: fix a memory leaks in "test-progress"
 helper
Message-ID: <20211227010727.ak6hr5m3wc6kwblh@gmail.com>
References: <cover-v7-0.7-00000000000-20211217T041945Z-avarab@gmail.com>
 <patch-v7-1.7-5367293ee84-20211217T041945Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <patch-v7-1.7-5367293ee84-20211217T041945Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

looks good; maybe change the subject: "memory leaks" -> "memory leak"
