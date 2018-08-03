Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A1471F597
	for <e@80x24.org>; Fri,  3 Aug 2018 16:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbeHCSrq (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 14:47:46 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43606 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeHCSrq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 14:47:46 -0400
Received: by mail-ed1-f68.google.com with SMTP id b20-v6so2379467edt.10
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 09:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1WPtpYPWB6fzeHm3Mjyb5CDBhi5coB3+fR5HzKOKKMU=;
        b=P9aziyf40h2bNtgM3DQnmY8hgc/9U7+WWFOSrBpTb8fbaXm+KNRZStBRPxGE9q4qfp
         xIFP7dK00ZsOTdh2UsyFY5MGpB7aEVWeS+2LFxspkhYFWosFgwEoZO04w3UN8FI9QbT9
         Q+ABzPn1lmRMruNLM+qEuvbB74GoWln4WFRI1s6NTW7+GLX5O03Hk2gTtmHfRUPMaCoO
         Lxpu5vxeSUtrsDxsR5ZMvXoubWixHJD38Sa2GrmfHj9e2a3IgpHOwb3W0qSfwvg//i0U
         2fehaxmLJKjGT1fnJ6LYusHE/CaMDMYQRfnyqatEai9sY2BWb5PI8iq7eq4XjMRiJQTI
         vclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1WPtpYPWB6fzeHm3Mjyb5CDBhi5coB3+fR5HzKOKKMU=;
        b=P3tfvMoiJC1s1zpJxhQd/+JqN1ubOAeduLPCxhJATF/iFSa2kSM2cIWomU9iv2zlHp
         12us3UisjXCXTXXALz29ipcNL5fy6XoovsBiFZ+9sWiOXzEUIHwINj7ypH1j/CnhCz+C
         LTmPdAr4eWzqJBrhPlp+XwqtadwjI3KxTwcX5+pf9V4CT+CHxnEIq/jtQQBUR0U3WRAa
         RuCmQBh19BCJjH1Ngi768kfjt6wxZ8G7LEWRuyT1i64v3f8sLIx3390E7hMVQ7/YjDtD
         v2YUqgTb56r9QhaVyG74IvxPCxcs/AH97RRTPJ+1HEEqI7WL+xU/nKOUyE/GY34A1vTj
         Ev0w==
X-Gm-Message-State: AOUpUlEiAa4c265smmByF/kUQJ0lM8WPgLfk2wFhJcBl3OalrTAHIU+E
        Cr+66wDP2eqeiRJhT/yRlNcpRbiM
X-Google-Smtp-Source: AAOMgpcAE2cbPs6E2i6eWGjEB3opZcP4LhrjiPje8kisxAUQulgnhw7pbnz4a1IhSXyFN5SWhW+16A==
X-Received: by 2002:a50:c01d:: with SMTP id r29-v6mr8106965edb.202.1533315039258;
        Fri, 03 Aug 2018 09:50:39 -0700 (PDT)
Received: from localhost (cable-158-181-65-254.cust.telecolumbus.net. [158.181.65.254])
        by smtp.gmail.com with ESMTPSA id w3-v6sm5711103edb.16.2018.08.03.09.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 09:50:38 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] builtin/config.c: separate message and value by colon in error messages
Date:   Fri,  3 Aug 2018 18:50:35 +0200
Message-Id: <20180803165035.15099-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The error message and the value that caused that error should be
separated by a colon.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 builtin/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index 2c93a289a7..862f870b58 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -98,7 +98,7 @@ static int option_parse_type(const struct option *opt, const char *arg,
 		else if (!strcmp(arg, "color"))
 			new_type = TYPE_COLOR;
 		else
-			die(_("unrecognized --type argument, %s"), arg);
+			die(_("unrecognized --type argument: %s"), arg);
 	}
 
 	to_type = opt->value;
-- 
2.18.0.203.gfac676dfb9

