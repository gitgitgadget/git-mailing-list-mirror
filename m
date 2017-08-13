Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53BBB1F667
	for <e@80x24.org>; Sun, 13 Aug 2017 19:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751500AbdHMTgd (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 15:36:33 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35044 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbdHMTg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2017 15:36:28 -0400
Received: by mail-it0-f68.google.com with SMTP id 76so6811443ith.2
        for <git@vger.kernel.org>; Sun, 13 Aug 2017 12:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Av/mID1bFcOUBABxt27no34EJHXtiLqCijBLDeHbQhg=;
        b=afbTl8MOBeum/lC0NAENWMZn0P74iUMH+qKDG00D6ED/w0AWILomND1w4FOdkmIH9u
         rlyR/1fXbMb0sFFEWk4vDdZUaWixqeLqpPTCDAOrWS/Q74DFnwBlkmHRfD0hNAmHF5Oc
         bwmqrXoqgf4IW7/NbHEYw7+/Xs4eBJHT++ek+GNwvJCVZRDj/s4wwzpFQyWWuiaDZ30J
         A/HaPiF9dsbxeK8ZxxhJvSYw8S8KLaQEaKrFR2IHNtTMh5NlCiHjsK9wEKXUjXFMYHOM
         TkLoHPCwVs5TV6DUwTACseexLcx5DRxTuwst7m3wzOWHBSzDXqdoojPQqutaHDBCpiey
         AEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Av/mID1bFcOUBABxt27no34EJHXtiLqCijBLDeHbQhg=;
        b=bHjctmKV6L/YL2KYBfQXCoICfxQu0a/LYYaEh214ifTjHc9rS4ZR72Y7ehxFXM3s8u
         43+0bk32vR1bCF866rWbCT3AojQZhE30BLlGhA8tyOLo/Fe7WTwdtH+fMPO+RJDtIWBL
         PKLNFmTlpCjUZhIrj/hl3OTclQBuFX7Y5e/bDF0wMbLI4sF4Anqn07Zj2jsJj50NfBLK
         k+h3/RirOSuGHY1Qp5gdV4qOxtNFjGlSSGLztY7N9j0lnOLHjagha0jbzQP6qnJNSyBP
         8A7NijaCzaSUNOYDHhN37iSIF9SR2PPM4HQQorgbdEv/cRTLnRhEz8EuZUaGPWF93yTy
         qHzA==
X-Gm-Message-State: AHYfb5jQhHLUCzcw5IlBmWp55TlmPK2LTbHYJ8CIR96fKv/lRO9t8+8u
        iWEHVZZ9cWAKXTCNj2g=
X-Received: by 10.36.46.13 with SMTP id i13mr3825514ita.124.1502652987530;
        Sun, 13 Aug 2017 12:36:27 -0700 (PDT)
Received: from localhost.localdomain ([192.252.136.182])
        by smtp.gmail.com with ESMTPSA id s66sm2045678ita.9.2017.08.13.12.36.26
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Aug 2017 12:36:27 -0700 (PDT)
From:   Richard Maw <richard.maw@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 4/7] Autocreate reflogs for namespaced refs
Date:   Sun, 13 Aug 2017 20:36:08 +0100
Message-Id: <20170813193611.4233-5-richard.maw@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170813193611.4233-1-richard.maw@gmail.com>
References: <20170813193611.4233-1-richard.maw@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since refs are classified based on their prefix
but namespaces have their own prefix,
it's necessary to skip that prefix to classify their remaining prefix.
---
 refs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/refs.c b/refs.c
index ba22f4a..2e8bace 100644
--- a/refs.c
+++ b/refs.c
@@ -699,6 +699,7 @@ int should_autocreate_reflog(const char *refname)
 	case LOG_REFS_ALWAYS:
 		return 1;
 	case LOG_REFS_NORMAL:
+		(void) skip_namespace(refname, &refname);
 		return starts_with(refname, "refs/heads/") ||
 			starts_with(refname, "refs/remotes/") ||
 			starts_with(refname, "refs/notes/") ||
-- 
2.9.0

