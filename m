Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A606C46467
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 21:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjAJVQe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 16:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjAJVQb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 16:16:31 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DFF5EC26
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 13:16:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GadSSr95opzhRXwg1kQoVWMumiOxLom9ATWVYBFFp/iy7CPFXsKU1OkFFonc6L4bVZ+U5wFxPi2LdDA/48JUTS6iSkkgkiMxTyoi6aM6wWSkQSqr/XymZqWZKYfezAYMCWj6jmWqfC264JUxMle07gVQVxzya6rfL0dTxsTZ1KY7SL+R4NC8jJRPsS0VDvXSHTcNqxTk+mtRBfeaoRUYVKtNrkoUrd/FVWJn7A3Td0v1Mj9MqCyQ4QP7oCOd3XyddBfFyZWmdAXHyb+/ROTxzmJ0Jy0aYexJkQTVg57IU4F3lFIiaQad67j5s1+EbZcqI/OQi/kviVGWPD95ShObJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unJ/BcNM1w47KD5X/qrbM56l0bB74cFhM+aATeoFI4I=;
 b=O8+3ZZxxtfgMp6rPDX9XNQ/hcFyh+c0wuCm6ylx0qX8q1YDotfFdQpA7c8K/GnCGZMQTHvHEfF16Ds/4NE7CprBuaiAyZBrYjSZTFOOoLA9L9gFgtvnfAxU/YOjv5XhCv6D8WSDN3JQ3Qb+xl1V2EW2HOMaLAYUjTro2/9qN1NEZdMPg23zbCDJudajCQXESo3vWGA4txJ5CnpSGGFVsNVf0zil/M0kV0Ag7O2NqA2hNhEoTvxnYxs4cxfwJVp2k487Dv5mqVQSKJhbMkOI0U/qV34ettY+6mEunJ3Urozfe34m/QL3C/zqlKL26ZBlGv3+NBusy5qS6LZPPWFhamA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unJ/BcNM1w47KD5X/qrbM56l0bB74cFhM+aATeoFI4I=;
 b=fFw9C7b+P2sZG0bowdD3TCXurlsS3JSfkF1YPt5F9MOMGTZAnjG1Fu1acXXuzHgoLcBpGSw7bsMMQhBk7iU4BVVTsy3A1Mf08nJbXGN/9RamVHb2//17RymwsvKqre1JVxJs66RPC26ckOnmlacCx01XZEg0bn3L3qfAISMIRHc=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Tue, 10 Jan 2023 21:16:28 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::b282:6c4:7660:583f]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::b282:6c4:7660:583f%8]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 21:16:28 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Thread-Topic: [PATCH v5 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Thread-Index: AQHZJTjNDVmgpxBQjUKjqEOVS11wHA==
