Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D707BC433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE52B64E4B
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbhBQTpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbhBQTol (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:44:41 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FCDC0617A7
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:13 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id i23so18088048ejg.10
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uZoMQZJ4EmwofHfCZSJJDUCF2+sIzjjBgQ66TnJj+zk=;
        b=embHRSi5CovxS7ZmbctmuiF5UmAxxu60jxfY4EBmYrRrLhFXe3nVAwcTD103ovlQUX
         ak5Ift2HwVSkwdYB6EGs/v/ZfhstmUFqByVwcDbtswBBdkT8xi6XtbVHS7Jo7X5uzcOz
         UBRHaUdDMWwgghrswO+/kLwQn1DpfmngoPDRbcIV1m4tQN3x/ypN8EJDbpS8fM5oXijA
         nMy6/ECxbI+cjOF36fTKEQfSA0vsUunW2SNd3Nc757DEatfcQL7O1QSId7IEjXLhmJRo
         GTCV3QfpMPLGz/Rt/q4Ty7IjzqLMgw+1gKkk2uSYo7MVBDB5hExcR0e3TxmqbimMzeQE
         kXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uZoMQZJ4EmwofHfCZSJJDUCF2+sIzjjBgQ66TnJj+zk=;
        b=Ss2rB5eYo3DgDwgrUf6hQxXnbXc2gF5jPrwNrZRrxuHZW0/IIiwqr/yrtcxA65x+jm
         Av0EI0nPBhroJ+1QrW1s1pJ0ifQxLEX4hFrohIrFxNpWsJJrkLYFC4RpA3cTm8WWbb0s
         5XDLnZtBU+rCs4uZwhjTRzi6zD9+Aiau9LXSKbiEe2VcCcZzjsSeNPfYpWJ9wH1XGLFR
         X13uzvO4aTQUIj8K+Xz33oUuiLO3EdJ97+7/qBybg0Q8AiKqRCZOd7J+W3DvtRRvj1Tn
         U1I5r5PcPyZ/gg3SctwazWvKxGnBa1lHTycHzGo8bMPtSDcvgmg5fa3ccntxKmrIxYaQ
         GxSw==
X-Gm-Message-State: AOAM531vGPxy0c72BBuDuAkvn4j8teHghwnx8Kvk1+w53q9vme7VFiqw
        NY+HrhqeeS+KxuNxYl272o4a9PGTZNWzbw==
X-Google-Smtp-Source: ABdhPJxH6lZrtWzVyt/UkludJ0QSruYpfuRqZXMAZPwADbFslYVIHuyBhi07DpgdzKPLcUAd5Qh5eg==
X-Received: by 2002:a17:907:11ce:: with SMTP id va14mr604944ejb.10.1613590991956;
        Wed, 17 Feb 2021 11:43:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o10sm1479706eju.89.2021.02.17.11.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:43:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/14] fsck.c: pass along the fsck_msg_id in the fsck_error callback
Date:   Wed, 17 Feb 2021 20:42:43 +0100
Message-Id: <20210217194246.25342-12-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87blcja2ha.fsf@evledraar.gmail.com>
References: <87blcja2ha.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the fsck_error callback to also pass along the
fsck_msg_id. Before this change the only way to get the message id was
to parse it back out of the "message".

Let's pass it down explicitly for the benefit of callers that might
want to use it, as discussed in [1].

Passing the msg_type is now redundant, as you can always get it back
from the msg_id, but I'm not changing that convention. It's really
common to need the msg_type, and the report() function itself (which
calls "fsck_error") needs to call fsck_msg_type() to discover
it. Let's not needlessly re-do that work in the user callback.

1. https://lore.kernel.org/git/87blcja2ha.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fsck.c  | 4 +++-
 builtin/mktag.c | 1 +
 fsck.c          | 6 ++++--
 fsck.h          | 6 ++++--
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d6d745dc702..b71fac4ceca 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -89,7 +89,9 @@ static int objerror(struct object *obj, const char *err)
 static int fsck_error_func(struct fsck_options *o,
 			   const struct object_id *oid,
 			   enum object_type object_type,
-			   enum fsck_msg_type msg_type, const char *message)
+			   enum fsck_msg_type msg_type,
+			   enum fsck_msg_id msg_id,
+			   const char *message)
 {
 	switch (msg_type) {
 	case FSCK_WARN:
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 1834394a9b6..dc989c356f5 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -23,6 +23,7 @@ static int mktag_fsck_error_func(struct fsck_options *o,
 				 const struct object_id *oid,
 				 enum object_type object_type,
 				 enum fsck_msg_type msg_type,
+				 enum fsck_msg_id msg_id,
 				 const char *message)
 {
 	switch (msg_type) {
diff --git a/fsck.c b/fsck.c
index 980ef2cb8fa..007f02b556a 100644
--- a/fsck.c
+++ b/fsck.c
@@ -247,7 +247,7 @@ static int report(struct fsck_options *options,
 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
 	result = options->error_func(options, oid, object_type,
-				     msg_type, sb.buf);
+				     msg_type, msg_id, sb.buf);
 	strbuf_release(&sb);
 	va_end(ap);
 
@@ -1195,7 +1195,9 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 int fsck_error_function(struct fsck_options *o,
 			const struct object_id *oid,
 			enum object_type object_type,
-			enum fsck_msg_type msg_type, const char *message)
+			enum fsck_msg_type msg_type,
+			enum fsck_msg_id msg_id,
+			const char *message)
 {
 	if (msg_type == FSCK_WARN) {
 		warning("object %s: %s", fsck_describe_object(o, oid), message);
diff --git a/fsck.h b/fsck.h
index b4c53aaa08c..56536d7f29e 100644
--- a/fsck.h
+++ b/fsck.h
@@ -99,11 +99,13 @@ typedef int (*fsck_walk_func)(struct object *obj, enum object_type object_type,
 /* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
 typedef int (*fsck_error)(struct fsck_options *o,
 			  const struct object_id *oid, enum object_type object_type,
-			  enum fsck_msg_type msg_type, const char *message);
+			  enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
+			  const char *message);
 
 int fsck_error_function(struct fsck_options *o,
 			const struct object_id *oid, enum object_type object_type,
-			enum fsck_msg_type msg_type, const char *message);
+			enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
+			const char *message);
 
 struct fsck_options {
 	fsck_walk_func walk;
-- 
2.30.0.284.gd98b1dd5eaa7

