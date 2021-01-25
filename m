Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F81C433E6
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 265FC2226A
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732912AbhAYXox (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 18:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732608AbhAYXi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 18:38:26 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C915C0613ED
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 15:37:25 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id z22so11055515qto.7
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 15:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aPY07tfPrTnRXnbEQoW8yh4XdMIBE09rVkJTXTU19AQ=;
        b=BA1EI2xEDZtRUg1a0Dg40mHHdgrM5XFwfXVSIrS2Z7EZ5LDlMMHpX0N7GjE8epka+q
         yJLqYN1SwXkBF8d6fwcEwPhU07TBGRbi6WWwwaSrsNeEQo9rWkV/Pr/kj7htIv6QUede
         FrUpIkWOBXyr/6ueXuvewkuu67b1ElytxU18T0f9jVZ0FwXCgF2dRU6kYi6KDKucNvHA
         21Qkao7txgvM0PQfCC5eudC99d8Xikok4NfmYUQm+YuUFYjRGrrjyrOCtVCFr5jdmGQG
         QST/H7Q46IagxZ+Y7icCjnvLuZ6qpr+9n90ztF5lBjMwYvIX1V9lZPzq1FXAP9T5gEP9
         AWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aPY07tfPrTnRXnbEQoW8yh4XdMIBE09rVkJTXTU19AQ=;
        b=XFBpQZ60Ue/A3wwwgyVE6qgcFDWT6N9th14BKkPa36MZ6YhVk3ws8M7goF+KlQvGVx
         FzkPq1T9IeBngohaKleChrnaDpBqSr2Yz8BkSo5PKbxMbmaZMVlxw1gKltnrdWTlI1fQ
         Aygp/OH+WI4bPT2t5nuKrWlZRBEvMbXN0OKytl6kz1KeP3vv4nb48TuNWGIj4+C5pEaJ
         5jtVhodztDgBZTB0WC0x9VgveHxNXAwDjWWWnEMxP/Ngstmij4lIGkmfypG7O2C0CAim
         SovWRTOqueeq4j+ef1Bk8VDH2JgUnMtQ2uSzXfzpKvN3Ish2rk2tQpr3lHOOv4TxbvOB
         W7pA==
X-Gm-Message-State: AOAM533fTzw5hkDbmOddZJwBYAQteeN6m2SSbp73VKBo4RDjZ+TInFDO
        93Ele9DD7NN/wmgRgVrn3TlIj4NXc+KzXg==
X-Google-Smtp-Source: ABdhPJxNNv6wea35JZhp6OSWXjjlh/1OxXYc0b6jktRw+zjT5EOM2GXH8rWLpMS6EWqmrP2P5V/cgw==
X-Received: by 2002:aed:3145:: with SMTP id 63mr2802557qtg.189.1611617844507;
        Mon, 25 Jan 2021 15:37:24 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5e9f:a2e5:e7ac:394d])
        by smtp.gmail.com with ESMTPSA id c49sm12982827qta.89.2021.01.25.15.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 15:37:23 -0800 (PST)
Date:   Mon, 25 Jan 2021 18:37:22 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v3 03/10] builtin/index-pack.c: allow stripping arbitrary
 extensions
Message-ID: <8a3e70454b9bc64fc7a5ff07d47f7fde018e6a3d.1611617820.git.me@ttaylorr.com>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611617819.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To derive the filename for a .idx file, 'git index-pack' uses
derive_filename() to strip the '.pack' suffix and add the new suffix.

Prepare for stripping off suffixes other than '.pack' by making the
suffix to strip a parameter of derive_filename(). In order to make this
consistent with the "suffix" parameter which does not begin with a ".",
an additional check in derive_filename.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/index-pack.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 557bd2f348..c758f3b8e9 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1436,15 +1436,15 @@ static void fix_unresolved_deltas(struct hashfile *f)
 	free(sorted_by_pos);
 }
 
-static const char *derive_filename(const char *pack_name, const char *suffix,
-				   struct strbuf *buf)
+static const char *derive_filename(const char *pack_name, const char *strip,
+				   const char *suffix, struct strbuf *buf)
 {
 	size_t len;
-	if (!strip_suffix(pack_name, ".pack", &len))
-		die(_("packfile name '%s' does not end with '.pack'"),
-		    pack_name);
+	if (!strip_suffix(pack_name, strip, &len) || !len ||
+	    pack_name[len - 1] != '.')
+		die(_("packfile name '%s' does not end with '.%s'"),
+		    pack_name, strip);
 	strbuf_add(buf, pack_name, len);
-	strbuf_addch(buf, '.');
 	strbuf_addstr(buf, suffix);
 	return buf->buf;
 }
@@ -1459,7 +1459,7 @@ static void write_special_file(const char *suffix, const char *msg,
 	int msg_len = strlen(msg);
 
 	if (pack_name)
-		filename = derive_filename(pack_name, suffix, &name_buf);
+		filename = derive_filename(pack_name, "pack", suffix, &name_buf);
 	else
 		filename = odb_pack_name(&name_buf, hash, suffix);
 
@@ -1824,7 +1824,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (from_stdin && hash_algo)
 		die(_("--object-format cannot be used with --stdin"));
 	if (!index_name && pack_name)
-		index_name = derive_filename(pack_name, "idx", &index_name_buf);
+		index_name = derive_filename(pack_name, "pack", "idx", &index_name_buf);
 
 	if (verify) {
 		if (!index_name)
-- 
2.30.0.138.g6d7191ea01

