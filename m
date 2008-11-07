From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 6/7] Add tags to the graphical history display.
Date: Fri,  7 Nov 2008 23:07:43 +0100
Message-ID: <1226095664-13759-7-git-send-email-robin.rosenberg@dewire.com>
References: <1226095664-13759-1-git-send-email-robin.rosenberg@dewire.com>
 <1226095664-13759-2-git-send-email-robin.rosenberg@dewire.com>
 <1226095664-13759-3-git-send-email-robin.rosenberg@dewire.com>
 <1226095664-13759-4-git-send-email-robin.rosenberg@dewire.com>
 <1226095664-13759-5-git-send-email-robin.rosenberg@dewire.com>
 <1226095664-13759-6-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Fri Nov 07 23:09:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyZWN-0008MC-Q3
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 23:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbYKGWIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 17:08:07 -0500
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbYKGWIG
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 17:08:06 -0500
Received: from mail.dewire.com ([83.140.172.130]:11975 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751741AbYKGWH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 17:07:59 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 284D5147EACF;
	Fri,  7 Nov 2008 23:07:57 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ucO5kYMzPEOd; Fri,  7 Nov 2008 23:07:54 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id C6F16147EACC;
	Fri,  7 Nov 2008 23:07:46 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.578.g6a50
In-Reply-To: <1226095664-13759-6-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100347>

Both the SWT (Eclipse) drawing and Swing versions are updated.
The coloring and shapes are intentionally not the same as for gitk.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../egit/ui/internal/history/SWTCommit.java        |    5 +-
 .../egit/ui/internal/history/SWTPlotRenderer.java  |   71 ++++++++++++=
+++++++-
 .../spearce/egit/ui/internal/history/SWTWalk.java  |    2 +-
 .../org/spearce/jgit/awtui/AWTPlotRenderer.java    |   46 ++++++++++++=
+
 .../spearce/jgit/revplot/AbstractPlotRenderer.java |   23 ++++++-
 .../src/org/spearce/jgit/revplot/PlotCommit.java   |    8 ++-
 .../src/org/spearce/jgit/revplot/PlotWalk.java     |   60 ++++++++++++=
++++-
 7 files changed, 207 insertions(+), 8 deletions(-)

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
index c4ee282..b008df7 100644
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
@@ -92,7 +104,64 @@ protected void drawText(final String msg, final int=
 x, final int y) {
 		g.drawString(msg, cellX + x, cellY + texty, true);
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
+
+		// Make peeled objects, i.e. via annotated tags come out in a paler =
color
+		Color peeledColor =3D null;
+		if (ref.getPeeledObjectId() =3D=3D null || !ref.getPeeledObjectId().=
equals(ref.getObjectId())) {
+			peeledColor =3D new Color(g.getDevice(), ColorUtil.blend(g.getBackg=
round().getRGB(), sys_white.getRGB()));
+			g.setBackground(peeledColor);
+		}
+
+		if (txt.length() > 12)
+			txt =3D txt.substring(0,11) + "\u2026"; // ellipsis "=E2=80=A6" (in=
 UTF-8)
+
+		Point textsz =3D g.stringExtent(txt);
+		int arc =3D textsz.y/2;
+		final int texty =3D (y * 2 - textsz.y) / 2;
+
+		// Draw backgrounds
+		g.fillRoundRectangle(x + 1, cellY + texty -1, textsz.x + 3, textsz.y=
 + 1, arc, arc);
+		g.setForeground(sys_black);
+		g.drawString(txt, x + 2, cellY + texty, true);
+		g.setLineWidth(2);
+
+		// And a two color shaded border, blend with whatever background the=
re already is
+		g.setAlpha(128);
+		g.setForeground(sys_gray);
+		g.drawRoundRectangle(x, cellY + texty -2, textsz.x + 5, textsz.y + 3=
, arc, arc);
+		g.setLineWidth(2);
+		g.setForeground(sys_black);
+		g.drawRoundRectangle(x + 1, cellY + texty -1, textsz.x + 3, textsz.y=
 + 1, arc, arc);
+		g.setAlpha(255);
+
+		if (peeledColor !=3D null)
+			peeledColor.dispose();
+		return 8 + textsz.x;
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
index 527d284..57039b5 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTW=
alk.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTW=
alk.java
@@ -19,6 +19,6 @@ SWTWalk(final Repository repo) {
=20
 	@Override
 	protected RevCommit createCommit(final AnyObjectId id) {
-		return new SWTCommit(id);
+		return new SWTCommit(id, getTags(id));
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
index f175c9d..911dd68 100644
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
@@ -140,11 +141,29 @@ protected void paintCommit(final PlotCommit<TLane=
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
+	/**
+	 * Draw a decoration for the Ref ref at x,y
+	 *
+	 * @param x
+	 *            left
+	 * @param y
+	 *            top
+	 * @param ref
+	 *            A peeled ref
+	 * @return width of label in pixels
+	 */
+	protected abstract int drawLabel(int x, int y, Ref ref);
+
 	private int computeDotSize(final int h) {
 		int d =3D (int) (Math.min(h, LANE_WIDTH) * 0.50f);
 		d +=3D (d & 1);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotCommit.j=
ava b/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotCommit.java
index 5a5ef1e..c885a44 100644
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
+	final Ref[] refs;
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
index e5e8aba..8801850 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revplot/PlotWalk.java
@@ -37,14 +37,33 @@
=20
 package org.spearce.jgit.revplot;
=20
+import java.io.IOException;
+import java.util.Arrays;
+import java.util.Collection;
+import java.util.Comparator;
+import java.util.Map;
+import java.util.Set;
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
+	private Map<AnyObjectId, Set<Ref>> reverseRefMap;
+
+	@Override
+	public void dispose() {
+		super.dispose();
+		reverseRefMap.clear();
+	}
+
 	/**
 	 * Create a new revision walker for a given repository.
 	 *=20
@@ -54,6 +73,7 @@
 	public PlotWalk(final Repository repo) {
 		super(repo);
 		super.sort(RevSort.TOPO, true);
+		reverseRefMap =3D repo.getAllRefsByPeeledObjectId();
 	}
=20
 	@Override
@@ -65,6 +85,44 @@ public void sort(final RevSort s, final boolean use)=
 {
=20
 	@Override
 	protected RevCommit createCommit(final AnyObjectId id) {
-		return new PlotCommit(id);
+		return new PlotCommit(id, getTags(id));
+	}
+
+	protected Ref[] getTags(final AnyObjectId commitId) {
+		Collection<Ref> list =3D reverseRefMap.get(commitId);
+		Ref[] tags;
+		if (list =3D=3D null)
+			tags =3D null;
+		else {
+			tags =3D list.toArray(new Ref[list.size()]);
+			Arrays.sort(tags, new PlotRefComparator());
+		}
+		return tags;
+	}
+
+	class PlotRefComparator implements Comparator<Ref> {
+		public int compare(Ref o1, Ref o2) {
+			try {
+				Object obj1 =3D getRepository().mapObject(o1.getObjectId(), o1.get=
Name());
+				Object obj2 =3D getRepository().mapObject(o2.getObjectId(), o2.get=
Name());
+				long t1 =3D timeof(obj1);
+				long t2 =3D timeof(obj2);
+				if (t1 > t2)
+					return -1;
+				if (t1 < t2)
+					return 1;
+				return 0;
+			} catch (IOException e) {
+				// ignore
+				return 0;
+			}
+		}
+		long timeof(Object o) {
+			if (o instanceof Commit)
+				return ((Commit)o).getCommitter().getWhen().getTime();
+			if (o instanceof Tag)
+				return ((Tag)o).getTagger().getWhen().getTime();
+			return 0;
+		}
 	}
 }
--=20
1.6.0.3.578.g6a50
