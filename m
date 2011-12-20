From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] t/t2023-checkout-m.sh: fix use of test_must_fail
Date: Tue, 20 Dec 2011 20:37:45 +0000
Message-ID: <1324413465-25614-1-git-send-email-avarab@gmail.com>
References: <4EDF1631.5090906@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Pete Harlan <pgit@pcharlan.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 20 21:37:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rd6RY-0004AS-Er
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 21:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193Ab1LTUhp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Dec 2011 15:37:45 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:48718 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688Ab1LTUhn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 15:37:43 -0500
Received: by wibhm6 with SMTP id hm6so1607087wib.19
        for <git@vger.kernel.org>; Tue, 20 Dec 2011 12:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DrzXbX6jhrYPHG5KZ/5LQndDWdjD9MR45qIepvuTNH4=;
        b=cKqnO0p8u4sg2XuDII1v/Yl/7252xAb2vTw1V4pBXPUBHfMyXWcirIFL7DstfVOiPn
         3kIcpRXunD6n1GfbUP1WrHy+UH8mUscPedoAmiocJFsqLOCNptjPGyQCqnL4mQ99TY9M
         lJb9uTtICnMO2CwQMMd9LkRHUj9xiZUjsghcg=
Received: by 10.180.96.72 with SMTP id dq8mr8044648wib.10.1324413462154;
        Tue, 20 Dec 2011 12:37:42 -0800 (PST)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id 28sm3343027wby.3.2011.12.20.12.37.40
        (version=SSLv3 cipher=OTHER);
        Tue, 20 Dec 2011 12:37:41 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <4EDF1631.5090906@pcharlan.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187526>

Change an invocation of test_must_fail() to be inside a
test_expect_success() as is our usual pattern. Having it outside
caused our tests to fail under prove(1) since we wouldn't print a
newline before TAP output:

    CONFLICT (content): Merge conflict in both.txt
    # GETTEXT POISON #ok 2 - -m restores 2-way conflicted+resolved file

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t2023-checkout-m.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/t/t2023-checkout-m.sh b/t/t2023-checkout-m.sh
index 1a40ce0..7e18985 100755
--- a/t/t2023-checkout-m.sh
+++ b/t/t2023-checkout-m.sh
@@ -17,7 +17,9 @@ test_expect_success setup '
 	test_commit added_in_topic each.txt in_topic
 '
=20
-test_must_fail git merge master
+test_expect_success 'git merge master' '
+    test_must_fail git merge master
+'
=20
 clean_branchnames () {
 	# Remove branch names after conflict lines
--=20
1.7.7.3
