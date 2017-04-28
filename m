Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C512E207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 13:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2998156AbdD1Nuf (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 09:50:35 -0400
Received: from mout.gmx.net ([212.227.17.22]:56193 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2998153AbdD1Nud (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 09:50:33 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvhC4-1eBVmw2wk0-017YuR; Fri, 28
 Apr 2017 15:50:26 +0200
Date:   Fri, 28 Apr 2017 15:50:25 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 07/25] difftool: address a couple of resource/memory
 leaks
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <254784d80407e0eb138f52ec5f9724fcbcda92c5.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+CnIe3iW7Hb9ZXJ+4EIZA9v2ZueHAX3gZ+hij9fd8yfjmuML2M6
 e0fdwLxZs0lhKyE9NIP6p5o4rJbKMJdc4FvuVofhL2dTCsJjqWHu0RPfaSpsTm++JaPMpZk
 a1DbR5giqKNYdYdj7SaeshSCxR2HgAVLUubKYhvUIcHKQAuJnDsB6aHgQLTcMq3SBpXrxzd
 awC+a3BEzwd6H1GNjwPRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TZhiulVsEic=:RuR/UdjrsnERyJd1JJfood
 3yRHUXVH06iN6vXQZmbx7OsZQag9LDmg+SMNq5V/EP7FCqsYP/qr45AWuU/2lnJO01gv2Hvvu
 zw/RTQtswI0U8LVnT6wbZ1YRhhMlKUHQHMv3Ic1+qB310aYoTrYA599Adh4Gv/N4bABI4BM/i
 vJJPQZX/6BdB8ArLOfMQj30u53fqBk/AhmQQV6QzE4zP4UGjko7FTvBCoLZfVomJwLEnNGlBV
 9PTHmZlzmlYNnMfmLXYYmdlhHO3Ci0fS5JUuhF/iMBUIiuVZrF80jlHoSDRxixplvovS1cr8L
 nL0QXhk3M8MGZ7iI4f1yp7ZEXGWvS5373NHN6aDncx4Hs5UqTV9XY7dLy961GTTqMirdYY7Cp
 geb8H72Fy5dWSl+Hte9hR88O/iZ4rsZ8K6WNR6cDCTgitwWDlxG8grajgx0WhT34GLfS1/8Ja
 vfr233W5AzpzM/RUM3X+4OZiG3iTnrfUoRn2izQp2qOMW7xhguMOVyuYibLA98vz405L5m7Sd
 7JS21ZXEkmcoqRgFkAzaeIjrI/eIXZLZc4V61I1Ls98fzsutKKDnbzvemBdLVfH2BlXg5eAqa
 FHv3TNEVlV4BYJUfLCEXMRU7gB8ebsWQE7qV9Wt6svd9U6Kwz/3c0o7MjKwwcGeUowrT3aKCg
 rCvAvPw9GdKivAPeoIBy5Y2ww1958a7rn7vld92i89KbHqhkvsSqUcJvkbsyHMPFFc8ICYdU+
 kY913x9uBTsMs6N18Hm/+ZRfx96z1E1/9ThkaGRVqgvXz0A96zDOiuey2D3b1ANZ8BYBvCpQZ
 9eMKvEc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change plugs a couple of memory leaks and makes sure that the file
descriptor is closed in run_dir_diff().

Spotted by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/difftool.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 1354d0e4625..b9a892f2693 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -226,6 +226,7 @@ static void changed_files(struct hashmap *result, const char *index_path,
 		hashmap_entry_init(entry, strhash(buf.buf));
 		hashmap_add(result, entry);
 	}
+	fclose(fp);
 	if (finish_command(&diff_files))
 		die("diff-files did not exit properly");
 	strbuf_release(&index_env);
@@ -439,8 +440,10 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		}
 
 		if (lmode && status != 'C') {
-			if (checkout_path(lmode, &loid, src_path, &lstate))
-				return error("could not write '%s'", src_path);
+			if (checkout_path(lmode, &loid, src_path, &lstate)) {
+				ret = error("could not write '%s'", src_path);
+				goto finish;
+			}
 		}
 
 		if (rmode && !S_ISLNK(rmode)) {
@@ -456,9 +459,12 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 			hashmap_add(&working_tree_dups, entry);
 
 			if (!use_wt_file(workdir, dst_path, &roid)) {
-				if (checkout_path(rmode, &roid, dst_path, &rstate))
-					return error("could not write '%s'",
-						     dst_path);
+				if (checkout_path(rmode, &roid, dst_path,
+						  &rstate)) {
+					ret = error("could not write '%s'",
+						    dst_path);
+					goto finish;
+				}
 			} else if (!is_null_oid(&roid)) {
 				/*
 				 * Changes in the working tree need special
@@ -473,10 +479,12 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 						ADD_CACHE_JUST_APPEND);
 
 				add_path(&rdir, rdir_len, dst_path);
-				if (ensure_leading_directories(rdir.buf))
-					return error("could not create "
-						     "directory for '%s'",
-						     dst_path);
+				if (ensure_leading_directories(rdir.buf)) {
+					ret = error("could not create "
+						    "directory for '%s'",
+						    dst_path);
+					goto finish;
+				}
 				add_path(&wtdir, wtdir_len, dst_path);
 				if (symlinks) {
 					if (symlink(wtdir.buf, rdir.buf)) {
@@ -497,13 +505,15 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		}
 	}
 
+	fclose(fp);
+	fp = NULL;
 	if (finish_command(&child)) {
 		ret = error("error occurred running diff --raw");
 		goto finish;
 	}
 
 	if (!i)
-		return 0;
+		goto finish;
 
 	/*
 	 * Changes to submodules require special treatment.This loop writes a
@@ -626,6 +636,9 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		exit_cleanup(tmpdir, rc);
 
 finish:
+	if (fp)
+		fclose(fp);
+
 	free(lbase_dir);
 	free(rbase_dir);
 	strbuf_release(&ldir);
-- 
2.12.2.windows.2.800.gede8f145e06


