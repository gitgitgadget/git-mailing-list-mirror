Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1F65202A3
	for <e@80x24.org>; Wed, 18 Oct 2017 19:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbdJRTzd (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 15:55:33 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:51182
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751360AbdJRTzd (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 18 Oct 2017 15:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1508356531;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=/oALCGcvv44OhiJekXgmb1eDbWPiKji+h6ucvzTv8xw=;
        b=M/vNHRWVG0+MFRTM3zPGvRi/7fvc1DggHEBL9U71bksQtoipiSCMAmnRt0tnfuGC
        Qx3Qr+EPMtiAcnN6t69xxbMfjFl46RnU8cHD/pD66YisDy6tAI+ogJorgDCFG5tyjZP
        RJkxFfWWMBPGNNDtxdC2Gk7tqr/o9+hNiBecEREM=
From:   Guillaume Castagnino <casta+github@xwing.info>
To:     git@vger.kernel.org
Message-ID: <0102015f310e24b9-b96378f3-a029-4110-80dd-e454522e2cb7-000000@eu-west-1.amazonses.com>
Subject: [PATCH] use filetest pragma to work with ACL
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Oct 2017 19:55:31 +0000
X-SES-Outgoing: 2017.10.18-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Guillaume Castagnino <casta@xwing.info>

as stated in comment in https://github.com/git/git/commit/46a13857fc036b54ac2ddd0a218e5cc171aa7bd9#diff-00703a794a540acf45e225abd6aeda3b the referenced commit is broken when using ACL and not basic UNIX rights.
this commit handle ACL too
---
 gitweb/gitweb.perl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9208f42ed1753..0ee7f304ce2b1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3072,6 +3072,7 @@ sub git_get_projects_list {
 				# only directories can be git repositories
 				return unless (-d $_);
 				# need search permission
+				use filetest 'access';
 				return unless (-x $_);
 				# don't traverse too deep (Find is super slow on os x)
 				# $project_maxdepth excludes depth of $projectroot

--
https://github.com/git/git/pull/416
