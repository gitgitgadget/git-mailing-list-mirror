Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4624C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjBBJpb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjBBJpP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:45:15 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2A088CCF
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:44:36 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id o18so1135319wrj.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybrOW28B1qf/T6oBOxjTGvJfSqc+Ur+JsXhIiwdiLkQ=;
        b=IoZ3HMvkKpnHk0uTP2x+cNySxyRYY39ZWYHwh1Jiv4npPczf3W5PtZw3r/bCblYfBY
         2bQMxIiyrI8xQvH5LXsdJpwM9k0EeBbQziJq05too3F7QFmlr1ADHF3g+hhllNQ2cOqe
         0c6sOVB4gCKAc+fN+wVegzib7DZS5rPv0OB5G0phyRTHYRw12w8mvi8QGopLhAREz25i
         sGfOqVUNRSwgqitPutn/deoEWMgw9miljHMu22kHGgHN7xhSzGLVW7CaMRgNxDh7vIPO
         0Ra7f4xZPrbfGG/MUDFpQI8aPsCQoHGrwEu6+CDUEUj4wT6CEzBX6v4ih2TkAQp2gmuB
         xKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybrOW28B1qf/T6oBOxjTGvJfSqc+Ur+JsXhIiwdiLkQ=;
        b=cpCNyJj5AmTj8D0Il2zGsDMHhXI/F0KvYxVEORKm006vLioTYFl15SZg7ZRT3IOU1y
         u+4cciM26Kp9zABqZCpo7oQ/RRMuEUgSKBkfk41vvy8WFSLbU+urDKqnH3GghRYmpQwU
         iSg5ycaAvLpk4gV54FWD2BlVGNgYssQlLbk7CisIT8Es61b32gCPmUWYFbBHz9JilRHw
         k2cXKocDw10+1BdceFjHfq3q8kQT2R4yVmEq8ZqoTqLC3s83pXx6cYeNjvwYyIl0PAUL
         JxYyx/fqy4/HWIzCnGdgLjq9GcyfLUJnKfZqW1BdHLjiqjYMQh8pi2zbVV0Gv+uoHnLq
         73dw==
X-Gm-Message-State: AO0yUKX04HZ0YQ4/OivdzFgF2V+M/8oIxiJ2p10fwDkRKTQdXjCzs/dd
        WNNu/vsDSj8MFWbIO2AY4mTCL3IFilbiHF76
X-Google-Smtp-Source: AK7set9kpl9tzm6jQ9ljgnpsNUsxCxIdi2XY0q87gI6sHlBw8GU3buiPYXXx/Tu2e6uIdDNoZVZY2w==
X-Received: by 2002:adf:fccb:0:b0:2bf:ae19:d8e4 with SMTP id f11-20020adffccb000000b002bfae19d8e4mr5354221wrs.16.1675331067194;
        Thu, 02 Feb 2023 01:44:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600010ce00b0029e1aa67fd2sm19487938wrx.115.2023.02.02.01.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:44:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/6] imap-send: make --curl no-optional
Date:   Thu,  2 Feb 2023 10:44:15 +0100
Message-Id: <patch-v2-4.6-e9cc9bbed1e-20230202T093706Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the preceding commit the old "USE_CURL_FOR_IMAP_SEND" define became
always true, as we now require libcurl for git-imap-send.

But as we require OpenSSL for the "tunnel" mode we still need to keep
the OpenSSL codepath around (ee [1] for an attempt to remove it). But
we don't need to keep supporting "--no-curl" to bypass the curl
codepath for the non-tunnel mode.

As almost all users of "git" use a version of it built with libcurl
we're making what's already the preferred & default codepath
mandatory.

The "imap.authMethod" documentation being changed here has always been
incomplete. It only mentioned "--no-curl", but omitted mentioning that
the same applied for "imap.tunnel". Let's fix it as we're amending it
to be correct, now (as before) with "imap.tunnel" only
"imap.authMethod=CRAM-MD5" is supported.

1. https://lore.kernel.org/git/ab866314-608b-eaca-b335-12cffe165526@morey-chaisemartin.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/imap.txt   |  4 ++--
 Documentation/git-imap-send.txt | 10 ----------
 imap-send.c                     | 15 ++++-----------
 3 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/Documentation/config/imap.txt b/Documentation/config/imap.txt
index 7f30080c409..5cc46d87216 100644
--- a/Documentation/config/imap.txt
+++ b/Documentation/config/imap.txt
@@ -37,6 +37,6 @@ imap.preformattedHTML::
 
 imap.authMethod::
 	Specify authenticate method for authentication with IMAP server.
-	If you're running git-imap-send with the `--no-curl`
-	option, the only supported method is 'CRAM-MD5'. If this is not set
+	If you're using imap.tunnel, the only supported method is 'CRAM-MD5'.
+	If this is not set
 	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 202e3e59094..ddbbe819315 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -37,16 +37,6 @@ OPTIONS
 --quiet::
 	Be quiet.
 
---curl::
-	Use libcurl to communicate with the IMAP server, unless tunneling
-	into it.  Ignored if Git was built without the USE_CURL_FOR_IMAP_SEND
-	option set.
-
---no-curl::
-	Talk to the IMAP server using git's own IMAP routines instead of
-	using libcurl.
-
-
 CONFIGURATION
 -------------
 
diff --git a/imap-send.c b/imap-send.c
index 26f8f01e97a..9d7cb22285d 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -39,7 +39,7 @@ static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-
 
 static struct option imap_send_options[] = {
 	OPT__VERBOSITY(&verbosity),
-	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP server"),
+	OPT_HIDDEN_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP server"),
 	OPT_END()
 };
 
@@ -1519,12 +1519,8 @@ int cmd_main(int argc, const char **argv)
 	if (argc)
 		usage_with_options(imap_send_usage, imap_send_options);
 
-#if defined(NO_OPENSSL)
-	if (!use_curl) {
-		warning("--no-curl not supported in this build");
-		use_curl = 1;
-	}
-#endif
+	if (!use_curl)
+		die(_("the --no-curl option to imap-send has been deprecated"));
 
 	if (!server.port)
 		server.port = server.use_ssl ? 993 : 143;
@@ -1560,10 +1556,7 @@ int cmd_main(int argc, const char **argv)
 
 	/* write it to the imap server */
 
-	if (server.tunnel)
-		return append_msgs_to_imap(&server, &all_msgs, total);
-
-	if (use_curl)
+	if (!server.tunnel)
 		return curl_append_msgs_to_imap(&server, &all_msgs, total);
 
 	return append_msgs_to_imap(&server, &all_msgs, total);
-- 
2.39.1.1392.g63e6d408230

