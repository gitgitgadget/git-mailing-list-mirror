Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDB1C43461
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 12:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36F8820829
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 12:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Blo684RQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgIDMiZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbgIDMiV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 08:38:21 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF24C061244
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 05:38:18 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id v23so7799923ljd.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 05:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ivyLKxJ/+e4XBBBRZqWNetE3DN6Lul5XRFjFZVruygQ=;
        b=Blo684RQYWAhDBighshTW6ABRUZnxM3TkceKqkWZ7vpwqJ+aXn5hEIs3nF1Ojgsarp
         PATRrdbo6Bc1Isp+t+wjsO4U2RrNhoCflzkIOmBR1+GgUXQaQNjg8oqEJBmwnqayucwF
         8zFkLpumlrjAoCvhJTvyv+Ree8D/SaJBDFl5scTa4NeMBu8o572UkfoSdfekBK86bFSR
         HOFGnDDfiVPalgwGpBLrXyNSmCf3vkuf1OQWWazUsVP1HhTtzgpA/8LUq1omuU841jyC
         CnQXYK7NUnVmTA7WkMsGj//3ydLcOFNxxn8/Qwkvl/fkGCGJtN4PvhmEL4Z2hlObIRpu
         Xe/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=ivyLKxJ/+e4XBBBRZqWNetE3DN6Lul5XRFjFZVruygQ=;
        b=FfvWgQ+Wybnh3R3ASaO68k+feJsBDhzJppc6wXrE5wDPQ3M8bhn/dbAvFzfORUSbq+
         GJI1+iuR+yHyDsycXK+kxaxtx/vseOEsqTEOxK4hSFEsgXaO29dBokLa+qsZeNlCYo7s
         T8UI5jyjeEtA40T+wOhBBQ9h5V3pWyGapH0jRdpNuVeBkfKZAfIHtPCVLtBADvGQvZsW
         rYRhsdj8ssHGoOXpmSlYDWBh/MmrTkXF7rxWij4s97v0aAYNf/L29l1LeVHJQHVIE+yQ
         kWrZfZ0BML/7I4YlrOyHIjh2e6MSGMpIza+wZAQ2bE8xha/DJdy8lQiTo+jdWAj/rey+
         dZWA==
X-Gm-Message-State: AOAM530mkOof6d2/ummGQyqApGXUaRtacn7Kezr4EvUQyfI2+81YqTVO
        ALdzgmmPjiNt4qwGqyQNt0QLh51k1nA=
X-Google-Smtp-Source: ABdhPJykATaokbN4UmA/R2NLWboGljYO695Fw0tLLZFgP+YnieOFDkRgtJe7K53QNydUzCU8uofcDQ==
X-Received: by 2002:a2e:6d01:: with SMTP id i1mr4010000ljc.181.1599223093867;
        Fri, 04 Sep 2020 05:38:13 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u23sm239809ljl.86.2020.09.04.05.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 05:38:12 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] log_tree_diff: simplify
References: <20200828110526.21145-1-sorganov@gmail.com>
Date:   Fri, 04 Sep 2020 15:38:11 +0300
In-Reply-To: <20200828110526.21145-1-sorganov@gmail.com> (Sergey Organov's
        message of "Fri, 28 Aug 2020 14:05:24 +0300")
Message-ID: <874kodd8ek.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Junio,

Sergey Organov <sorganov@gmail.com> writes:
> These patches are pure code quality improvements, -- they should introduce no
> changes in behavior.
>
> Sergey Organov (2):
>   log_tree_diff: get rid of code duplication for first_parent_only
>   log_tree_diff: get rid of extra check for NULL

What's the status of this?

Thanks,
-- Sergey Organov
