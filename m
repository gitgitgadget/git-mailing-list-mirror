Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4F98202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 21:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753138AbdKTV0X (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 16:26:23 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:42991 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752963AbdKTV0W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 16:26:22 -0500
Received: by mail-io0-f193.google.com with SMTP id u42so17220974ioi.9
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 13:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/1plWX+PUf900PaswzuakWUoMtCkH8P2B1iRvYkILoU=;
        b=LZHqQ9j3ZUcQPmb/+myW2bJ+LIiBm8KcurGRYSXh4KMoMaj/lnqO/BrfuZUfKg6oM1
         8VQ/eGgOENbTL8BcgFjI/b/P80CMo6s+ku3vHHLmoUsjZngo0p4KT+Uy4F7I58JQ/Qgc
         Lp0EyMGmSRswoLn6848txwwBdo1265PmWbQFVAODWdi/QkgdqsGVuLBQQBP2YpS4YCWr
         rkTP2Hk81BiNj+65j2WpKHnZjJdiYi1yZk+gunW1Agx7YOaHiLiSB36aMkCf7/zXty8Q
         iih1nN8pBiIxSoUwCmdQaSFlhkduuihqDLcvPaTtA8YiC2cuiFzT6tyWFEGE5xnmeoXd
         15WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/1plWX+PUf900PaswzuakWUoMtCkH8P2B1iRvYkILoU=;
        b=TgKeWiGLtG8tPArn8I/m+8dOpCDAt1U/zHkPfHavu6A3eCHwP7KoDIj0wfu/v2h2jY
         MsuUGX+5E6i4nWg40AxOzp9d332GLPXhw34ZY2ueANcZg3BI/WoUq3ePpQiWu1kJJwOL
         tEA2H39OMVrmZnDME/cjAHAxvyTmxJBXD4IBIZubDlpPeF7dliLCBExsyNQEY2zbJ5O0
         o7bGbrmV0ylO0fucWboS6S88w5qDTacrFH/e2nE1Jh+LMtnBT3/57r/UZ/YDfMdY/uit
         Ei04e8/KvplApgS8tY2DXb6EgeCo3bCdUpDdubnnBLx7rI3FhPb7BMS/MLxoqTTWoBxc
         IURw==
X-Gm-Message-State: AJaThX73Vsu0xzimsQQpq605apnDLJ+6QjgSPa8s7hmTjwbkeGiCUdAo
        8zre2aLShhSi07py8eyr65E7PYli
X-Google-Smtp-Source: AGs4zMbdXV+Ob/jupvA0V08N4w1s59Sp55TzFdef7U1WIJgA3OuuZ//NYI9pWc6y6W1SDAw10CL/0g==
X-Received: by 10.107.47.38 with SMTP id j38mr8228984ioo.22.1511213181743;
        Mon, 20 Nov 2017 13:26:21 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id y198sm4866769iod.50.2017.11.20.13.26.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Nov 2017 13:26:21 -0800 (PST)
Date:   Mon, 20 Nov 2017 13:26:19 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>
Subject: [PATCH 5/8] connect: split ssh option computation to its own function
Message-ID: <20171120212619.nqtijn5ygypixmw6@aiede.mtv.corp.google.com>
References: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This puts the determination of options to pass to each ssh variant
(see ssh.variant in git-config(1)) in one place.

A follow-up patch will use this in an initial dry run to detect which
variant to use when the ssh command is ambiguous.

No functional change intended yet.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Split out to make patch 6 easier to read, as suggested at
https://public-inbox.org/git/xmqq60b59toe.fsf@gitster.mtv.corp.google.com/.

Added a function comment to make the purpose and API of this internal
helper clearer.

 connect.c | 65 ++++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/connect.c b/connect.c
index a9dc493db2..d2fbb15cc5 100644
--- a/connect.c
+++ b/connect.c
@@ -919,6 +919,42 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
 	return conn;
 }
 
+/*
+ * Append the appropriate environment variables to `env` and options to
+ * `args` for running ssh in Git's SSH-tunneled transport.
+ */
+static void push_ssh_options(struct argv_array *args, struct argv_array *env,
+			     enum ssh_variant variant, const char *port,
+			     int flags)
+{
+	if (variant == VARIANT_SSH &&
+	    get_protocol_version_config() > 0) {
+		argv_array_push(args, "-o");
+		argv_array_push(args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
+		argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
+				 get_protocol_version_config());
+	}
+
+	if (variant != VARIANT_SIMPLE) {
+		if (flags & CONNECT_IPV4)
+			argv_array_push(args, "-4");
+		else if (flags & CONNECT_IPV6)
+			argv_array_push(args, "-6");
+	}
+
+	if (variant == VARIANT_TORTOISEPLINK)
+		argv_array_push(args, "-batch");
+
+	if (port && variant != VARIANT_SIMPLE) {
+		if (variant == VARIANT_SSH)
+			argv_array_push(args, "-p");
+		else
+			argv_array_push(args, "-P");
+
+		argv_array_push(args, port);
+	}
+}
+
 /* Prepare a child_process for use by Git's SSH-tunneled transport. */
 static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
 			  const char *port, int flags)
@@ -947,34 +983,7 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
 	}
 
 	argv_array_push(&conn->args, ssh);
-
-	if (variant == VARIANT_SSH &&
-	    get_protocol_version_config() > 0) {
-		argv_array_push(&conn->args, "-o");
-		argv_array_push(&conn->args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
-		argv_array_pushf(&conn->env_array, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
-				 get_protocol_version_config());
-	}
-
-	if (variant != VARIANT_SIMPLE) {
-		if (flags & CONNECT_IPV4)
-			argv_array_push(&conn->args, "-4");
-		else if (flags & CONNECT_IPV6)
-			argv_array_push(&conn->args, "-6");
-	}
-
-	if (variant == VARIANT_TORTOISEPLINK)
-		argv_array_push(&conn->args, "-batch");
-
-	if (port && variant != VARIANT_SIMPLE) {
-		if (variant == VARIANT_SSH)
-			argv_array_push(&conn->args, "-p");
-		else
-			argv_array_push(&conn->args, "-P");
-
-		argv_array_push(&conn->args, port);
-	}
-
+	push_ssh_options(&conn->args, &conn->env_array, variant, port, flags);
 	argv_array_push(&conn->args, ssh_host);
 }
 
-- 
2.15.0.448.gf294e3d99a

