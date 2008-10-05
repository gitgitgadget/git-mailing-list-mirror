From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 4/6] Add tags to the graphical history display.
Date: Mon,  6 Oct 2008 01:36:40 +0200
Message-ID: <1223249802-9959-5-git-send-email-robin.rosenberg@dewire.com>
References: <1223249802-9959-1-git-send-email-robin.rosenberg@dewire.com>
 <1223249802-9959-2-git-send-email-robin.rosenberg@dewire.com>
 <1223249802-9959-3-git-send-email-robin.rosenberg@dewire.com>
 <1223249802-9959-4-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spearce@spearce.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 06 01:39:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmdCH-0003Jr-6X
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 01:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbYJEXiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 19:38:07 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbYJEXiE
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 19:38:04 -0400
Received: from av7-2-sn3.vrr.skanova.net ([81.228.9.182]:51258 "EHLO
	av7-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbYJEXhy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 19:37:54 -0400
Received: by av7-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 678DD38926; Mon,  6 Oct 2008 01:37:52 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av7-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 2C1EE38705; Mon,  6 Oct 2008 01:37:52 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id D68C237E47;
	Mon,  6 Oct 2008 01:37:51 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.310.gf789d0.dirty
In-Reply-To: <1223249802-9959-4-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97551>

Both the SWT (Eclipse) drawing and Swing versions are updated.
The coloring and shapes are intentionally not the same as for gitk.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../egit/core/internal/storage/KidWalk.java        |    3 +-
 .../egit/ui/internal/history/SWTCommit.java        |    5 +-
 .../egit/ui/internal/history/SWTPlotRenderer.java  |   64 ++++++++++++=
+++++++-
 .../spearce/egit/ui/internal/history/SWTWalk.java  |    5 +-
 .../org/spearce/jgit/awtui/AWTPlotRenderer.java    |   46 ++++++++++++=
++
 .../spearce/jgit/revplot/AbstractPlotRenderer.java |   18 +++++-
 .../src/org/spearce/jgit/revplot/PlotCommit.java   |    8 ++-
 .../src/org/spearce/jgit/revplot/PlotWalk.java     |   56 ++++++++++++=
++++-
 .../src/org/spearce/jgit/revwalk/RevWalk.java      |   19 +++++-
 9 files changed, 209 insertions(+), 15 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/s=
torage/KidWalk.java b/org.spearce.egit.core/src/org/spearce/egit/core/i=
nternal/storage/KidWalk.java
index 6b8f468..b337efe 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/=
KidWalk.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/=
KidWalk.java
@@ -11,6 +11,7 @@
 import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.revwalk.RevCommit;
+import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.revwalk.RevWalk;
=20
 class KidWalk extends RevWalk {
@@ -19,7 +20,7 @@ KidWalk(final Repository repo) {
 	}
=20
 	@Override
-	protected RevCommit createCommit(final AnyObjectId id) {
+	protected RevCommit createCommit(final AnyObjectId id, final Ref[] ta=
gs) {
 		return new KidCommit(id);
 	}
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/histo=
ry/SWTCommit.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/interna=
l/history/SWTCommit.java
index fa0d25d..2341fbd 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTC=
ommit.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTC=
ommit.java
@@ -10,12 +10,13 @@
 import org.eclipse.swt.widgets.Widget;
 import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.revplot.PlotCommit;
+import org.spearce.jgit.lib.Ref;
=20
 class SWTCommit extends PlotCommit<SWTCommitList.SWTLane> {
 	Widget widget;
=20
-	SWTCommit(final AnyObjectId id) {
-		super(id);
+	SWTCommit(final AnyObjectId id, final Ref[] tags) {
+		super(id, tags);
 	}
=20
 	@Override
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/histo=
ry/SWTPlotRenderer.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/i=
nternal/history/SWTPlotRenderer.java
index 23ec255..56d5842 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTP=
lotRenderer.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTP=
lotRenderer.java
@@ -15,7 +15,10 @@
 import org.eclipse.swt.widgets.Display;
 import org.eclipse.swt.widgets.Event;
 import org.eclipse.swt.widgets.TableItem;
+import org.eclipse.ui.themes.ColorUtil;
 import org.spearce.egit.ui.internal.history.SWTCommitList.SWTLane;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.revplot.AbstractPlotRenderer;
 import org.spearce.jgit.revplot.PlotCommit;
=20
@@ -26,7 +29,13 @@
=20
 	private final Color sys_gray;
=20
-	private Color sys_darkblue;
+	private final Color sys_darkblue;
+
+	private final Color sys_yellow;
+
+	private final Color sys_green;
+
+	private final Color sys_white;
=20
 	GC g;
=20
@@ -43,6 +52,9 @@ SWTPlotRenderer(final Display d) {
 		sys_black =3D d.getSystemColor(SWT.COLOR_BLACK);
 		sys_gray =3D d.getSystemColor(SWT.COLOR_GRAY);
 		sys_darkblue =3D d.getSystemColor(SWT.COLOR_DARK_BLUE);
+		sys_yellow =3D d.getSystemColor(SWT.COLOR_YELLOW);
+		sys_green =3D d.getSystemColor(SWT.COLOR_GREEN);
+		sys_white =3D d.getSystemColor(SWT.COLOR_WHITE);
 	}
=20
 	void paint(final Event event) {
@@ -92,7 +104,57 @@ protected void drawText(final String msg, final int=
 x, final int y) {
 		g.drawString(msg, cellX + x, cellY + texty);
 	}
=20
+	@Override
+	protected int drawLabel(int x, int y, Ref ref) {
+		String txt;
+		String name =3D ref.getOrigName();
+		if (name.startsWith(Constants.R_HEADS)) {
+			g.setBackground(sys_green);
+			txt =3D name.substring(Constants.R_HEADS.length());
+		} else if (name.startsWith(Constants.R_REMOTES)){
+			g.setBackground(sys_gray);
+			txt =3D name.substring(Constants.R_REMOTES.length());
+		} else if (name.startsWith(Constants.R_TAGS)){
+			g.setBackground(sys_yellow);
+			txt =3D name.substring(Constants.R_TAGS.length());
+		} else {
+			// Whatever this would be
+			g.setBackground(sys_white);
+			if (name.startsWith(Constants.R_REFS))
+				txt =3D name.substring(Constants.R_REFS.length());
+			else
+				txt =3D name; // HEAD and such
+		}
+		Color peeledColor =3D null;
+		if (ref.getPeeledObjectId() !=3D null) {
+			peeledColor =3D new Color(g.getDevice(), ColorUtil.blend(g.getBackg=
round().getRGB(), sys_white.getRGB()));
+			g.setBackground(peeledColor);
+		}
+		if (txt.length() > 12)
+			txt =3D txt.substring(0,11) + "\u2026"; // ellipsis "=E2=80=A6" (in=
 UTF-8)
+
+		Point testsz =3D g.stringExtent(txt);
+		final int texty =3D (y * 2 - testsz.y) / 2;
+		g.setForeground(sys_black);
+		g.drawString(txt, x + 2, cellY + texty);
+		g.setLineWidth(2);
+		Color blend1 =3D new Color(g.getDevice(), ColorUtil.blend(g.getBackg=
round().getRGB(), sys_gray.getRGB()));
+		g.setForeground(blend1);
+		g.drawRoundRectangle(x, cellY + texty -2, testsz.x + 3, testsz.y + 3=
, testsz.y/4, testsz.y/4);
+		g.setLineWidth(2);
+		Color blend2 =3D new Color(g.getDevice(), ColorUtil.blend(g.getBackg=
round().getRGB(), sys_black.getRGB()));
+		g.setForeground(blend2);
+		g.drawRoundRectangle(x + 1, cellY + texty -1, testsz.x + 1, testsz.y=
 + 1, testsz.y/4, testsz.y/4);
+
+		blend1.dispose();
+		blend2.dispose();
+		if (peeledColor !=3D null)
+			peeledColor.dispose();
+		return 8 + testsz.x;
+	}
+
 	protected Color laneColor(final SWTLane myLane) {
 		return myLane !=3D null ? myLane.color : sys_black;
 	}
+
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/histo=
ry/SWTWalk.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/=
history/SWTWalk.java
index 527d284..bc347db 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTW=
alk.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTW=
alk.java
@@ -11,6 +11,7 @@
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.revplot.PlotWalk;
 import org.spearce.jgit.revwalk.RevCommit;
+import org.spearce.jgit.lib.Ref;
=20
 class SWTWalk extends PlotWalk {
 	SWTWalk(final Repository repo) {
@@ -18,7 +19,7 @@ SWTWalk(final Repository repo) {
 	}
=20
 	@Override
-	protected RevCommit createCommit(final AnyObjectId id) {
-		return new SWTCommit(id);
+	protected RevCommit createCommit(final AnyObjectId id, final Ref[] ta=
gs) {
+		return new SWTCommit(id, tags);
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/awtui/AWTPlotRendere=
r.java b/org.spearce.jgit/src/org/spearce/jgit/awtui/AWTPlotRenderer.ja=
va
index b6b715c..5dcddf5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/awtui/AWTPlotRenderer.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/awtui/AWTPlotRenderer.java
@@ -44,6 +44,8 @@
=20
 import org.spearce.jgit.awtui.CommitGraphPane.GraphCellRender;
 import org.spearce.jgit.awtui.SwingCommitList.SwingLane;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.revplot.AbstractPlotRenderer;
 import org.spearce.jgit.revplot.PlotCommit;
=20
@@ -134,4 +136,48 @@ void paintTriangleDown(final int cx, final int y, =
final int h) {
 		g.drawPolygon(triangle);
 	}
=20
+	@Override
+	protected int drawLabel(int x, int y, Ref ref) {
+		String txt;
+		String name =3D ref.getOrigName();
+		if (name.startsWith(Constants.R_HEADS)) {
+			g.setBackground(Color.GREEN);
+			txt =3D name.substring(Constants.R_HEADS.length());
+		} else if (name.startsWith(Constants.R_REMOTES)){
+			g.setBackground(Color.LIGHT_GRAY);
+			txt =3D name.substring(Constants.R_REMOTES.length());
+		} else if (name.startsWith(Constants.R_TAGS)){
+			g.setBackground(Color.YELLOW);
+			txt =3D name.substring(Constants.R_TAGS.length());
+		} else {
+			// Whatever this would be
+			g.setBackground(Color.WHITE);
+			if (name.startsWith(Constants.R_REFS))
+				txt =3D name.substring(Constants.R_REFS.length());
+			else
+				txt =3D name; // HEAD and such
+		}
+		if (ref.getPeeledObjectId() !=3D null) {
+			float[] colorComponents =3D g.getBackground().getRGBColorComponents=
(null);
+			colorComponents[0] *=3D 0.9;
+			colorComponents[1] *=3D 0.9;
+			colorComponents[2] *=3D 0.9;
+			g.setBackground(new Color(colorComponents[0],colorComponents[1],col=
orComponents[2]));
+		}
+		if (txt.length() > 12)
+			txt =3D txt.substring(0,11) + "\u2026"; // ellipsis "=E2=80=A6" (in=
 UTF-8)
+
+		final int texth =3D g.getFontMetrics().getHeight();
+		int textw =3D g.getFontMetrics().stringWidth(txt);
+		g.setColor(g.getBackground());
+		int arcHeight =3D texth/4;
+		int y0 =3D y - texth/2 + (cell.getHeight() - texth)/2;
+		g.fillRoundRect(x , y0, textw + arcHeight*2, texth -1, arcHeight, ar=
cHeight);
+		g.setColor(g.getColor().darker());
+		g.drawRoundRect(x, y0, textw + arcHeight*2, texth -1 , arcHeight, ar=
cHeight);
+		g.setColor(Color.BLACK);
+		g.drawString(txt, x + arcHeight, y0 + texth - g.getFontMetrics().get=
Descent());
+
+		return arcHeight * 3 + textw;
+	}
 }
\ No newline at end of file
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revplot/AbstractPlot=
Renderer.java b/org.spearce.jgit/src/org/spearce/jgit/revplot/AbstractP=
lotRenderer.java
index f175c9d..603547b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revplot/AbstractPlotRendere=
r.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revplot/AbstractPlotRendere=
r.java
@@ -37,6 +37,7 @@
=20
 package org.spearce.jgit.revplot;
=20
+import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.revwalk.RevFlag;
=20
 /**
@@ -140,11 +141,24 @@ protected void paintCommit(final PlotCommit<TLane=
> commit, final int h) {
 		else
 			drawCommitDot(dotX, dotY, dotSize, dotSize);
=20
+		int textx =3D Math.max(maxCenter + LANE_WIDTH / 2, dotX + dotSize) +=
 8;
+		int n =3D commit.refs =3D=3D null ? 0 : commit.refs.length;
+		for (int i =3D 0; i < n; ++i) {
+			textx +=3D drawLabel(textx + dotSize, h/2, commit.refs[i]);
+		}
+
 		final String msg =3D commit.getShortMessage();
-		final int textx =3D Math.max(maxCenter + LANE_WIDTH / 2, dotX + dotS=
ize) + 8;
-		drawText(msg, textx, h / 2);
+		drawText(msg, textx + dotSize + n*2, h / 2);
 	}
=20
+	/** FIXME: supply text=20
+	 * @param x=20
+	 * @param y=20
+	 * @param ref TODO
+	 * @return TODO
+	 */
+	protected abstract int drawLabel(int x, int y, Ref ref);
+
 	private int computeDotSize(final int h) {
 		int d =3D (int) (Math.min(h, LANE_WIDTH) * 0.50f);
 		d +=3D (d & 1);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotCommit.j=
ava b/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotCommit.java
index 5a5ef1e..fac89f5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotCommit.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotCommit.java
@@ -39,6 +39,7 @@
=20
 import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.revwalk.RevCommit;
+import org.spearce.jgit.lib.Ref;
=20
 /**
  * A commit reference to a commit in the DAG.
@@ -58,14 +59,19 @@
=20
 	PlotCommit[] children;
=20
+	Ref[] refs;
+
 	/**
 	 * Create a new commit.
 	 *=20
 	 * @param id
 	 *            the identity of this commit.
+	 * @param tags
+	 *            the tags associated with this commit, null for no tags
 	 */
-	protected PlotCommit(final AnyObjectId id) {
+	protected PlotCommit(final AnyObjectId id, final Ref[] tags) {
 		super(id);
+		this.refs =3D tags;
 		passingLanes =3D NO_LANES;
 		children =3D NO_CHILDREN;
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotWalk.jav=
a b/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotWalk.java
index e5e8aba..6e253f4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotWalk.java
@@ -37,14 +37,26 @@
=20
 package org.spearce.jgit.revplot;
=20
+import java.io.IOException;
+import java.util.Collections;
+import java.util.Comparator;
+import java.util.List;
+import java.util.Map;
+
 import org.spearce.jgit.lib.AnyObjectId;
+import org.spearce.jgit.lib.Commit;
+import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.Tag;
 import org.spearce.jgit.revwalk.RevCommit;
 import org.spearce.jgit.revwalk.RevSort;
 import org.spearce.jgit.revwalk.RevWalk;
=20
 /** Specialized RevWalk for visualization of a commit graph. */
 public class PlotWalk extends RevWalk {
+
+	Map<AnyObjectId, List<Ref>> reverseRefMap;
+
 	/**
 	 * Create a new revision walker for a given repository.
 	 *=20
@@ -54,6 +66,7 @@
 	public PlotWalk(final Repository repo) {
 		super(repo);
 		super.sort(RevSort.TOPO, true);
+		reverseRefMap =3D repo.getAllRefsByPeeledObjectId();
 	}
=20
 	@Override
@@ -64,7 +77,46 @@ public void sort(final RevSort s, final boolean use)=
 {
 	}
=20
 	@Override
-	protected RevCommit createCommit(final AnyObjectId id) {
-		return new PlotCommit(id);
+	protected RevCommit createCommit(final AnyObjectId id, final Ref[] ta=
gs) {
+		return new PlotCommit(id, tags);
+	}
+
+	@Override
+	protected Ref[] getTags(final AnyObjectId commitId) {
+		List<Ref> list =3D reverseRefMap.get(commitId);
+		Ref[] tags;
+		if (list =3D=3D null)
+			tags =3D null;
+		else {
+			if (list !=3D null && list.size() > 1) {
+				Collections.sort(list, new Comparator<Ref>() {
+					public int compare(Ref o1, Ref o2) {
+						try {
+							Object obj1 =3D getRepository().mapObject(o1.getObjectId(), o1.=
getName());
+							Object obj2 =3D getRepository().mapObject(o2.getObjectId(), o2.=
getName());
+							long t1 =3D timeof(obj1);
+							long t2 =3D timeof(obj2);
+							if (t1 > t2)
+								return -1;
+							if (t1 < t2)
+								return 1;
+							return 0;
+						} catch (IOException e) {
+							// ignore
+							return 0;
+						}
+					}
+					long timeof(Object o) {
+						if (o instanceof Commit)
+							return ((Commit)o).getCommitter().getWhen().getTime();
+						if (o instanceof Tag)
+							return ((Tag)o).getTagger().getWhen().getTime();
+						return 0;
+					}
+				});
+			}
+			tags =3D list.toArray(new Ref[list.size()]);
+		}
+		return tags;
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java=
 b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
index d7e4c58..41d57c6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
@@ -53,6 +53,7 @@
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.ObjectIdSubclassMap;
 import org.spearce.jgit.lib.ObjectLoader;
+import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.lib.WindowCursor;
 import org.spearce.jgit.revwalk.filter.RevFilter;
@@ -541,7 +542,7 @@ public RevTree lookupTree(final AnyObjectId id) {
 	public RevCommit lookupCommit(final AnyObjectId id) {
 		RevCommit c =3D (RevCommit) objects.get(id);
 		if (c =3D=3D null) {
-			c =3D createCommit(id);
+			c =3D createCommit(id, getTags(id));
 			objects.add(c);
 		}
 		return c;
@@ -564,7 +565,7 @@ public RevObject lookupAny(final AnyObjectId id, fi=
nal int type) {
 		if (r =3D=3D null) {
 			switch (type) {
 			case Constants.OBJ_COMMIT:
-				r =3D createCommit(id);
+				r =3D createCommit(id, getTags(id));
 				break;
 			case Constants.OBJ_TREE:
 				r =3D new RevTree(id);
@@ -687,7 +688,7 @@ public RevObject parseAny(final AnyObjectId id)
 			final int type =3D ldr.getType();
 			switch (type) {
 			case Constants.OBJ_COMMIT: {
-				final RevCommit c =3D createCommit(ldr.getId());
+				final RevCommit c =3D createCommit(ldr.getId(), getTags(ldr.getId(=
)));
 				c.parseCanonical(this, data);
 				r =3D c;
 				break;
@@ -718,6 +719,14 @@ public RevObject parseAny(final AnyObjectId id)
 	}
=20
 	/**
+	 * @param commitId
+	 * @return the list of refs associated with a commit, possibly filter=
ed
+	 */
+	protected Ref[] getTags(final AnyObjectId commitId) {
+		return null; // Don't get tags in the basic case
+	}
+
+	/**
 	 * Ensure the object's content has been parsed.
 	 * <p>
 	 * This method only returns successfully if the object exists and was=
 parsed
@@ -1008,9 +1017,11 @@ private boolean isNotStarted() {
 	 *=20
 	 * @param id
 	 *            the object this walker requires a commit reference for.
+	 * @param tags
+	 *            tags attached to the commit
 	 * @return a new unparsed reference for the object.
 	 */
-	protected RevCommit createCommit(final AnyObjectId id) {
+	protected RevCommit createCommit(final AnyObjectId id, final Ref[] ta=
gs) {
 		return new RevCommit(id);
 	}
=20
--=20
1.6.0.1.310.gf789d0.dirty
