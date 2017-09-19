Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CCAC2047F
	for <e@80x24.org>; Tue, 19 Sep 2017 19:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751300AbdIST2Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 15:28:24 -0400
Received: from mail-dm3nam03on0125.outbound.protection.outlook.com ([104.47.41.125]:34016
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750919AbdIST2W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 15:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=lypzC4Bn4BHCFbCSb8e/KyeTSNQxZDVajhQ+VXMsdgU=;
 b=VlFhUcP+XOSIgAk0aq9r92Rjaluk8PuHiBDuyiF1wTSISw+yKAcpM5/OCKPGUCeb+Kr9iFYpfRtV97yDgk2Z7b9wrK+PIgQTC2ErmsCGJhpxHrKDC2PoAWKstw+5FZ3p2Z1dNiiA/b+N3cbcCHJYD8RZthA9EDiB6FdwvMvB9FM=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.98.1; Tue, 19 Sep 2017 19:28:17 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v7 00/12] Fast git status via a file system watcher
Date:   Tue, 19 Sep 2017 15:27:32 -0400
Message-Id: <20170919192744.19224-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20170915192043.4516-1-benpeart@microsoft.com>
References: <20170915192043.4516-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: DM5PR03CA0030.namprd03.prod.outlook.com (10.174.189.147) To
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03164ae6-23b8-4245-0146-08d4ff949540
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR21MB0471;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;3:cfRGh9zDbLd/qUs8zW2za46XFALwC2haRyeYbPZigwzj/Sa75XA9h8oA1MC/odRasQ5lGadf9ArhHjH1aAyYv/jV3jd6Q7v4h1Qk+HraiOYwc8fJDtswNAaFGcgpTBYC+le2m+MFT8iA5S/HyaOrvVqg5AVp8DsMF/nMAflV/xyz2UZGoyaXWOQfmDSj/ZjwC6W72TydaBHcKEzupmQYD/yTJhSDqiokIK+1GHCSlaB084iBVffwhjuJ+sEIdHiJ;25:XJ0CZYKuta/1ImuWbGeVnNCfUqyv0B7rDX0yKJUf9wZuFtULAZKcxTqlTrDuk02djLbiY4MDGarTY/g/lduyLZli2Fii4pUOpUmby7HrMXHNqSTgDk8KKfPp0BpqYdNNmpWieFQqJy4XlryZ69iAZAq+DOwXHHGHjAgttVNTPtjDO6zMTlRPvmrO7iVodQ6tTr15bOl/oLo4SfWj+HQDEsWWIEp/Ly/6UFhsV2Eo4f/9hqNnt/l3nHGkLnVH21UYeBe6TDEcm+YzU1veE2hLOTd4uHV84lbzT9BjsjbHdWvvEB2tZa0bX24NuCd7T5wFwynquODl8H9My6hi7+Q7aA==;31:q4TqaI6MOU4AvtgCMLwhWdKd+8x6a9q7Dhz8Mr/TsHC8MN1WpP0y5GILZhV7ggDTijt6CY/Y/AlsYRbwz/+mKb2xE7HTiWkpX8NacCNcyC6RqpEl6KWJDAK4FCYAVQRucu0V+yjQfHJf5cQX6r09881B1onzK9fhZfRkzy36+sgbsPA+BNpBGbJSOV2VT5KzdtpP+zLEEyNn8gGe+uDn6LqzxgHxNkSxrlL2g4ir4MA=
X-MS-TrafficTypeDiagnostic: CY4PR21MB0471:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;20:/7YBHv+yxHylfMwBEp24/WrIFptEMT838VmKq9R2sLsBaOUM0FGpNp+9sMrIZ1YZ0npvlSYF9Yl8kTkSY8m6CWO/uBG5HqS0J1TwmVIlG/tqzCGVRl2GxVnZGCJTOIL1WOxFW7ixZBP17nwm0C5Za9WEsLPmIpKXL+NUmyRE+tkAvZ6tGDYz84mlQfxsCaK6GZ+8ysLYqXCs9+En7D+GC0YI7J9ZkQ6APP87GWxp3MfHlXMrv7xr4dmDnyYODHDZefyzrgVvL8+fh+9aVsvFNjonsyXl/Dw8YP82Z86+6DDmSVWRTWRbCBOp+Tnbn8NOcesEH2LUZsrmu/UIoJAS4mAbRQTzOg86ws0y704170dpdE55YNi4AGZGW3KldmExIBnOiPV3vfrYzXslmhyEJFx3GdTlIU+8WKGYx1wy0NyQb7PBHAvykK6n4YcCbML80m6pq1Nt8q5L6XwFGEgo6RskIBBLAhdK2nKQ24l+xB0hkGR7Unb/EokFBc5JzxED;4:V7t9e1SAxpdcatLx6p4DVLIgLn4BdEHHiz1kW+v0XyqaTOZpDIleHlu5jCUsvCjx2JFRyUt8taTvKBz5xEucpGFybpNdiPso852Q0phtSxcb8y9+c1bZGbKw6IBtpSPWDvASSEj3rHF6xfV2wZu2gAA4fBEWYD+e2XZWqdaNcd5qPfNtT+GTBLBU2KsY0g3LFUtFAr3OP2p8J1rYtsIY8ty/tkkOr+cCWG5Dus2JbDhbktRGtgmPQQqt3DdzVzrB
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR21MB047156EE967B92C9ECF322B1F4600@CY4PR21MB0471.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123564025)(20161123555025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0471;
X-Forefront-PRVS: 04359FAD81
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(189002)(199003)(54164003)(25786009)(1076002)(2906002)(50226002)(478600001)(6486002)(6666003)(5660300001)(33646002)(50466002)(23676002)(36756003)(8676002)(16526017)(10290500003)(316002)(37006003)(2870700001)(189998001)(97736004)(3846002)(22452003)(86612001)(81166006)(575784001)(6116002)(305945005)(6512007)(4326008)(34206002)(101416001)(39060400002)(106356001)(105586002)(8656003)(76176999)(50986999)(68736007)(53936002)(2351001)(7736002)(10090500001)(81156014)(8666007)(72206003)(2361001)(1511001)(8936002)(47776003)(66066001)(2950100002)(6506006)(2421001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjIxTUIwNDcxOzIzOmhSOStISkptWkNxOUI2dVgxdGFBN1U3d29t?=
 =?utf-8?B?eVE3d0FOUHpNamRtRk90S0QwY1R2VDBKSXZaTlRFWk1pTGhJRkcvNmx6UERK?=
 =?utf-8?B?eDFEM2JRYVM3YWtiR0k3TG1VRlRJd05vTktHM2F6ek5NM1VJM0FkNmNnMk5H?=
 =?utf-8?B?bGJQM3RQaFpiekxOVitQOFUxTEhBcjllaXJTSDBhL1BZWkZROEpjbW1seVFj?=
 =?utf-8?B?VVV2UjQ4N2s1RDRIbnVrWDVIdzBGbUN4VlYrWFhSYkRRRHlVakkvRXgvditS?=
 =?utf-8?B?TkJpcW91Q0phRVFNN1dzOWlKNjFjMnFWUVU4N1lrQlJMdmtFMlZJRExTK3VJ?=
 =?utf-8?B?d0l3bnpYdGdkMUkzS3hrYlVhR3dIbStSWTgyd2FlL0dLT2U0SHlYUHh5SzNm?=
 =?utf-8?B?SUVtR2VyT04xTzRoaUlsQVJVWFNiYy9rdHlhTHp3Zy8xWUczSVhOeGRyMFRZ?=
 =?utf-8?B?Kzk3djdwcWI2T2RlTUVPVi9LdUkyZjNyc1lQejYrbTZPYlFBMVN4YW5ZcHZQ?=
 =?utf-8?B?Rnl2ck00L2d4anhKNCtlZE5zdis2VHVNVHkrYm9VVk1obVE1UjFodDFoM0FQ?=
 =?utf-8?B?WEs5aGNKcjNnc3F2NU9zWDcyUDY5alNXMmZXR2VjMU9oQU0vMm13TCtzRkd2?=
 =?utf-8?B?OUFzN0FBRUxBdW5Lc1ZBU1JXZi9ydE5qankybUd2Z2ZkRDNxVGl4aWhZblEr?=
 =?utf-8?B?cThjcC9ueGRhQ1hwOCsrRHJaTThMRVdlTmVwR2NsZmRxanduNEhsTFJlQ0h3?=
 =?utf-8?B?S00zM1VoZ3c2b1ZsZzhmVDdRSjFmNGE4WDU5bHUzWCtDb2FudWFab2hBRVN4?=
 =?utf-8?B?UzZJMVpBbTR3aktEb05XeTVIckkzOVVkUHR4SHNPQ1N3TzJhdzNKb2Z0dWND?=
 =?utf-8?B?bXBBSGJaQ1Z6N3l0dmVDTER4SXdSZVcwNTRlQ0FCOXRnNmNXS3pIbENHSGRD?=
 =?utf-8?B?TkJleForNmNsbjBKTUQ3OXZJN053aWY5Q0M4Y0QxaWRnQzJxeWRHOTJXalpt?=
 =?utf-8?B?c3MzVSt6SlRYemF5MXZ2RzJuNC90QmxzVlAxOFJ6MHpEbGNnV3VZdVVnc2hV?=
 =?utf-8?B?VHB5N2pZTW5Ic3JmZ0pnVDFVMVpndTVjY3Y1QXR6Tm52dWZtRzVETUo0NGxV?=
 =?utf-8?B?ellaY1ROMDBaNGpKZ0doZThmUHBNdEdVd3dPc2RQMnNSbEFEbWFWejBOb0s0?=
 =?utf-8?B?ZHlXS01uWisyd3VHeUlEa2JtU0xUUGxlTXUzT0QxOWJ5Sm1SU2swUkc3Tmto?=
 =?utf-8?B?VnhYajhYa0x3Z2hlZWM3TlZiL0ZXa01kZTJDZGZVSXZMSnhvNHNEdGhWTlVy?=
 =?utf-8?B?UWN3OWtUVERDYUE1ZStQVVVtb0NRVTNCQ3BTRklpa1VLVE1SbU90RmUwczkr?=
 =?utf-8?B?V01TdjY2ZlNqMjRpSHdWMFpic25mYkZEV0czMExYbm9kV0kxK3BjLzlnYzdw?=
 =?utf-8?B?anBYL0pyeFk2dUx3ZExtUmdHWlFDNWJnTmZOb2lMNFBDMXN0L1d1aGt6YnNN?=
 =?utf-8?B?V1FrZGRQbTRGQnlaYzN4cm0wZDRhWEhEZUZOdTU0ME01eStUWVkxRk9NZWFW?=
 =?utf-8?B?RjNtQkdVVmpXY3ByZG4rSjRPMzhqa3F6TWlpczFpejRTRE00OE9ySm94YURx?=
 =?utf-8?B?aXpUakNpdFJVRkV6K2hvYVhiNzBLNk1yVjgxZVhaSG95c0xqbG5sMUtkK0lV?=
 =?utf-8?B?dWZnUEJxUHpsZlIvVTM5WFVSTzlsbk1ISTZsazFWVlVjdmN6RnU4dTV2aUNI?=
 =?utf-8?B?L1d1VFI2RmJlMjhGQk5yOHZuMFVvdi9iNGViS0xhN3BTUlpOejBaTFdtdUxJ?=
 =?utf-8?B?WUN6MWJtMmtObWZJR3k4dnA0Z3RsQnFENjVpL0wxWU0zOXYzOFhVck44UGFL?=
 =?utf-8?B?NjFZVXRlbWs3R3FhWXdBZUpZUUlkTDU4ODQ3QzNpeGcxMTB4SG5UK2ZFRUl5?=
 =?utf-8?B?NXFrSlYwNVJVaXhNdjJZaE5QeXpCa2U3SVV5eUVVU1EvQnVXczNxS3J3T1FI?=
 =?utf-8?Q?ClsYl1?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;6:xXUw5cDjuntd2YW3K/whEK0PvHo7njNY91GUYEyZQupgEjYcTiXeYykrGcbI0ljjig7DzdS1O4qMxX6S9bhcN4YY1k7O4Fyy/R/zFB4a8d238c00MdyfuPKr/9Z2qYVgUO0TAel/5ntoB6u5tqCcD02/5fCVkkUylpWlCT1/Gwk0ermLZhf8EA5hr4YBDvvZXffuwO3XG6Q62kNQqDBwnLJj5Pul10JR/9tymgXT0mYkqFuDWcCLyT1r5faPTQ6WYLIJt3Js0NNXTJFXy83anzGktQplfDw8d7AjgrXFCS0edvALMYZoS0xdkV/6rA/I/tB2yW8p0A1bQQt6QS/OKg==;5:ybmbB1DjNMk4DelN3egBidxMkcQg9iyY5S0aDiEbu/fJCpcYD2GgWzG5GvabDM3p6d4RXKbh6GGW1G02od9hT288OubO2xISBiKrYydqm1PLvkc8jL5j12ln4M+REwK4d8jXOHxVqgRSMhhyAYxjRQ==;24:8NTIYn45ly2a1idl479hjaswnuQL84X0DQyvU13E26TDZEuiSmZe91ZON16hJ0O2iyyfcCT5td+jcIqV3paGb/X0ZPvzCkmhpNDgVv0xDyU=;7:SYlk2ePt+a2XlDp/hCzyy4KkGYXeFdqzMuf/SjJUQ6bT72uktfjPCo74AOZpbZpvlU7MLuX1V8f525maW015vICe6ma3NdcwgyYOE2FeXyHykHoxTcYeiH+5VvILEJDUfvXmac2nH2QC+nVdI0HqdJniQ0QF7gRpGRpiMZ579dOh9yE73SwwL+/3OTQFucWqiDa8pkQnVcpwnIaGSd224sM+jOIEAhxEly8d7qefjis=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2017 19:28:17.9387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subject: Fast git status via a file system watcher

Thanks to everyone who provided feedback.  There are lots of minor style
changes, documentation updates and a fixed leak.

The only functional change is the addition of support to set/clear the
fsmonitor valid bit via 'git update-index --[no-]fsmonitor-valid' with
the associated documentation and tests.

Interdiff between V6 and V7:

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c196007a27..db52645cb4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -418,6 +418,7 @@ core.fsmonitor::
 	will identify all files that may have changed since the
 	requested date/time. This information is used to speed up git by
 	avoiding unnecessary processing of files that have not changed.
+	See the "fsmonitor-watchman" section of linkgit:githooks[5].
 
 core.trustctime::
 	If false, the ctime differences between the index and the
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index d153c17e06..3ac3e3a77d 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -9,7 +9,7 @@ git-ls-files - Show information about files in the index and the working tree
 SYNOPSIS
 --------
 [verse]
-'git ls-files' [-z] [-t] [-v]
+'git ls-files' [-z] [-t] [-v] [-f]
 		(--[cached|deleted|others|ignored|stage|unmerged|killed|modified])*
 		(-[c|d|o|i|s|u|k|m])*
 		[--eol]
@@ -133,6 +133,11 @@ a space) at the start of each line:
 	that are marked as 'assume unchanged' (see
 	linkgit:git-update-index[1]).
 
+-f::
+	Similar to `-t`, but use lowercase letters for files
+	that are marked as 'fsmonitor valid' (see
+	linkgit:git-update-index[1]).
+
 --full-name::
 	When run from a subdirectory, the command usually
 	outputs paths relative to the current directory.  This
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index e19eba62cd..95231dbfcb 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -16,9 +16,11 @@ SYNOPSIS
 	     [--chmod=(+|-)x]
 	     [--[no-]assume-unchanged]
 	     [--[no-]skip-worktree]
+	     [--[no-]fsmonitor-valid]
 	     [--ignore-submodules]
 	     [--[no-]split-index]
 	     [--[no-|test-|force-]untracked-cache]
+	     [--[no-]fsmonitor]
 	     [--really-refresh] [--unresolve] [--again | -g]
 	     [--info-only] [--index-info]
 	     [-z] [--stdin] [--index-version <n>]
@@ -111,6 +113,12 @@ you will need to handle the situation manually.
 	set and unset the "skip-worktree" bit for the paths. See
 	section "Skip-worktree bit" below for more information.
 
+--[no-]fsmonitor-valid::
+	When one of these flags is specified, the object name recorded
+	for the paths are not updated. Instead, these options
+	set and unset the "fsmonitor valid" bit for the paths. See
+	section "File System Monitor" below for more information.
+
 -g::
 --again::
 	Runs 'git update-index' itself on the paths whose index
@@ -201,6 +209,15 @@ will remove the intended effect of the option.
 	`--untracked-cache` used to imply `--test-untracked-cache` but
 	this option would enable the extension unconditionally.
 
+--fsmonitor::
+--no-fsmonitor::
+	Enable or disable files system monitor feature. These options
+	take effect whatever the value of the `core.fsmonitor`
+	configuration variable (see linkgit:git-config[1]). But a warning
+	is emitted when the change goes against the configured value, as
+	the configured value will take effect next time the index is
+	read and this will remove the intended effect of the option.
+
 \--::
 	Do not interpret any more arguments as options.
 
@@ -447,6 +464,34 @@ command reads the index; while when `--[no-|force-]untracked-cache`
 are used, the untracked cache is immediately added to or removed from
 the index.
 
+File System Monitor
+-------------------
+
+This feature is intended to speed up git operations for repos that have
+large working directories.
+
+It enables git to work together with a file system monitor (see the
+"fsmonitor-watchman" section of linkgit:githooks[5]) that can
+inform it as to what files have been modified. This enables git to avoid
+having to lstat() every file to find modified files.
+
+When used in conjunction with the untracked cache, it can further improve
+performance by avoiding the cost of scaning the entire working directory
+looking for new files.
+
+If you want to enable (or disable) this feature, it is easier to use
+the `core.fsmonitor` configuration variable (see
+linkgit:git-config[1]) than using the `--fsmonitor` option to
+`git update-index` in each repository, especially if you want to do so
+across all repositories you use, because you can set the configuration
+variable to `true` (or `false`) in your `$HOME/.gitconfig` just once
+and have it affect all repositories you touch.
+
+When the `core.fsmonitor` configuration variable is changed, the
+file system monitor is added to or removed from the index the next time
+a command reads the index. When `--[no-]fsmonitor` are used, the file
+system monitor is immediately added to or removed from the index.
+
 Configuration
 -------------
 
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index da82d64b0b..ae60559cd9 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -455,10 +455,8 @@ the name of the file that holds the e-mail to be sent.  Exiting with a
 non-zero status causes 'git send-email' to abort before sending any
 e-mails.
 
-
-[[fsmonitor-watchman]]
 fsmonitor-watchman
-~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~
 
 This hook is invoked when the configuration option core.fsmonitor is
 set to .git/hooks/fsmonitor-watchman.  It takes two arguments, a version
@@ -471,10 +469,17 @@ should be inclusive so that it does not miss any potential changes.
 The paths should be relative to the root of the working directory
 and be separated by a single NUL.
 
+It is OK to include files which have not actually changed.  All changes
+including newly-created and deleted files should be included. When
+files are renamed, both the old and the new name should be included.
+
 Git will limit what files it checks for changes as well as which
 directories are checked for untracked files based on the path names
 given.
 
+An optimized way to tell git "all files have changed" is to return
+the filename '/'.
+
 The exit status determines whether git will use the data from the
 hook to limit its search.  On error, it will fall back to verifying
 all files and folders.
diff --git a/builtin/update-index.c b/builtin/update-index.c
index b03afc1f3a..41618db098 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -33,6 +33,7 @@ static int force_remove;
 static int verbose;
 static int mark_valid_only;
 static int mark_skip_worktree_only;
+static int mark_fsmonitor_only;
 #define MARK_FLAG 1
 #define UNMARK_FLAG 2
 static struct strbuf mtime_dir = STRBUF_INIT;
@@ -229,12 +230,12 @@ static int mark_ce_flags(const char *path, int flag, int mark)
 	int namelen = strlen(path);
 	int pos = cache_name_pos(path, namelen);
 	if (0 <= pos) {
+		mark_fsmonitor_invalid(&the_index, active_cache[pos]);
 		if (mark)
 			active_cache[pos]->ce_flags |= flag;
 		else
 			active_cache[pos]->ce_flags &= ~flag;
 		active_cache[pos]->ce_flags |= CE_UPDATE_IN_BASE;
-		mark_fsmonitor_invalid(&the_index, active_cache[pos]);
 		cache_tree_invalidate_path(&the_index, path);
 		active_cache_changed |= CE_ENTRY_CHANGED;
 		return 0;
@@ -460,6 +461,11 @@ static void update_one(const char *path)
 			die("Unable to mark file %s", path);
 		return;
 	}
+	if (mark_fsmonitor_only) {
+		if (mark_ce_flags(path, CE_FSMONITOR_VALID, mark_fsmonitor_only == MARK_FLAG))
+			die("Unable to mark file %s", path);
+		return;
+	}
 
 	if (force_remove) {
 		if (remove_file_from_cache(path))
@@ -1014,6 +1020,12 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			N_("write out the index even if is not flagged as changed"), 1),
 		OPT_BOOL(0, "fsmonitor", &fsmonitor,
 			N_("enable or disable file system monitor")),
+		{OPTION_SET_INT, 0, "fsmonitor-valid", &mark_fsmonitor_only, NULL,
+			N_("mark files as fsmonitor valid"),
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, MARK_FLAG},
+		{OPTION_SET_INT, 0, "no-fsmonitor-valid", &mark_fsmonitor_only, NULL,
+			N_("clear fsmonitor valid bit"),
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, UNMARK_FLAG},
 		OPT_END()
 	};
 
