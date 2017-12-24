Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B5401F406
	for <e@80x24.org>; Sun, 24 Dec 2017 08:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750989AbdLXIXL (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 03:23:11 -0500
Received: from forward3j.cmail.yandex.net ([5.255.227.21]:37277 "EHLO
        forward3j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750805AbdLXIXK (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 24 Dec 2017 03:23:10 -0500
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Dec 2017 03:23:10 EST
Received: from mxback9g.mail.yandex.net (mxback9g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:170])
        by forward3j.cmail.yandex.net (Yandex) with ESMTP id 7EEEA203C4;
        Sun, 24 Dec 2017 11:15:36 +0300 (MSK)
Received: from web45o.yandex.ru (web45o.yandex.ru [2a02:6b8:0:1a2d::5:225])
        by mxback9g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id EmqbHNGGPX-FZmm00qu;
        Sun, 24 Dec 2017 11:15:36 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1514103336;
        bh=GVbQJYnsVVc/0rJIJCrLi6osXWf3pgnw5dKP2X5AJUU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date;
        b=ZvyCPZEwH6vxsiRHs/9OZxUQf7GMmuwKThaCgbtVy88HLkOL9Nxa8UwH/OMZA+b/t
         mPi4j/s+5D17N4+LYo/NbQAnNtDCK87PUt+wEbBDG6B2yd9Cb+FBQ541rEEnMU5A4n
         A4IDjFEYcwbiEUJPdWFJvyC1NArSIcn3o4HfI4gQ=
Authentication-Results: mxback9g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web45o.yandex.ru with HTTP;
        Sun, 24 Dec 2017 11:15:35 +0300
From:   Vadim Petrov <tridronet@yandex.ru>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1.1712232332000.406@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <3853941514059379@web42g.yandex.ru> <alpine.DEB.2.21.1.1712232332000.406@MININT-6BKU6QN.europe.corp.microsoft.com>
Subject: Re: [PATCH] setup.c: move statement under condition
MIME-Version: 1.0
Message-Id: <1483761514103335@web45o.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sun, 24 Dec 2017 12:15:35 +0400
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for your replay.

> I have to be honest: this commit message (including the subject) left me
> quite puzzled as to the intent of this patch.

I still only learn English and correctly express my thoughts while somewhat difficult.

> If you also have a background story that motivated you to work on this
> patch (for example, if you hit a huge performance bottleneck with some
> tool that fed thousands of absolute paths to Git that needed to be turned
> into paths relative to the worktree's top-level directory), I would
> definitely put that into the commit message, too, if I were you.

I have no such reason. I just saw it and wanted to change it.

> Up until recently, we encouraged dropping the curly brackets from
> single-line statements, but apparently that changed. It is now no longer
> clear, and often left to the taste of the contributor. But not always.
> Sometimes we start a beautiful thread discussion the pros and cons of
> curly brackets in the middle of patch review, and drop altogether
> reviewing the actual patch.

I was guided by the rule from the Documentation/CodingGuidelines:
	When there are multiple arms to a conditional and some of them
	require braces, enclose even a single line block in braces for
	consistency.
And other code from setup.c:
	from function get_common_dir:
		if (!has_common) {
			/* several commands */
		} else {
			free(candidate->work_tree);
		}
	from function get_common_dir_noenv:
		if (file_exists(path.buf)) {
			/* several commands */
		} else {
			strbuf_addstr(sb, gitdir);
		}

> In short: I think your patch does the right thing, and I hope that you
> find my suggestions to improve the patch useful.

I fixed the patch according to your suggestions.


Signed-off-by: Vadim Petrov <tridronet@yandex.ru>
---
 setup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index 8cc34186c..1a414c256 100644
--- a/setup.c
+++ b/setup.c
@@ -27,26 +27,26 @@ static int abspath_part_inside_repo(char *path)
 {
 	size_t len;
 	size_t wtlen;
 	char *path0;
 	int off;
 	const char *work_tree = get_git_work_tree();
 
 	if (!work_tree)
 		return -1;
 	wtlen = strlen(work_tree);
 	len = strlen(path);
-	off = offset_1st_component(path);
 
-	/* check if work tree is already the prefix */
-	if (wtlen <= len && !strncmp(path, work_tree, wtlen)) {
+	if (wtlen > len || strncmp(path, work_tree, wtlen))
+		off = offset_1st_component(path);
+	else { /* check if work tree is already the prefix */
 		if (path[wtlen] == '/') {
 			memmove(path, path + wtlen + 1, len - wtlen);
 			return 0;
 		} else if (path[wtlen - 1] == '/' || path[wtlen] == '\0') {
 			/* work tree is the root, or the whole path */
 			memmove(path, path + wtlen, len - wtlen + 1);
 			return 0;
 		}
 		/* work tree might match beginning of a symlink to work tree */
 		off = wtlen;
 	}
-- 
2.15.1.433.g936d1b989
