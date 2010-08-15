From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2] log: test for regression introduced in v1.7.2-rc0~103^2~2
Date: Sun, 15 Aug 2010 10:16:25 +0000
Message-ID: <1281867385-30545-1-git-send-email-avarab@gmail.com>
References: <7v39uggs5h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 15 17:58:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Okfbi-0008GS-4Q
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 17:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758359Ab0HOP6k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 11:58:40 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61434 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758183Ab0HOP6k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Aug 2010 11:58:40 -0400
Received: by wwj40 with SMTP id 40so5347064wwj.1
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 08:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=wwvCKEYmPiDwsKYC+UrxOLrUVLEBe8JxrithCAlFY/k=;
        b=eVbmXxqLz351O9e+Xw9snNRUCS6XjyWI379r+vJ+/qie9xdBCl2/tdurBo0Tn2ftgd
         t6RTStK/Abf/vOm9YuJhTEpcwnAE3MiBxw0rMLvyojvdgFegdjAzm4BmInpquux83aU3
         MknQC+piRmi7/jCL/fu1Pz3AmGjz9h4C4g7Fc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=RVSkvelyLOviRmOvS2f0W7Cot6TBAcDie97vhImQ+je7LzRN96rToKPfglobUbHczN
         Zp9Xr8YmpqsS549EMRqA9XKU7gN1GgJ9jaHzkeCBzX6DitgxCJimyGAp9bi7Wu4Vga/F
         5Qm9sQEQJ2gAYJ36ZKmqiurlM1DemHkio7+Xs=
Received: by 10.216.5.13 with SMTP id 13mr1383718wek.91.1281867393145;
        Sun, 15 Aug 2010 03:16:33 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id n40sm2584924weq.29.2010.08.15.03.16.31
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 15 Aug 2010 03:16:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.339.gfad93
In-Reply-To: <7v39uggs5h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153606>

Add a regression test for the git log -M --follow $diff_option bug
introduced in v1.7.2-rc0~103^2~2, $diff_option being diff related
options like -p, --stat, --name-only etc.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

Version two of this test case, simpler, and takes into account
commentary from Junio.

 t/t4202-log.sh |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 95ac3f8..a0be122 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -441,5 +441,18 @@ test_expect_success 'log.decorate configuration' '
=20
 '
=20
+test_expect_success 'show added path under "--follow -M"' '
+	# This tests for a regression introduced in v1.7.2-rc0~103^2~2
+	test_create_repo regression &&
+	(
+		cd regression &&
+		test_commit needs-another-commit &&
+		test_commit Foo.bar &&
+		git log -M --follow -p Foo.bar.t &&
+		git log -M --follow --stat Foo.bar.t &&
+		git log -M --follow --name-only Foo.bar.t
+	)
+'
+
 test_done
=20
--=20
1.7.2.1.339.gfad93
