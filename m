Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4693C4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241271AbiKRLS5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241287AbiKRLSl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:18:41 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F6717E26
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:40 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id vv4so2936767ejc.2
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAX/X9OmbrYFqBqdE9BX3H7MVNafDIY286wBwcUaP/0=;
        b=HEewrrrY3n3yjqIQXjwTH7CdTZAm8RDa+Q3tB7kBuR+DNUeS1BYuRUToleAXmxD3PV
         f1mgMLfqkSoQzB62cVn0eDABF2iOHHU1Mmb3mogfvqgG98/jRPZQIqVSGQ1gueNwdTrg
         YdJlK2q0Xp7y31HzvvNbgZpkciQHePydaEXhRePgusFdyTU9SfmqkSC1cUex1NsSWcnT
         l/gqxKp/2RI1CvoSicAklFcb/WoDYZflShHDKvyUjcpaIbMX+fjowO7gyGFxjWBErV6t
         oqofexmijYV+Gv6QP+ZfxWKPs9nR1RH8rdRTc8+feNbcUUnhomwMIxynLio+gvCABogr
         bqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAX/X9OmbrYFqBqdE9BX3H7MVNafDIY286wBwcUaP/0=;
        b=l7C7db4Kc9YOIaf/ATlZntDlnKQdiQtgLdgDRQvLwkrvRsB/D2MciXHLwTpKymCqtI
         EVikIrdOgEQn5h3R0gWpR7axZu7yBmDJfMZaRZBnInouwr98shC89Y0MY7SEbl60Vxa4
         866qUqNbVfyplBCJCQ520GAGbr3sQYsoGXgOg3C2zPS4DT3nNKf0iCHScQihddU3zTnC
         hjIGc4vidKdvU8MgOJLAfe6/pdwQpK6MrM2zIcR6Kc0zZ0UT5y7sJ15LyBRRVgPdalY6
         GaA/h0/4Xg2wKRPrhCnDw06QLKdTJ/85HKOp8cdSsTDTkEsY8i0jdxrKoGuh3UcrEKsp
         w5aQ==
X-Gm-Message-State: ANoB5pkOUZf5M0o14H8BqlflIchzoSr+BHN39o0ihDZixrgu7iO6FZor
        e7tNzMfRe/MtMZPpbWNqTQ6J3lukQLJ/jQ==
X-Google-Smtp-Source: AA0mqf6tRdhHnvvJw78vRlRtqE8y1689YNAzpTV8H3B5MZxL9mJOVzeMQCQL7ZxeI+C8Jp7lIhWXKA==
X-Received: by 2002:a17:907:204c:b0:7ae:63b8:d688 with SMTP id pg12-20020a170907204c00b007ae63b8d688mr5658387ejb.222.1668770319530;
        Fri, 18 Nov 2022 03:18:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id fy20-20020a1709069f1400b00788c622fa2csm1558955ejc.135.2022.11.18.03.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:18:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 07/12] merge-index i18n: mark die() messages for translation
Date:   Fri, 18 Nov 2022 12:18:24 +0100
Message-Id: <patch-v9-07.12-04c2bae9e68-20221118T110058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1511.gcdcff1f1dc2
In-Reply-To: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
References: <20220809185429.20098-1-alban.gruin@gmail.com> <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark the die() messages for translation with _(). We don't rely on the
specifics of these messages as plumbing, so they can be safely
translated.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge-index.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 0b06c69354b..ee48587a8fb 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -16,7 +16,7 @@ static int merge_entry(int pos, const char *path)
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
 	if (pos >= active_nr)
-		die("'%s' is not in the cache", path);
+		die(_("'%s' is not in the cache"), path);
 	found = 0;
 	do {
 		const struct cache_entry *ce = active_cache[pos];
@@ -31,7 +31,7 @@ static int merge_entry(int pos, const char *path)
 		arguments[stage + 4] = ownbuf[stage];
 	} while (++pos < active_nr);
 	if (!found)
-		die("'%s' is not in the cache", path);
+		die(_("'%s' is not in the cache"), path);
 
 	strvec_pushv(&cmd.args, arguments);
 	if (run_command(&cmd)) {
@@ -39,7 +39,7 @@ static int merge_entry(int pos, const char *path)
 			err++;
 		else {
 			if (!quiet)
-				die("merge program failed");
+				die(_("merge program failed"));
 			exit(1);
 		}
 	}
@@ -130,6 +130,6 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 			merge_one_path(argv[i]);
 
 	if (err && !quiet)
-		die("merge program failed");
+		die(_("merge program failed"));
 	return err;
 }
-- 
2.38.0.1511.gcdcff1f1dc2

