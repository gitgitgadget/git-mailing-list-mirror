From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] unpack-trees: do not delete i-t-a entries in worktree even when forced
Date: Wed, 24 Feb 2016 18:45:17 +0700
Message-ID: <1456314317-30301-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 12:45:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYXsm-0007Qu-Gn
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 12:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbcBXLpY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2016 06:45:24 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35434 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbcBXLpX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 06:45:23 -0500
Received: by mail-pf0-f169.google.com with SMTP id c10so12263828pfc.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 03:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=F5W8+Ju3Siz4h+Pm5chadoUHkVTW203tNi2t4rVoKVo=;
        b=N9a2/bXncgJdKJzAfz87SSVgzdlHgrjbn0A3JaqFTjeIdVR/1W+tcWwySF/oUz54y8
         AJK+0Hx478k/K/JOKQst2+QStmEPTqTWZg7eD6xSqbhWqY+u5ev7STy4nYsvbfIgjXXl
         tLWMAA/eHeJgxTn1ptRe4j0paEMzx+Qed4ZAd0zlUYPLLPeF//o6vwsQjs16BrzHns+5
         smimLCMNlxop/pnsIvfTMlx3InJCMXEhrW4iUkTBJYcjmhRJzG3l+ubBYcz3Ll41vJ+v
         mFUgIyFNy5UoSa0Rk/WKXrqEj0gYLRlCoJEAn6yn5Bbtchw3AdmKoryFhwxNO/epYc+X
         KUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=F5W8+Ju3Siz4h+Pm5chadoUHkVTW203tNi2t4rVoKVo=;
        b=JT/kGINRivno/OyRUeeijctddqpyQOhqxuZQwSP+oc2sg7rxDu3VedqLrBGTMPa2X7
         npm16y6sL6hm1fJChJ9N/Bf4Rc4Pz+vJVxxRW2zG9lOPwTKxacHdE341tfGAZPCXZN2T
         /FrWUs868wEdbFcnIwke8go/72r8D1JbOBlOo/tpFq5Dq+ksqUZWyOSKQxt0ske9DZrs
         ex49GHoambIGs3EiOUbsphgoNYvrExGYv4aruWjW0ETnSDhuXwYCWdgSNb5kEW0Mb++D
         Z9BUQ7POVsii/UqRYhgqdyZk6TIBvo0ayK4ubW8TfTygKLoT6jb78sfWecuqby0m31hl
         zgPA==
X-Gm-Message-State: AG10YORSiGUlrhqal32TyEwcXwe821yavgDHqPq+gnCCaKXKpmGYc+2I4JMYtwzfdCXE/g==
X-Received: by 10.98.18.215 with SMTP id 84mr53831361pfs.131.1456314323227;
        Wed, 24 Feb 2016 03:45:23 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id r87sm4527547pfa.61.2016.02.24.03.45.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Feb 2016 03:45:21 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 24 Feb 2016 18:45:53 +0700
X-Mailer: git-send-email 2.7.2.531.gc9e018c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287201>

Intent-to-add entries are basically "I may want to commit these files
later, but for now they are untracked". As such, when the user does "gi=
t
reset --hard <tree>", which removes i-t-a entries from the index, i-t-a
entries in worktree should be kept as untracked.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Lost two files today, luckily I had a backup.

 t/t2203-add-intent.sh | 15 +++++++++++++++
 unpack-trees.c        |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 2a4a749..63086bf 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -82,5 +82,20 @@ test_expect_success 'cache-tree invalidates i-t-a pa=
ths' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'reset --hard leaves on-disk ita entries alone' '
+	git init keep-ita &&
+	(
+	cd keep-ita &&
+	echo abc >abc &&
+	echo def >def &&
+	git add abc &&
+	git commit -m abc &&
+	git add -N def &&
+	git reset --hard HEAD &&
+	echo def >expected &&
+	test_cmp expected def
+	)
+'
+
 test_done
=20
diff --git a/unpack-trees.c b/unpack-trees.c
index 9f55cc2..1a2271b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -104,7 +104,7 @@ static int do_add_entry(struct unpack_trees_options=
 *o, struct cache_entry *ce,
 {
 	clear |=3D CE_HASHED;
=20
-	if (set & CE_REMOVE)
+	if ((set & CE_REMOVE) && !ce_intent_to_add(ce))
 		set |=3D CE_WT_REMOVE;
=20
 	ce->ce_flags =3D (ce->ce_flags & ~clear) | set;
--=20
2.7.2.531.gc9e018c
