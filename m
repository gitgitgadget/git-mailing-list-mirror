Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8D60207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 21:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934263AbcI2VAi (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:00:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53693 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934231AbcI2VAh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:00:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43CF6429F4;
        Thu, 29 Sep 2016 17:00:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=Xz1e
        03BNLWI9XzhbpShCxRNkp+s=; b=TiJSHN66vq9QEzANc73vGzRjSlsk3QjmmsXi
        pL2WNkFsdK/cXceDN+FRzcrR1+hly5u3JGipJQfZZpib5ospqR16kgrwjqAN6RLi
        GDWT/vbA8aBF2hgIxHbO1IeDHudOMxy4hWpV+xKn/PkJTIFddaHYSMGO8+0iPZtE
        keEyaLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=QDSPPh
        xf3B3dZY0HW7oo/13JSOopEzqUXJXg6ehYlpzgoE9YZ7A+cQrgPlh+beY7M46FKx
        JCHL2pXDNRMl2bJ2Hq340z4WKEI2siJgeT2/D+7uB2oSYUR/gRu5mmqD25IjtXeX
        rUhxToDsaREzAinpeNoLbbHl/fWtI5Ijva8PA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B8F4429F3;
        Thu, 29 Sep 2016 17:00:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5EA40429F2;
        Thu, 29 Sep 2016 17:00:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 7/9] t1300: be explicit in local configuration tests
Date:   Thu, 29 Sep 2016 14:00:12 -0700
Message-Id: <20160929210014.3874-8-gitster@pobox.com>
X-Mailer: git-send-email 2.10.0-589-g5adf4e1
In-Reply-To: <20160929210014.3874-1-gitster@pobox.com>
References: <20160929210014.3874-1-gitster@pobox.com>
X-Pobox-Relay-ID: C3BCF868-8687-11E6-9F4E-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many tests in this script prepare variable settings in the
repository local configuration and expects "--list" to report only
the ones from the repository local configuration.

This happened to work while we were running out tests under
GIT_CONFIG_NOSYSTEM and/or with an empty system-wide configuration
file, but as we will soon make our fake system-wide configuration
non-empty, prepare for that change by explicitly telling the command
to look only at "--local" configuration.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1300-repo-config.sh | 80 +++++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 2a15cd4d150d..8979212946c0 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -245,18 +245,18 @@ test_expect_success 'multivar' '
 '
 
 test_expect_success 'non-match' '
-	git config --get nextsection.nonewline !for
+	git config --local --get nextsection.nonewline !for
 '
 
 test_expect_success 'non-match value' '
 	echo wow >expect &&
-	git config --get nextsection.nonewline !for >actual &&
+	git config --local --get nextsection.nonewline !for >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'multi-valued get returns final one' '
 	echo "wow2 for me" >expect &&
-	git config --get nextsection.nonewline >actual &&
+	git config --local --get nextsection.nonewline >actual &&
 	test_cmp expect actual
 '
 
@@ -265,7 +265,7 @@ test_expect_success 'multi-valued get-all returns all' '
 	wow
 	wow2 for me
 	EOF
-	git config --get-all nextsection.nonewline >actual &&
+	git config --local --get-all nextsection.nonewline >actual &&
 	test_cmp expect actual
 '
 
@@ -341,7 +341,7 @@ version.1.2.3eX.alpha=beta
 EOF
 
 test_expect_success 'working --list' '
-	git config --list > output &&
+	git config --local --list > output &&
 	test_cmp expect output
 '
 
@@ -361,7 +361,7 @@ version.1.2.3eX.alpha
 EOF
 
 test_expect_success '--name-only --list' '
-	git config --name-only --list >output &&
+	git config --local --name-only --list >output &&
 	test_cmp expect output
 '
 
@@ -371,7 +371,7 @@ nextsection.nonewline wow2 for me
 EOF
 
 test_expect_success '--get-regexp' '
-	git config --get-regexp in >output &&
+	git config --local --get-regexp in >output &&
 	test_cmp expect output
 '
 
@@ -381,7 +381,7 @@ nextsection.nonewline
 EOF
 
 test_expect_success '--name-only --get-regexp' '
-	git config --name-only --get-regexp in >output &&
+	git config --local --name-only --get-regexp in >output &&
 	test_cmp expect output
 '
 
@@ -392,7 +392,7 @@ EOF
 
 test_expect_success '--add' '
 	git config --add nextsection.nonewline "wow4 for you" &&
-	git config --get-all nextsection.nonewline > output &&
+	git config --local --get-all nextsection.nonewline > output &&
 	test_cmp expect output
 '
 
@@ -404,45 +404,45 @@ cat > .git/config << EOF
 EOF
 
 test_expect_success 'get variable with no value' '
-	git config --get novalue.variable ^$
+	git config --local --get novalue.variable ^$
 '
 
 test_expect_success 'get variable with empty value' '
-	git config --get emptyvalue.variable ^$
+	git config --local --get emptyvalue.variable ^$
 '
 
 echo novalue.variable > expect
 
 test_expect_success 'get-regexp variable with no value' '
-	git config --get-regexp novalue > output &&
+	git config --local --get-regexp novalue > output &&
 	test_cmp expect output
 '
 
 echo 'novalue.variable true' > expect
 
 test_expect_success 'get-regexp --bool variable with no value' '
-	git config --bool --get-regexp novalue > output &&
+	git config --local --bool --get-regexp novalue > output &&
 	test_cmp expect output
 '
 
 echo 'emptyvalue.variable ' > expect
 
 test_expect_success 'get-regexp variable with empty value' '
-	git config --get-regexp emptyvalue > output &&
+	git config --local --get-regexp emptyvalue > output &&
 	test_cmp expect output
 '
 
 echo true > expect
 
 test_expect_success 'get bool variable with no value' '
