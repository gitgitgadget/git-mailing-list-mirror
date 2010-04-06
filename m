From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] t7006: test core.pager configuration in subdir of
 toplevel
Date: Mon, 5 Apr 2010 23:03:50 -0500
Message-ID: <20100406040350.GB30403@progeny.tock>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
 <1270492888-26589-44-git-send-email-pclouds@gmail.com>
 <20100406040145.GA30403@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 06:03:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz00c-0005pY-0H
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 06:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748Ab0DFEDV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 00:03:21 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:57454 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab0DFEDU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 00:03:20 -0400
Received: by gxk9 with SMTP id 9so3413563gxk.8
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 21:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9yhqTFFGITY4GnrzWZD4eVYXCMC2LMODhABHqO56ie4=;
        b=k2l0ltgUzIvR3Q4DtY0Zltjn1rPIXVkJSwtEFrHmEY3gkzjXWEzyOId+cHOuHboZwJ
         6x3a7TDBLfQROO1iHB2aF0Jb+I9cpZIs8PL9J1baIukH62ALiZvp277KlKj9SCUF4AlD
         QmTLyXgZkoXoRVawps2IY3MXvSyymbK8B2p7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=DWCAFucrqPo9HzGn7O+zhEYidfC/cW0gLoilkniG3p7Xh2HmEfWEPFT85cSbg0J5xm
         InXKGhJTB2uqDQR8bWiv1MP7RG+yobwtZh4FC2ivod/AfXrtqXq9PPdQa9skHhiZUGE7
         4oqlKH/mvTjMVDIIpyz5q5IlsiBk3V62Kuhn4=
Received: by 10.101.176.6 with SMTP id d6mr15842965anp.155.1270526598942;
        Mon, 05 Apr 2010 21:03:18 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm4071808iwn.10.2010.04.05.21.03.17
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 21:03:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100406040145.GA30403@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144091>

If git is passed the --paginate option, committing the pager choice
will require setting up the pager, which requires access to repository
for the core.pager configuration.

Unfortunately, the --paginate option is handled before git has a
chance to search for a git directory.  The effect is that with
--paginate and only with --paginate, a repository-local core.pager
setting does not take effect unless the git directory is simply .git
in the cwd (or GIT_DIR or GIT_CONFIG was explicitly set).

Add a test to demonstrate this problem.

Noticed while reading over a patch by Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=
=8Dc Duy that
fixes it.

Cc: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7006-pager.sh |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index d9202d5..4f804ed 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -164,6 +164,38 @@ test_expect_success TTY 'core.pager overrides PAGE=
R' '
 	test -e core.pager_used
 '
=20
+unset GIT_PAGER
+rm -f core.pager_used
+rm -fr sub
+test_expect_success TTY 'core.pager in subdir' '
+	PAGER=3Dwc &&
+	stampname=3D$(pwd)/core.pager_used &&
+	export PAGER stampname &&
+	git config core.pager "wc > \"\$stampname\"" &&
+	mkdir sub &&
+	(
+		cd sub &&
+		test_terminal git log
+	) &&
+	test -e "$stampname"
+'
+
+unset GIT_PAGER
+rm -f core.pager_used
+rm -fr sub
+test_expect_failure TTY 'core.pager in subdir with --paginate' '
+	PAGER=3Dwc &&
+	stampname=3D$(pwd)/core.pager_used &&
+	export PAGER stampname &&
+	git config core.pager "wc > \"\$stampname\"" &&
+	mkdir sub &&
+	(
+		cd sub &&
+		test_terminal git --paginate log
+	) &&
+	test -e "$stampname"
+'
+
 rm -f GIT_PAGER_used
 test_expect_success TTY 'GIT_PAGER overrides core.pager' '
 	git config core.pager wc &&
--=20
1.7.0.4.369.g62d9d
