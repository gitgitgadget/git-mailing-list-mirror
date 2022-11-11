Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B852C433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 19:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbiKKTmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 14:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbiKKTmi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 14:42:38 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5072E7F564
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 11:42:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INkdBvhpp8WQPOc96M37wi07+50kFWxGv0H38nhZXokiJIeJ9PU/hKZB1hZtM0xT0bX7G5mQAL9/C9bo9C6kN5k3rEOeU6KjG9HHWMwYbr403kgBYmKyCE1bsCoingNrEwVYR8tSDcE/wv5UdJUaR2qiTpxZp1UzWktnqoga4GYYgFiYNJqwJly7ulpEvhopbNfrMFOW1OYbVUoNZf+M79nabg4GdATeUnL22tSv3PqWWFTK/flvRpm6ZPQw/f4v4e0PECJQsy/ozICFeYWew/Hm6hC+30ZUOUreHyQWEd+LwZezZodASugXtcb9VBCFDf89LpjJNRvZH3Xgyh5s/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fxiUtlwu1ESwVVgEzVKUoxSgBRpc+mDDHql35fEH5A=;
 b=h6/EZ5llT+JcWUYcYevb4Nb3wd+PdDYED7eCmpGi48Lz8YjwXzanMmWjR1+DZt3ksirNqIV+sIJTqNmglHbnNLQM8AnV2TVjBYyEEel3kD3yaftu77ipG0BrDQ+2+hOniktu6fu8OeznSkBzIhZEP9if5FGXSlxn9USvPD+kTH01hIV84CeaZ4TuByTU42mSHA3je5LpinWqxEtPMC66QJXIKVwpjGVoT2DRWydtIEYpP64udHiUDF5msZaVu43b3rcQRhvvfjwLnEnyQZyl3yRDHRxJksUUxmaNlkDt5JPAU51GKNuyL5LS2HohesY1zfPBYwuV54U425mmLOl2Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fxiUtlwu1ESwVVgEzVKUoxSgBRpc+mDDHql35fEH5A=;
 b=ckmjJvTrrXg8naRhDJxw37j66hagouSNgwpao1DZ6+9BDXMvhcEYtsaAAdimIDLgNsOAs+K7YT4aASBWCNCXGFhuBF6FDFIVzHBVDejGvOJloIUJcr8oLBk9Q/kHF0jSKQ6OnAKZ/ZCj9ZRQgac/VS+8eDiEhMrIxqSKJgP4BD8=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Fri, 11 Nov 2022 19:42:35 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::70fe:fd7e:da10:fd66]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::70fe:fd7e:da10:fd66%6]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 19:42:35 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 1/1] Expose header information to git-send-email's
 sendemail-validate hook
Thread-Topic: [PATCH v3 1/1] Expose header information to git-send-email's
 sendemail-validate hook
