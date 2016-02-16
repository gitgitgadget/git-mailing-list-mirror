From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 21/26] worktree: simplify prefixing paths
Date: Tue, 16 Feb 2016 20:29:22 +0700
Message-ID: <1455629367-26193-22-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
 <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:31:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfiy-0003rC-E7
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:31:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbcBPNbX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 08:31:23 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34697 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932405AbcBPNbU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 08:31:20 -0500
Received: by mail-pf0-f179.google.com with SMTP id x65so105414597pfb.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 05:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=oJDl5Lzuf6s24EqGn4H9nFwXy0k+2eb/+VXQVR1ZmUM=;
        b=Qdl1PvNvmmlKfHWlINAe0sCS4ZTGe+dEaYEr0/eshRG6xlioNdpfj6+rzdSkQuomgH
         kYn3n3Xx5Qeq9S3vKM1KAf2jvyCh54jb7QvF/1EmlBh/CI1zsF1y3g5/WgTj+Ntwtm3v
         9Lg60e5t+oyWOCYCRVc0ScNT5wyM/VrrSm/9kzsuW3rEiFTF/PnaRHmeWZJRtOrvj2wU
         C+I6Jh+SaL3SoWxh7pndhhOty92eRGx0ZSJkRXDmBKhRIepLY+WcZhK1BVpOQpdGZ3G3
         wgNtt03OXmeQFkLBIiclPr6O4WIQWPsTb8ijXW8zkAJ+bDupy1Dct25WdqZMzJ4NN+ra
         YFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=oJDl5Lzuf6s24EqGn4H9nFwXy0k+2eb/+VXQVR1ZmUM=;
        b=iFzDaVKWRhcK1RVNHVar2hdb/FNaRkzFpLPWWG2Gq/fRY5gtdL+EQTkBoGnCf1rZz6
         VdUaXQvp4ims6keIG1b0CUsi7dhDaOTnK+h+KLCBvYuMcivgGzXwmGYT6TwsudN9RXHf
         idMrL/Ork4XGACi2chbDKCSRUYP0+KCt/pLQW9J4Orkb37rm/2QbUzrROjlj6lf1xYE6
         lXWb42lNzAqPNGgIItWNpsCldOqr7S+i8HIx4AztxUgLAsFlSGSsBvKmPPhLWo2t7apt
         ZeS7e/g755sNmo2Kulw0D0WV1jFUrTffH2hNymAdSzcLho157fJ2ZWg67Ftt9piiDL4J
         alrQ==
X-Gm-Message-State: AG10YOTPEBvISIpBOLqjLDI6+Bltch+KwVqmFmYTv7nrjVa9xyuHagf8156YyhETgIsfBQ==
X-Received: by 10.98.9.219 with SMTP id 88mr31569236pfj.0.1455629480186;
        Tue, 16 Feb 2016 05:31:20 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id n78sm45981412pfb.53.2016.02.16.05.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 05:31:18 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 16 Feb 2016 20:31:41 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286388>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/worktree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 97666cc..b261e11 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -332,7 +332,7 @@ static int add(int ac, const char **av, const char =
*prefix)
 	if (ac < 1 || ac > 2)
 		usage_with_options(worktree_usage, options);
=20
-	path =3D prefix ? prefix_filename(prefix, strlen(prefix), av[0]) : av=
[0];
+	path =3D prefix_filename(prefix, strlen(prefix), av[0]);
 	branch =3D ac < 2 ? "HEAD" : av[1];
=20
 	opts.force_new_branch =3D !!new_branch_force;
@@ -453,6 +453,8 @@ int cmd_worktree(int ac, const char **av, const cha=
r *prefix)
=20
 	if (ac < 2)
 		usage_with_options(worktree_usage, options);
+	if (!prefix)
+		prefix =3D "";
 	if (!strcmp(av[1], "add"))
 		return add(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "prune"))
--=20
2.7.0.377.g4cd97dd
