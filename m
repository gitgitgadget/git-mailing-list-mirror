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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01BFC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BC54610FC
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbhDISsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbhDISrx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:47:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB907C061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:47:39 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id y20-20020a1c4b140000b029011f294095d3so5253039wma.3
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OUffXNu87CDMnFQUZ0L6u1Y+eZRl0x+hw5v/1tRshY8=;
        b=Bik4cR/fNlc4/P1C2lgjFOQzs5xoKK/h3cLuTXm9z1l50mCGA8QTCaHd61+BhbNW2T
         whAJU/s4mlzs5+HA+0rG3nxX5DbnLHvOiQkf+ynEqHCMIEV0Depaf5ajI+TZebC/u6Mr
         qtjgtoUyg84uf615AJaD+/plUC9ViojQb2kHpU/el74UxztNlzh4Fd6Zw2p1fqDFPRsC
         l9QT9pD0jPLjabfEpEkft2NBvBDf3eAnHTmAnZ6fsw993hsGdEoT24kq9ff3ztAPOy56
         9MgCv7hQqiuwGVZ3f4NfYxAyTZzSUq/xaKTP+o0AoJgSctmAk+ktmRRV6SdHdxVzVtwn
         XO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OUffXNu87CDMnFQUZ0L6u1Y+eZRl0x+hw5v/1tRshY8=;
        b=bmENGJkc2owmKSlCCB6b+EBvHaXH0aorm/LwM2LnWltboUTXMp1jcnw9eqm5/k09fh
         cV3LTN7tTdbNMqS0Xk7v3OOAIKCUlKhUaCtrkAT1cQag8o7hWoVQkdTbKa8IT4dJcezB
         GrtqEcH6Moo2SHpXKYap24DyiAL4XDDh1t90SQ3HciK2YoVTLAN3p9LNq+Zxh/En8Faa
         oYrHLm8284GpApm3mBXtt/3jK7sT7Gkv279OMsLwqnMv31jPvFYQ/X78702vmTbRKFov
         wZHVEnsQVgyXUP4iAxTeBQt0y/2AzBV2jjhqlC1FqmabGWl7fvByy6ShyGRzAi0GVRSh
         WeRA==
X-Gm-Message-State: AOAM531hZXI1ZUrTUd5lCXZPTRMm8rJFy1Qi8x9B0POihkBB6kj1czF6
        lzoJs+wwNRsomUvKjcBb5PNTyxNaKHU=
X-Google-Smtp-Source: ABdhPJw/irUzefmSq12nktihwoqs+Rb3F0krWNgmnyAAkdu4npoLFAZDZxjmpIuAWHdaDtrVUPcENw==
X-Received: by 2002:a05:600c:1992:: with SMTP id t18mr14680967wmq.125.1617994058575;
        Fri, 09 Apr 2021 11:47:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c24sm5211856wml.29.2021.04.09.11.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:47:38 -0700 (PDT)
Message-Id: <130ef89218a47adc7ee558e75672e0e4eb5f30ca.1617994052.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.git.1617994052.gitgitgadget@gmail.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Apr 2021 18:47:28 +0000
Subject: [PATCH 09/12] mailinfo: also free strbuf lists when clearing mailinfo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrzej Hunt <andrzej@ahunt.org>, Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

mailinfo.p_hdr_info/s_hdr_info are null-terminated lists of strbuf's,
with entries pointing either to NULL or an allocated strbuf. Therefore
we need to free those strbuf's (and not just the data they contain)
whenever we're done with a given entry. (See handle_header() where those
new strbufs are malloc'd.)

Once we no longer need the list (and not just its entries) we can switch
over to strbuf_list_free() instead of manually iterating over the list,
which takes care of those additional details for us. We can only do this
in clear_mailinfo() - in handle_commit_message() we are only clearing the
array contents but want to reuse the array itself, hence we can't use
strbuf_list_free() there.

Leak output from t0023:

Direct leak of 72 byte(s) in 3 object(s) allocated from:
    #0 0x49a85d in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
    #1 0x9ac9f4 in do_xmalloc wrapper.c:41:8
    #2 0x9ac9ca in xmalloc wrapper.c:62:9
    #3 0x7f6cf7 in handle_header mailinfo.c:205:10
    #4 0x7f5abf in check_header mailinfo.c:583:4
    #5 0x7f5524 in mailinfo mailinfo.c:1197:3
    #6 0x4dcc95 in parse_mail builtin/am.c:1167:6
    #7 0x4d9070 in am_run builtin/am.c:1732:12
    #8 0x4d5b7a in cmd_am builtin/am.c:2398:3
    #9 0x4cd91d in run_builtin git.c:467:11
    #10 0x4cb5f3 in handle_builtin git.c:719:3
    #11 0x4ccf47 in run_argv git.c:808:4
    #12 0x4caf49 in cmd_main git.c:939:19
    #13 0x69e43e in main common-main.c:52:11
    #14 0x7fc1fadfa349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: AddressSanitizer: 72 byte(s) leaked in 3 allocation(s).

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 mailinfo.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 5681d9130db6..95ce191f385b 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -821,7 +821,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 		for (i = 0; header[i]; i++) {
 			if (mi->s_hdr_data[i])
 				strbuf_release(mi->s_hdr_data[i]);
-			mi->s_hdr_data[i] = NULL;
+			FREE_AND_NULL(mi->s_hdr_data[i]);
 		}
 		return 0;
 	}
@@ -1236,22 +1236,14 @@ void setup_mailinfo(struct mailinfo *mi)
 
 void clear_mailinfo(struct mailinfo *mi)
 {
-	int i;
-
 	strbuf_release(&mi->name);
 	strbuf_release(&mi->email);
 	strbuf_release(&mi->charset);
 	strbuf_release(&mi->inbody_header_accum);
 	free(mi->message_id);
 
-	if (mi->p_hdr_data)
-		for (i = 0; mi->p_hdr_data[i]; i++)
-			strbuf_release(mi->p_hdr_data[i]);
-	free(mi->p_hdr_data);
-	if (mi->s_hdr_data)
-		for (i = 0; mi->s_hdr_data[i]; i++)
-			strbuf_release(mi->s_hdr_data[i]);
-	free(mi->s_hdr_data);
+	strbuf_list_free(mi->p_hdr_data);
+	strbuf_list_free(mi->s_hdr_data);
 
 	while (mi->content < mi->content_top) {
 		free(*(mi->content_top));
-- 
gitgitgadget

