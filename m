Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,UNWANTED_LANGUAGE_BODY,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE2881F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbeGLT7L (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:59:11 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:53475 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732355AbeGLT7L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:59:11 -0400
Received: by mail-qt0-f201.google.com with SMTP id k11-v6so5172939qtj.20
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=YarDi+XlLkz07ssLMuaE2nrphMu29jkE+6o/kMRH0Y0=;
        b=PgZjL1Vgl4JoBJIovbfIbmb611BYgOdXYT+XVugsj9cfDIUmYdwApKgHIU4VPbRDgQ
         66UgjCXqW3F3iBCIVyCkGuQLN3ruZVBcTyao007TAiRRuudORCC8gOBCj3HOUAcc4AzP
         Zsa2ngzE+2yfV9qKTvCAc0IuU+TycTZf6tc64iowyGyvmT/goOWi1Jm5XaPE91uNXV6h
         msw2VQRJRJtWC5gXyNM9lg0NLrg8sng7ubACNzQyjnthzl4nuqVRIRbCna7SjXCg9DTF
         xiptPdQbq8Mp3KE2BaYvH2P3npyax7N+3/23jyPAhTcVgzKUCY/7WcuMv+jIELrFvMA9
         MDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=YarDi+XlLkz07ssLMuaE2nrphMu29jkE+6o/kMRH0Y0=;
        b=LsOzIqAOBOCpRUq5RFfdLv8tFdrohzFj5yNrDV2ZzpS7ikK4WXg1RkE8r5Pq7hdI0J
         wR0Phc2BOnobbJ8QEk2a3rycmsMVp0DNoi9wdVd/6LnAsGMmLEoLNF2lvnUivYjX5ms2
         zox1T7cLDpn60xF2hxQODmMjMT5TA/3cGBUeWvmhksuAGoq6Mz5eDOk3MNnyhQqBp9PR
         KCyGOL4fGKMH4LfcCySwaHZ6Sx4jxjz9QK5UoX1JYbtLoixtRRvfjy4muk4EW0hJ8fgM
         FICdqMYI7ph/2ACFgJIHWJNmD+b0MGJBs6LmLnG5yDLUJuu87kQ9s9FmOSPGv3qSeQLq
         72og==
X-Gm-Message-State: AOUpUlH50QEK2en4ua29syFSjUYGMeh1eAojfNIH1Fl/sFKDsKW0UI6n
        rOFxs3egzd7kVGWkrzoyS0zBUA3lIBkdBnDT/8BRBzEJd6dLtH9rS1GUrE7ihOiwICjvyLbF1xE
        dqsC0LCgMXQe06S8ER8o0sDOfctweLBHrkxp1VRgakgNeoGqbfxCsu3rIY24j
X-Google-Smtp-Source: AAOMgpc5Dx+1CwEmAp7/jkChATBkFXho2BUL+WRAV07R1ql9PlRzzsSTm1+hPaSNj9xFOILIuuciW37yQMSu
MIME-Version: 1.0
X-Received: by 2002:a0c:e982:: with SMTP id z2-v6mr2266791qvn.29.1531424889722;
 Thu, 12 Jul 2018 12:48:09 -0700 (PDT)
Date:   Thu, 12 Jul 2018 12:47:53 -0700
In-Reply-To: <20180712194754.71979-1-sbeller@google.com>
Message-Id: <20180712194754.71979-6-sbeller@google.com>
References: <20180712194754.71979-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 5/6] builtin/submodule--helper: factor out method to update a
 single submodule
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we'll find this method handy.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c9c3fe2bf28..4bbf580df79 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1725,10 +1725,17 @@ static int gitmodules_update_clone_config(const char *var, const char *value,
 	return 0;
 }
 
+static void update_submodule(struct submodule_update_clone_information *suci)
+{
+	fprintf(stdout, "dummy %s %d\t%s\n",
+		oid_to_hex(&suci->oid),
+		suci->just_cloned,
+		suci->sub->path);
+}
+
 static int update_submodules(struct submodule_update_clone *suc)
 {
 	int i;
-	struct strbuf sb = STRBUF_INIT;
 
 	run_processes_parallel(suc->max_jobs,
 			       update_clone_get_next_task,
@@ -1747,16 +1754,9 @@ static int update_submodules(struct submodule_update_clone *suc)
 	if (suc->quickstop)
 		return 1;
 
-	for (i = 0; i < suc->submodule_lines_nr; i++) {
-		strbuf_addf(&sb, "dummy %s %d\t%s\n",
-			oid_to_hex(&suc->submodule_lines[i].oid),
-			suc->submodule_lines[i].just_cloned,
-			suc->submodule_lines[i].sub->path);
-		fprintf(stdout, "%s", sb.buf);
-		strbuf_reset(&sb);
-	}
+	for (i = 0; i < suc->submodule_lines_nr; i++)
+		update_submodule(&suc->submodule_lines[i]);
 
-	strbuf_release(&sb);
 	return 0;
 }
 
-- 
2.18.0.203.gfac676dfb9-goog

