From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 2/4] Make t1300-repo-config resilient to being run via
 'sh -x'
Date: Wed, 23 Mar 2016 11:55:07 +0100 (CET)
Message-ID: <2426f15643f605cd197772323c888f1df7c0d313.1458730457.git.johannes.schindelin@gmx.de>
References: <cover.1458668543.git.johannes.schindelin@gmx.de> <cover.1458730457.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:55:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aigS6-0006Vd-OP
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699AbcCWKzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:55:31 -0400
Received: from mout.gmx.net ([212.227.15.19]:57634 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754663AbcCWKzW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 06:55:22 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M2L2a-1Zt3I94BmO-00s7is; Wed, 23 Mar 2016 11:55:10
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1458730457.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:fu/EL+jnY759ThqC4N3bd1hcceUhW43glxLRZsBYxoL8CYgXXIG
 wVhGRaY9u2Pler+EqPy4tGVzUg9LGYbypSa2SyRpy43Kj2W7wUY9tde518Ds1MaFvYu6JrM
 ZDCW9cQi+W4j0IIjn9BadcaS7CVFVjJ8it7DkMSki4JSMSOoM6VnCJTnYPxwFdD6WfUBT5K
 0kADMYZIAzwBNntQlPcVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jrs1GFiJNyE=:rbC5OGjXdR/PI+IgmFzhTh
 bIn9nTHo+7UlQZpSiS3hVSvnfqzMiMc28acpKavencYWY0+3h8sfs9RGLv8yVBozJdSunv82B
 +Qst/C0CTNmM/Ov6JFZVM8ZlQbLesj48OwXlwuZZBoOkGTmUKGAzbdMNgy+DGfLjGh07RPxR7
 xpnsyI7+dWYFInGZrHcTDn8xHkB1Vpn9+u8H8te/kIp9RPyBWEShfdCF5ng34pQN2q6nppwcB
 XzVV5BDVgHmAUBPC8EO5hA83n00L74qIQnZEYMI+PWlJkfwjRJxfDU0n8Gbmht4DTgaAglvbo
 VS1IFG1MyfzYrf+yNCGogSf2B4H/NjHRMiNs12Yw5dC3qQ90m8N+Eg23KAwylvH+h186vVGTD
 1EsLWYwntm0KQaNzHCA+qb1M/dnyvifgOnlxiHS0SLRUNA1dI5ezu8Jn4cVrfFkaO9II9IhuW
 e0YDT8w8VhasrhEhKlruMqfp+/k6m033Xi7LwptGK+pCQfImVbiM4uNFD2x+W3ZpGF/vSLSCe
 LWDLInyLSyfJWnwtTtGdVzl+49161ehREU8551g4dxQFqCDGv7YPXAwaPNFgv2pg0kkelGBfS
 9rk/Zic5VcqgBugwaY805o/boz4th0J5Ls1428vGEXktq+dARkmWqrvERxWHDCSXyLrl38jZG
 r3/+FKP/XKaLR0oln3ykEBOhAodepFpqOf7LMINGaQ8FNcY4pz1CrzirFJ8VHoG2YHruV9Wtj
 2TZzXhQVxp3CuhjzdEpkkCUDGygzLcsnTSJwWr/m/L0g95UkFVGKarb91JtNl7+sKL7yoJr6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289643>

One of this developer's primary tools to diagnose broken regression
tests is to run the test script using 'sh -x t... -i -v' to find out
*which* call *actually* demonstrates the symptom.

Hence it is pretty counterproductive if the test script behaves
differently when being run via 'sh -x', in particular when using
test_cmp or test_i18ncmp on redirected stderr.

So let's use test_i18ngrep (as suggested by Jonathan Nieder) instead of
test_cmp/test_i18ncmp to verify that stderr looks as expected.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1300-repo-config.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 8867ce1..dca27a3 100755
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
+	test_i18ngrep "bad numeric config value .1auto. for .aninvalid.unit. in file .git/config: invalid unit" actual
 '
 
 test_expect_success 'invalid stdin config' '
-	echo "fatal: bad config line 1 in standard input " >expect &&
 	echo "[broken" | test_must_fail git config --list --file - >output 2>&1 &&
-	test_cmp expect output
+	test_i18ngrep "bad config line 1 in standard input" output
 '
 
 cat > expect << EOF
-- 
2.7.4.windows.1
