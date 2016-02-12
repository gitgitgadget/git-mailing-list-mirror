From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] rev-parse: take prefix into account in --git-common-dir
Date: Fri, 12 Feb 2016 11:31:45 +0700
Message-ID: <1455251505-20685-1-git-send-email-pclouds@gmail.com>
References: <20160212034723.GA20739@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mh@glandium.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 05:31:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aU5OV-0006Ya-TZ
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 05:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbcBLEbo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2016 23:31:44 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34876 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbcBLEbl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 23:31:41 -0500
Received: by mail-pf0-f177.google.com with SMTP id c10so41584571pfc.2
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 20:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kPvpdnHiWAWuyrfw51mehGXpeGCtjTj9zW+H0UM2BxI=;
        b=VfILZaEamm0XxPZQMW+EGhxGFkyEXS61r4cmBWHT+FzrHXtZm037Ah2kAInDE4G3Dy
         PUJ3FE69wsKPoLtekBfDfYtDYrY0dwDjdxCqoC6cN/Qg0Nrvp987USuXSwxmQq37sKPd
         OHYQL3yyRUk/MtE18+65eizKlAgK1zpmQbruJDkYN5KwP/mLiT/KpxHI3VlQ/5qRLDN4
         HY3lvHqIO9u/DH4GWAqx+zHop/L62+lracgT06ywTcA3ftYy0uUWIpE+06AdFfeRBgS2
         qeJweZhz4Qk9QQvNpIrRsmVTfnAm9B829XEo92UDyQklPt9oXseuYK83Yc3w7rsMBQ3L
         cR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=kPvpdnHiWAWuyrfw51mehGXpeGCtjTj9zW+H0UM2BxI=;
        b=aBm1V3eUYZRiltYqb5Gk607XjAc6/4B5YpuXVwijaa0bRK0JzuxnAwiHvuAorU9IqE
         dTvSwNguQeSAu4UbN1Ap+AP0irjXn2tPM1FMMcB3UFVRL/ESUBNU9JgnjHn0KyduSEzQ
         MwmZytkN79kbMvEiYj3cY+YKYax9TxlrslSkmgywuSd7Wx2+N+wAw9RL6W6PrZmi1fis
         72yblr/SN3lFpgwvMkOf12zs0wFbQk7VHMdEeSG9qtZAfk9uXCDGiYEdSiyiDQuYEyh3
         dOxSXuR2brhApLn3wfsh+DJtLzbH6yeyZK7IBFOf+2PrHgXVTeJa9C6gYicF88Iw+b1I
         M27Q==
X-Gm-Message-State: AG10YORBm8seBqtvlD+qT2s9iaitzTBkG5cd6uXnAQTmU46a0b5SGIyqWYq75eCG//YTTg==
X-Received: by 10.98.70.139 with SMTP id o11mr71857622pfi.123.1455251501085;
        Thu, 11 Feb 2016 20:31:41 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id 195sm15646852pfa.5.2016.02.11.20.31.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Feb 2016 20:31:39 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 12 Feb 2016 11:32:00 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <20160212034723.GA20739@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286038>

Most of the time, get_git_common_dir() returns an absolute path so
prefix is irrelevant. If it returns a relative path (e.g. from the
main worktree) then prefixing is required.

Noticed-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Fri, Feb 12, 2016 at 10:47 AM, Mike Hommey <mh@glandium.org> wrote:
 > Hi,
 >
 > In a worktree, git rev-parse --git-common-dir returns the non
 > worktree-specific git directory. e.g. .git instead of
 > .git/worktrees/name. The problem is that while it returns the right
 > thing from a subdirectory of a worktree, it doesn't from a subdirect=
ory
 > of the "main" work tree. In the latter case it returns ".git" instea=
d
 > of the full path to it.
=20
 Oops. Fixed.

 builtin/rev-parse.c      |  3 ++-
 t/t2027-worktree-list.sh | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index bd16876..cf8487b 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -763,7 +763,8 @@ int cmd_rev_parse(int argc, const char **argv, cons=
t char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--git-common-dir")) {
-				puts(get_git_common_dir());
+				const char *pfx =3D prefix ? prefix : "";
+				puts(prefix_filename(pfx, strlen(pfx), get_git_common_dir()));
 				continue;
 			}
 			if (!strcmp(arg, "--resolve-git-dir")) {
diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
index 75ebb1b..1b1b65a 100755
--- a/t/t2027-worktree-list.sh
+++ b/t/t2027-worktree-list.sh
@@ -8,6 +8,16 @@ test_expect_success 'setup' '
 	test_commit init
 '
=20
+test_expect_success 'rev-parse --git-common-dir on main worktree' '
+	git rev-parse --git-common-dir >actual &&
+	echo .git >expected &&
+	test_cmp expected actual &&
+	mkdir sub &&
+	git -C sub rev-parse --git-common-dir >actual2 &&
+	echo sub/.git >expected2 &&
+	test_cmp expected2 actual2
+'
+
 test_expect_success '"list" all worktrees from main' '
 	echo "$(git rev-parse --show-toplevel) $(git rev-parse --short HEAD) =
[$(git symbolic-ref --short HEAD)]" >expect &&
 	test_when_finished "rm -rf here && git worktree prune" &&
--=20
2.7.0.377.g4cd97dd
