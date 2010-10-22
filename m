From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/7] branch -h: show usage even in an invalid repository
Date: Fri, 22 Oct 2010 01:42:58 -0500
Message-ID: <20101022064258.GB6081@burratino>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 08:46:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9BP0-0003Hd-2Q
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 08:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489Ab0JVGqq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 02:46:46 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43197 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab0JVGqo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 02:46:44 -0400
Received: by gwj21 with SMTP id 21so789827gwj.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 23:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=FvOmjEMy5p1mrAcKajdNZYZwzSBMTs/9RyllkO26n1U=;
        b=AHIRRPezVI+ZjYA9n+Qcog7Bf1goTUE6qupNgqalbuL1itu16qTecm82v4rGoGjRTE
         5/8y+TiZ+yf6Cw601APhwmhAO1/YlIN+bagtMDtc090f9kZDNNmvut77hoHgJp+Yfdcy
         YAPphK/rruz/hP/2LKVRhS4EUCIKB+SoIJdpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=tTuu6HzBK/hkBuhz2Rh1Fn6KRgiTDL+7IaeghqCYeCI6lVKUdgSXGfIR3DrQW0suB2
         c8aSWtvjx5UaAqfaS2YYSjqm9tkBP258SGCDjnn4pCrOCSQ+O8pme6KXkAe7uYsCmyAK
         yVKbO9qD+TNdwgk7zvlczYJH3uOSCGXE9eSZ4=
Received: by 10.90.35.4 with SMTP id i4mr2060906agi.79.1287730004051;
        Thu, 21 Oct 2010 23:46:44 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id w15sm3062536anw.13.2010.10.21.23.46.42
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 23:46:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101022063837.GA6081@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159651>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

There is no need for "git branch -h" to try to access a repository.

In the spirit of v1.6.6-rc0~34^2~3 (Let 'git <command> -h' show usage
without a git dir, 2009-11-09).  This brings git one step closer to
passing the following (automatically verifiable) test:

 Before any repository access (aside from git_config()), a
 function from the setup_git_directory_* family has been run

and thus one step closer to being able to use an automatic repository
access checker.

[jn: simplified; new commit message, test]

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/branch.c  |    3 +++
 t/t3200-branch.sh |   11 +++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 87976f0..0e50556 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -667,6 +667,9 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 		OPT_END(),
 	};
=20
+	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(builtin_branch_usage, options);
+
 	git_config(git_branch_config, NULL);
=20
 	if (branch_use_color =3D=3D -1)
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index f54a533..f308235 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -26,6 +26,17 @@ test_expect_success \
      ! test -f .git/refs/heads/--help
 '
=20
+test_expect_success 'branch -h in broken repository' '
+	mkdir broken &&
+	(
+		cd broken &&
+		git init &&
+		>.git/refs/heads/master &&
+		test_expect_code 129 git branch -h >usage 2>&1
+	) &&
+	grep "[Uu]sage" broken/usage
+'
+
 test_expect_success \
     'git branch abc should create a branch' \
     'git branch abc && test -f .git/refs/heads/abc'
--=20
1.7.2.3
