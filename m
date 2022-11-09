Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FA3C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 18:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiKISXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 13:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiKISXK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 13:23:10 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669F328724
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 10:23:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMt/H/hoGDfg62VQFlLwMgsm1D3m3RqiWKRZXT37iXizfbDd+lpl0yHfyrkVFUU+6EBt5cdg7LpnnTvVdwARHArmbO98elv7cQxcYuG9DYyAFf9sBxESJxNdbkwM9Y3nW9cC2rLky8O2S1zLYa6s/F3vCfNPTJUM8qKxd6nPpFzONxrnoWfh3HUjtsMcfGRb9y449UWgDKYGNB4O7nNi0GMyvtxadVINGsSLvI2wINw9WD0y3AI1cgX0MFZpogBmekpDLT2dqHVobv4fG+pyQXvur6LVjPYrX6lpeCsGABwrMsP3ew2zvP4RmZ0Ln/rkXkeNLp5jGVuSeHv1Wv1Gfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAP7p9ata+E2sozEaVhzjNxhEiTyUC3GEpomW1h9sKs=;
 b=NK7PrF2/X2S3ZKUrW/phfk1FPC4y6OWtxnFG2YphSU2wlu+57uCNYuqbHX6b+rUfiM/QC+tmgmOPTL7iQ6wYLbG28QeGMT0IZYVst+ZwGJYmoZB57i2NAqGbla7lQ5CcjOEQXJVmU4NlGe/Oof8NqJBGxRGe6WUFcagRX14IL8221DBhI7C/kaRNLSj21S1YiqUHL40p3ZT1LjPyuZFLaGK7ltsX8NzsRV03ng6ZQ7fdSHEWM8pPkshDjtAHu5y6m8SFOc+ZSnCWCBe+HPOw8bVoyhNthBg4hnONTP2gFtGpB5N1Uuh9KU84aLa5f3ow6ifJk4dzMJ2dZehD5ks+sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAP7p9ata+E2sozEaVhzjNxhEiTyUC3GEpomW1h9sKs=;
 b=1Z/FB0XoxuWt+hf3Yscyb57Z9F0OKHreOdxXNB5UgH+Bm1QQkEy/kP63w96ZSrD7vND4fGv5zyv4MYsqD01i7EKnosl2q7Cf7kS471RLJ8DG2UqENAhXyXjJImrR6EBUDyZ7R6pcAgPdhS4+tdqf0QLE1UW4BYq1RKckEe4SccQ=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12; Wed, 9 Nov 2022 18:23:06 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::aaf9:9bc:a3a7:45d0]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::aaf9:9bc:a3a7:45d0%5]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 18:23:06 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] Change git-send-email's sendemail-validate hook to use header
 information
Thread-Topic: [PATCH] Change git-send-email's sendemail-validate hook to use
 header information
