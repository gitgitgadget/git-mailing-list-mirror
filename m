Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D478320954
	for <e@80x24.org>; Thu,  7 Dec 2017 15:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753716AbdLGPRL (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 10:17:11 -0500
Received: from mail-by2nam01on0119.outbound.protection.outlook.com ([104.47.34.119]:13483
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753562AbdLGPRG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 10:17:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=dYQzJx7hFMDxFEFrfdkRyLwUIoiJmKXZFeesxSjHhjs=;
 b=E7wedAPnOXc5yGuTGMyaiMcWm3Oi5gXU5trWuG67NxpdtrVGfhRo52ZENMIsDSMBIAxj2QKRI+THer3v1jm2XqnThzL86YjxocGpdYAB0Ztt2O0gUPUFtlqUGPRIoU97K4oNqr05aQI6Bf+0lJ+UsmzTAXC3x6k+OtB4UPYAAIM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 DM5P136MB0027.NAMP136.PROD.OUTLOOK.COM (129.75.96.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.282.13; Thu, 7 Dec 2017 15:17:01 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com, sandals@crustytoothpaste.net,
        peff@peff.net, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v5 0/2] launch_editor(): indicate that Git waits for user input
Date:   Thu,  7 Dec 2017 16:16:39 +0100
Message-Id: <20171207151641.75065-1-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [62.159.156.210]
X-ClientProxiedBy: VI1P193CA0018.EURP193.PROD.OUTLOOK.COM (10.175.177.156) To
 DM5P136MB0027.NAMP136.PROD.OUTLOOK.COM (129.75.96.154)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 464611c5-d6e2-4055-e4bd-08d53d8591c8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(5600026)(4604075)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(48565401081)(2017052603286);SRVR:DM5P136MB0027;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0027;3:ip5dEUOsbiwN2jc3WRQIBZVF39LcK7XWkcyLYPNMhf6rpnyJaU/0cQdjHBpER+5+Ny1N0hz5lTUyjkbnwf42jtNY8tg5V8BAN3elPrbqM178UD53xAz04Byhy17kBEH3GXBVXhlpYyEGboBkyL+WccjpWf+eA5USnanPCoIlBMeMmeFNAChYcBKCJAI4ZopPEHVyMWCKwktZstHf8kGhPPsIj6LPrztioedYI5AzOexggYHb9pWFnqUhzhv2cReH;25:hzOjZcc7uLc6wizK5RGATt+ghnVDI/cnKuo4aeJ4eB/yPm0F52h90igcfjbauzMi+thP32MZd+mCLhP8lqlV2efd8fehkJ8Ib6Q1oLgtXArVNj4tuHw2S1+NvVxeo3i467lCu2JxpWOT5USZS8AdjAd3yi/s47YZTEb4Can9RUPQ0Q7IkHOt8dLYCXDhSKZM2XhDxwmP3iK4omXSkgX5ObjemgHIVw776Gsl02Wp31tFAo/HgzBF8Sny9JQdgpdu7rvB2ckUAS2N/FV+ELqxIGp2RK8vt9iIy2Q1w0YWABB8CzBJeCMU6Yb08R4TDp9dzXud85bzf8Un67UKz/CtqA==;31:Soicg+6VFC5zgUtjBLlhmNaj8qtGGAUTk5CJJRjD9vnN/8NcyvzrbL44cvRmecgLl3S22WuxbdjLPsWgPzzzeQQoxcvpNGpBdLm7cIu5K5YRS0CwyxHjZLN0lJEAKtrsK1+2tiqfkvw2yp6eefFxiZTzWDwlDDLCY6rEUW6CykZMHzr1TtRefQ8LZ0vThuAxmSFjwywZsbgvCdCsZ35E+HRFOkXfAIi/bdUA9OVNYzk=
X-MS-TrafficTypeDiagnostic: DM5P136MB0027:
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0027;20:b8t8mIgx+gBKVeC5u5+W3ESLbrydBULVkghqDnfxW2WxBmEDaC8Ld5ESxpNu8RtJtZLs/D/ueowEUBOkX3MxnpPAcSy80H9whZ/rDtXvsmTp7K519FRfcWRIaVpU9118egCebPv/oVrwcyctbNjlUmiSdAToNMysOELtUKevFideCwhEZ4UN47f3YLCD6JzFxvp/XYgmv4SgaW+/yBP77yYqC2pqqfQLrhggUyOhYDMqDQTngfoGlgnHQ9HZ5ocfNZWLzH2LsvkTrWbMsiRT9LXrCx/fyknvkJOYr21TAew/aI6IxiqFeTtM6y5ler/QUtvYzVGfzMhnJe6wuXFn58FvnviAlb96P4y65sCYpyWee7fTSKFX8FRVUqZCw9cpU0NF6YVXlA0GqoAr6u8U0MsuccvKCP7Harys/XO+Zy5sXy+huH1cWK5a8hWGlOHaLReskIDJVgW1ROUSQ2WU6moJ+eio6WEEYnTDrRpwU2CU1JfdSK+YWQgn3JlVTmuw7Md56aSINQUzlY2sonoWwVmWbHGaBMwsORGv3+KtP+MQ+WMFkILJoXMjw4UMIUu9DXSb/s32G66sn4vOm8Gfs/g4eu1bs+Wte9NkNlXc+MU=
X-Microsoft-Antispam-PRVS: <DM5P136MB0027315A6D24C50FC648F9D3E8330@DM5P136MB0027.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(211936372134217)(61196332173343);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231022)(920507027)(6055026)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123555025)(20161123564025)(20161123560025)(6072148)(201708071742011);SRVR:DM5P136MB0027;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:DM5P136MB0027;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0027;4:IaBFo/IxZUYkuMaycDwi/zHRmMCWzvNtG+4KZICUtVnMIzPC213PBRMNpAWUuU+NCadLecXlhb/XoNWNWJ50S8Ro/FhLW7IIRLifm7x6G1HXl76LLocQEfs5Xi2Nx06kh2fN5aqBDY/7ymKe8X1em+0dIJBRYMpcp7ZCUYuV04FgOlOBWY0kkq35phhFS35cSqCblt43ytAQxnypawkgqy/IJmXPY7eFIfc6vmTIhps/UO87Ben7stxTuVjODd8ndupsR3xiBedllmq88/vhg3mqP/SXzuw+jqAnbZXrHTsAhzD2i5hS/TAu6hasd6yL4ppxzHVRZNTdM7wI0J0MNVEQ3blosPPrLYkIIKzAqLS4HEvMyv4ge9faaWWKrnut
X-Forefront-PRVS: 05143A8241
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(366004)(51914003)(189003)(199004)(81166006)(52116002)(7696005)(51416003)(85782001)(16526018)(7736002)(8936002)(50226002)(966005)(68736007)(81156014)(8676002)(4326008)(478600001)(2906002)(34040400001)(6486002)(305945005)(9686003)(6306002)(86362001)(53936002)(97736004)(39060400002)(2361001)(8656006)(316002)(2351001)(106356001)(33646002)(105586002)(6116002)(1076002)(66066001)(5660300001)(6666003)(25786009)(50466002)(101416001)(36756003)(6916009)(48376002)(3846002)(47776003)(16586007)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5P136MB0027;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5P136MB0027;23:LjlNH9xS4eO3shtyWnQByjj1FA9EhUMd5gdv0GpKN?=
 =?us-ascii?Q?jQ6wHx25D1od51RGRgPd4cyQxy17cKtm1f8dj6gDqX8iXHuUiQI0zTBz92EO?=
 =?us-ascii?Q?jBV7YiCOaXDYBFPLMpSHg8+OiSMy6u+Jmm/EAWFLaMVkIYa9n9bvthGJTe5p?=
 =?us-ascii?Q?HviLLsujTsWvdmkpbM8hLcZ4boYJMqhAPpdl9/310sgudET5isvLu29stSpO?=
 =?us-ascii?Q?pkx+qAQVoNlJMXlWneGB7vgmzADVDAfOfy616Ttdbjapid/4X/PIRE+W7tqM?=
 =?us-ascii?Q?zvook0XOBF+ga7unWgGVDssVzEQX419PnGs4QM0zCA0owbw0TwY4MNPWG67o?=
 =?us-ascii?Q?pMOQ8Ga36nlev0N94tZy/a8eAtjiQUK7DEGg2bYB0T5E48dq8+gQ+JEHUruI?=
 =?us-ascii?Q?7/sbmd1JVYCweh6rZGqaf/uDjixQS3GcSDDztDPNcwZj6YkVoY/JP0YtYBY6?=
 =?us-ascii?Q?Hazf4RlHDKQ9oAiqRqx7ONADEU0jBZC5g3/UvCCsefTwehJvIiml17LKK+5g?=
 =?us-ascii?Q?3Eqkoi7HmyaszOQlIyb12uz0NyIjEBJ9h/+YNQu+DtvqATfzNEgqnMdhkhMq?=
 =?us-ascii?Q?FS3JDq37TDYT1JQyoYnQGx2pxOs5QOwl4qJaoxjwaeaQs8HysgKYScICJRNN?=
 =?us-ascii?Q?IWQocxUwi51rTbXngt+5vKV6YpfFVwDJdmmO34tMI/B0rt30QHMFsRqYTPw7?=
 =?us-ascii?Q?yfztVmCs2agIt0nGaOBQnnKJTYlXcsEQWpL6uZ3hwa+6CO8qRU8Mvf8FG6ej?=
 =?us-ascii?Q?XGayeGPTbPn0f0fbLyOgD4q8AUPE1fdPYlaehhM2+u3OqCLh2aG6eZf9j+Sg?=
 =?us-ascii?Q?Ov/IR9qSOSdUUFIQxTUWZuiG9PV9SfwLwBtv887ZARhJvnSsrWvKlfi1cN9B?=
 =?us-ascii?Q?p/Qg8H2aLCkK16XghqTTD6vrfPRMz4i6nUfgCFilWaG02vBxbsVQJv8rGtaY?=
 =?us-ascii?Q?N/IZQzWCdpawiy/1DKswhHw5Vtku1oldGZlamKeNvtb97YpXpj8SkUySWyls?=
 =?us-ascii?Q?1P3A2zWbae9hQ6Tm540fdGSo+yimmXMdbo9bC2yk7TIbS0PrWNQoZgc554EU?=
 =?us-ascii?Q?sLL6V+YaktEmnBQ6K8hxE5Sc8YQyMVl3NstRAiPN4/O2nou+nRhs5UYhgmHJ?=
 =?us-ascii?Q?e+ir+RpcnRXqyjVx3gnt7tFQI+72+DgoPLThONJAiT68uF2W16Ij/kVjBwf5?=
 =?us-ascii?Q?RTgJ2Z0UoTF9lcyR+18s7ECNbqB7ZkrkBxbBZ/05PQ0l6sh1k/Be3+Unw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0027;6:NFx7r+lK92mf6333y5mmJd+Cwt5m2xp0dHXlpZVJ44fnOudrWO3r1Mtkktp9zhyX/Tkt2fvQbfR4xchhAsArIma4sHDtsXKvE+HENUjUyElE4gf+yvSrATe/P8JdiidpgHwvlsbfR6IIgmz3dK7MrsufgAu+fLhR/6hQptj1AEySEjPAF8nXbBEgZwI3JEdH4wIO3O7IBrBRFt0s6MmizCUqyslVzgpEd3cM1a60APQM2OsOcQuf7z3XboMn5k2vPs93OVUPXf8umd7KfLwMCYYgdeocpgUzjq33Ceb+Ef/6cskOMlJsoKzYL7mO+F9w2KhJT+0fSN53RS5sW0xJ6umDSOk+MIXeJ2+XHOEVaIw=;5:ptkR8BOiNT00gWHshUnysSyHNRaDugXXYyKU8riMz+R0qoaF3A08R8jilot3Pujmx0IEBUHJYEigxerDMPKr4BARsc2Ek3Z9T7xnpK5cleqBFd7GX0a8pxBcoXDWj02aWbOCiMqVzU/sqyLoS9ljDPD9ZbsKqa30FVsXeGQyUH0=;24:1p35nE4FD2eutEH88NoZdRedsnG59lcb7Yh05PZiFDhQySlclU7vfgLrGL7ujseO8HflGK/F7OTZv43CiwBXXQklhh7C0cVf131GdneQJQM=;7:s8e1U5khiKtqS05UQ3HSAm2MWmfC+/qViMPZ/ZzfKCaGAJtiNA5bcxn9E3vE12R7haa5zzWVTsX7VzHNOsdy7tbwKi6ST1Bx/WEkTVlEhE/WsHI/vLTEDdpOABLOZSU7hv/sk1WwQLVv4HTD9TNkigX1x641kTxk2HgNdjbfik2EUmW6JUDFNp/wjhXehXW0g//2xoyefEx8cGg2txYy7RCTVZOuC50jSVe7TWsFPtnKaHDoeqjVnM7Mh7wL8dXU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0027;20:lbtxl9fDF7ZCnfhFFLwnkm+ZAI1Ybnsvn7a3PeYmhhF4wzW0BJAJ0SdM1m0T310H5ABLAyDa4eJpYEQMbrSg8aCvRb2B16yhQdajR0rzXtDmULTp+083Dn3QRz1LGX2gAwAvb4/vvhANRCDE8LwjhXptgJahlVg5zqET0+oP7vc=
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2017 15:17:01.2974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 464611c5-d6e2-4055-e4bd-08d53d8591c8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5P136MB0027
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

