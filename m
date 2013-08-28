From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2] remote-bzr: fix export of utf-8 authors
Date: Wed, 28 Aug 2013 16:14:40 -0500
Message-ID: <1377724480-18649-1-git-send-email-felipe.contreras@gmail.com>
References: <CAPig+cSt6HCuB2VOj_-C+e7BeXJD72hKdtNN3ueyKn6B4DSu7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 28 23:19:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEn9F-0003ot-KO
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 23:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755949Ab3H1VTZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Aug 2013 17:19:25 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:41149 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122Ab3H1VTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 17:19:25 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so7420381obc.12
        for <git@vger.kernel.org>; Wed, 28 Aug 2013 14:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GEl0DJNG7C9FfuknCwpYRWLC/FNgWjlBMOz3pGOImwg=;
        b=oPwqc7dZwN1x7JW2zOJ3SI8R22dE0rkDyZg+IKKmH10F2MxzkZXweYqDWD8gp0iq1q
         nMB3aPqOloZXm2F3blBmpj7apMD3U8x0y+4xxerfoAogU1w3UYyhJ2kfmRioE7ke2rbv
         dDqXXJL6J6/kXArDm8z4fk0suqn9cYWdSwp22710ggo2y64lymKkYA0Ks2XR2o4oVbSo
         PA9qNEr82SFnfFHhJf+CKQPc5011D9e4Ow+XrevdyRB48rwf/tMk64xrNCGIr4LGdXC4
         M8l/vi61kXGvLEugyl5+vScUsDvz/GAott8LXJxy2MnKtghswnTdrBrss4w4ztMtbTTz
         MDQA==
X-Received: by 10.182.153.200 with SMTP id vi8mr25331611obb.27.1377724764621;
        Wed, 28 Aug 2013 14:19:24 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ps5sm29010806oeb.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 Aug 2013 14:19:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc-3-g64bc480
In-Reply-To: <CAPig+cSt6HCuB2VOj_-C+e7BeXJD72hKdtNN3ueyKn6B4DSu7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233216>

Reported-by: Joakim Verona <joakim@verona.se>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr |  1 +
 contrib/remote-helpers/test-bzr.sh    | 30 +++++++++++++++++++++++++++=
+++
 2 files changed, 31 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-hel=
pers/git-remote-bzr
index c3a3cac..08b0b61 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -168,6 +168,7 @@ class Parser:
         if not m:
             return None
         _, name, email, date, tz =3D m.groups()
+        name =3D name.decode('utf-8')
         committer =3D '%s <%s>' % (name, email)
         tz =3D int(tz)
         tz =3D ((tz / 100) * 3600) + ((tz % 100) * 60)
diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helper=
s/test-bzr.sh
index dce281f..b0d70fd 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -358,4 +358,34 @@ test_expect_success 'strip' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'export utf-8 authors' '
+	test_when_finished "rm -rf bzrrepo gitrepo && LC_ALL=3DC && unset GIT=
_COMMITTER_NAME" &&
+
+	LC_ALL=3Den_US.UTF-8
+	export LC_ALL
+
+	GIT_COMMITTER_NAME=3D"Gr=C3=A9goire"
+	export GIT_COMMITTER_NAME
+
+	bzr init bzrrepo &&
+
+	(
+	git init gitrepo &&
+	cd gitrepo &&
+	echo greg >> content &&
+	git add content &&
+	git commit -m one &&
+	git remote add bzr "bzr::../bzrrepo" &&
+	git push bzr
+	) &&
+
+	(
+	cd bzrrepo &&
+	bzr log | grep "^committer: " > ../actual
+	) &&
+
+	echo "committer: Gr=C3=A9goire <committer@example.com>" > expected &&
+	test_cmp expected actual
+'
+
 test_done
--=20
1.8.4-fc-3-g64bc480
