From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 71/72] gettextize: git-revert split up "could not revert/apply" message
Date: Sat, 19 Feb 2011 19:24:54 +0000
Message-ID: <1298143495-3681-72-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:29:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsUV-0003dU-EG
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756254Ab1BST2p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:28:45 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62949 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162Ab1BST23 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:29 -0500
Received: by eye27 with SMTP id 27so2347289eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=/b3RwdzMteJyULyuTuWfe06iQjYn0cqRAfhgsQwD0bE=;
        b=aRUQ0WoK4S1fGI24vUodlAP3iweYUGajgr0xX/GHePzAumpAJMAWnGFPuTErAp4Mki
         4aqlIWFwhUF634SaG88Q4x2ucFwy3BQVJ+9zMawXpLqjpGjhAs++2OEVSiQP+ItU821U
         fn2PvxM2z3sm/ZsaOe6l7w5gWQFkrYGmOuU/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XSUnBOq9O3hn7z52/9SByjLWV+2c8hExS4eRu8liQF5B3sPkuFhhm5aJ8BOuLM7Hpe
         qysbwhd4XRRtv6ckVcfzesKNFiIslWArpTcZebxD7dlXTFCIAR4WPf0TjSThAYgnIYrk
         0J1TRlQbj8nfmtbdqn9U7cuHxNMSUAkpYx6tA=
Received: by 10.213.113.210 with SMTP id b18mr2533300ebq.21.1298143708265;
        Sat, 19 Feb 2011 11:28:28 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.27
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:27 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167357>

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
index 607bf25..bf664ec 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -38,7 +38,7 @@ test_expect_success 'failed cherry-pick does not adva=
nce HEAD' '
 	test "$head" =3D "$newhead"
 '
=20
-test_expect_success 'advice from failed cherry-pick' "
+test_expect_success NO_GETTEXT_POISON 'advice from failed cherry-pick'=
 "
 	git checkout -f initial^0 &&
 	git read-tree -u --reset HEAD &&
 	git clean -d -f -f -q -x &&
--=20
1.7.2.3
