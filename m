From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/4] revert: convert resolve_ref() to read_ref_full()
Date: Mon, 12 Dec 2011 18:20:29 +0700
Message-ID: <1323688832-32016-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 12 12:22:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra3xL-0000Hs-OH
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 12:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562Ab1LLLV7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Dec 2011 06:21:59 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51305 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab1LLLV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 06:21:58 -0500
Received: by ggdk6 with SMTP id k6so949489ggd.19
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 03:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=UhRVMmwIoTTcyRzJ4uYrWQ8AwAjGCkxnAuLywynDGiw=;
        b=wFT4rIzyChKW3kORPo2/R0ujQyDlGclPCQiX5HlzTtd1eZ7MVrPQ3tPfFehrzSTOMT
         g+AUAPQO90FFQ6d5YVUdJP8yMq+55q8CldxWHzgSrGg09mvfrNjZCTDWVMLKPK9LlHHU
         9DvTWq3i2s+oNQ4AlsXFEE6AdFvi+5Ae0/CNg=
Received: by 10.50.77.137 with SMTP id s9mr14440360igw.66.1323688917292;
        Mon, 12 Dec 2011 03:21:57 -0800 (PST)
Received: from tre ([115.74.36.175])
        by mx.google.com with ESMTPS id wo4sm40130486igc.5.2011.12.12.03.21.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Dec 2011 03:21:55 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Mon, 12 Dec 2011 18:20:32 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186905>

This is the follow up of c689332 (Convert many resolve_ref() calls to
read_ref*() and ref_exists() - 2011-11-13). See the said commit for
rationale.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/revert.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 1ea525c..0c52a83 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -901,7 +901,7 @@ static int rollback_single_pick(void)
 	if (!file_exists(git_path("CHERRY_PICK_HEAD")) &&
 	    !file_exists(git_path("REVERT_HEAD")))
 		return error(_("no cherry-pick or revert in progress"));
-	if (!resolve_ref("HEAD", head_sha1, 0, NULL))
+	if (read_ref_full("HEAD", head_sha1, 0, NULL))
 		return error(_("cannot resolve HEAD"));
 	if (is_null_sha1(head_sha1))
 		return error(_("cannot abort from a branch yet to be born"));
--=20
1.7.8.36.g69ee2
