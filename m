From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/20] worktree.c: use is_dot_or_dotdot()
Date: Wed,  3 Feb 2016 16:35:36 +0700
Message-ID: <1454492150-10628-7-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 10:36:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQtrk-0005Vw-QV
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 10:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbcBCJga convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2016 04:36:30 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35760 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104AbcBCJg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 04:36:27 -0500
Received: by mail-pa0-f50.google.com with SMTP id ho8so10752966pac.2
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 01:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=b1rAd4PVXzH+FYmiXfLftReP+MReFPat5ZGDbqCmOXo=;
        b=wYjaOFRSKuDnFJEuFbk8rsx8OUauwrq+/wzs6hK0tfH8DIZAXr80m1qCLIZhr8B69V
         LpP1GuWnHppqDh4+yFPoE/89y06cfMMpznrnTxlCpRDq6iWLM7Etg7nnaWltkMVWKyKZ
         4vSH4Yf9/DZdXszOpOnRWbJx9/Yk8FIl/sqfqhzxHFvm1gGfJoc6AOtNhb+UaEahGrJZ
         dmvj/WfbYmuC60P8X1F6jM4n8h5zLRwslaODVzde63C+0KCqeu2uxdW0eLuIYsZFmcQr
         BoQC8Ughs+M3oXBvQqTgV4Kgr1JZwqYrSWJfQipouYQE4eobYiszxmlZlYk3yuoysj1g
         4yXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=b1rAd4PVXzH+FYmiXfLftReP+MReFPat5ZGDbqCmOXo=;
        b=WV6SMhMJLVeQ7MJiNo1dSnuYFoXpBQSSfDVtzWe9aGrZLIsuKEoqsfuEx3QORVYQSF
         oQrWJWhX9KtPZeViKI86FFprWnZBOABoue6hV8/OtH01mlCnlMRt+S7Wko7FZwgj0/bk
         n6bqjPndVKZuyQXmfzckHBRIQWS9UpOfvBR4fQUJwXNgDPbTva1KlWVz3jqvgLeVNa6M
         qbPu5GJuOftvFr3youHePlzf/juXwLJBDw3n+nX0noJu/St++Wpf+vV8fAkCfAJwYL/K
         rS/NrkRmmJmZIi5wN+7JN+cqVuOq6gMa9oxjK1Qf0C6cfmc8ODZrfXN2rBgi8NNNkddf
         8geA==
X-Gm-Message-State: AG10YOTYUbfhb7dPppS6P0UWwFQBHTyyQEbQSVSWRZ+Vb1w0DfQeqatyBM5lj8Eslz1pkA==
X-Received: by 10.66.142.168 with SMTP id rx8mr763090pab.16.1454492187336;
        Wed, 03 Feb 2016 01:36:27 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id a21sm8400736pfj.40.2016.02.03.01.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 01:36:25 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 03 Feb 2016 16:36:38 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285352>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/worktree.c | 2 +-
 worktree.c         | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 475b958..7b217fb 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -94,7 +94,7 @@ static void prune_worktrees(void)
 	if (!dir)
 		return;
 	while ((d =3D readdir(dir)) !=3D NULL) {
-		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+		if (is_dot_or_dotdot(d->d_name))
 			continue;
 		strbuf_reset(&reason);
 		if (!prune_worktree(d->d_name, &reason))
diff --git a/worktree.c b/worktree.c
index 6181a66..ddb8cb7 100644
--- a/worktree.c
+++ b/worktree.c
@@ -2,6 +2,7 @@
 #include "refs.h"
 #include "strbuf.h"
 #include "worktree.h"
+#include "dir.h"
=20
 void free_worktrees(struct worktree **worktrees)
 {
@@ -173,7 +174,7 @@ struct worktree **get_worktrees(void)
 	if (dir) {
 		while ((d =3D readdir(dir)) !=3D NULL) {
 			struct worktree *linked =3D NULL;
-			if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+			if (is_dot_or_dotdot(d->d_name))
 				continue;
=20
 			if ((linked =3D get_linked_worktree(d->d_name))) {
--=20
2.7.0.377.g4cd97dd