Thread-Index: AQHY9gW/tzPeLfHCm0GTpO84iTpdaQ==
Date:   Fri, 11 Nov 2022 19:42:35 +0000
Message-ID: <20221111194223.644845-2-michael.strawbridge@amd.com>
References: <20221111194223.644845-1-michael.strawbridge@amd.com>
In-Reply-To: <20221111194223.644845-1-michael.strawbridge@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|DM4PR12MB6160:EE_
x-ms-office365-filtering-correlation-id: ef6ff059-25d4-4129-4ca5-08dac41ce1e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l1Lmwx4nLlVAx2w6SaLDoTpNWTE4IH2sAM/lrrmQBEWJNwW0XdwLnP8QMZDazSS9njP9rBSZFGwbKIoxv7KcD5ceYOXs/NYL9xd9gBTVaDN3M85cLmbyS/5g6kzt2ROgwzJs1azsP9474Td0U15Qhuxmfn8r+aZDw/SYfuwQifXoErOudJEpAT9EzB2ELp7R/vEoE2JufyqtYnqnNxK133SZS9h4VUq56VM+LWSMatGwDI5M+9oEaHCJ4ghe0MVxOuPkNKcA+NLoQyHHihScSteXAJsh5AE4tuji31+VEBDaT55wVpwtiy/D58v80jzyTdmrZ1nKIRmuy6UBqw6rZMDqHhbscOx5R5KCiuH3VM3Ik/W1CfvdlenjWalwzQZzBlmT0ExbecsT//FeVb2V0rF4K3oCu5QErJXaTan6a1aDYPFEgV+erxuYUbOGJUoiWVsjwDLeEPWGXCmEKJIVBbzyPYBE6Y1s5LjpX6cfMS7C3QFxGzEUHi+y4rrmZM3DFMoyC4yxgUI5rXX2xcjtKMhLEbd9ZcL6pp5uM3Mi8yeAiZh4cctyblXvMnz5vnTkLEX2mxbcE1V+aKyVezUM0eJTrwiWrsViNk5zR571cbFEcJSlCO98GWu5j6IDBZh4WOV5JuJvvDaIdPYGOI89Vx8k1GlYCT0Yrur2Ml1dd4UXpdwtC5jEZm6S44zO8OQQnSANVFl7cVZnbxuo14KLxtDXXjpBCZamEgDHsdtVV5nTPcnnUM9fWCYR2bSefl9NcZuY23IJngGE55+BZhUb4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(5660300002)(6916009)(71200400001)(66556008)(54906003)(316002)(91956017)(41300700001)(76116006)(6486002)(66476007)(66446008)(4326008)(8676002)(2616005)(8936002)(66946007)(36756003)(122000001)(64756008)(6506007)(38070700005)(38100700002)(6512007)(26005)(86362001)(83380400001)(186003)(478600001)(1076003)(15650500001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XctG4QTzPQL8I72IgxTie8BhVKAQxrNBFxr6NHCk7pYAJ6M+0OFG9pBdM3?=
 =?iso-8859-1?Q?MCdPg+ZQyXa36/btn/pK8VyAPOx9rYCEks3VYYrvyVjN83yVG17gOBXJ9F?=
 =?iso-8859-1?Q?I0ds86yitntQDQFhMlxqpyYMqlI60gBgJEOqa/Re9LC66q7cIBn38+zDiE?=
 =?iso-8859-1?Q?Zrr2QzD2kL615RMNhi+W+4NQfbWfiKQSia+ofW1oU777PqMjvM2fMXOWwU?=
 =?iso-8859-1?Q?CbNi/5RUHQYMeoVCGm2kisq7YJAsP/fMsIz3qrfNz3SYWRz95oKn6YpLUy?=
 =?iso-8859-1?Q?NfyQ+giBI01eyzu930F047BUdoD4yitziwZw0ihxAF6QSCPB8pl5YKDY6+?=
 =?iso-8859-1?Q?Igk79VMkjPOlJZ75SgDM8q+agPpeE7xmrFco5y4HR6HjPhB5QJtjnk4p9u?=
 =?iso-8859-1?Q?pjA/Zc4g5++OpW9pRt8ELM50fzO/M36mbo3wp3CIf0Q4NMAastrTF+wJP4?=
 =?iso-8859-1?Q?S/e1JGmHB4PbazsUZEn4LWMN5+j6CY1aiFYnEsnP8gClAGBSFMXC9SxW7p?=
 =?iso-8859-1?Q?hfHDTktPyXlx+h9nGjLniDVpdVSmt+1trJNzXYTmW+kY56kjXUwT/4vCx3?=
 =?iso-8859-1?Q?NAe6F5AgQxRu2PVRGyGqOtHAXTK6Ztf7hoGGvB4vthZfo2uamsSfu1m2vv?=
 =?iso-8859-1?Q?lxUGVAowIb4s/D/i35xA/Z8xcUAjrAk65/IFHUM+ffUZYxFMARAP7FyITB?=
 =?iso-8859-1?Q?WZWFhW9Am1uDXx41liFx7EJPucQK/u0Svs0RGaJl9hclSNxnSyG4y+B8ZZ?=
 =?iso-8859-1?Q?hCfoL0PaamS5LG+cKe1AOaKq3U//U7B/8l80d9cgaYtLyEiwdYfmvRBgyI?=
 =?iso-8859-1?Q?qfqVFywROc8r5K+FRCTgYtmhKx+HVh6Z/8LTItVMKgJxNHGGu0+ImW7KxC?=
 =?iso-8859-1?Q?BL7B9ZpSnZ8MqzR7m6oeloJRm4DtzBiD+ZzH5U1cWsiwDLuasgvbbECzL+?=
 =?iso-8859-1?Q?JDmw8GuNJH3ftgEGiI2QYMOOvvsPHCpY4z8HXXKVinza5oNFwjv6LSeAtb?=
 =?iso-8859-1?Q?yQp0NELvkN2pMvWjMiwwQ9uHY221wDoqKPzyXce7IP5IeX7FEEjyNmu8RF?=
 =?iso-8859-1?Q?sLHk9OoyaM+x9v3Dst8GyCa0eFd0x37SgozcVxs5N0/0dcCfPLeZsoWNHM?=
 =?iso-8859-1?Q?x9lKPhGXvvmlzl61QPy6szlw6QoDxNazc7ut3pnOjFRPssk5CEKVErDaLI?=
 =?iso-8859-1?Q?bSMFAk82wP3zef2QDHyi1F2nEznh1PIgGljx1WojG0lYLqN/bD3cjcxhcs?=
 =?iso-8859-1?Q?IPv2gxlP7MQ4n7pGFL+dqPIc5403uOeR/ZerTJOf7BeZTIAIoV8XWEaQpl?=
 =?iso-8859-1?Q?BJNaRomZT31ePjpJYyHRV+HFzcCNx5X0y6JelPEv+Mc3ReU50+8NXugKka?=
 =?iso-8859-1?Q?mmv/j1PfPKERCXLr4PKNQ1ZMVMCxSoGXcjLTRQ13xb1Ppsagv3/AFVV7Bq?=
 =?iso-8859-1?Q?dqB6sDWLtCFMVHVsRrLpZXsegwN8QWpBNerPBGboCpW4+5bz0oE4ZNI7ps?=
 =?iso-8859-1?Q?Rnm/mGW5AojlbbF3hW1dHyV3WDIKddzxNgf+1VtkpvnW/lroPynWfIuA+v?=
 =?iso-8859-1?Q?aPWelFtARgm3MXiTkhRdRX5n0TKo5CfWJ/1nC/u1tMS6uvE6SOVuizU/Cu?=
 =?iso-8859-1?Q?MFDsN/1ogkn/UUYtlFND3jnoNDDChPefpY?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6ff059-25d4-4129-4ca5-08dac41ce1e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 19:42:35.3423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FCs2Kz84CjyfPPboT0moSUpeinnpm9XityhJwSSuQOp+FJAPc7kyko5/L3PdKt+1qzDD1DTg9Ede5OdA3b18YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To allow further flexibility in the git hook, the smtp header
information of the email that git-send-email intends to send, is now
passed as a 2nd argument to the sendemail-validate hook.  Docs are
also updated.

As an example, this can be useful for acting upon keywords in the
subject or specific email addresses.

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>
---
 Documentation/githooks.txt |  8 +++---
 git-send-email.perl        | 57 +++++++++++++++++++++++++-------------
 2 files changed, 41 insertions(+), 24 deletions(-)

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
