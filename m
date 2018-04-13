Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD8EB1F404
	for <e@80x24.org>; Fri, 13 Apr 2018 21:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeDMVTM (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 17:19:12 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:42410 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeDMVTL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 17:19:11 -0400
Received: by mail-io0-f194.google.com with SMTP id d5so11739297iob.9
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 14:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=pqcPareosspWixAAdQM1KUGz1iCPQ/1aDlZRkixf30w=;
        b=BeQ7GnPi2afRREF5wmxfh3ewK8NKOtp0CSvczH/aEAMCFxZmeK/bJZCNzqnKHdwiEY
         59otx1dnlhAMcF+2I3ViDThLvPqGiCRzxa+9OlcwI3ybr7NdZB9o2VVdNVr4Kblos7Ko
         4o6Vyu90HHEc7IDPh21Hz4VAovVIa5SPmFFbbpBveFHabol+xYViQZs56cMVL7u4U8gw
         9WshifHF9OQtgSulZbEp99Oxz+32TpOigRoREVhtw86y8OR8J8j6AqX1VhaFYbAwmS83
         xdPI++a6FtytcXY2x4+nzNqbbkjKBuC/PLMaX4VwSDZSKr8NqOabzJwKa4Z0g/nMrCrV
         UxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=pqcPareosspWixAAdQM1KUGz1iCPQ/1aDlZRkixf30w=;
        b=HoyukfizTY6+NAgj1jjdHwRpqv0sLPcq2/aO5NiKTOUj5m6qXJKwgf2sKD5mQ2DJrE
         WcB653dWFUPG95l8cLJAUj9wb/bQYVABgEXviWgFriS+Ny41Sd61YbFvk2EXKyHrGGwB
         i9GAuSDllTd9ctpPiDM7XYKRg0bjdFcRiZA1FOlNfgEWvZQ/n4WXKUcUY9ba/NlbWD80
         I5ClII9WXkYVZ2mMrxX+eHreUdaSLKkjzjAgmOLYBUP2aSQPHJIMlJFd2KubL/avM73/
         OTkHtkBkXQy/5FYaEcmK2C9xEFSJm5u2d1RqYzjXzy/kVleld+Jh0L25JxehEq1HntEb
         jB+A==
X-Gm-Message-State: ALQs6tCzhG3Ifa09XT5hdWkYRo4z00sTq6nY2+RJ7233Va39qMgvoIGi
        I1pxYzpChvV3ucM3f4DK0qbRnSEyWhQ=
X-Google-Smtp-Source: AIpwx4+zHz9FNPG+XRMWgIuT1BSKZQmXgckZsFEto3UHjLLvr5uMoIJwjhc4qkd5YXgzMomAtMfxzg==
X-Received: by 10.107.131.97 with SMTP id f94mr1504884iod.17.1523654350471;
        Fri, 13 Apr 2018 14:19:10 -0700 (PDT)
Received: from localhost.localdomain (174-16-129-48.hlrn.qwest.net. [174.16.129.48])
        by smtp.gmail.com with ESMTPSA id z7sm3125124iob.9.2018.04.13.14.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Apr 2018 14:19:09 -0700 (PDT)
From:   Ben Toews <mastahyeti@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, sbeller@google.com,
        gitster@pobox.com, szeder.dev@gmail.com, sunshine@sunshineco.com,
        Ben Toews <mastahyeti@gmail.com>
Subject: [PATCH v2 2/9] gpg-interface: handle bool user.signingkey
Date:   Fri, 13 Apr 2018 15:18:30 -0600
Message-Id: <20180413211837.99415-3-mastahyeti@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <20180413211837.99415-1-mastahyeti@gmail.com>
References: <20180413211837.99415-1-mastahyeti@gmail.com>
In-Reply-To: <20180409204129.43537-1-mastahyeti@gmail.com>
References: <20180409204129.43537-1-mastahyeti@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

The config handler for user.signingkey does not check for a
boolean value, and thus:

  git -c user.signingkey tag

will segfault. We could fix this and even shorten the code
by using git_config_string(). But our set_signing_key()
helper is used by other code outside of gpg-interface.c, so
we must keep it (and we may as well use it, because unlike
git_config_string() it does not leak when we overwrite an
old value).

Ironically, the handler for gpg.program just below _could_
use git_config_string() but doesn't. But since we're going
to touch that in a future patch, we'll leave it alone for
now. We will add some whitespace and returns in preparation
for adding more config keys, though.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ben Toews <mastahyeti@gmail.com>
---
 gpg-interface.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/gpg-interface.c b/gpg-interface.c
index 4feacf16e5..61c0690e12 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -128,13 +128,19 @@ void set_signing_key(const char *key)
 int git_gpg_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "user.signingkey")) {
+		if (!value)
+			return config_error_nonbool(var);
 		set_signing_key(value);
+		return 0;
 	}
+
 	if (!strcmp(var, "gpg.program")) {
 		if (!value)
 			return config_error_nonbool(var);
 		gpg_program = xstrdup(value);
+		return 0;
 	}
+
 	return 0;
 }

--
2.15.1 (Apple Git-101)
