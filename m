Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74D491F454
	for <e@80x24.org>; Wed,  6 Nov 2019 09:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfKFJUq (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 04:20:46 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45274 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbfKFJUq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 04:20:46 -0500
Received: by mail-pg1-f196.google.com with SMTP id w11so6382097pga.12
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 01:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AukqvAVBuV9CV2EJxL2162H5F0jq3DYY1FZNJzfEgGQ=;
        b=MHj2RsEL/NlRn8dMl5BgVbtKTFRmsT1orMYctScKPP5iGGzS/1GxbzUq7wujzflZ57
         Ax9YHiS31/lzsmaITlbyQJEt/6o2XIlCaeDbjEkxPG5JCFF1CpPJ/mxEaiB3G8mLjeoA
         Tous+gfFmmS/IDD6xuL0Ld0Fs0sOpcbPfZUfJaafmzAfDqlvbqGEY5IszquUBRYjLEPL
         Tc1uGgttSCfzO8h9ViwYhEhdgrbk89+/yHpzbCI7mFeHY1vA7qg/6MjGbo2icpMpviJn
         TEokiXVSRujjZyf1BPIazLCvvP2Gjudd7q8tv9/jABTRcH7ieF8nwtQY4XRIaCVnXLtP
         E/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AukqvAVBuV9CV2EJxL2162H5F0jq3DYY1FZNJzfEgGQ=;
        b=EgaUCwoWzpGDDn4c6kQYCei/2JAltkN1c+EZbc8rKyWHzeYnaXRK33kegIGxgQAc7K
         TRBxdSbZSQDWgmvOcPTRYeX3KUsgtIRhQVtgD1l+3nF5r8R97Fa7hMl3ZLeEjUWUA5FC
         UEP2ioWtBjVJXAWampSa5nxYfOg0aru4a/ldCgaZjm5MYwAmZwb2BuiraTSH7GjffA61
         bFN+kM3HmwmViXn1mgd/l/Q39igV50I2Qnn+Fx32j/dHsPHW8th016K5fxZZdHR4Swhm
         0hI5GWBy6tr47EVCFviIOTzPMc1LBnNoRd+IzJC0HqDF+XoEmgkFnd0YIneXMN7f0rfj
         1AIw==
X-Gm-Message-State: APjAAAV0dF/4wcAho/WjflDEjCITYgtUxdOaHmLBCw3ovAPLmVg26PM4
        ZafYl6TNpxpoMmrFbwnSSXmEyNDW
X-Google-Smtp-Source: APXvYqyirv8Z+VoK1Vyq+6x1IgUKC1o/QCACEibjVbDUl5a8I0VAQGUdahlMpClFNIHNz0xXl7i1hQ==
X-Received: by 2002:a62:e818:: with SMTP id c24mr2042410pfi.125.1573032045671;
        Wed, 06 Nov 2019 01:20:45 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:4ba:cb41:a2ec:2198:454b])
        by smtp.gmail.com with ESMTPSA id c1sm4696984pjc.23.2019.11.06.01.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 01:20:45 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v3 5/8] sequencer: reencode revert/cherry-pick's todo list
Date:   Wed,  6 Nov 2019 16:20:03 +0700
Message-Id: <d382e35e4ef93a77209c0a6659371d25c8ed219e.1573031848.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.4.g6a51fdd29c
In-Reply-To: <cover.1573031848.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573031848.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Keep revert/cherry-pick's todo list in line with rebase todo list.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 sequencer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 69430fe23f..a19954f2bf 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2564,14 +2564,17 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 	enum todo_command command = opts->action == REPLAY_PICK ?
 		TODO_PICK : TODO_REVERT;
 	const char *command_string = todo_command_info[command].str;
+	const char *encoding;
 	struct commit *commit;
 
 	if (prepare_revs(opts))
 		return -1;
 
+	encoding = get_log_output_encoding();
+
 	while ((commit = get_revision(opts->revs))) {
 		struct todo_item *item = append_new_todo(todo_list);
-		const char *commit_buffer = get_commit_buffer(commit, NULL);
+		const char *commit_buffer = logmsg_reencode(commit, NULL, encoding);
 		const char *subject;
 		int subject_len;
 
-- 
2.24.0.4.g6a51fdd29c

