From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] name-rev: include taggerdate in considering the best name
Date: Fri, 22 Apr 2016 15:39:01 +0200 (CEST)
Message-ID: <d58135a6720d6fda4c7bc609e77e2709d161fe25.1461332260.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Olaf Hering <olaf@aepfle.de>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 15:39:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atbIq-0005lr-B8
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 15:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbcDVNjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 09:39:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:64640 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752494AbcDVNjT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 09:39:19 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MEo4s-1avE713eVm-00Fzhb; Fri, 22 Apr 2016 15:39:06
 +0200
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Z36P+vXMEiuGCqa6VaIfQOKkIHt6OdedY7sP98IZ6aB7w15MBHa
 3m7WiHdtMPfxhCeUF7MB4I/tJzUlGyqaLBqR4p65gTOrSnDvkj44q49fGO4QbGLSXm5LR9Y
 cmdzDQO+xwsDHChKfpKPv0d4Hz7W8pURv1er/GNOAyWLC3ytwXCGODtUIak1Gbw0EdS2PZr
 9aTu+3RY68PhJo71mcezQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ttmvl3Akw1E=:4pZaMvWMjosY8hSirAdy64
 2wn/Zd33ZmesSnCm1oE17PNxA5SdUs1uS1anZsdtf3LQIBegOcHeHiT+uZ4HEI0k7A7HWyWt1
 74XeUZgR952bZT981UH4FoOq9UJPOoCnEQlgwHk1StXTtW+Kr3Stwj/LJ5hCALr6X8eMU6kur
 6zEKQnxa+HsPpxh0Ud4dyQf5GjYhrRhod9Xkjfoy6VviGAfEjTWCi2MBJBaiOz97euCfyWO9C
 Uag9+k54HfV99aZJbp4K8R4NVHrO/RQC6fQd6EtAmbVTKr8w6lb4lSIvYeOSLEIb1tyZT0GvF
 MHotsM+bOBHuqL60lO4Pt/754SudmFmyauB67jRnMV7msDMEaWRpHwql6RuN7RPxPynCDFB0H
 4gMDRevlf+eQ0vl8vQ3TO0VY74L6PNTjD49WM00p4X95A+OBE7bQ1lebFBZDx+KOgbbmPQoEL
 x7fQ+RBnKgqHhWKlDn4/bNFL9ST7/F1b/ABkXhjmG8jqTPvDSMa4vPe34fEV4OJIT7qj/HwUm
 hUVERPzExXd5FeoF5jY+62UV3f86zdvrIRbYN3V+lNEcaBpMcRMiiFYsH5mODkWA+9si6rDw3
 rJwqNgIVAI8PN5h88N0HfPAuXFi2HJqtvaPNaYiW9BLAhfrloKEzoA3G0R/Yuy2uJzydYS1FI
 NQBs36ujVqqkS15qUqKLdvlFPZmpB9Q2S4Vizn5bi/QGytmMfkY2y9POZ6Iqi/A3IDarcqaqb
 azdYpf/qQTttNvUmjrp3F6RCvq5RC8vSjhQrNBBLab2FzOUjfsfkigBXKZ/cMLlXzEOOYm4t 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292204>

We most likely want the oldest tag that contained the commit to be
reported. So let's remember the taggerdate, and make it more important
than anything else when choosing the best name for a given commit.

Suggested by Linus Torvalds.

Note that we need to update t9903 because it tested for the old behavior
(which preferred the description "b1~1" over "tags/t2~1").

We might want to introduce a --heed-taggerdate option, and make the new
behavior dependent on that, if it turns out that some scripts rely on the
old name-rev method.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/name-rev.c     | 19 +++++++++++++------
 t/t9903-bash-prompt.sh |  2 +-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 092e03c..57be35f 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -10,6 +10,7 @@
 
 typedef struct rev_name {
 	const char *tip_name;
+	unsigned long taggerdate;
 	int generation;
 	int distance;
 } rev_name;
@@ -20,7 +21,8 @@ static long cutoff = LONG_MAX;
 #define MERGE_TRAVERSAL_WEIGHT 65535
 
 static void name_rev(struct commit *commit,
-		const char *tip_name, int generation, int distance,
+		const char *tip_name, unsigned long taggerdate,
+		int generation, int distance,
 		int deref)
 {
 	struct rev_name *name = (struct rev_name *)commit->util;
@@ -43,9 +45,12 @@ static void name_rev(struct commit *commit,
 		name = xmalloc(sizeof(rev_name));
 		commit->util = name;
 		goto copy_data;
-	} else if (name->distance > distance) {
+	} else if (name->taggerdate > taggerdate ||
+			(name->taggerdate == taggerdate &&
+			 name->distance > distance)) {
 copy_data:
 		name->tip_name = tip_name;
+		name->taggerdate = taggerdate;
 		name->generation = generation;
 		name->distance = distance;
 	} else
@@ -66,11 +71,11 @@ copy_data:
 				new_name = xstrfmt("%.*s^%d", (int)len, tip_name,
 						   parent_number);
 
-			name_rev(parents->item, new_name, 0,
+			name_rev(parents->item, new_name, taggerdate, 0,
 				distance + MERGE_TRAVERSAL_WEIGHT, 0);
 		} else {
-			name_rev(parents->item, tip_name, generation + 1,
-				distance + 1, 0);
+			name_rev(parents->item, tip_name, taggerdate,
+				generation + 1, distance + 1, 0);
 		}
 	}
 }
@@ -140,6 +145,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 	struct name_ref_data *data = cb_data;
 	int can_abbreviate_output = data->tags_only && data->name_only;
 	int deref = 0;
+	unsigned long taggerdate = ULONG_MAX;
 
 	if (data->tags_only && !starts_with(path, "refs/tags/"))
 		return 0;
@@ -164,12 +170,13 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 			break; /* broken repository */
 		o = parse_object(t->tagged->oid.hash);
 		deref = 1;
+		taggerdate = t->date;
 	}
 	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
 
 		path = name_ref_abbrev(path, can_abbreviate_output);
-		name_rev(commit, xstrdup(path), 0, 0, deref);
+		name_rev(commit, xstrdup(path), taggerdate, 0, 0, deref);
 	}
 	return 0;
 }
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index ffbfa0e..0db4469 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -107,7 +107,7 @@ test_expect_success 'prompt - describe detached head - contains' '
 '
 
 test_expect_success 'prompt - describe detached head - branch' '
-	printf " ((b1~1))" >expected &&
+	printf " ((tags/t2~1))" >expected &&
 	git checkout b1^ &&
 	test_when_finished "git checkout master" &&
 	(
-- 
2.8.1.207.g7b140d3