diff --git a/fsmonitor.c b/fsmonitor.c
index 144294b8df..b8b2d88fe1 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -57,12 +57,12 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
 
 		/* Mark all previously saved entries as dirty */
 		ewah_each_bit(fsmonitor_dirty, fsmonitor_ewah_callback, istate);
-		ewah_free(fsmonitor_dirty);
 
 		/* Now mark the untracked cache for fsmonitor usage */
 		if (istate->untracked)
 			istate->untracked->use_fsmonitor = 1;
 	}
+	ewah_free(fsmonitor_dirty);
 
 	trace_printf_key(&trace_fsmonitor, "read fsmonitor extension successful");
 	return 0;
@@ -177,7 +177,7 @@ void refresh_fsmonitor(struct index_state *istate)
 	}
 
 	/* a fsmonitor process can return '*' to indicate all entries are invalid */
-	if (query_success && query_result.buf[0] != '*') {
+	if (query_success && query_result.buf[0] != '/') {
 		/* Mark all entries returned by the monitor as dirty */
 		buf = query_result.buf;
 		bol = 0;
diff --git a/fsmonitor.h b/fsmonitor.h
index dadbe90283..c2240b811a 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -46,7 +46,7 @@ static inline void mark_fsmonitor_valid(struct cache_entry *ce)
 }
 
 /*
- * Clear the given cache entries CE_FSMONITOR_VALID bit and invalidate any
+ * Clear the given cache entry's CE_FSMONITOR_VALID bit and invalidate any
  * corresponding untracked cache directory structures.
  */
 static inline void mark_fsmonitor_invalid(struct index_state *istate, struct cache_entry *ce)
diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
index 717079865c..4e5ca8f397 100644
--- a/t/helper/test-drop-caches.c
+++ b/t/helper/test-drop-caches.c
@@ -2,7 +2,7 @@
 
 #if defined(GIT_WINDOWS_NATIVE)
 
-int cmd_sync(void)
+static int cmd_sync(void)
 {
 	char Buffer[MAX_PATH];
 	DWORD dwRet;
@@ -49,7 +49,7 @@ typedef enum _SYSTEM_MEMORY_LIST_COMMAND {
 	MemoryCommandMax
 } SYSTEM_MEMORY_LIST_COMMAND;
 
-BOOL GetPrivilege(HANDLE TokenHandle, LPCSTR lpName, int flags)
+static BOOL GetPrivilege(HANDLE TokenHandle, LPCSTR lpName, int flags)
 {
 	BOOL bResult;
 	DWORD dwBufferLength;
@@ -77,10 +77,11 @@ BOOL GetPrivilege(HANDLE TokenHandle, LPCSTR lpName, int flags)
 	return bResult;
 }
 
-int cmd_dropcaches(void)
+static int cmd_dropcaches(void)
 {
 	HANDLE hProcess = GetCurrentProcess();
 	HANDLE hToken;
+	HMODULE ntdll;
 	int status;
 
 	if (!OpenProcessToken(hProcess, TOKEN_QUERY | TOKEN_ADJUST_PRIVILEGES, &hToken))
@@ -91,7 +92,7 @@ int cmd_dropcaches(void)
 
 	CloseHandle(hToken);
 
-	HMODULE ntdll = LoadLibrary("ntdll.dll");
+	ntdll = LoadLibrary("ntdll.dll");
 	if (!ntdll)
 		return error("Can't load ntdll.dll, wrong Windows version?");
 
@@ -118,36 +119,36 @@ int cmd_dropcaches(void)
 
 #elif defined(__linux__)
 
-int cmd_sync(void)
+static int cmd_sync(void)
 {
 	return system("sync");
 }
 
-int cmd_dropcaches(void)
+static int cmd_dropcaches(void)
 {
 	return system("echo 3 | sudo tee /proc/sys/vm/drop_caches");
 }
 
 #elif defined(__APPLE__)
 
-int cmd_sync(void)
+static int cmd_sync(void)
 {
 	return system("sync");
 }
 
-int cmd_dropcaches(void)
+static int cmd_dropcaches(void)
 {
 	return system("sudo purge");
 }
 
 #else
 
-int cmd_sync(void)
+static int cmd_sync(void)
 {
 	return 0;
 }
 
-int cmd_dropcaches(void)
+static int cmd_dropcaches(void)
 {
 	return error("drop caches not implemented on this platform");
 }
diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
index 482d749bb9..ad452707e8 100644
--- a/t/helper/test-dump-fsmonitor.c
+++ b/t/helper/test-dump-fsmonitor.c
@@ -12,7 +12,7 @@ int cmd_main(int ac, const char **av)
 		printf("no fsmonitor\n");
 		return 0;
 	}
-	printf("fsmonitor last update %"PRIuMAX"\n", istate->fsmonitor_last_update);
+	printf("fsmonitor last update %"PRIuMAX"\n", (uintmax_t)istate->fsmonitor_last_update);
 
 	for (i = 0; i < istate->cache_nr; i++)
 		printf((istate->cache[i]->ce_flags & CE_FSMONITOR_VALID) ? "+" : "-");
diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 1c5978d5c8..16d1bf72e5 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -95,7 +95,7 @@ test_expect_success "setup for fsmonitor" '
 		INTEGRATION_SCRIPT="$GIT_PERF_7519_FSMONITOR"
 	else
 		#
-		# Choose integration script based on existance of Watchman.
+		# Choose integration script based on existence of Watchman.
 		# If Watchman exists, watch the work tree and attempt a query.
 		# If everything succeeds, use Watchman integration script,
 		# else fall back to an empty integration script.
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 6aa1e4e924..c6df85af5e 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -32,14 +32,16 @@ dirty_repo () {
 	echo 6 >dir2/new
 }
 
-write_integration_script() {
+write_integration_script () {
 	write_script .git/hooks/fsmonitor-test<<-\EOF
-	if [ "$#" -ne 2 ]; then
+	if test "$#" -ne 2
+	then
 		echo "$0: exactly 2 arguments expected"
 		exit 2
 	fi
-	if [ "$1" != 1 ]; then
-		echo -e "Unsupported core.fsmonitor hook version.\n" >&2
+	if test "$1" != 1
+	then
+		echo "Unsupported core.fsmonitor hook version." >&2
 		exit 1
 	fi
 	printf "untracked\0"
@@ -100,6 +102,43 @@ test_expect_success 'update-index --no-fsmonitor" removes the fsmonitor extensio
 	grep "^no fsmonitor" actual
 '
 
+cat >expect <<EOF &&
+h dir1/modified
+H dir1/tracked
+h dir2/modified
+H dir2/tracked
+h modified
+H tracked
+EOF
+
+# test that "update-index --fsmonitor-valid" sets the fsmonitor valid bit
+test_expect_success 'update-index --fsmonitor-valid" sets the fsmonitor valid bit' '
+	git update-index --fsmonitor &&
+	git update-index --fsmonitor-valid dir1/modified &&
+	git update-index --fsmonitor-valid dir2/modified &&
+	git update-index --fsmonitor-valid modified &&
+	git ls-files -f >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<EOF &&
+H dir1/modified
+H dir1/tracked
+H dir2/modified
+H dir2/tracked
+H modified
+H tracked
+EOF
+
+# test that "update-index --no-fsmonitor-valid" clears the fsmonitor valid bit
+test_expect_success 'update-index --no-fsmonitor-valid" clears the fsmonitor valid bit' '
+	git update-index --no-fsmonitor-valid dir1/modified &&
+	git update-index --no-fsmonitor-valid dir2/modified &&
+	git update-index --no-fsmonitor-valid modified &&
+	git ls-files -f >actual &&
+	test_cmp expect actual
+'
+
 cat >expect <<EOF &&
 H dir1/modified
 H dir1/tracked
@@ -204,7 +243,7 @@ for preload_val in $preload_values
 do
 	test_expect_success "setup preloadIndex to $preload_val" '
 		git config core.preloadIndex $preload_val &&
-		if [ $preload_val -eq true ]
+		if test $preload_val = true
 		then
 			GIT_FORCE_PRELOAD_TEST=$preload_val; export GIT_FORCE_PRELOAD_TEST
 		else
@@ -249,8 +288,14 @@ do
 			git status >actual &&
 			test_path_is_file marker &&
 			test_i18ngrep ! "Changes not staged for commit:" actual &&
-			if [ $uc_val -eq true ]; then test_i18ngrep ! "Untracked files:" actual; fi &&
-			if [ $uc_val -eq false ]; then test_i18ngrep "Untracked files:" actual; fi &&
+			if test $uc_val = true
+			then
+				test_i18ngrep ! "Untracked files:" actual
+			fi &&
+			if test $uc_val = false
+			then
+				test_i18ngrep "Untracked files:" actual
+			fi &&
 			rm -f marker
 		'
 	done
diff --git a/t/t7519/fsmonitor-all b/t/t7519/fsmonitor-all
index a3870e431e..691bc94dc2 100755
--- a/t/t7519/fsmonitor-all
+++ b/t/t7519/fsmonitor-all
@@ -9,15 +9,16 @@
 #
 #echo "$0 $*" >&2
 
-if [ "$#" -ne 2 ] ; then
-	echo -e "$0: exactly 2 arguments expected\n" >&2
+if test "$#" -ne 2
+then
+	echo "$0: exactly 2 arguments expected" >&2
 	exit 2
 fi
 
-if [ "$1" != 1 ]
+if test "$1" != 1
 then
-	echo -e "Unsupported core.fsmonitor hook version.\n" >&2
+	echo "Unsupported core.fsmonitor hook version." >&2
 	exit 1
 fi
 
-echo "*"
\ No newline at end of file
+echo "/"
diff --git a/t/t7519/fsmonitor-none b/t/t7519/fsmonitor-none
index c500bb0f26..ed9cf5a6a9 100755
--- a/t/t7519/fsmonitor-none
+++ b/t/t7519/fsmonitor-none
@@ -9,13 +9,14 @@
 #
 #echo "$0 $*" >&2
 
-if [ "$#" -ne 2 ] ; then
-	echo -e "$0: exactly 2 arguments expected\n" >&2
+if test "$#" -ne 2
+then
+	echo "$0: exactly 2 arguments expected" >&2
 	exit 2
 fi
 
-if [ "$1" != 1 ]
+if test "$1" != 1
 then
-	echo -e "Unsupported core.fsmonitor hook version.\n" >&2
+	echo "Unsupported core.fsmonitor hook version." >&2
 	exit 1
 fi
diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
index aaee5d1fe3..7ceb32dc18 100755
--- a/t/t7519/fsmonitor-watchman
+++ b/t/t7519/fsmonitor-watchman
@@ -17,7 +17,7 @@ use IPC::Open2;
 # 'git config core.fsmonitor .git/hooks/query-watchman'
 #
 my ($version, $time) = @ARGV;
-print STDERR "$0 $version $time\n";
+#print STDERR "$0 $version $time\n";
 
 # Check the hook interface version
 
@@ -29,7 +29,20 @@ if ($version == 1) {
 	    "Falling back to scanning...\n";
 }
 
-my $git_work_tree = $ENV{'PWD'};
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
 
 my $retry = 1;
 
@@ -57,20 +70,19 @@ sub launch_watchman {
 	# creation clock (cclock) newer than $time_t value and will also not
 	# currently exist.
 
+	my $query = <<"	END";
+		["query", "$git_work_tree", {
+			"since": $time,
+			"fields": ["name"],
+			"expression": ["not", ["allof", ["since", $time, "cclock"], ["not", "exists"]]]
+		}]
+	END
+	
 	open (my $fh, ">", ".git/watchman-query.json");
-	print $fh "[\"query\", \"$git_work_tree\", { \
-	\"since\": $time, \
-	\"fields\": [\"name\"], \
-	\"expression\": [\"not\", [\"allof\", [\"since\", $time, \"cclock\"], [\"not\", \"exists\"]]] \
-	}]";
+	print $fh $query;
 	close $fh;
 
-	print CHLD_IN "[\"query\", \"$git_work_tree\", { \
-	\"since\": $time, \
-	\"fields\": [\"name\"], \
-	\"expression\": [\"not\", [\"allof\", [\"since\", $time, \"cclock\"], [\"not\", \"exists\"]]] \
-	}]";
-
+	print CHLD_IN $query;
 	my $response = <CHLD_OUT>;
 
 	open ($fh, ">", ".git/watchman-response.json");
@@ -100,17 +112,17 @@ sub launch_watchman {
 		qx/watchman watch "$git_work_tree"/;
 		die "Failed to make watchman watch '$git_work_tree'.\n" .
 		    "Falling back to scanning...\n" if $? != 0;
-		# return fast "everything is dirty" flag"
-		print "*\0";
-		open ($fh, ">", ".git/watchman-output.out");
-		print "*\0";
-		close $fh;
 
 		# Watchman will always return all files on the first query so
 		# return the fast "everything is dirty" flag to git and do the
 		# Watchman query just to get it over with now so we won't pay
 		# the cost in git to look up each individual file.
-		print "*\0";
+
+		open ($fh, ">", ".git/watchman-output.out");
+		print "/\0";
+		close $fh;
+
+		print "/\0";
 		eval { launch_watchman() };
 		exit 0;
 	}
@@ -118,11 +130,11 @@ sub launch_watchman {
 	die "Watchman: $o->{error}.\n" .
 	    "Falling back to scanning...\n" if $o->{error};
 
-	binmode STDOUT, ":utf8";
-	local $, = "\0";
-	print @{$o->{files}};
-
 	open ($fh, ">", ".git/watchman-output.out");
 	print $fh @{$o->{files}};
 	close $fh;
-}
\ No newline at end of file
+
+	binmode STDOUT, ":utf8";
+	local $, = "\0";
+	print @{$o->{files}};
+}
diff --git a/templates/hooks--fsmonitor-watchman.sample b/templates/hooks--fsmonitor-watchman.sample
index 2779d7edf3..870a59d237 100755
--- a/templates/hooks--fsmonitor-watchman.sample
+++ b/templates/hooks--fsmonitor-watchman.sample
@@ -69,12 +69,15 @@ sub launch_watchman {
 	# creation clock (cclock) newer than $time_t value and will also not
 	# currently exist.
 
-	print CHLD_IN "[\"query\", \"$git_work_tree\", { \
-	\"since\": $time, \
-	\"fields\": [\"name\"], \
-	\"expression\": [\"not\", [\"allof\", [\"since\", $time, \"cclock\"], [\"not\", \"exists\"]]] \
-	}]";
-
+	my $query = <<"	END";
+		["query", "$git_work_tree", {
+			"since": $time,
+			"fields": ["name"],
+			"expression": ["not", ["allof", ["since", $time, "cclock"], ["not", "exists"]]]
+		}]
+	END
+
+	print CHLD_IN $query;
 	my $response = <CHLD_OUT>;
 
 	die "Watchman: command returned no output.\n" .
@@ -105,7 +108,7 @@ sub launch_watchman {
 		# return the fast "everything is dirty" flag to git and do the
 		# Watchman query just to get it over with now so we won't pay
 		# the cost in git to look up each individual file.
-		print "*\0";
+		print "/\0";
 		eval { launch_watchman() };
 		exit 0;
 	}

Ben Peart (12):
  bswap: add 64 bit endianness helper get_be64
  preload-index: add override to enable testing preload-index
  update-index: add a new --force-write-index option
  fsmonitor: teach git to optionally utilize a file system monitor to
    speed up detecting new or changed files.
  fsmonitor: add documentation for the fsmonitor extension.
  ls-files: Add support in ls-files to display the fsmonitor valid bit
  update-index: add fsmonitor support to update-index
  fsmonitor: add a test tool to dump the index extension
  split-index: disable the fsmonitor extension when running the split
    index test
  fsmonitor: add test cases for fsmonitor extension
  fsmonitor: add a sample integration script for Watchman
  fsmonitor: add a performance test

 Documentation/config.txt                   |   7 +
 Documentation/git-ls-files.txt             |   7 +-
 Documentation/git-update-index.txt         |  45 +++++
 Documentation/githooks.txt                 |  28 +++
 Documentation/technical/index-format.txt   |  19 ++
 Makefile                                   |   3 +
 apply.c                                    |   2 +-
 builtin/ls-files.c                         |   8 +-
 builtin/update-index.c                     |  38 +++-
 cache.h                                    |  10 +-
 compat/bswap.h                             |  22 +++
 config.c                                   |  14 ++
 config.h                                   |   1 +
 diff-lib.c                                 |   2 +
 dir.c                                      |  27 ++-
 dir.h                                      |   2 +
 entry.c                                    |   4 +-
 environment.c                              |   1 +
 fsmonitor.c                                | 253 ++++++++++++++++++++++++
 fsmonitor.h                                |  61 ++++++
 preload-index.c                            |   8 +-
 read-cache.c                               |  49 ++++-
 submodule.c                                |   2 +-
 t/helper/.gitignore                        |   1 +
 t/helper/test-drop-caches.c                | 162 +++++++++++++++
 t/helper/test-dump-fsmonitor.c             |  21 ++
 t/perf/p7519-fsmonitor.sh                  | 184 +++++++++++++++++
 t/t1700-split-index.sh                     |   1 +
 t/t7519-status-fsmonitor.sh                | 304 +++++++++++++++++++++++++++++
 t/t7519/fsmonitor-all                      |  24 +++
 t/t7519/fsmonitor-none                     |  22 +++
 t/t7519/fsmonitor-watchman                 | 140 +++++++++++++
 templates/hooks--fsmonitor-watchman.sample | 122 ++++++++++++
 unpack-trees.c                             |   8 +-
 34 files changed, 1572 insertions(+), 30 deletions(-)
 create mode 100644 fsmonitor.c
 create mode 100644 fsmonitor.h
 create mode 100644 t/helper/test-drop-caches.c
 create mode 100644 t/helper/test-dump-fsmonitor.c
 create mode 100755 t/perf/p7519-fsmonitor.sh
 create mode 100755 t/t7519-status-fsmonitor.sh
 create mode 100755 t/t7519/fsmonitor-all
 create mode 100755 t/t7519/fsmonitor-none
 create mode 100755 t/t7519/fsmonitor-watchman
 create mode 100755 templates/hooks--fsmonitor-watchman.sample

-- 
2.14.1.windows.1

