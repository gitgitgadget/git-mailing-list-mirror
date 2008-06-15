From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 06/20] Tests for PackReverseIndex
Date: Sun, 15 Jun 2008 23:45:35 +0200
Message-ID: <1213566349-25395-7-git-send-email-marek.zawirski@gmail.com>
References: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-2-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-3-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-4-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-5-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-6-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 15 23:47:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K804E-0001bl-Nc
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbYFOVqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 17:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbYFOVqY
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:46:24 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:49881 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088AbYFOVqT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:46:19 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3137938fgg.17
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 14:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Qaeg6/OeKFwggPWHP3oYmNCyYimC1k+7Qgd1qaxA3xI=;
        b=WJSfzqtuFlZIa0ZVDprdKfF8JU6EF3GAM4noGgJmTva85aE7UwX4k1m8WjIVqK74Ao
         kXlfypEVj6jUFCfmYbNf3BMjm8Tm0Pn+m3nKjXtbmcpldPZgJNRkeIe3W6efP4q3wU+j
         lXaeR3LwY0Fl9D2OD5drQ8qEgCfI+PhjXMxJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TERP/BKeEd/EGSmvuCI5TlR3KkzOguiC7vNZIDuIEzErvrCExCvkklZmA8F9G2Izv9
         YpB7CV4f2gziitGIzEqqPayYV4JqspyQFAivi6BTkBzk9rF4gC+HPZFdalmjInATlOAt
         h7f2ODj7wehUA6nSuQnH+JkrITuqmdYScsab0=
Received: by 10.86.27.9 with SMTP id a9mr7195345fga.57.1213566378499;
        Sun, 15 Jun 2008 14:46:18 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id l19sm10902826fgb.7.2008.06.15.14.46.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 14:46:16 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1213566349-25395-6-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85128>

