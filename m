Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6942520229
	for <e@80x24.org>; Sat, 22 Oct 2016 00:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936122AbcJVAAC (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 20:00:02 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:32921 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935899AbcJVAAA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 20:00:00 -0400
Received: by mail-pf0-f176.google.com with SMTP id 128so65001518pfz.0
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 17:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eAhQ5ZmJFsDKQRdcMs4bvD6zmjCDAfKa9Q3vL6HlYts=;
        b=Jan7VxfVO1QZxuKxPH5LyMHjjEvihpnj32YlrEzvgqOVS3wLksdN07HXhTFN1n8mbd
         3nht0up4DN8w0NWVDDI3RrlUBSbxBHEy+/lnR0OCze89XhNkP4WXIpKolgK1e63Dk8GF
         WPI8V88EM95SGuapY7KwR6x9RNYwTFRL39BiHnkcrZZStCKXGkFYpAaifN1yFkouAlro
         LfbaBHPHt/X17yU0MEOQp3Fii02L+LcG1YcBXDnJxlfNF509v1d8QlnIS8/vu4/rxQCo
         0as1+RB5eLqL2I70QEOfuVnOV6efvgdBiFNaB9Y7P9bGq63ZVC8QGY948bj3RnoA+p/6
         U2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eAhQ5ZmJFsDKQRdcMs4bvD6zmjCDAfKa9Q3vL6HlYts=;
        b=FtCnggjJEp6FU4ykI3+QPpAc4HkFiAzP8WEfjjlM0ErflYfG6/pImgX9tYLT6QnhJ1
         EftNO0dKHK3itukNoQy91MyzzwGj2r6oi22BIhYPZRv25+BlnK0vZxTcUOVT+H3FkCBJ
         F1ZIsA7JPvX1UKBuD6Qv/cmwhYe1ibUBnq+jqSHG9y6CpUTx0aQ6Iu9QQ4zT1/u5bqok
         +qqWnU4PiEZ2mIgRLWpiW4wUsRjf9MynkZij3uCYELO+iwhn6MyD74EvBIQXiCKFbrlX
         fuOYVgJZ2SHcTJnFcjxU5xneYScKMmersGyY5Qzu1uI8mr9RhzP4tHHRp/aB0zeMyDu8
         kt5A==
X-Gm-Message-State: ABUngvdazMPaTZ+gQ36drmDIdGPxv3E1qArTxi72bC07lTyjmYDL0JrF4W6C82fJ36BO8/PK
X-Received: by 10.99.111.2 with SMTP id k2mr5165997pgc.136.1477094399416;
        Fri, 21 Oct 2016 16:59:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:cc9c:7559:8571:d165])
        by smtp.gmail.com with ESMTPSA id z11sm7588482pfd.49.2016.10.21.16.59.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 21 Oct 2016 16:59:58 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, j6t@kdbg.org, Johannes.Schindelin@gmx.de
Cc:     git@vger.kernel.org, venv21@gmail.com, dennis@kaarsemaker.net,
        jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] submodule--helper: normalize funny urls
Date:   Fri, 21 Oct 2016 16:59:39 -0700
Message-Id: <20161021235939.20792-4-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.507.g2a9098a
In-Reply-To: <20161021235939.20792-1-sbeller@google.com>
References: <20161021235939.20792-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The remote URL for the submodule can be specified relative
to the URL of the superproject in .gitmodules.  A top-level
git://site.xz/toplevel.git can specify in its .gitmodules

        [submodule "sub"]
                url = ../submodule.git
                path = sub

to say that git://site.xz/submodule.git is where the
submodule bound at its "sub/" is found.

However, when the toplevel is cloned like this:

        git clone git://site.xz/toplevel.git/. top

i.e. the toplevel specifies its URL with trailing "/.", the
code set the URL to git://site.xz/toplevel.git/submodule.git
for the submodule, which is nonsense.  This was because the
logic failed to treat trailing "/." any differently from
trailing "/<anything-without-slash>" when resolving a
relative URL "../<something>" off of it.  Stripping "/." at
the end does *not* take you one level up, even though
stripping "/<anything-without-slash>" does!