Patch 1/2: No change. The patch got "looks good to me" from Peff [1]

Patch 2/2: I changed the waiting message to our bikeshedding result [2] and
           I enabled the waiting message on dumb terminals for consistency.

I also tested the patch on OS X and Windows with smart and dumb terminals.

Thanks for the reviews,
Lars


[1] https://public-inbox.org/git/20171130203042.GB3313@sigill.intra.peff.net/
[2] https://public-inbox.org/git/20171204220908.GA8184@sigill.intra.peff.net/

RFC: https://public-inbox.org/git/274B4850-2EB7-4BFA-A42C-25A573254969@gmail.com/
 v1: https://public-inbox.org/git/xmqqr2syvjxb.fsf@gitster.mtv.corp.google.com/
 v2: https://public-inbox.org/git/20171117135109.18071-1-lars.schneider@autodesk.com/
 v3: https://public-inbox.org/git/20171127134716.69471-1-lars.schneider@autodesk.com/
 v4: https://public-inbox.org/git/20171129143752.60553-1-lars.schneider@autodesk.com/


Base Ref: master
Web-Diff: https://github.com/larsxschneider/git/commit/c00d4de8cf
Checkout: git fetch https://github.com/larsxschneider/git editor-v5 && git checkout c00d4de8cf


### Interdiff (v4..v5):

