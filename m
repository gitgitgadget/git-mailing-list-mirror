From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 2/7] t/t5705-clone-2gb: change from skip_all=* to prereq skip
Date: Wed, 11 Aug 2010 19:04:05 +0000
Message-ID: <1281553450-26467-3-git-send-email-avarab@gmail.com>
References: <7vd3tpxao1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 21:04:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjGbT-00034v-CV
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 21:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758450Ab0HKTEd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 15:04:33 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51867 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755602Ab0HKTE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 15:04:29 -0400
Received: by wwj40 with SMTP id 40so479718wwj.1
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 12:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=/CpIvkmqsdtVxBAjYeP6B7LN3F5GdSksSuaz+BTDMGk=;
        b=ACvZqRtXKQOkunoiRSxyeDzkIVsCsi5hvnE71ESVxKpMpEnDUy+B6iQ/Kk+DYD1HlH
         X0iBANY6DJnIlmDavUxylGxsJdu3FvxYP2u2sI7ydlJWabv4x6NHKQD6Nl1uTkuUi/7V
         1wUIjdRoU7UNsuLcv0UGqsfh6l32L0Q14KsbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=sOGLDCp2wCm4qNTYSChcogz0o7B7ibXtXCWM8Cla9puDShadBcSNOCrpS7TkXrlS1z
         OSMuULANKL9OCPDB9DMaJG+S/Qb35Xcdikal94IHKDkbd2vyae9W+wsVpgIIBScOigfZ
         +cZ4UZ+wjFPUAVOwHvaG8jA6Vn/EsPVsulris=
Received: by 10.227.133.66 with SMTP id e2mr16986590wbt.132.1281553468379;
        Wed, 11 Aug 2010 12:04:28 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b18sm369379wbb.19.2010.08.11.12.04.27
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 12:04:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.295.gdf931
In-Reply-To: <7vd3tpxao1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153282>

Change this test to skip test with test prerequisites, and to do setup
work in tests. This improves the skipped statistics on platforms where
the test isn't run.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t5705-clone-2gb.sh |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/t/t5705-clone-2gb.sh b/t/t5705-clone-2gb.sh
index e4d1b6a..e9783c3 100755
--- a/t/t5705-clone-2gb.sh
+++ b/t/t5705-clone-2gb.sh
@@ -3,12 +3,14 @@
 test_description=3D'Test cloning a repository larger than 2 gigabyte'
 . ./test-lib.sh
=20
-test -z "$GIT_TEST_CLONE_2GB" &&
-skip_all=3D"Skipping expensive 2GB clone test; enable it with GIT_TEST=
_CLONE_2GB=3Dt" &&
-test_done &&
-exit
+if test -z "$GIT_TEST_CLONE_2GB"
+then
+	say 'Skipping expensive 2GB clone test; enable it with GIT_TEST_CLONE=
_2GB=3Dt'
+else
+	test_set_prereq CLONE_2GB
+fi
=20
-test_expect_success 'setup' '
+test_expect_success CLONE_2GB 'setup' '
=20
 	git config pack.compression 0 &&
 	git config pack.depth 0 &&
@@ -36,13 +38,13 @@ test_expect_success 'setup' '
=20
 '
=20
-test_expect_success 'clone - bare' '
+test_expect_success CLONE_2GB 'clone - bare' '
=20
 	git clone --bare --no-hardlinks . clone-bare
=20
 '
=20
-test_expect_success 'clone - with worktree, file:// protocol' '
+test_expect_success CLONE_2GB 'clone - with worktree, file:// protocol=
' '
=20
 	git clone file://. clone-wt
=20
--=20
1.7.2.1.295.gdf931
