Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E6DC54EBE
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 01:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbjAQBiS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 20:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjAQBiC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 20:38:02 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA662B29A
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 17:37:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obM29LIjKxyHOs2FnZ0AYYkV93IAWkkfr/XLmOhD1kFdyZnYa6Aez7+i1+wsFZ+GjBugAfaYr6Vrw6eXI28S7RSI0maOLdgDCm3sTwYGXSNuBFJrLmnOCXMVQlrfmTlIvMdkCSn186UtP9yC+A3uCp7656hjLeqV4Wl8qQ5zdveGV7E4Upwl0v8i/ZCzrF9NnABkzPzLSTdEnH7uvHd8yGSVd7Lkk9gl/nUXnoO330rh/5Lj7eDUNaWbUSB/4tLAMPqsYPn33bJepGyIJVT09Mc1LrlThavLmLMM3fPeKJJ/ENtSIyHmPrYWeztBtle4ya9XWT/jZ60rNf0yYjPUsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unJ/BcNM1w47KD5X/qrbM56l0bB74cFhM+aATeoFI4I=;
 b=NEtpd535drRWaXJhBsP+Vc4uLszrer1EctR+4+k9zsi5Pyoypv1hHVG6yoygG2/LzDEAJtmM0atP2G1Z+Pos0Geo7DwZl73gXfeo0DSL0VzRS+/5AyP8j8CVjYZbUhO7fYtrdySzIgyJj5l1z8hq/CqzsMzch/Hh53QjDLHBgKgPHo0FPAmSERbEVH0a2LDWO5G7T9iv7oc6oICRtDoZ0+WdjYbaW3vWFZTCdtY/TSQ1Z+EJdZuJsXyIKiMvdT3Ani4Fm0jj89VIB6JgzWXMTzsB6DTnjp24oPrcLp1CtvtyqKr59kXbf5Qimz3V999O2w7cfv9lhrOqYvB7f+aWQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unJ/BcNM1w47KD5X/qrbM56l0bB74cFhM+aATeoFI4I=;
 b=DxTpBy4yiQM4hf5QVpgqrr6eJt8LHpuW1Q8Veau3+UrAOStQu+bXOMD85tJc4eNVqD+odNZ89ufTiv5AG9Rs+kD5PsPzWWpL5wOqOoa2LrBwbt9ZZZFR7IPyodDyKHn+dV0e1FB7IN/xRuLkpXBg04Kdg610rGO2dO1Z8h0mkmQ=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Tue, 17 Jan 2023 01:37:38 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77%3]) with mapi id 15.20.5986.019; Tue, 17 Jan 2023
 01:37:38 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Thread-Topic: [PATCH v5 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Thread-Index: AQHZKhRI3pD5ftuX0kGmxDnSI6POhg==
Date:   Tue, 17 Jan 2023 01:37:38 +0000
Message-ID: <20230117013709.47054-3-michael.strawbridge@amd.com>
References: <20230117013709.47054-1-michael.strawbridge@amd.com>
In-Reply-To: <20230117013709.47054-1-michael.strawbridge@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|MN0PR12MB5764:EE_
x-ms-office365-filtering-correlation-id: a9a1d9f0-33a0-4c92-f040-08daf82b6afc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IpEGrz5ARhIdjqSV2fkaXhzAu3Tyj2ZTHNVr4rYuGq4fjacJ5EfberBGMClU5TCIujIfRY/P4BniXvztQft2vE8ZD6+ietWIs8+m+R1vkbL/ClCACZ42fWjHHeON2ZzU3i2BSTPnoBY/H2VajJFfDdZbNtbaodhGJu8CjjyfkDuMhxOcE0567nueQesovLOBDUpvNWNHuTjANwrFSIqwS2nG9c8LXCNCwwJqlw5AssOXqVTIvPNWH37D9GVB5XcZbL6A50+U51r2JMDm4JWmUojqwAjlsO4LE4jPaamAw5sLDz6PzCRSG6RqaUNrcfL7QBe39D2fq0e+G9Ei0FyfCcqNgAn5InQmA6/AO0H/qnTvZRJK2MWvsEJzwpiXqo0Sb6CTKgcYBvAQsJlcOyhYqezQqHivz9bmSBcxC1CbDBzxMQ0w0YVvm2gqcarQuDku4VibNb/HELZiuoj3caiSP5LLghDoLmrvE0nmyGJo2bv4GuwWEYnjqL7IZBOlfQAk8Cpv2A/zwDVpoZg5DA+Dbr+y6Ka6b4Vc+o2KuBbadGfzziLbLQUrH37UOhyoz7qXJj30qp4yA5Su6VGkUNSVDjRxxfW2V2wSES0FkyDCanoJ8bGQ9PmXRgJJoqSibCqBufnMs7YDl4W10F3pnSk5Vh3xTvkuy/pd/GlWjaNcY377+xx9AcgykZaCUrU9cZBDZcs8u8faN9i3gkwY69h/gQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199015)(71200400001)(316002)(478600001)(122000001)(6486002)(5660300002)(1076003)(36756003)(54906003)(6916009)(38100700002)(4326008)(15650500001)(8676002)(6512007)(38070700005)(2906002)(8936002)(83380400001)(2616005)(41300700001)(186003)(26005)(64756008)(86362001)(66556008)(76116006)(66446008)(66476007)(66946007)(91956017)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?M24NNbAl6fOEaHCXWcqBVH3FGwNzmHLSdfNso9guEROxtCz56wOP0LEXwl?=
 =?iso-8859-1?Q?+su6FGJMnvxSsS2v3IVjcQlDo/k9hYUPJc9sRTuaOy4ApV2dn8h/5FCij4?=
 =?iso-8859-1?Q?+63NAQjQS5jr/0Gss9QDyY0wF0gjgdMX2AvmVU3rnbfaxNc49lpr1e2rEI?=
 =?iso-8859-1?Q?kfcnHmcMk0kZoGmzExwx1n5JCbNi480QNEiGLcRXDvu6I9oifKNYxYI+K8?=
 =?iso-8859-1?Q?aHyRTMC6Q6umIMeCSn2HV+G/5hmtzEVGeZEoGp5ZjJoJoWenNPhRaMrVgi?=
 =?iso-8859-1?Q?kdoGKtm2Fj6FStj3JwUuGhSXs30Ym1ax4pUm08BC8mPLnFyXa5LDUpYecX?=
 =?iso-8859-1?Q?LO01pCDsXv0ODY2oySnwhfJiKgyVcaE+CieZ/OjXwG7TVuPsYuFTvRmjS+?=
 =?iso-8859-1?Q?3nkeX1QzC6tOIGhTeEMSYa0WZA017kiQ4xihh7PLn3pz+MhdK7PEb3dA+9?=
 =?iso-8859-1?Q?dvJ4QCUd68t/ZxPEyRkEIbY4ZrX5z0cDtplskapcm1iMLpIRivOvdAM+ZX?=
 =?iso-8859-1?Q?ac8dXGj57Lmd0nQYKl26zZTQOHafomQ1C6G9BEgt79BoTIlVVWUgch/Hrv?=
 =?iso-8859-1?Q?hXCelZVh16oYsbk0XAWpH3+yWuvEnPVMPMMAjyL4G9fBp4kMVLaNr7xgz8?=
 =?iso-8859-1?Q?KJYmUZSvQfpEXDktlz+H08+abGvJTIWS8I3+dfiw9uFGoUMcZwUXnGbtJW?=
 =?iso-8859-1?Q?9++OHn2ivbBjIL6d70grZJMfE+Rvir1YVCubGrBPhWiS6ivVdAyADs0aLg?=
 =?iso-8859-1?Q?oYbtTNp1Svyze6FF7ZYNeboJ4EIULi4+XXdUKrmMeEnkqJg7npAM9yjeDm?=
 =?iso-8859-1?Q?HqfVKGf0PARHLmA3Z0iVGbHmP3bSBwXtDngi0eQph6lm8nZI6faFH+uzh/?=
 =?iso-8859-1?Q?JaFjmtbbWu3gI3dqJ1SGsd6xL31IwqUbd8WBmqQL4sdCUmF6K52DkWXYB2?=
 =?iso-8859-1?Q?B5+TfPgsrkLlenZfCIcCSz6ICsb8b14ZM4yV09fHE2D1IUGmObrfbE/uzl?=
 =?iso-8859-1?Q?1Qnx1aSZkWW6587zmmX/rHybrcOnI5p+lM0BHmJZYdcevIICPqwb58z8/e?=
 =?iso-8859-1?Q?4p1SeBtDYyJgEfjS0dG0RtrC6V2CruS7Da39UyOWVXul/KRacQhYFbk+4e?=
 =?iso-8859-1?Q?iFkZTgvQPnIdwDa/LvyaTJCEKvMu/6VsK5vYSigmlNT+59TN7tPaYsfTOS?=
 =?iso-8859-1?Q?FWdySOGzLx6izqMtePNw8n7YcqipJg0UsIJpoFbG+99C8rtu/4OqaxkdJT?=
 =?iso-8859-1?Q?JtIwbSOKOzBYpkuabhyN2oSmMuKEEEZXThtxnTBbf1l9cgDPQPQUCWYcic?=
 =?iso-8859-1?Q?ZyUlX8Ph4N9lMksA9UDi6hyVTPC/mh7hrEHfE+OlPEV0jop0P1yGAA7pJ6?=
 =?iso-8859-1?Q?kujlKqh4/Cpj2Viq4RuyarDQFDLBdvjS20HEnc3yiu4YpKv0HwfChO58jf?=
 =?iso-8859-1?Q?P1+MyIMLFFHdLlkt+h+wD2T+D7+a9FtTrt2hObMLbqWo2kOOX2yA3lJO5a?=
 =?iso-8859-1?Q?xw4mMgIDQ2sH+K0kxsYHDWiygvFoFgQIGyWrbAJe4oR8IQ8tqRIjgYAQNd?=
 =?iso-8859-1?Q?afVvucUA8bPWppyJ947xo/KbUC52AfXcDOY+vmUW/PUM5ZewRGXIqsjw37?=
 =?iso-8859-1?Q?zgxDTnH6UBoz1bAWtjfn7PsczyGAz1qqDC?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a1d9f0-33a0-4c92-f040-08daf82b6afc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 01:37:38.7966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5PS1GKWu8p3XIzlM7fmX8U1WJrxJBY263pWc3N2tvLDAgg8FikmT81i6xo+/hC5stxsTomK8QvoZqZhKVrSDUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
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
