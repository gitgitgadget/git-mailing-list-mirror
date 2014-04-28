From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/32] read-cache: mark new entries for split index
Date: Mon, 28 Apr 2014 17:55:39 +0700
Message-ID: <1398682553-11634-19-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:58:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejGC-0004zM-Fn
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbaD1K56 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:57:58 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:63832 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755239AbaD1K4L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:56:11 -0400
Received: by mail-pb0-f52.google.com with SMTP id rp16so1850820pbb.25
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=b9yjlRXCD9WRYL0nwkT3vDQdZpDAR+VvYd+0JN1/wr4=;
        b=Ph3tJW3X53R0Aq2TFt7/Zbyw63U6mYVJ1E7op0xeeFUUHNnG7VVK5hvnRFTanR0pKo
         Bj0NmMAc3Zm6tTtLnZKJzm/EAEbctRYcZIqdeUOi1ZFPEkboAXCPHelFj3BV7SHUfinG
         KTZZqcyatA8bOW/+leoYwoom4xAMWj8YXRJn/pczR1cZm3EL8aVUTccZMNEsBRDHx5IS
         63MS1ZLDbdYH3Z8HVxzxx4gNaycTalN0ut/tAuXWr2SKnqRin0cU8MoBxvQWMvQzHm0l
         o7blhVaqVFvq19GKUf53Du5YUuFUGWDZF6YMxyK6Mbm4p7u1WrcdQtTXea2bHpssCueb
         nydA==
X-Received: by 10.66.142.73 with SMTP id ru9mr24668086pab.41.1398682569414;
        Mon, 28 Apr 2014 03:56:09 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id gj9sm34247317pbc.7.2014.04.28.03.56.06
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:56:08 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:57:37 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247299>

Make sure entry addition does not lead to unifying the index. We don't
need to explicitly keep track of new entries. If ce->index is zero,
they're new. Otherwise it's unlikely that they are new, but we'll do a
through check later at writing time.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index ff889ad..2f2e0c1 100644
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
