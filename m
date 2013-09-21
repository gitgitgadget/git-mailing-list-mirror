From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/17] fixup! index-pack: support completing thin packs v4
Date: Sat, 21 Sep 2013 20:57:51 +0700
Message-ID: <1379771883-10278-6-git-send-email-pclouds@gmail.com>
References: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 21 15:55:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNNeb-0000GP-Rk
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 15:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359Ab3IUNzO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Sep 2013 09:55:14 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:52428 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285Ab3IUNzL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 09:55:11 -0400
Received: by mail-pb0-f50.google.com with SMTP id uo5so1479076pbc.9
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 06:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=94E/khY5eDXcAgrfqcvn7+3SJbvYSnomLYbA0DjYK2M=;
        b=RTBM7I8rSYqL289PfmIzp/f3k+QPyWy68zdBSfo8jcudXy5dD7w8HDjnrPZZw5rzdf
         FZFBIVts586+GekFTK/lD/N0FQLTOwsILry1+2oHlmNdtWL2PXagg/R1lH9oFe77c3zE
         /jTPPfHgMQChsTMK24czahdzKsQhAnUkwHO/bGorzu8sEp6J3hyTDkJtUfEq5ou3Yctv
         b46Me3RL3Zv3ERiElTpABkbETpYPh8bN7RE1hGxX0QFtjImUbIDLMM8xcFh1OKTlrz11
         CdJqcC4UZK/gpXwRbJfRG1CQEd9k+E67Z695bmLVH0eFcb7pPUNYUlrOMb11NOPtmi2S
         BsMQ==
X-Received: by 10.66.157.165 with SMTP id wn5mr857731pab.169.1379771710951;
        Sat, 21 Sep 2013 06:55:10 -0700 (PDT)
Received: from lanh ([115.73.252.65])
        by mx.google.com with ESMTPSA id gg10sm22123388pbc.46.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 06:55:10 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 21 Sep 2013 20:58:33 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235105>

!is_delta_tree() is not correct because the tree may have been
resolved in by find_unresolved_deltas() in the previous iteration of
this loop. Check for entry->idx.sha1 instead, that must be non-null
when we resolve the object.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index fbf97f0..db885b1 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1783,7 +1783,7 @@ static void fix_unresolved_deltas(struct sha1file=
 *f, int nr_unresolved)
 		enum object_type type;
 		struct base_data *base_obj =3D alloc_base_data();
=20
-		if (obj->real_type !=3D OBJ_REF_DELTA && !is_delta_tree(obj))
+		if (!is_null_sha1(obj->idx.sha1))
 			continue;
 		base_obj->data =3D read_sha1_file(d->base.sha1, &type, &base_obj->si=
ze);
 		if (!base_obj->data)
--=20
1.8.2.83.gc99314b
