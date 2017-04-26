Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF507207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754215AbdDZUFd (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:05:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:64709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754208AbdDZUFc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:05:32 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MX19U-1dZFAG26h2-00VuM2; Wed, 26
 Apr 2017 22:05:24 +0200
Date:   Wed, 26 Apr 2017 22:05:23 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] read-cache: close index.lock in do_write_index
Message-ID: <e1b4f9c377ceee296112fa07bd06492a1de1be67.1493237111.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:UgHl0zLA8D5PV90zFjlAUoIRadD0tWczfsabEFF92xqTcV0myn7
 /jgWNbWVEKUKqEQphr3qeJRB+IOACF9GBJslVcVOrCwYxy67/QpY88jUswKOT+ZF5xdYRWG
 BElkmOv0uyPJ0VJYe6cSd8owz2k4vKMhcx3n9vGNq+/jdLKP6xxl9ufWwL9T3Y54H3Zmwjn
 /UvAc1xPovMn20j5/girg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WZwxzEJfd1Y=:wpfFX6DFkVHKQkLpBaBcn6
 Y/ThbKsN/phEsK37b7zjAmkjYdeTrN8+8FLcNmKNS65QBJAF2abSFSwWNtp5xmasT8RYUNKdC
 V60L2gfjXJzv5y3fu8vt6RVrit3272AsF2kKcuNNRn7lxAmrhSYiGg4h90Hj1GYHgQeSNCsKG
 NLHGHnEqAlWbDXot5oaQ/Jqf7mPPrmkOEFavYoevc6CqNSAWZnWAWtMUynIaPBHWWqGmYrBlX
 N3cBFZNYwQM5uWX0UqzFwXmRKIffMBP52FO4mzCCR+KaLEl6IIBmTlbDUFN84/SnYlgyoO54o
 5Ae6twKqIpf7q5/szKg6aQQycNScQpch1Ckz5KmpbTb8Z5yXdKsn/wflYnYNhxeQG5KDO5sII
 zPtPQJcybxx9s6LLQ9joVrEBFJiZWkImzvkzhpSq/7UKz+8vr3xePMlpJVv/HfMCV+QK8P7Jd
 eX9CRGdLZCR7rpRQKHJCmvdfMP8klESS3mt702jlAgH+x+OpwCihD/nu1alj17vNZDX06WdpG
 s2S1rbFDJ48QkwdU4iMcBtNHpywhhoZ2oXxhk020LLqrRP71yZrrVE4xEZXAhznkj2nai4qqH
 1zMi6dsoi7Yl1TY5KhfUzuYm1utb4wwrO0Lp3p7+7SVmUmCBzUzSQyfzd1DM6ETlD6UnsB5Vd
 tXGbbs9Var9u+TdyA9E9qx4xuywAJkQQiw2RAXmBSxi0QeXw8EDWarcV7zvno62vltpLckeMs
 ym2CllPml+p+BamRKlXY5WvfsIi7h5j50i8x1V1DWf6kxBJPxSen3nR5+5HYN6j2gWmHTU4sG
 JwRME0K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach do_write_index() to close the index.lock file
before getting the mtime and updating the istate.timestamp
fields.

On Windows, a file's mtime is not updated until the file is
closed.  On Linux, the mtime is set after the last flush.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/do-write-index-mtime-v1
Fetch-It-Via: git fetch https://github.com/dscho/git do-write-index-mtime-v1

 read-cache.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 008b335844c..b0276fd5510 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2051,9 +2051,10 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
 		rollback_lock_file(lockfile);
 }
 
-static int do_write_index(struct index_state *istate, int newfd,
+static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			  int strip_extensions)
 {
+	int newfd = tempfile->fd;
 	git_SHA_CTX c;
 	struct cache_header hdr;
 	int i, err, removed, extended, hdr_version;
@@ -2162,7 +2163,11 @@ static int do_write_index(struct index_state *istate, int newfd,
 			return -1;
 	}
 
-	if (ce_flush(&c, newfd, istate->sha1) || fstat(newfd, &st))
+	if (ce_flush(&c, newfd, istate->sha1))
+		return -1;
+	if (close_tempfile(tempfile))
+		return error(_("could not close '%s'"), tempfile->filename.buf);
+	if (lstat(tempfile->filename.buf, &st))
 		return -1;
 	istate->timestamp.sec = (unsigned int)st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
@@ -2185,7 +2190,7 @@ static int commit_locked_index(struct lock_file *lk)
 static int do_write_locked_index(struct index_state *istate, struct lock_file *lock,
 				 unsigned flags)
 {
-	int ret = do_write_index(istate, get_lock_file_fd(lock), 0);
+	int ret = do_write_index(istate, &lock->tempfile, 0);
 	if (ret)
 		return ret;
 	assert((flags & (COMMIT_LOCK | CLOSE_LOCK)) !=
@@ -2282,7 +2287,7 @@ static int write_shared_index(struct index_state *istate,
 		return do_write_locked_index(istate, lock, flags);
 	}
 	move_cache_to_base_index(istate);
-	ret = do_write_index(si->base, fd, 1);
+	ret = do_write_index(si->base, &temporary_sharedindex, 1);
 	if (ret) {
 		delete_tempfile(&temporary_sharedindex);
 		return ret;

base-commit: e2cb6ab84c94f147f1259260961513b40c36108a
-- 
2.12.2.windows.2.800.gede8f145e06
