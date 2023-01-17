Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4B2C67871
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 01:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbjAQBkC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 20:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbjAQBjp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 20:39:45 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D552B601
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 17:39:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5LM4+un0rvsBL5n02QB0ulfhBVLcM9CcOrkyUiJUcjfkQkJpowNv8B0CTHACdprnmm34lz0gVxT8nTWN2V7lJJ9BRe8XRbc0DR1FsH5kMJ9WkZIMgyqGgjoARV5T6PesKxAYIERZij0JN53EG2RLCO83h+/xueXlZk0WbDYUIvPTTq0E6EegzIQTWvVjigZ0bTuW1ZfHzzTIpNcCoLIu5kph1FWnuMF8uPLRBYm2u2lWkn9C/WAbqqPNlZRkRxTVj5UiAhPrp8bF7xd7jzMrLe5GI24FBFLfFrj9fWmp4k6YbaiD92v0QfRHhgekkVQ9KNvZUfVJ/TVD6rloEuTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9M+LtdeDtARP6sIeVV+OY/iK4R1+9zkz6iAYEq5W3s=;
 b=m2G2iBiFWvy0E/QNxzPq0y9JRceRofuRBHtvzHqBEQGs0hABjrHXjZVflnsTUFgysAP2n/wyT/omiCi2M39mUykda1YyIFFXmT0hBB5GyDn0duAuP4i4LztOLk8VPxDHgzUq4G5JqLwCY2pj/o/l4sUKW7KTHbvuwpgwYGUSpnil0hOG0wI4+y4aknkWpPxfJ/mrvFObYG0AJr9RNSUvmfbe1rnuHLVOpwk6bJ96TXEIVqdNefJ/98DijyDXisMgXsttQ9+yam3s5q6xePxezDoC6g5gLI4HwAtFgqycE7b5PgFKWA+IynqZx04rNtaEfeZ2RU82ENeA0tiBSuzH9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9M+LtdeDtARP6sIeVV+OY/iK4R1+9zkz6iAYEq5W3s=;
 b=1Hz1usePLnne0a9OLdIZSQvn+LjjElaKM3OpMo3EC6M3IRnWYdztnc7AG9QtiM8Md7rxqUS9HYrEnLkKVQ98AU270AA6pr29nV1wwq7W5PURJAFEErBEu2vEZPke/LbHZ+0V7J+aHKBRJ9Ya70A6C+G93EImfroXoEPsarIdAqI=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 DM6PR12MB5518.namprd12.prod.outlook.com (2603:10b6:5:1b9::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13; Tue, 17 Jan 2023 01:39:41 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77%3]) with mapi id 15.20.5986.019; Tue, 17 Jan 2023
 01:39:41 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 1/2] send-email: refactor header generation functions
