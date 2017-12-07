Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B88B420954
	for <e@80x24.org>; Thu,  7 Dec 2017 15:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753873AbdLGPRP (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 10:17:15 -0500
Received: from mail-by2nam01on0119.outbound.protection.outlook.com ([104.47.34.119]:13483
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753563AbdLGPRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 10:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=alx+8xQvGTk+U+sjL8dStHueaX7G9Elt6LkEqWna4ko=;
 b=iTJsPfL7vz8bji1GifdX47M+roITZtLqgSzRr8fZMx7JAWf06HfJ62jTMcmdMOtpqeJ+uIoywXEz2DvWlGrJWcjhD1k9lvOmZRqfw289WvsZyihe6l+4SQNTAE8xHpAwSDQConll6smZCD/avz5NzlEfJ6mHe43XoGXve2nxeWo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 DM5P136MB0027.NAMP136.PROD.OUTLOOK.COM (129.75.96.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.282.13; Thu, 7 Dec 2017 15:17:05 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com, sandals@crustytoothpaste.net,
        peff@peff.net, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v5 2/2] launch_editor(): indicate that Git waits for user input
Date:   Thu,  7 Dec 2017 16:16:41 +0100
Message-Id: <20171207151641.75065-3-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171207151641.75065-1-lars.schneider@autodesk.com>
References: <20171207151641.75065-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [62.159.156.210]
X-ClientProxiedBy: VI1P193CA0018.EURP193.PROD.OUTLOOK.COM (10.175.177.156) To
 DM5P136MB0027.NAMP136.PROD.OUTLOOK.COM (129.75.96.154)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7b68eb9-0966-4b77-3cfb-08d53d859469
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(5600026)(4604075)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(48565401081)(2017052603286);SRVR:DM5P136MB0027;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0027;3:f2j3z9SFLXuD0GDXaM5doYwVrnBNTC9lMZiQ8WifAq289EZTOMNs87tjgCi7wma+Nv1rc3MS5tt8pNaVI1otIxtMoSrGG3cWuRH5wA9nOPyw9nn5YUo0codJFw/Fabf9hREmZKPtcN4b1Vtz6Xdi4Pc74gWwXKEBWQppjnDIEYyEN/81VhhErZoiHHg1ttILmtKN0kuQPKcPyzulB4b4OHr3XIHulVE02w3+gqx+i14XgBC9XTgOwM+mdo0Dm0jQ;25:mAjHL0QXgD28zBUjTyifQramWkTHl7suJGgSGASA9uDyaVbSToSg5i7/hUpYpWlu+28Fu8lBAsMkymA1uxs0xy2KWSKnbvuYQOq6ZICPEVu0daszUfWSWEwtQyfMPjvQcIERiGr2BPJUQcJ6lsdJQij4rlHcrLz8pw0YtABl3nFxhz6Ri1f6VEMU4WHDvLx8oE2kQhQyPlZHx9/HHDFn+LeKAKiC2x4fV8IawkP938T2IYE4kvW3p8uW+wdhBluz0j5o/FRC5tTGVWYzE67G7bjCS9O2X8hdjzEbRX9GVgVVU31+j9oaD6dsu+Pf349Z8MEuZ8kEdoCC820WBCoH5Q==;31:C4MG44bCcW1huIlg0cK0AKihTI4eaZ0gY/zgxEZkG45uDErxp+WM7vpJyhAak6PyD2O1uazAtxwXcu1LiUSj1mL8WZh6tXYF8TV98R31nO5HaGKkk7lEo7nhAuv50ThlkvNvJtpNrbGvOcS0pgbPMSD2qkh6R/YVQVD4glAHDNtAM2k+KXDEu2i1TEeeDmEFVDJ2CJ5YsH7YBsZE/Kc5KHIOf3I+HbD1i/kM48/aipM=
X-MS-TrafficTypeDiagnostic: DM5P136MB0027:
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0027;20:V0bdww08QYVRnq3qT2dblCEA90W3g0q+WQTqHHWy4z/HM46Ab64sGa1hqBCxtqrIT8EVpR3eANWJi2fkF6oW+UgEeH1V8C2zDwWblJwk7WSTeH2AhZ0lHyjyscD8U1zQM7KzBrGFLmKAQDXXkwXfyAOOW7RHBtWGxl2SFuvVH/94ZloUGNQB0hY6JOcR0d6ZNCgq85mkMgcCeDOLKZbYNj7ZoTUmTRPfV0OzqQnX2j27jFq7PZhnwMNLBUkgaG+Xb1JQQ7sYblziHcvfdqD77/gjKafL0x/nDzSc4Zt0nnxjkFjuXECQdxbOcIhoK3BcR5nlCzLMQqajA1VYpay8WcKuJnisX5UnUBdNWRS+Kzieo6ThtWgx/GMA8VExWiLMCmsd08WjvH+GeL7XryUs4mvfxkq1lR5/bwRELkMicFHOyppg+DzbdlzO0YRzH5EATMUFeB0MDE7Q/1c7nZqwZN1TqAck9TH3RniRlorqVecUQjhgbVq14HXklob7l64Qh7+HA2NyldyQ9A+rkmMBjcwNFIw4Ue/VCSeZlP2nM5xNJmK9UlnwngA5DE68VNcekimQ7+h4GvTjxuufuBYZyZZrFOUrx2ozY1tBIlvhn2g=
X-Microsoft-Antispam-PRVS: <DM5P136MB0027EE6FA2107B00B3BC398CE8330@DM5P136MB0027.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(35073007944872)(100324003535756);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231022)(6055026)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123555025)(20161123564025)(20161123560025)(6072148)(201708071742011);SRVR:DM5P136MB0027;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:DM5P136MB0027;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0027;4:wBKFNq+rt2/ztm+Yh3XrqsWcifnuJXk8BxbJ0oEPwwxkG5PZVOtGsBFYOLqSfzuctHsnDOqy5sFgsra6U7dD/7Z0e/mNja7ba8tX6VeLRe4zhiVKB4zSbScG/nap8m8WfP9MoanFvltI0zco2c6IRkWsE+PiJO12CztLkRWH2bbFu5nVAPL0GHuwa9sYwKc+5nab1HHHvWGsQsqXtEvopglfu8H6VWZxh8Arlzg9nfJx/cfhG2jubJ2Co1TmwqnC1FRXyzRb/fxn5ssFND5vtnqbZQsxPrBOjhOxG54334juROqBuS/vBgoJ218yrr2goZlQey20HtayW3pzyi5uEdzApJmr0KZQIHhGEq0pT7U=
X-Forefront-PRVS: 05143A8241
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(366004)(189003)(199004)(81166006)(52116002)(7696005)(51416003)(76176011)(85782001)(16526018)(7736002)(8936002)(50226002)(68736007)(81156014)(8676002)(4326008)(478600001)(2906002)(6486002)(305945005)(9686003)(575784001)(86362001)(53936002)(97736004)(39060400002)(2361001)(8656006)(316002)(2351001)(106356001)(33646002)(105586002)(6116002)(1076002)(66066001)(5660300001)(6666003)(2950100002)(25786009)(50466002)(101416001)(36756003)(6916009)(48376002)(3846002)(47776003)(16586007)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5P136MB0027;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5P136MB0027;23:suRrJ4IkxW0AW2mbyakkfEuc2biFQ9NDscEg0D+So?=
 =?us-ascii?Q?8oUDkJj3i47Q9WT9oTNfdK1Z9uXHZ8b5x6FKeKFbz7DMWW3i/wt3jqM70mMl?=
 =?us-ascii?Q?mRLEA92RCNEyv7473XSyb6Et1ixUbyZt1KezLC4VXrN8IVjvktUQemWB2Dbj?=
 =?us-ascii?Q?NwIyHZpXP6hSw+DdfhqVVRIr8zzeSw43FC45q2LHmmDjHmmhIxDiAPTuKHpA?=
 =?us-ascii?Q?EUKrixkvkpl224UgQ4wdxA1WFGDmWZtLBIeErykOW3BHN7xZ/kv9f1Df0J2y?=
 =?us-ascii?Q?LJt4aWtZst4XUL115uwDm7X3vQz7KnlIRkR04JyRjD/fDyPfeUFcQ3h7oBwX?=
 =?us-ascii?Q?oAZSji270d0GA8fNkiiIRhc3cIcUrhBNwm6WUcOS4oaJjOmncXfHL8JtNZWY?=
 =?us-ascii?Q?MEmPUg7nvvQ/EVAaRtUoPg5pR7Lck/1LO/xCDqdtg7gwaZGCdfgXTAKh5jh0?=
 =?us-ascii?Q?9PXFi01+zIyCPO9Qqm2YpvGyJX/dRFNZL0Mb+JIRhLBwUrad8JK8IuKGtvrO?=
 =?us-ascii?Q?9seNZsp23vxF5XdoxmNhfDMFT31pz3Lj5M4/ZkYoNoGCihy4WDTuG5lpuLhD?=
 =?us-ascii?Q?BuQjd97rDjgZOn4At/22KoVE4wGrxE6dH7InfbXAGfU46GaWzMb8FP6Kc+zr?=
 =?us-ascii?Q?rrn+WBd93FqvPiyP6UlES0ZZCnQ112fwrzxQiHyFvCqYctJStm3hOvniskB0?=
 =?us-ascii?Q?GotTrbJivXhJRmOj8WJUKINA6SCISxDW/Pj3Wo389pSAt9D+KW4bFW0hEDf5?=
 =?us-ascii?Q?RC5nrV0+pDF5oY0dJGTItfG3yruCbqxNxNBS/e3v5ySpsVh+gWVDC1+KeA9g?=
 =?us-ascii?Q?4GM63ZcTCkikKvXXo9MfgrCa4gkvlvmj7gRHGEGO5LpkRdK30ZXyXVRkG/3+?=
 =?us-ascii?Q?/4xZA2e2oJBRfj28KIDpT9atrh8r/ctHr0pDikck48n5P1J8N2yONTgQfrLc?=
 =?us-ascii?Q?vHPlOi7Rt4mI5FlX8QHATQCFLehen/KYtxCoXuvL1r98U2V5mD3fFX5uhrpb?=
 =?us-ascii?Q?vOfxjUeMlG5FGayxStRfqbEBwNnVKoe5H/DVZTmZB1UMZTaavCdYSThdTkXo?=
 =?us-ascii?Q?37RSFhemwfh7XDERuJRWHikPcDAKB3JxkWaXkdPYfAffICIvM0pdnzHKhSHD?=
 =?us-ascii?Q?A0cdmQvEmM5tKxsL6a5hInp4j31Qjl4DSyCD/1XyMogb8RWvXXsX9xf3hf1c?=
 =?us-ascii?Q?jLiFRBE3pxr6vG7ETsI4am6AUDjb2edUpPZ37kec7+AjOXQUGWu7W+ydg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0027;6:7LxyedyLmjgbf1NdR+uqJ26FDNiJhsp7OD57MPAlRCKAV0QYuiXWWCkHikFwibW2iFiC86BZ1Vx2836kuf4lqbLo82O34jcEmgwGCmxeQUAawfv/dukc+HmWU3cFjzs9oSGMVfLfjU+uEqs8MYTyLxomWBkbfDJsfF0ZXvkFW5n7sUWLeYA0RqRqkIiyqh4EHbtVqlBHeUTvqEb8ho2EtY7oLvnI/jSMTCVOopaIklQyDhTmX74sK8wsFy+Ezb4oGWroPb6P/c8GveR2VjM06cb+mWf5DxrTLw06PMNxo6/F6BnxoIOvKnw2Vlrqh5ALxo8vVNls8fGlV2w3L7ZUkAbHYIktxG/tYsq0luYMWDU=;5:s4sSlU3ok6XCkltB7LNhnTlqD3kL09MEuBA2JL8xA2+iDdoNqGS3wCCjuS9flTsqDCPXliw2gk7FYNDrSbaLFqQYX+2z2coO+eGoBrRlPkXIuBegVFv+QXR82F2+sEcaWawvL0l5L8qQ0gr1fxB3FUsE6x6Vr23VgjqtTCoiMJE=;24:ey08lNe9GU9FN0JyQmNO8N8x9n2G3Cw87bwZQAiQMA1iwQ+gsjqoB2g1jgl0luTktP2gWCcCt8pQ3oO5jpp1HM5H+mZt/tefVAW97EVypd4=;7:j+afTO1pVPbccjvweqyBqI91qUuyB8ieBB8C6JGaWCeW+4UfInLf2odDoGYIp/YDxfe/aeXoWdGTo+JUYBn3tFLl9xouaOOKCvqDpiShpBjVdvZB+NcTGM6hpX8+0xc+hyyaxlSx1YIB1tc2Jypu+Y5DNi621qQ2tRmY0hXomVP17QV4V16tk74hsSHjNNnBbR+d6IY9uOljLfjQwzL7so5qfwtVschdOtxImanoUneTBGG2DfeVLRvQ5WiPXm99
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0027;20:qMJw0j8q7/GkJv5H2fd0FCfJ0uVWX7Y78jpojmGP4NH4UG74YqJLuX6kyaGmdR5NjQVMtd8/SVUglwtFffyQD1w4hfoS9zWCiJM43CQ01vkjbP6C3mQVEcE16WNTSZA2y0WM9CE+S4wRaHP3gF92JdHIqImfF3ZyrrDUGq8qt5c=
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2017 15:17:05.7037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b68eb9-0966-4b77-3cfb-08d53d859469
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5P136MB0027
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

