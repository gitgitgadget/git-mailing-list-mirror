From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] commit: fix test broken by jn/commit-no-change-wo-status
Date: Tue, 10 Aug 2010 13:38:39 +0000
Message-ID: <1281447519-25862-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 15:38:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oip2a-0003NJ-TX
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 15:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757610Ab0HJNis convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 09:38:48 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47277 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756524Ab0HJNiq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 09:38:46 -0400
Received: by wwj40 with SMTP id 40so12874514wwj.1
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 06:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=gmGuOjcN8RwyeIEdHkFzcG/zX+ilWKj8iKgVP+/HgsE=;
        b=tkMO9bdmwaE4pI22lgPABfyR8CL6cPsj+oIgoj+0PjYxy3rhCRI1W0dOX3DDbgKqlM
         U4ZT9l7R4WK0zeseqOFMmyI9eYgHg0khY/DCRsS5rdjo2FzLmJNMQaQXhqSKB9iIH1K2
         UBpnDNaqer9dH0LqKHn0FXFXJ45vtAMaVo6fg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Lorv/EMiFRTNV5GdMCzW0XJExYfLVvrlhnmDQSgRXZ4t3udttuQesfO6JYdWK0Pall
         Tj0MfGiaLKHPsoobn/uCJYoPzbRX3+2LIcEi/oD6OLhg+KVL7sqx4PNFMMxzNOlx6ADP
         rC/iWZFuFHgM2aT9tZHg6T5iiyM9P46m65Uds=
Received: by 10.216.35.65 with SMTP id t43mr3936027wea.34.1281447525248;
        Tue, 10 Aug 2010 06:38:45 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id n40sm3319107weq.5.2010.08.10.06.38.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 06:38:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153103>

"commit: suppress status summary when no changes staged" in Jonathan
Nieder's jn/commit-no-change-wo-status series changed git commit
--dry-run output. But didn't update the t/t6040-tracking-info.sh test,
which relied on the old output.

Change the test to check the new output, and additionally test stderr
there while I'm at it.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

This is 1/2 things causing black smoke in pu right now.

 t/t6040-tracking-info.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 1785e17..5f50f70 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -70,8 +70,9 @@ test_expect_success 'status' '
 		git checkout b1 >/dev/null &&
 		# reports nothing to commit
 		test_must_fail git commit --dry-run
-	) >actual &&
-	grep "have 1 and 1 different" actual
+	) >actual 2>actual-err &&
+	grep "nothing to commit" actual &&
+	grep "Already on" actual-err
 '
=20
 test_expect_success 'status when tracking lightweight tags' '
--=20
1.7.1
