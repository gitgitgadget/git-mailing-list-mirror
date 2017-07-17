Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22AAD20357
	for <e@80x24.org>; Mon, 17 Jul 2017 15:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbdGQPgQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 11:36:16 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35355 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbdGQPgO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 11:36:14 -0400
Received: by mail-pf0-f181.google.com with SMTP id e199so17102533pfh.2
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 08:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=huGhFcaR8NsaqO5Tq7kSSItu4oct03gy86noxF2zFDg=;
        b=NF0dsqnufAwyqVzB6JJrpFKzxnR/zbEQeupmO8pkbep/fh2FeR8/WZQNP/uTDnCMAj
         2mYucKIUdIQtWxJH1X4uGtyTRQUrpYwwk6rzweYEITclf9EKtfgMWZXlGygDthjaB5OM
         EXS4i4pIjBzgtTSHAy+laHkSK9Wa6bkA9i/YeEVfaHdIYlKkQIAMhawVNPts6/YX5EiV
         +8NtNOxxAN2nRXIcWm7C8Iq2r+T8ftYRbyiBs1mM9zYKAD+dSNFbH981EbU1CgmYAlTu
         yTA8MbRZPVXTcuvJuLVS0EJvsrMI9GxJZlcTIqSVPkv3QOm7XCgYX7SEmeGrCmL1/Gck
         3sCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=huGhFcaR8NsaqO5Tq7kSSItu4oct03gy86noxF2zFDg=;
        b=e8lP+GcN/+BJXvxB/n7YcygZU++B5cnRrvRAUvZIAWn4Fz78h0tpd2zcjEaOEe4xmi
         1Wl/bKmUKCaUSED9EwjtAZAC0D3sZoYfC/NIkfgK8o1CwBzV1Mdns4WkVpkgvzxSD1Pn
         TZUtyxXAsr8L1xQzfoRc5+6Uc+avcIUwGZdzrmpmAawgpkgReqb2CrvNtMA+Lbw+r+w4
         gENzS/gZXmESPYwbbafjKV0l64JO3Y00JVtjzEBjMOud2v7MiBqNsjgbzKUvwyhRfvgO
         6Xxft/vWAlO19u5EV8E/wYd+xTME5375GU9bDtI2JG0dzKSg758vHBVSxHsOgrSVyw86
         xihQ==
X-Gm-Message-State: AIVw113orHnfxrVP4O5olcnQUnnfGzwQORsQ4Nz54RUbTn/d1Qoqf5h2
        Nk4qA4IfIr9vcw==
X-Received: by 10.98.76.17 with SMTP id z17mr9875341pfa.136.1500305774282;
        Mon, 17 Jul 2017 08:36:14 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7003:dd63:70be:8c6f:6f19:1db1])
        by smtp.gmail.com with ESMTPSA id j27sm30803084pgn.63.2017.07.17.08.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jul 2017 08:36:13 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH] commit: check for empty message before the check for untouched template
Date:   Mon, 17 Jul 2017 21:06:15 +0530
Message-Id: <20170717153615.16252-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.13.3.973.gaaf39e6bd.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The check for whether the template given to 'git commit' is untouched
is done before the empty message check. This results in a wrong error
message being displayed in the following case. When the user removes
everything in template completely to abort the commit he is shown the
"template untouched" error which is wrong. He should be shown the
"empty message" error.

Do the empty message check before checking for an untouched template
thus fixing this issue.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 builtin/commit.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index aff6bf7aa..9c299d792 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1736,19 +1736,19 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (verbose || /* Truncate the message just before the diff, if any. */
 	    cleanup_mode == CLEANUP_SCISSORS)
 		strbuf_setlen(&sb, wt_status_locate_end(sb.buf, sb.len));
-
 	if (cleanup_mode != CLEANUP_NONE)
 		strbuf_stripspace(&sb, cleanup_mode == CLEANUP_ALL);
-	if (template_untouched(&sb) && !allow_empty_message) {
-		rollback_index_files();
-		fprintf(stderr, _("Aborting commit; you did not edit the message.\n"));
-		exit(1);
-	}
+
 	if (message_is_empty(&sb) && !allow_empty_message) {
 		rollback_index_files();
 		fprintf(stderr, _("Aborting commit due to empty commit message.\n"));
 		exit(1);
 	}
+	if (template_untouched(&sb) && !allow_empty_message) {
+		rollback_index_files();
+		fprintf(stderr, _("Aborting commit; you did not edit the message.\n"));
+		exit(1);
+	}
 
 	if (amend) {
 		const char *exclude_gpgsig[2] = { "gpgsig", NULL };
-- 
2.13.3.973.gaaf39e6bd.dirty

