Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF38C433EF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 19:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A132A60F70
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 19:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbhIRTdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 15:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbhIRTdM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 15:33:12 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BA3C061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 12:31:48 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b7so12355272pfo.11
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 12:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j0h2UVGqmgW/pTMFRC38X7s9je0S5osw5ZHHUazqNNw=;
        b=odievm1p1cJwrBJ6OGhpb1xanJkLitOwv4X+4KmgdUfzfz7vATsCTKIqPPDj8+bkwS
         IAuB835nuCNWuX79S1PNcwpXk0ZzS9GWAVGwu1yOreygXIbBVmb3BE4cjWTxIQT6BtJA
         c7fiEK6AS3icid3Xia8D5aohfZwPTye4Bb6YwVMs+Xds6aQXQsAZMUMTV+nLqUMnnkAq
         EzPrctzkldCUyxpO8YEzDC9S2lmaxLmAlJ74IlBVsV/PGiPAZzml8SPf8o03XPn46etj
         ahpS94Vmp1RamsQEA2GXERYxJHQGMdSoZwKS2cWcHTDsJJC91MGegY9fY9oYx6gu57UL
         fmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j0h2UVGqmgW/pTMFRC38X7s9je0S5osw5ZHHUazqNNw=;
        b=LIxRaAg8eP/ntfPFFx7CWLSuhJI+UXX6u7TJmDdaOMY5GO7Z/MHhvqSj59LKL7CR6D
         0hVq8H1MEDFr3J5t1j58w69No2WuQMziGV6T41HdUQjcAWHFJ31DgOd4RHsgKWgsAFIS
         0ie+7E+co5B8gCLD0swud6FqmZ2ykHkXi5XldNhtTjsTSMXhvfVexq9DQIuqgPUhEfUE
         zovhvY0nqRERGTx7oqwqsHGEgbMMxrShp0cCe+V0zbWYPHAjxVE5JMnfzfsGSgeDttWy
         jQzIFaf9a46h4S/8ikx/lmLlbP6g5CJPxwDvFHjOUmfwAmS197I0BMIxszNTnA49WhnU
         weog==
X-Gm-Message-State: AOAM531XOS++3O3b+I1FKi3jaWukHh8J0XfJ8Xnv2HnqErjkOGaazvzP
        FzFvXlr5xRkyEzHmnSJYE8i1P0TEXJs=
X-Google-Smtp-Source: ABdhPJwHtI3SgvC7Y5+1aE3S0OyR3KLFeYc1wVv2OhESKJP9hW16x7xbo5E8Zh1tks8cyP803qnmuA==
X-Received: by 2002:a62:5b42:0:b0:447:1b85:28b3 with SMTP id p63-20020a625b42000000b004471b8528b3mr2938232pfb.58.1631993507986;
        Sat, 18 Sep 2021 12:31:47 -0700 (PDT)
Received: from localhost.localdomain ([49.204.135.121])
        by smtp.gmail.com with ESMTPSA id j6sm9861979pgh.17.2021.09.18.12.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 12:31:47 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Subject: [PATCH v2 0/1] submodule: corret an incorrectly formatted error message
Date:   Sun, 19 Sep 2021 01:01:15 +0530
Message-Id: <20210918193116.310575-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.32.0.385.gc00617bc03.dirty
In-Reply-To: <20210805192803.679948-1-kaartic.sivaraam@gmail.com>
References: <20210805192803.679948-1-kaartic.sivaraam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Finally got a chance to send the v2 of this one.

Changes in v2:

- Removed the 'if' from the message as Atharva mentioned that it was
  added inadvertently

- Moved 'fatal:' prefix from middle of the message to the beginning.

- Expanded the commit message to also mention the output after the change

For reference, the v1 could be found here:

  https://public-inbox.org/git/20210805192803.679948-1-kaartic.sivaraam@gmail.com/

... and the range-diff against v1 could be found below. Reviews appreciated.

--
Sivaraam


Kaartic Sivaraam (1):
  submodule--helper: fix incorrect newlines in an error message

 builtin/submodule--helper.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

