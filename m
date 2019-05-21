Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 973841F462
	for <e@80x24.org>; Tue, 21 May 2019 11:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfEULL2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 07:11:28 -0400
Received: from elephants.elehost.com ([216.66.27.132]:49061 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfEULL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 07:11:28 -0400
X-Greylist: delayed 1602 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 May 2019 07:11:28 EDT
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x4LAig2L057346
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Tue, 21 May 2019 06:44:42 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [Breakage] 2.22.0-rc1 - t0211-trace2-perf.sh
Date:   Tue, 21 May 2019 06:44:36 -0400
Message-ID: <019e01d50fc2$324bd400$96e37c00$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdUPwX5hnpBW1EOeQi+B+3SL0q/RZw==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

On the NonStop platform, the entire test for t0211-trace2-perf.sh does not
work. The first case, in verbose, reports:

We get errors when the script is run:

Use of uninitialized value within @tokens in pattern match (m//) at
t0211/scrub_perf.perl line 29, <> line 1.

Initialized empty Git repository in /home/git/git/t/trash
directory.t0211-trace2-perf/.git/
expecting success:
        test_when_finished "rm trace.perf actual expect" &&
        GIT_TR2_PERF="$(pwd)/trace.perf" test-tool trace2 001return 0 &&
        perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
        cat >expect <<-EOF &&
                d0|main|version|||||$V
                d0|main|start||_T_ABS_|||_EXE_ trace2 001return 0
                d0|main|cmd_name|||||trace2 (trace2)
                d0|main|exit||_T_ABS_|||code:0
                d0|main|atexit||_T_ABS_|||code:0
        EOF
        test_cmp expect actual

--- expect      2019-05-21 10:38:47 +0000
+++ actual      2019-05-21 10:38:47 +0000
@@ -1,5 +1,5 @@
-d0|main|version|||||2.22.0.rc1
-d0|main|start||_T_ABS_|||_EXE_ trace2 001return 0
-d0|main|cmd_name|||||trace2 (trace2)
-d0|main|exit||_T_ABS_|||code:0
-d0|main|atexit||_T_ABS_|||code:0
+d0|th01:unknown|version|||||2.22.0.rc1
+d0|th02:unknown|start||_T_ABS_|||_EXE_ trace2 001return 0
+d0|th03:unknown|cmd_name|||||trace2 (trace2)
+d0|th04:unknown|exit||_T_ABS_|||code:0
+d0|th06:unknown|atexit||_T_ABS_|||code:0

Our perl is v5.24.0 and this cannot be upgraded.

Thoughts?

Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



