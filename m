Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCC3C4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 02:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiKKCPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 21:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiKKCPa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 21:15:30 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAB05F879
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 18:15:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRfkHFsHXB3aaTRoeWyfqP0kxTe2EGparxye/mOwBNXhgw6KciH20NHZnNWqQqAsxbnVIYmL3/l4WbAakTSBogkxMoe6MkpySwsRtXRQ6USfqIb657fqTWyUrin56F54hNrM8siE0X3Zuns1TZGrcYEsuihmm+MfEIT7sfAQOyyRsHtLXRLlTiPwvGbSBAYASdzrIAt777Xzg3r2lhMSNVlye1ui1Nc6vHiw34ghZihF2x/jGHQLHU3K7zgtKwVaLbYiwYRA3Pygqu5ATohqbi1g5pDBn2FfcIGyuJAX8Ktn1c0uKgMSfpA1aiahDjFc5tWhdNJMHo5w58K8Yd5BFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6muwiSv8ww/DveJxWuQhvAHWxHo+KiAUuWXJuzJB1to=;
 b=XJGHQgMAuZOg4M0ktapq7cWirh0q0rsTirY/1MKwY13q5jwytFMDn/WMrPh/2dwHnG1qi8xlmVrEhMkT0JH4AShLvk8az6OlxMUHKZAd5J3gQWbLDOg3QOkZ0cE6lDPh4hqwjIGgjfXe9xHIuGYqXCsP6VcX2RMDtvQQzsAIiCg3Q1Y4csCO9T6O5ilUtA6em4ifhGV0pcjUkW0I1MBWfnzr0GOq9uCcixw7i7ZG2yPjeLouSQe6d+9B2+ON2HaxxxcMN6qhlGNZTPyLiUXq6brQwaOJARwUp1mVWnZTzCGqK07pspL+GiWHYauzQsCOC0WqeX6j2fX3G6XDfX4wwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6muwiSv8ww/DveJxWuQhvAHWxHo+KiAUuWXJuzJB1to=;
 b=2r/whAReJJfaRquHJouWmT/Y/YcrUWre0ffA/vswKP6Tk2tz3dcX8jigFYHvoEVfSos1tvc9wawZtTcuXV/hYTwTiAsR3B72r5h9TkH7etnAGSGh1z5EKhYTAUh3rvKF56v/rOi+cV4BWkC/gIuxu26Zs86JdfRS0RxHYa7gPto=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.13; Fri, 11 Nov 2022 02:15:25 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::70fe:fd7e:da10:fd66]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::70fe:fd7e:da10:fd66%6]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 02:15:25 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/2] Expose header information to git-send-email's
 sendemail-validate hook
Thread-Topic: [PATCH 1/2] Expose header information to git-send-email's
 sendemail-validate hook