Range-diff against v1:
1:  c00617bc03 ! 1:  c6daed7a92 submodule--helper: fix incorrect newlines in an error message
    @@ Commit message
     
         After the refactoring the error started appearing like so:
     
    -     --- START OF OUTPUT ---
    +      --- START OF OUTPUT ---
           $ git submodule add ../sub/ subm
           A git directory for 'subm' is found locally with remote(s):  origin     /me/git-repos-for-test/sub
           fatal: If you want to reuse this local git directory instead of cloning again from
    @@ Commit message
         Make the error message consistent with the error message that used to be
         printed before the refactoring.
     
    +    This also moves the 'fatal:' prefix that appears in the middle of the
    +    error message to the first line as it would more appropriate to have
    +    it in the first line. The output after the change would look like:
    +
    +      --- START OF OUTPUT ---
    +      $ git submodule add ../sub/ subm
    +      fatal: A git directory for 'subm' is found locally with remote(s):
    +        origin        /me/git-repos-for-test/sub
    +      If you want to reuse this local git directory instead of cloning again from
    +        /me/git-repos-for-test/sub
    +      use the '--force' option. If the local git directory is not the correct repo
    +      or you are unsure what this means choose another name with the '--name' option.
    +      ---  END OF OUTPUT  ---
    +
         [1]: https://lore.kernel.org/git/20210710074801.19917-5-raykar.ath@gmail.com/#t
     
      ## builtin/submodule--helper.c ##
    +@@ builtin/submodule--helper.c: struct add_data {
    + };
    + #define ADD_DATA_INIT { .depth = -1 }
    + 
    +-static void show_fetch_remotes(FILE *output, const char *sm_name, const char *git_dir_path)
    ++static void show_fetch_remotes(struct strbuf *msg, const char *sm_name, const char *git_dir_path)
    + {
    + 	struct child_process cp_remote = CHILD_PROCESS_INIT;
    + 	struct strbuf sb_remote_out = STRBUF_INIT;
    +@@ builtin/submodule--helper.c: static void show_fetch_remotes(FILE *output, const char *sm_name, const char *gi
    + 		while ((next_line = strchr(line, '\n')) != NULL) {
    + 			size_t len = next_line - line;
    + 			if (strip_suffix_mem(line, &len, " (fetch)"))
    +-				fprintf(output, "  %.*s\n", (int)len, line);
    ++				strbuf_addf(msg, "  %.*s\n", (int)len, line);
    + 			line = next_line + 1;
    + 		}
    + 	}
     @@ builtin/submodule--helper.c: static int add_submodule(const struct add_data *add_data)
    + 
      		if (is_directory(submod_gitdir_path)) {
      			if (!add_data->force) {
    - 				fprintf(stderr, _("A git directory for '%s' is found "
    +-				fprintf(stderr, _("A git directory for '%s' is found "
     -						  "locally with remote(s):"),
    -+						  "locally with remote(s):\n"),
    - 					add_data->sm_name);
    - 				show_fetch_remotes(stderr, add_data->sm_name,
    +-					add_data->sm_name);
    +-				show_fetch_remotes(stderr, add_data->sm_name,
    ++				struct strbuf msg = STRBUF_INIT;
    ++				char *die_msg;
    ++
    ++				strbuf_addf(&msg, _("A git directory for '%s' is found "
    ++						    "locally with remote(s):\n"),
    ++					    add_data->sm_name);
    ++
    ++				show_fetch_remotes(&msg, add_data->sm_name,
      						   submod_gitdir_path);
    -@@ builtin/submodule--helper.c: static int add_submodule(const struct add_data *add_data)
    - 				      "use the '--force' option. If the local git "
    - 				      "directory is not the correct repo\n"
    - 				      "or if you are unsure what this means, choose "
    + 				free(submod_gitdir_path);
    +-				die(_("If you want to reuse this local git "
    +-				      "directory instead of cloning again from\n"
    +-				      "  %s\n"
    +-				      "use the '--force' option. If the local git "
    +-				      "directory is not the correct repo\n"
    +-				      "or if you are unsure what this means, choose "
     -				      "another name with the '--name' option.\n"),
    -+				      "another name with the '--name' option."),
    - 				    add_data->realrepo);
    +-				    add_data->realrepo);
    ++
    ++				strbuf_addf(&msg, _("If you want to reuse this local git "
    ++						    "directory instead of cloning again from\n"
    ++						    "  %s\n"
    ++						    "use the '--force' option. If the local git "
    ++						    "directory is not the correct repo\n"
    ++						    "or you are unsure what this means choose "
    ++						    "another name with the '--name' option."),
    ++					    add_data->realrepo);
    ++
    ++				die_msg = strbuf_detach(&msg, NULL);
    ++				die("%s", die_msg);
      			} else {
      				printf(_("Reactivating local git directory for "
    + 					 "submodule '%s'\n"), add_data->sm_name);
-- 
2.32.0.385.gc00617bc03.dirty

