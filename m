From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] test-lib: use subshell instead of cd $new && .. && cd $old
Date: Mon, 30 Aug 2010 12:00:42 +0000
Message-ID: <1283169642-21917-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Carl Worth <cworth@cworth.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 14:00:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq32m-0004fw-FP
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 14:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439Ab0H3MAu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 08:00:50 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34139 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006Ab0H3MAu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 08:00:50 -0400
Received: by wyb35 with SMTP id 35so6513777wyb.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 05:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Z4exz5N3YA+fl3/ounAmmv/1XR2iHeeTNK6hs22WKbg=;
        b=O2iK7H1wdESqc+5GHoHiiQ03+sciN58J3XFAC3aMBGF2Pv++EX6Akp7QbYoM0B4ihD
         PsPz2mCQlChZsgQAR0Yd8qX8mPzIDef/N29eMDnJfY+BS8IBklbEjlJbrP25pr/NcQIZ
         jVcn7p5zCmdlZ+C1aGeHVozWSk9TMe14/LyHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=N14T1U51rXnwfcGZcYc41TWwAL5kNqkZSlO+kayQXKu5hLx+mwZYsQnpEyxLAGisFD
         vz81Q3v9xmjl9htVGRMX5a1SnkSnG8bF+9PgjYE780KfEr9pel4HPlr8ZxKBmD8hDvh7
         7d6AKj5iGP2FFegB1PUgQOyYeAsh+AYh/cuXM=
Received: by 10.216.70.10 with SMTP id o10mr4726338wed.83.1283169648800;
        Mon, 30 Aug 2010 05:00:48 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p52sm4371997weq.20.2010.08.30.05.00.47
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 05:00:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.518.gf0ba8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154791>

Change the test_create_repo code added in v1.2.2~6 to use a subshell
instead of keeping track of the old working directory and cd-ing back
when it's done.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/test-lib.sh |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index dc934b8..778ba8d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -687,14 +687,12 @@ test_when_finished () {
 test_create_repo () {
 	test "$#" =3D 1 ||
 	error "bug in the test script: not 1 parameter to test-create-repo"
-	owd=3D`pwd`
 	repo=3D"$1"
 	mkdir -p "$repo"
-	cd "$repo" || error "Cannot setup test environment"
+	(cd "$repo" || error "Cannot setup test environment"
 	"$GIT_EXEC_PATH/git-init" "--template=3D$GIT_BUILD_DIR/templates/blt/=
" >&3 2>&4 ||
 	error "cannot run git init -- have you built things yet?"
-	mv .git/hooks .git/hooks-disabled
-	cd "$owd"
+	mv .git/hooks .git/hooks-disabled)
 }
=20
 test_done () {
--=20
1.7.2.2.518.gf0ba8
