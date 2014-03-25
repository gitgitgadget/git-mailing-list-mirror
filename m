From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 028/144] t1512-rev-parse-disambiguation.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:33 -0700
Message-ID: <1395735989-3396-29-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:36:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMqd-0001QU-OL
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688AbaCYIgc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:36:32 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:55698 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbaCYI1K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:10 -0400
Received: by mail-pa0-f44.google.com with SMTP id bj1so135417pad.3
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+4GkEEcg62Gu1JM67GKjY9G/NJ0Hm2C4aR/lvBN6ANQ=;
        b=OnCveisfryphztFC0WbF6IYRs/9Hdgd6KetmhjcwDGkviVPZaEzhnEGETlCC6RlVsC
         +LeemOAXGK3ZVgDnssXCfhC5ciWsIhANyM0V/NOwxaAEG6gEZBDKfnmhWtjD+al/+xi9
         PsVnagH/Z2VFhVig3r6HQthGE6wqKujWEIRq1srtd3/J8y/W/l9hSTGjBsNnrf/lacxx
         tjVTBW19rp5KENHmsPrNBBz46p1x8tVCbZNpq4gUY3dDYZIRbg5s+U/lVN8LC6y2lkBK
         dr8DXEAeFly3L2nYfRd8XZ9O39iarmn4RqlKK+fKFx5QlRRh0rVbRK1+GJe00HQJ/9s/
         EZ3A==
X-Received: by 10.69.26.103 with SMTP id ix7mr77818512pbd.41.1395736030245;
        Tue, 25 Mar 2014 01:27:10 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244996>

The Git CodingGuidelines prefer the $( ... ) construct for command
substitution instead of using the back-quotes, or grave accents (`..`).

The backquoted form is the historical method for command substitution,
and is supported by POSIX. However,all but the simplest uses become
complicated quickly. In particular,embedded command substitutions
and/or the use of double quotes require careful escaping with the backs=
lash
character. Because of this the POSIX shell adopted the $(=E2=80=A6) fea=
ture from
the Korn shell.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t1512-rev-parse-disambiguation.sh |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-di=
sambiguation.sh
index 4a155c8..e221167 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -275,19 +275,19 @@ test_expect_success 'rev-parse --disambiguate' '
=20
 test_expect_success 'ambiguous 40-hex ref' '
 	TREE=3D$(git mktree </dev/null) &&
-	REF=3D`git rev-parse HEAD` &&
+	REF=3D$(git rev-parse HEAD) &&
 	VAL=3D$(git commit-tree $TREE </dev/null) &&
 	git update-ref refs/heads/$REF $VAL &&
-	test `git rev-parse $REF 2>err` =3D $REF &&
+	test $(git rev-parse $REF 2>err) =3D $REF &&
 	grep "refname.*${REF}.*ambiguous" err
 '
=20
 test_expect_success 'ambiguous short sha1 ref' '
 	TREE=3D$(git mktree </dev/null) &&
-	REF=3D`git rev-parse --short HEAD` &&
+	REF=3D$(git rev-parse --short HEAD) &&
 	VAL=3D$(git commit-tree $TREE </dev/null) &&
 	git update-ref refs/heads/$REF $VAL &&
-	test `git rev-parse $REF 2>err` =3D $VAL &&
+	test $(git rev-parse $REF 2>err) =3D $VAL &&
 	grep "refname.*${REF}.*ambiguous" err
 '
=20
--=20
1.7.10.4
