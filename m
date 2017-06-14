Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 365F120282
	for <e@80x24.org>; Wed, 14 Jun 2017 15:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752225AbdFNPCC (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 11:02:02 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35545 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752062AbdFNPCB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 11:02:01 -0400
Received: by mail-wr0-f195.google.com with SMTP id z45so762560wrb.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 08:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zX2knh5B1PruYFGc0d1J4xTHCEjVvxvcDYHCGla4WNA=;
        b=fzBJ6bFGS01Z/tMYlgiXb0LtHS+TghI+HQs6TzS9T2ZP7xjBtzmCmP+ZkQIyOolLAV
         yQpbi5aNREMFP+arjkvFnF02RXCdtky4G+TMHgA/TB73ArE7XCfl9n6eoyJvwbzo7UpG
         ylxz1Cla0FVWUMGueNIE52sZKtXktnSOxBgmnURZmEfvlGJzjwtOPIpgNmJeIWaMCeVb
         Lo+dCfoH3Nzz03zgZPyW2A7ZaNKfOaJzU/8KZF73Qy8PdIU2bYFyp5JXqQp/QFzPjWpt
         2Q/HmStbj7HDUdlP0NpP/rjN1BsJWoXmRRbXrKrssHjQBWDtgIMml1aTrqyGjTWQyG0y
         /jQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zX2knh5B1PruYFGc0d1J4xTHCEjVvxvcDYHCGla4WNA=;
        b=sRjAPT25Q8u9EJUvE56FULjdNykqOOrEev4y25hRTOEA7uQDaKZDSACMNgMnbwEda+
         EPI5I0VDTotFiDyqShznDvGw1kt2CT2tutfJDxgz3TcWmBp/rLcwI6VQDC0LjNSsW4mD
         fbjh9PaLZiVmv6rZezauFP6SPTGNWqxgamO63Jf5rkTkLEuCQOhDCu8pKmFywncD3ARX
         kyInjY0cq4QOphupB5qDObm3rtcOKfjicz7rnzxjzVkLpmpm2Dk/ieF+gejpoSSAtEfB
         NOIVHa3lYpT2EhRISLwnwaa9NkrYemx80wog2m++7aTRAVpBqb5g/kOEL7/ZXUZS6iVk
         RzqQ==
X-Gm-Message-State: AKS2vOwDF/7q2WEl+K6/Ib5AYRYKZ+R56scsUdUpCbRHc9HNb55xMX+k
        g33Q0eTDsNqXMy9b
X-Received: by 10.223.142.150 with SMTP id q22mr362907wrb.180.1497452519300;
        Wed, 14 Jun 2017 08:01:59 -0700 (PDT)
Received: from christian-Latitude-E6330.booking.pcln.com ([185.24.142.26])
        by smtp.gmail.com with ESMTPSA id z194sm179767wmc.31.2017.06.14.08.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Jun 2017 08:01:58 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] builtin/clone: get rid of 'value' strbuf
Date:   Wed, 14 Jun 2017 17:01:48 +0200
Message-Id: <20170614150148.29298-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.453.g04e95ab038
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the code simpler by removing a few lines, and getting
rid of one variable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/clone.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index a2ea019c59..370a233d22 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -870,7 +870,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	const struct ref *our_head_points_at;
 	struct ref *mapped_refs;
 	const struct ref *ref;
-	struct strbuf key = STRBUF_INIT, value = STRBUF_INIT;
+	struct strbuf key = STRBUF_INIT;
 	struct strbuf branch_top = STRBUF_INIT, reflog_msg = STRBUF_INIT;
 	struct transport *transport = NULL;
 	const char *src_ref_prefix = "refs/heads/";
@@ -1035,7 +1035,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
 	}
 
-	strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
 	strbuf_addf(&key, "remote.%s.url", option_origin);
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
@@ -1049,10 +1048,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
 
-	fetch_pattern = value.buf;
+	fetch_pattern = xstrfmt("+%s*:%s*", src_ref_prefix, branch_top.buf);
 	refspec = parse_fetch_refspec(1, &fetch_pattern);
-
-	strbuf_reset(&value);
+	free((char *)fetch_pattern);
 
 	remote = remote_get(option_origin);
 	transport = transport_get(remote, remote->url[0]);
@@ -1191,7 +1189,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_top);
 	strbuf_release(&key);
-	strbuf_release(&value);
 	junk_mode = JUNK_LEAVE_ALL;
 
 	free(refspec);
-- 
2.13.1.453.g04e95ab038

