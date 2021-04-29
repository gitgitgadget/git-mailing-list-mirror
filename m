Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4384C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 20:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65949613B3
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 20:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbhD2UQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 16:16:09 -0400
Received: from avasout04.plus.net ([212.159.14.19]:54011 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbhD2UQG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 16:16:06 -0400
Received: from [10.0.2.15] ([217.32.115.138])
        by smtp with ESMTPA
        id cD47lMTatOQhvcD48laxBB; Thu, 29 Apr 2021 21:15:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1619727317; bh=5HvDexHabQsWLhVeIxd+dVOTyF4v/gc59j0A4zT339M=;
        h=To:Cc:From:Subject:Date;
        b=f77FxuNFzP+NcolN6J2M1xcCh/sv0REdiqIdtHT54jvHWra+tsQXJfBg+tIFWC2wK
         LYSR7sKJXRl1ixH1zDHbBt1JY0W0pJcDOiCpuEntajd3uuGXcz/iCiIqo8jGzF3+E0
         cZ1LC1N5hUVhSgkZqpEoqQ2qZ5b6NL1PfucZTP/NMlJswTtzEeilvWJp+0EyVcQvbj
         +RRVqv24PZKMFR5JNilxL9sxIC4XObyFvmii+7C6zckGpwHllcFGAE71zO4ZiTu1ZJ
         Mxxa2P338JfruxApEFOzJaWEPyS9Mb5JB94esd+0Fp+bsD4EzrPQrqFtb2h2opaymJ
         eCHSKx+5W0okA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=IvmFjI3g c=1 sm=1 tr=0
 a=T9WNts+jH3PhiGdS1gtV5Q==:117 a=T9WNts+jH3PhiGdS1gtV5Q==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EBOSESyhAAAA:8
 a=PBMBaPzqN09XOE2X9X4A:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=yJM6EZoI5SlJf8ks9Ge_:22 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Trygve Aaberge <trygveaa@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2] bisect--helper: use BISECT_TERMS in 'bisect skip' command
Message-ID: <fa098676-a56c-cbb9-28cb-e57d4a8a5d77@ramsayjones.plus.com>
Date:   Thu, 29 Apr 2021 21:15:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIqvh41kn/NQ972SotD56yJFloIUTGtOb/iCdgqoBJYnBqbpvy+0zaC/j44s2rDC+9Fsd/As/rWhTl7WVNTw+8WnR9UVRev5us8JmcKg9UUMW0xAmQ3e
 +fxC8Q0vbAPUvw9hjNfQtZeK4T8YYHh/b90MrKmgJ5T+PrGEAND18Haj8n/z4YzWz9C1Ojzmxvt+pw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Commit e4c7b33747 ("bisect--helper: reimplement `bisect_skip` shell
function in C", 2021-02-03), as part of the shell-to-C conversion,
forgot to read the 'terms' file (.git/BISECT_TERMS) during the new
'bisect skip' command implementation. As a result, the 'bisect skip'
command will use the default 'bad'/'good' terms. If the bisection
terms have been set to non-default values (for example by the
'bisect start' command), then the 'bisect skip' command will fail.

In order to correct this problem, we insert a call to the get_terms()
function, which reads the non-default terms from that file (if set),
in the '--bisect-skip' command implementation of 'bisect--helper'.

Also, add a test[1] to protect against potential future regression.

[1] https://lore.kernel.org/git/xmqqim45h585.fsf@gitster.g/T/#m207791568054b0f8cf1a3942878ea36293273c7d

Reported-by: Trygve Aaberge <trygveaa@gmail.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

This v2 patch was also created directly on top of commit e4c7b33747 and,
once again, applied to current 'master' (@311531c9de). (I was a little
surprised that it applied clean, given the changes to t6030-*.sh in the
meantime! ;).

I didn't bother with the range-diff[*], since it wasn't very illuminating
(just the addition of a few trailing lines in the commit message and the
addition of the test).

I don't know if I did the 'Co-authorship' bit correctly; I nearly used an
'Co-authored-by:' rather than an 'Signed-off-by:' for Bagas, but I seem to
remember that caused some push-back recently. Anyway, if I messed that up,
please just modify however you see fit.

ATB,
Ramsay Jones

[*] Once I got it to work, that is; for some reason, I was trying smaller
creation-factor values rather than larger! ;-)

 builtin/bisect--helper.c    |  1 +
 t/t6030-bisect-porcelain.sh | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 7ad9b4d55b..49c07f0710 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1129,6 +1129,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		break;
 	case BISECT_SKIP:
 		set_terms(&terms, "bad", "good");
+		get_terms(&terms);
 		res = bisect_skip(&terms, argv, argc);
 		break;
 	default:
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index aa226381be..b707296ae2 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -919,6 +919,17 @@ test_expect_success 'bisect start takes options and revs in any order' '
 	test_cmp expected actual
 '
 
+# Bisect is started with --term-new and --term-old arguments,
+# then skip. The HEAD should be changed.
+test_expect_success 'bisect skip works with --term*' '
+	git bisect reset &&
+	git bisect start --term-new=fixed --term-old=unfixed HEAD $HASH1 &&
+	hash_skipped_from=$(git rev-parse --verify HEAD) &&
+	git bisect skip &&
+	hash_skipped_to=$(git rev-parse --verify HEAD) &&
+	test "$hash_skipped_from" != "$hash_skipped_to"
+'
+
 test_expect_success 'git bisect reset cleans bisection state properly' '
 	git bisect reset &&
 	git bisect start &&
-- 
2.31.0
