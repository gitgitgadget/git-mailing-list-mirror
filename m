Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09365C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 16:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbiBVQa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiBVQax (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 11:30:53 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314C6166E26
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:28 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id f17so9557495wrh.7
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E38wZpp4FkHoZgeWxHWlwwjW9ujaAyYMiL9nw2foArY=;
        b=m+O/QmbYzibJtWkfZXI0WmqfePnSMaRahcRGg6EZBLt6V9V0xvctdl4RlTU1vBUwHj
         HFsxJ4jjIrbdqLOQZoz6hPkopz57Qfome0xibyntsqipWdvRFkvBoCylADv0UQhoGcks
         FhDbfOpVhex8ycq19RPe5AMHjWyf3gGE6ehgXdSYwMwuXrr9pF6DJEQrsYCE7s7iuHxj
         A/niIomIW4t5LPUJWHO511CeWNqcYgKSEc3c0XHsW9SolfzxyNr3LYFjHA+dmh3Jb3lp
         J+9x/1IiNALLLCTJ+GjbDIece+Xbs0AwT9tBf2h/QQ0L1gbpDfCId95t/JhaMoCSNS23
         NEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=E38wZpp4FkHoZgeWxHWlwwjW9ujaAyYMiL9nw2foArY=;
        b=yByMMjnU5wlfvUGsr55SR9BCjRiBPvXziu2twbBaoX6Oj+UJw24o75Gls2R8YJmIFU
         rQ+WoWHjZlcE1UDF3aReQHcPIap1Em6RUdhNxoS82gf71cBkTqXJ8fqjIbTGIzBwg9zX
         xS++ZqRHOylxd9HqsdClHfBaEPson2QH9HemZw/kk8HLPMRLdq81wGjRx3g9zvOLLnok
         JlYVW37nMq2LkuT7H8B0DGV/ZnAN6edPqWXmnQikbqf//5WRnwoYwM5jQr37ugtmmmlb
         /d56KdMPzUNmGaIR7BGCHdbMPnaW7F+3ZyNG+N1nH6/Q/swHrU0xf5qdQuvBFGmox65q
         IFWw==
X-Gm-Message-State: AOAM533cdk2SMXc55T7ZrJYygbNoP/373zJbBF7JQwfY9b+eh1v3XzDG
        K2gXd1clToqq538hha8vMl9zUiWaas4=
X-Google-Smtp-Source: ABdhPJzmq3f1/rpxoPZnoR+N7BURymTfwFRwDKbj8z3QTBSv/APpkPs2umttOmnHwF12Qg2LvQ/nEQ==
X-Received: by 2002:adf:f312:0:b0:1e8:f4bb:5a5c with SMTP id i18-20020adff312000000b001e8f4bb5a5cmr19472630wro.668.1645547426669;
        Tue, 22 Feb 2022 08:30:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r14sm28749169wrz.84.2022.02.22.08.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:30:26 -0800 (PST)
Message-Id: <4320101f2e01709ae33f7d81c9e4caa486fd9ad8.1645547423.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
        <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 16:30:11 +0000
Subject: [PATCH v2 02/14] bisect: avoid double-quoting when printing the
 failed command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We already quote the command via `sq_quote_argv()`, no need to enclose
the result in an extraneous pair of single-quotes.

Pointed out by Elijah Newren.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 4208206af07..ba6d90635a5 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1115,7 +1115,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 
 		if (res < 0 || 128 <= res) {
 			error(_("bisect run failed: exit code %d from"
-				" '%s' is < 0 or >= 128"), res, command.buf);
+				" %s is < 0 or >= 128"), res, command.buf);
 			strbuf_release(&command);
 			return res;
 		}
-- 
gitgitgadget

