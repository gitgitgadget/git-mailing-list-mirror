From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/7] worktree.c: use is_dot_or_dotdot()
Date: Tue, 10 May 2016 21:15:50 +0700
Message-ID: <20160510141553.22967-4-pclouds@gmail.com>
References: <20160510141416.GA22672@lanh>
 <20160510141553.22967-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 16:16:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b08Sp-0007js-CI
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 16:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbcEJOQj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 10:16:39 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35645 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbcEJOQi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 10:16:38 -0400
Received: by mail-pa0-f65.google.com with SMTP id zy2so1176483pac.2
        for <git@vger.kernel.org>; Tue, 10 May 2016 07:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5kLTEGrQTc3gg7qfUyUKHBvOU+G0NwCzjRl4bNUJgAM=;
        b=lwASt35DZ+0+1gT6fZauVdzfNQr6IadwJWw6zeP/Bca4QeXODwAeoCj6OFdnEudvX0
         NlPcwhy91ten4j3NQVfKu3lJludvdnga2ID8k9xFjrCm01NZjGm2IXCwh2yBhuWFzLMt
         6hUsOksB36HqZSGrdEs6S4huIlaHe6+xtLsua3c+Cimsd3IHHCpuiWP+C7b5eVFbJc9S
         hnTwOM1WcJEjzhuDNLxb68jH0NREGdG9h/51V2jv8onY9lJHfTreExWf3rkELAHSJmtg
         86m+EY6LmoKw0WURh2ibDR+xDU43rUYjEE6T/oLvmTIasgz0EDqY/FSzMIyVGvT+o9zW
         8LEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5kLTEGrQTc3gg7qfUyUKHBvOU+G0NwCzjRl4bNUJgAM=;
        b=W8f7vwtNtD8nwshU2bUqxcjQi+cFkcwvAuQ1T03rFKlWFvmoUfcQSU9TIxuok5njFd
         ofFzsyZ7sC+DCpLs0ktjMCAYxKzpD/CUQBTdqNP9xAFpfgIxsDnXaVOZ+CzVIc8ITrdQ
         Vt52LyrO9tMo1jYc7vRTDN5k5l2CIZLfltL/jBKsmj0lhRf3ZQw5vuUtE01r2ub1Zecw
         LUGuSOQRFW+tT4suTXMnx+DgF86MdB8aHfQq1UvHiCYmhYZvHfKOHY/LNG0+OSedzMps
         MTA56u9ivRz3wzlbnmtoPqIAp2BguMnF3mTZTkgQrIJcLs/m+yXzBTaLJd9TCy5hqnPF
         QJ3A==
X-Gm-Message-State: AOPr4FVdB/lv3wsmDwrOmITyqIzlxq5zpQYqkKKhaLpNu1s3IAPmTGQzieqV6ce4srJjrQ==
X-Received: by 10.66.89.228 with SMTP id br4mr58372061pab.110.1462889797841;
        Tue, 10 May 2016 07:16:37 -0700 (PDT)
Received: from lanh ([115.76.164.133])
        by smtp.gmail.com with ESMTPSA id e7sm4995683pfa.28.2016.05.10.07.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2016 07:16:36 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 10 May 2016 21:16:39 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160510141553.22967-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294139>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/worktree.c | 2 +-
 worktree.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index bf80111..aaee0e2 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -95,7 +95,7 @@ static void prune_worktrees(void)
 	if (!dir)
 		return;
 	while ((d =3D readdir(dir)) !=3D NULL) {
-		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+		if (is_dot_or_dotdot(d->d_name))
 			continue;
 		strbuf_reset(&reason);
 		if (!prune_worktree(d->d_name, &reason))
diff --git a/worktree.c b/worktree.c
index 6a11611..f4a4f38 100644
--- a/worktree.c
+++ b/worktree.c
@@ -187,7 +187,7 @@ struct worktree **get_worktrees(void)
 	if (dir) {
 		while ((d =3D readdir(dir)) !=3D NULL) {
 			struct worktree *linked =3D NULL;
-			if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+			if (is_dot_or_dotdot(d->d_name))
 				continue;
=20
 			if ((linked =3D get_linked_worktree(d->d_name))) {
--=20
2.8.2.524.g6ff3d78
