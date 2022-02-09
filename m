Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B0EC43217
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 02:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344338AbiBIClI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 21:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244535AbiBICKM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 21:10:12 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7B9C061353
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 18:10:11 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m26so538550wms.0
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 18:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s/VMTgp8zVGz57OURNC4xxkpH68NzGiQBA3psJDzlsw=;
        b=YJQ709tZzkbOJSjIcZ1uGQ4YFjVM/8BL8E7TCUoI/03cDZBV8bjUrfHD5RW7M6nYzh
         u/3xForsuspjnOrltuiCFUmmqQ2Vewwi/cUf1FytidzLqYHja4Z0uguZXHs9hBnQyDR2
         kgjm9vqLeHnbiDjfCCIT5G492yq5c4A7hJ6mSIK5lp2rZ3/q4+zZs/Qc0n8amVmi7BHl
         LMZP8ryeP+gHr7V7HN+jQ5tX2PwPFEz5Z4fliu6x+dVSeR90O3aSJMumnaijOj/kOkib
         VzZlVRRPlsoHiv2m6q1r0YGM3eZQ0dtcbQZAj/8ANzdVbdXhsO/Rglwqvq0GeFAoFtB/
         VJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s/VMTgp8zVGz57OURNC4xxkpH68NzGiQBA3psJDzlsw=;
        b=prHtE4bgqmImSr5vzuWow5Wwwp+PiLjhNvRnU90F/cPbsZPt4YNsNNzkS+Dzk9kwt4
         DMfhjLcTcB2YcNltdqhjYocev6K4kEqHybc/RdihbKQyqaY/icvpSZ+TV1T20XXbY/U4
         Hs/QDSzqP4y2ZRWb7ElvZjcHgUawGsMtDz2WzcpKAnif5oES1u+Me6qtCYPoyXZ98gcz
         foI8R4/o3hU/Sdx3B6fJPcVSipdLxdX4eMcMY9fTxHxLSezig9oPxWXupHbMDSEzHv9L
         MpMJd+mn4rjF9RJfraKmbVNbnzLkOegs4beOErGSrmRIk7hFISmoYzOUrEGBTXRditMb
         OjbA==
X-Gm-Message-State: AOAM5300EnaMZoNdprS1d9Va3j2FT/WZogRZmbtrq2phw6j5fCBBniv9
        BV4K0FARAwd+BoUjuP+5XKhdbqOCHP4=
X-Google-Smtp-Source: ABdhPJzLRg7Q42a0Za8Dft+R01gvxdJu4RbhLGxpFDYp/Psq+x6t7+nM3X8Hj8GP7c6nPezNuNZPdw==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr629145wmj.2.1644372610382;
        Tue, 08 Feb 2022 18:10:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l10sm14152623wrz.20.2022.02.08.18.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 18:10:10 -0800 (PST)
Message-Id: <40612b9663b8d20e8cfa25ccfce76c7f97e4934d.1644372606.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com>
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
        <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Feb 2022 02:10:05 +0000
Subject: [PATCH v2 3/4] upload-pack: allow missing promisor objects
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

When a git server (A) is being used alongside an http server (B) remote
that stores large blobs, and a client fetches objects from both (A) as
well as (B), we do not want (A) to fetch missing objects during object
traversal.

Add a config value uploadpack.allowmissingpromisor that, when set to
true, will allow (A) to skip fetching missing objects.

Based-on-patch-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 upload-pack.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/upload-pack.c b/upload-pack.c
index 8acc98741bb..39b56650b77 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -112,6 +112,7 @@ struct upload_pack_data {
 	unsigned allow_ref_in_want : 1;				/* v2 only */
 	unsigned allow_sideband_all : 1;			/* v2 only */
 	unsigned advertise_sid : 1;
+	unsigned allow_missing_promisor : 1;
 };
 
 static void upload_pack_data_init(struct upload_pack_data *data)
@@ -309,6 +310,8 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 		strvec_push(&pack_objects.args, "--delta-base-offset");
 	if (pack_data->use_include_tag)
 		strvec_push(&pack_objects.args, "--include-tag");
+	if (pack_data->allow_missing_promisor)
+		strvec_push(&pack_objects.args, "--missing=allow-promisor");
 	if (pack_data->filter_options.choice) {
 		const char *spec =
 			expand_list_objects_filter_spec(&pack_data->filter_options);
@@ -1315,6 +1318,8 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 		data->allow_ref_in_want = git_config_bool(var, value);
 	} else if (!strcmp("uploadpack.allowsidebandall", var)) {
 		data->allow_sideband_all = git_config_bool(var, value);
+	} else if (!strcmp("uploadpack.allowmissingpromisor", var)) {
+		data->allow_missing_promisor = git_config_bool(var, value);
 	} else if (!strcmp("core.precomposeunicode", var)) {
 		precomposed_unicode = git_config_bool(var, value);
 	} else if (!strcmp("transfer.advertisesid", var)) {
-- 
gitgitgadget

