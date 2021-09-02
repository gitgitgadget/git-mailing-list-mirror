Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1844EC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 11:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB00F610D0
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 11:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbhIBLZD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 07:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbhIBLZC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 07:25:02 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B656C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 04:24:04 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so1214191pjw.2
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 04:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=34i4ocE35MUKywg/cMIr1v2+jeBwWTpR+nfsSTT9INs=;
        b=dnzy79Rr3Z5P65bkHsTTl21Q3cfShXP3+SRmmEe05M0Q2Ne48kt47Tevs7IF8Z9x7X
         zbx9pkRzz1tjhSXnwYUHoRkyPvvc+JUXcB/Dz0/RV4zZwnuuEUnpObnzLhQNm4NebM0n
         bFj3DWzTQw+2ls0wtwWJCbUzO4AnQBN0eqkKYqO4uk9g/c632lFHn3HJ4CaLGk632aMU
         j8u8TxbGXyoysZmYPLxM3GE4X/sm5bbAlEPFDt6sQtCnGKh93gfL7h4MvxSN6X1lq8qk
         dhRiCjR0tuJEpwHxNE3XV8owXMteIekIEX/FN5VNYHN5UtdIazrRLIgljj7oIAggcn+t
         pk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=34i4ocE35MUKywg/cMIr1v2+jeBwWTpR+nfsSTT9INs=;
        b=pcf5MBSkBqgx+TFI42BDxoMhcUEzutZZxs/EuWSflFlXbbD2lCDcDqNmGu9/oE3Jd6
         I77Knln4ZdKv4oe5zmkqx+D7TGng0n8Vf4uC8sQJdfH+jBy9cUpeDTxhhLnC8BK4U6qr
         n5x9J2JQwl5H/9YZ2USH8zCVe6InCWyXD6Utk5gy4CjqZQrVoNuJw1RFT9nArC2PaIih
         Dyqjp7x09CvDiGndEh91jCXBNZ7qUdzXBGU8E0c0gg4WB4lZQV1+/0Ij7GifLnss+u84
         94iXRZ6fU1SBTV6PPdX/kyrZlQqZPXAZCYm6YEKxjwflobf1yPutS+BptA3+madHMLl7
         1sZg==
X-Gm-Message-State: AOAM530EMPo2buH09orDzT2vxUBlT1vwFUM8u/9X9mkwD/EPSwfscvdC
        WMLHdPQ8fNLfWaDiX/P904s=
X-Google-Smtp-Source: ABdhPJz1ja3SrJAC1RmZ7uC0/AGvbO9hJwj8BTlbKccn41UtoETVXP92+hMR4/GKQzSIS7wX3knBFg==
X-Received: by 2002:a17:90a:bb04:: with SMTP id u4mr3185963pjr.221.1630581843788;
        Thu, 02 Sep 2021 04:24:03 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.145])
        by smtp.gmail.com with ESMTPSA id i1sm2117534pjs.31.2021.09.02.04.24.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Sep 2021 04:24:03 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     avarab@gmail.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v5 05/14] packfile-uri.txt: support for excluding commits and trees
Date:   Thu,  2 Sep 2021 19:23:55 +0800
Message-Id: <20210902112355.76244-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.456.g1a7c4c5894.dirty
In-Reply-To: <8735qxccay.fsf@evledraar.gmail.com>
References: <8735qxccay.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Newline churn?

Agree.

I have no impression why the NEWLINE was deleted, will be fixed
in the next patch.

Thank you.
