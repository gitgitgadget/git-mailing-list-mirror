Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ED4C61DB3
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 21:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbjAFVvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 16:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbjAFVvP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 16:51:15 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1494B44C72
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 13:51:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONkyuEapnbfzwhrwfsKGCTGlVW0GGfWn6CwlO/Hg17OIKOQn/VS1+1pR94QhQmS/zim7WWyH2+4LDV/fA8gC4lnSYC+5jshznWIXw1jnrNusiFRsGuhdcAn3TRdOwa3p+/Qdjya9NZkUYW+EMnRRJjytRvu/KSVIPYy8MA4kIXuKxGrxIPTxULoaeZRwEZ50Z0TpQc7ef4V+ZCVnjHEZ94eY5Fv78yVRMo1MM//JyjEcVw5ZdJThiXwk88/whhlufeQR+s4rlKo2V6WZdqkfr3VgOtpg0S6G8PA3Nv7v9OFx1V2pq2iALFKikVpgj4G7Qif8zigQ531KYvzITkmjww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYGAcDlatxRfocLH8Cj92E0Ez4ooFz2+8Nc0ljxVcjo=;
 b=aNyJcKSh7yaJaWTmF4fPxWMReTkOuTryJ3uSBOnKRRmBFuZlVfUoeILVyIdkflLMHZA5VXbITrpADQwIRGZUAFNUQezxFD3gC5Eza6KprmolMlABnukc5DY8/VI8g09O+PDL95Vb6ZekWIBcUyyRJBrANezhLT5eRlpARkrgCc91bzvlT/nh4KWodGcYgwtzcCr2scNuPnKXo73az1xtC9AC+v87kepcyk4No1f82ta6yqUp0r6Y9W5JLQiV+xKZ9zpFSW0RJ1IX3pfvwsWT0HgxzQOPWu5T7+fZM9PyJ7ugjvYdWDXIOZxOXOvd5evIVffR4td4Sle+YgkVCK1BIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYGAcDlatxRfocLH8Cj92E0Ez4ooFz2+8Nc0ljxVcjo=;
 b=DrEgRrrPxtEk80yCPMYzSuem9+T4+wzoeAOd2ZXfTwJzIaxUPLIdd2rIL7llciibSGRwMvdTc5FqjpfCR5R3CtrvsQQDznxM6EC5iJa7zGoBM2PuF+mTJNKiUK7fPeMWPsOzzNHpK1zDzZbej4iAoxhfn5ZIV1/Vjz82oQn8Vs4=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 PH7PR12MB5976.namprd12.prod.outlook.com (2603:10b6:510:1db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 21:51:10 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::b282:6c4:7660:583f]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::b282:6c4:7660:583f%7]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 21:51:10 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 1/1] Expose header information to git-send-email's
 sendemail-validate hook
Thread-Topic: [PATCH v4 1/1] Expose header information to git-send-email's
 sendemail-validate hook
