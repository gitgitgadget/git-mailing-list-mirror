Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55755C433E1
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31E8C20709
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVDIezmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgEOKF3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 06:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgEOKF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 06:05:26 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C96C05BD09
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f13so1689809wmc.5
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=friTYmnGhW5bqnhTppOnCfdbrBVFGESA+3rhTEdSCEk=;
        b=aVDIezmMXrcVCdsvxBX6PnQU7r2FP2YGSVeGxGpws6qScxEsvR1TumEFvChZ1X6j/S
         XV2O9ZM8KmsgdntD+Azhnmv/JcR2INq1DFQVjUD8R/K8PdPAfxSO0Jba8PF+Q7PPfn8/
         YGLgtIrix7U+1S8IS7onzkp9AgSu+VK535lKX8WUjOmMn7dCxDFKgzSxpAxpECSjKhSx
         1geEss3y7xCnuSr90cLDPkgktp/E428LRz+4fa/EqJgcj8bkEWsKAwK3of6r/chXBm0r
         fCSuhPUh7TbggPTAUNy6gxLgKqcNUY6v/T0t1bKQ7BRV76HrZriPtDGUbqeZbYws4ZB+
         5q8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=friTYmnGhW5bqnhTppOnCfdbrBVFGESA+3rhTEdSCEk=;
        b=CnBOXKlNu+l+CSP4IHwoI3NsXYFkjIsMjQx7u9ebrvqgUg/Fnfg+bA9z019r/zTHWH
         m+k5OOtb22MIzT8KSApqjzzrM0nD4YAX1aaJWRy62JHs27AoNZL3qJi116oiNu97vYpC
         e/WiGaaIA2RGx1zNC54W5e9itSpxMUvilrmq9oRR9OAleIlOJE0+QtACD+cFSwUSwNUV
         blQ2KmYqdsV/sXC6PuzQu318eXE2nr+62uXGuwH0PXpTe1IElwG4NuOL1Ml0D6fMB+nA
         HxTdJM+tNAuZsyd/63oKzpCIcwQjXvjZZzmG3oz7NSgMuC0A4Zg2ZtCyNuDrszOGgJOx
         6LBA==
X-Gm-Message-State: AOAM530pui9920Hc/P6/Llsy7FK4tqWqFSfqG2hJfgmhoeoAdNtpptGx
        SoUQD5MT+f4prI66Juitq6rSXVNAcEE=
X-Google-Smtp-Source: ABdhPJyO1kVvQ8QADmqjfBpahBfK5cL1irTx5554SPBRGdcbbXB1JmaCDDuuDsOe9M9HAyAkF8YO4A==
X-Received: by 2002:a1c:bbc4:: with SMTP id l187mr3312547wmf.183.1589537122709;
        Fri, 15 May 2020 03:05:22 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.171])
        by smtp.gmail.com with ESMTPSA id m3sm2792326wrn.96.2020.05.15.03.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:05:22 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 11/13] upload-pack: remove static variable 'stateless_rpc'
Date:   Fri, 15 May 2020 12:04:52 +0200
Message-Id: <20200515100454.14486-12-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.26.2.639.gb7dde20fdf
In-Reply-To: <20200515100454.14486-1-chriscool@tuxfamily.org>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
more thoroughly, let's remove the 'stateless_rpc' static
variable, as we can now use the field of 'struct upload_pack_data'
with the same name instead.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 680c38cc13..4ac40c5b04 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -63,7 +63,6 @@ static int keepalive = 5;
  * otherwise maximum packet size (up to 65520 bytes).
  */
 static int use_sideband;
-static int stateless_rpc;
 static const char *pack_objects_hook;
 
 static int filter_capability_requested;
@@ -449,7 +448,7 @@ static int get_common_commits(struct upload_pack_data *data,
 				packet_write_fmt(1, "ACK %s\n", last_hex);
 				return 0;
 			}
-			if (stateless_rpc)
+			if (data->stateless_rpc)
 				exit(0);
 			got_common = 0;
 			got_other = 0;
@@ -663,7 +662,8 @@ static void check_non_tip(struct upload_pack_data *data)
 	 * uploadpack.allowReachableSHA1InWant,
 	 * non-tip requests can never happen.
 	 */
-	if (!stateless_rpc && !(allow_unadvertised_object_request & ALLOW_REACHABLE_SHA1))
+	if (!data->stateless_rpc
+	    && !(allow_unadvertised_object_request & ALLOW_REACHABLE_SHA1))
 		goto error;
 	if (!has_unreachable(&data->want_obj))
 		/* All the non-tip ones are ancestors of what we advertised */
@@ -1074,7 +1074,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 				     " allow-tip-sha1-in-want" : "",
 			     (allow_unadvertised_object_request & ALLOW_REACHABLE_SHA1) ?
 				     " allow-reachable-sha1-in-want" : "",
-			     stateless_rpc ? " no-done" : "",
+			     data->stateless_rpc ? " no-done" : "",
 			     symref_info.buf,
 			     allow_filter ? " filter" : "",
 			     git_user_agent_sanitized());
@@ -1149,7 +1149,6 @@ void upload_pack(struct upload_pack_options *options)
 	struct packet_reader reader;
 	struct upload_pack_data data;
 
-	stateless_rpc = options->stateless_rpc;
 	timeout = options->timeout;
 	daemon_mode = options->daemon_mode;
 
@@ -1157,9 +1156,11 @@ void upload_pack(struct upload_pack_options *options)
 
 	upload_pack_data_init(&data);
 
+	data.stateless_rpc = options->stateless_rpc;
+
 	head_ref_namespaced(find_symref, &data.symref);
 
-	if (options->advertise_refs || !stateless_rpc) {
+	if (options->advertise_refs || !data.stateless_rpc) {
 		reset_timeout();
 		head_ref_namespaced(send_ref, &data);
 		for_each_namespaced_ref(send_ref, &data);
-- 
2.26.2.638.gb2c16ea67b.dirty

