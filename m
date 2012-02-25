From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH] pack-objects: Fix compilation with NO_PTHREDS
Date: Sat, 25 Feb 2012 09:16:09 +0100
Message-ID: <1330157769-7884-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 25 09:16:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1Cnv-00035y-VZ
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 09:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755389Ab2BYIQ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Feb 2012 03:16:26 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:53080 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755345Ab2BYIQW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 03:16:22 -0500
Received: by eekc4 with SMTP id c4so1237268eek.19
        for <git@vger.kernel.org>; Sat, 25 Feb 2012 00:16:21 -0800 (PST)
Received-SPF: pass (google.com: domain of michal.kiedrowicz@gmail.com designates 10.213.25.215 as permitted sender) client-ip=10.213.25.215;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of michal.kiedrowicz@gmail.com designates 10.213.25.215 as permitted sender) smtp.mail=michal.kiedrowicz@gmail.com; dkim=pass header.i=michal.kiedrowicz@gmail.com
Received: from mr.google.com ([10.213.25.215])
        by 10.213.25.215 with SMTP id a23mr1701288ebc.60.1330157781465 (num_hops = 1);
        Sat, 25 Feb 2012 00:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=NT4WyjU0jz3qn58vdzcMLSeDVZ1EiyvErNI6SCLcT/0=;
        b=otCIToe+l0/BTNvLm5Vpzs7d1520TvcqSxM9/jbnbikpMQwk5cAJFET2F8sV94ODHa
         DymZFKyEJgfzDeyAMAw5LjJsoBQnEdKTH+tFO+aWy9r1/bNBfMOQosmHBeNeFm5Q6uHN
         aAYvrD8Yld8BVOtwj9fMTzoupWBSkUFUfSJnc=
Received: by 10.213.25.215 with SMTP id a23mr1292854ebc.60.1330157781328;
        Sat, 25 Feb 2012 00:16:21 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id n17sm28416983eei.3.2012.02.25.00.16.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 25 Feb 2012 00:16:20 -0800 (PST)
X-Mailer: git-send-email 1.7.8.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191507>

It looks like commit 99fb6e04 (pack-objects: convert to use
parse_options(), 2012-02-01) moved the #ifdef NO_PTHREDS around but
hasn't noticed that the 'arg' variable no longer is available.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 builtin/pack-objects.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index db09cf7..71af246 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2449,7 +2449,7 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
 		die("bad pack compression level %d", pack_compression_level);
 #ifdef NO_PTHREADS
 	if (delta_search_threads !=3D 1)
-		warning("no threads support, ignoring %s", arg);
+		warning("no threads support, ignoring --threads");
 #endif
 	if (!pack_to_stdout && !pack_size_limit)
 		pack_size_limit =3D pack_size_limit_cfg;
--=20
1.7.8.4