Some users may rely on this by always cloning with '/.' and having
an additional '../' in the relative path for the submodule, and this
patch breaks them. So why introduce this patch?

The fix in c12922024 (submodule: ignore trailing slash on superproject
URL, 2016-10-10) and prior discussion revealed, that Git and Git
for Windows treat URLs differently, as currently Git for Windows
strips off a trailing dot from paths when calling a Git binary
unlike when running a shell. Which means Git for Windows is already
doing the right thing for the case mentioned above, but it would fail
our current tests, that test for the broken behavior and it would
confuse users working across platforms. So we'd rather fix it
in Git to ignore any of these trailing no ops in the path properly.

We never produce the URLs with a trailing '/.' in Git ourselves,
they come to us, because the user used it as the URL for cloning
a superproject. Normalize these paths.

The test 3600 needs a slight adaption as well, and was not covered by
the previous patch, because the setup of the submodule in this test
is different than the "clone . super" pattern that was fixed in the
previous patch.

The url configured for the submodule path submod is "./.", which
gets normalized with this patch, such that the nested submodule
'subsubmod' doesn't resolve its path properly via '../'.
In later tests we do not need the url any more as testing of
removal of the config including url happens in early tests, so the
easieast fix for that test is to just make the submodule its own
authoritative source of truth by removing the remote url.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 48 +++++++++++++++++++++++++++++++++------------
 t/t0060-path-utils.sh       | 11 +++++++----
 t/t3600-rm.sh               |  1 +
 3 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4beeda5..21e2e2a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -76,6 +76,29 @@ static int chop_last_dir(char **remoteurl, int is_relative)
 	return 0;
 }
 
+static void strip_url_ending(char *url, size_t *len_)
+{
+	size_t len = len_ ? *len_ : strlen(url);
+
+	for (;;) {
+		if (len > 1 && is_dir_sep(url[len - 2]) && url[len - 1] == '.') {
+			url[len-2] = '\0';
+			len -= 2;
+			continue;
+		}
+		if (len > 0 && is_dir_sep(url[len-1])) {
+			url[len-1] = '\0';
+			len--;
+			continue;
+		}
+
+		break;
+	}
+
+	if (len_)
+		*len_ = len;
+}
+
 /*
  * The `url` argument is the URL that navigates to the submodule origin
  * repo. When relative, this URL is relative to the superproject origin
@@ -93,14 +116,16 @@ static int chop_last_dir(char **remoteurl, int is_relative)
  * the superproject working tree otherwise.
  *
  * NEEDSWORK: This works incorrectly on the domain and protocol part.
- * remote_url      url              outcome          expectation
- * http://a.com/b  ../c             http://a.com/c   as is
- * http://a.com/b/ ../c             http://a.com/c   same as previous line, but
- *                                                   ignore trailing slash in url
- * http://a.com/b  ../../c          http://c         error out
- * http://a.com/b  ../../../c       http:/c          error out
- * http://a.com/b  ../../../../c    http:c           error out
- * http://a.com/b  ../../../../../c    .:c           error out
+ * remote_url       url              outcome          expectation
+ * http://a.com/b   ../c             http://a.com/c   as is
+ * http://a.com/b/  ../c             http://a.com/c   same as previous line, but
+ *                                                    ignore trailing '/' in url
+ * http://a.com/b/. ../c             http://a.com/c   same as previous line, but
+ *                                                    ignore trailing '/.' in url
+ * http://a.com/b   ../../c          http://c         error out
+ * http://a.com/b   ../../../c       http:/c          error out
+ * http://a.com/b   ../../../../c    http:c           error out
+ * http://a.com/b   ../../../../../c    .:c           error out
  * NEEDSWORK: Given how chop_last_dir() works, this function is broken
  * when a local part has a colon in its path component, too.
  */
