From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/18] check-ref-format: use RUN_SETUP_GENTLY
Date: Sun,  7 Mar 2010 11:55:59 +0700
Message-ID: <1267937767-12504-11-git-send-email-pclouds@gmail.com>
References: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 06:00:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No8bL-0002Hr-Az
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 06:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759Ab0CGFAK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 00:00:10 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49858 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702Ab0CGFAH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 00:00:07 -0500
Received: by mail-pw0-f46.google.com with SMTP id 8so3156711pwj.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 21:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=c257rWpd/S+PWrHh7FID1JwNtSJQEAwwg3rni5+gb/g=;
        b=jAboJdCNttCB7aaCbTcxb3l8yp/5cJ2/dN39fOF3Lht0xd838Z3vezpVXYBMPj+vS3
         0oWPWjAuu8hz7j0qyuyQBpteOktQV21rVImEOhcpXmI6gUcOxGbpGc9E2cgz3cB2Cr1N
         xf3jdwdVQO2VqLTrphRygAFZDLludXXUOtV/w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=b9bOqkCtbxSBBxqyS2KTW+WKhDSkNyO7WnZSn8KvnitTwPvg+4yR6ASgWxlk4I/YO1
         v0dztKAaS9qN+dt456wkFr7rbjUNs3dxX7uXpxZl7PNa8RHK5k4eR0tli65jAUvhW26g
         tk+y8FXibj6PXibEw6NnurkxcjnNv10ohGBqc=
Received: by 10.141.187.29 with SMTP id o29mr2016609rvp.48.1267938006471;
        Sat, 06 Mar 2010 21:00:06 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 23sm3275259pzk.2.2010.03.06.21.00.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 21:00:05 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 11:56:51 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141654>

When --branch is used, check-ref-format will look into repository for
branch name. Therefore repository search is needed.

The call flow is:
 - cmd_check_ref_format
 - strbuf_check_branch_ref
 - strbuf_branchname
 - interpret_branch_name
 - branch_get
 - read_config
 - resolve_ref

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 326f7c7..a8660f4 100644
--- a/git.c
+++ b/git.c
@@ -304,7 +304,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
 		{ "checkout-index", cmd_checkout_index,
 			RUN_SETUP | NEED_WORK_TREE},
-		{ "check-ref-format", cmd_check_ref_format },
+		{ "check-ref-format", cmd_check_ref_format, RUN_SETUP_GENTLY },
 		{ "check-attr", cmd_check_attr, RUN_SETUP },
 		{ "cherry", cmd_cherry, RUN_SETUP },
 		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
--=20
1.7.0.195.g637a2
