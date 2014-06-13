From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/32] read-cache: mark new entries for split index
Date: Fri, 13 Jun 2014 19:19:37 +0700
Message-ID: <1402661991-14977-19-git-send-email-pclouds@gmail.com>
References: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 14:21:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQUX-0003xQ-WD
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454AbaFMMVx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 08:21:53 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:62629 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbaFMMVw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:21:52 -0400
Received: by mail-pa0-f47.google.com with SMTP id fa1so2107846pad.34
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 05:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6/VDGsHCp/C4XPZpzzTBaR9g5bi5xDF8txbSiM6B4WU=;
        b=cspZJmwnk5nSPg2vB4xXXmf+reoS9fFmMj3gSFV3wxrUEY2Xby9a0uW/m7XkxjF73J
         u7h+OWZiClxSusTKecW7pauvG+RQCWIiEeh0yyySFb8zI+XZiNNy2AEL0c4qLiPwuHDD
         U/jbnKErki+Bu1xGR+8VXw0ZM4DU3E9A8xsruGraz0XfK+whECoV9qO26oyfyy1tTrbf
         /BvB0D8KLkWLHs7LhNjIaH1C0q3eYIe41B6wodH4M6H4WHiGe91BRJjjG277COydTL+c
         dND22gEo4DvOvLr4DUyiSvXVnCfx2xNCPAdPnZAYGbDyhTi0it7vLkHzzq43iyOnPlM5
         LbxQ==
X-Received: by 10.66.66.199 with SMTP id h7mr3045963pat.30.1402662112160;
        Fri, 13 Jun 2014 05:21:52 -0700 (PDT)
Received: from lanh ([115.73.228.145])
        by mx.google.com with ESMTPSA id vf9sm3376301pbc.94.2014.06.13.05.21.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 05:21:51 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:21:52 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251574>

Make sure entry addition does not lead to unifying the index. We don't
need to explicitly keep track of new entries. If ce->index is zero,
they're new. Otherwise it's unlikely that they are new, but we'll do a
thorough check later at writing time.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 90a3f09..52a27b3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -38,7 +38,8 @@ static struct cache_entry *refresh_cache_entry(struct=
 cache_entry *ce,
 #define CACHE_EXT_LINK 0x6c696e6b	  /* "link" */
=20
 /* changes that can be kept in $GIT_DIR/index (basically all extension=
s) */
-#define EXTMASK (RESOLVE_UNDO_CHANGED | CACHE_TREE_CHANGED)
+#define EXTMASK (RESOLVE_UNDO_CHANGED | CACHE_TREE_CHANGED | \
+		 CE_ENTRY_ADDED)
=20
 struct index_state the_index;
 static const char *alternate_index_output;
--=20
1.9.1.346.ga2b5940