Thread-Index: AQHY9GhQdqchLAcPUkuZUVJFlMi5kw==
Date:   Wed, 9 Nov 2022 18:23:06 +0000
Message-ID: <20221109182254.71967-1-michael.strawbridge@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|MN0PR12MB6077:EE_
x-ms-office365-filtering-correlation-id: 989ca755-9dbe-4e97-7894-08dac27f72b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AyUvwto+lkInTHtbNrcMA/+KPFWexBRErPGQ73fexa1s7ejSkkJrcV26obdVM3sBLDQCflAhC9UwSbH5QzeacRKnLpCdBN+EfqlT61vZEYOo/bThwQUGTS1vBfMEWdoTM0tRP55h+Z2ETAdQQAZDF8Ea+/9RfwNLmbdh49bVGSnuE3CwUHHA/kMddq4DyoiQhQDazCgZzkO/GZdY1j24sjpXq2oW1hhkPA8kKVuFzTrX4t/cffF/tpa4NUf3W9XzEulpg7vVri0e6RB9ludnuHGShVsze2XSim2SG4sLym5J4heJA/dj4JIQgVpidGWQYq2YeVyR0uTaOHJualP6yWH5EmqmKc8NDOwk8xtcnyRMQYMtSkOXwr9o4lcL3N1lEhy+HlMj8Hyx66T0vcoFmdevlcjlhFIAe/L3s0U7QcK6bihrYMM4KVbj2lfB0+joF3Qihu2YSFzVy7Y73tmpME2vPQGwDoTNjRjz94MSnO0hJwq+m35sJImqtTKfmZ1GeFkA89aU6U0xiJ2+8rmK1TosbryjVzbXT1HzpOO0QYdcXyHTzHQ9xQSDdmT/lEvBFXoF1JCLNC8HsvaLsKf4E26LVAiS44gS8sLygYbhr2fSiDDU3fEbY1BKGc4PLwySjlfXopUrJvqoTdBIybVH6KY6wJihelXCPL9SVtkzfdVhgNHS/zjQ1eCIyYwYdm8SdAnFDUynlEiIbHFIkCk/N7mvodd14zVAhRFfNG2JzH69elJuAg/eSnC8NC1QfRHiwjT1LMyFVg2BROxc+TaC2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199015)(478600001)(38100700002)(6486002)(2906002)(38070700005)(71200400001)(15650500001)(2616005)(83380400001)(186003)(1076003)(122000001)(26005)(6512007)(36756003)(64756008)(6506007)(316002)(66476007)(66556008)(66446008)(4326008)(8676002)(91956017)(76116006)(66946007)(86362001)(8936002)(5660300002)(6916009)(54906003)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2nhGEwZS3Hy/rGbyWUiyESaO+AYKIHiM3TKDH0d1V6onyXrc++W2K9ngRA?=
 =?iso-8859-1?Q?PBtokKvogrOnj8pGNHg2U3C3URk0kJe8nEcZrY5U+JeoaTaiqY1aMMJCoL?=
 =?iso-8859-1?Q?OQQeZ9abih3eGJSuy4wq+mL4RCPqqUP7xMXTUa7HFgoPghEp1uJkNU5xDt?=
 =?iso-8859-1?Q?XNI0Angd4MIav4qn4kw9Q2fi9Kjjwhp0KJdtJ/9WKuqFcyKX0H2kdUUenY?=
 =?iso-8859-1?Q?7kZh0Mj+Kqt733W3VmHVtvU+lpUu9DVddcsxWbHkxk/GrTRZ+MepuzYS4O?=
 =?iso-8859-1?Q?HNWqFeke7z5n9aVpsXmcE/RymR5LGgAqp9mZTXaUDktBLXItTAvtSyJppp?=
 =?iso-8859-1?Q?Z8qAKpUlTg14hfuvy6Bh7smbWcelxaSGztKKXWJzedSc2KFYlaAMIbTWuw?=
 =?iso-8859-1?Q?Y2AYuh/1zKCu5QK05FynWXXPY/xqqlZSy1RJBTDMSimMvr6vgAEi9UiEMD?=
 =?iso-8859-1?Q?oJU8t+rDMGnvo2/SJns7ia8bi/PFlh3VmYE6uxvurVxGj1bumYBdOQr0lj?=
 =?iso-8859-1?Q?zuWZd1RjBbg+0W4Bq36UZ/ZXN28MrlesRpAFKhs/XrgfIaD/UKp2ygvVpX?=
 =?iso-8859-1?Q?p9IrwM68Y82WKhgeQM38vUScsT/rq5zMwuYJp1DUrW2gLoLY9QYHMyWany?=
 =?iso-8859-1?Q?BOaLcbUemoOGFG3gQUE7udC8ezfsAJw8iMo6reUkfIRXNJof8s0kn82hSg?=
 =?iso-8859-1?Q?dIi+7zexst4JTqs7RqIEczdb75H6sLLIcvGIlm5g2N43xkxIcbWr3fvy7D?=
 =?iso-8859-1?Q?X44W3OYfPd2TSRB85903Mv8ApGbSZYyqUhBw35k38O7UWrcQrn8CucKxkb?=
 =?iso-8859-1?Q?3/Z50rBAplmtmgFYeuzMLz8ML7HUU7yyVMTyZ6gkUbnpPUPnCQTc1nI8+q?=
 =?iso-8859-1?Q?4e/vYPuUJzs7hStsN6BSifwFpDCKT1OlpF5hDkDqEyf8jS16y9lWqhk5b1?=
 =?iso-8859-1?Q?bAY1Aaa5CnkAYmlPg5KH0eBgeKvjTnTI4Camt4ViUanKSW27HARBqv7ZzL?=
 =?iso-8859-1?Q?pttgvLtLoGcNheh2CwhkaLHPdkWBBKVy6ASy4NxdKcekmfOpxhKeZ8WfMg?=
 =?iso-8859-1?Q?Z7VcdrSFNLMpPuBoNGo2huUd0/w/VDa2weoxra1ESMBWTBkRl8UKAAIC+d?=
 =?iso-8859-1?Q?0tskhet1i8Vha9hRVlrdOelAuTX4APtyV+PWCi0LXVLx0kVIf673DMY48d?=
 =?iso-8859-1?Q?3iVnVcxdytTGodnkOO+fW6/J4ADYjPr2VoD++cIJJeDBjxkHlItZvAayB7?=
 =?iso-8859-1?Q?mGeb5JHCW72mitQXJ/hngkvmelnRI3RBBw2B7FtFyOMcMjDCFHOk4/sRtd?=
 =?iso-8859-1?Q?X6fVA1UKPY79X8uinwbBmhdYsOVog81CUgRgbV8mGL3aqq4HnvHTuXRSJF?=
 =?iso-8859-1?Q?5lcqEYTxqPnQD9LqMVTW+EVEJRPMT2wMA0Mo44vrmxgwidFODpDhfPspmv?=
 =?iso-8859-1?Q?iRRejSD9WDaRHmLfV7r2CgR2vRiqGHbuWoehA9FT4QdwWsymxhYSbTaFsR?=
 =?iso-8859-1?Q?84A8+RYPaX2QgLfw6gUPqVR9JBK+OkhyROoic5t537kjKBI7/dbUDW5fGp?=
 =?iso-8859-1?Q?Ag5io2ceJBj+KiGmRrunj1uiaEGsll84KkFxhIgtVPm5lzpWRjzzFb2PkY?=
 =?iso-8859-1?Q?Snx2HB6vRSQmGhR+cxLFXMM0OuQN0MJzgv?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 989ca755-9dbe-4e97-7894-08dac27f72b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 18:23:06.7189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZrYTMW2li2wB56Rx/+JG22IukMenqEQJCosUYCOcDY5Iql2aIInFq/3fdHvwtn2oZqaehvWfu+nHddH1tHw2GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since commit-msg and pre-commit git hooks already expose commit
