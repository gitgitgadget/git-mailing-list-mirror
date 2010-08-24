From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/32] cache-tree: ignore CE_REMOVE entries in verify_cache()
Date: Wed, 25 Aug 2010 08:19:53 +1000
Message-ID: <1282688422-7738-4-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:22:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1st-0001Xh-8O
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306Ab0HXWVT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:21:19 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43052 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932305Ab0HXWVR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:21:17 -0400
Received: by pwi7 with SMTP id 7so50255pwi.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=fk6ZiB7vjBeckQPmVak0olgB5tY7gWJZIOc4/ABNsRI=;
        b=L0x+qTqMcdFzoAjiHgkXtUgGcW62Aqjj+GkUaHDoj+zYJD5HT31djx1k4esbK2crXl
         vdFGsiFRFUc4SnrdnQlGzd6ac2X+H+vI0vj4nZZqZTrYGYVJVdU1zZEGaQzbJJ9hiOYu
         009HD+qEwkFVQm7hrCJKcPjGgadyI7YOwPCwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=GWO/1dJF1OapdQDXvZSbZ1NlzcBQ4eaiMLreh0tUY/JqpEH4lqEpqdeoQ+jCZdP5/M
         5OheccTd/v+hYWJwRRmO5wUrS3NFOmrRZeV2Q8xLgYQ5095h5o+3lUJGgl2t36Rvuusq
         YHQpgi9oAZi+LkpsqInDtRCvEBsxeEr/H2+EE=
Received: by 10.114.38.6 with SMTP id l6mr8494355wal.47.1282688476532;
        Tue, 24 Aug 2010 15:21:16 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id q6sm937952waj.22.2010.08.24.15.21.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:21:14 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:21:08 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154344>

Those entries are not to be written out. MAY HAVE NEGATIVE IMPACT!!

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache-tree.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 7fd7203..03952c7 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -156,6 +156,8 @@ static int verify_cache(struct cache_entry **cache,
 	funny =3D 0;
 	for (i =3D 0; i < entries; i++) {
 		struct cache_entry *ce =3D cache[i];
+		if (ce->ce_flags & CE_REMOVE)
+			continue;
 		if (ce_stage(ce) || (ce->ce_flags & CE_INTENT_TO_ADD)) {
 			if (10 < ++funny) {
 				fprintf(stderr, "...\n");
--=20
1.7.1.rc1.69.g24c2f7
