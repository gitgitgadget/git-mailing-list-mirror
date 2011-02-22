From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 72/73] gettextize: git-revert split up "could not revert/apply" message
Date: Tue, 22 Feb 2011 23:42:31 +0000
Message-ID: <1298418152-27789-73-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:45:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1vJ-0000K1-0e
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755652Ab1BVXpB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:45:01 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:52041 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755626Ab1BVXou (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:50 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3867035bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=wiLpeDzK1VqwJMvEJqRLeR25cu78fmT9Yf+LjsaXqok=;
        b=BBkf7vcvrq2JQVXTKebkVeKXQbXcBHhvFLuTe+7g9554xptR2zfMZiMITHyCA/r6AU
         GIgi6nqiTwxvn27NPpIlDlM8RD/kn4JsMVcDvuSNenVezykQecBhlH0ksXZA9xIuosVS
         7lZ/39Rb8/oPlhXOYzv/rfJVlTMHEAXvi+bcM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=m4KMoxkYfTd/X6n7pN93SIMNKP62GXEZQFMyHQqvwI51BigAGVK0bbiRZAHT5j+rfX
         xZBJ7qq7u0/uLWHauX1SoDcjQcWX62rC8Nz3LcVhNgwu846YxOBBslguRS7w4OqIa70c
         TEs4Y5IJjyndhyutEdq4T8pPO9R/3wATcSXz0=
Received: by 10.204.116.206 with SMTP id n14mr2989644bkq.65.1298418289928;
        Tue, 22 Feb 2011 15:44:49 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.48
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:49 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167622>

Split up the "could not %s %s... %s" message into "could not revert
%s... %s" and "could not apply %s... %s". This makes it easier for
translators to understand the message.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/revert.c                |    5 +++--
 t/t3507-cherry-pick-conflict.sh |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index b0a5ffb..98dfd4d 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -536,8 +536,9 @@ static int do_pick_commit(void)
 	}
=20
 	if (res) {
-		error("could not %s %s... %s",
-		      action =3D=3D REVERT ? "revert" : "apply",
+		error(action =3D=3D REVERT
+		      ? _("could not revert %s... %s")
+		      : _("could not apply %s... %s"),
 		      find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
 		      msg.subject);
 		print_advice();
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conf=
lict.sh
index 607bf25..f7e4072 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -38,7 +38,7 @@ test_expect_success 'failed cherry-pick does not adva=
nce HEAD' '
 	test "$head" =3D "$newhead"
 '
=20
-test_expect_success 'advice from failed cherry-pick' "
+test_expect_success C_LOCALE_OUTPUT 'advice from failed cherry-pick' "
 	git checkout -f initial^0 &&
 	git read-tree -u --reset HEAD &&
 	git clean -d -f -f -q -x &&
--=20
1.7.2.3
