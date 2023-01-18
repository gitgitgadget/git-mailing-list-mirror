Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB14AC38159
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 16:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjARQOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 11:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjARQNh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 11:13:37 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602403250E
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:09:32 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id kt14so25531742ejc.3
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5LVRAk+TBXjsdmx9T0iYBzU2Pp235dr80UzXOD8kjo=;
        b=aL77JgG/eiq1TCoaWl+1TD+Xd8YGjRwpjg8eDMrfMazI8NndMZFkup2apsrGrs3LfY
         U3Vcx8It4TeGkivzlsc2BiBQYSqa8kJ9E/r70AkiIyJwesd/9jjgu5b6fJJBRnyypBkm
         A1qSeTQWKmnVqe1cyFvnpOumFqNTDQc7tep5unn+ueM0uoM0GBivekT4srvZyUuWkKqi
         aoc2kOTyYbfWRJy9kwspbMZggOXTdRRHHFwfOju4RnDsygozgHT8QV7LeY66rVerRDtR
         MB+gqDlKXlDG9lDNrs8RSk+dys+NaNnDxqCmQBeW94Izo9B++MZdHHPVZgeESuUzHHME
         uKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5LVRAk+TBXjsdmx9T0iYBzU2Pp235dr80UzXOD8kjo=;
        b=3Oak4pcv/V0dUlRXz46qSCk/e/YXk39O9u1FMb2HjPgdf2KotdBkvTAU72/YrErs4H
         uAM6OeME6oPCMfxkejzgaz7KRAPdu3tlmm4XafTgcVj3nAS5usWF4eGyv9U/88goPQ/0
         Rp5vrn3289qafw5N8jVzT1GIvFO3uXrMRzVctEKe4WJ/g6urzEFt4oYiW0Sb28tH5J8i
         o1k7bg27AmdtdaSaStyoPcdRAJPYKpMr8i7vQyQhZHdw4NMB791jVCdRfmBgIJ7satrn
         GDpIVJp0D4IwFf4+dEi7pO6B0qDHh+Izd2pGSltbmYgstXUld+nzCuBuY+JuQfreyo9A
         8n3w==
X-Gm-Message-State: AFqh2kqZdgdvn0vVAR5pMX7eDJrmUpyrlWwBZ6VtkmTlHYeKlKi/9kAS
        Hu3Vt3gdhlr1i2oTCEIDHQQOnPI+4sPeDA==
X-Google-Smtp-Source: AMrXdXtDcOUGIzfvQQgQiIazpJ++9EdQhNWTH7rWKBglDIlHqQ01b5er/0e7f5Vw5AknsJHOVT/RLA==
X-Received: by 2002:a17:906:af94:b0:86d:bbf9:302 with SMTP id mj20-20020a170906af9400b0086dbbf90302mr7293680ejb.20.1674058170486;
        Wed, 18 Jan 2023 08:09:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id du1-20020a17090772c100b0084bfd56fb3bsm14778202ejc.162.2023.01.18.08.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:09:30 -0800 (PST)
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
Subject: [PATCH v3 6/8] sequencer.c: always free() the "msgbuf" in do_pick_commit()
Date:   Wed, 18 Jan 2023 17:09:14 +0100
Message-Id: <patch-v3-6.8-c07dc006c6d-20230118T160600Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v3-0.8-00000000000-20230118T160600Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20230118T160600Z-avarab@gmail.com>
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
index ea568d99498..2c5ed5bc5ea 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2277,8 +2277,10 @@ static int do_pick_commit(struct repository *r,
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
@@ -2288,9 +2290,11 @@ static int do_pick_commit(struct repository *r,
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
@@ -2328,7 +2332,6 @@ static int do_pick_commit(struct repository *r,
 		free_commit_list(common);
 		free_commit_list(remotes);
 	}
-	strbuf_release(&msgbuf);
 
 	/*
 	 * If the merge was clean or if it failed due to conflict, we write
@@ -2402,6 +2405,7 @@ static int do_pick_commit(struct repository *r,
 leave:
 	free_message(commit, &msg);
 	free(author);
+	strbuf_release(&msgbuf);
 	update_abort_safety_file();
 
 	return res;
-- 
2.39.0.1225.g30a3d88132d

