From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 17/20] gettextize: git-bisect bisect_reset + $1 messages
Date: Tue, 14 Sep 2010 13:52:17 +0000
Message-ID: <1284472340-7049-18-git-send-email-avarab@gmail.com>
References: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 16:01:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvW4m-0001xG-2E
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 16:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027Ab0INOBX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 10:01:23 -0400
Received: from mail-wy0-f180.google.com ([74.125.82.180]:35782 "EHLO
	mail-wy0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292Ab0INOBU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 10:01:20 -0400
Received: by wyb40 with SMTP id 40so9227858wyb.11
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 07:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=h77gp0b1SSYn2IePy3cil4zZl3EFkK8sCunQ13mhNuI=;
        b=UXF9FhthPHpK+mcYYUcgClenpWUEoFRjMhGP4DApFaEOdEKgoKfO5fHBKMcj+e/1ef
         k8HYJkTQueqQWVcYKgT9Uq+elqPAaFhpAmpHnIpggJ6jnf8e5D2BAz+Ijf97uhsNCz+X
         YjL6or11RUjpk12kyrgUA3Q6/3CuhckPXxJTs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=P07qGnsQg601VPFxydNMTMfbnA3Pel8WL3y3uXIWjmFqpuKY6q2AL5D24oVj1Eg7II
         d4vTAyYtLeGv87hgM32dEGazSixJO+r6A8SqjR2AMY9fgZmbJJCddEw5IHKai1R00lAr
         Fq6tz9+p06B+RpuIKxX0hiPcTUZdSXRe2Iufo=
Received: by 10.227.163.72 with SMTP id z8mr780880wbx.52.1284472430704;
        Tue, 14 Sep 2010 06:53:50 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm158854weq.16.2010.09.14.06.53.47
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 06:53:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.234.g8dc15
In-Reply-To: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156191>

ettextize bisect_reset messages that use the $1 variable. Since it's
subroutine local we have to provide an alias for it for eval_gettext.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 3b10ce6..64c6b81 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -311,8 +311,10 @@ bisect_reset() {
 	}
 	case "$#" in
 	0) branch=3D$(cat "$GIT_DIR/BISECT_START") ;;
-	1) git rev-parse --quiet --verify "$1^{commit}" > /dev/null ||
-	       die "'$1' is not a valid commit"
+	1) git rev-parse --quiet --verify "$1^{commit}" > /dev/null || {
+	       invalid=3D"$1"
+	       die "$(eval_gettext "'\$invalid' is not a valid commit")"
+	   }
 	   branch=3D"$1" ;;
 	*)
 	    usage ;;
--=20
1.7.3.rc1.234.g8dc15
