From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [MinGW PATCH] spawnvppe_pipe: Don't overwrite argv[0]
Date: Sat, 27 Oct 2007 20:26:31 +0700
Message-ID: <20071027132631.GA32149@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Oct 27 15:26:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Illgm-0005kG-LF
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 15:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795AbXJ0N0o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Oct 2007 09:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752587AbXJ0N0o
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 09:26:44 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:64978 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517AbXJ0N0n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 09:26:43 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1071698rvb
        for <git@vger.kernel.org>; Sat, 27 Oct 2007 06:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        bh=6+an9nWw3fK0cy7XG5/J3j30hEYjFmEZ/k1cAbYYPJ0=;
        b=FFPaiOGG01nP/CydW+guVQBw6gLJqvXliWycNRIwfLRI0+uknhYb4YzOiyEnySHAwf3vOkmgBH7XXFETRPGmvY+ZvNPD5i+u2XypQeKp6h2NO/O4cFVkzhMJtKG3AKKtszlVY3w8UzNpdZ2Lk0GW7FhJhYcNKFMEGqNVwv9vkl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=aYTsk+bBNNQZmZ2lZns/GsUjpfZBn0rt0NEu8VU68/iapoh8bHk2RsEHBNLt+lehXL+8DVrvW7UyYSulnncm/xsU/s2C4seipSp/odDf0KqEqEvgmFaFFdqq7Q8BnEVwB5qXfaD4b5bJ3rXPBq//tzWOvl/EnvDTjnrbk8LbfKU=
Received: by 10.140.251.1 with SMTP id y1mr2004856rvh.1193491603279;
        Sat, 27 Oct 2007 06:26:43 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.1.6])
        by mx.google.com with ESMTPS id g22sm7542136rvb.2007.10.27.06.26.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Oct 2007 06:26:40 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 27 Oct 2007 20:26:31 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62491>

Because caller expects it so

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 spawn-pipe.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/spawn-pipe.c b/spawn-pipe.c
index c8f0452..3df7e22 100644
--- a/spawn-pipe.c
+++ b/spawn-pipe.c
@@ -123,6 +123,7 @@ int spawnvppe_pipe(const char *cmd, const char **ar=
gv, const char **env,
 		  int pin[], int pout[])
 {
 	const char *cmd_basename =3D strrchr(cmd, '/');
+	const char *argv0 =3D argv[0];
 	pid_t pid;
=20
 #ifdef __MINGW32__
@@ -214,6 +215,8 @@ int spawnvppe_pipe(const char *cmd, const char **ar=
gv, const char **env,
 	}
 #endif
=20
+	argv[0] =3D argv0;
+
 	return pid;
 }
=20
--=20
1.5.3.rc4.3.gab089
