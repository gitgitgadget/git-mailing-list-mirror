From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 4/7] completion: add __gitcomp_nl tests
Date: Wed, 10 Apr 2013 01:57:54 -0500
Message-ID: <1365577077-12648-5-git-send-email-felipe.contreras@gmail.com>
References: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 08:59:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPp05-0007eM-QL
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 08:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481Ab3DJG7P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Apr 2013 02:59:15 -0400
Received: from mail-qe0-f50.google.com ([209.85.128.50]:42517 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab3DJG7O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 02:59:14 -0400
Received: by mail-qe0-f50.google.com with SMTP id a11so70888qen.9
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 23:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=G05cM0bshX0N1lipOxLNCv/ErxKHPlPHptuQryocFwY=;
        b=vv7bnHFjhPsmPYoDd41yjL7WrZizhTXw3/RvSzqmRk+8rfit+rWj+pDc/+sk/ui1Z2
         f1d3Sv2Skgpfd+O1R/T6cxd3qGxPy1jhkGUUXpvYb5r0mImapLKDoX8+iNj7F6Y+SMOE
         IzEa9eo1JLDdEzPdDssvLvlryDO1OOacXMsy7LuyzXfxBozxZ8Ds3PBXPHRrgEczuQXa
         kNCiMLSIMId1HWCDWjehNGDEhwLeIT3istQS7ECZmRChV0L8q0kst2LnsFd5lov9zzZf
         mkuglL/NbGvY/clRGNudPWpM4VTyvNSrGz0YgE8czjQ+5K03qKjyjtz9mmXgfi5ZtC1N
         ksSg==
X-Received: by 10.224.9.198 with SMTP id m6mr1117687qam.46.1365577153211;
        Tue, 09 Apr 2013 23:59:13 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id e3sm29450000qeo.0.2013.04.09.23.59.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 23:59:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220667>

Original patch by SZEDER G=C3=A1bor.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 60 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 60 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 99d5c01..b752f4d 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -105,6 +105,23 @@ test_gitcomp ()
 	test_cmp expected out
 }
=20
+# Test __gitcomp_nl
+# Arguments are:
+# 1: current word (cur)
+# -: the rest are passed to __gitcomp_nl
+test_gitcomp_nl ()
+{
+	local -a COMPREPLY &&
+	sed -e 's/Z$//' >expected &&
+	cur=3D"$1" &&
+	shift &&
+	__gitcomp_nl "$@" &&
+	print_comp &&
+	test_cmp expected out
+}
+
+invalid_variable_name=3D'${foo.bar}'
+
 test_expect_success '__gitcomp - trailing space - options' '
 	test_gitcomp "--re" "--dry-run --reuse-message=3D --reedit-message=3D
 		--reset-author" <<-EOF
@@ -148,6 +165,49 @@ test_expect_success '__gitcomp - suffix' '
 	EOF
 '
=20
+test_expect_failure '__gitcomp - doesnt fail because of invalid variab=
le name' '
+	__gitcomp "$invalid_variable_name"
+'
+
+read -r -d "" refs <<-\EOF
+maint
+master
+next
+pu
+EOF
+
+test_expect_success '__gitcomp_nl - trailing space' '
+	test_gitcomp_nl "m" "$refs" <<-EOF
+	maint Z
+	master Z
+	EOF
+'
+
+test_expect_success '__gitcomp_nl - prefix' '
+	test_gitcomp_nl "--fixup=3Dm" "$refs" "--fixup=3D" "m" <<-EOF
+	--fixup=3Dmaint Z
+	--fixup=3Dmaster Z
+	EOF
+'
+
+test_expect_success '__gitcomp_nl - suffix' '
+	test_gitcomp_nl "branch.ma" "$refs" "branch." "ma" "." <<-\EOF
+	branch.maint.Z
+	branch.master.Z
+	EOF
+'
+
+test_expect_success '__gitcomp_nl - no suffix' '
+	test_gitcomp_nl "ma" "$refs" "" "ma" "" <<-\EOF
+	maintZ
+	masterZ
+	EOF
+'
+
+test_expect_failure '__gitcomp_nl - doesnt fail because of invalid var=
iable name' '
+	__gitcomp_nl "$invalid_variable_name"
+'
+
 test_expect_success 'basic' '
 	run_completion "git " &&
 	# built-in
--=20
1.8.2.1
