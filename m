Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFCBC6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjC1O3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjC1O27 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 10:28:59 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6EB61AF
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:28:58 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so15283807pjt.2
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680013738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkevVo6PUUdw6Nhm2T7L2YC8siiJDff+1BSRStlg8YI=;
        b=Yn78qGnf9CpUGeagMcBM1qZEFoMZWQLWRJmTiRk16N8lIOa9tDoJsdI8But1yfC1Rs
         1MHIfzMq7wL8kQzZgx2CJdDYvQY5dXaLsTv/RaRf4y7Wv3ghECKwACucNlcPtQlfOQZX
         wIWbC6lRDIU+Ko3uAJ6JpGL1A0lMH7jUXNwmWepoVCGt2l1qUggDjShjGx3hnAbS8lOs
         UR0bI8PkpLY+M8yQBtDCCmzqgu0oslZux5MOdoiFzUEAPXPrOjnbmyOd+q6IB2YZL+7U
         +pM2MlTwy0fnF5CzzOVoQMJyico1MyqXtFXbSykVX5Tt3ogQRf0aLxr5QRzX/jV/WH6P
         0SrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680013738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkevVo6PUUdw6Nhm2T7L2YC8siiJDff+1BSRStlg8YI=;
        b=rp2oMVXiryT9eGVVB6K1NhJWXRQfix2KswySQM5RTlLcmlUbN8o895Dv5mGQinh1KJ
         mANK+ZUeDDO+JJkBxXeME267USnmKADOybjWMQl8iG0R5FCvVxVrpDUq0rQHONThbBdw
         ZHqfjshMMmcrUoa8z77CUpMmCkdZvZwQWzDLUjA/+b9i+ItsDSNATEXgETc4jGji51d6
         0IR95V0q4clGRUiyfaBiLa6S7gixxzJSMEcAa9J0AXPUILrFxJiCMCdEu24ztd0lS7kQ
         1oxFxgQGAFZ5w2k+LMJNOI04ZUUv+BuYIk37OL0uwtx3loZdMJ6jeLezO6GSHO0ZKHSc
         fGYA==
X-Gm-Message-State: AAQBX9dLPl2OtGYYrBCP9FpU+kPZjakSy7q8LW1wMxS/L4a3XXKj52ob
        ZS/8nyxb7PojNBjsbEhIiHc=
X-Google-Smtp-Source: AKy350aVQxK85nutgLyH6c6VpCwxhAmxNr56S78Ma3R5+4DqZxOnQag2YK8eCfpYI1z9igxM128kVQ==
X-Received: by 2002:a17:902:c402:b0:1a2:775:7d29 with SMTP id k2-20020a170902c40200b001a207757d29mr21085359plk.5.1680013737639;
        Tue, 28 Mar 2023 07:28:57 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.62])
        by smtp.gmail.com with ESMTPSA id bg9-20020a1709028e8900b0019cbabf127dsm21189275plb.182.2023.03.28.07.28.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Mar 2023 07:28:57 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v7 1/4] notes.c: cleanup 'strbuf_grow' call in 'append_edit'
Date:   Tue, 28 Mar 2023 22:28:44 +0800
Message-Id: <ea9c199ecf78fe8edaa157a51824b31bb983cfcb.1680012650.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.rc2.4.gb9d12f0c
In-Reply-To: <cover.1680012650.git.dyroneteng@gmail.com>
References: <cover.1680012650.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Let's cleanup the unnecessary 'strbuf_grow' call in 'append_edit'. This
"strbuf_grow(&d.buf, size + 1);" is prepared for insert a blank line if
needed, but actually when inserting, "strbuf_insertstr(&d.buf, 0,
"\n");" will do the "grow" for us.

348f199b (builtin-notes: Refactor handling of -F option to allow
combining -m and -F, 2010-02-13) added these to mimic the code
introduced by 2347fae5 (builtin-notes: Add "append" subcommand for
appending to note objects, 2010-02-13) that reads in previous note
before the message.  And the resulting code with explicit sizing is
carried to this day.

In the context of reading an existing note in, exact sizing may have
made sense, but because the resulting note needs cleansing with
stripspace() when appending with this option, such an exact sizing
does not buy us all that much in practice.

It may help avoiding overallocation due to ALLOC_GROW() slop, but
nobody can feed so many long messages for it to matter from the
command line.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/notes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 80d9dfd2..23cb6f0d 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -215,7 +215,6 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 
 	BUG_ON_OPT_NEG(unset);
 
-	strbuf_grow(&d->buf, strlen(arg) + 2);
 	if (d->buf.len)
 		strbuf_addch(&d->buf, '\n');
 	strbuf_addstr(&d->buf, arg);
@@ -618,7 +617,6 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		enum object_type type;
 		char *prev_buf = read_object_file(note, &type, &size);
 
-		strbuf_grow(&d.buf, size + 1);
 		if (d.buf.len && prev_buf && size)
 			strbuf_insertstr(&d.buf, 0, "\n");
 		if (prev_buf && size)
-- 
2.40.0.rc2.4.gb9d12f0c