When a graphical GIT_EDITOR is spawned by a Git command that opens
and waits for user input (e.g. "git rebase -i"), then the editor window
might be obscured by other windows. The user might be left staring at
the original Git terminal window without even realizing that s/he needs
to interact with another window before Git can proceed. To this user Git
appears hanging.

Print a message that Git is waiting for editor input in the original
terminal and get rid of it when the editor returns (if the terminal
supports erasing the last line).

Power users might not want to see this message or their editor might
already print such a message (e.g. emacsclient). Allow these users to
suppress the message by disabling the "advice.waitingForEditor" config.

The standard advise() function is not used here as it would always add
a newline which would make deleting the message harder.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/config.txt |  3 +++
 advice.c                 |  2 ++
 advice.h                 |  1 +
 editor.c                 | 20 ++++++++++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 671fcbaa0f..de64201e82 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -354,6 +354,9 @@ advice.*::
 	ignoredHook::
 		Advice shown if an hook is ignored because the hook is not
 		set as executable.
+	waitingForEditor::
+		Print a message to the terminal whenever Git is waiting for
+		editor input from the user.
 --
 
 core.fileMode::
diff --git a/advice.c b/advice.c
index c6169bcb52..406efc183b 100644
--- a/advice.c
+++ b/advice.c
@@ -18,6 +18,7 @@ int advice_object_name_warning = 1;
 int advice_rm_hints = 1;
 int advice_add_embedded_repo = 1;
 int advice_ignored_hook = 1;