diff --git a/editor.c b/editor.c
index cdad4f74ec..d52017363c 100644
--- a/editor.c
+++ b/editor.c
@@ -45,11 +45,17 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		const char *args[] = { editor, real_path(path), NULL };
 		struct child_process p = CHILD_PROCESS_INIT;
 		int ret, sig;
-		int print_waiting_for_editor = advice_waiting_for_editor &&
-			isatty(2) && !is_terminal_dumb();
+		int print_waiting_for_editor = advice_waiting_for_editor && isatty(2);

 		if (print_waiting_for_editor) {
-			fprintf(stderr, _("hint: Waiting for your editor input..."));
+			fprintf(stderr,
+				_("hint: Waiting for your editor to close the file... "));
+			if (is_terminal_dumb())
+				/*
+				 * A dumb terminal cannot erase the line later on. Add a
+				 * newline to separate the hint from subsequent output.
+				 */
+				fprintf(stderr, "\n");
 			fflush(stderr);
 		}

@@ -71,11 +77,10 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 			return error("There was a problem with the editor '%s'.",
 					editor);

-		if (print_waiting_for_editor)
+		if (print_waiting_for_editor && !is_terminal_dumb())
 			/*
-			 * go back to the beginning and erase the
-			 * entire line to avoid wasting the vertical
-			 * space.
+			 * Go back to the beginning and erase the entire line to
+			 * avoid wasting the vertical space.
 			 */
 			fputs("\r\033[K", stderr);
 	}


### Patches

Lars Schneider (2):
  refactor "dumb" terminal determination
  launch_editor(): indicate that Git waits for user input

 Documentation/config.txt |  3 +++
 advice.c                 |  2 ++
 advice.h                 |  1 +
 cache.h                  |  1 +
 color.c                  |  3 +--
 editor.c                 | 29 +++++++++++++++++++++++++++--
 sideband.c               |  5 ++---
 7 files changed, 37 insertions(+), 7 deletions(-)


base-commit: 89ea799ffcc5c8a0547d3c9075eb979256ee95b8
--
2.15.1

