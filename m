Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231FBC05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 19:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjBFTJH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 14:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjBFTI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 14:08:59 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860B32BF03
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 11:08:51 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id z13so1934684wmp.2
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 11:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FH5CnGvT3cO9J+OsZV/Kygt9niVnkntJ9qiB2eN/Dw=;
        b=n1tbzG6sgISAk8zjCy0pHJTPHswHlyjdz8IXcEXcchQikkdQcEVSChPEwwPcOVyJ7T
         9niei7p79D+JUSU6eZz8kcUTDIPPnt9NOpovAFb3lyVmUr121iDQ7zC2DXoLSdEgs7t0
         5LeCcso089YMpC6ZPIRvwsNah0cHiUHTay+4b0DhDx+lUavdRMdfoTM31RjlTH9epsJf
         SHogg6nF5B11V5/fKUskk2xez661fQyOWhBZ03O9eq74aGwQqQ4reMIu3ADx3J2W2Xol
         AZiHoQbOKSdDSzd2OyGabLHClcWmleSmXw+pZoSdMrs+TgI2URAhUxCM34fR+Q5kKUMz
         RkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FH5CnGvT3cO9J+OsZV/Kygt9niVnkntJ9qiB2eN/Dw=;
        b=61qLro7gwfGYf6ydU7QU0cElQDV3jmGCE9wrVNtyaDZ4dcrT7w5PdcvsYdyxnhki5/
         MFsqZc8o3h92f/HiaEAXPx1C5UwIDEtrG5TudR2n0K32U4RltrkmhNiNn646U/mGYd0o
         9bbqwzMrWo+BPYDlnQrMTa1iiL/lWfiwdIVVJMyl8O7/bfpf6lo96FxHEnJyhuyzIL+U
         OsUbAyZD2d1OBt18CobamFoy1ihV2E8dlK+Vrf1dKiK4Bk8TVvTrEtv5OlWzT8lDYjCL
         ZeGLvWHivvL1zp0ErtH3vrnq34UDjCpXBgGlppf7o8qxlurUEpBYJuDSvmgZbyxHz7E/
         zyow==
X-Gm-Message-State: AO0yUKVI9aMg90su1II2Nmf9t2wKhErAoxgINDYdpF9WdDu601/WMVwa
        Z8mvhs+miqAKoO9TnaHlpoiHwUsptcYcl6Py
X-Google-Smtp-Source: AK7set9mNWdMUKtQQPGgQ1jxhmbbAQRX1fJWUNkTk5OLod9jtduldUtM7Csq5zo1HAmEb+DpcISbyA==
X-Received: by 2002:a05:600c:1817:b0:3db:8de:6993 with SMTP id n23-20020a05600c181700b003db08de6993mr457741wmp.4.1675710530475;
        Mon, 06 Feb 2023 11:08:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p2-20020a05600c358200b003dc4ecfc4d7sm12538595wmq.29.2023.02.06.11.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 11:08:50 -0800 (PST)
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
Subject: [PATCH v4 6/8] sequencer.c: always free() the "msgbuf" in do_pick_commit()
Date:   Mon,  6 Feb 2023 20:08:11 +0100
Message-Id: <patch-v4-6.8-5c2870ed2e6-20230206T190346Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.ge02fe682bd8
In-Reply-To: <cover-v4-0.8-00000000000-20230206T190346Z-avarab@gmail.com>
References: <patch-v3-7.8-ee8262ab22a-20230118T160600Z-avarab@gmail.com> <cover-v4-0.8-00000000000-20230206T190346Z-avarab@gmail.com>
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
index cb4b1ce062c..fb23f734ade 100644
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
2.39.1.1425.ge02fe682bd8

