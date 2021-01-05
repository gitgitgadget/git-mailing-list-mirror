Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A95C433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0D26227BF
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbhAEEob (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 23:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbhAEEoa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 23:44:30 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19553C0617A2
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 20:43:14 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v14so1871138wml.1
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 20:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7wxpQwD2S7ImoZHKLssEJqa72kQrG0DmjRoz4MATBCU=;
        b=qczC+UgK30uGMTEnLc6H/vnFY10KEyLdOVKr1PufazN4nNhRTmnjtc58hFk22qlTAP
         amdvKPv2EUWMTQIxi3wa4WQP6xrc5iZQ0ui0WzKm9qpNE6GcdyNKeLrinfttpwhdsZBE
         2SiAieFgUZMTPNkUT/Ao9rSXM8LSou6OFFcKlm0Lme/PVq+XADFrGmyAtO4hkdKAIDdc
         5iSkan5MQQ7kYIyYQfTQmqp4ENh+1W94PurUjz+undVxH/5+kTxR0PLKMgQwqsoyU03d
         81m7d/J73QxBztke61fSeUbEyRbMoKObz5Q694N637tPN1DIbHKfOxMjmUQKPVXvbgFw
         Ycpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7wxpQwD2S7ImoZHKLssEJqa72kQrG0DmjRoz4MATBCU=;
        b=qYb0l2eYZi+w2gyY7ln9/SQZhM8qa+L/RlL00y06+k7atxYhsELfYZZl5BpA2B6Qxr
         KInN2MCKvsV9boZaNurl+2sGrslsU3Uq3ttcF715fv+QzNIJ63CcDJ/5Q98gs5I0457q
         Pn/IAVFICImjPMBQu7ZvxSiITjiNXou8UGd/mR25kYCSjKeRY6kkPnqqDZvgbJdFqIQK
         M6rr5cmrOeJFn7FNnoTdsxDh1NH1eaxbSasZNy/6Q10P05kgSUnFkMxOGPlcnHTYmK75
         vKzOuMmWg0/wnh2GsAfjwCKOXBjRVAaL8R9G9coPDL6/M/YcZ+IKyd8y+5uMqc0HfLqU
         bh+w==
X-Gm-Message-State: AOAM53281jUs0V8d+v8eLmED7+LOBirLcRuwzZrsSLhhJ8Okv84W68If
        hqUkpInQAQB41rzu17zsn2gr1j/sIfo=
X-Google-Smtp-Source: ABdhPJzOnzb2cACx31uu9PaLdkJERpATSU2yiE4fimNu4XM9SdruQ6J0AetoqQmnJg6EggcJa3K/kQ==
X-Received: by 2002:a1c:287:: with SMTP id 129mr1694051wmc.133.1609821792650;
        Mon, 04 Jan 2021 20:43:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z63sm2586774wme.8.2021.01.04.20.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 20:43:12 -0800 (PST)
Message-Id: <620e300ad6b346af6b73feec625a3e125afaa53f.1609821783.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
        <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Jan 2021 04:42:58 +0000
Subject: [PATCH v2 09/14] update-index: use add_index_entry()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This is a mechanical replacement of add_cache_entry().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index aa859c4e018..ffa42813370 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -294,7 +294,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 	}
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
-	if (add_cache_entry(ce, option)) {
+	if (add_index_entry(istate, ce, option)) {
 		discard_cache_entry(ce);
 		return error("%s: cannot add to the index - missing --add option?", path);
 	}
@@ -672,12 +672,12 @@ static int unresolve_one(const char *path)
 	}
 
 	remove_file_from_index(istate, path);
-	if (add_cache_entry(ce_2, ADD_CACHE_OK_TO_ADD)) {
+	if (add_index_entry(istate, ce_2, ADD_CACHE_OK_TO_ADD)) {
 		error("%s: cannot add our version to the index.", path);
 		ret = -1;
 		goto free_return;
 	}
-	if (!add_cache_entry(ce_3, ADD_CACHE_OK_TO_ADD))
+	if (!add_index_entry(istate, ce_3, ADD_CACHE_OK_TO_ADD))
 		return 0;
 	error("%s: cannot add their version to the index.", path);
 	ret = -1;
-- 
gitgitgadget

