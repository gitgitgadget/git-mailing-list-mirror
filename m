Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E69C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiI3SJH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiI3SIq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:08:46 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66CD1E5567
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:38 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c11so7993340wrp.11
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=wBDmrqvjcjiyRMtqKj2Mux9zKv//pJAnXLq/uM3yKwE=;
        b=Ll5/K2rgiR3lVzPt6gT9/sTg+Dh+8wp7ljFv3kb3sVcU4r/ggYTUy6O+/0rYVUGMRr
         lMQ4GzTNJ9IpDCBFzCPVtME06xuKzUMGuUwBKlT90xwWegWPMamBUudp8JqBNDEZu/hs
         yNbfYa6Y60D+omnBXew6OX/ucvyp2rVjXSWQ80Vrm/G7iYh0DOUETYnrq4UeuunYGgAW
         cAVeuFs39M6ps3ufyMS0IL1F9pwM5EldhnOGhfyTirGBV7kJUx7cgMlrRRv2vKlU/zC5
         NhL4V5nN6eHAqmSUMI9+qk4Cp1C0vcxKfDFfRnD+FiLYeRLhK43TG9yIXs2CVRIiDYkc
         juLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wBDmrqvjcjiyRMtqKj2Mux9zKv//pJAnXLq/uM3yKwE=;
        b=rY+5na3wZC0+vf5lvWelM0/vNZMo7ZGNhlM/IfmA7aKeSPkTPklqRhwevfzvD1SQ63
         Y8AMj1wQe9DtiMpjhQry8KwD0me1wAW1SpP8qab6ODZCLC86jf/qZaIbqPjDQHyVDFPM
         g99BGbhgWOfSktxBBYPTwBQ6JGa7PjOzoom3nxrN7HwqjrWzfc/ciqXEAnzu2X6DKJwx
         IvxLjKn5CxEBSM31BztbtGP4TFlFNl6OMm5CsR/eEGHkupBfYAe3JujAHtZbQTHff7nQ
         Ad6ut0cCrAsrQKLyKfzpwS7ui28B1r/rAJbSH+nXNVAkUHr47DwYRQAEiuRqmp9Ih7Fj
         bvEQ==
X-Gm-Message-State: ACrzQf28rN+64WI93ZC7YBCtn8Hg1AknQLvtSLJMiVP4Bm6G9TUFHLiV
        yM5tkJFe86y/GfVpq8QMHjf8xbLFROvyTg==
X-Google-Smtp-Source: AMsMyM7I+T4nplEuOuO8Y0JveqEaHqlFWOztmbkl/tq5WWXQnh1OLkqGDtiqBgcol7zDIuyz+XTlgA==
X-Received: by 2002:a5d:4a01:0:b0:21d:8ce1:8b6d with SMTP id m1-20020a5d4a01000000b0021d8ce18b6dmr6596280wrq.718.1664561316554;
        Fri, 30 Sep 2022 11:08:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:08:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/36] doc SYNOPSIS & -h: word-wrap
Date:   Fri, 30 Sep 2022 20:07:32 +0200
Message-Id: <patch-v3-09.36-516af07e8a8-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the documentation and -h output for those built-in commands
where both the -h output and *.txt were lacking in word-wrapping.

There are many more built-ins that could use this treatment, this
change is narrowed to those where this whitespace change is needed to
make the -h and *.txt consistent in the end.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-hash-object.txt | 3 ++-
 builtin/hash-object.c             | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index df9e2c58bdb..58670ef12f7 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -9,7 +9,8 @@ git-hash-object - Compute object ID and optionally creates a blob from a file
 SYNOPSIS
 --------
 [verse]
-'git hash-object' [-t <type>] [-w] [--path=<file>|--no-filters] [--stdin [--literally]] [--] <file>...
+'git hash-object' [-t <type>] [-w] [--path=<file>|--no-filters]
+		[--stdin [--literally]] [--] <file>...
 'git hash-object' [-t <type>] [-w] --stdin-paths [--no-filters]
 
 DESCRIPTION
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index fbae878c2b9..f7c16802f0c 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -80,7 +80,8 @@ static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
 int cmd_hash_object(int argc, const char **argv, const char *prefix)
 {
 	static const char * const hash_object_usage[] = {
-		N_("git hash-object [-t <type>] [-w] [--path=<file> | --no-filters] [--stdin] [--] <file>..."),
+		N_("git hash-object [-t <type>] [-w] [--path=<file> | --no-filters]\n"
+		   "                [--stdin] [--] <file>..."),
 		"git hash-object  --stdin-paths",
 		NULL
 	};
-- 
2.38.0.rc2.935.g6b421ae1592

