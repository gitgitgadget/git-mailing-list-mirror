Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DE1C54EBE
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 01:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbjAQBkF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 20:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbjAQBjq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 20:39:46 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D401229E3C
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 17:39:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmHe1SDlk0AL4Pko8V+sBOLbqAhcSnzt3OkvJ2NabUchI/QUTQR6XNKiZ77gbkfP7k9IvH4reErwT5So93OjLcnvY45hE0jUUlGnpIEKhVaRGwE9UEqbUL1RqkQY9kE30gW964nZ+EevW6dwE6V//5Ug7Irn6pb2xwCoTIrUwVjisAocpBJH4KlWciVTfDcxbEwYm2aaTE6I8AvWaAzHTm7imCIrB44jQdDmT56owTxwnSMNGsdWhD3vLCuw2Cz4c2rc9OqWGBF4prnScaMMG2TpKIs6cD8KV2CjS3AUcZrIKeAuKCrNldyxIb5GGg/p+lyTw1ChYWNRLRJWTg/54A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DyAUqG3b9/btB8pZwR/kWEKxSxFoTgTjgmQu0O+N5U=;
 b=XNbsL+y+Ule9g2xLbmWx5IuHsO+2j2AjXenpTR31TaYpgcEZO47tec1dM9+eqmZtn2mbDR7zUt9F+uPegZcXuuzCfsghaqIuhyMBmMvEiBaaZpMXilI3Vmhmubuc4Axv0iIvda+ltWyIRRUxOZQ0wRy5IDn0amY3ecQrY8DeSqUPdGiTbkbyURNgTVZnHM98Ga4z4SwGF0kjxXKgvTcKWofHbNstt+gfR9i+Q84YwkKsIi7+3rxfXRjjFdfW7U2jOTtEVJ+IJ+eovhBjIpJI5qFK5OiCOMkMqGQGPf6Zg2IvDhIp00TH3jnj0Y2z1/bSUVcPCbMRx7ybFAmsORVrsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DyAUqG3b9/btB8pZwR/kWEKxSxFoTgTjgmQu0O+N5U=;
 b=uYb3g0tmgypQzBvUAL6cpowaax/XOmtRGcJUcoPOuSrpRgrYA95EChA1vWk/ChF2bPq758pJiEDMRCTz76o4L1hMBnpjAnHeTL5E+vsjHlZigmwHtwUa+kr6kYlZOwfkmMKPPyC8R252KuP7NE0lAekrlJRBalUDeVXA2qwDBy0=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 DM6PR12MB5518.namprd12.prod.outlook.com (2603:10b6:5:1b9::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13; Tue, 17 Jan 2023 01:39:43 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77%3]) with mapi id 15.20.5986.019; Tue, 17 Jan 2023
 01:39:43 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Thread-Topic: [PATCH v6 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Thread-Index: AQHZKhSS7YRHI5G1yk+daSce60b9bA==
Date:   Tue, 17 Jan 2023 01:39:42 +0000
Message-ID: <20230117013932.47570-3-michael.strawbridge@amd.com>
References: <20230117013932.47570-1-michael.strawbridge@amd.com>
In-Reply-To: <20230117013932.47570-1-michael.strawbridge@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|DM6PR12MB5518:EE_
x-ms-office365-filtering-correlation-id: be7b5833-1db5-4817-8d9c-08daf82bb4f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q0ou63iixF/LZcqC3UpkZnUxXm0qHaRhk92SbCSpNKsXBTtjHWncgWq9eC+kzVJaFEzEo9syo/+zmB7uLnAUJ5S1rkisqNYj5Kn0yAd4gPSFT1p8fhNFPy7NAxS/aEIavtFYGE3sJO3uWMsHI31eIK4mRVNN/ubufwpeiGQeuAe3BELN9HCqnkexjwCh7FigHNlmhH965qYXF15EgQsnJFQT+02+dYlU91y5a1wuf9wiJL3Yhhm9qbtabuwtvwiMBfT3Mlm2focgUWAOupdTjP969tHLcgqIJhVmHaP75jsvhJn/itlZI1rgQmhhdRnQE3CkyN0OWbcQjJcaAEa1POZJLiEXKxl/ft45AZVo/V0z/mqHxxkBIL5GOs0SQuzCeH8FuYhs/5j2q+H0tSKQETAbxQpGWxEyg3+T/mHUQnBp/e9TLcuQh57EzuQuQSIfU43N4/EVm5xPAWJ9MJP7U7hb9B4QfQ5EnUCy8Kz+vw0vONw59b8jI/ME5gvFa6QckYBOA1UgzRv97qZ/9wbTO4KbAGllXNXhPxSy0qVB3BbMDFCi243YLU5ZrkR9fgVBJmJTnu/e7AHr47q4oqzZaN2mllAHh7OXCOFiMsOoBcn87mxh2ppgLkedw8Gb2idlTCMVk4mA0Is+4Rf878caVAcCISOea6EeMrS0btURwU36g16roDT2pJd8hPLSWZVZA1HtGh320d2DwryqrquynA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199015)(36756003)(478600001)(71200400001)(6486002)(54906003)(6512007)(26005)(6506007)(15650500001)(2906002)(41300700001)(8936002)(5660300002)(316002)(6916009)(4326008)(8676002)(91956017)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(122000001)(186003)(38070700005)(38100700002)(2616005)(1076003)(86362001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LMljlWf/cM9B6vOGk69z5HVdswGQNCEWiANdzLcUusFLCSTtOaX+zQaoMJ?=
 =?iso-8859-1?Q?2wVJDRkpASkzkdGHla7+97m7fv4413xJ7JrtjxfJBq9/xKO0h0mgmrYM/C?=
 =?iso-8859-1?Q?o2orZjRceLprYctTunBRx/X/wv8wj0SFasIlGFWrcdsUz+7/khCtmqz8Ui?=
 =?iso-8859-1?Q?E6NViYI3/nQGjBiTMBWlZC9TA8u06a0erOgJmJRnASAWoAM8/WoOjIYX/T?=
 =?iso-8859-1?Q?dueqU0znnqZqCk5Y61yUKT11xjsbekVk8WgnnqrpGaWW26H9i9JNB7n/80?=
 =?iso-8859-1?Q?45auUCCaM1B99Dx+JkxNbaJXDv1VoaL3SW0J+mnpc3TzBGxgbkux7pYzJb?=
 =?iso-8859-1?Q?evVNqItbcgoXVa68IPtBTQg1B6Jr3d9Ml/1ne0/pLwcJ6zD/bCDVmb93/E?=
 =?iso-8859-1?Q?IjzkURTrO40dIzgZG59UpldyBSsKu46VwGYpzLer+VTW/N/GbpuXXaryDk?=
 =?iso-8859-1?Q?5r8iZ+xpZ5nLFyXvtjHdp4m0Ifkv0m1HXrE0tQ+N+w3CtzMTb4oe/pzPJ1?=
 =?iso-8859-1?Q?gZ2hNhjn5XJqTU6gEO2pNfUwQ2N+tQUHKTDLeSfUcCKfSBs4xc8M7HHm6g?=
 =?iso-8859-1?Q?+HBwCuRBo7xoll4q08AGz6T7TFWSqfpf2PX6lfKFJnNkLigGa/OQc90ab+?=
 =?iso-8859-1?Q?1oEIjHSi9PiGnDqlamtMmdRAKF2fChbMPpO1hVwqD3CwQ3hKm35OytpgYF?=
 =?iso-8859-1?Q?rRwdX9i5aPC5RIgh2p2rs/K13cJjpI2VRly/i2pMRmehXdwEp7aBfs2IK6?=
 =?iso-8859-1?Q?BInAUcT605aj7tehueh9Qm2fjwyQLlBBQxZN0rbE1+snIkr3LC0s13AsX7?=
 =?iso-8859-1?Q?+FZZ15r5CKtpZy9xZ31VEt7eiInoT6E6fnNakRjbG0tp1xV7jSnRkc76Sa?=
 =?iso-8859-1?Q?IoMHh5T4o/syerNhAWnnqB2819MnhYJIomdvtZtI0kGpqR0DwLewgMQQJp?=
 =?iso-8859-1?Q?BpwI8GH4TzXlrmv2HX2ClFNKRAPZYQnK2ZCYAGC/mU2uVfIE/EcHEO0uaD?=
 =?iso-8859-1?Q?WcjYo8b/0IN/KTEDxjYbkRUInLgRzhUegCmzl2Nmfw6CY+tqvNcqCqcjH1?=
 =?iso-8859-1?Q?HpMjG2KQTcsQ3FeQcYcXSWsOdY+/4YjSt2f9vVeToAlEWZO23QpBVuZj7w?=
 =?iso-8859-1?Q?kQyO+byiesdfrwvi3l6rN0O4L1Yc3i0LDGrx8yp6XYUc+OzW1quMDyVnOd?=
 =?iso-8859-1?Q?gB0vtCE0AAurljyf0KmvyaodCAHYLoOBGCrzik0D5toGrgMtmbBVatOxyR?=
 =?iso-8859-1?Q?66RjRC31VM/lOqLT0hKwAaJvn+7xatmNQb7VMbCgKNxgObQqxQX4GJRk/C?=
 =?iso-8859-1?Q?c7i4kjnFnd+hvfEejpMm0Gpytgx1C61PluxPl2gE1Xp4bo6hXJBhTBS5EH?=
 =?iso-8859-1?Q?Flhdw9HwuGPUNUJrzm/fLTtSWyPR1kTdwYlotLENjrMoQZGc07vK+iOwPo?=
 =?iso-8859-1?Q?OGM7J2mdNZm46EuvKQ+HA9PgqsoGGN4tB409srqWQFjxCcUuuvc9GPj327?=
 =?iso-8859-1?Q?CfKOh6UdIFXAaw+W8sjfj0dSPBPAf4HpfHdaD27nl0U5DA7sRr8QIetC0l?=
 =?iso-8859-1?Q?em7Ps8OWsMYuzeFgGo6sYkglHYdBKnoICHyLT29/EE7eWYf1OsDbuCi6//?=
 =?iso-8859-1?Q?4LiD+R44RX9Cl0NOfT2806tvhyGJ25NI/C?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be7b5833-1db5-4817-8d9c-08daf82bb4f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 01:39:42.9267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ymhARyBa0NVrVlBotB25k8HWXKM7z9+sHV0G/z8v/cdrBvat9TSH8DoNSf21XA5z/FpjrgDdJiMUroCfxdRCTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5518
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To allow further flexibility in the git hook, the SMTP header
information of the email that git-send-email intends to send, is now
passed as a 2nd argument to the sendemail-validate hook.

As an example, this can be useful for acting upon keywords in the
subject or specific email addresses.

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>
---
 Documentation/githooks.txt | 29 +++++++++++++++++++----
 git-send-email.perl        | 31 +++++++++++++++++--------
 t/t9001-send-email.sh      | 47 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 91 insertions(+), 16 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index a16e62bc8c..e80f481efd 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -583,10 +583,31 @@ processed by rebase.
 sendemail-validate
 ~~~~~~~~~~~~~~~~~~
=20
-This hook is invoked by linkgit:git-send-email[1].  It takes a single para=
meter,
-the name of the file that holds the e-mail to be sent.  Exiting with a
-non-zero status causes `git send-email` to abort before sending any
-e-mails.
+This hook is invoked by linkgit:git-send-email[1].
+
+It takes these command line arguments:
+1. the name of the file that holds the e-mail to be sent.
+2. the name of the file that holds the SMTP headers to be used.
+
+The SMTP headers will be passed to the hook in the below format.
+Take notice of the capitalization and multi-line tab structure.
+
+  From: Example <from@example.com>
+  To: to@example.com
+  Cc: cc@example.com,
+	  A <author@example.com>,
+	  One <one@example.com>,
+	  two@example.com
+  Subject: PATCH-STRING
+  Date: DATE-STRING
+  Message-Id: MESSAGE-ID-STRING
+  X-Mailer: X-MAILER-STRING
+  Reply-To: Reply <reply@example.com>
+  MIME-Version: 1.0
+  Content-Transfer-Encoding: quoted-printable
+
+Exiting with a non-zero status causes `git send-email` to abort
+before sending any e-mails.
=20
 fsmonitor-watchman
 ~~~~~~~~~~~~~~~~~~
diff --git a/git-send-email.perl b/git-send-email.perl
index 810dd1f1ce..b2adca515e 100755
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
@@ -1738,6 +1730,16 @@ sub send_message {
 	return 1;
 }
=20
+if ($validate) {
+	foreach my $f (@files) {
+		unless (-p $f) {
+		        pre_process_file($f, 1);
+
+			validate_patch($f, $target_xfer_encoding);
+		}
+	}
+}
+
 $in_reply_to =3D $initial_in_reply_to;
 $references =3D $initial_in_reply_to || '';
 $message_num =3D 0;
@@ -2101,11 +2103,20 @@ sub validate_patch {
 			chdir($repo->wc_path() or $repo->repo_path())
 				or die("chdir: $!");
 			local $ENV{"GIT_DIR"} =3D $repo->repo_path();
+
+			my ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header) =
=3D gen_header();
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
+			my @cmd_msg =3D (@cmd, "<patch>", "<header>");
+			my @cmd_run =3D (@cmd, $target, $header_filename);
 			$hook_error =3D system_or_msg(\@cmd_run, undef, "@cmd_msg");
+			unlink($header_filehandle);
 			chdir($cwd_save) or die("chdir: $!");
 		}
 		if ($hook_error) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 1130ef21b3..346ff1463e 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -540,7 +540,7 @@ test_expect_success $PREREQ "--validate respects relati=
