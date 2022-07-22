Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF079C433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 06:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbiGVGRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 02:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiGVGR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 02:17:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D491C664D6
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 23:17:27 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q41-20020a17090a1b2c00b001f2043c727aso3361485pjq.1
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 23:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gzashz6xYzBVK6PJkSjyqYoH1Zpw3MPXxb3dnNmRPWg=;
        b=qsaosoajTBH6dvyARQ4RfWtyul6Xu/99sMH0m+59NDqXIXLF1Bd7tic/uWVx0UGSzT
         w1pvE7MEDi4gGQCblxRFeeTjaUzzZoCdmaVPlFhpvEivs/OS+QqQm6rAW1cR9KTEjYhm
         Z8yd6gEVZKsPNNxCqPXoRidaUs8K5u6ZLW8j2RU/htdUhUMJ1fOLF+UnawaueQvABSy/
         V3xrqvQ4FSWFzbveFRD/WLz7V7wJ8kIz5QJmHG07igPm7T5FjJM1uC4W/pFo+q4gEfST
         PS4YDW0cWyZSlMSiW0klabwxqTNzRnjdIFKk2o3GrNOmnSRRdOPLDOhTBrC56v/9Q62U
         h/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gzashz6xYzBVK6PJkSjyqYoH1Zpw3MPXxb3dnNmRPWg=;
        b=TNShbsmLQOTdTo+VlH0s0NJVlnE18yj8Y7YnTHMU7Q/JxHQ0xCmycAaFuEskwlZhaM
         CyVX+Lu4QSef8G6jQkSyBxTdhHC3OaVOHT5WlP3gD5PKbYix79kv2/WgVgPkDx5zKEKm
         s9qTnC+6KTxdUa0+v1YsPr+glouqArtrM/bekMa0yknTiujid6WXzgwnRgzjPZLHRkZF
         UM6G+dWwyL52ypV7UCciiHAV6PmIJiC8AD1xEM6B1L7GU/Vv1p19Y1aZuW8Hkfrpm+eu
         oOC6jlcxbEz72Ch+I/XeHT4uYX7ZAobuAFfTKMlTDVHzMSUfOlMfuEryB3j/U4GXip5w
         XXLg==
X-Gm-Message-State: AJIora/xOJyphOwiI/2d859QWoqCYcuAVuYfESWz3oyjD8WqAN5KYeHl
        lUwXtVTzfjaHFf4UxmhdwHw=
X-Google-Smtp-Source: AGRyM1vy+tU/9fBe5WdEzWz1WE6i5oHy+7EwdODKgxtq2iWSCVTt9xEC9dTaOMU2/3G4QfUMdleKWQ==
X-Received: by 2002:a17:90b:4ad2:b0:1f0:3395:6427 with SMTP id mh18-20020a17090b4ad200b001f033956427mr2331620pjb.93.1658470647311;
        Thu, 21 Jul 2022 23:17:27 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id y16-20020aa79e10000000b0052850947cf8sm2937994pfq.171.2022.07.21.23.17.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jul 2022 23:17:26 -0700 (PDT)
From:   "tenglong.tl" <dyroneteng@gmail.com>
X-Google-Original-From: "tenglong.tl" <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@jeffhostetler.com, git@vger.kernel.org, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v8 0/6] pack-bitmap.c: optimize error messages
Date:   Fri, 22 Jul 2022 14:17:21 +0800
Message-Id: <20220722061721.9803-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.37.1.1.g8cbb44ffc4.dirty
In-Reply-To: <xmqq1quedq9p.fsf@gitster.g>
References: <xmqq1quedq9p.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> writes:

> If that is the only change, then I am relieved, as I can safely
> ignore this round ;-)

Yes, only removed 7/7, the others do not change.


> The previous round (without the last step) has been in 'next' since
> Tuesday and cannot be replaced.
>
> It seems that both of the topics are in good shape.  Let's plan to
> merge the other one about showing the scope of the configuration
> variable in trace2 output down to 'next' soonish.

Oh, I see.

Thanks.
