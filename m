Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9C0C3F68F
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 07:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5E720659
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 07:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIXnPH8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfLDHsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:48:02 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33893 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfLDHsC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 02:48:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id n13so3225065pff.1
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 23:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4ry4whkvr4bRo1jUw3sUAXZ/RJQh+nTemy5Pw4b44GA=;
        b=pIXnPH8Rt8qVpgrJv5DWkHcU33XstPuZM8q35/hsxedMDe2/paHXm6EM3ZTCF/0pQ7
         vsRfkeluU6IfDzsAFE3RQCyzxYXS04dV7OS3dMcvEzdXGV5yT+fBwyUJ2rRUMBm96eTS
         EercnhUbuPACHAEB82S5LlERZjVVZt1ppamVZttxh6vFy8W1Xm5K/h7Wz23rRVyS7CP/
         p3DfhEcRffeUDZU4bBHcbvb4VDZOcrDjbH+jn9456NP2vn+e7kmaP1Z2YVC4trpIH8Y8
         v7l7NiZXAYoJ5LRrh1LNiB6fJrfPNSblxV44KZ2u+Yfcis6AA1shUySeUWnB2A4uv1V0
         oDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ry4whkvr4bRo1jUw3sUAXZ/RJQh+nTemy5Pw4b44GA=;
        b=JAWEkS41SCOYuRa902+9GhdR8WlhoiSM3LJM88yvzF4rF6EncRtjMNy2lTKMbnmljU
         QtqaxgDlNX/0s/NTDsA8oJQJGrghgLcOqYkMISDfeenjEFjcWOUpJBkBqjAwynhzz4Lu
         fi4JcKvANxgs0SRRkDbum5LPDw426z3LMftmzRjV4s8jOzU85Y1Upr7oDQHtWKSvHlWb
         i976dBKXyto8/lyRj1H/Fdj4wIoVdlWzCrkYDDCmdKSFMI0Ks8nui0KtYAQLi2o+V1Yt
         psSOzI9oul/wnXW73N3IKfOh/R6yBs98bdqdgS81Nh/X1BrWb6GBWfFaFOWRmIWC7Lxb
         JlKQ==
X-Gm-Message-State: APjAAAUaAhok0oYGJiMDWUODbYVOMiSrFcapoPBHxsxkEY9k0EDsjlEe
        Ik6AiaoZztcOy5H5wbtaYnhcPUii
X-Google-Smtp-Source: APXvYqw9vRV+PSzFZOK4OEZ4zarYrPnJctocDEUXrKxUe3CjcrqLUifCoxbvezrMa56VV/A6mZKb6w==
X-Received: by 2002:a63:b26:: with SMTP id 38mr2100106pgl.116.1575445681222;
        Tue, 03 Dec 2019 23:48:01 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id z29sm6360672pge.21.2019.12.03.23.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 23:48:00 -0800 (PST)
Date:   Tue, 3 Dec 2019 23:47:59 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Biesinger <cbiesinger@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/5] format-patch: teach --no-base
Message-ID: <6cba51ca247423c76bda498152c162900aba1b59.1575445583.git.liu.denton@gmail.com>
References: <cover.1574878089.git.liu.denton@gmail.com>
 <cover.1575445582.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575445582.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If `format.useAutoBase = true`, there was no way to override this from
the command-line. Teach format-patch the `--no-base` option which
overrides `format.useAutoBase`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-format-patch.txt |  5 +++--
 builtin/log.c                      | 22 ++++++++++++++++++++--
 t/t4014-format-patch.sh            |  6 ++++++
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 00bdf9b125..0d4f8951bb 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -333,11 +333,12 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
   Output an all-zero hash in each patch's From header instead
   of the hash of the commit.
 
---base=<commit>::
+--[no-]base[=<commit>]::
 	Record the base tree information to identify the state the
 	patch series applies to.  See the BASE TREE INFORMATION section
 	below for details. If <commit> is "auto", a base commit is
-	automatically chosen.
+	automatically chosen. The `--no-base` option overrides a
+	`format.useAutoBase` configuration.
 
 --root::
 	Treat the revision argument as a <revision range>, even if it
diff --git a/builtin/log.c b/builtin/log.c
index 9c44682f61..645d6db7cc 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1388,6 +1388,23 @@ static int from_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int base_callback(const struct option *opt, const char *arg, int unset)
+{
+	char **base_commit = opt->value;
+
+	free(*base_commit);
+
+	if (unset) {
+		base_auto = 0;
+		*base_commit = NULL;
+	} else if (arg) {
+		*base_commit = xstrdup(arg);
+	} else {
+		BUG("arg is NULL");
+	}
+	return 0;
+}
+
 struct base_tree_info {
 	struct object_id base_commit;
 	int nr_patch_id, alloc_patch_id;
@@ -1676,8 +1693,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_OPTARG, thread_callback },
 		OPT_STRING(0, "signature", &signature, N_("signature"),
 			    N_("add a signature")),
-		OPT_STRING(0, "base", &base_commit, N_("base-commit"),
-			   N_("add prerequisite tree info to the patch series")),
+		{ OPTION_CALLBACK, 0, "base", &base_commit, N_("base-commit"),
+			   N_("add prerequisite tree info to the patch series"),
+			   0, base_callback },
 		OPT_FILENAME(0, "signature-file", &signature_file,
 				N_("add a signature from a file")),
 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index c7cc643adf..a5b6302a1c 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1958,6 +1958,12 @@ test_expect_success 'format-patch --base overrides format.useAutoBase' '
 	test_cmp expect actual
 '
 
+test_expect_success 'format-patch --no-base overrides format.useAutoBase' '
+	test_config format.useAutoBase true &&
+	git format-patch --stdout --no-base -1 >patch &&
+	! grep "^base-commit:" patch
+'
+
 test_expect_success 'format-patch --base with --attach' '
 	git format-patch --attach=mimemime --stdout --base=HEAD~ -1 >patch &&
 	sed -n -e "/^base-commit:/s/.*/1/p" -e "/^---*mimemime--$/s/.*/2/p" \
-- 
2.24.0.578.g4820254054

