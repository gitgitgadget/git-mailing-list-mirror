Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED30C2047F
	for <e@80x24.org>; Tue, 19 Sep 2017 19:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751513AbdIST3E (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 15:29:04 -0400
Received: from mail-dm3nam03on0134.outbound.protection.outlook.com ([104.47.41.134]:8672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751502AbdIST2s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 15:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6wLFU4ALya5xzcGekap8V3/uUq2ltsv/FMcWR5H0GjU=;
 b=WsQIbkwTaUFXnyT12QHiJAjZO6aGfF8D5eT2KzuE+i1et43s5/3GS5BUruJtZ8CE2DmbvsHEbAv6h6Ibl5NV9ozJcAltcY4XE3PPLjP08kxjJXebgLcgcoboF1Y/N6XATU99x4a0g3vL18IYBci5IZnNiNySGgBam4AI5u7QqfE=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.98.1; Tue, 19 Sep 2017 19:28:41 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v7 11/12] fsmonitor: add a sample integration script for Watchman
Date:   Tue, 19 Sep 2017 15:27:43 -0400
Message-Id: <20170919192744.19224-12-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20170919192744.19224-1-benpeart@microsoft.com>
References: <20170915192043.4516-1-benpeart@microsoft.com>
 <20170919192744.19224-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: DM5PR03CA0030.namprd03.prod.outlook.com (10.174.189.147) To
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55a56b6d-537b-49f5-9573-08d4ff94a384
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR21MB0471;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;3:gDlBHUassOI3LcVJC+jj1hL2m0XpDt+KV16+GSkmzuz/9E0+uVMTRvUM62QjJv9999ajLILeUCSDDD+NhGsBt/Hte7D97f4oWAX6vmmQKYxJ03QkmLZ38IfKa1HHAfId0biystZ97G4jDJc8H2fOessooSsbU4XNqY31lxNrGZWbH60f3b0qA2CUEz6Hb23O1en4IvYfxuUfdJDlHSfOB/Cyq5gfT8y1sXdY15/an0k29OGS67EhykZgDUmi9IXS;25:G+e2hT0nFl/0qlJA2g64943uDKJzl7bAtp3YfH3LrQTtFo15QYXpHKv5NnCvU2ozrNA/9q2AM7oIWhnxY1alWc8rOCPYUYIpxc7JryQBIirEBidDsPZJ4JsmcyB1eToIS1TnuLjUjbqUC2Nb5s86PhPuRD8OqbqO9gSYmYnDRevOuZRKRlWxN/aPQQzRxnO+IM9ECXO/AxKCkwia3k6a22O7o6Pp58ezNL6HOSQUepGAOMA4auU6sJnF4X/mzTInwZhzUn80l8Q6DpiJm7pNeCMuLsflpj4w4ra5u/cDvzWFnVvM9GNael3xJREsBvnlK7R9OTsavWBB8is8YmlH+A==;31:5JLQ5nkbK2uKYYvNqGw3CIcQwtLrK4RAz7XymyIL6eHzKQDpx/22kLawuiUu/Tib1S/HZCRywR8djJApXZ6Y6zbk+ZSWXdEwRpfgAuGhijKehxd1yBL0PPNXPMOl9mDAJYohHxsZso02DCGKKJlkyv8PqoaQ1LWGrTAhPtKM+pehNMxHUePkC0wANJiScplt9tyfeqc54X60M5V63iNo7Z4FwynQBtGDS1ymi60r+EU=
X-MS-TrafficTypeDiagnostic: CY4PR21MB0471:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;20:w+L0gTNmOiKdBgCKwFKnjtCzdNAbdxwINIf44fYJIF23FWARsZMcdZUVHKIVjcJO+4ZbRymgfezoy0PjpIUB1iMI0ba78KajbrL/2AokAG6Dwa5Q7AaAupySqYypTCScwxeK2Q8cMVSLXuLwiBX0deeAlGsVozEPSQq4qlUyFF6whyHY2NfzVd3pGiz5JgrxUyvZ0iamHO3k+v3uVjdhqVf1nLwxHi9gtmOKswvnzbI9U9RMG+vH8HeerlhwlNG/9ckrShZI1opmamMaWCvFLa08fMAo+X9kD3UVdESOBXco1xvm86hiFyRlsf6FZLJ6PDKAsA/74tMb+F/K2cbSPkCNdSeZzkhwUBTsnld/SDLEcQoJ9uiRF9Ns4tXmDpcgEBsYZiKCA+/gAM1dI5aG8b8CSRQqwZyYxE/K3o0JGhMg8gbGntLYTbXQaNUi+2zvg2y/xu/UlYhBkSJQnV+z1reXl0fhhtbGxrzygnGHaJqWTCE3KxJCxcVOwjtuGNO+;4:3U1o7ZvuoDGlMQYnZY9E9rf1YmxEDmS3nlrbsm1fJCNRTa09g5g30lQsWZL0Op2Si9DKsCOb/1/LHxFPwPx0SFfbIehvVtCbg6Aj/BizKK4TM8xdHeLuQCCZS8WhHNeFlzlxciu2yMU/yPCcBUo/GPJ96ZSvGjFUZ+JPkcEgdSVAaB5BOKjuXCAkWU49u9I0howws1LObAwMiqRLYyxRO+UsbFDStZVCCTufhxsOxGOjGoGGhD6Sc4I34sWH2yn7qjiZs0gDr9YZcpvCA0DPGyFoDPa+JhVdCCh3Oul+xLh3fQk6YEIdnSVXYNcUFHMkednbGntvOBpt0b7Ce0DE2w==
X-Exchange-Antispam-Report-Test: UriScan:(26323138287068)(89211679590171);
X-Microsoft-Antispam-PRVS: <CY4PR21MB04710AF32C6E657F30E01EDBF4600@CY4PR21MB0471.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123564025)(20161123555025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0471;
X-Forefront-PRVS: 04359FAD81
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(189002)(199003)(25786009)(1076002)(2906002)(50226002)(478600001)(6486002)(5660300001)(33646002)(50466002)(23676002)(36756003)(8676002)(16526017)(10290500003)(316002)(37006003)(2870700001)(189998001)(97736004)(3846002)(22452003)(86612001)(81166006)(6116002)(305945005)(6512007)(4326008)(34206002)(101416001)(39060400002)(106356001)(105586002)(8656003)(76176999)(50986999)(68736007)(53936002)(2351001)(7736002)(10090500001)(81156014)(8666007)(72206003)(966005)(2361001)(1511001)(8936002)(47776003)(6306002)(66066001)(2950100002)(6506006)(2421001)(22906009)(171213001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjIxTUIwNDcxOzIzOm5RNTNReHljTklpZXptLzR5V29qWjBZTnVO?=
 =?utf-8?B?alhhWlFCU3pUaC9FdWRDd2tvdE1sejk0YVRuMUl3VTRlbjJpaXI5UC9CMjhM?=
 =?utf-8?B?VE03SGJXN25nSVBCa3AyOUFQc2swMmQ1Q05PdG0vWS8wV2ZvVnVGTmUrWk4v?=
 =?utf-8?B?RzRJQkJMRUhsTTlCVkFhWWtTV0NGSUdyT2sxL3FkSUNzTzh6d010OE1vMUJ1?=
 =?utf-8?B?dUxzU3djZlZKdkFCZlhZQ3Q4NEJNa0ZWSFVlN1FCMy81dm5tUzhkSDUyVjRO?=
 =?utf-8?B?NzFGTFdxR3pHR3Z1ME9vNDY2cVNnNzJYU3YyOCtJUEZReUJ5LzYvMmNFQ1pR?=
 =?utf-8?B?UkkxUmd1OHBmcUNsWERVY2licFhEcEdiSVF5VGpwbEVCT3BTaXhuVGgxR1Rm?=
 =?utf-8?B?VTA1eDF5emp1bGVGdENGYTJ4ck5TVHNNRUNrY3JCMjA3M0k2TkJjS0Ntd0tQ?=
 =?utf-8?B?ZzRSMm5PQ2ozd1I4bHc2cEdSczU2aHRMb1FOYjZwMExaTnV5SHFReEVvSFRo?=
 =?utf-8?B?SjNuVlNveit2UVlPaDRvR29rNXJWdTJOZFZ1bUlud210ZHV5STNKdm1nKzZF?=
 =?utf-8?B?WDFGU0FSNE1RbkE1S3dnbU9OcFN3UzlXN2ZhZTFVTHBmaldlRVYrZEttTHND?=
 =?utf-8?B?b2lhY1NWY2ZZNGJQNjZ1SFlMN1Z4WngvRWo3cjFkRXpTSEdxZS9tWmxMYXFE?=
 =?utf-8?B?V3daR0xTMGpqWERmanJqckJlZldwa2lIS0VObUc5TFZHMWtHb0tEdFVWQ2hK?=
 =?utf-8?B?MHBHWTBzaG54Rmc1THprSldCTElnQWkvSHg4L0lFb3ZKMnF5Rlo4UlRic3VL?=
 =?utf-8?B?TXRTZ3NHaE5pNmFNUTJxVHBUSE1QQnpSTE11eTh6V1RPbGFSWGF6MDYxWUg2?=
 =?utf-8?B?MW5tYnhPVVZ5MVg2Z3VWVk0xR2pWQUNxNmRMRVp2ZVFTU2lrQ3pISm01cEpl?=
 =?utf-8?B?NEhleW1nblZLd0N3aFpVRFF0cUVZODlxMk9YM0FpSkFvYktQY1NjRTRUUnVI?=
 =?utf-8?B?djdnNlNVZ1lJVmNOZlR0b2xJNnpaQ0xoa2lEeWxHd2tEMW5TWk8wMUZ1c0tU?=
 =?utf-8?B?U0RFNmxqN3pQUmJ6WXFOZUNjMkRlTnRrTWdNQlVFSFhMV25EdVpITlpIMFNR?=
 =?utf-8?B?ZHBnK01yWDBHOUNUZ3krV1o0TFhEdjAwMG93V3ZWSWpaSlRvVU1rc01XbDBo?=
 =?utf-8?B?VnJMbjk5b3pxdmVETlU3U2ZUWm9ZYUJCbEgxeko0cjRlWjAyK2prcUZGRUdS?=
 =?utf-8?B?d3d0VEZYTjhwVkRjNmFPVExWZXNqYTBqQmxQWlo2M1Z6V3FmWlhGT016NThJ?=
 =?utf-8?B?WUVGQmtqdU5RdkkySWg0Z3JTZ05vWVpyd0t5b1A4ZkFsbVpiTzV3cWRXYlpi?=
 =?utf-8?B?bHVxOHc5Yzh4S2M4NWtINWpraDJyemZkM3pDK0ZPK0FNdnJEQTdlY2loN2Rv?=
 =?utf-8?B?UnFaVndYS1NkdWljNWpXNzFab29zSCtoUEZzS1E0dHc2UXBoQUtVdHhEN2s5?=
 =?utf-8?B?L2I4RW5YWXY3RUJKY2kvM0N0RVFyQXVZZlpJajh2Wk5vOFp1SVJzbFVidFdL?=
 =?utf-8?B?RVdHWEJZVjRBYUM4WThWZEkzUWhzTmlFNjAyU0RZYlg1MVJ0VWNBVGhWTVA1?=
 =?utf-8?B?RHlYOWl1OUM5bVoxU2ZRc3lXZDlBcS8yOTB3WWhHQkw4S0h0OUx6NnRFZjQ4?=
 =?utf-8?B?MzVycFNjd0NDS2UyNHFBY0NsM05kSGlwVWtCTUJtaWFaT09jQ0ZEYUJiTmQ4?=
 =?utf-8?B?U2ZGQlY0ZmdCZW9mclRuUkFCRTRNM3VlUE4xYzlUWEd4L3lUeWhBeDB6cHpD?=
 =?utf-8?B?OU9UeGxTZXRxejFXNWx5ZGlJcEowbmJKcVlDUlhlN1lzdGRQNk5GbmZtMEFl?=
 =?utf-8?B?Z0V0S2JuRHFIaFpGZVZaRFNqeGNwRWZrcmNFNlNPV1YrSmdHYXdDeWh2eWhm?=
 =?utf-8?Q?iwRA54KHyRjlCL8DQTP+k9tTbfDXQc=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;6:pvuoLcMLKoL4INCT6IT4CwN/UC3uqXXQUGp+hUlULnqs0wyVsCyX9UY27MO+pI1cUVGraZdlPqWKp8hqCm2SHD6hZcbh6w9pISDn0iiNiDjHMPIocGAcPStS+TW1/B623DNrMPLe+390fbi7xFjgflIjH6/gaQEoEkEEXWDxjPsbO0tjKd9VCfjmACtnzrMvnDkp1UbH3kdkqpDeREkMjVA/z5hOtrGQ+yiK7+rtPof0BXVplMoLEY7CgK45pxfJSqm+Z9sGBTtNxYu07KhMidLB97snWzdqpjGJnderQmJe6+gDAHXJ3w+krz548ox7QhyvCFS60N9Lz0lTijWfFQ==;5:Rv1WE1TzWFAlSXAoED2W3whR3vn8VGumNRslt2H4ULmgM5yhGsBBcJaOr/MOBCKPZrTcWZxPpPcVHbGfZS7vXZ0288HLcRtKRiqJAACQwaXl5jt/Us2g771X92uQDrBUjfFBx63aK3BuiuosRZZvlg==;24:sJ69Hy1eGI7HpP8xaY8IqldKsJNOcR2cxrDtp9+TdvOd4ex7UHxInZ+6FbVBpmMsroQ5T+W/bexThGygN6vRoyDa510JgH8o9nrDeMfi65g=;7:j6eRb0046zZ9loJxGL2gFNOj+yhRbDdTWKMNaaavH0+4sOVQAHRjqLpT9YLPwsfrQWtmm1P5Z90LsLShcoFesGak6a12/hXJlSkGFv4oMm9l+4NEBxv4ON3D7E16XqRtzzI8E9GTj5VKRdEYxd/UwmFdIMZ49NoDDXmMO/Bm3J7Wj4CB8biaJPKhH1i8y9eHQ4+kjHwhl3sRn6EMYh4BmwXqj3XLWEU0RDkOO9K/oQE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2017 19:28:41.4700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
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
2.14.1.windows.1