+int advice_waiting_for_editor = 1;
 
 static struct {
 	const char *name;
@@ -40,6 +41,7 @@ static struct {
 	{ "rmhints", &advice_rm_hints },
 	{ "addembeddedrepo", &advice_add_embedded_repo },
 	{ "ignoredhook", &advice_ignored_hook },
+	{ "waitingforeditor", &advice_waiting_for_editor },
 
 	/* make this an alias for backward compatibility */
 	{ "pushnonfastforward", &advice_push_update_rejected }
diff --git a/advice.h b/advice.h
index f525d6f89c..70568fa792 100644
--- a/advice.h
+++ b/advice.h
@@ -20,6 +20,7 @@ extern int advice_object_name_warning;
 extern int advice_rm_hints;
 extern int advice_add_embedded_repo;
 extern int advice_ignored_hook;
+extern int advice_waiting_for_editor;
 
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
diff --git a/editor.c b/editor.c
index c65ea698eb..d52017363c 100644
--- a/editor.c
+++ b/editor.c
@@ -45,6 +45,19 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		const char *args[] = { editor, real_path(path), NULL };
 		struct child_process p = CHILD_PROCESS_INIT;
 		int ret, sig;
+		int print_waiting_for_editor = advice_waiting_for_editor && isatty(2);
+
+		if (print_waiting_for_editor) {
+			fprintf(stderr,
+				_("hint: Waiting for your editor to close the file... "));
+			if (is_terminal_dumb())
+				/*
+				 * A dumb terminal cannot erase the line later on. Add a
+				 * newline to separate the hint from subsequent output.
+				 */
+				fprintf(stderr, "\n");
+			fflush(stderr);
+		}
 
 		p.argv = args;
 		p.env = env;
@@ -63,6 +76,13 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		if (ret)
 			return error("There was a problem with the editor '%s'.",
 					editor);
+
+		if (print_waiting_for_editor && !is_terminal_dumb())
+			/*
+			 * Go back to the beginning and erase the entire line to
+			 * avoid wasting the vertical space.
+			 */
+			fputs("\r\033[K", stderr);
 	}
 
 	if (!buffer)
-- 
2.15.1

