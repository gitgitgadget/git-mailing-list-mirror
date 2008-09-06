From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] builtin-merge: release the lockfile in try_merge_strategy()
Date: Sat,  6 Sep 2008 18:29:49 +0200
Message-ID: <1220718589-12424-1-git-send-email-vmiklos@frugalware.org>
References: <20080906021222.GY16514@genesis.frugalware.org>
Cc: Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 18:31:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kc0gf-0005Xn-M0
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 18:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbYIFQ3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 12:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbYIFQ3x
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 12:29:53 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:38297 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbYIFQ3x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 12:29:53 -0400
Received: from vmobile.example.net (dsl5401CA71.pool.t-online.hu [84.1.202.113])
	by yugo.frugalware.org (Postfix) with ESMTP id E10601DDC5B;
	Sat,  6 Sep 2008 18:29:50 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 3C21984CA; Sat,  6 Sep 2008 18:29:50 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1
In-Reply-To: <20080906021222.GY16514@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95080>

Once we committed the locked index, we should release the lockfile. In
most cases this is done automatically when the process ends, but this is
not true in this case.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sat, Sep 06, 2008 at 04:12:23AM +0200, Miklos Vajna <vmiklos@frugalware.org> wrote:
> > Try reverting 18668f5 (builtin-merge: avoid run_command_v_opt() for
> > recursive and subtree, 2008-08-28).  That patch seems to be
> > seriously broken.
>
> Yes, that works around the problem. I'll try to send a fix later
> today.

Here is - I think - the proper prefix.

 builtin-merge.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index b857cf6..bb09e6f 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -576,6 +576,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 				(write_cache(index_fd, active_cache, active_nr) ||
 				 commit_locked_index(lock)))
 			die ("unable to write %s", get_index_file());
+		rollback_lock_file(lock);
 		return clean ? 0 : 1;
 	} else {
 		args = xmalloc((4 + commit_list_count(common) +
-- 
1.6.0.1
