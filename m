Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5AFECAAA2
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 04:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiH2E6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 00:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiH2E6w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 00:58:52 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D748843335
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 21:58:50 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c2so6879610plo.3
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 21:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=GMI4O6UnkXkg1wI4hoJ+ay175Ni5q9ZPR1YQ+u3lR0c=;
        b=J6V9tVYempmZiDQrXQ+MtWmgwWHX1Digb9BZwG2na9GZZUmmNq0WrkcuLRUb1X74Ip
         BXM4znJSdOneKqLNEQ2aaoY1to6hJo0dS08bZjX+A7L8Ezgkin0XBZXRsWsPEWmPKiSx
         nyKliuwzJ2YWi9FKSQmiUl0x1+llbV0S8ijrolSMGlLJ1tIzr9fyLGhxue+bhdx43mMH
         4eBI2PlOb7/CJejS+VVNLP0P5cflrcMnwLu2VfQOtZZR58jizKSo4pkd19rCGvfvGpwq
         Lj5uC1B9B33bFTOGG439C5hDCzsmqoEW/fDOwOoTmyq+kyvubs8iy+DXHlTEog0v1WLK
         fx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=GMI4O6UnkXkg1wI4hoJ+ay175Ni5q9ZPR1YQ+u3lR0c=;
        b=tAA48YCQy4bdpFSgxzU7/ZelWxzPbJ2NcRY+e69kBLLcHmQbHZ4UZCGD2epfDi4J0X
         ORwd7e2o98Y0gVCPyFWaKeXtnYU7HKe1EsmyewLpTRv+8HvY9R+Y/iW7MUoBGso+MUDd
         Os6r/uCJ2jjvhj+znsp+Dw3UgMuqm+6RwR4qrWXaGFlSKcJSsu7VfJJnij60eCEq9Yid
         p0wkNeOZxdlVnwsS+TK/Lx8MPlZ+cRF2gjaCImbP4BwMGkGUO8uL1XDEAwjkpRbnYVbH
         o0Q9mCKT+SVKNrFGFSJ8JCLAWsvS86o+CTLTMjOKCs2JX6CggZ4s81RfLVXX/RNLg+o3
         UU3Q==
X-Gm-Message-State: ACgBeo1lhc+uVKoEe9+TS81r+OaTqsI9r8MbNVWu15WTD521wmisj346
        +7PBOQwPC+N2tFWChuT7ISw=
X-Google-Smtp-Source: AA6agR4TMEsR1B4ARqZmmeJX37VKDelvfw3u20uFowCsc3E2B5F2xn3WgtkccqgXOXrH15aHib5kTw==
X-Received: by 2002:a17:902:ef46:b0:168:bac3:2fd4 with SMTP id e6-20020a170902ef4600b00168bac32fd4mr14654480plx.132.1661749130333;
        Sun, 28 Aug 2022 21:58:50 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.103])
        by smtp.gmail.com with ESMTPSA id z7-20020a17090a398700b001f2ef3c7956sm5429382pjb.25.2022.08.28.21.58.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Aug 2022 21:58:49 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitgitgadget@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com,
        derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        mjcheetham@outlook.com, newren@gmail.com, steadmon@google.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 4/5] bundle-uri: add support for http(s):// and file://
Date:   Mon, 29 Aug 2022 12:58:37 +0800
Message-Id: <20220829045837.49659-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.37.1.210.g6a6f1a04889.dirty
In-Reply-To: <66a1ce4045192d153d5ac66cc248ac569cac8cf6.1660050704.git.gitgitgadget@gmail.com>
References: <66a1ce4045192d153d5ac66cc248ac569cac8cf6.1660050704.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> +	while (!strbuf_getline(&line, child_out)) {
> +		if (!line.len)
> +			break;
> +		if (!strcmp(line.buf, "get"))
> +			found_get = 1;
> +	}

Clear implementation for me to read, thanks.

I'm not sure but maybe a nit, should it be a "break;" after
"found_get = 1;" for omitting the left uncencerned capabilities
to quit earlier?

Thanks.
