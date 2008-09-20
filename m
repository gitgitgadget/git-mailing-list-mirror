From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/14] checkout_entry(): CE_NO_CHECKOUT on checked out entries.
Date: Sat, 20 Sep 2008 17:01:47 +0700
Message-ID: <1221904913-25887-9-git-send-email-pclouds@gmail.com>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
 <1221904913-25887-2-git-send-email-pclouds@gmail.com>
 <1221904913-25887-3-git-send-email-pclouds@gmail.com>
 <1221904913-25887-4-git-send-email-pclouds@gmail.com>
 <1221904913-25887-5-git-send-email-pclouds@gmail.com>
 <1221904913-25887-6-git-send-email-pclouds@gmail.com>
 <1221904913-25887-7-git-send-email-pclouds@gmail.com>
 <1221904913-25887-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 20 12:04:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgzKA-0001Il-LY
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 12:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbYITKDL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Sep 2008 06:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbYITKDL
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 06:03:11 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:14530 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbYITKDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 06:03:09 -0400
Received: by rv-out-0506.google.com with SMTP id k40so808445rvb.1
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=EuSD3JKxEEDzlmN4AutMbCqIV2eHJxTtisxMVCFjz2Q=;
        b=vTHlQCtPO1qC3oO/I+FP+KZoFq3b9RsJV4OP+LPeFE/mVxbi5HGZLAq/aDRfY5x/bD
         +wvpUyd38kc79a8ck7ZPeQGwybVXpSOX8JiYsLwGdbYvs6O+h8n23cOZdz5UBPmrQZnh
         qG4bGcdy5Id0yW1aojlqs7S3wsupAiNNnnr/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=B33TIw7/kJx28eo11+M+0i9Npw+euXV+xPS3rkbgNJvmKZsXyxiLJeNiRQI74B2QVf
         1AxK5RZ78S0GzvfbJIAP5kwLrp9pDIRvKjVMxe/pSUmuFneB1SSF5yqOjJwXT2lzInPB
         pt6BsCU5tPtywtQDZ3Z243YcLh0By2Xxrq1+o=
Received: by 10.142.180.11 with SMTP id c11mr454894wff.113.1221904989235;
        Sat, 20 Sep 2008 03:03:09 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.36.54])
        by mx.google.com with ESMTPS id 30sm3576691wfa.10.2008.09.20.03.03.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Sep 2008 03:03:07 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 20 Sep 2008 17:02:58 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221904913-25887-8-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96347>

With this you can just do "git checkout some-files" to
widen your checkout. One caveat though: caller must save
the index.

=46or all of its callers (unpack_trees(), checkout-index, checkout
and apply), only "git apply" does not write index back.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 entry.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/entry.c b/entry.c
index aa2ee46..305f8d3 100644
--- a/entry.c
+++ b/entry.c
@@ -230,5 +230,6 @@ int checkout_entry(struct cache_entry *ce, const st=
ruct checkout *state, char *t
 	} else if (state->not_new)
 		return 0;
 	create_directories(path, state);
+	ce_mark_checkout(ce);
 	return write_entry(ce, path, state, 0);
 }
--=20
1.6.0.96.g2fad1.dirty
