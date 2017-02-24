Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 764BD2022D
	for <e@80x24.org>; Fri, 24 Feb 2017 00:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbdBXARW (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 19:17:22 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36720 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbdBXARN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 19:17:13 -0500
Received: by mail-pg0-f46.google.com with SMTP id s67so2997179pgb.3
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 16:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dew8P9rwtiIZX4ujVyUYdPgrkan9xU/pos24n40VgH0=;
        b=ET3spRSnIoAbuWfwRvLKzh0hnCWWKUqUOLqULnQ7+3IK7noYWc764DKTBFkhBZVL/y
         BlXKBNaTZrcymCyWUWn4wQynyPqRLKCqf0D4kTb9exlWR4CHoPSopRJXlOqQM0L1CNSj
         9NnKzLfsqUg0OCx/BqfFB+U8tX446IDZwrQ4gnP01mIn4rAC5BSZBzOmq9NKM0ISIJnp
         zsEn94uU6ct5wwe5umdv1kvGE46SHF65ccTX/jCeYAosnP/0kK5nPCwdmCuohK8OzT4h
         m1n2Rmkng6dXTvEltIZDuO0d9wg84MtbRqsF6B/mUxRvtZW1Zu5gnvYCe7mZLhHzivkl
         MaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dew8P9rwtiIZX4ujVyUYdPgrkan9xU/pos24n40VgH0=;
        b=D82Ob1H8VA04ug4BMBCxULNz58VuTJPo1HGSZBETBYXjHxnW5U+Z1x+LKNs3P1ScOg
         DcMWr1KNiyENgxe7abeIbtP/LcsmNylTKy3m9avIwrhb9D+u7EotkGZFg75kRx6HyIIJ
         QK1Bf9/jmlMHqpQKGKpf6duWU+8gghowq8POZ7UoUEDqPH8LleCJR224Qwb1Pvep+0bE
         eWnKDNNgsxYqUjuNAvsu9xATaSdJiVTCJ50sg8Rc5T/JHd0HU7dzHTtYyM8TgNRkImrT
         Zaj0TxhgzIKN/V+DrQvRJrRXD2V9ATANIKyAJKuG+OR0CR8lNXWp9WTl3ol1HOk7gTV8
         9ugA==
X-Gm-Message-State: AMke39kWzgt1B5hiANrM9A7EXqisfPvxDFoRlXgTX3xivGI0lvdAWTu3fnePlEfvVpaNx+WV
X-Received: by 10.98.33.129 with SMTP id o1mr20592505pfj.5.1487895428224;
        Thu, 23 Feb 2017 16:17:08 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:ad75:dfc7:8a6:1152])
        by smtp.gmail.com with ESMTPSA id b74sm11665977pfc.129.2017.02.23.16.17.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 16:17:07 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     philipoakley@iee.org
Cc:     git@vger.kernel.org, gitster@pobox.com, sop@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule init: warn about falling back to a local path
Date:   Thu, 23 Feb 2017 16:17:04 -0800
Message-Id: <20170224001704.23854-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <CAGZ79kYXyk=giuM6CnU=gnvkCw3aaVEn=WbJ6tjhn8kZumrmTA@mail.gmail.com>
References: <CAGZ79kYXyk=giuM6CnU=gnvkCw3aaVEn=WbJ6tjhn8kZumrmTA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a submodule is initialized, the config variable 'submodule.<name>.url'
is set depending on the value of the same variable in the .gitmodules
file. When the URL indicates to be relative, then the url is computed
relative to its default remote. The default remote cannot be determined
accurately in all cases, such that it falls back to 'origin'.

The 'origin' remote may not exist, though. In that case we give up looking
for a suitable remote and we'll just assume it to be a local relative path.

This can be confusing to users as there is a lot of guessing involved,
which is not obvious to the user.

So in the corner case of assuming a local autoritative truth, warn the
user to lessen the confusion.

This behavior was introduced in 4d6893200 (submodule add: allow relative
repository path even when no url is set, 2011-06-06), which shared the
code with submodule-init and then ported to C in 3604242f080a (submodule:
port init from shell to C, 2016-04-15).

In case of submodule-add, this behavior makes sense in some use cases[1],
however for submodule-init there does not seem to be an immediate obvious
use case to fall back to a local submodule. However there might be, so
warn instead of die here.

While adding the warning, also clarify the behavior of relative URLs in
the documentation.

[1] e.g. http://stackoverflow.com/questions/8721984/git-ignore-files-for-public-repository-but-not-for-private
"store a secret locally in a submodule, with no intention to publish it"

Reported-by: Shawn Pearce <spearce@spearce.org>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-submodule.txt | 22 +++++++++++++++-------
 builtin/submodule--helper.c     |  8 +++-----
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 8acc72ebb8..d23dee2a5b 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -73,13 +73,17 @@ configuration entries unless `--name` is used to specify a logical name.
 +
 <repository> is the URL of the new submodule's origin repository.
 This may be either an absolute URL, or (if it begins with ./
-or ../), the location relative to the superproject's origin
+or ../), the location relative to the superproject's default remote
 repository (Please note that to specify a repository 'foo.git'
 which is located right next to a superproject 'bar.git', you'll
 have to use '../foo.git' instead of './foo.git' - as one might expect
 when following the rules for relative URLs - because the evaluation
 of relative URLs in Git is identical to that of relative directories).
-If the superproject doesn't have an origin configured
++
+The default remote is the remote of the remote tracking branch
+of the current branch. If no such remote tracking branch exists or
+the in detached HEAD mode, "origin" is assumed to be the default remote.
+If the superproject doesn't have a default remote configured
 the superproject is its own authoritative upstream and the current
 working directory is used instead.
 +
@@ -118,18 +122,22 @@ too (and can also report changes to a submodule's work tree).
 
 init [--] [<path>...]::
 	Initialize the submodules recorded in the index (which were
-	added and committed elsewhere) by copying submodule
-	names and urls from .gitmodules to .git/config.
+	added and committed elsewhere) by copying `submodule.$name.url`
+	from .gitmodules to .git/config, resolving relative urls to be
+	relative to the default remote.
++
 	Optional <path> arguments limit which submodules will be initialized.
-	It will also copy the value of `submodule.$name.update` into
-	.git/config.
-	The key used in .git/config is `submodule.$name.url`.
+	If no path is specified all submodules are initialized.
++
+	When present, it will also copy the value of `submodule.$name.update`.
 	This command does not alter existing information in .git/config.
 	You can then customize the submodule clone URLs in .git/config
 	for your local setup and proceed to `git submodule update`;
 	you can also just use `git submodule update --init` without
 	the explicit 'init' step if you do not intend to customize
 	any submodule locations.
++
+	See the add subcommand for the defintion of default remote.
 
 deinit [-f|--force] (--all|[--] <path>...)::
 	Unregister the given submodules, i.e. remove the whole
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 899dc334e3..44c11dd91e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -356,12 +356,10 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 			strbuf_addf(&remotesb, "remote.%s.url", remote);
 			free(remote);
 
-			if (git_config_get_string(remotesb.buf, &remoteurl))
-				/*
-				 * The repository is its own
-				 * authoritative upstream
-				 */
+			if (git_config_get_string(remotesb.buf, &remoteurl)) {
 				remoteurl = xgetcwd();
+				warning(_("could not lookup configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);
+			}
 			relurl = relative_url(remoteurl, url, NULL);
 			strbuf_release(&remotesb);
 			free(remoteurl);
-- 
2.12.0.rc1.16.ge4278d41a0.dirty

