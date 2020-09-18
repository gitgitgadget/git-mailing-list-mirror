Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A65C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 04:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0429B2100A
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 04:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADB7QniC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgIREvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 00:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgIREvA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 00:51:00 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BFCC06174A
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 21:51:00 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id r19so2344736pls.1
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 21:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mV59WNovYrBtsFtagldh691go5Qt6QFxT9YUKVu/XdI=;
        b=ADB7QniCdaA2EWBhik3Vp3LGUEzVHsEQd+DguDQsEe2fJuO716+P1TTQ7JTjYnDo2c
         w399mdG1GlHpZ+xter5yV6PQwkia+Mj5AYx7WtkHVnXbANmoOcYCBssAD+sEMDIJp9B8
         yWnRoXJXED1EllNFuPrc77D73xYAoh7IcU4Qf1XcY1vCfidVnGxm2+XJbIjMBqiJvOOU
         L1bEQXgYArgWIJK3IVszpkBTGMYmqMhUmlN4fVXspbvS9sE4MrYIAEi4vnzb/PXl1u7F
         ea6Nl8C/GptyMBYA1O9E4oexY3zZMNkwJIlP6usMYW1/76RCLiBNORTTWgOvo3tzwtUL
         oNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mV59WNovYrBtsFtagldh691go5Qt6QFxT9YUKVu/XdI=;
        b=Z6VTdtNxpnkqybrSZtykHezatr0MZf3A181LBNqIkmeQe4qPDQrCF5ep+IOpF9olfG
         oV4Ore+nTtltnvWSNNyWFtlDPBOA6fwToH/KuHuAGHvyTPK6DdqAApZszjftzmn8MYaJ
         SvPVaY/l3naIUihQfCKID3skWZjMqPDvmNIXhS0hdfqzd7evAGuVBJspohduY3m1L39m
         hnD80kiF4eMFgl6hP8e4ckefWfrLSTn/mFmJTjsQKspFNrVi2jhLMzeROek1CuKOR2c+
         JQMuJGe2fFAhXnnPbmpJuuE6osCb4gsoDd+tA2lkatUDWs/Xdm/Xn6mkSN8wQMc0tDPt
         wWlw==
X-Gm-Message-State: AOAM532CmNINODpKuaJ50itYwZ1mIGPNzfOVtmZ2kPDyeHPN7JH99Moz
        C3ytMI9MkYZDvQOM+dVgW8OZN5hvFWgsAJl6+uQ=
X-Google-Smtp-Source: ABdhPJzoYuBDq5d1iovOK71QXHTeXbfIUm8TQavpJxzkebfOjxiyL1tB5Vea1hKB9PfAxg2r+jCu7A==
X-Received: by 2002:a17:90a:f486:: with SMTP id bx6mr11117339pjb.130.1600404659702;
        Thu, 17 Sep 2020 21:50:59 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.85])
        by smtp.gmail.com with ESMTPSA id e125sm1409200pfe.154.2020.09.17.21.50.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 21:50:59 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
X-Google-Original-From: Han Xin <hanxin.hx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2] send-pack: run GPG after atomic push checking
Date:   Fri, 18 Sep 2020 12:50:52 +0800
Message-Id: <20200918045052.13022-1-hanxin.hx@alibaba-inc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <xmqqv9gdthgj.fsf@gitster.c.googlers.com>
References: <xmqqv9gdthgj.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The refs update commands can be sent to the server side in two different
ways: GPG-signed or unsigned.  We should run these two operations in the
same "Finally, tell the other end!" code block, but they are seperated
by the "Clear the status for each ref" code block.  This will result in
a slight performance loss, because the failed atomic push will still
perform unnecessary preparations for shallow advertise and GPG-signed
commands buffers.

Add a new test case to t5534 to ensure GPG will not be called when the
GPG-signed atomic push fails.

Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 send-pack.c            | 58 ++++++++++++++++++++++--------------------
 t/t5534-push-signed.sh | 21 +++++++++++++++
 2 files changed, 51 insertions(+), 28 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index d671ab5d05..f227b7315e 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -244,7 +244,12 @@ static int check_to_send_update(const struct ref *ref, const struct send_pack_ar
 		return CHECK_REF_STATUS_REJECTED;
 	case REF_STATUS_UPTODATE:
 		return CHECK_REF_UPTODATE;
+
 	default:
+	case REF_STATUS_EXPECTING_REPORT:
+		/* already passed checks on the local side */
+	case REF_STATUS_OK:
+		/* of course this is OK */
 		return 0;
 	}
 }
