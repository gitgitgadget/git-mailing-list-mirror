Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046C7ECAAA1
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbiIEI3P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237801AbiIEI2r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:28:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA683F30B
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:22 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id s23so4840514wmj.4
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WcKxuRliNV6qJx1fVacssCRPGoydlQioIRXOBQHGJ28=;
        b=Jexx1/mtHQeqtOxw4Fvih1xpi7w9C4SvvuIHgUoema2Qw5c07A1JKs8FwVjlNT36Bp
         u2ES3t77cK+gVL+WmQrQtPLFcx67qnk2AAKvsPlEEeJ5af+dStzhlDtmN9QW5dN1qjf4
         19AYD4IMT1UxGB9RjmJ2oX9uathr/p3Q5p23zwE7fWHzRYXxAOkctEOyfSD15kZwIXRJ
         R+p7/kKu+ilRi25FD6k2DWgWA/NYK4WZXkhnavT5Xuox3hxi0nnxpJvr4jSVIyNmF9Ka
         U2hSAUSZjXp/emeKMrZMHQPOt5Lkhn/iu5ZiVgpVGAjtw7pt/FXM0BMcOhIS8N9KrjFs
         heCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WcKxuRliNV6qJx1fVacssCRPGoydlQioIRXOBQHGJ28=;
        b=DQr/hEsG5zyMctOE4r4TZsn+dugERifU271FO8T9PPOfrhFZyNv861EepTNDQNWNnM
         frcG8yxP5iwBScInOFV4RtI2PSjrog+zCswMNnt8V4FjK2WF58I2x9ULaMoF0QvHC+8P
         htcMNiOaQb+VeHRAbb/gYa/NKOdQFXGlqDa/bRWJk4SvwbF4kQQN1PhXNdnkDd6cRz7N
         ZDon4DdGTl0uN3Tc2h6MLjisusPbQ42+C6gFBaPYXLby58i5Z3AHVn4iZNp3bFkISXYE
         +xccGy+gsbGuelcP7LTOjEcWmLQZ52OhOSs6kgyJRsvOV8L8bnz/taGYWTtO8+Z9XqTE
         +nOg==
X-Gm-Message-State: ACgBeo2/p77iHK3fYyTKcIISVpQiFNUqqHY6zDvGyXbq6iXCGduDtykX
        dijHCTdARFOgCj3Cb3MMAdIsF3KjdniFcA==
X-Google-Smtp-Source: AA6agR5Wi4EvV4rHqVAMF4ZpPIHaf/LnP89ndmp2DJ2gFADkH3RdZK7+sB9INyIlkv7MDtDz1FnzKQ==
X-Received: by 2002:a05:600c:1551:b0:3a6:2f4d:aeca with SMTP id f17-20020a05600c155100b003a62f4daecamr9768094wmg.100.1662366440008;
        Mon, 05 Sep 2022 01:27:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:27:19 -0700 (PDT)
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
Subject: [PATCH 29/34] doc txt & -h consistency: make "diff-tree" consistent
Date:   Mon,  5 Sep 2022 10:26:40 +0200
Message-Id: <patch-29.34-dc32043b203-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the "diff-tree -h" output consistent with the *.txt version.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/diff-tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 23f58702fa0..85e8c81e594 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -83,8 +83,9 @@ static int diff_tree_stdin(char *line)
 }
 
 static const char diff_tree_usage[] =
-"git diff-tree [--stdin] [-m] [-c | --cc] [-s] [-v] [--pretty] [-t] [-r] [--root] "
-"[<common-diff-options>] <tree-ish> [<tree-ish>] [<path>...]\n"
+"git diff-tree [--stdin] [-m] [-s] [-v] [--no-commit-id] [--pretty]\n"
+"              [-t] [-r] [-c | --cc] [--combined-all-paths] [--root] [--merge-base]\n"
+"              [<common-diff-options>] <tree-ish> [<tree-ish>] [<path>...]\n"
 "\n"
 "  -r            diff recursively\n"
 "  -c            show combined diff for merge commits\n"
-- 
2.37.3.1425.g73df845bcb2

