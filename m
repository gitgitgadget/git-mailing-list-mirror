Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8805720281
	for <e@80x24.org>; Fri, 15 Sep 2017 19:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbdIOTV4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 15:21:56 -0400
Received: from mail-dm3nam03on0117.outbound.protection.outlook.com ([104.47.41.117]:20724
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751810AbdIOTVo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 15:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rNfBP2wZSqNb7Xv4Ah7hedWxnaesn9FmxR/gu8P5OFs=;
 b=Dfdylw3azdqb8Zops0gTioTzfQ8DL6JJQOYP8p70hwjH1SwlMpj/rysM/bNN39CdeTykhotTkIpdyVG5wJMBwy0A5Ug3x+FTNrDdwuK5u2gjx02KnOLTk4F8Yz5wxfwPbr0iTVOKWCaLS8YB3fob5IKScBuYjTg1HRB0hLTsuis=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Fri, 15 Sep 2017 19:21:37 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v6 11/12] fsmonitor: add a sample integration script for Watchman
Date:   Fri, 15 Sep 2017 15:20:42 -0400
Message-Id: <20170915192043.4516-12-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20170915192043.4516-1-benpeart@microsoft.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR2201CA0010.namprd22.prod.outlook.com (10.174.119.23)
 To CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e581c8b3-0133-4c55-1c04-08d4fc6efd2f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR21MB0469;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;3:f8pAzwZP7ly2seyHXnBoTA38l4iCTV866wrL34yJv16TXpOAyrl+cjaMG2C3Tv0a8bnP+cGLABK30rc6D/77M1gEpbCUVX2TJUPfu6NS9x57RVHtAQPqui5rJxWxx+OMT4ZqlVdymqIsXLhm2ZIPph0nc+Oo3iUcXL4Z3So45BkagAmPd9l4AEmjUYTYTfcTbOqKs9eRKbVJKYpwCuDVKNh1gMRYiSAwCuIzq3mcu9T+MaVlQjOepyXuikccBf7d;25:GDw9Vfz8joWHIAqLjp2fNRRsNI34fnUF8Y5S0ft+zz+zyStEOfng85GglZehGSfK9288ZigWCSiYd3FryjWPdfYHtoxcKh0AmA9wy3V6oQ4q1QPzi+FhytCKJmTtoeDvC80l6YIrPKN08fJHbb+3r+xQFjE8MLCLLkS6K5gLtuExi8Sa1a2yxeIKNjdQxpH3gm0EHZoDxZfUOovl1v1ngYSQ9H5AtgIyEaZfj7llps6S0lWD29cun2lqVLTT6xyHROavZqvdZkR5acYnVsNttp+92elbwNfQgenYPLvPXStBtyojP9AV40CzW3b8BQbcMwXymlDocC1VFBXxAyAuVA==;31:QK1h/eGsf7VT4IdT/JsRJHJN0ISxeEypLU5EFzoJOysB9rgGHx1FSxKQYthzKHiYlXWmAjYflgh3h/R3yq9p4r23bGMjCRr7IlZt8TgpYkMTUfLbnHEM/W88PQnni4UFbs3bCasymbQlHvvXJ3vw9DwoVEL8WAwU+4PqJO/IvQPhSxa4WPhXktanSRWbg1zSnnScpdYo9NZU2VyC1IdjGuZXiKCpTPtd5P9bV0pGg9c=
