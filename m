Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1FFC54EBC
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 21:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjAJVQc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 16:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjAJVQa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 16:16:30 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817285C1FC
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 13:16:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOS8hma+Z4s3JTQPXft7bhYrI7psBT+c/K+9DHpI/NnOX0Ssc6SwCn3Q5XTxHkVoaFpZgdx4Xqad1NwDNzhmBanh+RU2vLf6C2k8D74XoM/vZqcBOAj8zS6pRV4FsKGM0RDOz4RWSdE9pNeAfg98O+7zgoXZH76m82UI74lWEaGQoBELl/LTTpfkg0sv/FyJtm9tvJjPBYWUls6kN6AMZbuLC+xmhXX9CfsRTBvSEPCR0Oi0SqumvZEZaGu7OMpcVFd8qxyCYv6MdOY8Sf2tVaaye7ELHZ9xSqNwJGVN41+gZw9LMpOIGUQYaAA8egAODxrH//NS1xmE53i1RZYsJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9M+LtdeDtARP6sIeVV+OY/iK4R1+9zkz6iAYEq5W3s=;
 b=ZjSOdWt74epodPAz/2k4+tm6BctbmkC+4mHdl2gO1OwF8gxFGYORvIYEk+yOoRBxjn+lOqaxXCX7zzO4i1AYV53Dzjeo/6UMDSsct6wPMfNIm7f31UdHXpnhoR6OX0F+w9A+r4rhXC/a1jgwTZQnkmkM7mg10yEgQYWUcamNJjEBj0wFZp6kjGpq8UjRgHu8SKQ7r6ciPGuWI3D2EITlwgLV04bqvL0MUG5gL8cT8kcC89e/YPvHh97v+WLzmLxx6iCGwwx8vy/x9BfxvEtI3uMrcfyX41E/wuiVvahVuw8y8M67lx/TliItuTtc8mKbu13ISJy6I+IU+BihizPG8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9M+LtdeDtARP6sIeVV+OY/iK4R1+9zkz6iAYEq5W3s=;
 b=bVSOkWkugdhGTR7s4G203RuV7DGelPlsxh6bk/De2mOR49ZE+1QkewGdw2i774HqgiIAplKYMu+RMR/+L7eYfOzLwIVueIT/G3yZWtZlhll9yuDeHRiOQjxYb416W34Ih25eocYoIHXqX8pZv2F+OJ93pZPmzvywKDNMglOSeug=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Tue, 10 Jan 2023 21:16:26 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::b282:6c4:7660:583f]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::b282:6c4:7660:583f%8]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 21:16:26 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 1/2] send-email: refactor header generation functions
