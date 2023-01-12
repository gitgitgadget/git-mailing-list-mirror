Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB838C54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 12:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjALMqj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 07:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjALMqP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 07:46:15 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CC93BB
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:46:13 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id fy8so44344767ejc.13
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxzqBi9vERRV4a3rFM7b/HTLMVqDPOMu5xPyScSsmYc=;
        b=NSdqRka0vcXeTjLBBvtg0oHIDf+FiefPq8pJ5ZdCcNsIlj/AHlSChSgG2IH8ZcL3bE
         YkymMVfwOQe3kd6yz7jVUxoG9neU2NOi+Jzadhv4kDwTqJIh30mbcuVtInaUJYms9HS3
         E5ftPtsxsGEMURgGJwqAIVH49pvEVw0P+FXsS1E44IZOTBks8wianG6oHT59hTZj4h17
         u5SUEniFkTL4+z1tAJqhbmwkJ7e96JwmhX/U0mHdD7MNQ2PxvWtSWHNjx8gMoWAkZrzo
         +aPkNOs4n1E59NkV3FHDrr8NMnfSJZy8tzDTEumkYI4Lfzt/YGqAWgk5/+fwa85zlEQ1
         1jsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxzqBi9vERRV4a3rFM7b/HTLMVqDPOMu5xPyScSsmYc=;
        b=fY3CHDE5Y0Gap42EyUEy8uHZL5E02xVEqQFkpTP9gaD6L9Z/A0hUpozPcgC219Grfh
         2AuPnx6hGQAxr4qX1HneGKX93NqlgzABtyhZz0nhwWBY8jVdoo8HW70zc9tsWzqlxmfm
         hti6sRQWIFpuSfG4hI/ZJIi5zVCsgqAnHD9g/sA50Am9Z9X8hE9BO0FVp+/QwGqRc4mS
         Bpfss/wk6FnWavjEeZ84vJKsUdAOwKPKwTKT7srkcqo/Sll3HxVLCFcQpxxd9eCmNHH7
         zHV6LbwdCs3vfcmNztVcx2lKe8jkbdPPfCF2PJNUXIyV6mU8fFiKM+Jbh6/4csi1NkuI
         v0Hg==
X-Gm-Message-State: AFqh2kprpjd1TKAMyzj1grBPJGKOgvHWPfYidJOV5wI0+yahnjElH7+G
        G73qwHa71SF/RLL5S9syarPGbktjgp18OA==
X-Google-Smtp-Source: AMrXdXv7Ul76BJukvxpI5XHcjF16WqMPf8xPceryVemk9nXA3Tpx9njzqnme84mtgiSdtKmZoDJYyQ==
X-Received: by 2002:a17:907:8744:b0:7c1:277:cb05 with SMTP id qo4-20020a170907874400b007c10277cb05mr83187658ejc.6.1673527571775;
        Thu, 12 Jan 2023 04:46:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v17-20020a170906293100b007be301a1d51sm7373523ejd.211.2023.01.12.04.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:46:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/9] sequencer.c: always free() the "msgbuf" in do_pick_commit()
Date:   Thu, 12 Jan 2023 13:45:59 +0100
Message-Id: <patch-v2-7.9-fb38dc873f9-20230112T124201Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1205.g2ca064edc27
In-Reply-To: <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In [1] the strbuf_release(&msgbuf) was moved into this
do_pick_commit(), but didn't take into account the case of [2], where
we'd return before the strbuf_release(&msgbuf).

Then when the "fixup" support was added in [3] this leak got worse, as
in this error case we added another place where we'd "return" before
reaching the strbuf_release().

This changes the behavior so that we'll call
update_abort_safety_file() in these cases where we'd previously
"return", but as noted in [4] "update_abort_safety_file() is a no-op
when rebasing and you're changing code that is only run when
rebasing.". Here "no-op" refers to the early return in
update_abort_safety_file() if git_path_seq_dir() doesn't exist.

1. 452202c74b8 (sequencer: stop releasing the strbuf in
   write_message(), 2016-10-21)
2. f241ff0d0a9 (prepare the builtins for a libified merge_recursive(),
   2016-07-26)
3. 6e98de72c03 (sequencer (rebase -i): add support for the 'fixup' and
   'squash' commands, 2017-01-02)
4. https://lore.kernel.org/git/bcace50b-a4c3-c468-94a3-4fe0c62b3671@dunelm.org.uk/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sequencer.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index c729ce77260..31ea9b036cd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2278,8 +2278,10 @@ static int do_pick_commit(struct repository *r,
 		reword = 1;
 	else if (is_fixup(command)) {
 		if (update_squash_messages(r, command, commit,
-					   opts, item->flags))
-			return -1;
+					   opts, item->flags)) {
+			res = -1;
+			goto leave;
+		}
 		flags |= AMEND_MSG;
 		if (!final_fixup)
 			msg_file = rebase_path_squash_msg();
@@ -2289,9 +2291,11 @@ static int do_pick_commit(struct repository *r,
 		} else {
 			const char *dest = git_path_squash_msg(r);
 			unlink(dest);
-			if (copy_file(dest, rebase_path_squash_msg(), 0666))
-				return error(_("could not rename '%s' to '%s'"),
-					     rebase_path_squash_msg(), dest);
+			if (copy_file(dest, rebase_path_squash_msg(), 0666)) {
+				res = error(_("could not rename '%s' to '%s'"),
+					    rebase_path_squash_msg(), dest);
+				goto leave;
+			}
 			unlink(git_path_merge_msg(r));
 			msg_file = dest;
 			flags |= EDIT_MSG;
@@ -2329,7 +2333,6 @@ static int do_pick_commit(struct repository *r,
 		free_commit_list(common);
 		free_commit_list(remotes);
 	}
-	strbuf_release(&msgbuf);
 
 	/*
 	 * If the merge was clean or if it failed due to conflict, we write
@@ -2403,6 +2406,7 @@ static int do_pick_commit(struct repository *r,
 leave:
 	free_message(commit, &msg);
 	free(author);
+	strbuf_release(&msgbuf);
 	update_abort_safety_file();
 
 	return res;
-- 
2.39.0.1205.g2ca064edc27

