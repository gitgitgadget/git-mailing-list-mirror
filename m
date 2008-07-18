From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 27/28] Convert rev-list, log, glog programs to args4j
Date: Thu, 17 Jul 2008 21:44:20 -0400
Message-ID: <1216345461-59382-28-git-send-email-spearce@spearce.org>
References: <1216345461-59382-1-git-send-email-spearce@spearce.org>
 <1216345461-59382-2-git-send-email-spearce@spearce.org>
 <1216345461-59382-3-git-send-email-spearce@spearce.org>
 <1216345461-59382-4-git-send-email-spearce@spearce.org>
 <1216345461-59382-5-git-send-email-spearce@spearce.org>
 <1216345461-59382-6-git-send-email-spearce@spearce.org>
 <1216345461-59382-7-git-send-email-spearce@spearce.org>
 <1216345461-59382-8-git-send-email-spearce@spearce.org>
 <1216345461-59382-9-git-send-email-spearce@spearce.org>
 <1216345461-59382-10-git-send-email-spearce@spearce.org>
 <1216345461-59382-11-git-send-email-spearce@spearce.org>
 <1216345461-59382-12-git-send-email-spearce@spearce.org>
 <1216345461-59382-13-git-send-email-spearce@spearce.org>
 <1216345461-59382-14-git-send-email-spearce@spearce.org>
 <1216345461-59382-15-git-send-email-spearce@spearce.org>
 <1216345461-59382-16-git-send-email-spearce@spearce.org>
 <1216345461-59382-17-git-send-email-spearce@spearce.org>
 <1216345461-59382-18-git-send-email-spearce@spearce.org>
 <1216345461-59382-19-git-send-email-spearce@spearce.org>
 <1216345461-59382-20-git-send-email-spearce@spearce.org>
 <1216345461-59382-21-git-send-email-spearce@spearce.org>
 <1216345461-59382-22-git-send-email-spearce@spearce.org>
 <1216345461-59382-23-git-send-email-spearce@spearce.org>
 <1216345461-59382-24-git-send-email-spearce@spearce.org>
 <1216345461-59382-25-git-send-email-spearce@spearce.org>
 <1216345461-59382-26-git-send-email-spearce@spearce.org>
 <1216345461-59382-27-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:47:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJf4M-0006LD-FL
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758787AbYGRBqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbYGRBqA
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:46:00 -0400
Received: from george.spearce.org ([209.20.77.23]:47013 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758868AbYGRBpV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:45:21 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id C86BE38351; Fri, 18 Jul 2008 01:44:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E11F7383A8;
	Fri, 18 Jul 2008 01:44:33 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.3.569.ga9185
In-Reply-To: <1216345461-59382-27-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88973>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/pgm/RevWalkTextBuiltin.java   |  146 +++++++++++---------
 1 files changed, 80 insertions(+), 66 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevWalkTextBuiltin.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevWalkTextBuiltin.java
index 2aba3c5..97fe7a4 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevWalkTextBuiltin.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevWalkTextBuiltin.java
@@ -41,9 +41,14 @@ import java.util.ArrayList;
 import java.util.EnumSet;
 import java.util.List;
 
+import org.kohsuke.args4j.Argument;
+import org.kohsuke.args4j.Option;
 import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.pgm.opt.PathTreeFilterHandler;
 import org.spearce.jgit.revwalk.ObjectWalk;
 import org.spearce.jgit.revwalk.RevCommit;
+import org.spearce.jgit.revwalk.RevFlag;
 import org.spearce.jgit.revwalk.RevObject;
 import org.spearce.jgit.revwalk.RevSort;
 import org.spearce.jgit.revwalk.RevWalk;
@@ -53,98 +58,105 @@ import org.spearce.jgit.revwalk.filter.CommitterRevFilter;
 import org.spearce.jgit.revwalk.filter.MessageRevFilter;
 import org.spearce.jgit.revwalk.filter.RevFilter;
 import org.spearce.jgit.treewalk.filter.AndTreeFilter;
-import org.spearce.jgit.treewalk.filter.PathFilter;
-import org.spearce.jgit.treewalk.filter.PathFilterGroup;
 import org.spearce.jgit.treewalk.filter.TreeFilter;
 
 abstract class RevWalkTextBuiltin extends TextBuiltin {
 	RevWalk walk;
 
+	@Option(name = "--objects")
 	boolean objects = false;
 
+	@Option(name = "--parents")
 	boolean parents = false;
 
+	@Option(name = "--total-count")
 	boolean count = false;
 
 	char[] outbuffer = new char[Constants.OBJECT_ID_LENGTH * 2];
 
-	@Override
-	public final void execute(String[] args) throws Exception {
-		final EnumSet<RevSort> sorting = EnumSet.noneOf(RevSort.class);
-		final List<String> argList = new ArrayList<String>();
-		final List<RevFilter> revLimiter = new ArrayList<RevFilter>();
-		List<PathFilter> pathLimiter = null;
-		for (final String a : args) {
-			if (pathLimiter != null)
-				pathLimiter.add(PathFilter.create(a));
-			else if ("--".equals(a))
-				pathLimiter = new ArrayList<PathFilter>();
-			else if (a.startsWith("--author="))
-				revLimiter.add(AuthorRevFilter.create(a.substring("--author="
-						.length())));
-			else if (a.startsWith("--committer="))
-				revLimiter.add(CommitterRevFilter.create(a
-						.substring("--committer=".length())));
-			else if (a.startsWith("--grep="))
-				revLimiter.add(MessageRevFilter.create(a.substring("--grep="
-						.length())));
-			else if ("--objects".equals(a))
-				objects = true;
-			else if ("--date-order".equals(a))
-				sorting.add(RevSort.COMMIT_TIME_DESC);
-			else if ("--topo-order".equals(a))
-				sorting.add(RevSort.TOPO);
-			else if ("--reverse".equals(a))
-				sorting.add(RevSort.REVERSE);
-			else if ("--boundary".equals(a))
-				sorting.add(RevSort.BOUNDARY);
-			else if ("--parents".equals(a))
-				parents = true;
-			else if ("--total-count".equals(a))
-				count = true;
-			else
-				argList.add(a);
-		}
+	private final EnumSet<RevSort> sorting = EnumSet.noneOf(RevSort.class);
+
+	private void enableRevSort(final RevSort type, final boolean on) {
+		if (on)
+			sorting.add(type);
+		else
+			sorting.remove(type);
+	}
+
+	@Option(name = "--date-order")
+	void enableDateOrder(final boolean on) {
+		enableRevSort(RevSort.COMMIT_TIME_DESC, on);
+	}
+
+	@Option(name = "--topo-order")
+	void enableTopoOrder(final boolean on) {
+		enableRevSort(RevSort.TOPO, on);
+	}
+
+	@Option(name = "--reverse")
+	void enableReverse(final boolean on) {
+		enableRevSort(RevSort.REVERSE, on);
+	}
+
+	@Option(name = "--boundary")
+	void enableBoundary(final boolean on) {
+		enableRevSort(RevSort.BOUNDARY, on);
+	}
+
+	@Argument(index = 0, metaVar = "commit-ish")
+	private final List<RevCommit> commits = new ArrayList<RevCommit>();
+
+	@Option(name = "--", metaVar = "path", multiValued = true, handler = PathTreeFilterHandler.class)
+	private TreeFilter pathFilter = TreeFilter.ALL;
+
+	private final List<RevFilter> revLimiter = new ArrayList<RevFilter>();
 
+	@Option(name = "--author")
+	void addAuthorRevFilter(final String who) {
+		revLimiter.add(AuthorRevFilter.create(who));
+	}
+
+	@Option(name = "--committer")
+	void addCommitterRevFilter(final String who) {
+		revLimiter.add(CommitterRevFilter.create(who));
+	}
+
+	@Option(name = "--grep")
+	void addCMessageRevFilter(final String msg) {
+		revLimiter.add(MessageRevFilter.create(msg));
+	}
+
+	@Override
+	protected void run() throws Exception {
 		walk = createWalk();
 		for (final RevSort s : sorting)
 			walk.sort(s, true);
 
-		if (pathLimiter != null && !pathLimiter.isEmpty())
-			walk.setTreeFilter(AndTreeFilter.create(PathFilterGroup
-					.create(pathLimiter), TreeFilter.ANY_DIFF));
+		if (pathFilter != TreeFilter.ALL)
+			walk.setTreeFilter(AndTreeFilter.create(pathFilter,
+					TreeFilter.ANY_DIFF));
 
 		if (revLimiter.size() == 1)
 			walk.setRevFilter(revLimiter.get(0));
 		else if (revLimiter.size() > 1)
 			walk.setRevFilter(AndRevFilter.create(revLimiter));
 
-		final long start = System.currentTimeMillis();
-		boolean have_revision = false;
-		boolean not = false;
-		for (String a : argList) {
-			if ("--not".equals(a)) {
-				not = true;
-				continue;
-			}
-			boolean menot = false;
-			if (a.startsWith("^")) {
-				a = a.substring(1);
-				menot = true;
-			}
-			final RevCommit c = walk.parseCommit(resolve(a));
-			if (not ^ menot)
-				walk.markUninteresting(c);
-			else {
+		if (commits.isEmpty()) {
+			final ObjectId head = db.resolve(Constants.HEAD);
+			if (head == null)
+				throw die("Cannot resolve " + Constants.HEAD);
+			commits.add(walk.parseCommit(head));
+		}
+		for (final RevCommit c : commits) {
+			final RevCommit real = argWalk == walk ? c : walk.parseCommit(c);
+			if (c.has(RevFlag.UNINTERESTING))
+				walk.markUninteresting(real);
+			else
 				walk.markStart(c);
-				have_revision = true;
-			}
 		}
-		if (!have_revision)
-			walk.markStart(walk.parseCommit(resolve("HEAD")));
-
-		int n = walkLoop();
 
+		final long start = System.currentTimeMillis();
+		final int n = walkLoop();
 		if (count) {
 			final long end = System.currentTimeMillis();
 			System.err.print(n);
@@ -158,7 +170,9 @@ abstract class RevWalkTextBuiltin extends TextBuiltin {
 	protected RevWalk createWalk() {
 		if (objects)
 			return new ObjectWalk(db);
-		return new RevWalk(db);
+		if (argWalk == null)
+			argWalk = new RevWalk(db);
+		return argWalk;
 	}
 
 	protected int walkLoop() throws Exception {
-- 
1.5.6.3.569.ga9185