Date:   Tue, 10 Jan 2023 21:16:28 +0000
Message-ID: <20230110211452.2568535-3-michael.strawbridge@amd.com>
References: <20230110211452.2568535-1-michael.strawbridge@amd.com>
In-Reply-To: <20230110211452.2568535-1-michael.strawbridge@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|DS7PR12MB6264:EE_
x-ms-office365-filtering-correlation-id: eb44aa8b-888c-477c-073c-08daf34ff04f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EVnlXKqN4HzoQipFUFpcTCmydazvHucX1bjdk8QTRbNQUAcCSGHyp9jwQ3+Tsdl7SAXc7J6DoWwY2jp3OqHIEBop7mnD5Kfn6QnUpZb7M/Z5Ptrey1uhH7DO0uNoA16IObbVREDys5OYZonkGIpyzPZh2WZD8hZ/jqjNXGdO+wySvTZUurcuPIjSzL3i6JPhRzS0tjMVNQdXPaXIx1vARf4MEN2y3zBP2ztllVVKwXXCf9X/6juT0UYvr2wFEOJQTAJcuMjDHTroT13f70EaGHc+2u8CUcU+lB7bqSnaXk89Q+2efO8iEEOOhcDqRws4XdVmdIOcOvlTuRdp/Ay0ryWhzBTrv/qjsxrHUD+dHJe0ErRVnqr90rqBiMZU2ORrizMITmMjejJi56+GxmC4pyww4/uM6KUSVGN7eXh1FML/Q1kSOS5rKLnhI7sefcBGUOKCzh3N+lYTPtTCfzLbnljuF3jMA5RzacvYvvpy/LKxTAcgVd8PuLFtU76vB2hCBb9nB/4KiZN7QAataF/dRukRw2X5yi4LETpyHVz6HrTdvMsNKqWcS3GsgDGsrooXGXPG22/8HnjE7F5qis2LZFQHSgTTabZ/hggLu6qrnpdOqiZeY614s+VG6x2e2bwx687OcCTGdckIYKIhKXGPl/ADWfD79G25r9FPapnPe5bbgE9NE6FzEFBaML70uWQFRXInyTCHd44CbqeACYxnxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199015)(6506007)(478600001)(26005)(6486002)(1076003)(186003)(6916009)(6512007)(66476007)(76116006)(64756008)(8676002)(71200400001)(2616005)(41300700001)(66446008)(91956017)(66946007)(54906003)(4326008)(316002)(83380400001)(86362001)(38070700005)(38100700002)(122000001)(66556008)(2906002)(8936002)(5660300002)(15650500001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bezoWJiWXCA/rCVbnDDfPjFqVds21HEvIlWpBkuw6mG2fx2L5Ra4d5RKDN?=
 =?iso-8859-1?Q?j3+EphzVAUeCYFNHHyTYJDAKbNMkw7Br1Rr1YPBdBhfutlnYeTEP932oxr?=
 =?iso-8859-1?Q?xdQiv6WawAWD7kyZxu3CrQ327Ddgr5EW+diiZWmyxPTQKdEbpVHD7TRR83?=
 =?iso-8859-1?Q?AP5gc2Q0LEU+Z6e/Rb9L/YvjcRY4O+IDLPe75x4QDiw4QTqauRV4kgAZsv?=
 =?iso-8859-1?Q?q0IutFK15eMaa9TnDY5Yw34chrcOxiWZ5JRZebB3AK5fL9L+B+PppHMInz?=
 =?iso-8859-1?Q?705VmSmptxyhRJD4zJfygWl9+9bwACm/4861e61j+KPXIwvxu2UrguulBu?=
 =?iso-8859-1?Q?W/6xk/hO7IWnoeVg2FPAybYbTxpSnCmJj8dlQF9LbUYORjrMEWGPtr17Fb?=
 =?iso-8859-1?Q?SOqPcv1HbZNmsDNg8t3iuU/WuE+rpFiFmjqxix85kwWbOcrftGI4yRCq/w?=
 =?iso-8859-1?Q?Y+KsLfDQkaN5cIm/7aV5Uvjjulssp3H57/ntec6x+VRT2L4+hldUUDHbVc?=
 =?iso-8859-1?Q?3U/CpZ05oepU/K28Xwm7qIca9AFQDA6qo0SZ88JsbyMVmCXZhCKm5l5u3S?=
 =?iso-8859-1?Q?XlAzEmndEmCsCOdPRgOM5R7UKWdoq9joyKPyMVu3pvSsKKJIsFx4TpfEKt?=
 =?iso-8859-1?Q?MpSjLMPK7IJldfdPK/z8cWqa3YCkOENQTiW4L2S6nuR53J4egh9uFqwjrE?=
 =?iso-8859-1?Q?74cbR6JC5gVTyVaRwtEZBk1OY3TuamXojfwZwPIRsz65oss5jWTjXoIJ0+?=
 =?iso-8859-1?Q?Qi+YYd59YNNxwPPJqKXQmZj21hIGXUS76slWOrmctwrKhLgvxK91HO4jO0?=
 =?iso-8859-1?Q?jqiSDr6oCV8QgH5plbkP7etG1hVTLDBgYFee/1H/2RCXCJSWf8zV5SgOlR?=
 =?iso-8859-1?Q?1MmWNR1s/f11MqEFVNm7PfwdmniqQD1sypKtNxxNW7gzKSdLCkTPykbd96?=
 =?iso-8859-1?Q?s3MJZvG4SlN5tKIufOdZBMfp0Nnkc9Fu3/jLCgay7Zr3csemvzlwPKhHN6?=
 =?iso-8859-1?Q?N0/RN0ixG1y4YoGKXlMzLTM6PsqvnlHAMO5eFGHZOXtrhf15sf9AaCYJHm?=
 =?iso-8859-1?Q?Hk1tK53q/I24tvrt3RsA87DWKq3Cc7S9yD78u8dNU9DY375HRruMXt2Mlh?=
 =?iso-8859-1?Q?sFf5BL8M5/dGxHyyiUB6xiDfYxHG4cuCfFWI55iRatRwedcPhiKmwVgGwN?=
 =?iso-8859-1?Q?29uxccpaUGP7dkblpSWXlGtbJXRqjI5NQkRaqRtYU/9z34bLwdW03KGAR9?=
 =?iso-8859-1?Q?kBMsAOPj8Vcl8JSH574C7TjEzhhl2bXnzqMDiuyaHbifWIZmdL4+RtO8cl?=
 =?iso-8859-1?Q?8/GDcLCuGQ+YZT3bFDsuUHRWoYBXlXC1tzjDbslF0hPKOWf8JZy/24Ab4O?=
 =?iso-8859-1?Q?1uD0kOkLtZVhsbNcz2fCRcOZf2JP24f1TNW+vuda9Rgv5MpY42l5ZtTiEa?=
 =?iso-8859-1?Q?346oC6+0RHaRCH9Y4ZJl67NB8R+72Ua4CxXFcN4YncRPFVWoIOqPCJvFrR?=
 =?iso-8859-1?Q?mPZhz6f8nhLAi6w02evxmjjnAVmO+c+s32lLWuBFXu7ELoNrFFyR1lLR3H?=
 =?iso-8859-1?Q?bh68+Lh0VtRGJdG6iR1FNRqVm7spjWDJ0jvywQStVjGxoAouLHfFaHepJs?=
 =?iso-8859-1?Q?TV00cMnk0DDt4ihXh58sF0zg10CKtGhbWb?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb44aa8b-888c-477c-073c-08daf34ff04f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 21:16:28.5554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2lOogkl5zb0FJ2ASSLqS41pWIqqkh7StL3TzvIeXNHFc+kIBOHAGEaOwgzbJ65L0hxvYMMcCs/SN1keXp/3Z7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
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
 Documentation/githooks.txt | 17 +++++++++++++----
 git-send-email.perl        | 31 +++++++++++++++++++++----------
 t/t9001-send-email.sh      | 29 +++++++++++++++++++++++++++--
 3 files changed, 61 insertions(+), 16 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index a16e62bc8c..2b5c6640cc 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -583,10 +583,19 @@ processed by rebase.
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
+The hook doesn't need to support multiple header names (for example only C=
c
+is passed). However, it does need to understand that lines beginning with
+whitespace belong to the previous header.  The header information follows
+the same format as the confirmation given at the end of send-email.
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
index 1130ef21b3..f02b1eba16 100755
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
@@ -559,7 +559,32 @@ test_expect_success $PREREQ "--validate respects absol=
ute core.hooksPath path" '
 	test_path_is_file my-hooks.ran &&
 	cat >expect <<-EOF &&
 	fatal: longline.patch: rejected by sendemail-validate hook
-	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <=
patch>'"'"' died with exit code 1
+	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <=
patch> <header>'"'"' died with exit code 1
+	warning: no patches were sent
+	EOF
+	test_cmp expect actual
+'
+
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
patch> <header>'"'"' died with exit code 1
 	warning: no patches were sent
 	EOF
 	test_cmp expect actual
--=20
2.34.1