Thread-Topic: [PATCH v6 1/2] send-email: refactor header generation functions
Thread-Index: AQHZKhSRIu302wxjykuV6JI01Ath/g==
Date:   Tue, 17 Jan 2023 01:39:41 +0000
Message-ID: <20230117013932.47570-2-michael.strawbridge@amd.com>
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
x-ms-office365-filtering-correlation-id: 3099e9d5-481c-4b88-9b8d-08daf82bb420
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N/01c0ydFq1Yahb3Caphw9Azo6gSfqQ5ajuUhRTSaEGq5Yz7k39l5GD6AoUm+lhInjz6XwrckLYYAysRhn0bfmBAQrTykUtOH1qK+3vn2LVFV/m74YFXuB0SMRaPX5KZq+27UiPypvq1GS1I9HJydrCpWn8FrI2ZJn05gmDGigYWp7dSwfeQcVQRRLdJV/UJV1SLiS01fJc9ZyS8+2KbHrrz9RGPHlGuVgFjb6l9W04fkG1nSkLgop69bIlcDJnY0iRPeS4Uze5IleBhkrRzaxHCnLKCostsn4LUrUxr4lg+4FitDI3fL12FcFjBKTwbhmDn3Xn5W2Ia7tv1StWRAi1BWMoMjkLifpMKRGD58kEY0JJNFuzhK6IKGc/VLBU2oUxNlD+Uk0FmRgFQgdEpJAusDs2H4jBPIhpra6oRfGpRDBsPFyTysX5gkpojUvBmh6L7Hb65MmzNopatWjwyWkRLetBHGz1FjrH4mxR8L0ZY1JTod4NPJDZ6UkIj0/Flv0TzogtqfzfIg/4I0WEIlIjkJ55pbzjwaDXZa/M3HXxHHIp5JuQm0dDAO7W57vlZb3RORVE/B/vjz0/0Rjtv6O8ZP9/heK9Ysdt0PX/5B15/zRp/DAxNsl0yzp+rK5quhEdrYSLkmhiGM22ocCLMfdgq/xv6SC1rgsIvAio3ZndSaMko3Dxvdq9tNTyD0JCbcfNcY5PXdViMd6Y76i7xEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199015)(36756003)(478600001)(71200400001)(6486002)(54906003)(6512007)(26005)(6506007)(2906002)(41300700001)(8936002)(5660300002)(316002)(6916009)(4326008)(8676002)(91956017)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(122000001)(186003)(38070700005)(38100700002)(2616005)(1076003)(86362001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4MFmYvRRkjupJToWUve8NUnwVqOO3egJdjKK8FeAgCSMmkgYulpcedy/xN?=
 =?iso-8859-1?Q?ukOcV4mb61AyH6c+CVhqNh0UbaeGQczMvqW+pZ4wVVbpSX51afZweKKAzF?=
 =?iso-8859-1?Q?2aVrBaRqLXx24en5v249tKyb4r47P/jqbp9FzkKFU2Yk6lbM0XFu09r4P7?=
 =?iso-8859-1?Q?jAX71qWVgYlToMcxAfSIrG/X//rrVcb8uFgLfU1pFQIpM0xpRIt7V5JFOT?=
 =?iso-8859-1?Q?ZRhNkEXB3E8YUTLc/HPY6w0P0N2+eeh/TC2tniLAT7l5bSqRBjdDYRLGmS?=
 =?iso-8859-1?Q?jZl0Y5hk4Dj7NYGwZroi8Q997eBOoc0GdNF3RdrssNcFeoSnWTno4LgI66?=
 =?iso-8859-1?Q?Cj1h9sP2wui6Kv5ge4xVK6vZO7AD13FzIQsWBGGOcXLpaL60r2BA2RwjMv?=
 =?iso-8859-1?Q?WIJLKcgeo1Xc0yZddU+gpnptnJR9d46QPtaSV+eNlS46phaC+F3EH1eB5J?=
 =?iso-8859-1?Q?lIojJUiF1+yCmc1vgrliArfsXHL3SP+4UfI2qOcZuApN3fD31jg+eib7bj?=
 =?iso-8859-1?Q?EnYAHTbZfU/f4UiCy87VM6kJQCihMrJjPqWp+kkaJINB462hZ//wyg+K+4?=
 =?iso-8859-1?Q?ESNjsOTr8uj6R+ylopmBM8E4TFNZvjfHzPyMhScst4E3SE9KZNIS0BPZCp?=
 =?iso-8859-1?Q?vCtUNpdVy8uSDKCG8smGqxRWtx1ej4LapeihK8hlybVCM5yBFp4CLEBh2Y?=
 =?iso-8859-1?Q?ePNuU1fF/uEx6puh6UmOhkuhKB5NKeJ/Kpnh2cz0XM9Q74NxVpoQeWPl+0?=
 =?iso-8859-1?Q?Q2CxXola+X9PhBT67+KaFk/XvQJg0JXgz2jHFqj5kGZduNlApzBljieOLj?=
 =?iso-8859-1?Q?VC4uTxTq71QkTRXTNH+RljomBti3YN85wkJiCPnxTpO/6ooiHRre4H39L0?=
 =?iso-8859-1?Q?/vzzNPlNK+ItrwklvbBkKhAn37xvxCbifUwyOlzcPEEnAmOo778OwMVNAL?=
 =?iso-8859-1?Q?GQq8fxyWFlyzKhEmz9Cp/GCmQzYY7CjJhtfclowFl9jyCjAJCsuft/sGsK?=
 =?iso-8859-1?Q?RJGsGwNUWz/2zuBBvS7/Apr2IbbA9cAmmBQqFqUf6HGC1mzngrjUxOx9f4?=
 =?iso-8859-1?Q?fPbnmSQPbY1JcocnnkAPcU13oLsGlPKse98DtrJmNkGrlNQBp9zyEz8Yor?=
 =?iso-8859-1?Q?C9TphQmz9BDTcLSFKLO6SN16OCw2avtPN2IFnDl3tlxqoQ2JutRkv0Drap?=
 =?iso-8859-1?Q?pvE0pvFoUAG8DaT7TeMyMpCmKtZ10vMBeyCL1r7zdxZs3SCTjC25Rv8PGr?=
 =?iso-8859-1?Q?ChGZvPmdHmeO5WgLcy9ajVZMmyk128jCBicHN7edvJvfnSEcbRRe+LDrXy?=
 =?iso-8859-1?Q?H23EvsuJA/nFyOYZ3P4O7ihv6vGlI/r37nom1H47CXTwsrMRxKj8FeT0hp?=
 =?iso-8859-1?Q?1Ck7Cn53Q2gRjH8KBEl8+CPlSPdonjTNrKauwP8Xu3FsG+Q8YC49SE4xlW?=
 =?iso-8859-1?Q?c8O54ObnJKnjOWTlfGu3kvXHM9SgOATvtlH+2VTRq/9Bi4TbwcPkmW2rUI?=
 =?iso-8859-1?Q?UM+xyzwlw28PX96Y9i4eQIIXnye2zJf7nRnZBo+oCSlDkOiqbiaggciGQN?=
 =?iso-8859-1?Q?Ae2CfsIpfM0kWPYaoMFvx9SLiKOy3FJzLXMAkEc4xOHmqyote66gBv0BhL?=
 =?iso-8859-1?Q?sk+X+jsCbttlwHOsRg4if9zvY8ioYdm8gR?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3099e9d5-481c-4b88-9b8d-08daf82bb420
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 01:39:41.5508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hbGfIL4cHVJ26KSx+fnz1unqpWJPiVLik2Hl5/CsQFfYtZS2SLfBTYlzoLOB0oXRlhfq146sbWlghRozDhC5wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5518
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
