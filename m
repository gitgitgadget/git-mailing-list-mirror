From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/7] revert: free revs->cmdline.rev
Date: Mon, 21 May 2012 16:56:07 +0200
Message-ID: <20120521145610.1911.46356.chriscool@tuxfamily.org>
References: <20120521143309.1911.94302.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nick Bowler <nbowler@elliptictech.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 21 17:10:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWUG4-0003sk-T8
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 17:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671Ab2EUPKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 11:10:49 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:40127 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576Ab2EUPKr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 11:10:47 -0400
Received: from [127.0.1.1] (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 44FB1A620B;
	Mon, 21 May 2012 17:10:36 +0200 (CEST)
X-git-sha1: 1c47c46501e7b175eee91f56a93578f085c2938c 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20120521143309.1911.94302.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198113>

add_rev_cmdline() in revision.c is (re)allocating an array of
struct rev_cmdline_entry. This patch releases it.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/revert.c b/builtin/revert.c
index 5f82a84..1d32ed5 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -217,6 +217,8 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
 	res = sequencer_pick_revisions(&opts);
+	if (opts.revs)
+		free(opts.revs->cmdline.rev);
 	free(opts.revs);
 	if (res < 0)
 		die(_("revert failed"));
@@ -233,6 +235,8 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
 	res = sequencer_pick_revisions(&opts);
+	if (opts.revs)
+		free(opts.revs->cmdline.rev);
 	free(opts.revs);
 	if (res < 0)
 		die(_("cherry-pick failed"));
-- 
1.7.10.2.555.g6528037
