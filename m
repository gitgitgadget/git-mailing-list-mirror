From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/2] Add explanation why we do not allow to sparse checkout to empty working tree
Date: Thu, 22 Sep 2011 21:24:23 +1000
Message-ID: <1316690663-29382-2-git-send-email-pclouds@gmail.com>
References: <7vk4911ux8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 13:24:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6hOb-00021U-0W
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 13:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014Ab1IVLYo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Sep 2011 07:24:44 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42979 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757Ab1IVLYn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 07:24:43 -0400
Received: by mail-gx0-f174.google.com with SMTP id 6so1849200gxk.19
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 04:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qHhW6oKYunGD/75JwXKPXVIvvFR8xbteP1A7PZweKok=;
        b=qZtI5+tb883oQ0cJ5FLjtP8Gf/TSlOnF3vLlN/z36XJx7NM69DkZODKPnCPZeuI5UX
         AXZsG1+pwQ00uC2vjDxCTnLdiT/qczjZzvTbVhdvqmeNnzVsl/FEQ4/F+lsDAjNczqzd
         s1fp6M/zeFpI8Yt+8KHdduRdYFsw4MwDZMmNA=
Received: by 10.236.190.193 with SMTP id e41mr12255191yhn.118.1316690683147;
        Thu, 22 Sep 2011 04:24:43 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id s19sm29997934anm.20.2011.09.22.04.24.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Sep 2011 04:24:42 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 22 Sep 2011 21:24:33 +1000
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <7vk4911ux8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181893>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 unpack-trees.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index fcf40a0..bacb473 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1119,8 +1119,13 @@ int unpack_trees(unsigned len, struct tree_desc =
*t, struct unpack_trees_options
 		}
 		if (ret < 0)
 			goto return_failed;
+		/*
+		 * Sparse checkout is meant to narrow down checkout area
+		 * but it does not make sense to narrow down to empty working
+		 * tree. This is usually a mistake in sparse checkout rules.
+		 * Do not allow users to do that.
+		 */
 		if (o->result.cache_nr && empty_worktree) {
-			/* dubious---why should this fail??? */
 			ret =3D unpack_failed(o, "Sparse checkout leaves no entry on workin=
g directory");
 			goto done;
 		}
--=20
1.7.3.1.256.g2539c.dirty
