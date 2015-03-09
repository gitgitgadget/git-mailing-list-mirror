From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] diff --cached: do not report i-t-a entries as "new"
Date: Mon,  9 Mar 2015 21:14:04 +0700
Message-ID: <1425910445-27383-2-git-send-email-pclouds@gmail.com>
References: <1425910445-27383-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 15:14:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUyRt-00055h-Lo
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 15:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754123AbbCIOOW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2015 10:14:22 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34337 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbbCIOOS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 10:14:18 -0400
Received: by pdno5 with SMTP id o5so21115653pdn.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 07:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GP74qMwzvW8b6WBrsM5/kSEzz+c/nWrpka1+XcakhQQ=;
        b=h+sCnB9gNTzRIwOZbjMUX6fOa6KhN9I1PVWRmWEWxQdblFtmleIXCX6oNibLG09x2o
         ii1qWcfM6TftiVKPfM4X1cpB9B/LbTahTG3oBj8OUo+HGLV5SiC03xh3AEW905rVmrKD
         XMZOmssWFbIBTBglMd9l3sxw/xg9Em1tQmiVjLkRKOI4YZuG5DCMkErBEPZpUkqRex7/
         m37a+IeasrHmbLQsSt9KSyHMv2g+myXI2O+QkvGkuB2Z9V9CpxmMERnPkutudwt4ZC2j
         mxjMfzCCBmAXWs04pHTt7E8SSanRo7vDIFfz1Jd8vc3KsYNFZ7YDOL9bU0Nox6IoHZuC
         +ySA==
X-Received: by 10.70.55.8 with SMTP id n8mr15933344pdp.167.1425910457860;
        Mon, 09 Mar 2015 07:14:17 -0700 (PDT)
Received: from lanh ([115.73.245.123])
        by mx.google.com with ESMTPSA id g10sm11872700pdm.29.2015.03.09.07.14.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 07:14:17 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Mar 2015 21:14:14 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425910445-27383-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265166>

Paths marked by "git add -N" are simply a reminder to the user that
these files should be staged. If the user does not stage any of them,
"git commit" will not record them.

Align the behavior of "diff --cached" and "git commit". The most
prominent result of this patch is "git status" no longer reports i-t-a
paths as "Changes to be committed".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff-lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/diff-lib.c b/diff-lib.c
index a85c497..db0e6f8 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -400,6 +400,8 @@ static void do_oneway_diff(struct unpack_trees_opti=
ons *o,
 	 * Something added to the tree?
 	 */
 	if (!tree) {
+		if (idx && (idx->ce_flags & CE_INTENT_TO_ADD))
+			return;
 		show_new_file(revs, idx, cached, match_missing);
 		return;
 	}
--=20
2.3.0.rc1.137.g477eb31