@@ -447,13 +452,6 @@ int send_pack(struct send_pack_args *args,
 		if (ref->deletion && !allow_deleting_refs)
 			ref->status = REF_STATUS_REJECT_NODELETE;
 
-	if (!args->dry_run)
-		advertise_shallow_grafts_buf(&req_buf);
-
-	if (!args->dry_run && push_cert_nonce)
-		cmds_sent = generate_push_cert(&req_buf, remote_refs, args,
-					       cap_buf.buf, push_cert_nonce);
-
 	/*
 	 * Clear the status for each ref and see if we need to send
 	 * the pack data.
@@ -489,31 +487,35 @@ int send_pack(struct send_pack_args *args,
 			ref->status = REF_STATUS_EXPECTING_REPORT;
 	}
 
+	if (!args->dry_run)
+		advertise_shallow_grafts_buf(&req_buf);
+
 	/*
 	 * Finally, tell the other end!
 	 */
-	for (ref = remote_refs; ref; ref = ref->next) {
-		char *old_hex, *new_hex;
-
-		if (args->dry_run || push_cert_nonce)
-			continue;
-
-		if (check_to_send_update(ref, args) < 0)
-			continue;
-
-		old_hex = oid_to_hex(&ref->old_oid);
-		new_hex = oid_to_hex(&ref->new_oid);
-		if (!cmds_sent) {
-			packet_buf_write(&req_buf,
-					 "%s %s %s%c%s",
-					 old_hex, new_hex, ref->name, 0,
-					 cap_buf.buf);
-			cmds_sent = 1;
-		} else {
-			packet_buf_write(&req_buf, "%s %s %s",
-					 old_hex, new_hex, ref->name);
+	if (!args->dry_run && push_cert_nonce)
+		cmds_sent = generate_push_cert(&req_buf, remote_refs, args,
+					       cap_buf.buf, push_cert_nonce);
+	else if (!args->dry_run)
+		for (ref = remote_refs; ref; ref = ref->next) {
+			char *old_hex, *new_hex;
+
+			if (check_to_send_update(ref, args) < 0)
+				continue;
+
+			old_hex = oid_to_hex(&ref->old_oid);
+			new_hex = oid_to_hex(&ref->new_oid);
+			if (!cmds_sent) {
+				packet_buf_write(&req_buf,
+						 "%s %s %s%c%s",
+						 old_hex, new_hex, ref->name, 0,
+						 cap_buf.buf);
+				cmds_sent = 1;
+			} else {
+				packet_buf_write(&req_buf, "%s %s %s",
+						 old_hex, new_hex, ref->name);
+			}
 		}
-	}
 
 	if (use_push_options) {
 		struct string_list_item *item;
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 030331f1c5..a8638f16be 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -273,4 +273,25 @@ test_expect_success GPGSM 'fail without key and heed user.signingkey x509' '
 	test_cmp expect dst/push-cert-status
 '
 
+test_expect_success GPG 'failed atomic push does not execute GPG' '
+	prepare_dst &&
+	git -C dst config receive.certnonceseed sekrit &&
+	write_script gpg <<-EOF &&
+	# should check atomic push locally before running GPG.
+	exit 1
+	EOF
+	test_must_fail env PATH="$TRASH_DIRECTORY:$PATH" git push \
+			--signed --atomic --porcelain \
+			dst noop ff noff >out 2>&1 &&
+	sed -n -e "/^To dst/,$ p" out >actual &&
+	cat >expect <<-EOF &&
+	To dst
+	=	refs/heads/noop:refs/heads/noop	[up to date]
+	!	refs/heads/ff:refs/heads/ff	[rejected] (atomic push failed)
+	!	refs/heads/noff:refs/heads/noff	[rejected] (non-fast-forward)
+	Done
+	EOF
+	test_i18ncmp expect actual
+'
+
 test_done
-- 
2.28.0