Thread-Topic: [PATCH v5 1/2] send-email: refactor header generation functions
Thread-Index: AQHZJTjMQkM7Bmd4+kuTSVtnSb0OZg==
Date:   Tue, 10 Jan 2023 21:16:26 +0000
Message-ID: <20230110211452.2568535-2-michael.strawbridge@amd.com>
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
x-ms-office365-filtering-correlation-id: 313a9a08-14b3-4ea0-66e0-08daf34fef4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ChBm37HH1y0T6cK3Z1PVyw6i0vkstGr7YLYNsOhfrmH6tfBY55hZmkxMVukLeOMgNJImCJ4SSH5dYiAsyUvAz7AjMSBGMCI/0y7QTzP5fbJTkTuHlcxoORS7Cbx9ceN8j0Puui/fC2NdponFtegXwXIUSASv796IVoSW2CNTY4bEOB3ZxH1k6CAy3JbbtoIoAuH9vEGnwJ/1LSV12xjrWXghOZeUU6Y0rp298ID3BCn5/v6h9OmiJgL/mKSAQ8zQNvhh+SDC+++tQ3vkJBDdThR9VqgEbSlbtRx9f6MdqyZGu5+2pCeNKAuQxVNlE0El1MZxwOca1KRSTBFgeE+09gWGy3VsLCKt6gJw+i9rxyzrNiUw9CColZkOGfx792E+rt+Z4asCvuXdSULOr1th+8f2CyvHCNUC6zwPG5WWRi0WJYWy8aCu9mHgC0O1IBZLB4E4xzbxcHRTREojCBfsWFDZKT3V40WnkUfKjWSya/IfbkrQ7vaVhyH/2S3ZsrlpmEb6jTx5F+45jtKC3NKEa5sKfLmLUQ4EoY842bKBvHd3ajom4sKDPDOc+XPfwp/XMCQwmjhfpKsN/EfbSkkKs/2vkSTYHSF8EOUFlUOqArF7AZCTbjIj70iKITtIWlAl8lkx4Bw6MgDIjv0F0RAtRQY8vdaZ6xTo3uHLaW4/4fF+wDdBIZdLfVmwIXd9ijA7eZ1mLOqULEnfum8+k0bmJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199015)(6506007)(478600001)(26005)(6486002)(1076003)(186003)(6916009)(6512007)(66476007)(76116006)(64756008)(8676002)(71200400001)(2616005)(41300700001)(66446008)(91956017)(66946007)(54906003)(4326008)(316002)(83380400001)(86362001)(38070700005)(38100700002)(122000001)(66556008)(2906002)(8936002)(5660300002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZHwXxTJzlEqg86aDL6bPYXa9IJxjDqitP5USDghXPZSsslc/pFCQRBMJM/?=
 =?iso-8859-1?Q?FU4rPjrZ0Td2rlFGor9Y5s+Lo2fYl+Yv95jFDlvR6w0BCbSpRnYUQJqwU0?=
 =?iso-8859-1?Q?AsV32zC+4YdMVUxG1vcvgxW7sksLJZvzC27KXzoWf97YqWRrVcLMlyxlVn?=
 =?iso-8859-1?Q?2wTI2KPcGl9wUWnfFDMDeLoKf+Tst46BSb6OlhgGpWcvLRSwBitgXywnMN?=
 =?iso-8859-1?Q?yE2LK6zbE7ztLdEBDK7eFUlvzNv54a9ScY+7Zr1yj6V6ziexJmVv4xWXHi?=
 =?iso-8859-1?Q?Ut8WGi56uhDooviberLO4Fr7Mb6AqZ62WSsxZf+Ge47nPiOyxmJQuM/VTD?=
 =?iso-8859-1?Q?mE+KhI0qSYGB/jkoWSdYU4eFjFcdldItVzG4AHCETDUolNdfz1Ilc3g+Am?=
 =?iso-8859-1?Q?7qigmZ0QDWxNdMoF2z8V2z09sgwBRaIk0eZfe38vEOZCsDx5i7mssgHgbl?=
 =?iso-8859-1?Q?h2NpnZhGE5qMev+sJzuWoprEc1pz0ieyOwbbi9O4NL2YmzpmBiBiznqUEn?=
 =?iso-8859-1?Q?ecPm1bHpY5OiG1E+ue0rTor9DgAwKKc9CiXr21NeG6J8MD7oukbZvyKA6t?=
 =?iso-8859-1?Q?/O63FNXrJQeSDerDzlMoEiT+h5RxKq388r9wo42zpf4UCoj0S877Q5p+m7?=
 =?iso-8859-1?Q?QtAnVM4VRNWGeQrniZVGNf5xiX8YQKrUFTQrlDpVddLiH9NzSq8EkpFLRO?=
 =?iso-8859-1?Q?IBBCKBHkR7EHhODbang1UUE173SSUQ6n7fQqa0+xE7n1AsGBOIbaCYlZwx?=
 =?iso-8859-1?Q?CuvVUu2Fn9CJF33W32SMiRcoBWdCSC0Pp/rvWzZsvCRARYVfJsLRukTqgY?=
 =?iso-8859-1?Q?+epnn0O5XLAOD/XdB7QaAh1xWPctmrxI6ra9gppPs63WnzT+13zWkS1Amd?=
 =?iso-8859-1?Q?XU+CU0lnhga7nAhDPxngB+l+1G8rtGIWRV1klmNrqQaiW2qmLNudD4cgzK?=
 =?iso-8859-1?Q?Bh1IIN6ANopB34CvfwtsrVVsWZLOUWRA+dIuBvuwZXbGj7hMxoUDqvZH1g?=
 =?iso-8859-1?Q?hAQI7oafcH9BJoO43O8UFb3BaUyzCSZuTDS6OmjPHrdWFB2YQvB/ECk5NF?=
 =?iso-8859-1?Q?1KsBMSbNubp5jCwon/QvzjxlYorzrSN01Xoi1w8DC0Q+Ww+RgIv3QfPq7X?=
 =?iso-8859-1?Q?Ag7VRrcqU4uk7WqrumYtBsmP/fSE9zz7SqTNBNKfoyg2JhAB6I33Kzs8/4?=
 =?iso-8859-1?Q?PP1mDI/N9uxFDMjT77H11z/2CXq6gxqFTTB3G/R3UGMXc01dYvnBhEqE+F?=
 =?iso-8859-1?Q?u1lynSR+lMBaV63W4lQEnwb4LidOJ9eW1Qdq1uxpfWWdweRcmqyepzb0zy?=
 =?iso-8859-1?Q?yqRj5YELPEZKa3j8oJyZ3Ly0g4bb7QddDCFANngsPzwq2/tb0f1wx4uZui?=
 =?iso-8859-1?Q?zxWgZAyNrga5fsik/0BlB/pfm8PIcG1Ydudx7AtDGlw6fmxEJyGOj8IccR?=
 =?iso-8859-1?Q?rEi7kE522GTpgBmoNSEM3CeMJgc8Uy7UX/IlYfOntPoy/D8tpbLUQBh65H?=
 =?iso-8859-1?Q?Qe8Qu8jVyISEblZYTTyMXRL5e0CW89ytPNmTLcVbj9Iuxn3Crsf0kURt66?=
 =?iso-8859-1?Q?yW4iIjkzuCRyxeagyJ6UGqXxsQG9l8UX54BH+6Sipu68lb9sFQgUNkcX0l?=
 =?iso-8859-1?Q?ClAFFknR+0d1C+4lBEjb2ot8h8oqXqXMrb?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313a9a08-14b3-4ea0-66e0-08daf34fef4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 21:16:26.8671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xR/W0qcZ1cJGwKQGeJA0Hupr2zCg6CfBbyq+a1w7M/M1kNRcqvDXnsF0Pz8ooqrhGLfruRUaHXX3LR25ncoI0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split process_file and send_message into easier to use functions.
Making SMTP header information more widely available.

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>
---
 git-send-email.perl | 49 ++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5861e99a6e..810dd1f1ce 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1495,16 +1495,7 @@ sub file_name_is_absolute {
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
@@ -1546,6 +1537,22 @@ sub send_message {
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
@@ -1735,11 +1742,8 @@ sub send_message {
 $references =3D $initial_in_reply_to || '';
 $message_num =3D 0;
=20
-# Prepares the email, prompts the user, sends it out
-# Returns 0 if an edit was done and the function should be called again, o=
r 1
-# otherwise.
-sub process_file {
-	my ($t) =3D @_;
+sub pre_process_file {
+	my ($t, $quiet) =3D @_;
=20
 	open my $fh, "<", $t or die sprintf(__("can't open file %s"), $t);
=20
@@ -1893,9 +1897,9 @@ sub process_file {
 	}
 	close $fh;
=20
-	push @to, recipients_cmd("to-cmd", "to", $to_cmd, $t)
+	push @to, recipients_cmd("to-cmd", "to", $to_cmd, $t, $quiet)
 		if defined $to_cmd;
-	push @cc, recipients_cmd("cc-cmd", "cc", $cc_cmd, $t)
+	push @cc, recipients_cmd("cc-cmd", "cc", $cc_cmd, $t, $quiet)
 		if defined $cc_cmd && !$suppress_cc{'cccmd'};
=20
 	if ($broken_encoding{$t} && !$has_content_type) {
@@ -1954,6 +1958,15 @@ sub process_file {
 			@initial_to =3D @to;
 		}
 	}
+}
+
+# Prepares the email, prompts the user, sends it out
+# Returns 0 if an edit was done and the function should be called again, o=
r 1
+# otherwise.
+sub process_file {
+	my ($t) =3D @_;
+
+        pre_process_file($t, $quiet);
=20
 	my $message_was_sent =3D send_message();
 	if ($message_was_sent =3D=3D -1) {
@@ -2002,7 +2015,7 @@ sub process_file {
 # Execute a command (e.g. $to_cmd) to get a list of email addresses
 # and return a results array
 sub recipients_cmd {
-	my ($prefix, $what, $cmd, $file) =3D @_;
+	my ($prefix, $what, $cmd, $file, $quiet) =3D @_;
=20
 	my @addresses =3D ();
 	open my $fh, "-|", "$cmd \Q$file\E"
--=20
2.34.1
