Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFD4C63777
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 18:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 756C220773
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 18:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Busj39v5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1827171AbgJ0SVy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 14:21:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37156 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753811AbgJ0OCX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 10:02:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id w1so2059999wrm.4
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 07:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qJ+aTUDBZYP1HQbTAMXG2iRa0Q9j/4pzu9dS15D1wYs=;
        b=Busj39v5UvJKN4Czwp45b9BTJh0ogHCR0rYnzg5UUZwyhxcXYbx7lgOmocWEnNAIl3
         eG2v6FSlIFJDP/MSOpG1uDd3nbVZ8l8a9eHrLa+rj8Q8DOBCeJ27ZiJKx4MueEf8CWNv
         1ZWG5VmpmTvWB6HS10h0GLesoH7hnvyDKVdoKqK1AYDIRlXflqyAfMlG3LC6EcHCU1x+
         gns8CvHOJhneRqMkYtlZZV57mZXR1o/2La5eKEU0ppIHuM+wumsFiyKmAf+e4xwXadNS
         Kwn7TCtrTewSv4lS1/UKh/Er3Aw7rE/FuUF85WZRTM6I0DoTSR6Ab+D8MdTve0WmCNGA
         A3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qJ+aTUDBZYP1HQbTAMXG2iRa0Q9j/4pzu9dS15D1wYs=;
        b=iXVp28fItG7MHDatJHw9eM8EMqMLie1GOXw4dEaIQXwMZ360+yD8tMmmvdtK6vBBlE
         w+CMMytsk92juLlI8BWHGxJ1Ost5/eJeawFaKScgxijzj7zLfjt8PBOeyOVE553HT12g
         Eea6Y8dJYCRPc1SyquAfDsZAcFvxWqab/TgyWMcs3xnqMGnNH7qBfwLerfy5VXrs4IsR
         xf9vHeR/lMTMWsa5vsXsr0ie9hASXWBNicXKzCidPCc945MZ2X900eHkZpdWbwnbKmKe
         o0QCW+REcz5QcyblSk+LaJs14soFyZLhoW8ubCqYznYMcdYzbgBfkVMVrMR43kKweUiD
         gtmg==
X-Gm-Message-State: AOAM531SHUh6Cw0aQ8Nn8utP8sut/e5olBpGEdxaqsR6NCFPuIhqYiLG
        v9pwpj0G8rEIPlVae7SbzVC4MjIq9ls=
X-Google-Smtp-Source: ABdhPJze9zY8ToPbmQb3CcavM/U95yfLRPz6OhIUEtRRRBK9QimZHp2Z1wpIlBJ2/R7gc6n3bsxUJQ==
X-Received: by 2002:a5d:4f0b:: with SMTP id c11mr3015636wru.316.1603807341098;
        Tue, 27 Oct 2020 07:02:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d20sm2200976wra.38.2020.10.27.07.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 07:02:20 -0700 (PDT)
Message-Id: <589aed08f18c50979c210ca97c6dc0a01eac76c3.1603807338.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.773.git.1603807337.gitgitgadget@gmail.com>
References: <pull.773.git.1603807337.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Oct 2020 14:02:15 +0000
Subject: [PATCH 2/4] rebase -i: use struct object_id rather than looking up
 commit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Caspar Duregger <herr.kaste@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

We already have a struct object_id containing the oid that we want to
set ORIG_HEAD to so use that rather than converting it to a string and
then calling get_oid() on that string.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c |  5 +++--
 sequencer.c      | 10 +++-------
 sequencer.h      |  5 +++--
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6def28a533..d975918de6 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -370,8 +370,9 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 
 		split_exec_commands(opts->cmd, &commands);
 		ret = complete_action(the_repository, &replay, flags,
-			shortrevisions, opts->onto_name, opts->onto, head_hash,
-			&commands, opts->autosquash, &todo_list);
+			shortrevisions, opts->onto_name, opts->onto,
+			&opts->orig_head, &commands, opts->autosquash,
+			&todo_list);
 	}
 
 	string_list_clear(&commands, 0);
diff --git a/sequencer.c b/sequencer.c
index 00acb12496..f79c3df861 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3965,21 +3965,17 @@ static int run_git_checkout(struct repository *r, struct replay_opts *opts,
 
 static int checkout_onto(struct repository *r, struct replay_opts *opts,
 			 const char *onto_name, const struct object_id *onto,
-			 const char *orig_head)
+			 const struct object_id *orig_head)
 {
-	struct object_id oid;
 	const char *action = reflog_message(opts, "start", "checkout %s", onto_name);
 
-	if (get_oid(orig_head, &oid))
-		return error(_("%s: not a valid OID"), orig_head);
-
 	if (run_git_checkout(r, opts, oid_to_hex(onto), action)) {
 		apply_autostash(rebase_path_autostash());
 		sequencer_remove_state(opts);
 		return error(_("could not detach HEAD"));
 	}
 
-	return update_ref(NULL, "ORIG_HEAD", &oid, NULL, 0, UPDATE_REFS_MSG_ON_ERR);
+	return update_ref(NULL, "ORIG_HEAD", orig_head, NULL, 0, UPDATE_REFS_MSG_ON_ERR);
 }
 
 static int stopped_at_head(struct repository *r)
@@ -5314,7 +5310,7 @@ static int skip_unnecessary_picks(struct repository *r,
 
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
-		    struct commit *onto, const char *orig_head,
+		    struct commit *onto, const struct object_id *orig_head,
 		    struct string_list *commands, unsigned autosquash,
 		    struct todo_list *todo_list)
 {
diff --git a/sequencer.h b/sequencer.h
index b2a501e445..ea56825488 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -163,8 +163,9 @@ void todo_list_add_exec_commands(struct todo_list *todo_list,
 				 struct string_list *commands);
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
-		    struct commit *onto, const char *orig_head, struct string_list *commands,
-		    unsigned autosquash, struct todo_list *todo_list);
+		    struct commit *onto, const struct object_id *orig_head,
+		    struct string_list *commands, unsigned autosquash,
+		    struct todo_list *todo_list);
 int todo_list_rearrange_squash(struct todo_list *todo_list);
 
 /*
-- 
gitgitgadget

