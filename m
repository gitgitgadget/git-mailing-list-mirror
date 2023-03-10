Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41543C6FA99
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 21:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjCJVtV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 16:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbjCJVsx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 16:48:53 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C2A14DA2D
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 13:45:59 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id a4-20020a056830008400b0069432af1380so3686996oto.13
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 13:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678484723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtF0uqF8Lxp6HgvZFD9B2CTHDTfQGAcVmyEnYlQFxgg=;
        b=L83pumvHM7JNNyOboVnk5lj7F1pro4bAbLDNWKmtpls7esOkN3HNA4xsBbQYLduSll
         oJomQScA0yC4CQ8Vrvo1LeFjeJvg3wo6Uzhe+3IdnZ8EDEyki3tj8M+i7DXOCiB8bQqQ
         I2vzCFNfuxs9IqK/HBn/ETSoUe4j3J1hQAXT/3h4wKbjr6mjT4sxpkMYMGcsjqdt3ou/
         XrUpS+tXSNtEUDgfaBiY6V22tq+yWxeqENpMr4QEKeHCJU/tAW43ZuSDZpyedICRfZB7
         blYVjhRxERBhRpQnQkrEyaD+Ep/SMCqzsfpaFMjRjMlNtKBfSbHlzjj1EeysNsC3d56e
         VSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtF0uqF8Lxp6HgvZFD9B2CTHDTfQGAcVmyEnYlQFxgg=;
        b=Teg2gKmwHy25HLwH+SMuyAVZsO9ModbPbXS2slZEGc2KdCswuscSpc2fNXEktv/zcj
         gnNpMTJJ6acmzQCdwjtMvNHTkXGCgIUtspnmsT4dfocr/0oIQqfLT3g2vNHmPZ542YDw
         +Bfxn/tiH1Ol2KIN62rh6BFpJWR9/dJmYKgJFe8U3FXPolzOzYlAicmZoqbvTHf5Otd2
         TpTt49e03gKTJlX4/UeglKdZjDidKEVt8s0Ofvp5KAT5wnZFznz46+D+rYetPbmucrRr
         VGBQkm8gjTXYH8/rCRknLalaCZfpdG+yj4cbVu811n1+uT5XiGByWJYO+hHyJ77mdrBO
         KCOA==
X-Gm-Message-State: AO0yUKXAJPuLFToFZzLQ3OfLGLH54ivSLckgUcBEv0f8wDqdyGSJzPW/
        lxMp5lMlRQLtFFVMj5Kc4LozzvaWik8=
X-Google-Smtp-Source: AK7set+qsbVLy+o+jrgztR3EOLHpdzTUIVSs4ca7wsaS3spW6NA0BZ0bL8lbvSR+ICcPjF7EHmJ8tA==
X-Received: by 2002:a9d:2e7:0:b0:690:f7da:5390 with SMTP id 94-20020a9d02e7000000b00690f7da5390mr13931423otl.25.1678484723710;
        Fri, 10 Mar 2023 13:45:23 -0800 (PST)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id c26-20020a9d615a000000b0068bbc9e7cc9sm509255otk.53.2023.03.10.13.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:45:23 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 3/3] rebase: update branch tail after rebasing
Date:   Fri, 10 Mar 2023 15:45:15 -0600
Message-Id: <20230310214515.39154-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0.rc2.1.gf652911b76.dirty
In-Reply-To: <20230310214515.39154-1-felipe.contreras@gmail.com>
References: <20230310214515.39154-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/rebase.c          | 15 +++++++++++++++
 t/t1514-rev-parse-tail.sh | 10 ++++++++++
 2 files changed, 25 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6635f10d52..19cfb0d0e4 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -252,6 +252,16 @@ static int init_basic_state(struct replay_opts *opts, const char *head_name,
 	return write_basic_state(opts, head_name, onto, orig_head);
 }
 
+static void update_tail(struct rebase_options *opts)
+{
+	const char *shortname = NULL;
+	struct strbuf ref = STRBUF_INIT;
+	skip_prefix(opts->head_name, "refs/heads/", &shortname);
+	strbuf_addf(&ref, "refs/tails/%s", shortname);
+	update_ref(NULL, ref.buf, &opts->onto->object.oid, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+	strbuf_release(&ref);
+}
+
 static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 {
 	int ret = -1;
@@ -294,6 +304,9 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 			shortrevisions, opts->onto_name, opts->onto,
 			&opts->orig_head->object.oid, &opts->exec,
 			opts->autosquash, opts->update_refs, &todo_list);
+
+		if (!ret)
+			update_tail(opts);
 	}
 
 cleanup:
@@ -564,6 +577,8 @@ static int finish_rebase(struct rebase_options *opts)
 		strbuf_release(&dir);
 	}
 
+	update_tail(opts);
+
 	return ret;
 }
 
diff --git a/t/t1514-rev-parse-tail.sh b/t/t1514-rev-parse-tail.sh
index 6024b4276c..7b3482de55 100755
--- a/t/t1514-rev-parse-tail.sh
+++ b/t/t1514-rev-parse-tail.sh
@@ -26,4 +26,14 @@ test_expect_success 'test @{tail}' '
 	test_cmp expect actual
 '
 
+test_expect_success 'test rebase tail update' '
+	git checkout -b next master &&
+	echo three > content &&
+	git commit -a -m three &&
+	git rebase --onto next test@{tail} test &&
+	git rev-parse test@{tail} > actual &&
+	git rev-parse next > expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.40.0.rc2.1.gf652911b76.dirty

