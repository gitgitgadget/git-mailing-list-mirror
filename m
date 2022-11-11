Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB39C4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 19:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbiKKTbE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 14:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbiKKTbB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 14:31:01 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692ED716C4
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 11:31:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGIJCM8fJCCs04fKXbFccH0KTgeI3eklzAJKzWU+jJtX96gJgydQCyDDBbSLRrAoRQkOmsaIqUHViVNTs9FGXJLA5yZN4mj4JIYDPpUbhEqGjN5Dp3q3vHEAkl2FDe3KgAdwvdMR9cIYjqLyDTk3SVrqvNdD8iS2Tz0XfiXfvzIToImFRdXW5uCIJ1gJABIpsPpO6yqQ0UpYuQcptsIG/YbVo/rjSpJO35BYvCEHRG/WM1UmmasWbWJQlbOKUZ519nUiyB8iPk/Uc1zTjdXEJvDuSDGtPU/6YCBbdHQWfLMKU7MyBkn7TW0pIFB3Pqc54IT2rGfKj3WyGYMY0xxlhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6muwiSv8ww/DveJxWuQhvAHWxHo+KiAUuWXJuzJB1to=;
 b=CXd6/i+MT9no+e9BboHLKLT8QBNBnJnUpbeJ7aI77eWuQbrbEiZsYp1ewNvYKT93zFHOYCyC2/uX13rdamD5iYUjmgjNfoaeHvj/E7W3R+oKGry3T6Cpi7jVRl6XDQnV8IZcM+hcNIm96BxdZc7Y24PzRFAsNszmgX/Y4y4ZdaGNotbYsF38AZcyTVDX8YfDmKBoljXYbJJqqh60Y227TddSQOSOnnMUoLrQ9/MAGVznaRPOgFPtySNwuth1+Z+R0JRnfQjPBDr5OBZBAbEo3Kolc5OZnS5LdiqpRHDrlfgsuaFGHd/oZslsmgyJeiamYtsPs5f9onDUkCX0fc37VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6muwiSv8ww/DveJxWuQhvAHWxHo+KiAUuWXJuzJB1to=;
 b=A+5QcD7LT5SKHUpCcgB5z6gJsPhb10iB7RmBPeuhM6H+G2svq98izjK2ranHq00yUssLOzrnNR7x3RjjI6coevSAetGtHfhTUEHsIH6uf2cn7t+ZDvGrjuwvEayjZkpcShzbM+1W6bQOLWp6x3Zm8vc49IJdwEn4wdZg2S0VKSo=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Fri, 11 Nov
 2022 19:30:58 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::70fe:fd7e:da10:fd66]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::70fe:fd7e:da10:fd66%6]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 19:30:58 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 1/2] Expose header information to git-send-email's
 sendemail-validate hook
Thread-Topic: [PATCH v2 1/2] Expose header information to git-send-email's
 sendemail-validate hook
