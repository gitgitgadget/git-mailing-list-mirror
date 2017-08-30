Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02367208DE
	for <e@80x24.org>; Wed, 30 Aug 2017 17:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbdH3RuP (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:50:15 -0400
Received: from mout.web.de ([217.72.192.78]:65183 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751740AbdH3RuH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:50:07 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lrruc-1dN1AO1Hyg-013gD9 for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:50:06 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 05/34] clean: release strbuf after use in remove_dirs()
Date:   Wed, 30 Aug 2017 19:49:36 +0200
Message-Id: <20170830175005.20756-6-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:nd5J0258HfvWshImfvv4Z+9rlYD9oUYnNxNMObyYmiypvOu+nzI
 7doY5F7rU4Uqo+jw2Uh4KVLPE8XPQujxj2aH48fVDyvu42lL/OmMhcK5GEfVnoq2y1/NxaX
 o0oCsXgV6cuFUGowV1DjCP2A0gRgQWwrm6cCjN2h2HTW8W9trT4yQiG8adNdjnwVfcS4Sjx
 bE7LMTgBiyFqcMxZif0Dg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BI6fa2CtuD8=:JzZtek1G7s2O8hVimjzyhF
 TKOD3UNxw3ol1ay7ErdLLof1XRH8dXRWDMDN/QPuq5GpUsUSdVRBk+dTh7v7mHFFNtCXKuR2U
 vK/o5nxcVEzeX/7pBdbaDsKC35N28xglIKBnB2+6mvXxZyGGwSEQ/yPKsKaunm/PN+s7HjukV
 o7UwTHZ5hS4kYrGyqUmTT8MnEdWb9D+3IRKeJG04bJzdj2Kk46SLz8k6BUg0llYbgjMKlmNrO
 NtJGhPdE6gyD456opPTiX4bLMKty7W1ovowQDqhTNn0vWi+bi5Nadj+d4iLju5QzBGRiEGQrp
 9qZrBBXFoWIRLwvVTar7kMKoKohSYl/umeo+a68tAZFw/DT/rVQmtOPuk7e6zKQPdg7LzSgmW
 AXKggGsnn7Tzy0UYkJblMlYBZkNFkcodnJOwDzNYkRarDNpJ2Z0ByvvmrUfP4rLmpO28ItHfJ
 6vTVw0a4sIe10Jq+C0PlS0+sWu+rBtgANi1umAfDLkBTKUTfoaLSXXspBdw4K/ymueqn7yz2d
 3BHcduk3ign3aVFX8jLfDvztYk5CsTqiaNjgceksLK26GsDG2DVClXBc4T/7tdL9BYICCO9EZ
 Mef73f0+u3XCSag7l3grnnpU0NICl05fhhoi2CxSxzgRQCrhaBhgCdJ/zd/rhd1ej8zutosPv
 N5MgUpjw5p/FL9zRL07lE01KFazefjQOCZRitcxYKAAtnDS+4sW1Z+rY2W8SQibS+NpzzjDn5
 Q6xVYdhQH/ga1sgKi136XOP8IGmSpxOzE6ant+837NA/2UPcI9aYVa0L+Ow2EttyE7qTjhtfD
 /xAhSpWyce1roDtPcTVUN1eQWhYuw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/clean.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 21a7a32994..733b6d3745 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -151,104 +151,107 @@ static int exclude_cb(const struct option *opt, const char *arg, int unset)
 static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 		int dry_run, int quiet, int *dir_gone)
 {
 	DIR *dir;
 	struct strbuf quoted = STRBUF_INIT;
 	struct dirent *e;
 	int res = 0, ret = 0, gone = 1, original_len = path->len, len;
 	struct string_list dels = STRING_LIST_INIT_DUP;
 
 	*dir_gone = 1;
 
 	if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) && is_nonbare_repository_dir(path)) {
 		if (!quiet) {
 			quote_path_relative(path->buf, prefix, &quoted);
 			printf(dry_run ?  _(msg_would_skip_git_dir) : _(msg_skip_git_dir),
 					quoted.buf);
 		}
 
 		*dir_gone = 0;
-		return 0;
+		goto out;
 	}
 
 	dir = opendir(path->buf);
 	if (!dir) {
 		/* an empty dir could be removed even if it is unreadble */
 		res = dry_run ? 0 : rmdir(path->buf);
 		if (res) {
 			int saved_errno = errno;
 			quote_path_relative(path->buf, prefix, &quoted);
 			errno = saved_errno;
 			warning_errno(_(msg_warn_remove_failed), quoted.buf);
 			*dir_gone = 0;
 		}
-		return res;
+		ret = res;
+		goto out;
 	}
 
 	strbuf_complete(path, '/');
 
 	len = path->len;
 	while ((e = readdir(dir)) != NULL) {
 		struct stat st;
 		if (is_dot_or_dotdot(e->d_name))
 			continue;
 
 		strbuf_setlen(path, len);
 		strbuf_addstr(path, e->d_name);
 		if (lstat(path->buf, &st))
 			; /* fall thru */
 		else if (S_ISDIR(st.st_mode)) {
 			if (remove_dirs(path, prefix, force_flag, dry_run, quiet, &gone))
 				ret = 1;
 			if (gone) {
 				quote_path_relative(path->buf, prefix, &quoted);
 				string_list_append(&dels, quoted.buf);
 			} else
 				*dir_gone = 0;
 			continue;
 		} else {
 			res = dry_run ? 0 : unlink(path->buf);
 			if (!res) {
 				quote_path_relative(path->buf, prefix, &quoted);
 				string_list_append(&dels, quoted.buf);
 			} else {
 				int saved_errno = errno;
 				quote_path_relative(path->buf, prefix, &quoted);
 				errno = saved_errno;
 				warning_errno(_(msg_warn_remove_failed), quoted.buf);
 				*dir_gone = 0;
 				ret = 1;
 			}
 			continue;
 		}
 
 		/* path too long, stat fails, or non-directory still exists */
 		*dir_gone = 0;
 		ret = 1;
 		break;
 	}
 	closedir(dir);
 
 	strbuf_setlen(path, original_len);
 
 	if (*dir_gone) {
 		res = dry_run ? 0 : rmdir(path->buf);
 		if (!res)
 			*dir_gone = 1;
 		else {
 			int saved_errno = errno;
 			quote_path_relative(path->buf, prefix, &quoted);
 			errno = saved_errno;
 			warning_errno(_(msg_warn_remove_failed), quoted.buf);
 			*dir_gone = 0;
 			ret = 1;
 		}
 	}
 
 	if (!*dir_gone && !quiet) {
 		int i;
 		for (i = 0; i < dels.nr; i++)
 			printf(dry_run ?  _(msg_would_remove) : _(msg_remove), dels.items[i].string);
 	}
+out:
+	strbuf_release(&quoted);
 	string_list_clear(&dels, 0);
 	return ret;
 }
-- 
2.14.1

