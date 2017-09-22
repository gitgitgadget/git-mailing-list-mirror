Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F989202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 16:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbdIVQgf (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 12:36:35 -0400
Received: from mail-cys01nam02on0112.outbound.protection.outlook.com ([104.47.37.112]:49189
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752519AbdIVQgb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 12:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=1t6P/GgCQLSuU8pH7xzk4WGhDBx2XOsfhWjejiT02IU=;
 b=KAuG7pgH80MPohbKETmjlOYKfWA3MqBW4fCadcS/mDDk4+/VN7clFFSN+YrJpgZfBHpi8THTg0zxbBM16Aoj9pelp5i2N7VDuuJuHOG9FS5av86KUilavXB2qX0fV2x4UyUxlnOb2WZAM/fZip7uRq46uAKl8I0BNRCwekyDnYc=
Received: from localhost.localdomain (65.222.173.206) by
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.98.0; Fri, 22 Sep 2017 16:36:17 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v8 11/12] fsmonitor: add a sample integration script for Watchman
Date:   Fri, 22 Sep 2017 12:35:47 -0400
Message-Id: <20170922163548.11288-12-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.549.g6ff7ed0467
In-Reply-To: <20170922163548.11288-1-benpeart@microsoft.com>
References: <20170919192744.19224-1-benpeart@microsoft.com>
 <20170922163548.11288-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR06CA0048.namprd06.prod.outlook.com (10.174.93.37) To
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e077fffb-2946-4b42-fedd-08d501d80c4a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:BN6PR21MB0466;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;3:9GFWQgW16k6gGW4W5/7AncFFpLLBfO5NUiXr4nRRxu/ZA6abeftUDow22iTc/74KSZHdtYgiQ4H0Fd31Ib1mYr+bqoPFxT6jmrQjNw9NSZD/ARKSj87HjXn99+CPDzlpGx8uY//RD6yKXhACLuCOivVOXhK9ECdvyAJLoMtEdTsS7Ds8LTi6sx0yLRod7AuHQmJU/M8qKL3fH7kEO6AJZ+9EDhzvj066pFe21pyySAyvuQ4j2VQXMh5rOg/74vJ2;25:uqs6pFGA3+RZj4Tihd/j1Vtco+62mJVAgBVupFFGWSRh+4Ogxdr1Y78iHEzIz13XGtOeiFxSyGdbd5kTkLashNO0bzUZsxdnZrw7g+kBYIX/xmcAAIZumFJFkU5Kge7pc1Nqgdyr7BDm0LBv7HYYf9xQcJUimyn9brr7cV0wIt2Hn07L8UsTB5KV2tecnIhjw1QgLOxJOhbToC8F2VvFKGO0j0Oyj6NGhkoh9B2LyRL7OVXCh5kiD8QNUAZxAWOn+jCgzzKgyKnQt+lYyZiHB6WOZILBAe5tetYDwZnymVEMFwtnb0/48PDOhKUMwTddvsr0CQKuecsDr6vFbrZGNA==;31:yvDdvrP3e0tXz6Ui9e/NsLn5Ja9xGM1fwSk+zjgJpYz7kpsrXrGb7WhJxmRj5E4Uxmr7G4RoKmTyeFLfSU7F6QWo7+s/IYB69OYyUFXs8EJ37cwonO3ZO+qPu8bQpZrsEfA1GOHK2y2lhxP8Ja5CCpdUR6ypiBf9btfTEKHGEy2TzAq0dfoQY+81Dnu+1DlTnIYLo8pPNUBLgp4klbQFrtcXz/AV8SzINeXMP9B9qC8=
X-MS-TrafficTypeDiagnostic: BN6PR21MB0466:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;20:aAZH3o5AMK2Hgj1p5E6YF1Kk5PXxdUNdH+4Lzh6xVCNLaqP5fj2nrdyJOQlPnchx3kdqLPjAS5YP5Fi/vQjUPmcq4aRy55NIzD07Lg4yXrnOSRl1BB7MIq7OrfdtpSj1w2ftHVxSQ+5xia70YsYgz0lFAHMDCXD32FrKrz4YtFnn7LUrdgXVxJgpxCQiXX+4hqBhfGrg8SSl7tKy3finOlCJV3aT5lw1CPHfGH1NO/vO9AacpV8Qb3lpL3pm+Q7tOWG4sP5NPKeZmVdoqGFzN65W2+rro9kIXffp/C3g4W1pAW1yag22vqM55S9hYoAEi8uEhJu7Dg2fxXmwPU9fDX1qhFqSbaFqLJYF58QwhUHabzW88GS9VARH1P1f+13OSPjI0/mTeXSOZuAo5eKUZer2AepINm5FTuaCxjijjCRAwFH8oDMcuaOste9K8Z4lD/7IxQWLxfTl2F5TRCsQU8/gQad1lVpPumQT5PS++7MXyxlxpuvvkrUY3TTFIXU2;4:rxBnyUur6BwWg0yBCHYIX8Zc3L65HcYBdbm0sDdLo68aJnK95vfEDkB1rGN4GcclINGVbM7eke5ueYrqoDor0q2g2+/4k/E3hTkbHFdl78Jn4AX9l8Uy7HAqWPDYUkrPRmXHlyHNsH5CvWx+0byDksfSats/CkIGedgaaXj1BUnB9T5vWYiL1lNFRGXLqvDSMTpcEqc9famOn5DJ5Ir44hclydQqjRHSawecEUBLk233bGPyx7DUEyBEOp1jbDA2/hqzutPQZn5LbQqnixHvp08Lpz81fPVQ8+kXTma4F/LOyunLM0jy7RsnZZrNrSRe7aqYc6uZ1D+WYH+AquPYyQ==
X-Exchange-Antispam-Report-Test: UriScan:(26323138287068)(89211679590171);
X-Microsoft-Antispam-PRVS: <BN6PR21MB0466F73CE7D3E79C148DA7FBF4670@BN6PR21MB0466.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(100000703101)(100105400095)(6055026)(61426038)(61427038)(6041248)(20161123558100)(20161123564025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BN6PR21MB0466;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BN6PR21MB0466;
X-Forefront-PRVS: 0438F90F17
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(2351001)(6506006)(10290500003)(6486002)(86612001)(2906002)(5660300001)(66066001)(4326008)(10090500001)(101416001)(97736004)(1511001)(47776003)(50986999)(68736007)(76176999)(50226002)(2870700001)(106356001)(6666003)(16526017)(478600001)(53936002)(2361001)(37006003)(50466002)(81166006)(81156014)(966005)(8666007)(8936002)(316002)(72206003)(36756003)(23676002)(22452003)(6512007)(6306002)(189998001)(8656003)(25786009)(2421001)(33646002)(2950100002)(6116002)(34206002)(39060400002)(3846002)(1076002)(305945005)(7736002)(105586002)(8676002)(22906009)(171213001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0466;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjIxTUIwNDY2OzIzOjFXRTI3aUJlOFRWSHg5elJvNDBDdVVOQkxw?=
 =?utf-8?B?MDNSS3JzVkZkRktkOWkwUHRRNGE2bElsdWY2VGI1R2w2SjIyZjBlRVgrdEor?=
 =?utf-8?B?UnlCelRDN3ZGMWpHNTRCVFNqVjZrVEZFUE1ZWHlYUE0rVmxtY1hNclFsZExr?=
 =?utf-8?B?TGRqTlhGTmNaZWlBc1VWZ0U3NnBjOElvWWVxekdQU2lCVUVqUEhycXJaQmhC?=
 =?utf-8?B?RmlBOC9EU3Y0U1duWkFiczRrbS9vTDNIblZmY1QrM2JoV1pLNlNGZ3U4MHVN?=
 =?utf-8?B?cUJUNXBYQ3I0SWNNanN0YXJnQ3A4MDhHeWNPWDYyT0ZPd1lJR2UrNGRiOEJo?=
 =?utf-8?B?elRZenpMRmFPSisybFAvR1hFOHB4VklLMFVxSlBIYU1WbkhTaVVNMW10bTRQ?=
 =?utf-8?B?WGp5a0NMcjY5My9BNzRFcVZ5KzQ2Nk14R3hSbzNtU28xRXVwRHZNU1pMNjNa?=
 =?utf-8?B?M0NPcnovanhzTlQwUUNRZ05LLzRsN3hBbTZMZStqckEyb2JyUkdMMkc0akht?=
 =?utf-8?B?RTltSVgvOXp5UkNLbjczZW9rZWh1cnk0eFRJZXg5blp6ZmdNanJ4emlDaVBV?=
 =?utf-8?B?Q1o5emtZd1VHRDExaERaOXU2TDMyR0lWVElzODZPWXN6MG42ZXd1UEo4TWpS?=
 =?utf-8?B?ZnMvVFViblg4TnR6MWxWWmMxQ0ZRZDVMMHlXRmJSWUV5cGYzSno0UEFmNHgx?=
 =?utf-8?B?ZUR4Mm9qUitGRk94dVcvSVBwTWx6Nm42Z2ZZUVZ3bkl4WGtmOEFkOFo5OEgx?=
 =?utf-8?B?Um90a2RCZHczakpWN2h2aXVLbmgvaHFQVDNHcG42eDZqQWtwaHZ4TUo2NlA0?=
 =?utf-8?B?eG9BRzRlclVTZjQ4RTdya1F1Nks4Nm9mVFlIU0xPVW9abW5MK25OWHlZeTJp?=
 =?utf-8?B?WDFPSnYvNWdweU1LbGczN0hVN1haVVJBWlNXZ0RIN3VoVjgzMGF5aGhuZG5R?=
 =?utf-8?B?QmZHODhxcEhqcnR0MkkzNi9uWnAwVXc2Y3lMVTA5SW9pRjBPaHNDSWJvdEJx?=
 =?utf-8?B?R3RZSUlqYjFaMlR5VG5wUHNFRTEyaG5ySXk3K0djV2Y1YmdvR09UcnZxZHlM?=
 =?utf-8?B?c1FCYTFreWxBT1RKazNKd2d3c1JZU1dhUENTaTk3L1hmTlNjTjRBQTZpamds?=
 =?utf-8?B?ZjBhK0VxWTFIb25HaXU3c0o0VnY1bmNyTE93L3JsdndGdDE3aFBmRDQydksy?=
 =?utf-8?B?U1JCNmdVK1RIWmdYdGxqRkYyenJvQjRuRmZYQU1FNDVlWEp2Y1l4L0hOcFBw?=
 =?utf-8?B?MDU0Y2JVZk1lMTRHcXgzdWdhSzBSa0xwNTZTNHpVYkRNczhuRHV4QkIvKzQy?=
 =?utf-8?B?amV1bUdWUk5QdHVDelZCZThmNFFRc0VwSVNIUUo0ZUlWd0VLaDZSekVYMXhE?=
 =?utf-8?B?bW4yd0hnbGdwMDdnZzJvZzJwS29mSVJaN0plL3FoYkJycGZWQkUweUdQZGx0?=
 =?utf-8?B?NzJ4TGdaV1RQVGtDbXdob20zWFY5UFRGcWp3Ykk0aWRVRU9PMCtiZjlzY2ZH?=
 =?utf-8?B?dWNhMzhZZjROa1p5WHZ2M25USTg2ZFAyY0RQd2U1Y2tSZGQrWEJRcGxaTkV3?=
 =?utf-8?B?SGxoWjdpeDRqNExZKzZVZHNDaFB4c0x3NFpNMWJYR05BUmtkR3QvRnQ2azZx?=
 =?utf-8?B?SjZ6NTRoYVlPSDM1bkJwM1ZWbXpuM215Q0F1ZHdyWExtZm1ZZGdWU3ZpbTNt?=
 =?utf-8?B?NzdNdC9ZQkliU3ZpRnFqdU1KVTlRK2YwWTRaZU5mR2JGWTJjL29XTXgyajhQ?=
 =?utf-8?B?NXQ0c05Rb25COWFFMVV4c2Njb1BRVUpRWk9OTEs1NmJTYVNNaU1vaDJabWdj?=
 =?utf-8?B?c0NERGhaQXNyVHVpTFBHdFl1YkFMbjBZTkRwYzZnb0NLTEpQSXJZREdxRzhZ?=
 =?utf-8?B?NXV5V0hkQVYzUGVOZzFGelpVeHNZMnI1a1JaeUFLWWVzUWJMYXdRM3Vtdnpq?=
 =?utf-8?B?emU3bHlhWGdjV1M5U2dkb2JhTHNURXF0OE5URE5RTlFtWC9Ka21sQjlJcDF0?=
 =?utf-8?Q?Diovzq?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;6:3Ne3MDhF9iedqcG8g6RKv43uilBtzIZVkUMfCVnLufeNvmUNW+SprEqwepm9xdJhjAzrfvvtLoWP4v0wmsreoVE4R2UzvDFAZt4vyvUtr9zlrfsuaHRJiBb0yzhjAQ9MkW5uVBfM9m5I8zWl9Jn0ixt9/JWiMcOtmpeOS8RG75WNWux0BrFV5hY+qZ5Btk8v27a0anRcnSdSe6Sx3KfjX4upD8E1WnVQHxoFlJ4FJ8pYhM5bmflUfhBmzPMMsnb4zSb3WBhiSi1AuszYJcYWz1QtgxH8xFHoiimjqEzDUzlfBeN6k6qq0CldBHzn71c3FZg057Lsb1OABy33B3r9zQ==;5:SfUU7J4AwXVnAs7s16fbesAjhDheaQuhdxBg5jd/Bw3Dx9IZ9TbbN7/TdZ7Dyn6/qCZ2W37OFtf0jy3EB5sZrdv2+kKGrqKqIkKdMYqNUoFaG49L0b60U6diOs4sM3fl2vJn87WC832bJnR1Jt93Eg==;24:ZgeOvGVy9Q2Gw9yoa1iZL1EWkDCgyUjn9qmK8peICyh9Inq/ovuDt39nMGgl49s6l1YHeBqYLKeqPESfe0MHCecF9d4QGMlpcEo/PFIpvZ4=;7:ZhxEKM8kxWfMfwaYR6b1u4vEP/hkC3Kv1Kv1FFCPNbLqs4Lwh6id0dSccSQoFYCF4DQU1mjJ6fvabVPJ9Gc3aZe+ZDF4ZLPPHuMbl7jFYr7rG6gNHaX2joCfitdj8ktEWLuIEptrLFXR3PTXEh9T0HF1aCo69r6yGX5D2UssFR8yQfyRaLGG0aIHuGxEmzUh5MNT9MXnvpaplhTymCtHHnW+xCLFaIw7CoDYW/Heri4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2017 16:36:17.0160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0466
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
 templates/hooks--fsmonitor-watchman.sample | 122 +++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100755 templates/hooks--fsmonitor-watchman.sample

diff --git a/templates/hooks--fsmonitor-watchman.sample b/templates/hooks--fsmonitor-watchman.sample
new file mode 100755
index 0000000000..870a59d237
--- /dev/null
+++ b/templates/hooks--fsmonitor-watchman.sample
@@ -0,0 +1,122 @@
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
+	my $query = <<"	END";
+		["query", "$git_work_tree", {
+			"since": $time,
+			"fields": ["name"],
+			"expression": ["not", ["allof", ["since", $time, "cclock"], ["not", "exists"]]]
+		}]
+	END
+
+	print CHLD_IN $query;
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
+		print "/\0";
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
2.14.1.549.g6ff7ed0467