ve core.hooksPath path" '
 	test_path_is_file my-hooks.ran &&
 	cat >expect <<-EOF &&
 	fatal: longline.patch: rejected by sendemail-validate hook
-	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <=
patch>'"'"' died with exit code 1
+	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <=
patch> <header>'"'"' died with exit code 1
 	warning: no patches were sent
 	EOF
 	test_cmp expect actual
@@ -559,12 +559,55 @@ test_expect_success $PREREQ "--validate respects abso=
lute core.hooksPath path" '
 	test_path_is_file my-hooks.ran &&
 	cat >expect <<-EOF &&
 	fatal: longline.patch: rejected by sendemail-validate hook
-	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <=
patch>'"'"' died with exit code 1
+	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <=
patch> <header>'"'"' died with exit code 1
 	warning: no patches were sent
 	EOF
 	test_cmp expect actual
 '
=20
+test_expect_success $PREREQ 'setup expect' "
+cat >expected-headers <<\EOF
+From: Example <from@example.com>
+To: to@example.com
+Cc: cc@example.com,
+	A <author@example.com>,
+	One <one@example.com>,
+	two@example.com
+Subject: [PATCH 1/1] Second.
+Date: DATE-STRING
+Message-Id: MESSAGE-ID-STRING
+X-Mailer: X-MAILER-STRING
+Reply-To: Reply <reply@example.com>
+MIME-Version: 1.0
+Content-Transfer-Encoding: quoted-printable
+EOF
+"
+
+test_expect_success $PREREQ "--validate hook supports header argument" '
+	write_script my-hooks/sendemail-validate <<-\EOF &&
+	if test -s "$2"
+	then
+		cat "$2" >actual
+		exit 1
+	fi
+	EOF
+	test_config core.hooksPath "my-hooks" &&
+	test_must_fail git send-email \
+		--dry-run \
+		--suppress-cc=3Dsob \
+		--from=3D"Example <from@example.com>" \
+		--reply-to=3D"Reply <reply@example.com>" \
+		--to=3Dto@example.com \
+		--cc=3Dcc@example.com \
+		--bcc=3Dbcc@example.com \
+		--smtp-server=3D"$(pwd)/fake.sendmail" \
+		--validate \
+		longline.patch &&
+	cat actual | replace_variable_fields \
+	>actual-headers &&
+	test_cmp expected-headers actual-headers
+'
+
 for enc in 7bit 8bit quoted-printable base64
 do
 	test_expect_success $PREREQ "--transfer-encoding=3D$enc produces correct =
header" '
--=20
2.34.1
