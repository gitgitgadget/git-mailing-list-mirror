Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA54FC38147
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 16:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjARQOS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 11:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjARQNg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 11:13:36 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE57303E3
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:09:30 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id vw16so21276642ejc.12
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqE5wxpe0Zeqdrb9j7YRheUEknF+3PccLdohqn+TZAo=;
        b=DHs+Hd1vARWTtARESmgtyWinMqYNhAtN/oVJ8KirenWpByvpxtNX+/XtGfn0R2udoh
         TVrzHY7JQpYM81g3hpesNGj8AQc0j4SEH1CGJ9lPQV6w1Pl0EsE9IzLwwhiyefvdXUcu
         aWLQ/4rQD5iuxKMsUeAYhH9R1uBCWRTt77JmlY3otVIlXb1Hpc+9zkjcZP/NIIGxHqkX
         oHsyvmC6kmwnxPlaAUuELA1YhjmeM76xv0ocs/g5HVYOkyd1di9AklKOs1rWrbuiNiDH
         HS2cdjWmVVy/lXO4p/Qhbe0no8eH84poYrEy1h1Nm3jVXZnrr0jHWxU8fdmBMmaxT2qB
         M32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqE5wxpe0Zeqdrb9j7YRheUEknF+3PccLdohqn+TZAo=;
        b=AErJ3jo7nYwoGN7tje5vJnzxmLRp4F46W9V49UoO/+yToaSRmvRIObBlddJYx6cae6
         2gktJaQE/F+y4watrAvbOLrOrVyAfLuIi/alywovxTX7DWaCKXiVZ1jxdNrNM5dbl31r
         9JOQ2Bq4Q4UXmG66KIGA5KC4RkCfjy0EL5ylTnT7mXFgyL+DgcZZY4CKdpjLhsDpTKtW
         7xJOt/bvgNGiQnb0vHxvL6AHJ9KGVjzdq4CpE+r4McXDfX24ifBQt3racXOMGnjOKADl
         Uh/XuujwF3joUujKTehNHzOAPCDZhVYRMif7GLAVyAHc4TFBn4ZaD6bIIsTOIJECw32F
         xaZw==
X-Gm-Message-State: AFqh2kqunbUsB4l1iiFq1eYn4Oerq6L/RAv6jq2aXwwQO59X+oioq4mB
        cPgsAq7TpFMl82K1+rT2QU8ZXhP+/I+TvA==
X-Google-Smtp-Source: AMrXdXv0CGaKgOxUxzg4qCtJouv7I1gAioNakDwaoeMri6pi80GMWYlq3S1hsUvTpF6wHhKPBis6MQ==
X-Received: by 2002:a17:907:3e18:b0:84d:3403:f4f2 with SMTP id hp24-20020a1709073e1800b0084d3403f4f2mr10292368ejc.62.1674058169071;
        Wed, 18 Jan 2023 08:09:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id du1-20020a17090772c100b0084bfd56fb3bsm14778202ejc.162.2023.01.18.08.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:09:28 -0800 (PST)
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
Subject: [PATCH v3 4/8] builtin/revert.c: move free-ing of "revs" to replay_opts_release()
Date:   Wed, 18 Jan 2023 17:09:12 +0100
Message-Id: <patch-v3-4.8-9f72cc6e46b-20230118T160600Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v3-0.8-00000000000-20230118T160600Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20230118T160600Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In [1] and [2] I added the code being moved here to cmd_revert() and
cmd_cherry_pick(), now that we've got a "replay_opts_release()" for
the "struct replay_opts" it should know how to free these "revs",
rather than having these users reach into the struct to free its
individual members.

1. d1ec656d68f (cherry-pick: free "struct replay_opts" members,
   2022-11-08)
2. fd74ac95ac3 (revert: free "struct replay_opts" members, 2022-07-01)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/revert.c | 6 ------
 sequencer.c      | 3 +++
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 1cab16bf3ed..77d2035616e 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -248,9 +248,6 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	res = run_sequencer(argc, argv, &opts);
 	if (res < 0)
 		die(_("revert failed"));
-	if (opts.revs)
-		release_revisions(opts.revs);
-	free(opts.revs);
 	replay_opts_release(&opts);
 	return res;
 }
@@ -263,9 +260,6 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	opts.action = REPLAY_PICK;
 	sequencer_init_config(&opts);
 	res = run_sequencer(argc, argv, &opts);
-	if (opts.revs)
-		release_revisions(opts.revs);
-	free(opts.revs);
 	if (res < 0)
 		die(_("cherry-pick failed"));
 	replay_opts_release(&opts);
diff --git a/sequencer.c b/sequencer.c
index 8ff29262c1e..ea568d99498 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -361,6 +361,9 @@ void replay_opts_release(struct replay_opts *opts)
 		free(opts->xopts[i]);
 	free(opts->xopts);
 	strbuf_release(&opts->current_fixups);
+	if (opts->revs)
+		release_revisions(opts->revs);
+	free(opts->revs);
 }
 
 int sequencer_remove_state(struct replay_opts *opts)
-- 
2.39.0.1225.g30a3d88132d

