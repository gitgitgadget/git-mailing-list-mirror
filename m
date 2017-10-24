Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A77501FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 18:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbdJXS7a (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 14:59:30 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:56546 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbdJXS71 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 14:59:27 -0400
Received: by mail-io0-f196.google.com with SMTP id m81so24969409ioi.13
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 11:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3yXTDVmj2NZ+bb/q+I1Sw4anPD/NhtFHKX5u1L8rCIE=;
        b=f3sNWDhY3c2cbeKJiEElMTLn8OM9GHTqZHvmb45rD2uy5myim46dExldjkJuSmcfFb
         tobZXaJdRBRY216l37l/W5NhPLBNLv6D7sXpvrqZfu/oY1wuf4z3f3/dnH1uR85Wn+R6
         M72V76YLinDkbiMBNkXv7MdGGaEBTgJxQ4sEQVKtROoDP5XUayoT5GfbmtM9uG4zqsod
         OIjLbHsAYDlZqssJjgGtue98thUUIE7kKjlAIfa3zsufppzmVuDdS3UtIxDj7mhoyMa7
         h1IuNXPMUtgybxvS+i2sxqPbuhVjl56im6OekDAM0rQbIfEj/EQi4jlTr05vMGAz/SYb
         zrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3yXTDVmj2NZ+bb/q+I1Sw4anPD/NhtFHKX5u1L8rCIE=;
        b=LFm4aKcv8myoF4CsE9pU5B/jCylcHfJ1ptVAfORW/sNI14XRfBn2JMgR1ty/1gxwGb
         2eSUzeIW8S/cz2ftzqTw213Cs0zw5XLkZVnKjuI4aHsgKFJrjM+vn0t0Fse/q/8yJnov
         MXKXjRlPdh55sczGn+yMJgkPBXGW0R7d2BiTGvGAvTz9l3Rb2m/06AW3816MHyq/HPcU
         rdaI9rDiietLewb/Efb18QZJaauUVWjZFXbKRfBgEuphx79xQ8QxAHv79dMZqsSfM7Yt
         rYtx7p4E1ltaAYdaybHOjThIdbucpnf1Ul6roAB6eWykt9ac7voMorXe/vhiadLVF021
         ydAg==
X-Gm-Message-State: AMCzsaVesRxe4NGS4BHW9S7IeL5zwrJ3gI8hP8zggyxbZoS/EPVhkCeM
        vcFUuZy9otfR0w0bS1bAWldUSQNYdqs=
X-Google-Smtp-Source: ABhQp+SKQ+AaS6zI2lH5+rnqIBbudctPZi5Il84DJAYjSaMpSkAxt/pI02t1wT3rQiyxlQTq+0GoMA==
X-Received: by 10.107.181.215 with SMTP id e206mr22595746iof.98.1508871565840;
        Tue, 24 Oct 2017 11:59:25 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:24db:446:6fc5:b25b])
        by smtp.gmail.com with ESMTPSA id y198sm372452iod.50.2017.10.24.11.59.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Oct 2017 11:59:24 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/4] xdiff-interface: export comparing and hashing strings
Date:   Tue, 24 Oct 2017 11:59:15 -0700
Message-Id: <20171024185917.20515-3-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.6.g953226eb5f
In-Reply-To: <20171024185917.20515-1-sbeller@google.com>
References: <20171024185917.20515-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will turn out to be useful in a later patch

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 xdiff-interface.c | 11 +++++++++++
 xdiff-interface.h |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index 018e033089..fd002ebbc2 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -5,6 +5,7 @@
 #include "xdiff/xdiffi.h"
 #include "xdiff/xemit.h"
 #include "xdiff/xmacros.h"
+#include "xdiff/xutils.h"
 
 struct xdiff_emit_state {
 	xdiff_emit_consume_fn consume;
@@ -296,6 +297,16 @@ void xdiff_clear_find_func(xdemitconf_t *xecfg)
 	}
 }
 
+unsigned long xdiff_hash_string(const char *s, size_t len, long flags)
+{
+	return xdl_hash_record(&s, s + len, flags);
+}
+
+int xdiff_compare_lines(const char *l1, long s1, const char *l2, long s2, long flags)
+{
+	return xdl_recmatch(l1, s1, l2, s2, flags);
+}
+
 int git_xmerge_style = -1;
 
 int git_xmerge_config(const char *var, const char *value, void *cb)
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 6f6ba9095d..d3cb9285c5 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -29,4 +29,9 @@ extern void xdiff_clear_find_func(xdemitconf_t *xecfg);
 extern int git_xmerge_config(const char *var, const char *value, void *cb);
 extern int git_xmerge_style;
 
+extern int xdiff_compare_lines(const char *l1, long s1,
+			       const char *l2, long s2, long flags);
+
+extern unsigned long xdiff_hash_string(const char *s, size_t len, long flags);
+
 #endif
-- 
2.15.0.rc2.6.g953226eb5f

