From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 08/12] worktree.c: avoid referencing to worktrees[i] multiple times
Date: Wed, 20 Apr 2016 20:24:49 +0700
Message-ID: <1461158693-21289-9-git-send-email-pclouds@gmail.com>
References: <1460897965-486-1-git-send-email-pclouds@gmail.com>
 <1461158693-21289-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 15:26:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ass9M-00054I-2j
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 15:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678AbcDTN0c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 09:26:32 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36413 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908AbcDTN0b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 09:26:31 -0400
Received: by mail-pf0-f173.google.com with SMTP id e128so18321786pfe.3
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 06:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NcpvSpvnwGhEzm2sWll9DeII5/OW1+WQ0NeCmdnRatg=;
        b=wBWA0M0S11RivP73BPxeFY5Pr5usTMTn68dOqk6Y+QMbL8NeI7SVFe0sWUU/jFrMrX
         5qy0me8dUHnnpbIfNMBRu5yjhC/vfo3jBgR8WtwSzLd7W7NgZomw9GJOEYKzs6S9BgHO
         qgDbpG7bFZxB/np0f1EKlRk9nN1jWknClCyAz2/8vBU+ZhA8mgtR4I1K1H2Fski/8Dqc
         9XwBrXu8JU3spk/kcAKHR9EVBNYSuoh9laKqCuLf44Ym4XnT/c8l4bzkxI9rlDpL/nVl
         2lrevbBNsFSszyxUc/g26duwepu2gaQVIno3I9vjg+0dfCq/Doj1JaPQfR2C7uWFwGer
         CsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NcpvSpvnwGhEzm2sWll9DeII5/OW1+WQ0NeCmdnRatg=;
        b=fvaZ/ZqaY7yMZZlHzs3EBOhGJ8f+jadhDtbGNVgLtnNjNOlbLWIbhRSN7I1IsL88Ix
         n5cBRwZCEnVPQ3pUKwkfROuX8mQejG9BJdeiw1EEOUv4GgW2hwx2dU9SeXrZjISBFHei
         KyPv13/5gJK8dngfEMeEDE40/HbQ8Ha2RbnjiOZhoIg+NF+fQa4vUwbzgru5CMRPfjCo
         bage2iOMrlHIdrY5rGOqFDMeJWN1WvYYnI3dj+KnqgXTlkGooiLr8kJeRvVCg7n0Mg0z
         iAbTs5Y5UEBpAs/Pk958Jzpjt7GOiY63URgVwdltRID+Z7iMrhDmT9Kj0Au1T12pNvty
         1B+A==
X-Gm-Message-State: AOPr4FUyBdvpfmg3uBxB3rl9KpCdvJdi71qWsDP7aqz2gpvGWmPcAmWzeTNSPo9pajQSqg==
X-Received: by 10.98.68.86 with SMTP id r83mr12142303pfa.137.1461158790642;
        Wed, 20 Apr 2016 06:26:30 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id ut1sm31038576pac.46.2016.04.20.06.26.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Apr 2016 06:26:29 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Apr 2016 20:26:42 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292018>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/worktree.c b/worktree.c
index 452f64a..b5ca78f 100644
--- a/worktree.c
+++ b/worktree.c
@@ -221,10 +221,12 @@ const struct worktree *find_shared_symref(const c=
har *symref,
 	worktrees =3D get_worktrees();
=20
 	for (i =3D 0; worktrees[i]; i++) {
+		struct worktree *wt =3D worktrees[i];
+
 		strbuf_reset(&path);
 		strbuf_reset(&sb);
 		strbuf_addf(&path, "%s/%s",
-			    get_worktree_git_dir(worktrees[i]),
+			    get_worktree_git_dir(wt),
 			    symref);
=20
 		if (parse_ref(path.buf, &sb, NULL)) {
@@ -232,7 +234,7 @@ const struct worktree *find_shared_symref(const cha=
r *symref,
 		}
=20
 		if (!strcmp(sb.buf, target)) {
-			existing =3D worktrees[i];
+			existing =3D wt;
 			break;
 		}
 	}
--=20
2.8.0.rc0.210.gd302cd2