-	git config --bool novalue.variable > output &&
+	git config --local --bool novalue.variable > output &&
 	test_cmp expect output
 '
 
 echo false > expect
 
 test_expect_success 'get bool variable with empty value' '
-	git config --bool emptyvalue.variable > output &&
+	git config --local --bool emptyvalue.variable > output &&
 	test_cmp expect output
 '
 
@@ -683,15 +683,15 @@ test_expect_success numbers '
 	git config mega.ton 1m &&
 	echo 1024 >expect &&
 	echo 1048576 >>expect &&
-	git config --int --get kilo.gram >actual &&
-	git config --int --get mega.ton >>actual &&
+	git config --local --int --get kilo.gram >actual &&
+	git config --local --int --get mega.ton >>actual &&
 	test_cmp expect actual
 '
 
 test_expect_success '--int is at least 64 bits' '
 	git config giga.watts 121g &&
 	echo 129922760704 >expect &&
-	git config --int --get giga.watts >actual &&
+	git config --local --int --get giga.watts >actual &&
 	test_cmp expect actual
 '
 
@@ -700,7 +700,7 @@ test_expect_success 'invalid unit' '
 	echo 1auto >expect &&
 	git config aninvalid.unit >actual &&
 	test_cmp expect actual &&
-	test_must_fail git config --int --get aninvalid.unit 2>actual &&
+	test_must_fail git config --local --int --get aninvalid.unit 2>actual &&
 	test_i18ngrep "bad numeric config value .1auto. for .aninvalid.unit. in file .git/config: invalid unit" actual
 '
 
@@ -733,15 +733,15 @@ test_expect_success bool '
 	rm -f result &&
 	for i in 1 2 3 4
 	do
-	    git config --bool --get bool.true$i >>result
-	    git config --bool --get bool.false$i >>result
+	    git config --local --bool --get bool.true$i >>result
+	    git config --local --bool --get bool.false$i >>result
         done &&
 	test_cmp expect result'
 
 test_expect_success 'invalid bool (--get)' '
 
 	git config bool.nobool foobar &&
-	test_must_fail git config --bool --get bool.nobool'
+	test_must_fail git config --local --bool --get bool.nobool'
 
 test_expect_success 'invalid bool (set)' '
 
@@ -808,12 +808,12 @@ test_expect_success 'get --bool-or-int' '
 	-1
 	EOF
 	{
-		git config --bool-or-int bool.true1 &&
-		git config --bool-or-int bool.true2 &&
-		git config --bool-or-int bool.false &&
-		git config --bool-or-int int.int1 &&
-		git config --bool-or-int int.int2 &&
-		git config --bool-or-int int.int3
+		git config --local --bool-or-int bool.true1 &&
+		git config --local --bool-or-int bool.true2 &&
+		git config --local --bool-or-int bool.false &&
+		git config --local --bool-or-int int.int1 &&
+		git config --local --bool-or-int int.int2 &&
+		git config --local --bool-or-int int.int3
 	} >actual &&
 	test_cmp expect actual
 '
@@ -868,9 +868,9 @@ foo~
 EOF
 
 test_expect_success HOMEVAR 'get --path' '
-	git config --get --path path.home > result &&
-	git config --get --path path.normal >> result &&
-	git config --get --path path.trailingtilde >> result &&
+	git config --local --get --path path.home > result &&
+	git config --local --get --path path.normal >> result &&
+	git config --local --get --path path.trailingtilde >> result &&
 	test_cmp expect result
 '
 
@@ -882,10 +882,10 @@ EOF
 test_expect_success !MINGW 'get --path copes with unset $HOME' '
 	(
 		unset HOME;
-		test_must_fail git config --get --path path.home \
+		test_must_fail git config --local --get --path path.home \
 			>result 2>msg &&
-		git config --get --path path.normal >>result &&
-		git config --get --path path.trailingtilde >>result
+		git config --local --get --path path.normal >>result &&
+		git config --local --get --path path.trailingtilde >>result
 	) &&
 	test_i18ngrep "[Ff]ailed to expand.*~/" msg &&
 	test_cmp expect result
@@ -893,7 +893,7 @@ test_expect_success !MINGW 'get --path copes with unset $HOME' '
 
 test_expect_success 'get --path barfs on boolean variable' '
 	echo "[path]bool" >.git/config &&
-	test_must_fail git config --get --path path.bool
+	test_must_fail git config --local --get --path path.bool
 '
 
 cat > expect << EOF
@@ -936,7 +936,7 @@ section.quotecont=cont;inued
 EOF
 
 test_expect_success 'value continued on next line' '
-	git config --list > result &&
+	git config --local --list > result &&
 	test_cmp expect result
 '
 
@@ -960,14 +960,14 @@ Qsection.sub=section.val4
 Qsection.sub=section.val5Q
 EOF
 test_expect_success '--null --list' '
-	git config --null --list >result.raw &&
+	git config --local --null --list >result.raw &&
 	nul_to_q <result.raw >result &&
 	echo >>result &&
 	test_cmp expect result
 '
 
 test_expect_success '--null --get-regexp' '
-	git config --null --get-regexp "val[0-9]" >result.raw &&
+	git config --local --null --get-regexp "val[0-9]" >result.raw &&
 	nul_to_q <result.raw >result &&
 	echo >>result &&
 	test_cmp expect result
@@ -1127,7 +1127,7 @@ test_expect_success 'barf on syntax error' '
 	[section]
 	key garbage
 	EOF
-	test_must_fail git config --get section.key >actual 2>error &&
+	test_must_fail git config --local --get section.key >actual 2>error &&
 	test_i18ngrep " line 3 " error
 '
 
-- 
2.10.0-589-g5adf4e1

