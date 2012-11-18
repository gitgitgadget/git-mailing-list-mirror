From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v2 4/8] tmp: completion: add SZEDER's tests
Date: Sun, 18 Nov 2012 11:56:49 +0100
Message-ID: <1353236213-13471-5-git-send-email-felipe.contreras@gmail.com>
References: <1353236213-13471-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robert Zeh <robert.a.zeh@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 11:57:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta2ZK-0007uV-2O
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 11:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627Ab2KRK51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 05:57:27 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38308 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab2KRK50 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 05:57:26 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1599953bkw.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 02:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=kRUbxqIBwUnFv+MuOfxJDuPByK25/wkYVOgWW7DowJc=;
        b=sfavAaP3i5z1Y12ffHpFMmejNg8UOxtWdaIlnjQ60UVfsB/J+F0d2LEPFZT1QCqBCb
         zMFyD4hbx9RzLsJByH0+as7PivIcYc9u+xTHw7mM3+YwCbVBhYTBoEgwfdmW+Qz2eblF
         kqoROtEPke3I+bRxzDPzG2WopIRRou1a5IvxzK1zs6ZgvfKv78O3W3aDITdM8qGILd1U
         E72n3hpM2QiGe0gQTZ3xHvqxFfd3PUW3ZYsRGRfAG9wyLgpPHl9XzAnCmI7s6iGagJ3l
         Whr1lEqYVJFTrujF0h79xes1wxVS97qfYjXx5NM+6Yv0VkFg9dpKu58b2pItiQJrqHrU
         xyTA==
Received: by 10.204.145.144 with SMTP id d16mr3763347bkv.84.1353236246227;
        Sun, 18 Nov 2012 02:57:26 -0800 (PST)
Received: from localhost (ip-109-43-0-81.web.vodafone.de. [109.43.0.81])
        by mx.google.com with ESMTPS id gy18sm2895986bkc.4.2012.11.18.02.57.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Nov 2012 02:57:25 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353236213-13471-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210016>

Separate patch series, but the results are relevant.

+ modifications from me.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 79a2453..35fc31b 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -73,6 +73,24 @@ test_completion_long ()
 
 newline=$'\n'
 
+# Test __gitcomp_nl
+# Arguments are:
+# 1: current word (cur)
+# -: the rest are passed to __gitcomp_nl
+test_gitcomp_nl ()
+{
+	local -a COMPREPLY &&
+	sed -e 's/Z$//' > expected &&
+	cur="$1" &&
+	shift &&
+	__gitcomp_nl "$@" &&
+	print_comp &&
+	cp expected out /tmp
+	test_cmp expected out
+}
+
+invalid_variable_name="${foo.bar}"
+
 test_expect_success '__gitcomp - trailing space - options' '
 	sed -e "s/Z$//" >expected <<-\EOF &&
 	--reuse-message=Z
@@ -156,6 +174,49 @@ test_expect_success '__gitcomp - suffix' '
 	test_cmp expected out
 '
 
+test_expect_failure '__gitcomp - doesnt fail because of invalid variable name' '
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
+	test_gitcomp_nl "--fixup=m" "$refs" "--fixup=" "m" <<-EOF
+	--fixup=maint Z
+	--fixup=master Z
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
+test_expect_failure '__gitcomp_nl - doesnt fail because of invalid variable name' '
+	__gitcomp_nl "$invalid_variable_name"
+'
+
 test_expect_success 'basic' '
 	run_completion "git " &&
 	# built-in
-- 
1.8.0
