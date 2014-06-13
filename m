From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/32] read-cache: be strict about "changed" in remove_marked_cache_entries()
Date: Fri, 13 Jun 2014 19:19:26 +0700
Message-ID: <1402661991-14977-8-git-send-email-pclouds@gmail.com>
References: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 14:20:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQTW-0002u5-3G
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbaFMMUt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 08:20:49 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:65469 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbaFMMUs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:20:48 -0400
Received: by mail-pb0-f42.google.com with SMTP id ma3so1846553pbc.29
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 05:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=F3SOXzRj7YASY0snKfHUzMCJjAGzU5GHdBB1TXWjAwU=;
        b=vv2G7+cBL28rjROiJ7IQikEdyK00ic33zvWowefB/4ORuc7tKeTAOmvtogondC45ke
         cisAlhOs5OgvuEO5zJe/JMwlEqMNUzXR4d0mamvERSOjFYwTIHydCRICxw6IyDS3pcw1
         5F9cRRUIXEhQD86MmscvNnK3PJ8KI1FOygoRLhEMLSNZYx1AZoe/GjSHjhkFELZTw4WL
         T2O93ZdSzdl0puSDkEpmy8wbyl9o8kb1Rc8JPo3XA0Iicfqlly3vrBpzBi2KFQSUEZy/
         59WtEytoXrx82pEJvfjKDpWGvMcH2McssRAseHKi2W04Z1AgHedd0vFO4zO/GMvMQ2v7
         bPeg==
X-Received: by 10.66.66.135 with SMTP id f7mr3015749pat.22.1402662048417;
        Fri, 13 Jun 2014 05:20:48 -0700 (PDT)
Received: from lanh ([115.73.228.145])
        by mx.google.com with ESMTPSA id nw13sm20691189pab.37.2014.06.13.05.20.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 05:20:47 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:20:46 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251563>

remove_marked_cache_entries() deletes entries marked with
CE_REMOVE. But if there is no such entry, do not mark the index as
"changed" because that could trigger an index update unnecessarily.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 5e8c06c..c0c2e39 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -510,6 +510,8 @@ void remove_marked_cache_entries(struct index_state=
 *istate)
 		else
 			ce_array[j++] =3D ce_array[i];
 	}
+	if (j =3D=3D istate->cache_nr)
+		return;
 	istate->cache_changed =3D 1;
 	istate->cache_nr =3D j;
 }
--=20
1.9.1.346.ga2b5940
