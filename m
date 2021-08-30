Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27DFC4320E
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 07:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9510560FC0
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 07:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbhH3HXs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 03:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbhH3HXq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 03:23:46 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E0EC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 00:22:53 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id j18so18522213ioj.8
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 00:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vGQ/XUXlF71CPGkfvAHYmrMYR3DqGOG3pnS6uFdOJYU=;
        b=U8gn/lK6TmqeOTRmczkDmJL691zLV7+UzUkzR7WImtXrj2Ysp2hL3ljYcWom38Jn+r
         3s8VRt3OrYgvMZJ6xIU5FpEcPkdUKcdzIuecNRZidR+G32naRpsmxrtXXR+GVd0hzaQG
         GkTejCPfHNRys8eu62Gmqdc02xooS1VmpYkVyg17MuTuN4Q5o+7v780jLskK7fKNLt4V
         HdJqIusRPaeXEj8He4XVVpZ7HniWwufjTnxzeT8BRCG4UMCgAyUm8oOvqnJSNmdcwY8T
         /AztWney6gg9t2dYaHzk4mdocfNyVk+AS9zZ759gPqV2nQ+T7fPKxXCcbFgx/ZGtq0JA
         FHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vGQ/XUXlF71CPGkfvAHYmrMYR3DqGOG3pnS6uFdOJYU=;
        b=SyTaDZK7cDMZI0Wpt/SoT4rxaa7Rq6IaTBLNV9fGn/e5ugmrFOR24FkCc5whcwrVnK
         pxAJ3CZoS90d+ezVfEtN08c3MHpP9WFotTQqbVhC3U4TvDfVstR2gD54QFZmgA3m2q8b
         RFNEj1vmdtpd7FvtVirL7QNFYedpTjORrfwD+ZusOjKX4dbMwiD2R7fbEX9RDdnc+kfY
         zSC7wrv/1IoHfCCmg7wiGEoxj2Y5ChW26DMlxT9kNfmE3bsqWBrhKz8cN8TjxJsmLmBk
         8wdsnPy99lSMidlKEH9L7AXFXpME7bfdSjiFhL1pbQU+poyDhd9YcgTcwSdGYZnLknFZ
         TirA==
X-Gm-Message-State: AOAM532LXtGjV1fSallD4vm9j60cRIgKWMVd/yfRzXgECOZHEwdr/Gj+
        ZXImlHkays8W3dzEKSfMjz2pH3yqQWM=
X-Google-Smtp-Source: ABdhPJzX7nXrFo28jg/9PdiPxo0QfC3jvoYgacohEFKtTIxWSsICAgxnMIiOeDON892e4l3sVqaEfQ==
X-Received: by 2002:a6b:6918:: with SMTP id e24mr17322941ioc.71.1630308172853;
        Mon, 30 Aug 2021 00:22:52 -0700 (PDT)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id a6sm7903840ilb.59.2021.08.30.00.22.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Aug 2021 00:22:52 -0700 (PDT)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/3] notes: don't indent empty lines
Date:   Mon, 30 Aug 2021 03:21:18 -0400
Message-Id: <20210830072118.91921-4-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24
In-Reply-To: <20210830072118.91921-1-sunshine@sunshineco.com>
References: <20210830072118.91921-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like other Git commands, `git notes` takes care to call `stripspace` on
the user-supplied note content, thereby ensuring that it has no trailing
whitespace, among other cleanups. However, when notes are inserted into
a patch via `git format-patch --notes`, all lines of the note are
indented unconditionally, including empty lines, which leaves trailing
whitespace on lines which previously were empty, thus negating the
normalization done earlier. Fix this shortcoming.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 notes.c                 |  2 +-
 t/t4014-format-patch.sh | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/notes.c b/notes.c
index f87dac4068..25e0a59899 100644
--- a/notes.c
+++ b/notes.c
@@ -1295,7 +1295,7 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 	for (msg_p = msg; msg_p < msg + msglen; msg_p += linelen + 1) {
 		linelen = strchrnul(msg_p, '\n') - msg_p;
 
-		if (!raw)
+		if (!raw && linelen)
 			strbuf_addstr(sb, "    ");
 		strbuf_add(sb, msg_p, linelen);
 		strbuf_addch(sb, '\n');
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 712d4b5ddf..7406e5fe99 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -906,6 +906,23 @@ test_expect_success 'format-patch with multiple notes refs in config' '
 	grep "this is note 2" out
 '
 
+test_expect_success 'format-patch --notes does not indent empty lines' '
+	git notes add --file=- HEAD <<-\EOF &&
+	paragraph 1
+
+	paragraph 2
+	EOF
+	test_when_finished "git notes remove HEAD" &&
+	git format-patch -1 --stdout --notes >out &&
+	sed -n "/^[ 	]*paragraph 1$/,/^[ 	]*paragraph 2$/{s/^[ 	][ 	]*/[indent]/;p;}" out >actual &&
+	cat >expect <<-\EOF &&
+	[indent]paragraph 1
+
+	[indent]paragraph 2
+	EOF
+	test_cmp expect actual
+'
+
 echo "fatal: --name-only does not make sense" >expect.name-only
 echo "fatal: --name-status does not make sense" >expect.name-status
 echo "fatal: --check does not make sense" >expect.check
-- 
2.33.0.153.gba50c8fa24