Thread-Index: AQHZIhj8wH+O6ZIJ1kuC1RewChzNZA==
Date:   Fri, 6 Jan 2023 21:51:09 +0000
Message-ID: <20230106215012.1079319-2-michael.strawbridge@amd.com>
References: <20230106215012.1079319-1-michael.strawbridge@amd.com>
In-Reply-To: <20230106215012.1079319-1-michael.strawbridge@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|PH7PR12MB5976:EE_
x-ms-office365-filtering-correlation-id: 11de4563-968c-42dc-0ba2-08daf0301f56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ChxVCgVmWTIVD/83ygydPy8Ij9zdPIF4QmB4VS/kMgRMf6/2D3LSE2U7YJkgHVOzrZIvQx8aqZ8eohsqWP5L41AaZunNgObu+Sm4S1EqtwKoLGCVU8tNOutZIVFq2u/ESaGx79CziyP/DNW5deZouJDB3g/kb3kv656VZd0zuSVqR4jeutAAXriXJaPJiavrdvuOpDfdB40JxMSPHMEYzIvU9ifTJRvt2vUsj0jPSFMTgVAATK6Tky+aQVFnGcfY/7171pv5aoZRxYObvZZmnPrcl48rpKfp8S+wYAObKTVWSeTvxptr18FQ708lhKdhMurbnXXBaRGQvaGNXlcbuPVBj8hkPm4yKEtN5ieElCEqvIfnirD3RMOLIW2FZBAYNodSvKIomIBI4YNBAC4XQcvFQTXUu8aocXH/VmxJfa0ewZSNkgOZbYT1o12+bl73xDsYkvzfgSqFJPYKpOFON8kOSbwQ9yWFuAOPnLM8rkFBSLWHYL7fLpNcxOGqdZsKQrOsOny25njQWCsIxY8D3Ws7seDQewdU2o4ow3OkM4l76YAFRBbvq0/YfaOlAqeKenQRGgG+lQgiqCEF//qvCHRD2DO8mSc9Jvw+wnvBU4WCzaCp08zG61lACoKg9ogO2oFKx5Fy9fxwdb/JG+atG54VGmMTWhF9FRR9cPdekPk5GDyLu38RtPPoqBekdqOn2S1w3gUASIPHgJkJkZ0DOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(2616005)(316002)(186003)(6512007)(54906003)(478600001)(2906002)(15650500001)(1076003)(38070700005)(6916009)(8936002)(6486002)(26005)(5660300002)(83380400001)(91956017)(66476007)(66556008)(38100700002)(122000001)(64756008)(66946007)(4326008)(8676002)(66446008)(71200400001)(76116006)(6506007)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hjrsSiLfvvu6cK3qXa91eDkQlDxTUzfsb1ihJAp8wE4OISDKDI0jX+U9P1?=
 =?iso-8859-1?Q?lhtaLWZXo9y7JVreBDekZKWJP2w+6FxGoOcYwUJFTOychEePUYyxtLAweW?=
 =?iso-8859-1?Q?xkcD/KiaXDcqemP0izpqSJjr0UKHPVjCo6yKo+gSyVc9AKgYg4jvQq+Kgz?=
 =?iso-8859-1?Q?TsgnMocVnSbe1ICqGq9VXsngXxDd47xWsIKg6wbisEz+WavzEe+LyJOkvh?=
 =?iso-8859-1?Q?/GwUjtOvE6oKm3DXc3pxzKNDtjwsP4n0bGjH3rk/dYWs1sRAJ1GQ2mbwjX?=
 =?iso-8859-1?Q?+kf3sB7xiyyCGIp8f2x01rkfWOlm13wIxHXkhMf+XGUWEh8iyGNh4qsPOn?=
 =?iso-8859-1?Q?JrkFJRkIF71ql4Z6UpVXQ4fKzOowbkXQxURLFRP8vfjT1PpSLAtR8uL9uw?=
 =?iso-8859-1?Q?3Xm3x1EiUWUwkywNMBqsZPeu1AGeOmQj+fkbU+a8uzD/kQGVV7Eu8bI5AM?=
 =?iso-8859-1?Q?iTzss3VKDTYUbqn0GwLH2k2p+e8XWlVqCXS26lMrW5b4mdc3XPxFnYPDDM?=
 =?iso-8859-1?Q?J/17QtBZJY3VYPhUcwYFWO594JbcExE3455MdNUzmsxV771imDh9g9mphw?=
 =?iso-8859-1?Q?f5NUn2YDtHGEFvv2u+iO+SgFUL8Tmx1JHGcMY6r6rCHzd5cvvmHkekxhDl?=
 =?iso-8859-1?Q?BjJG232A+D0IOM379omw/hC2cPOPgsy0MC/mHo1TBxt135J+p7MFWKEQ3k?=
 =?iso-8859-1?Q?xeK3MyCPFuNzHvnG5FfjtwAASxJmv98MqLKVM/lrZteJsOOYIqIm1hpuBx?=
 =?iso-8859-1?Q?JEImjJAHnNuoF/vPyntYqwIJeuT2fArFKWfL/55IRRWiYwt1pIj6u92veK?=
 =?iso-8859-1?Q?GYXJgzMH8aFwy2cLHpo4rQwSvgSIW47hf++DsePcs//k84IDrTjvl7oGYC?=
 =?iso-8859-1?Q?yhSySJiGJ3ZaTe65uWPgMGmnFIUrOZjJYxjR3Q/d0giw3/GpcwPYh15mPe?=
 =?iso-8859-1?Q?A5aSvuEF39VPI9pWNVopuDiwBK+sWBF+6Z8/mV4cAmkbtjgPWmELK6Mus2?=
 =?iso-8859-1?Q?YevcoX4Rw5rVndbOpPRuknZ+A5II2FBsTQ8eR+dGmmjFrSO+NYRDgt/dvk?=
 =?iso-8859-1?Q?qyXFrVjaZbmSwLEgQ/A9LEUl2+rM9EBfgFCMoid92vj6Q7VxgzcswDHs8C?=
 =?iso-8859-1?Q?CRDTK4T9KSKfybbg5aa+mqcOsvOI4KRTiQK8ebHxWdGtn/6F0FOv7bDeDe?=
 =?iso-8859-1?Q?hvYWiAoZoDr+7zQaK7dCvWsKcrA0KKIPQ7w5pceduIhrJLjK+Zp1oysd4P?=
 =?iso-8859-1?Q?GRSuWui0xHZ6HzFPNewDY37Tw69/l/FXjwhoLG2Sf7Bh4VTnVbY9dt7jFr?=
 =?iso-8859-1?Q?pbUCNjdUrQaXNy48BvFriPrOG/5dOymjJbTdHnyf8rtAA4ASYlETduO7VD?=
 =?iso-8859-1?Q?usG9h+JUIZEt63EJs9orOl+O1bwFPthyF/pYyZMVkX/ckD8vBcSqqpuICk?=
 =?iso-8859-1?Q?MNG/7uL2bQbSVVTdEjByzUv1hBLM6Iarf0qvhmT/sZGqTFu18F8OzpdWoL?=
 =?iso-8859-1?Q?fHJOP6rjPrpVl7efiAVJer//Z/+N1WOtcmp0/zd9DdJlmVkPwKByRGIpDt?=
 =?iso-8859-1?Q?PQs4WG/fHIW0QClC8aJRm4abGfu66iT2seC5ehU480kvP925YjDOPC2Mic?=
 =?iso-8859-1?Q?QiWtlKFxJQ/HKWFgnbzICj8FUPW7US0VOG?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11de4563-968c-42dc-0ba2-08daf0301f56
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 21:51:10.0550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZiMAg0+4WAGUwDjOQoNf60cvSz9EUV4r4pKfJ18TXfu9x+e6yGJrMVOMy3UINoxS6nm+waHovfEbsVBPx7nuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5976
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To allow further flexibility in the git hook, the smtp header
information of the email that git-send-email intends to send, is now
passed as a 2nd argument to the sendemail-validate hook.  A new t9001
test was added to test this 2nd arg and docs are also updated.

