From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/5] worktree: make core.sparseCheckout and core.ignoreStat per-worktree
Date: Wed,  2 Dec 2015 20:13:45 +0100
Message-ID: <1449083626-20075-5-git-send-email-pclouds@gmail.com>
References: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Max Kirillov <max@max630.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 20:14:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4CrG-0003kL-CP
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 20:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933116AbbLBTOW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Dec 2015 14:14:22 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33654 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933079AbbLBTOK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 14:14:10 -0500
Received: by wmec201 with SMTP id c201so268594140wme.0
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 11:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jk84iFTC59gHHsyOV/+9ajpqIEbmvU9C5uMfw92mhOY=;
        b=w4JoN+Qln7XtzZ9JZN2ts0eEtduwsb4lhT3Nv+GnMdjD3g9GhrT4TCEN3dqleN08bK
         o1a3TT5XkFf9i5gXoT4fBAyPwV44Vrl6GOe+SsOCE1r5KNNY4BB++tBWHUsihmTOp/Ot
         L/UhcqBoWOaVYT8B8Jg3LTAxHFrHSo9bcPdqYkEA1RVTH9fFRVCjI/iHTWELKu0h+nfJ
         6we+2/mVjBRMcKB5U4hTnWS2gLofW1eWmJtvGS6VxytRIFhfVNyVM8iXQpgom6lXkMXf
         F9UeGTFSwN+tjTp5pxwLk9iPNzROmz1s0VZd84o0HWjEllamHi04RjsU5a+sRrZIiQmz
         LRvA==
X-Received: by 10.28.195.10 with SMTP id t10mr44028864wmf.11.1449083649231;
        Wed, 02 Dec 2015 11:14:09 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.internal.homenet.telecomitalia.it (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id uz5sm4090822wjc.8.2015.12.02.11.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Dec 2015 11:14:08 -0800 (PST)
X-Mailer: git-send-email 2.2.0.513.g477eb31
In-Reply-To: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281905>

The first one must be per-worktree because info/sparse-checkout
already is. The second one shares the same nature and should also be
per-worktree.

Note, because info/config.worktree uses .gitignore syntax, you can
negate a default pattern and revert it back to per-repo..

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt | 5 ++++-
 config.c                 | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 09a8b57..aff1431 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -435,7 +435,8 @@ Git will not normally detect changes to those files=
=2E
 This is useful on systems where lstat() calls are very slow, such as
 CIFS/Microsoft Windows.
 +
-False by default.
+False by default. This variable is per-worktree in multiple working
+tree setup.
=20
 core.preferSymlinkRefs::
 	Instead of the default "symref" format for HEAD
@@ -736,6 +737,8 @@ the 'GIT_NOTES_REF' environment variable.  See link=
git:git-notes[1].
 core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
++
+This variable is per-worktree in multiple working tree setup.
=20
 core.abbrev::
 	Set the length object names are abbreviated to.  If unspecified,
diff --git a/config.c b/config.c
index 54a6219..fdf38da 100644
--- a/config.c
+++ b/config.c
@@ -93,6 +93,8 @@ static long config_buf_ftell(struct config_source *co=
nf)
=20
 static const char* default_config_worktree[] =3D {
 	"core/bare",
+	"core/ignorestat",
+	"core/sparsecheckout",
 	"core/worktree"
 };
=20
--=20
2.2.0.513.g477eb31
