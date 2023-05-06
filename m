Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2745C77B73
	for <git@archiver.kernel.org>; Sat,  6 May 2023 12:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjEFMik (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 08:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjEFMii (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 08:38:38 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CE717DC3
        for <git@vger.kernel.org>; Sat,  6 May 2023 05:38:04 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6438d95f447so1924993b3a.3
        for <git@vger.kernel.org>; Sat, 06 May 2023 05:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683376648; x=1685968648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uz4ScYpZfBREVgbKu6l3DEZS0yyG7sOb/dCxOypA+Hg=;
        b=RDtIaarrsYn3yEo8z2PXgua8uFxkxilLxC9ACx3MvDI+jDgYyMWkY3OUz21zz9/2jg
         oiqNNYFv30xmXfsDZPqLj9vmrsCmQgSwwUu8rF7a2peLLgyxh0raYBidVxRRA2ojpyGj
         ZSWn112SN9VoUgPJ18fJPMcmioiVg7C6Fgl8xUPyZToRGCkuV8uhGiueVCPJcWDobv+v
         M6ckazCq1f7usrJyZT5wsfcUOQPB8joaMcd5c2KyKsNbTwczwrL85LnY+T1wNdJEafjU
         sJl83BjDiKup6cBNrlAbF50LzBXweB8gEgLrFAuU50N3WymZP//v3WauT5B4NxzRFb8B
         oicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683376648; x=1685968648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uz4ScYpZfBREVgbKu6l3DEZS0yyG7sOb/dCxOypA+Hg=;
        b=i5XcbIN7iv7xUYJV3/JblAx5aK1hyWGO6zRZHlmcCpx0yKBTKsgPTjpkHdm7FCmIdT
         JruMG0K9DHT6/NtfNcmZndhIV9AZEBNrTbdJA5UxKR1gKskXkyykXBxaHr90aq9NrQLZ
         rkyV4P9AebjpY18cHCvJ4BtLr1c6/bMFikPdD95oEiH5TRCi/xGCUweS+mQS9lpL1stv
         bzXgWam0Ix66l9eRDmJUz9mPwVcctXINb0Vhmqfh/5mn4XBrFzeKLhXxtZoq3zWckysN
         ADUzkZ5QcrE2jLw5bWwfzkmbcKGZ9OTBKyQVR5js0LX8qvj78On3YViI6ACzPG2vvGlM
         q+PA==
X-Gm-Message-State: AC+VfDyyDX7DSJpgopqnB4nIme9WgTkM3B801SzUZ57V14skA0ovUit1
        RrAnAjJWPsEt+8P5i/bRhSD0pYBEG+HHPMbiOa4=
X-Google-Smtp-Source: ACHHUZ5d2CQg1CSY/Lae1b7zkraAn9BXGqoV2wDcYK/otWJreBpH6rf0JFnvo2zYvEInDhnV6pUIYA==
X-Received: by 2002:a05:6a00:14d0:b0:63d:2f13:1f3 with SMTP id w16-20020a056a0014d000b0063d2f1301f3mr6412285pfu.33.1683376647688;
        Sat, 06 May 2023 05:37:27 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id n13-20020aa78a4d000000b0062de9ef6915sm3096621pfa.216.2023.05.06.05.37.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 May 2023 05:37:27 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, johncai86@gmail.com
Subject: [PATCH v2] name-rev: make --stdin hidden
Date:   Sat,  6 May 2023 20:37:21 +0800
Message-ID: <20230506123721.67555-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.0.335.g9857273b
In-Reply-To: <pull.1225.v2.git.git.1683314270964.gitgitgadget@gmail.com>
References: <pull.1225.v2.git.git.1683314270964.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 John Cai <johncai86@gmail.com> writes:

>-		OPT_BOOL(0, "stdin", &transform_stdin, N_("deprecated: use --annotate-stdin instead")),
>+		OPT_BOOL_F(0,
>+			   "stdin",
>+			   &transform_stdin,
>+			   N_("deprecated: use --annotate-stdin instead"),
>+			   PARSE_OPT_HIDDEN),
> 		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text from stdin")),
> 		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
> 		OPT_BOOL(0, "always",     &always,

It seems like there is an odd indent before "&always", of course, it's
not introduced by this patch.

Thanks.
