From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/4] Make t1300-repo-config resilient to being run via 'sh
 -x'
Date: Tue, 22 Mar 2016 18:42:49 +0100 (CET)
Message-ID: <b4df45088aa68d8410895f66a814dd6780e2e451.1458668543.git.johannes.schindelin@gmx.de>
References: <cover.1458668543.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 18:43:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiQKj-0003FW-8d
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 18:43:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756107AbcCVRnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 13:43:05 -0400
Received: from mout.gmx.net ([212.227.17.22]:56760 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753146AbcCVRnD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 13:43:03 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MHokD-1alSCM3XVV-003bXH; Tue, 22 Mar 2016 18:42:51
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1458668543.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:TyYhwOiCNhpyelGq5m/uglPfdhfwgZ1w/f/hOj862QANRgv6597
 XGfhUsUlV+XiQXAO7qVCcA5IskaF5Zq8F6zD7DPIRGn1wqQKqygEuYqSTAfyWnwQU0fEA6p
 YdQRw0grZWqI6VQzWyHU5ShcMp1CrB0r6OIoTQ7xl5PlVJ3xkFdEHALmmFSwE5n82/L8FqF
 In2sp/0Mz8Bmcv+kEK6fw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DWTaLT/+L4U=:60M1HCaYbV7UHxaR1vtuZl
 2FuD4pXSH57l4UMdAGyERCjz/sgmgSuKhsy6M3fgpZr5u68tldAnVT47bu5JnUzJL1pP7GjWn
 dod3e+S5iiJqrBrraN4OyPnSvCtTS0ezFotBn6zxOAvo6kfaawnC3NC9ijadioS6S+tdZX8zl
 I44ielCgMg8Nyj+WfoVWbJ5jaunFNLSRh8MBEI660c9WfFHSpZnNlKTqoxnFdDNpKMKB8xR4B
 NHvX8YMutBvPz0YSGjhSx6nz/1Js7r52iRqEoW1EgPRYK1rDEt9jy5y6PKGSiswSWjRlPUkBB
 34EakTuRCiEUJi/iwsBtUQ6rn6PaA10sVn7CQbfUkE5zU3C2JrmJ+wga9NcDtsm2tMGUtON//
 SV6V4aanql/g8S4YXMIvOtrzA1dC8uFiysG3ANJiM/iP/OnlGAG8hZ3TLzTfnYny9cN81fshk
 y1i7syMPVioIezmttYE9VSKbdD0gNyyLW7IpLBbwFysISxDd+53CXZ+BNEB6rNsUnpf4+YFSa
 Y7CY2n8lMBc7ZckM0+FhPzdTnV2UpqRX1pAOTMlTKdp4d48xbi6fJycZJCvuuJJFrSsmqsd8E
 AUiK7DCuc+VXSrBVk2CySPuMHkduLWMNSnsLigX47Z8OLbMJ+bjCXEqdjprQeqZIV8yGHFGwq
 5o9A69MprYS3Nv0SA7ibM1PFJG8vSQaODVPbcuCV7PC6/dEETb5051NK7FmGmMrTonQFNl1UG
 XGct7khsA6zuwGpR4mJaaR1tshUGwhgAKKgfsw0PiVf/EAbobKOeDWr/4TI02PO0s+F6Q7tp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289524>

One of this developer's primary tools to diagnose broken regression
tests is to run the test script using 'sh -x t... -i -v' to find out
*which* call *actually* demonstrates the symptom.

Hence it is pretty counterproductive if the test script behaves
differently when being run via 'sh -x', in particular when using
test_cmp or test_i18ncmp on redirected stderr.

So let's use grep instead of test_cmp/test_i18ncmp to verify that stderr
looks as expected.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1300-repo-config.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 8867ce1..0236fe2 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -699,17 +699,13 @@ test_expect_success 'invalid unit' '
 	echo 1auto >expect &&
 	git config aninvalid.unit >actual &&
 	test_cmp expect actual &&
-	cat >expect <<-\EOF &&
-	fatal: bad numeric config value '\''1auto'\'' for '\''aninvalid.unit'\'' in file .git/config: invalid unit
-	EOF
 	test_must_fail git config --int --get aninvalid.unit 2>actual &&
-	test_i18ncmp expect actual
+	grep "^fatal: bad numeric config value .1auto. for .aninvalid.unit. in file .git/config: invalid unit$" actual
 '
 
 test_expect_success 'invalid stdin config' '
-	echo "fatal: bad config line 1 in standard input " >expect &&
 	echo "[broken" | test_must_fail git config --list --file - >output 2>&1 &&
-	test_cmp expect output
+	grep "^fatal: bad config line 1 in standard input $" output
 '
 
 cat > expect << EOF
-- 
2.7.4.windows.1