contents, switch sendemail-validate to use the header information
of the email that git-send-email intends to send.

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-send-email.perl | 57 +++++++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5861e99a6e..3ea6fda48e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -787,14 +787,6 @@ sub is_format_patch_arg {
=20
 @files =3D handle_backup_files(@files);
=20
-if ($validate) {
-	foreach my $f (@files) {
-		unless (-p $f) {
-			validate_patch($f, $target_xfer_encoding);
-		}
-	}
-}
-
 if (@files) {
 	unless ($quiet) {
 		print $_,"\n" for (@files);
@@ -1495,16 +1487,7 @@ sub file_name_is_absolute {
 	return File::Spec::Functions::file_name_is_absolute($path);
 }
=20
-# Prepares the email, then asks the user what to do.
-#
-# If the user chooses to send the email, it's sent and 1 is returned.
-# If the user chooses not to send the email, 0 is returned.
-# If the user decides they want to make further edits, -1 is returned and =
the
-# caller is expected to call send_message again after the edits are perfor=
med.
-#
-# If an error occurs sending the email, this just dies.
-
-sub send_message {
+sub gen_header {
 	my @recipients =3D unique_email_list(@to);
 	@cc =3D (grep { my $cc =3D extract_valid_address_or_die($_);
 		      not grep { $cc eq $_ || $_ =3D~ /<\Q${cc}\E>$/ } @recipients
@@ -1546,6 +1529,22 @@ sub send_message {
 	if (@xh) {
 		$header .=3D join("\n", @xh) . "\n";
 	}
+	return $header;
+}
+
+# Prepares the email, then asks the user what to do.
+#
+# If the user chooses to send the email, it's sent and 1 is returned.
+# If the user chooses not to send the email, 0 is returned.
+# If the user decides they want to make further edits, -1 is returned and =
the
+# caller is expected to call send_message again after the edits are perfor=
med.
+#
+# If an error occurs sending the email, this just dies.
+
+sub send_message {
+	my @recipients =3D unique_email_list(@to);
+
+        my $header =3D gen_header();
=20
 	my @sendmail_parameters =3D ('-i', @recipients);
 	my $raw_from =3D $sender;
@@ -1955,6 +1954,15 @@ sub process_file {
 		}
 	}
=20
+
+	if ($validate) {
+		foreach my $f (@files) {
+			unless (-p $f) {
+				validate_patch($f, $target_xfer_encoding);
+			}
+		}
+	}
+
 	my $message_was_sent =3D send_message();
 	if ($message_was_sent =3D=3D -1) {
 		do_edit($t);
@@ -2088,11 +2096,20 @@ sub validate_patch {
 			chdir($repo->wc_path() or $repo->repo_path())
 				or die("chdir: $!");
 			local $ENV{"GIT_DIR"} =3D $repo->repo_path();
+
+			my $header =3D gen_header();
+
+			require File::Temp;
+			my ($header_filehandle, $header_filename) =3D File::Temp::tempfile(
+                            ".gitsendemail.header.XXXXXX", DIR =3D> $repo-=
>repo_path());
+			print $header_filehandle $header;
+
 			my @cmd =3D ("git", "hook", "run", "--ignore-missing",
 				    $hook_name, "--");
-			my @cmd_msg =3D (@cmd, "<patch>");
-			my @cmd_run =3D (@cmd, $target);
+			my @cmd_msg =3D (@cmd, "<header>");
+			my @cmd_run =3D (@cmd, $header_filename);
 			$hook_error =3D system_or_msg(\@cmd_run, undef, "@cmd_msg");
+			unlink($header_filehandle);
 			chdir($cwd_save) or die("chdir: $!");
 		}
 		if ($hook_error) {
--=20
2.34.1