X-MS-TrafficTypeDiagnostic: CY4PR21MB0469:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;20:WbdYzb+7j9utiMSea445rJZXWkYtHVgpvoBWvluQsxZ1EbL86m3tj4m8mwfuA6U7GlVNLzW2Feh/BYm62NM5FSJfZBOApV31M4affb8tuYX+KfsSgDOZi0lhvmdYSNmT7c8418Cm1julVyORZNyCo0EmXW03DiM3rw1WjmaWMVUi795ryNHKl997PdyFUV5AfPyU1HG5d2Jhrr3gYX0jy/Sce8jJBhhcKyfwF+VRaDTVIzQJah0vP3ozEf2JuXVPEQ8s7Lp8FHUqom8v9itei8gxgWbT5wkCktCwzCVa4d7BZ2k1duYup+j+6/sMqiECtGGyntxL/wXyZIm6wp7j8aTGiPXfoJ6N1eA43Mx5bgww8ogSpKizz5zGZLHJkoBp5Ia4dZnVEP1IxraDznVphhnjm4bLeVJ9MYm14ptMDbgH2GE4zPgeP4WjzDK0+RvnC6mXDi6wJZG2K2xrP2jzCS7lOXWDSZhXFrOyCZ+A3/FZktX5d006+cPxK0MqneUL;4:NkL4D1xtx9VUF5bNCfk+0QM0bChbZrhs7BEJ6+JCQREiZyL8EPR2lQvbcE5e++/yPo3g3VW0vQrwLCHS4ZTYqxbOy3pp//jOABLFqvqPtmmv1RFZhLksTfYPsalb81Qk+syflwsWF/mAsMrKO14wRUSVDFqhAPcpYnP2cKkSds8Jx7KaT9Fe1cG8zxJbMnv1PgjXCz+mOiFgIznk36KyI8xIF6PM9CXBkEeBsl7GTLjpmbg+xGExV8o/h1Vs6nZmOqkZZTxoKFM3rVOM2mNGGFqHLtTp8I0IHu+Avxnd84jt1keag9yliyt8Wki6DEjEg9yZB4fpdKMSJU48yC1+Dw==
X-Exchange-Antispam-Report-Test: UriScan:(26323138287068)(89211679590171);
X-Microsoft-Antispam-PRVS: <CY4PR21MB0469595BD56C25204ED69C9DF46C0@CY4PR21MB0469.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123560025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0469;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(101416001)(4326008)(39060400002)(110136004)(34206002)(8656003)(25786009)(97736004)(2906002)(2870700001)(2351001)(50986999)(76176999)(22452003)(50466002)(2421001)(33646002)(68736007)(36756003)(105586002)(50226002)(23676002)(2361001)(478600001)(106356001)(16526017)(1511001)(316002)(47776003)(10090500001)(5660300001)(6666003)(6506006)(2950100002)(72206003)(66066001)(966005)(6306002)(6486002)(6512007)(81156014)(81166006)(6116002)(7736002)(305945005)(8936002)(8676002)(3846002)(53936002)(10290500003)(1076002)(86612001)(189998001)(8666007)(37006003)(22906009)(171213001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjIxTUIwNDY5OzIzOnRyRmExSTJhbFlCYWYrS3ZMNHFmS1pxbElT?=
 =?utf-8?B?cWc3WlBzNngwaXV3bHREM2p2YUNFU0dsS3F0T1BnZUNyMDR6dTNFK2wvU2o1?=
 =?utf-8?B?YnVVQ2xLcm5hTEsrZVg1VTZ3WWJ6aklpOTJFNndVV2U1b2RJQzB5akVLWmda?=
 =?utf-8?B?aTViVGNvU2E0RWdXc0g4MFhCVmdWYmdsNFZvMWJzUFg4aGNPQW1WZFVSR0J6?=
 =?utf-8?B?VDBJSlpFV2l0eFplTEp3N1VhVlZhdHA2bXB4K0E2M1YreW9Lb25DelE0Tkps?=
 =?utf-8?B?WVZ0a1NEdCtpNnFUdlpldXlSUUdET2h1Uy9NbzdEUlVtUXVPZ0ZoS1hGNDVM?=
 =?utf-8?B?UHlEMWdCTXIydlpqUG43WU55TDBuU0k4MnlpaTR3Q1ExR2VUQStNbVcwdk9y?=
 =?utf-8?B?eVNnMWVwWmdaTngxeXNOMW10UmxlZEpZQ3BMaG1WTDN6TWRVZHJvTFI3YmMr?=
 =?utf-8?B?K2VZV0pUOGJtREV1QUZBcDdKaUlxc2htampUTlhWemhWMFhhVGhCc1MvT2kz?=
 =?utf-8?B?SDVUQTAyL1NWZUJ5TlZTZ0RTWS90eHg3UDNZd3dERjJnOUh2aDk4Q3R5MGtS?=
 =?utf-8?B?d0d5OXRNdStEWHVRcXNRclRGL20vTEZUVXMvanBMQ0tNcVlBQ24wUzMrc3BT?=
 =?utf-8?B?R0E4bnFXTEw5TWlBcHg2elRrMzN5a0M5aDdDM2hNUkcyNnlTR3ZWdi9mQURy?=
 =?utf-8?B?ZWt0Z09kZVpZVCtNVHBYaUpBSWNBcFlnTDRPeHZDcHVYQjRCNWpsRjNxV0Nq?=
 =?utf-8?B?dGE2OUpjVlIvclcxR2s2Ny82cVJQVGorbVpXM0tEOFFpQjhhc0h0SHJ4VHN1?=
 =?utf-8?B?Z21hcU9FcHZ1K1FmRDZhMlVaaWJHRHErSkk4SlJWWHY0UXkvSDhSdkN0bHd3?=
 =?utf-8?B?cGFoZGJ2Rm9YbVhEZ1lLSnpsdXpXY01hOWZQU0hzT2hzYW1qRTl3dXpadmJK?=
 =?utf-8?B?NGVNMDlHcEFEcmNtOVJ3OHZucHVlQTZLUnlkNklGOWdsRklzZk5RSk9vekNx?=
 =?utf-8?B?dXVjV0FxbEgzbEdZeVBlREVtY2FFN1ZSeVVCa0lMdmlTelI3WU1CRkFDMmFY?=
 =?utf-8?B?a256d2dKczB6cCtLSUVpamlra0dBOGRJaGU3Rk5zYllNc1VvUFNGSkxPcmsr?=
 =?utf-8?B?V1ZVRTVCMXZqRUI3cjNmc0xQclByRlBNaVE3M244QlhjMmNNN2ZZdmswaHp6?=
 =?utf-8?B?OWdwN2FoTTkxWGdDbXpST1R6S0xlQVZOVVJ3RG1YRjFEbURERWovbTZSUkNQ?=
 =?utf-8?B?cUlmZVRHbll4bHRHRW1aSHlOVGR6S21LYXdNb1piOFlXdG5jYzFwOFVFY2tP?=
 =?utf-8?B?a25BdlJNZ3JyK2JSTHNBT2c2TURtZzBIQzI1UDNoMFp5ZkhCbk4yLzk4TUFn?=
 =?utf-8?B?QitZbDZENHMyUWhnNVpjdHljSW1OdGNhY2ZIZ0JNNzN5d1FwMUdoSjBoVHdS?=
 =?utf-8?B?Mi9lcnh4aE51QTk1K05jV0xEZHp6WEplbkRpSms5UHRueVJONm03aW5DbFFG?=
 =?utf-8?B?WVo4cFpibmwyd0lMK0d6Ly9qRCtLSVVwTk9mTmc2c1o4dDhzZEZsY1d3akxE?=
 =?utf-8?B?blRFa1FoR2pObVZDeEJSTmdlWS9weHo3dUIxdUwvMCtNbDdWbzhORHZlZUNC?=
 =?utf-8?B?bXhzSlFyZnhZTmJuMHZZWGxIdkJOMEZuN2NhZmh6RHlyK1U0LzNzalRuYjlF?=
 =?utf-8?B?Qkk0SXFLMFZHVjBUU0JKb3hXSXZCNmQyS3Nlb1MzRXVlTThlUHEvek5HbVpG?=
 =?utf-8?B?SU1ZNkhIam41ZWtLa05ZSHRqbVU1aDZUcTFZN0dsMWc0MmJBT28zVU1ENTZt?=
 =?utf-8?B?Ti9CN29ZWnZOb0VwZWxXMklYc0F6YVk0NWlQRksrcFZtaDMxQk85SWlPaEVw?=
 =?utf-8?B?dFlneG5GeEpnbFRHVzRkc2M1b0I5L1ptR1NPTzV1N094Zk8wdVlxL1VqN2M1?=
 =?utf-8?B?N0xrVDErS1lLNW5jL202YVQ0bS9CM0dGZG5xQ3lUYjg1cUYyQlVqRVcreWVX?=
 =?utf-8?B?eThxaDYvQUNFOW9JMXdSVkhoS09LcmFoalM4Zz09?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;6:NpPpGgC7jWPnGPL1FZ8nKReFQDXLwylizrqS72sNb0xVNRgkxbtR7boKWEKCH0aBaDD8mD9L3fDJYNLkNrHHb/958ieOKntFQnOfemGtWkNfCjDW9XU9poCclchvtUv8VBjxBmmtDvMP1TlEMGxK/EmwlvvCwx270ma6lKXyzGayRVXJBliLof0E86LQ8rjT622zJ7rkvbiJb7bybXxvfeCaXebAwa2xemWzLwJMRPVE0pivfoT+C/KYXgGC55w59yX0j0DYUd8x+EFX1SOlNgprO+7grLxpWTdTtNZLxtIJWCOIhNaGTVw/uWLjaIoI5MpRw16KEuO9alqm2ut0NA==;5:Ebqvox/ZQJ5O/g4Uzwt9UmIvm196TzB6XrG6MIVDA9BZaYWPdbnHFewodnespR51Np7sugpyHWXwpjcs1IcAoyYntTvQXeriUEE7QxjpMTcGAcg5eI+19rzO8uqyC6yR3yUWtm/9bAkGHpdagngvLA==;24:baFKZKOl8+qwsYJsX8+U00Ua9mNe/81y77ZBgN0w9077N4KfhSgI/NAIc4Al+HF5tICHbdrw+9/kcKyHuIQUy/zDN4iib5A0Fcd10UzS4xE=;7:7zpHLuJvQzlwzKzN1ElR+MfFPqZfJe0nVwBwUhcLjP6FAF/WKBMSSpO+sjbW0UWaEI4Ul3feYc3c6LOMKPQYA1Q97akXXNfnjf3jZHT5Vtxm3TxG8Hu30wLlzwQLaxG/uYHkKbrDSd546dNtikS06DrFRTwY2nHI9Oxb5/kdHyj/fKbECejZYxA0MvujOvZuuzjaf3uiJCX4RhvUVV4xc1CTl/454pft3St2Kzbt5X4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 19:21:37.3532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This script integrates the new fsmonitor capabilities of git with the
cross platform Watchman file watching service. To use the script:

Download and install Watchman from https://facebook.github.io/watchman/.
Rename the sample integration hook from fsmonitor-watchman.sample to
fsmonitor-watchman. Configure git to use the extension:

git config core.fsmonitor .git/hooks/fsmonitor-watchman

Optionally turn on the untracked cache for optimal performance.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 templates/hooks--fsmonitor-watchman.sample | 119 +++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100755 templates/hooks--fsmonitor-watchman.sample

diff --git a/templates/hooks--fsmonitor-watchman.sample b/templates/hooks--fsmonitor-watchman.sample
new file mode 100755
index 0000000000..2779d7edf3
--- /dev/null
+++ b/templates/hooks--fsmonitor-watchman.sample
@@ -0,0 +1,119 @@
+#!/usr/bin/perl
+
+use strict;
+use warnings;
+use IPC::Open2;
+
+# An example hook script to integrate Watchman
+# (https://facebook.github.io/watchman/) with git to speed up detecting
+# new and modified files.
+#
+# The hook is passed a version (currently 1) and a time in nanoseconds
+# formatted as a string and outputs to stdout all files that have been
+# modified since the given time. Paths must be relative to the root of
+# the working tree and separated by a single NUL.
+#
+# To enable this hook, rename this file to "query-watchman" and set
+# 'git config core.fsmonitor .git/hooks/query-watchman'
+#
+my ($version, $time) = @ARGV;
+
+# Check the hook interface version
+
+if ($version == 1) {
+	# convert nanoseconds to seconds
+	$time = int $time / 1000000000;
+} else {
+	die "Unsupported query-fsmonitor hook version '$version'.\n" .
+	    "Falling back to scanning...\n";
+}
+
+# Convert unix style paths to escaped Windows style paths when running
+# in Windows command prompt
+
+my $system = `uname -s`;
+$system =~ s/[\r\n]+//g;
+my $git_work_tree;
+
+if ($system =~ m/^MSYS_NT/) {
+	$git_work_tree = `cygpath -aw "\$PWD"`;
+	$git_work_tree =~ s/[\r\n]+//g;
+	$git_work_tree =~ s,\\,/,g;
+} else {
+	$git_work_tree = $ENV{'PWD'};
+}
+
+my $retry = 1;
+
+launch_watchman();
+
+sub launch_watchman {
+
+	# Set input record separator
+	local $/ = 0666;
+
+	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j')
+	    or die "open2() failed: $!\n" .
+	    "Falling back to scanning...\n";
+
+	# In the query expression below we're asking for names of files that
+	# changed since $time but were not transient (ie created after
+	# $time but no longer exist).
+	#
+	# To accomplish this, we're using the "since" generator to use the
+	# recency index to select candidate nodes and "fields" to limit the
+	# output to file names only. Then we're using the "expression" term to
+	# further constrain the results.
+	#
+	# The category of transient files that we want to ignore will have a
+	# creation clock (cclock) newer than $time_t value and will also not
+	# currently exist.
+
+	print CHLD_IN "[\"query\", \"$git_work_tree\", { \
+	\"since\": $time, \
+	\"fields\": [\"name\"], \
+	\"expression\": [\"not\", [\"allof\", [\"since\", $time, \"cclock\"], [\"not\", \"exists\"]]] \
+	}]";
+
+	my $response = <CHLD_OUT>;
+
+	die "Watchman: command returned no output.\n" .
+	    "Falling back to scanning...\n" if $response eq "";
+	die "Watchman: command returned invalid output: $response\n" .
+	    "Falling back to scanning...\n" unless $response =~ /^\{/;
+
+	my $json_pkg;
+	eval {
+		require JSON::XS;
+		$json_pkg = "JSON::XS";
+		1;
+	} or do {
+		require JSON::PP;
+		$json_pkg = "JSON::PP";
+	};
+
+	my $o = $json_pkg->new->utf8->decode($response);
+
+	if ($retry > 0 and $o->{error} and $o->{error} =~ m/unable to resolve root .* directory (.*) is not watched/) {
+		print STDERR "Adding '$git_work_tree' to watchman's watch list.\n";
+		$retry--;
+		qx/watchman watch "$git_work_tree"/;
+		die "Failed to make watchman watch '$git_work_tree'.\n" .
+		    "Falling back to scanning...\n" if $? != 0;
+
+		# Watchman will always return all files on the first query so
+		# return the fast "everything is dirty" flag to git and do the
+		# Watchman query just to get it over with now so we won't pay
+		# the cost in git to look up each individual file.
+		print "*\0";
+		eval { launch_watchman() };
+		exit 0;
+	}
+
+	die "Watchman: $o->{error}.\n" .
+	    "Falling back to scanning...\n" if $o->{error};
+
+	binmode STDOUT, ":utf8";
+	local $, = "\0";
+	print @{$o->{files}};
+}
-- 
2.14.1.548.ge54b1befee.dirty