Thread-Index: AQHY9XN2OwZNasUh50CEA4i7LOan/w==
Date:   Fri, 11 Nov 2022 02:15:25 +0000
Message-ID: <20221111021502.449662-2-michael.strawbridge@amd.com>
References: <20221111021502.449662-1-michael.strawbridge@amd.com>
In-Reply-To: <20221111021502.449662-1-michael.strawbridge@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|DM6PR12MB4107:EE_
x-ms-office365-filtering-correlation-id: 46f66219-4ca8-4fa2-f1fb-08dac38a988d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m5fDBWMmhtIJWvRplQY6vrK4wboNQtQyi8DIHj7PsJPleDykimZ5ToOyy9pwt685pa5anpNHxcB7QtNZryR+S72GMT+Q3gKlHzwoApz+5PukgVONW1QP7oCrRJAqCEJx9eWRt/CgHyHGVAnYmu6QcKoAmqrnE5zN/TS3uQyZbioNl7QYc1+7HvHNiFLfGF6Uv9uAb6HrQbV5J9YKUGLHKnFK9NIz2/7F9Okn7pYEMFog58XuAkb7OqjdeszKxr3gIuH0MuFnORjL2LIjC5+MYQO7QMPeqUwbGYmewhvEpCDcolDNCPEayMQ0ekPesVW7vKy0QwNHuw4g0+frtZMzbLc8lxLXzwZENJOJX4vR/p6XAddIOW+PVPzlSmmWDkl+MVlVxiYn52EMr7ErC1YgQLwZEJWIPNzbRXz/gUz5lnpczWnG1eYL6CJ3a/MuzctHDQaJ6uxGoBUqnhcx+XpqUyacLz1X0LbjCISMEp6ymddjiWHmZ/3+ucrqr5fdzOwNOgC0DLu/7M9EOXStZjsxstQmE7Kn19DMoNirMnGX4VYvjEo+KsKcrMwDQVdZwoS8fhfbAL5VsUurYZ+KkWoQwtfgGjVf4jdAMCbOm/I8+ytgGF2sQqsyw/MP0aJR2NGg2W8SalTndW+vkFEDlxE/84CJNcFKUexigADG8IFrlnxEfO8oFF0jBFEYOhF8inzKkE6V4S3zIQi06mgptcaMW7v39hbTijnikNYmYE8I04fro91swgK1Lf7RSd2ad3xBffsL8/Yn0AZyw2uqP6ghnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199015)(38100700002)(122000001)(15650500001)(86362001)(38070700005)(4326008)(6506007)(2906002)(26005)(66556008)(6512007)(66446008)(66476007)(2616005)(64756008)(76116006)(91956017)(66946007)(6486002)(71200400001)(8676002)(316002)(83380400001)(8936002)(5660300002)(1076003)(6916009)(41300700001)(36756003)(478600001)(186003)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1ZjXaEA/3ey4ml/Qzf0oexgvteX2fjd0Tb4XQJuUNAmLNukcYePUhtx5Qv?=
 =?iso-8859-1?Q?z420gLifk4BFvPVA8uBBkTel2rRTQn/vPLzPjcuxgipaSYY2YDU04g3wp8?=
 =?iso-8859-1?Q?n3pnjjvwKxBYWxaHojuvStcHVXD/xN0up3k9pJXo7JNrwsAVGvzm8l9P9V?=
 =?iso-8859-1?Q?XQPdDAMgGSfzNjfALmG24twPDwIlBLpW4b4xztTflJNFr0xAfUmrfQSj09?=
 =?iso-8859-1?Q?WBNbxVLyYOc+6eDbvjB5/7q83LY/QQpj1UHVhQHYAeRKBPkQ3KBuY+ywqI?=
 =?iso-8859-1?Q?DHH3q+gWKQSZUX4pbbv3bnq/XyKwsoQZaNo4lQhc1/lvOFp5nZGn845fUD?=
 =?iso-8859-1?Q?zQzouejGtHwT2F/3CLnMjRQ8q+ZddzytQVvsr9eEOwncSmMS7F+5gfvkZb?=
 =?iso-8859-1?Q?0la2KC3ZI3Fpl5U+C8ZnOzuFE408vWuBe51tmFqdQDpaQ5f6RIZpG/QrwB?=
 =?iso-8859-1?Q?B444dXMNPKVOG1ZzgUQplMEaROujaTDzLGURy4Vp9J3jigHvzSVi3jMf5h?=
 =?iso-8859-1?Q?28efQZpTueU0NFYIs1esksvM70hWVuFFf457jy5IhNQ6GO9RiBQxGc3T3h?=
 =?iso-8859-1?Q?+qPalcZR7yEUUTeIHs2TU9CZDdLEPykTAB9sqwkKuuLve/fNvizzCz1Aex?=
 =?iso-8859-1?Q?ZjZHaADyy4yxh8se8+0eGJ8qux9TaAOoSzGB0zwpCqyZxRya5LYkrlGEGU?=
 =?iso-8859-1?Q?odWpM/g5mYnBCMrG3Eyoqy4pGtC04Q1JFtSm/3IUqUZ4AQV5rOZP1FSLhF?=
 =?iso-8859-1?Q?J8C6OvQWXPI2fXrDXeSeI/RiYdpCqu1tSqq7XAyhGrNu3SSvnrId90fGr3?=
 =?iso-8859-1?Q?l/zP1+2bADX7WTBx28a7jP86hv5a2B2CVP3ijdBfBp9qLJR1ePVsBJXRer?=
 =?iso-8859-1?Q?LK/soT4eeR2eZDxjjpxy8bpIHD/MIEQYXtRBL1ApEU6l15WbhN6hnI6J8o?=
 =?iso-8859-1?Q?N46SRksA6cnowqMitQFzy2F3BZQwPaIVSYVvgP84Wi4ZCBEUkhzAjlOUVS?=
 =?iso-8859-1?Q?+Gq6fD7TpVbBuGmrf1sznPrbKH07iuurV64VicCKESOrbjW+WzAYr57BFK?=
 =?iso-8859-1?Q?gbbJpbY8Nc7Y8qWJKFx8R9v21Lb2TK/9O+xlQEfUo7Uwzyz8F4NLSR60Q+?=
 =?iso-8859-1?Q?qlQ9DOmsfEvxJ/9YgdMBMjwWtKmqpBQo/qeaxPZM7fKZqXshBvIj3fDCCv?=
 =?iso-8859-1?Q?QBvRfLx+VcBP3n/8L5XOvldq/+7RrIAp4STiDY3mRv2AJCukcoQR8ViNDG?=
 =?iso-8859-1?Q?H4Fy+udvOI0/MNdcE3CCONx03OZPLbmmv6ojsIG0/ujbB/wWSCvDOAoqkP?=
 =?iso-8859-1?Q?1N+g2NGmNs+jmcDnclIzwoCXne6GyNDOBHrUUstwPlhd/K0Q8Il3Vf15dD?=
 =?iso-8859-1?Q?Ywd5brMh70AgPdoRypcR8RUJifeI+qmk7FsADitYmfVvE3NAgdoQVgyUA1?=
 =?iso-8859-1?Q?8iHAn1AloY3kysFu64+usYyGxXOIERb52RAWn51esBajAGT+9jcb46K22y?=
 =?iso-8859-1?Q?APxPcGx6rq4Bn5JwWKe1mOcP6hESribLTYOUqyPJNvF6NDvDL3pF7At3TI?=
 =?iso-8859-1?Q?ajcfHtU5Yj0tOGrXqFkjvbae5ATuu6noqKGIVLEPCQGU7JBQx/vtFFMQ/a?=
 =?iso-8859-1?Q?MIBGKmgPhKGL6mRorqxIxk5/VcmR4sK5xL?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f66219-4ca8-4fa2-f1fb-08dac38a988d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 02:15:25.8064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lx8nEhbZ8poFo5c6sMe5+wq3KOfcdpZPH/Px+gGXozUwDeYrRZpE+oUlD9VlmEPsjlMe17LDxcFtS1UqZjBRBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To allow further flexibility in the git hook, the smtp header
information of the email that git-send-email intends to send, is now
passed as a 2nd argument to the sendemail-validate hook.

As an example, this can be useful for acting upon keywords in the
subject or specific email addresses.

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>
---
 git-send-email.perl | 57 +++++++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5861e99a6e..3ce5b1aad3 100755
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
+			my @cmd_msg =3D (@cmd, "<patch>", "<header>");
+			my @cmd_run =3D (@cmd, $target, $header_filename);
 			$hook_error =3D system_or_msg(\@cmd_run, undef, "@cmd_msg");
+			unlink($header_filehandle);
 			chdir($cwd_save) or die("chdir: $!");
 		}
 		if ($hook_error) {
--=20
2.34.1
