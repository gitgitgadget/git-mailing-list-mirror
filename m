Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94A221F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 14:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757422AbcJNOPD (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 10:15:03 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:52106
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757309AbcJNOOX (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Oct 2016 10:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1476454456;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=O5Au8sjVlh2//wMkJT3oQyhBYlSrpk742//vWDlbYwY=;
        b=B6yYalVXypDYYXXC37wgAvRBkHhe/Vl3asP89C7L35BaJ86NHih0wCW5qqxHR+dT
        X8Q3zZYNpF3cKCpPvKJq/CsDgrn3lCafFL+JiFBvgHR69sqamOiTKkL3n9wHgXlpo4x
        EiMDLkiceEYqhE+wSWZgxkHiS4yBY6z0Vvd3RkgA=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020157c38b1adc-d5fa6b9a-ce13-4ee9-874e-e45fac99fba6-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v15 14/27] t6030: no cleanup with bad merge base
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Oct 2016 14:14:16 +0000
X-SES-Outgoing: 2016.10.14-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The bisection cleanup should be performed with bad merge base so that
the user can return to its original position with `git bisect reset`.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index e62e2a8..8ac77ee 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -911,4 +911,11 @@ test_expect_success 'git bisect reset cleans bisection state properly' '
 	test_path_is_missing "$GIT_DIR/BISECT_START"
 '
 
+test_expect_success 'check whether bisection cleanup is not done with bad merges' '
+	git bisect start $HASH7 $SIDE_HASH7 &&
+	test_expect_failure git bisect bad >out 2>out &&
+	test_i18ngrep "The merge base" out &&
+	test -e .git/BISECT_START
+'
+
 test_done

--
https://github.com/git/git/pull/287
