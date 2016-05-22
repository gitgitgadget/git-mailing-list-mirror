From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 6/6] worktree: simplify prefixing paths
Date: Sun, 22 May 2016 16:33:56 +0700
Message-ID: <20160522093356.22389-7-pclouds@gmail.com>
References: <20160510141416.GA22672@lanh>
 <20160522093356.22389-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 11:35:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4Pmn-0001Z8-KM
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 11:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbcEVJe5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2016 05:34:57 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34578 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225AbcEVJe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 05:34:56 -0400
Received: by mail-pa0-f67.google.com with SMTP id yl2so15030032pac.1
        for <git@vger.kernel.org>; Sun, 22 May 2016 02:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KdI5xFjPw8PRcXDAWqL2BIl6BylDuiBOONhOcBy3OJA=;
        b=OBeWy1Oki6sAWiySuEra1EwdfgHgpMBqFLQuhndOQHu5jTxDDdhcIaz3/nbr+bTWe5
         237NMV42MoOHpi23ivm5qlVGVMEz1blhCtZrMY63PFU4CMnPJ5vYRNwM45FS4HsERLzk
         J1GY2TWDGjihu3xy2TRP/R+tT1krkZ3ykkYnPTIaMjHc8itCH4vYwiwcYuFQ9Sdn/rzZ
         ueV5yiFh6owJzBFGvlQFzHdC78TdUgIejAEp5QHbaL32C/UREjNVGAU+4vw7B7u/k3Rb
         4zhULM7OUhRgs8k4oFSyOrYoA1EJuCk3Hi57WcUzFDEONK+Ki1d/Vd6gjswTAP4fwK16
         uyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KdI5xFjPw8PRcXDAWqL2BIl6BylDuiBOONhOcBy3OJA=;
        b=lW2yhvXKwZ0dahEZ1f6sESwhI1xdCHSxmF0HOSeWvabaNM6d6DYJ14AA7vGsW/90eT
         J5ZH3mMDnsBhvAgeDx5kZDOEjCm6GksMZpGRehq4dAsSkDjeZMJP2CxfhMxUsvNy2BFk
         EU255oItefRPkez5ug9oVNKfm4e5vQdMc3R5sp7LsKl8EyLVlwPYwsrL5DQHJ8UGsJ0+
         7H7K8jv5lXnnz9goOcGg3Z97ZEXd+ze3Kg0WJxKHgi4nsl7vIjsAFjc92dVqrBpj98hy
         sUF+oaxzEVQYyVf5nN8AIfTwHny7qZJl3emClX6u81g7egqGSk5w54jrIcP4jjan5AoE
         QX/Q==
X-Gm-Message-State: AOPr4FV9Rn8XE0kS7fQppJ1yDTePTyeHsqieXxzVcRAf9rOzaeV6Prfk7HbujDNx1t3q+g==
X-Received: by 10.66.191.100 with SMTP id gx4mr18724216pac.128.1463909695296;
        Sun, 22 May 2016 02:34:55 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id p187sm38686765pfb.3.2016.05.22.02.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 May 2016 02:34:54 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 22 May 2016 16:34:50 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160522093356.22389-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295266>

This also makes slash conversion always happen on Windows (a side effec=
t
of prefix_filename). Which is a good thing.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/worktree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index b53f802..f9dac37 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -337,7 +337,7 @@ static int add(int ac, const char **av, const char =
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
@@ -467,6 +467,8 @@ int cmd_worktree(int ac, const char **av, const cha=
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
2.8.2.524.g6ff3d78
