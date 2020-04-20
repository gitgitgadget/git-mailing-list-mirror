Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B853EC55182
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 21:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 920D720782
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 21:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7/t4ukO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgDTVPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727835AbgDTVPA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 17:15:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CCAC061A0C
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 14:14:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so4849359wrr.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 14:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NfPWVYm5oJnAy6N3ND7qYx88WtkIig5hT6uesdXdV6c=;
        b=U7/t4ukOLhXv86DnXnzKxUkr1I1anxjWVzcGDDCpuLC+wCoch8qzk+SAzyLmv3QC5O
         3G98TxfkRTRcHGOHqfw8ckXYayr5JTaj7VTiO6V1fRCW6KIGxW0GCUHcULOh4TroRXgu
         jO8Rd9qafmppoBfvstdw1dEHyunNblUC3HRUQd3ezo6PwUOjJnlsJHFicNseWxN8ikMS
         +/zlhJpMhyDYLFLOdz0/nvAX2LEyvEfnAOHar7KVEAxGLd5uV/LDN1QSsaHu2w6ACDf8
         8dliJmrd/h734UfDkzjUDNtKX3VOYqaeIPF4SR35yT4M6qaRYWWsezJd/wIsj77KoroW
         NGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NfPWVYm5oJnAy6N3ND7qYx88WtkIig5hT6uesdXdV6c=;
        b=KZtRWpaBAaJS/lgEQdfiiWL0rNK9iWZoj19jnaU0EXf0NGLLMEyek5wdyjfoLV3RGP
         IpmMrdaPoTshdqvTgAryspMia6NXw1x/dBn4r6p/rFnZg60F8eyvijDTV4moYMSRNR0l
         M6I0Zj/5Q6ayw4/fOTpNe5N9QJxjLCHkLuxXduB8rDVXVbTQ6EWwYchaS52KSINa1X02
         HgDuEPxOnY3bLgxxAj4Lc6w2qOaIN4/a20mKhJFaXdiZuVFxceWo9zUCIguapYG+Jggt
         Mpm3nng2rjD6dy3qNtVNV/nLZhUufciJLhhNCp1CjtgnOBwPys0dCgGdt4kgEQRiS2IV
         gYlw==
X-Gm-Message-State: AGi0PuZL5Ai0S2ZzIi3UGAf1tLP0Dm48nfeHzUPw+dgeMq8yG8yH76bJ
        Wt77/MsDlil0Dj+JkmnItP7z/11T
X-Google-Smtp-Source: APiQypLrfFBeBrH2Y4n1hC4WXwAAl/8LFFAwhABrt/kqD2NCsucsvX9DuKd3B00I/hYQadg8eIcbkA==
X-Received: by 2002:adf:f350:: with SMTP id e16mr19715282wrp.332.1587417297602;
        Mon, 20 Apr 2020 14:14:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p16sm892546wro.21.2020.04.20.14.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:14:57 -0700 (PDT)
Message-Id: <b600d0bc6ddd4ab1e228482e97d10fb40cb07cea.1587417295.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
References: <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
        <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Apr 2020 21:14:46 +0000
Subject: [PATCH v9 01/10] refs.h: clarify reflog iteration order
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs.h b/refs.h
index 545029c6d80..87c9ec921b9 100644
--- a/refs.h
+++ b/refs.h
@@ -444,18 +444,21 @@ int delete_refs(const char *msg, struct string_list *refnames,
 int refs_delete_reflog(struct ref_store *refs, const char *refname);
 int delete_reflog(const char *refname);
 
-/* iterate over reflog entries */
+/* Iterate over reflog entries. */
 typedef int each_reflog_ent_fn(
 		struct object_id *old_oid, struct object_id *new_oid,
 		const char *committer, timestamp_t timestamp,
 		int tz, const char *msg, void *cb_data);
 
+/* Iterate in over reflog entries, oldest entry first. */
 int refs_for_each_reflog_ent(struct ref_store *refs, const char *refname,
 			     each_reflog_ent_fn fn, void *cb_data);
 int refs_for_each_reflog_ent_reverse(struct ref_store *refs,
 				     const char *refname,
 				     each_reflog_ent_fn fn,
 				     void *cb_data);
+
+/* Call a function for each reflog entry, oldest entry first. */
 int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data);
 int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data);
 
-- 
gitgitgadget

