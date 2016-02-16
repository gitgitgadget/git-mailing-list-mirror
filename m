From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 12/26] worktree.c: use is_dot_or_dotdot()
Date: Tue, 16 Feb 2016 20:29:13 +0700
Message-ID: <1455629367-26193-13-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
 <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:32:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfjp-0004ZA-9M
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbcBPNcS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 08:32:18 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35085 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932338AbcBPNa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 08:30:26 -0500
Received: by mail-pa0-f43.google.com with SMTP id ho8so104955887pac.2
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 05:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=OiyKBnlkx9GEocPHfWARDHz6PyyQ4nndBskOg2rh14Y=;
        b=BD+QCQwwrt18My9DL/oTNvRAGXzGwILwtECRjSTAVkFkVFZzqvHpAqurJ7e1xLoIge
         TQ+A0A1TWRRSl9ZrVbAw/XwYfwCxOnkTOtHgYiC9vKO1A96rXxXMFwRNGhGHbWzvkp8Q
         uL4SghwROvZ/J6mtmK1byphvUqrss54nqQ/0zHWOI0NlMniECEsKrrfnIn3oEJG1sVd3
         42gNpRW4ENcnb0Omy2YniqkI60Xd67xyktl86aQUvh3maD9o8ZtiYHuxiBW6JcEPvu7T
         t8bJYILcTBaBoosBLEyUEKWGAFVbFOaW6DizveTMUdtx8ZE+cx69ulQoAsrrcf0zzYef
         CDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=OiyKBnlkx9GEocPHfWARDHz6PyyQ4nndBskOg2rh14Y=;
        b=MqEvAX2B1WBZkcRZDcAq/+O8NUPThBbGhC+as+G7ZoREDE1wdcGZ7l9VYVapffUi0c
         TQ0GEYHVnszaan+/pB0kmxmeLZtTRaRnkSff6ZSRSGWhQpHrsZ5vg1KqlerZGY4ts3d9
         d3kzVszVcsfqb7V1YxWiHM7Jcy1i1wX8X7N7N2ylagVRKtS1IM9Px8zQvHnstreOAlGq
         Rr8weQv78FvI1USx5HvPOuFXw8orxGqA2cp8uQq3Lu6lY8I5ZnveMHVfp6wsTlaTG+Oo
         Lmtor8CJPiUx1jkfnQgwJ8QY0JQIQXf1ZRMDQtsBYbl28Uw35YkTfaOWPTkSjnqT9lKR
         MhUA==
X-Gm-Message-State: AG10YOTohLDzoglyf1yd4DP75S0VFsK1gsXguB0bbC72FrAjCBHYXJrSphDSiJoWY7yGew==
X-Received: by 10.67.6.72 with SMTP id cs8mr30342940pad.138.1455629426152;
        Tue, 16 Feb 2016 05:30:26 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id z5sm46086756pas.29.2016.02.16.05.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 05:30:24 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 16 Feb 2016 20:30:48 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286400>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/worktree.c | 2 +-
 worktree.c         | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 68341e4..cfc848d 100644
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
