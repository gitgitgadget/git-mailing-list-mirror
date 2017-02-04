Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E7001FAFC
	for <e@80x24.org>; Sat,  4 Feb 2017 02:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753387AbdBDCOG (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 21:14:06 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35913 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753240AbdBDCOF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 21:14:05 -0500
Received: by mail-pg0-f68.google.com with SMTP id 75so3389657pgf.3
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 18:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Zbd/0ZcpfOOrZSZtFCqk+9Nw5ZxQ7QZpNNiQuIA/p1c=;
        b=L0PfqJvANHWgtQzPyW7xHjEvHvqjyEKxf5UJ23ODz/klJx2CEa6phA7UuuBj+RytoR
         SqggAj4BgJZ4ipzDd+a6m/VZtIIHBSXD0YZRtUloSubU0CbVkDpKMZyjWnVxcJumUi/A
         86Ki6trPirLTu92R7xJ0dHGoSIRVvRQygJW/p/V/6NBsjeDrElMz/n/+I5Pw2DRxea5c
         AgF0avppou2MVAmrDt4wqxb9P1yeNQk6A71SumP/VnumPVkplXi7yRrL3Wx2T6NXGIan
         SkzesZdIBmQtq/rL93eyRxU3a0No6p92FjwmhTQaApO+0/UF5sKtob+lgudXw988Py0p
         mqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Zbd/0ZcpfOOrZSZtFCqk+9Nw5ZxQ7QZpNNiQuIA/p1c=;
        b=Uff8+Vlxf+jmwdWuJxQ8T+rtbNigLHCqoHb+xEw+AWCYqZ2Gg+To8276Esa/oDPD0D
         Y9oSC+2633Fc4ekzEHgDzFI23v83nqb+02hRig3+cxUDaxWi0TEFrfSnE1GhHhrdtH9l
         SMubFy17Rp4vs4aJbjqmGM1LMSbaraqS+lWXJly9GP1VLHFBgb0YqiaWp7CySIlkE5Cw
         zZ/idWlUTsGIo7feaLaV7pwGdBQpBBgIqfmIsjo40gsNPi0GB6d1z/oobHN6bUZOXDDb
         U0Dze3kIuZBpJQqTM0E37g3sf3X1OEmOzJg0YGdVoVid8qoi6kYdCJu3hg56t1On1+Ix
         fXoQ==
X-Gm-Message-State: AIkVDXJJ8aykrFH0rQNe+UekOdJgswxYPssB8oCzILH6qmmpGrDhZE5geIqxZhsBuxbnqA==
X-Received: by 10.99.51.76 with SMTP id z73mr117360pgz.137.1486174444971;
        Fri, 03 Feb 2017 18:14:04 -0800 (PST)
Received: from raptor.fas.fa.disney.com (wdas-1.disneyanimation.com. [198.187.190.1])
        by smtp.gmail.com with ESMTPSA id z77sm70166951pfk.47.2017.02.03.18.14.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Feb 2017 18:14:03 -0800 (PST)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] tag: add a config option for setting --annotate by default
Date:   Fri,  3 Feb 2017 18:14:02 -0800
Message-Id: <20170204021402.15927-1-davvid@gmail.com>
X-Mailer: git-send-email 2.11.0.486.gcc949b6e67.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make it easier for users to remember to annotate their tags.
Allow setting the default value for "--annotate" via the "tag.annotate"
configuration variable.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Documentation/config.txt |  5 +++++
 builtin/tag.c            | 15 ++++++++++++---
 t/t7004-tag.sh           | 23 +++++++++++++++++++++++
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index af2ae4cc02..0d562b97e9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2945,6 +2945,11 @@ submodule.alternateErrorStrategy
 	as computed via `submodule.alternateLocation`. Possible values are
 	`ignore`, `info`, `die`. Default is `die`.
 
+tag.annotate::
+	A boolean to specify whether annotated tags should be created by
+	default.  If `--no-annotate` is specified on the command line,
+	it takes precedence over this option.
+
 tag.forceSignAnnotated::
 	A boolean to specify whether annotated tags created should be GPG signed.
 	If `--annotate` is specified on the command line, it takes
diff --git a/builtin/tag.c b/builtin/tag.c
index 73df728114..1cf9bb73ad 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -29,6 +29,7 @@ static const char * const git_tag_usage[] = {
 };
 
 static unsigned int colopts;
+static int force_annotate;
 static int force_sign_annotate;
 
 static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, const char *format)
@@ -161,6 +162,10 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 	status = git_gpg_config(var, value, cb);
 	if (status)
 		return status;
+	if (!strcmp(var, "tag.annotate")) {
+		force_annotate = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "tag.forcesignannotated")) {
 		force_sign_annotate = git_config_bool(var, value);
 		return 0;
@@ -326,7 +331,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct create_tag_options opt;
 	char *cleanup_arg = NULL;
 	int create_reflog = 0;
-	int annotate = 0, force = 0;
+	int annotate = -1, force = 0;
 	int cmdmode = 0, create_tag_object = 0;
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
@@ -387,11 +392,15 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		opt.sign = 1;
 		set_signing_key(keyid);
 	}
-	create_tag_object = (opt.sign || annotate || msg.given || msgfile);
 
 	if (argc == 0 && !cmdmode)
 		cmdmode = 'l';
 
+	if (force_annotate && !cmdmode && annotate == -1)
+		annotate = 1;
+
+	create_tag_object = (opt.sign || annotate > 0 || msg.given || msgfile);
+
 	if ((create_tag_object || force) && (cmdmode != 0))
 		usage_with_options(git_tag_usage, options);
 
@@ -478,7 +487,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		die(_("Invalid cleanup mode %s"), cleanup_arg);
 
 	if (create_tag_object) {
-		if (force_sign_annotate && !annotate)
+		if (force_sign_annotate && annotate == -1)
 			opt.sign = 1;
 		create_tag(object, tag, &buf, &opt, prev, object);
 	}
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 1cfa8a21d2..5ba52b57dd 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -754,6 +754,29 @@ echo from a fake editor.
 EOF
 chmod +x fakeeditor
 
+get_tag_header config-annotate $commit commit $time >expect
+./fakeeditor >>expect
+test_expect_success 'tag.annotate creates annotated tags' '
+	test_config tag.annotate true &&
+	GIT_EDITOR=./fakeeditor git tag config-annotate &&
+	get_tag_msg config-annotate >actual &&
+	test_cmp expect actual
+'
+test_expect_success 'tag --no-annotate overrides tag.annotate=true config' '
+	test_config tag.annotate true &&
+	GIT_EDITOR=false git tag --no-annotate cli-override-tag-annotate &&
+	tag_exists cli-override-tag-annotate
+'
+
+get_tag_header config-no-annotate $commit commit $time >expect
+./fakeeditor >>expect
+test_expect_success 'tag --annotate overrides tag.annotate=false config' '
+	test_config tag.annotate false &&
+	GIT_EDITOR=./fakeeditor git tag --annotate config-no-annotate &&
+	get_tag_msg config-no-annotate >actual &&
+	test_cmp expect actual
+'
+
 get_tag_header implied-sign $commit commit $time >expect
 ./fakeeditor >>expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-- 
2.11.0.486.gcc949b6e67.dirty

