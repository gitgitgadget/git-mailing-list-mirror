From: Nick Townsend <nick.townsend@mac.com>
Subject: Re: [PATCH] Improvements to git-archive tests and add_submodule_odb()
Date: Mon, 02 Dec 2013 16:14:37 -0800
Message-ID: <6D370472-81BB-4249-9ADA-1C906C26D88F@mac.com>
References: <C74C17E7-0780-4FE1-B916-D1A444F3B592@mac.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?windows-1252?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 03 01:15:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnddz-0007Cb-Jb
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 01:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749Ab3LCAPK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Dec 2013 19:15:10 -0500
Received: from nk11p03mm-asmtpout002.mac.com ([17.158.232.237]:47625 "EHLO
	nk11p03mm-asmtp002.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751191Ab3LCAPJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 Dec 2013 19:15:09 -0500
Received: from [172.16.1.4]
 (99-120-78-245.lightspeed.sntcca.sbcglobal.net [99.120.78.245])
 by nk11p03mm-asmtp002.mac.com
 (Oracle Communications Messaging Server 7u4-27.08(7.0.4.27.7) 64bit (built Aug
 22 2013)) with ESMTPSA id <0MX70030QFD8A230@nk11p03mm-asmtp002.mac.com> for
 git@vger.kernel.org; Tue, 03 Dec 2013 00:15:09 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.11.72,1.0.14,0.0.0000
 definitions=2013-12-02_04:2013-12-02,2013-12-02,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=13 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=7.0.1-1308280000 definitions=main-1312020196
In-reply-to: <C74C17E7-0780-4FE1-B916-D1A444F3B592@mac.com>
X-Mailer: Apple Mail (2.1822)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238667>

=46rom: Nick Townsend <nick.townsend@mac.com>
Date: Mon, 25 Nov 2013 15:31:09 -0800
Subject: [PATCH 1/2] submodule: add_submodule_odb() usability

Although add_submodule_odb() is documented as being
externally usable, it is declared static and also
has incorrect documentation.  This commit fixes those
and makes no changes to existing code using them.
All tests still pass.

Improved wording based on Rene Scharfe feedback

Signed-off-by: Nick Townsend <nick.townsend@mac.com>
---
 Documentation/technical/api-ref-iteration.txt | 4 ++--
 submodule.c                                   | 2 +-
 submodule.h                                   | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/api-ref-iteration.txt b/Documentat=
ion/technical/api-ref-iteration.txt
index aa1c50f..02adfd4 100644
--- a/Documentation/technical/api-ref-iteration.txt
+++ b/Documentation/technical/api-ref-iteration.txt
@@ -50,10 +50,10 @@ submodules object database. You can do this by a co=
de-snippet like
 this:
=20
 	const char *path =3D "path/to/submodule"
-	if (!add_submodule_odb(path))
+	if (add_submodule_odb(path))
 		die("Error submodule '%s' not populated.", path);
=20
-`add_submodule_odb()` will return an non-zero value on success. If you
+`add_submodule_odb()` will return zero on success. If you
 do not do this you will get an error for each ref that it does not poi=
nt
 to a valid object.
=20
diff --git a/submodule.c b/submodule.c
index 1905d75..1ea46be 100644
--- a/submodule.c
+++ b/submodule.c
@@ -143,7 +143,7 @@ void stage_updated_gitmodules(void)
 		die(_("staging updated .gitmodules failed"));
 }
=20
-static int add_submodule_odb(const char *path)
+int add_submodule_odb(const char *path)
 {
 	struct strbuf objects_directory =3D STRBUF_INIT;
 	struct alternate_object_database *alt_odb;
diff --git a/submodule.h b/submodule.h
index 7beec48..3e3cdca 100644
--- a/submodule.h
+++ b/submodule.h
@@ -41,5 +41,6 @@ int find_unpushed_submodules(unsigned char new_sha1[2=
0], const char *remotes_nam
 		struct string_list *needs_pushing);
 int push_unpushed_submodules(unsigned char new_sha1[20], const char *r=
emotes_name);
 void connect_work_tree_and_git_dir(const char *work_tree, const char *=
git_dir);
+int add_submodule_odb(const char *path);
=20
 #endif
--=20
1.8.5.4.g9d8cd78.dirty

On 2 Dec 2013, at 16:10, Nick Townsend <nick.townsend@mac.com> wrote:

> As per the previous patch request, I=92ve delayed the work on git-arc=
hive.
> However the following two patches (attached as replies) should still
> be considered.
> Kind Regards
> Nick
