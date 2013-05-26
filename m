From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 1/4] clone: let the user know when check_everything_connected is run
Date: Sun, 26 May 2013 08:16:14 +0700
Message-ID: <1369530977-12746-2-git-send-email-pclouds@gmail.com>
References: <1369530977-12746-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 26 03:15:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgPYL-0007vE-RE
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 03:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758564Ab3EZBPN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 May 2013 21:15:13 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:55883 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758754Ab3EZBPL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 May 2013 21:15:11 -0400
Received: by mail-pd0-f179.google.com with SMTP id q11so5413372pdj.10
        for <git@vger.kernel.org>; Sat, 25 May 2013 18:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GsSMJI1crhtOkjBo+VzUXKSk7xI5S1wcHJ4Kf32whdM=;
        b=nxnPNxwIRemkMIdqiy5juT7GjF50c4Fic21n1VkWd+Wn7zntYw0VkTlknNkNKPe5Qo
         HiigeopxoGMGu6Fpjzc5qkC8SM+ZMpQCTaz5uiNoxvaPbKSWCgraNZkmq34SjRVEH6bv
         h8/EBvJfqcXuqmhxOsZo0JleFk3YTmV1hsnrhNMf97LnXI4eScSYscvY1hHV37PVMP5M
         iwrOIEBGDR45zfWk/xnOdNioHHoi1Xbi9Z8dFeXiWJfa/C0jTE+ANcyEYRoRqtlpQAh5
         fjDBMpptlincSfqB/VNlsgDtwf0nYbxJ3yWJgyrTJjmrlSlbq22T691IKutssnqJhicm
         EfpQ==
X-Received: by 10.66.163.232 with SMTP id yl8mr24142156pab.104.1369530911199;
        Sat, 25 May 2013 18:15:11 -0700 (PDT)
Received: from lanh ([115.73.211.70])
        by mx.google.com with ESMTPSA id 10sm22393367pbm.0.2013.05.25.18.15.08
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 25 May 2013 18:15:10 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 26 May 2013 08:16:28 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1369530977-12746-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225538>

check_everything_connected could take a long time, especially in the
clone case where the whole DAG is traversed. The user deserves to know
what's going on.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clone.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 035ab64..dad4265 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -546,8 +546,12 @@ static void update_remote_refs(const struct ref *r=
efs,
 {
 	const struct ref *rm =3D mapped_refs;
=20
+	if (0 <=3D option_verbosity)
+		printf(_("Checking connectivity... "));
 	if (check_everything_connected(iterate_ref_map, 0, &rm))
 		die(_("remote did not send all necessary objects"));
+	if (0 <=3D option_verbosity)
+		printf(_("done\n"));
=20
 	if (refs) {
 		write_remote_refs(mapped_refs);
--=20
1.8.2.83.gc99314b
