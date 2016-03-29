From: tboegi@web.de
Subject: [PATCH v1 6/7] correct blame for files commited with CRLF
Date: Tue, 29 Mar 2016 15:25:38 +0200
Message-ID: <1459257938-17389-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 15:23:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aktbn-0001Jv-DH
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 15:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756086AbcC2NW4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 09:22:56 -0400
Received: from mout.web.de ([212.227.15.4]:55659 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752700AbcC2NWs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 09:22:48 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0MRTzc-1aIPSH4Bp2-00SjUQ; Tue, 29 Mar 2016 15:22:46
 +0200
X-Mailer: git-send-email 2.8.0.rc2.2.g1a4d45a.dirty
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:lEC2bGDn/FCtD5/OE5S+LLhx9w6VTUsIIIoxz8jT7pKc2mKycQi
 BgDCrePRy2yQEdr9m8qV/8d30/PyKI4q/gEpXwMnlWv7eMfhvHsFMk5kQPRvZFIdrVq1d7N
 Px1AQICLioZroMgFsWnKh6LDX7PqYJiBBjU9XuWksyLVZ2vkNFDCJ5YDI8XPkivCUUPsTib
 +rkJKjBvfQ3Rk5o7dkKaw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:USQ+jT6HQYk=:y2fNtT9+Le0qI8QmvXFZvZ
 BWIwlzMe70edNkFd7P3zxUod4JHCf1BHtQqRnW/yUoXDSLHdoVqrUo/f+1ggv65c78ya+95se
 h7eUwBLbspp/cjqiTmZ92oToZuMcHaT4wcO2ZUUk3qlaoDl49cQ+0jK4UwlUiybpuohuOcBH2
 12mL17+dXrwgHy9SESoDRTpFR24S0Mbd/zgJErvq0pjNe3Kqkf2m6DvynCbh/glqB56lFHEJ2
 6dXUdqU2g4mr+gOJzl93VdaxpncOYn+LnVp0fRaMLqK9PGnqx4gubbpg1MftKLgrtaFiEBltz
 CUKq9yWiLmsRIdsAHRsBvqbAT9he5FFSfqXRwRGTgG3JZQDhForcS75xePtXO9QRfd8IeeUsw
 nVCnKZ+Eny/+xQwIuCmPMf2m3KPnPLUPh6s6uhVpVWK6nu9zW0ge5oRPbByjTd3M9KARZ788d
 V5OZm8b3RZEC+rDN2Iqd1g60Jch8eW0zb4SjNFcHyUWU9M6X+i/5LoQaCPT8i7U0BQQ5a6NCL
 WX5a/DvuK6P/zUuHGmZm5jQAVVrUuEENgTH4nxJrSHvs3us57Q2Es3oa5dqeCoz977F1PLTJ3
 T2MMoOpbViOnpF32RyZkUvs0XFy4HqMjijEebYxa5Af7kS9OJTXpI6irqUx7VoAM1JcmgzCHE
 Hxf8kqS/J6wa4J7KMsFO/HU1rzu2h3Z+zZGrZnUDO1wZOLww+eQPiUgYnjLqSi66phmOMTOWx
 m+/rPnBpdxl/Z8DM2D4W7vCJOCDjeykBvJSggdYDl/kCQnQ19VoLUXknUs3hvmufHR+1SUpa 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290131>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

git blame reports lines as not "Not Committed Yet" when they have
CRLF in the index, CRLF in the worktree and e.g. core.autocrlf is true.

Since commit c48053 "new safer autocrlf handling", files that have CRLF
in the index are not normalized at commit when e.g. core.autocrl is set=
=2E

Whenever a CLRF conversion is needed (or any filter us set), load the
index temporally, before calling convert_to_git()

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 builtin/blame.c               |  6 +++++-
 convert.c                     | 10 ++++++++++
 convert.h                     |  1 +
 t/t8003-blame-corner-cases.sh | 14 ++++++++++++++
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index e982fb8..a219068 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2376,7 +2376,11 @@ static struct commit *fake_working_tree_commit(s=
truct diff_options *opt,
 		if (strbuf_read(&buf, 0, 0) < 0)
 			die_errno("failed to read from stdin");
 	}
-	convert_to_git(path, buf.buf, buf.len, &buf, 0);
+	if (convert_needs_conversion(path)) {
+		read_cache();
+		convert_to_git(path, buf.buf, buf.len, &buf, 0);
+		discard_cache();
+	}
 	origin->file.ptr =3D buf.buf;
 	origin->file.size =3D buf.len;
 	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1);
diff --git a/convert.c b/convert.c
index 4ed5d89..02c50da 100644
--- a/convert.c
+++ b/convert.c
@@ -903,6 +903,16 @@ const char *get_convert_attr_ascii(const char *pat=
h)
 	return "";
 }
=20
+int convert_needs_conversion(const char *path)
+{
+	struct conv_attrs ca;
+
+	convert_attrs(&ca, path);
+	if (ca.drv || ca.ident || ca.crlf_action !=3D CRLF_BINARY)
+		return 1;
+	return 0;
+}
+
 int convert_to_git(const char *path, const char *src, size_t len,
                    struct strbuf *dst, enum safe_crlf checksafe)
 {
diff --git a/convert.h b/convert.h
index ccf436b..ffd9c32 100644
--- a/convert.h
+++ b/convert.h
@@ -35,6 +35,7 @@ extern enum eol core_eol;
 extern const char *get_cached_convert_stats_ascii(const char *path);
 extern const char *get_wt_convert_stats_ascii(const char *path);
 extern const char *get_convert_attr_ascii(const char *path);
+int convert_needs_conversion(const char *path);
=20
 /* returns 1 if *dst was used */
 extern int convert_to_git(const char *path, const char *src, size_t le=
n,
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases=
=2Esh
index 6568429..a9b266f 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -212,4 +212,18 @@ test_expect_success 'blame file with CRLF attribut=
es text' '
 	grep "A U Thor" actual
 '
=20
+test_expect_success 'blame file with CRLF core.autocrlf=3Dtrue' '
+	git config core.autocrlf false &&
+	printf "testcase\r\n" >crlfinrepo &&
+	>.gitattributes &&
+	git add crlfinrepo &&
+	git commit -m "add crlfinrepo" &&
+	git config core.autocrlf true &&
+	mv crlfinrepo tmp &&
+	git checkout crlfinrepo &&
+	rm tmp &&
+	git blame crlfinrepo >actual &&
+	grep "A U Thor" actual
+'
+
 test_done
--=20
2.8.0.rc2.6.g3847ccb
