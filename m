Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F77C38142
	for <git@archiver.kernel.org>; Sat, 28 Jan 2023 20:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbjA1UIc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Jan 2023 15:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjA1UIa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jan 2023 15:08:30 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F2BBBB6
        for <git@vger.kernel.org>; Sat, 28 Jan 2023 12:08:29 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso703452wms.5
        for <git@vger.kernel.org>; Sat, 28 Jan 2023 12:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTvNOOm+QXCw68y4fbAovnVqZZWwKB7v/CfsevM4YB8=;
        b=hAJMNhtJKABz25Eqy6XCeDpolAPgytkOHjOdd9IaxMM6XoMVzelGt/zgvPkQ3r/nWQ
         RdsCtbE33RHhyQlSfyVu8sGR6OgIat4C73J4+t8dKhj1zmD6JynpY/NRUDxkciLrVfh+
         WdJCSNTkCJXIMK1x1viC+E8n/t9thfrChiF4/xKs+0yn6qqDZFC2JLQFETL6JPrWfg4Y
         OCDraVs/x/QIY0/qTqlAml2P3RTRtN5q03rhZWPtlmRQQTi9nmJw4LfChdfGEiTDvdBz
         CBra6Pwdb8jcaaerqpWD9W/83dwgvUeuEEzSMI44aVn2Ngi9TKa1snRO0geTfgB2SF9l
         6iqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTvNOOm+QXCw68y4fbAovnVqZZWwKB7v/CfsevM4YB8=;
        b=IoO8ioy4f3c9ScJfooEVokfJVqDBdbOk7IY9SN/JnmDqWtEZuM8DzyPYGgBj0H9hiq
         J8IzOREaIa/+qVPMdsG3s75CMEdlEvphkIbJP2rWu8qpcV2oCFv4amXY+3HimYB3k0vf
         JfpVwOdY9kiLqOCbk2dOdvbNWdiPTIvc+g0jipBsVeN+hT37GUUwrtG4aeEMo3imBaDe
         dTosJzVzl7iGym279Vzoqg9hUI81dxxxbWK8vokkcO6WY/i2QeWTr5XB/tTUQA3YLHXh
         VmK6p+IuJSqRt0GcDM6hx9LqszOQdMG+KYTCKOp9eerkouDAeRmQPogtz2ZCF0h4NgY+
         c0Wg==
X-Gm-Message-State: AO0yUKVEUg12/vclQVmUfCjPKZ+bUfqBs/Wvai+55oSC8lFMo/A/fic4
        BcRdbfvRKn2E2dVmGEsXAq75yErJisg=
X-Google-Smtp-Source: AK7set/nJgnEf0XyB1goopLzXXKBo0yiMPR97xwNILIVaDMT3Blm6yjrByFb1Wcizhb6Y2nYnYJZYg==
X-Received: by 2002:a05:600c:4f4b:b0:3dc:2af8:83c0 with SMTP id m11-20020a05600c4f4b00b003dc2af883c0mr9803523wmq.31.1674936508300;
        Sat, 28 Jan 2023 12:08:28 -0800 (PST)
Received: from penguin.lxd ([95.146.230.133])
        by smtp.gmail.com with ESMTPSA id f1-20020a7bc8c1000000b003c6bbe910fdsm13188695wml.9.2023.01.28.12.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 12:08:27 -0800 (PST)
From:   M Hickford <mirth.hickford@gmail.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com,
        sandals@crustytoothpaste.net, mirth.hickford@gmail.com
Subject: [PATCH] Documentation: clarify that cache forgets credentials if the system restarts
Date:   Sat, 28 Jan 2023 20:08:27 +0000
Message-Id: <20230128200827.6427-1-mirth.hickford@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Y6PDx7Ij4NA/kBB7@coredump.intra.peff.net>
References: <Y6PDx7Ij4NA/kBB7@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Junio, Jeff and Brian for your replies. I'll send an updated patch based on Junio's text. To me, most important is to explain that credentials are forgotten early if the daemon exits, so that setting a timeout of 1 year is unlikely to work.