Test cases based on new pack index, with big offsets (> 2^31).
Index was generated from artificially generated pack (repository).

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../org/spearce/jgit/lib/PackReverseIndexTest.java |  115 ++++++++++++++++++++
 org.spearce.jgit.test/tst/pack-huge.idx            |  Bin 0 -> 2368 bytes
 2 files changed, 115 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackReverseIndexTest.java
 create mode 100644 org.spearce.jgit.test/tst/pack-huge.idx

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackReverseIndexTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackReverseIndexTest.java
new file mode 100644
index 0000000..a06c613
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackReverseIndexTest.java
@@ -0,0 +1,115 @@
+/*
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.lib;
+
+import java.io.File;
+
+import org.spearce.jgit.errors.CorruptObjectException;
+import org.spearce.jgit.lib.PackIndex.MutableEntry;
+
+public class PackReverseIndexTest extends RepositoryTestCase {
+
+	private PackIndex idx;
+
+	private PackReverseIndex reverseIdx;
+
+	/**
+	 * Set up tested class instance, test constructor by the way.
+	 */
+	public void setUp() throws Exception {
+		super.setUp();
+		// index with both small (< 2^31) and big offsets 
+		idx = PackIndex.open(new File(new File("tst"),
+				"pack-huge.idx"));
+		reverseIdx = new PackReverseIndex(idx);
+	}
+
+	/**
+	 * Test findObject() for all index entries.
+	 */
+	public void testFindObject() {
+		for (MutableEntry me : idx)
+			assertEquals(me.toObjectId(), reverseIdx.findObject(me.getOffset()));
+	}
+
+	/**
+	 * Test findObject() with illegal argument.
+	 */
+	public void testFindObjectWrongOffset() {
+		assertNull(reverseIdx.findObject(0));
+	}
+
+	/**
+	 * Test findNextOffset() for all index entries.
+	 * 
+	 * @throws CorruptObjectException
+	 */
+	public void testFindNextOffset() throws CorruptObjectException {
+		long offset = findFirstOffset();
+		assertTrue(offset > 0);
+		for (int i = 0; i < idx.getObjectCount(); i++) {
+			long newOffset = reverseIdx.findNextOffset(offset, Long.MAX_VALUE);
+			assertTrue(newOffset > offset);
+			if (i == idx.getObjectCount() - 1)
+				assertEquals(newOffset, Long.MAX_VALUE);
+			else
+				assertEquals(newOffset, idx.findOffset(reverseIdx
+						.findObject(newOffset)));
+			offset = newOffset;
+		}
+	}
+
+	/**
+	 * Test findNextOffset() with wrong illegal argument as offset.
+	 */
+	public void testFindNextOffsetWrongOffset() {
+		try {
+			reverseIdx.findNextOffset(0, Long.MAX_VALUE);
+			fail("findNextOffset() should throw exception");
+		} catch (CorruptObjectException x) {
+			// expected
+		}
+	}
+
+	private long findFirstOffset() {
+		long min = Long.MAX_VALUE;
+		for (MutableEntry me : idx)
+			min = Math.min(min, me.getOffset());
+		return min;
+	}
+}
diff --git a/org.spearce.jgit.test/tst/pack-huge.idx b/org.spearce.jgit.test/tst/pack-huge.idx
new file mode 100644
index 0000000000000000000000000000000000000000..0a5bbfb6a6c1453926f7d1ceaa78af494a8b460d
GIT binary patch
literal 2368
zcmd7Tdo<K(7zgkfni%6YQn^GXGpJCQK`t|=u%X&vbaR(MbA%*Y)9QkCnN)*W#wD`S
zRzxDDVik%Smy!Dz3?WJ`rOrl%eScw(<8(Tmwm<fd&-uR3^S<x%n}6oKv%zF43<eVc
z;EO=@*NB4srIvx-QV7udlI5WPy~M!XuMr3PUxEbvFOdNK#ZaJLN)q%INP+dYkOt=<
zGE2yU8iEGo{wG#|-vN>Tij`pRd#nQY7F!MKA3*`kQJkj)a;Y_-2T@r>6|DcOwP40#
zYM}m+Fks%gZ=ep&EWm>Gx4?mO3pBx6>t9&M^kUw-u`-=-wd|mdRKhc%z3Bd_j3ZUc
zWckHw-5QZ>PpzD%uTgKTG1vcev~<^Nuom1z?blMx=#@?B>gP17cQlPL4MPkyd@=~+
z)|HBnlU&683U;z@2B$a;<e(k6KFa9(dYX|0i^|BN@;#x?`wzkLs2eC6GP~Sg$0NEQ
z*$3Y45zO-0V*0d0O$sunLS`MVol`aF^Ph=-GGhFSZ^f|<y?6ZlNA~DTOZ)0kJt<-f
zEy*|cFn7@AiNgEN6S#|m##^^(WjN=x%4i@Ckn{iMk=L+K+DL5QJeh4W+<%Q{R(Y;<
zFAWp>m(qG$p;5cv<BOMu^0JkDeMuEtidC(5H{-Z<P2`@;+>hO{_Zg2(gPZVs&H8s(
z)cEQS)2k&4x3`wT3Gp6Ioh2V$esJzoU&X+SjMv(5nvQk5RCYO-7~DA<{qUL_r=h{h
z1XoRW6><+q1Zj+SI)zT5GZWpPCdAa9ada={A2yuYT_;EL_G#TZO0X3TbEK`si)C#x
zFPtzCHmm2Id6gu_a3jqUev!BEtrs3fUOe@#F`q+Z+Zl_Om!Wm6j<K_X$_iNhOvcO9
zLUa29oufhR+MgQDj~{At4@ujU%N*99`h8PGAF=l=A+mvqlI(kxhZCezj84o3drqVj
z9&t(Y?hLz;Uuj9Z&4-y{yo$1^n9Xo!FI|J86`pba*X<rXitnP+FKz3fyKX#PR6VnD
zb=kOslE*GxH8Vw)y@zJ}-I)w3FWPPmhBnp4iBh>hS~a10Ki>>ivbmIqh$0`iA9Exi
zH;hv_7GB)wA@R(Kt16Usrp1<eKiAQEp-`5AwA52bbVZi5#HO_5_I!NtX?_0{UuU`U
z3msK`irOX{c2@n`#|wjH2gZ>y_+*O0hc>A}{9Efccj-HOy2nHle%=!;`GTj2jo>23
zQ2u%~`v`ddB5aqX@_@VNknzl<DXBHY#Z<dCk1XH6Rq$KY?OT4+k?>@6$F{h20Xn(c
z)%1rrQTfE_N#7wKNt?zS_7&b8I9BFBjww<YQOWnBqc|n&?i~zE&e|=FpthJ}vr#nM
zQCF+efkqE3(|MTpx+fbwYht?gmWS)anGz-LWc|Ts6uudL{=iIy;ud%v%XE(H7Py9L
z5KO4by+`9}W%c0g19Va?d1F&ptT7#-vHV0eKMk9zoLPdQ+$!`tn2>JgnVBQaz*|R&
zInieX+@zRYX5-~`UN%&(>5`ODHJOLD$~YobkVMZLE1j0+kr=IEbq=I(Q|f`5Q1C|v
z;EM3clORO^Q2@NhBF<i7Em~lW0G0z{0C*ooeQ@Cu0f7vz(hfwgB@70;4EjhwLNatV
z1|$lQ1f&3I0K8*}<b6?mL+}|xebEsQF#9d&%L3pngI9x;16G_uK7;Pb6C(yGAfYz{
zdOKlkROvXBm(SmQ0p$pb4Sg3%>|7>-*-)LBJeMpcl=)J(n&)cvLceIf4uG;b?o!TN
zo!C9!zXRpjn2H%FpUPah2jvJWfjFO^=k%hJ)8=Yc1(YSsoT~Z#?$l*jF@l0Nla?U^
i5q#0RPo(gxfy(+nDH~nU#sqlR)DGh}_SPGh&i(_^HDsp%

literal 0
HcmV?d00001

-- 
1.5.5.1