@@ -115,8 +140,7 @@ static char *relative_url(const char *remote_url,
 	struct strbuf sb = STRBUF_INIT;
 	size_t len = strlen(remoteurl);
 
-	if (is_dir_sep(remoteurl[len-1]))
-		remoteurl[len-1] = '\0';
+	strip_url_ending(remoteurl, &len);
 
 	if (!url_is_local_not_ssh(remoteurl) || is_absolute_path(remoteurl))
 		is_relative = 0;
@@ -149,10 +173,10 @@ static char *relative_url(const char *remote_url,
 	}
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s%s%s", remoteurl, colonsep ? ":" : "/", url);
-	if (ends_with(url, "/"))
-		strbuf_setlen(&sb, sb.len - 1);
 	free(remoteurl);
 
+	strip_url_ending(sb.buf, &sb.len);
+
 	if (starts_with_dot_slash(sb.buf))
 		out = xstrdup(sb.buf + 2);
 	else
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 25b48e5..e154e5f 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -329,14 +329,17 @@ test_submodule_relative_url "(null)" "./foo" "../submodule" "submodule"
 test_submodule_relative_url "(null)" "//somewhere else/repo" "../subrepo" "//somewhere else/subrepo"
 test_submodule_relative_url "(null)" "$PWD/subsuper_update_r" "../subsubsuper_update_r" "$(pwd)/subsubsuper_update_r"
 test_submodule_relative_url "(null)" "$PWD/super_update_r2" "../subsuper_update_r" "$(pwd)/subsuper_update_r"
-test_submodule_relative_url "(null)" "$PWD/." "../." "$(pwd)/."
-test_submodule_relative_url "(null)" "$PWD" "./." "$(pwd)/."
+test_submodule_relative_url "(null)" "$PWD/sub/." "../." "$(pwd)"
+test_submodule_relative_url "(null)" "$PWD/sub/./." "../." "$(pwd)"
+test_submodule_relative_url "(null)" "$PWD/sub/.////././/./." "../." "$(pwd)"
+test_submodule_relative_url "(null)" "$PWD" "./." "$(pwd)"
 test_submodule_relative_url "(null)" "$PWD/addtest" "../repo" "$(pwd)/repo"
 test_submodule_relative_url "(null)" "$PWD" "./å äö" "$(pwd)/å äö"
-test_submodule_relative_url "(null)" "$PWD/." "../submodule" "$(pwd)/submodule"
+test_submodule_relative_url "(null)" "$PWD/sub" "../submodule" "$(pwd)/submodule"
+test_submodule_relative_url "(null)" "$PWD/sub/." "../submodule" "$(pwd)/submodule"
 test_submodule_relative_url "(null)" "$PWD/submodule" "../submodule" "$(pwd)/submodule"
 test_submodule_relative_url "(null)" "$PWD/home2/../remote" "../bundle1" "$(pwd)/home2/../bundle1"
-test_submodule_relative_url "(null)" "$PWD/submodule_update_repo" "./." "$(pwd)/submodule_update_repo/."
+test_submodule_relative_url "(null)" "$PWD/submodule_update_repo" "./." "$(pwd)/submodule_update_repo"
 test_submodule_relative_url "(null)" "file:///tmp/repo" "../subrepo" "file:///tmp/subrepo"
 test_submodule_relative_url "(null)" "foo/bar" "../submodule" "foo/submodule"
 test_submodule_relative_url "(null)" "foo" "../submodule" "submodule"
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index d046d98..7839ccd 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -615,6 +615,7 @@ test_expect_success 'setup subsubmodule' '
 	git reset --hard &&
 	git submodule update &&
 	(cd submod &&
+		git config --unset remote.origin.url &&
 		git update-index --add --cacheinfo 160000 $(git rev-parse HEAD) subsubmod &&
 		git config -f .gitmodules submodule.sub.url ../. &&
 		git config -f .gitmodules submodule.sub.path subsubmod &&
-- 
2.10.1.507.g2a9098a

