Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4B9C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 23:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE1B823437
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 23:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgLPXTu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 18:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbgLPXTt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 18:19:49 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B378C06179C
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 15:19:09 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id r5so26662645eda.12
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 15:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mGYRvAWjPpLIAccnmL7zXzCbgzfAUTmNzdQRHgp7dGE=;
        b=WzgF/IJit6ysyEhDAQ7v8Tw2OPkD2INZjSwJAxifJjqYtHKBf1bRe1Ey6ZEJrYw3uL
         X0DTvWBuwUXiP/zV0AHYHIlFsprBYonZwiuA+NLXZzqWpJPobVijLFflJK4/zuRrPsgc
         kfhREXNZWIYqaeBhbhGZKsIvrSoRonEYdZx1TOhAl00nQAFf5yDZ3cHd8HuJF2l7v9y+
         W8FzX5U3CMUv4f7cKKqGM+avF5VyLEy2wXIWSshYKOsmCNDRQctZFE6T9vbduWSf0CdP
         xSeCx7BrXR4zITaPz1iWkZhYZWvJPNERU1qp5u39mMmTOgCiSYqIn0++hxOUQcczKFel
         nG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mGYRvAWjPpLIAccnmL7zXzCbgzfAUTmNzdQRHgp7dGE=;
        b=NZB/hcQqNYlMJnL1LY1TKn8SDJk/3bW6zGtu+J6/UqHhr7p4h7sT5+PuQ7SZZjg7gD
         exLOx7547gVklwAh71IT0KnL84T/dOjbDg24aFtPF52RHgxJ0yGUtX1MFqf8lDdm8tQb
         brGmkuc6lU2eT4CtO4gqZSH0DYK+99/n5BYb7JgyyD7kDV7++PSQrI8YXP10EOHQoL9V
         CUE/VSkuJuJisO58t6uMq4rSUsO++PM0zNquqRVU7iiTI5xPN2uCLLDnEbwKOSXFLO+o
         zk1eYGJhoxewc33LJbxmoEfzsv2nB99pt79BS1UEV18lOpBp1wd3fAXltwGv6erk8pO9
         iYRg==
X-Gm-Message-State: AOAM532TkZt76oC8bDYpexTi4PmiA0muW1a0w8DnR9Y9CKD1EIitwSTF
        Bh49r7iqnMLDWGh0zx20HmM=
X-Google-Smtp-Source: ABdhPJzY8zm59vUdKTjMFlYLKHu4PNu/cplHTWsoABXu4x/FxR7LnDREM5ZnrH62+VuXdgoewt9/Pg==
X-Received: by 2002:a50:fc13:: with SMTP id i19mr37021746edr.281.1608160746975;
        Wed, 16 Dec 2020 15:19:06 -0800 (PST)
Received: from lesale.home (194-166-87-93.adsl.highway.telekom.at. [194.166.87.93])
        by smtp.gmail.com with ESMTPSA id b19sm21907823edx.47.2020.12.16.15.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 15:19:06 -0800 (PST)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     gitster@pobox.com
Cc:     aclopte@gmail.com, git@vger.kernel.org
Subject: Re: Unexpected behavior on diff -I<regex> --name-only
Date:   Thu, 17 Dec 2020 00:18:39 +0100
Message-Id: <20201216231840.3163806-1-aclopte@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <xmqqeejsdv7x.fsf@gitster.c.googlers.com>
References: <xmqqeejsdv7x.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 14, 2020 at 11:49:06AM -0800, Junio C Hamano wrote:
> This is not a new issue limited to -I at all.  If you did this:
Right, I didn't think of -w at all!

> I do not offhand remember if -I flips diff_from_contents
> bit, but I wouldn't be surprised if the recent change added the
> support for -I forgot to do so.

Spot on ;)