As an example, this can be useful for acting upon keywords in the
subject or specific email addresses.

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>
---
 Documentation/githooks.txt |  8 +++---
 git-send-email.perl        | 55 +++++++++++++++++++++++++-------------
 t/t9001-send-email.sh      | 25 +++++++++++++++++
 3 files changed, 65 insertions(+), 23 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index a16e62bc8c..346e536cbe 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -583,10 +583,10 @@ processed by rebase.
 sendemail-validate
 ~~~~~~~~~~~~~~~~~~
=20
-This hook is invoked by linkgit:git-send-email[1].  It takes a single para=
meter,
-the name of the file that holds the e-mail to be sent.  Exiting with a
-non-zero status causes `git send-email` to abort before sending any
-e-mails.
+This hook is invoked by linkgit:git-send-email[1].  It takes two parameter=
s,
+the name of a file that holds the patch and the name of a file that holds =
the
+SMTP headers.  Exiting with a non-zero status causes `git send-email` to a=
bort
+before sending any e-mails.
=20
 fsmonitor-watchman
 ~~~~~~~~~~~~~~~~~~
diff --git a/git-send-email.perl b/git-send-email.perl
index 5861e99a6e..5a626a4238 100755
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
+	my $recipients_ref =3D \@recipients;
+	return ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header);
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
+	my ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header) =3D =
gen_header();
+	my @recipients =3D @$recipients_ref;
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
 			my @cmd_msg =3D (@cmd, "<patch>");
-			my @cmd_run =3D (@cmd, $target);
+			my @cmd_run =3D (@cmd, $target, $header_filename);
 			$hook_error =3D system_or_msg(\@cmd_run, undef, "@cmd_msg");
+			unlink($header_filehandle);
 			chdir($cwd_save) or die("chdir: $!");
 		}
 		if ($hook_error) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 1130ef21b3..11e68f9c18 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -565,6 +565,31 @@ test_expect_success $PREREQ "--validate respects absol=
ute core.hooksPath path" '
 	test_cmp expect actual
 '
=20
+test_expect_success $PREREQ "--validate hook supports header argument" '
+	test_when_finished "rm my-hooks.ran" &&
+	write_script my-hooks/sendemail-validate <<-\EOF &&
+	filesize=3D$(stat -c%s "$2")
+	if [ "$filesize" !=3D "0" ]; then
+	>my-hooks.ran
+	fi
+	exit 1
+	EOF
+	test_config core.hooksPath "my-hooks" &&
+	test_must_fail git send-email \
+		--from=3D"Example <nobody@example.com>" \
+		--to=3Dnobody@example.com \
+		--smtp-server=3D"$(pwd)/fake.sendmail" \
+		--validate \
+		longline.patch 2>actual &&
+	test_path_is_file my-hooks.ran &&
+	cat >expect <<-EOF &&
+	fatal: longline.patch: rejected by sendemail-validate hook
+	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <=
patch>'"'"' died with exit code 1
+	warning: no patches were sent
+	EOF
+	test_cmp expect actual
+'
+
 for enc in 7bit 8bit quoted-printable base64
 do
 	test_expect_success $PREREQ "--transfer-encoding=3D$enc produces correct =
header" '
--=20
2.34.1
