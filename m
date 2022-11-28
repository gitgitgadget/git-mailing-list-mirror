Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28B0C43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 12:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiK1Mab (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 07:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiK1MaK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 07:30:10 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169901D66E
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 04:29:29 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id w129so10294972pfb.5
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 04:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdVFBIRNZhXRIwbSCAcNw6hKPFbss+QQUpIqLojyEpI=;
        b=Prm/FXCCZrKOrNucQMJpSSDKe97ucjyOu41QcwWryOOhMjdJr89hc5zopzVlsDE4Cz
         +li7jBu9pD/IYbU1jsoywF08dHHj4qaANFBi0IuuqxmzhgAZVqqTivWbEkA+GZ3ATkJs
         33mTcWuFU3AiNBOObW6x4JJ8g7SH52YDrpxJ/MGtcL/8cjL4g6FgJK1TbITAxPBWTBmh
         PNg44kkyK78eGO4m8o2tAzNbuyT2BoW//nMaROmjEh0orRS4nuOeG6nKvb5bc1BCI5J0
         EpTYd6fkhbCGTRiWVwJquU+XIKsPesY9rTcEypExQcSsepb8hZQbBwnG/ErmD+SgyDk4
         eeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdVFBIRNZhXRIwbSCAcNw6hKPFbss+QQUpIqLojyEpI=;
        b=IVZQUzmQ8t9L3uxXHB1OqZrIRO/TIfjlxun07op7jy3zBA2zpLc79n/kwXMqMMvMGN
         E+yAuwHcPRgTm550bS+pvK2kbylSUKRfPp0AmZ37Ih6Dbp7Epibr7tR9BAhajU7jT+0N
         Y2UgNsx5FuAfcJz2wxK8hRtYFfmANOauILPvw65FSX6jxjdJBZCG4yPqZ3yXzN7jPOo0
         CSQhOfVr1/o9Uuyld88lN4/wb67IIbFouPKysa4sGpjTtEyXmkenCwtzM/iu/KNTwVl8
         TRnbrINesr8XOVdexGEUvqmgLE+G/zkrTsEj6658pH7XzrjVwIlKS9IJDhfuXJJi/DPq
         zk6g==
X-Gm-Message-State: ANoB5pllTFBUzC1wcNM8dGZ4wfOlczuTAybLmsFRNQqEWm53m7u+kYUZ
        5d2vOCfPjGeZDAP2xew73w4=
X-Google-Smtp-Source: AA0mqf6T7FMD3DZmito9j/RKPVougOV6g5JLkHjxcjRdrN7GzMm6XQlHA6GcEr+8z64K2M9SmUTpBQ==
X-Received: by 2002:a05:6a00:4c0b:b0:562:ebc8:6195 with SMTP id ea11-20020a056a004c0b00b00562ebc86195mr31704682pfb.38.1669638565340;
        Mon, 28 Nov 2022 04:29:25 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.57])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b00189947bd9f7sm626545plg.50.2022.11.28.04.29.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2022 04:29:24 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v4 4/4] pack-bitmap.c: trace bitmap ignore logs when midx-bitmap is found
Date:   Mon, 28 Nov 2022 20:29:13 +0800
Message-Id: <20221128122913.53518-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.473.ga0789512c5a.dirty
In-Reply-To: <xmqqbkozvqbt.fsf@gitster.g>
References: <xmqqbkozvqbt.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> write:

> Thanks for all these good suggestions.
>
> As you pointed out, the first two seems to be identical to what
> Taylor queued in 'next' already (so they do not have to be re-sent
> but it is not a huge deal if they did---it would be a huge deal if
> they were rewritten, though), and both of the two follow-on patches
> make sense with suggested (minor) updates.  I'll expect a reroll
> before queuing these two and mark the topic in 'next' to be waiting
> for them.

Sorry, Not online for a few days last week.
Will send a reroll today.

Thanks.
