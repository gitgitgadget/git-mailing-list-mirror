Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB345C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 08:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353805AbiCYIPN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 04:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346416AbiCYIPL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 04:15:11 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894DC6A02F
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 01:13:38 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o3-20020a17090a3d4300b001c6bc749227so7615704pjf.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 01:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=szCbK5iMYMrsZ3ii50PzkmZOYVQRDX7TbNivQavHKno=;
        b=Lzk8F1C0bQ/tDEDSNuGdq6mFfFBhLvCBlZTlg9ee7OMP6YZZPoxZ382L0tjgitGhvw
         UEaJ4npN5IyuadR3m0At8oeu7Yyh2tEzrij0Jrkb110F2T8Nn+kEX0j1RWSt2rrCxPVL
         /KjYMQAjvYETsYD0lB8NaXYotkBBhWxlGrWzPRKfRk1zEDn521AzeZs15NSk7F0rr2v4
         LHTxsN3C+UNIK8o+t/R2+gn3/5irMYBbulypi5arENRXFqg/zxS4S5dQZ9iHXQ2KBNpt
         79odAJ8TakmgIcgjXBsRFS7AYcygOxIxst56O9Ab+V+sxyiG6wz7kSFgyFJEIftT5zbO
         rPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=szCbK5iMYMrsZ3ii50PzkmZOYVQRDX7TbNivQavHKno=;
        b=RLVwvJVgiCLj+S3nQmLIgWPkCnukGlIkxLPCs/NkTHBL/Pqb5KiHok4+ko2cGgjEjP
         EbEEb4LxZBJCA9BWKHY3Cj2che3kpIUJ0bAX3MMqMxnePSGkEqNCz9bGvttV5hntNhsv
         8YPJStj3dk7i7ht4vYobrtz61jGiqmI+SKBm4E5e1R9McPAIuurMiJwgxfyyzyLGoN8O
         e5f5oEbGUhKtFyr4lCrMjd5p5kQPdmo18j3EP/kKgi0CKutxodPZKsN266Q7xTH3DNNB
         pX7qlypCQWBnebAQ+itsxMXmJldtueRskJ3vPv3f3avCRZKmBiromPhkTZnF4KVxdv3N
         Qj8A==
X-Gm-Message-State: AOAM5320za9dXWHecqyPrDQ/jBWGZVucaVloJBwOd/QWQYuFbpc5Ckwn
        h9H5B4ujk0SazGxzUrVSO4Y=
X-Google-Smtp-Source: ABdhPJzlnJDbeHWQk5zcHaGSARd78QINcHuSUl8SD7N4yIrTcvBIkveyraknLDR6Hpk1nyczREb+LQ==
X-Received: by 2002:a17:902:ea04:b0:154:63ae:ab97 with SMTP id s4-20020a170902ea0400b0015463aeab97mr10191240plg.110.1648196017887;
        Fri, 25 Mar 2022 01:13:37 -0700 (PDT)
Received: from localhost.localdomain ([2409:4061:2ecf:fc24:e0b3:196f:65fa:133f])
        by smtp.gmail.com with ESMTPSA id 6-20020a17090a194600b001c61a0f3debsm5059730pjh.10.2022.03.25.01.13.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Mar 2022 01:13:37 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] test-lib-functions: fix test_subcommand_inexact
Date:   Fri, 25 Mar 2022 13:43:14 +0530
Message-Id: <20220325081314.1500-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <xmqqy20yeuri.fsf@gitster.g>
References: <xmqqy20yeuri.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> ... How much fuzziness we tolerate is something
> that must be made clear to help developers who may potentially want
> to use it, and the phrase "inexact" alone would not help us.

Yep! I agree.

Thanks :)

