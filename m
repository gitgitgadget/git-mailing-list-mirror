Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAFAECAAD5
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237830AbiIEI3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237825AbiIEI2y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:28:54 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BE84D4C0
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id d12-20020a05600c34cc00b003a83d20812fso5240780wmq.1
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hE+NAD0FxgHACXQkqSNov8aXu6IkDtYJhLaTXizEtjQ=;
        b=HmQdQpaz3NGciC6jaYXfJM+tgu166O0S36panxNDC+ovVKdusuKh1NiOwxi9J/k1CX
         N9pzB7GbnZd8+fq/87tHCdtuO1mXfvH+/h/4Sfu7Iv19WS/MK9ppN5JXCkDNkFvZuowg
         RxGm2OkvpLeZDfNYd/C7wVGCKMTHkJjGiOAUHc/FXCG4CUXosTpjDqy7SDe2Gpl6wOr3
         1H4HbrrpDGW5yUZWKbYTbev8a76WD2vdpLFb5Qc8Mij6a46UwMLX7OBrMahGDgtX5z8i
         FtFr1+i4DHmDul4Z/6dczUkW7zUhEOraVqFHoopyN91vTnwpuYmN0L2c4PhVlRgngx1D
         BoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hE+NAD0FxgHACXQkqSNov8aXu6IkDtYJhLaTXizEtjQ=;
        b=k4NtxNIZlaCoPVcRBVieu8uJsz/vufFqlYP7Qs9yvCdXa0JvatJhj1uV+aswG+FNnJ
         Ls3PBmRAuEiiX83AvwCBGUL8esASzmqHDeIXaHK/s1z0BE0IZyzhEyH6Nq7xBkkr4JWC
         qf0Mj0FdSJLwl2CmRXi7YC8DOgYJvsNRW8RIlGjTSRdKWfkyFGDMIgERth9sXrsWDopT
         xj4IdgtzBodxucPRh9fturwuf+n/bE+eBNNkil89NTcB12V7ZTajEEjC0QBY1ahL9tpD
         ncToPWhvyx9JetUy+nAH+QHEgTO098KfSDsGAfWxnlWEwMpGST/IkgMlsXgjucvHMMy+
         Qowg==
X-Gm-Message-State: ACgBeo3thhUT1GdijVBlqalwgADBIKv+gXaHl3b68yGK/QiTZ6KiMkS7
        7pn37oOcDpWKIKaYoYxr0rnNOEyxa6dCwA==
X-Google-Smtp-Source: AA6agR4fS6gkg7B9orFdrBZVz8OizLGOKEAM1pKNYRX/OSz3FkWI1gTGkCeE7toQ3412INL80LlJ7w==
X-Received: by 2002:a1c:f016:0:b0:3a8:3d3b:6b8a with SMTP id a22-20020a1cf016000000b003a83d3b6b8amr9933855wmb.168.1662366442124;
        Mon, 05 Sep 2022 01:27:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:27:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 31/34] reflog doc: list real subcommands up-front
Date:   Mon,  5 Sep 2022 10:26:42 +0200
Message-Id: <patch-31.34-5da768a04bc-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "git reflog" documentation to exhaustively list the
subcommands it accepts in the SYNOPSIS, as opposed to leaving that for
a "[verse]" in the DESCRIPTION section. This documentation style was
added in cf39f54efc6 (git reflog show, 2007-02-08), but isn't how
other commands which take subcommands are documented.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-reflog.txt | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 0537d4645be..ec64cbff4c6 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -8,14 +8,6 @@ git-reflog - Manage reflog information
 
 SYNOPSIS
 --------
-[verse]
-'git reflog' <subcommand> <options>
-
-DESCRIPTION
------------
-The command takes various subcommands, and different options
-depending on the subcommand:
-
 [verse]
 'git reflog' [show] [<log-options>] [<ref>]
 'git reflog expire' [--expire=<time>] [--expire-unreachable=<time>]
@@ -25,6 +17,10 @@ depending on the subcommand:
 	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
 'git reflog exists' <ref>
 
+DESCRIPTION
+-----------
+This command manages the information recorded in the reflogs.
+
 Reference logs, or "reflogs", record when the tips of branches and
 other references were updated in the local repository. Reflogs are
 useful in various Git commands, to specify the old value of a
@@ -33,7 +29,8 @@ moves ago", `master@{one.week.ago}` means "where master used to point
 to one week ago in this local repository", and so on. See
 linkgit:gitrevisions[7] for more details.
 
-This command manages the information recorded in the reflogs.
+The command takes various subcommands, and different options
+depending on the subcommand:
 
 The "show" subcommand (which is also the default, in the absence of
 any subcommands) shows the log of the reference provided in the
-- 
2.37.3.1425.g73df845bcb2

