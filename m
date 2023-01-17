Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681BAC3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 14:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjAQO3I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 09:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjAQO2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 09:28:24 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD77F402C6
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 06:27:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAm1AjD0ke4FBn0RqJc2mM8NWUVQmzbF081j9KNbaV/3ijxSrq+6l79VcxDok2PriLPXRlm3iJjAfCepDTQY+XUreiP5U5DBI1y3/rLNb/bakRWVa0rBVuoaKUq41fv2GLk+N/wpNgT1y2QaD4jOmwSpQoPNC6Tg90nZ1YMQ93Q36dz3An4a9Yn0fg1Od5Bd6u4iW+jYfAjVMVUkb2+PmZ9/++6tqg3qUi4dTILeISjB2s6omt/Rv4bziKAiizKzgUC839vnyzUVTBxpTtwxz6q6wD8TjYFXJA5RegNRtqsaUsg5Um/PFNCoLIfs/ZSfXzcNJ0ajN3V4v8opcsyAOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ru/S+lN6ddJUrmPVrpBxo2nZ/6fWH1/e/TYk3WL11U=;
 b=OhoIwyLgmo4Bw18MZQcVLqgyWtsMDk9iIAdDBepREXgPGUDNbccltLQEo4MUv24T8Nditocjre6LHiDXIyktSHtchFuO5REd6OM9ZaRXbdzd+jAKgAQhFOg64Vc+/xslfg6zlSKSpy8q3xiIQiGxihTa39Qe2KYluZZjHkwiCaeAwBbzx2efSwaW1yxoI+q7upxf/6RP4Epk1apLVAEtwpfNh/57KYHKYBTYydp2sNHeeuOEGTVbno2JMN3EpWnSueRNGuiLg4bHrSeZEsDehPTTwi0wWpOkZHlJBO90c4PI42CH+8MTcFwZFQFu3LtiMWfKLEOS+31QS1HNY57YiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ru/S+lN6ddJUrmPVrpBxo2nZ/6fWH1/e/TYk3WL11U=;
 b=tPa20K8Y1+EPnKYW+hzzo8qGCM0DclpEn+vkP+GjKDga6hf2ipwQG9QrCaFXZZbJA1B0nCdknwdDJeg94aKUlrkoZT1Ulo01a1zF3yn67B9rIG7bfEcpLvHttsIUOhLwLk5ruGbdSjE6ZoY3QM4yuKy8KqKAC8ig6crMqOl9dHM=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 SA1PR12MB6678.namprd12.prod.outlook.com (2603:10b6:806:251::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 14:27:21 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77%3]) with mapi id 15.20.5986.019; Tue, 17 Jan 2023
 14:27:20 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Thread-Topic: [PATCH v7 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Thread-Index: AQHZKn/P6HNrNIjDP0url1PLFspUOA==
Date:   Tue, 17 Jan 2023 14:27:20 +0000
Message-ID: <20230117142706.230404-3-michael.strawbridge@amd.com>
References: <20230117142706.230404-1-michael.strawbridge@amd.com>
In-Reply-To: <20230117142706.230404-1-michael.strawbridge@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|SA1PR12MB6678:EE_
x-ms-office365-filtering-correlation-id: bf596a66-556d-4dbd-754b-08daf896f19a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LfZmUANVsoSvY1CIqflDF2JHkEiplUztvX5uadNC+rtivPbI5xPfisU54BZ0UouE1lyqrB2rLVeQ77ikFscS1PQpQte4S4l/bk5CdBXJ4h6VSTzWlv1ZMevUbHprjP4UYdlN7B3+NVvjAupb/hmPizHGUo7wdZzskCZaeiSg+PLFTtwH76yu89WD0ILKbu3AfVTC5KQ5wBJMMxtafuBWzKPEwU2fGcJKVfdC1oNkBFfn09sPhsXaMlvcbmeL8rQzXefe8XnNs/zSVfSYIiwrYIq2TjxhSXXI9fsQDvXsaevDA4pEoOIWCbwIMLcFBLfICvTuefKPl8zByN+2FViGzdTBoY/OeiImJxvM6qOZ/y6KGqQwHbML3mRiOHx5T/oDQ3Dlw8Yxb4nTtd+7CJqEVzqFyp0F5F96jiV3zptuZYlQwG7uJyW2f405bGUvlw9iUA80VnEHjn7abHfR396sLrJtTcvc/Hc6V6qVQkr6vZpNx4DGNaRXOcGwAh5QJFZVWEyXhrpu6pkx/OLBrQw1gLvJICPx0ReFXkjU39z4knzsdcPC3kVWC8N2cM6RcgFuvYjMDeMcyms95pgPs6JryKrGKJ3irRW3smPsGLEI3sCj7b/UWZ8B7XPcv9WNkYns6M6xdN2Z/AQ/H4bvHKrNMw9/2wOnEepPr1Pugm9IodHWPOsX/uekGOUe58bcE/cVg2La0g7/46Z73H8a6erV+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199015)(64756008)(6916009)(66946007)(66446008)(76116006)(66556008)(26005)(41300700001)(66476007)(186003)(91956017)(6512007)(8676002)(4326008)(2616005)(86362001)(36756003)(5660300002)(1076003)(8936002)(54906003)(478600001)(83380400001)(6506007)(316002)(38100700002)(15650500001)(71200400001)(38070700005)(6486002)(122000001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?L5ojgWRvGwlSadHGo/mapmKBjzrboyqBjutcaCMhdLl/mF9F3C+RngVC4Y?=
 =?iso-8859-1?Q?Appe2+ZPOL9G+5X/J2Y7nw8dmGSTzWSlJlUwusu3E7tRGc/upP41U0TOM7?=
 =?iso-8859-1?Q?GMiWlSZUgEmW85ucCXVn7u4UssdRzbBIHDoEEa4mGqTkKcQKp0sttmQoSS?=
 =?iso-8859-1?Q?7MW9v00Xws6mcyN9+kCcLaeJ7PV6XyVYzN1Vlbehozg78N8mHZI8+nIwtR?=
 =?iso-8859-1?Q?ZqBZw32t4utNyfVjBEZRwNadTN9hB4zo63mul0oUYGjtJA4TB45MQFni97?=
 =?iso-8859-1?Q?GnwPKfMKnE27apQxX6kaM1z3mwGbA0KtDvjPh/SRqgUVdYszC/coIBB7In?=
 =?iso-8859-1?Q?tXY4J+rGUmOG4k9q7cRbGzeZuTYXwX5l5HVwal7tFLUkcXuXq2Wwa0geLV?=
 =?iso-8859-1?Q?BanyAQrTWQWGDBFuuJLnYYsqmRcUwRavHNaf3yc7vr61eftn5Ah0jx2muk?=
 =?iso-8859-1?Q?9qVfeKniVrnuOF8oQf21D3nesnGn38/RVUkuPmxqps6jl2lZiZswCJI8Go?=
 =?iso-8859-1?Q?TYRAN/X+PPPE60BDhPEkMDmxzZ5Nmtf2EHv5Sk1dx50DeBZNTNCIHw28PF?=
 =?iso-8859-1?Q?wQ3DeWYf8wTOpeAIcFEhJZzJDJSpGgg/+aKwcELpcZIAGpl+bxz01fFV9u?=
 =?iso-8859-1?Q?vES5Ye79PbNGwbp8dWCjjwEjHFQyN2Mkc1tkGAp893V48SvDIolaVA9WCH?=
 =?iso-8859-1?Q?Hdpl+iTjL9Sgmk73EMbH7PtVlshSIhiFPno9h5gKiBjp09yqnwFBpGfa4Q?=
 =?iso-8859-1?Q?i/MwFZR/pU5a6KCnwm7NV3RMv92QTU7NhLN1RpCrar1KHLbxaSllyaq9uh?=
 =?iso-8859-1?Q?x3OLpVcLixNZFN+qb1LRWr/yV6cvnpWfIkPKzv7JYpy/vraRfkr1uqcIQy?=
 =?iso-8859-1?Q?q8T/VPp15lm+s981gb82wAzhoiPQfHDfKBGB0Ob0vDjdp6rdjPTNVnw7ij?=
 =?iso-8859-1?Q?wphUunFt3fPPdDXe5XHS/RPfBpfL2n/cLe1OP2E8qW7bCFex/oqvKfEXUE?=
 =?iso-8859-1?Q?bu1n5zJQkxnLV0MLHBfgvd6HuPASbmi07e5+YQjds+T5Ct4GEVEvbDaTs/?=
 =?iso-8859-1?Q?euYsEnbCaFHfBIrgsGxclH1FxUQ+ecpslWDTIPQ27Ld+6jlQGbSebboLoA?=
 =?iso-8859-1?Q?QLy048mzZj5YHMk8mAxQvlGHmWJV4WSS5HYZcOjUoENwUqZ844EN7GAdZW?=
 =?iso-8859-1?Q?GH9u2L1hxUpbVbnhBc5wSrL/FWfszUiVBzuVk0q0QGArefN8xbnhkzbeNH?=
 =?iso-8859-1?Q?UDItRuBdPGOiPXZscNosUdhx0OCtWnrNdaY7oFZ7hbWKKfoboCcBBw26yV?=
 =?iso-8859-1?Q?ljoDzTeCO5zQ6agwJEzwSLWd1Zeza1YvlDzTH/RLI6maThWCUtm8hbxtvU?=
 =?iso-8859-1?Q?egN7swIe36UZ6y7u6ZYvj3Yzknlk4RASjF1b8gsIfV8ohXbtZYqHyl6zVe?=
 =?iso-8859-1?Q?mnDtAVqps14a1T8uxYdc36vhsOA5V6vk/FILArieKV1MbGf0W/piE+UxFf?=
 =?iso-8859-1?Q?SfAb3AkJykE43p9vZ/3MZXMjQ8TJKBJxFezmqPud8LQ/FDjcXTJoWHLaIG?=
 =?iso-8859-1?Q?ZvpL3yX5bh3FUp6jH6VsTHbjOwt8kI4sW3CaF65KZH1OK8T/8Er0ScpQFS?=
 =?iso-8859-1?Q?9mV7kZCwAiN04eJGseSLXM5Yvx6ksFESVO?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf596a66-556d-4dbd-754b-08daf896f19a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 14:27:20.8248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Zo1HnENV/z2+i0WD9V66+aHOuhvnFY3BlcWt4GDSgX7whGnPYb1TJa9QptlCUb7nyrbVchbmYhVrGZd/GkOdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6678
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To allow further flexibility in the Git hook, the SMTP header
information of the email which git-send-email intends to send, is now
passed as the 2nd argument to the sendemail-validate hook.

As an example, this can be useful for acting upon keywords in the
subject or specific email addresses.

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>
---
 Documentation/githooks.txt | 28 +++++++++++++++++++++++----
 git-send-email.perl        | 31 ++++++++++++++++++++----------
 t/t9001-send-email.sh      | 39 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 82 insertions(+), 16 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index a16e62bc8c..978d599be5 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -583,10 +583,30 @@ processed by rebase.
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
+It takes these command line arguments. They are,
+1. the name of the file which holds the contents of the email to be sent.
+2. The name of the file which holds the SMTP envelope and headers of the e=
mail.
+
+The SMTP envelope and headers are passed in the exact same way as they
+are passed to the user's Mail Transport Agent (MTA). In effect, the email
+given to the user's MTA, is the contents of $2 followed by the contents
+of $1.
+
+Below is an example for a few common headers. Take notice of the
+capitalization and multi-line tab structure.
+
+  From: Example <from@example.com>
+  To: to@example.com
+  Cc: cc@example.com,
+	  A <author@example.com>,
+	  One <one@example.com>,
+	  two@example.com
+  Subject: PATCH-STRING
+
+Exiting with a non-zero status causes `git send-email` to abort
+before sending any e-mails.
=20
 fsmonitor-watchman
 ~~~~~~~~~~~~~~~~~~
diff --git a/git-send-email.perl b/git-send-email.perl
index 42f135a266..4f2039284e 100755
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
index 1130ef21b3..c0fcbacdaa 100755
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
@@ -559,12 +559,47 @@ test_expect_success $PREREQ "--validate respects abso=
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
+	grep "X-test-header: v1.0" "$2"
+	EOF
+	test_config core.hooksPath "my-hooks" &&
+	rm -fr outdir &&
+	git format-patch \
+		--add-header=3D"X-test-header: v1.0" \
+		-n HEAD^1 -o outdir &&
+	git send-email \
+		--dry-run \
+		--to=3Dnobody@example.com \
+		--smtp-server=3D"$(pwd)/fake.sendmail" \
+		--validate \
+		outdir/000?-*.patch
+'
+
 for enc in 7bit 8bit quoted-printable base64
 do
 	test_expect_success $PREREQ "--transfer-encoding=3D$enc produces correct =
header" '
--=20
2.34.1
