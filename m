Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72E9C4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 07:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbiL3H2s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 02:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbiL3H21 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 02:28:27 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA07C18B3B
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 23:28:26 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so12261510wmb.2
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 23:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glxLF5JOMMBpOG/qOaZ0p4DH53k460H30pO9Y+0fzp4=;
        b=jc7fagUZPqHNU7gc28zj18GgIApq/Foqrt+lRMSwmB84t7CxeaK5P4ueUS0UlRlXNf
         O+rAUeuuR8E7nhi12V+828z5JnpjSkcaWls8gBWA5Kbr/17ftBOmY4675pUTg5BBWSNx
         qt5ihKKLx+NuKQlo8R4fAeyQrL4HnE3l5038aWmRvVDAtsHIcElc4+v0ir4Eb+7KN5vi
         VOT5CmN2iyXZw98+nTKWfZQg/D//fmgizUzXKQFXhAi3Jukh9Amjpy4BaNf768WtO1Mo
         IjK6n6KH5C1lZxN9qxImTnn1BeE1SRORmVqCHwF5mYiYgULR0YvVedTfOBo3E+WyF+87
         an6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glxLF5JOMMBpOG/qOaZ0p4DH53k460H30pO9Y+0fzp4=;
        b=ThWbig8QLfhH7wB7q7evazS5DUI3BTBMqK3m4rLDedjIxhNCp6KSFhjqdCMcua3LXy
         J8ZTZBoX539Bv6tGDW6UpZwlbqoLazcFuaVE5TiZB/iZgH3jnqABTjkqoinP6Ti45SYe
         O+xMfirn3f9BT7VOac5RZR+oPL40omf32FxGM0APJZqcoBeXapt/fkTFH19gn5h/21/k
         Gub/ImIC2q1kHiOsRvwdZTsSqEjna90cRJv68Y//DssQp6Vt/GRkev61SGToxl+WeJuD
         Z9Ix4nSkucAH25z0gvPwtN6kmqwnU9kJ8pE9f7Dpaxg8kBpDHz0Ph7ScPZ50CtDjOhIR
         kEAA==
X-Gm-Message-State: AFqh2ko1dn8ly4f2ILUkrfjeCRmG4nFSZYoJG1AqbogVk+GYdapayNrp
        0Xt5aZTR18j27EQRb2iWxS7LAfhRnVVQ7w==
X-Google-Smtp-Source: AMrXdXtQerBAqhIf6TxTTV0o22TRyGeQDT5HCjirrf0O5rB1uDTNQbxb34pcjIvuOEd186C6LCQagQ==
X-Received: by 2002:a05:600c:1e10:b0:3d3:404a:8a1a with SMTP id ay16-20020a05600c1e1000b003d3404a8a1amr25262053wmb.11.1672385306078;
        Thu, 29 Dec 2022 23:28:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b003d998412db6sm6526449wmn.28.2022.12.29.23.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 23:28:25 -0800 (PST)
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
Subject: [PATCH 08/10] sequencer.c: always free() the "msgbuf" in do_pick_commit()
Date:   Fri, 30 Dec 2022 08:28:13 +0100
Message-Id: <patch-08.10-d607dbac38e-20221230T071741Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
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
we added another place where we'd "return" before reaching the
strbuf_release().

Let's move it to a "cleanup" label, and use an appropriate "goto". It
may or may not be safe to combine the existing "leave" and "cleanup"
labels, but this change doesn't attempt to answer that question. Let's
instead avoid calling update_abort_safety_file() in these cases, as we
didn't do so before.

1. 452202c74b8 (sequencer: stop releasing the strbuf in
   write_message(), 2016-10-21)
2. f241ff0d0a9 (prepare the builtins for a libified merge_recursive(),
   2016-07-26)
3. 6e98de72c03 (sequencer (rebase -i): add support for the 'fixup' and
   'squash' commands, 2017-01-02)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sequencer.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 47367e66842..db8d789fa76 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2280,8 +2280,10 @@ static int do_pick_commit(struct repository *r,
 		reword = 1;
 	else if (is_fixup(command)) {
 		if (update_squash_messages(r, command, commit,
-					   opts, item->flags))
-			return -1;
+					   opts, item->flags)) {
+			res = -1;
+			goto cleanup;
+		}
 		flags |= AMEND_MSG;
 		if (!final_fixup)
 			msg_file = rebase_path_squash_msg();
@@ -2291,9 +2293,11 @@ static int do_pick_commit(struct repository *r,
 		} else {
 			const char *dest = git_path_squash_msg(r);
 			unlink(dest);
-			if (copy_file(dest, rebase_path_squash_msg(), 0666))
-				return error(_("could not rename '%s' to '%s'"),
-					     rebase_path_squash_msg(), dest);
+			if (copy_file(dest, rebase_path_squash_msg(), 0666)) {
+				res = error(_("could not rename '%s' to '%s'"),
+					    rebase_path_squash_msg(), dest);
+				goto cleanup;
+			}
 			unlink(git_path_merge_msg(r));
 			msg_file = dest;
 			flags |= EDIT_MSG;
@@ -2331,7 +2335,6 @@ static int do_pick_commit(struct repository *r,
 		free_commit_list(common);
 		free_commit_list(remotes);
 	}
-	strbuf_release(&msgbuf);
 
 	/*
 	 * If the merge was clean or if it failed due to conflict, we write
@@ -2403,9 +2406,11 @@ static int do_pick_commit(struct repository *r,
 	}
 
 leave:
+	update_abort_safety_file();
+cleanup:
 	free_message(commit, &msg);
 	free(author);
-	update_abort_safety_file();
+	strbuf_release(&msgbuf);
 
 	return res;
 }
-- 
2.39.0.1153.g589e4efe9dc