Thread-Index: AQHY9gQge+czSpbllkurICGmw4j1EQ==
Date:   Fri, 11 Nov 2022 19:30:58 +0000
Message-ID: <20221111193042.641898-2-michael.strawbridge@amd.com>
References: <20221111193042.641898-1-michael.strawbridge@amd.com>
In-Reply-To: <20221111193042.641898-1-michael.strawbridge@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|BY5PR12MB4291:EE_
x-ms-office365-filtering-correlation-id: 2691c82b-c4bb-49fb-ef72-08dac41b4291
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eXfMUjAjvvm9iLk7sYF79JK9PHLu690HGRuPwX9lEG9sETq0Jo+4ntVIVzhSKhtMCJKMVZyI4RF3+n6cGIrNSa6vmFYt1tA4+ZbdciQh2HUqEvBAS6Sdx5qTwpU8NPM0BrYvEd2gPy0xB9EkG2yPttRtI8DysTOURHj1xy1m0uCQDHvXV1MjxR4+Y8NeV51UdOWHTmfKhAv1n3yHVxsVoao8SzkiDor4Zv5mcVIk/oTDDOcMl4wfjSkcozYRk3KvqTg3HpCOftPg/9TJk4rORfXIQ7CMxZOXO61NodNLoGvQERQavabO/h7wmy1MYTHuwJlNub0/GfEyi1gkRC7Hr1Mt6uleDwiuTxQP1K52EdsVgpVGIpOKBQ8YZgaVGYBOpmL7aRBuvwIJMNBGPbRZ4n8YIwBCzKBRoS5vvUVsrpmvSs4P+h2N58DloZ4b0vn/pAF5PytxX7GEgscabqXT8xMaJkNi5Nl/orqR+I9mR0M0NftastmcBWlMwdvKEkYw7rLIungCmE2y5cWgH9VMh08BsYZzHB+NRqxGPAt7Cf3Ic+gTfWU0Nh3d1exZFo8FeLu0c8jdwxFjhQuLJEDOFuou6zgNm5tj7+hABcv3tC5LUb0i9SYzEMWEXwv/d+H0crmuRn+3EMQFXct5B+qAP9XT0UAs25UuRPo5A5nrY7t1U9VBjMAFx2pbzcG0LZokbTOV5NZy65z3HBdg+cFV5PCFyevgefE/fQM7bxvC29SJzqqjDfrKbW98HB8OvsEzeqfTwLZAOVH65yzmGbzCSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199015)(36756003)(83380400001)(122000001)(6486002)(38070700005)(6512007)(478600001)(86362001)(1076003)(91956017)(15650500001)(6506007)(71200400001)(38100700002)(76116006)(41300700001)(66946007)(2906002)(26005)(6916009)(66446008)(66556008)(66476007)(8676002)(8936002)(4326008)(2616005)(316002)(186003)(5660300002)(64756008)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Hbd6z/decB6Jp0SWClXFo03Cl3DyUMya0CoHTdQG1XzVPygSXTZlR3IOEo?=
 =?iso-8859-1?Q?kkoHd+1Z9VyIZRCdDDwyGUN8lpDww1RZcQC+SktfXhrFKbIqzzmeP8GLnR?=
 =?iso-8859-1?Q?3tJR8GXA4o3TZchphlqigSWdME5WKh0/WUKjTplTP/PirlQOfBo3NpDEWz?=
 =?iso-8859-1?Q?inPOtuv233OfdWN/XnKWCGKRT0phVhhQ8zPMxpJc8dPihveuFyMOQhz6Yw?=
 =?iso-8859-1?Q?rV/AmGVLKGemoiMPiGWbAhSObeY/xpg4P6LqYzof4AxdX1S4brJLUa+bAF?=
 =?iso-8859-1?Q?WS7/sBSs29/8E+8l2xCp1UZ4Dh5QhbEVty/KRpwuUhYtOB3Dw001fuxCZR?=
 =?iso-8859-1?Q?ZoW8CgSr8tm831S/i+DYDtT7I2kFZJHBLACFyK1ij8NUoX7PWLKF/b05hH?=
 =?iso-8859-1?Q?iH6Ub2QYuWXAhC4p7aWY6FrLsXE1IRdequDf7B9xzqVWcHeR0C6OvQX7cG?=
 =?iso-8859-1?Q?6klZzfwpppyDfteyLvM2iE/SsjM02Z6lzc0wqkosLMqW36MT/lBmx8rV0z?=
 =?iso-8859-1?Q?ZgZnnQDrxlrRULmm7dJLnEKxOc5TRpllSvxg+KN6mesTgnB3CzFSKetAse?=
 =?iso-8859-1?Q?237TXnglJblDqUdSZ6qF+9oGPtxqkuhtchCbOz8Tw+02azJvS/sDwv4mB/?=
 =?iso-8859-1?Q?YuYK8blFUdMyvCJCIjgZ9i5iu9kxvWSa4BFspZ8a5MlhAiV1dBUIfWn8rA?=
 =?iso-8859-1?Q?SKS2T5MtK7U+VEjfz8Ypvpu1pzNi9pm0okTFTDgL6zqsDuznqPJ8pI9/wO?=
 =?iso-8859-1?Q?8dlJpI8uw5+rFq1VpyzVAaN0nUjZRYsIaUlJU5M1w9dfG/v+vPL+u23/dR?=
 =?iso-8859-1?Q?Vclq31FqTwDR7UvoEQ8y9GSWsWjm0PAfCxtsNflJf0Ph+SzgLJF+fMsm8z?=
 =?iso-8859-1?Q?Tx7/sl+yjGWT+lMsHV3S9bB4YuYjVBBoXfXyYPs87VaxX4C1pRec6YiLUM?=
 =?iso-8859-1?Q?HidtMDqeAyYJePx3fi4k2MKV5k+09ZIcZcTG8+tJM5dif8RM/s2c3Qb/NT?=
 =?iso-8859-1?Q?rstM5PcH0i2vXWRHkz2vaHXuGc7mkCLj/u2Qeg5FtTi4eXK9nIDixsEzgC?=
 =?iso-8859-1?Q?2BA8foPLYCs34VafTALpclVujuJgmZTXdvH9gJaqFa1Tlc4zpDveZ03t1e?=
 =?iso-8859-1?Q?hqQU2v9A+Uml6NWjqawYbLQ+4S2xy9oCBBWM04v7eEqABexOj1WWBhLsOt?=
 =?iso-8859-1?Q?6U3WHC8aUMsKcLv2c7g+B26wZDVhnqr4f7EmDh6hqTkpxTn+tJZ+C2+A9z?=
 =?iso-8859-1?Q?1/edDbjkS7aoU1Cga+5txbD3pzIV9+I8q6SZS15vdQsseRXo3m0gPPYsPw?=
 =?iso-8859-1?Q?SuJ0LVm1cwERUoNil6jgnLp+7i9jlh/bih69WTqK56ZtkWMuRSDmpQV6Go?=
 =?iso-8859-1?Q?mJQZq7BbWeK5Ok3cKQHUlnRvBY1MM0DIqgiCSKlWJj28uGD7wxzYvtnpLd?=
 =?iso-8859-1?Q?i5vzbwwijUYT0V1VbZ7Sq+oecbdtGZVBfpZQjfU+GCfQpHY8PDMKZbTreh?=
 =?iso-8859-1?Q?cuhYFlrk+nZmnsoPjdB6SXWlEXcQeGz/N9La5gayorGanztPplwGAJaUce?=
 =?iso-8859-1?Q?ROM46XkpQh1J4t8iIniDkpuzak7I/zEbELs0SqpeSLbI9WjPyt3l9NJZx6?=
 =?iso-8859-1?Q?qyvIUjcMOwWGPJCTKfZQN6RdPeZ6VVW+8B?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2691c82b-c4bb-49fb-ef72-08dac41b4291
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 19:30:58.5742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qHsxiGVeKQD5A5KYYeLnQ5UZfKc7Uz63WeIUdX9gt87pDypz85rdCe4/eBP+RM8hf0uPfy7S1GbHZf+Rut3Jlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
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
