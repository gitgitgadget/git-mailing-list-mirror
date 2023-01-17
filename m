Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B55C677F1
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 14:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjAQO3D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 09:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjAQO2V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 09:28:21 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377BA3FF0B
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 06:27:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGQa/Eqxfma/WNiCUbbh/RWVLG/wSU2F75TYj/lZKh04YwnG2GXOaoHbqavLtr7XNbD75qOdU1TT08mTWlzJBrhm6Xj2MVeSmi+DvM/G1qCV7j2EKanhmGF/Kjpxnkhoj+7v3rFIlrnk0I9d0gPlGLfhvb/4ShAIvqLBjPSDxVsnXwm0Ibev4Sdvp4cBBgNuM6oipIiq5DYGFID+xNWRfz3iyQxYXCp91Jtmcyw5sI9rIDRiMMjhCXHaY+Nd+8AbOJNMHJEgXwzJiYEN4REJ58sYPm2wRrI65VaQV1/R2VR21MLSJqluDn7N1vOpoidMR6xqUMc3tpv5HO34bGXTYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPIobfVFG/P8PWg3jcQlDUDAgoIFBgntpWB6wQ1/f/A=;
 b=NGSOYHf/OGyEi232NcS1aLZ98roB+/HFJPUdODqRxSdiHR8/V11StaTDO9OvuK7cEXvDKWPqHiSk7Z4Fk9IDaR+r20yKojTHfMsFYLydmBpOKX/gDJq+dIIvus9uEj/HadtmgRls0v9fNdiBDW2Sy+h8nDfe0hZhnDJyZrHf9ZaYXNIm0VL3d3aMv/9xsof4UOGwnmaA2Jsa2TSaknhAzaMQAGJTiwvdngem0SwHvViIeSwKVqTmT1OW4dWEqM+JMZSu9zLhM4iwIN/cKq50ir464/cqyrwYY67pK1LwBlzbDvk3UWaPWqTXYUPj4YX5MfhxCTCszE7vFZqdN8fPaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPIobfVFG/P8PWg3jcQlDUDAgoIFBgntpWB6wQ1/f/A=;
 b=aAeHsTbWUDz6/lvWLUNUu1bElZzttH/dp91j9nlnS92v5+gIQeQChGXzIR9XfMMuUTCT689PBItOtQ0CnzCRYUpeINgVQSB5YcV5D4mhJBWhK0rDA1sVvXRL0UeByCK5e0o93egMozaWR5AZLiFhpT59FJSmQ+pnNljJHOe4lws=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 SA1PR12MB6678.namprd12.prod.outlook.com (2603:10b6:806:251::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 14:27:18 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77%3]) with mapi id 15.20.5986.019; Tue, 17 Jan 2023
 14:27:17 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 1/2] send-email: refactor header generation functions
Thread-Topic: [PATCH v7 1/2] send-email: refactor header generation functions
Thread-Index: AQHZKn/NAKZ9rntskEioK2L680jtMw==
Date:   Tue, 17 Jan 2023 14:27:17 +0000
Message-ID: <20230117142706.230404-2-michael.strawbridge@amd.com>
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
x-ms-office365-filtering-correlation-id: 24d759ba-d9c9-40e8-4d9a-08daf896efd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5cod6p1ngJhRJyBYho97OYDiVca02UhZ5JPGM/z7huIOcHTgdsPYs1pLEgfM3ILhjqIjbaf2czC6w7SU/AdgAiX3p46X938JpIrxM1ply1FTDGENwMHodSfHgfQ7Bu+l8B5NRp1I+lKmGE5z+5UCD5CnPVd2Ww0yv9w1bmn/TNBxHeGCcvv2weMADaHituWgRFgGKGysB/FZ3B198+Tof+tY9Ffrt3NY7zllL8jbYGDGvnK/YMxa3gTY/THxQGKcurYPZxpgFd4t1elWIUyK/HyQF3l4bM4utCsEA1+Beu5DRgIJPFwcgFoUPYuId4RTReVlrhSkZ6ONuFDCQjRGlfbpgDaaZzmkhdjb8cgWP/JPm6tb2GPuaAyxyGGHXnzviEFpR2dULUjlSDAPDBfkFEgAGQfkumButLG/Ixy1IPfEwPBWNZh5GyW5UGeu+oN+tYIyKqGmz+guwwqnxev77OhbNS2CKKRS9CjY45p1Zws8dWC4HV9Xn2gFa44mngWadyThmdZ1httFHhgULN+kWVVY2zfgXYAUgGNUgwq2xOoGmUQmE9kxCrfbrplHqSuBiYD+w1ojO/szxNQxIuK1+R72HqMw0UBRydXf6NfbKuMnz01hdTd5/iW5+0I7qK4/KOxHvNB8CvGE6LmWH/y/wO2MtStaHk+SoPM4I/ceBWPOYnJZrhO1vRQv5JmWslWSlqK/gzPU2toaKpnE4vfqPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199015)(64756008)(6916009)(66946007)(66446008)(76116006)(66556008)(26005)(41300700001)(66476007)(186003)(91956017)(6512007)(8676002)(4326008)(2616005)(86362001)(36756003)(5660300002)(1076003)(8936002)(54906003)(478600001)(83380400001)(6506007)(316002)(38100700002)(71200400001)(38070700005)(6486002)(122000001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+l3cdKarMLbKgy0NFlC5VdOI2KGGPJj/P9K3MY8VO0teTuoWt4D67f+fkj?=
 =?iso-8859-1?Q?kG+Cfq0myudksT4R/MRsrnuc3l32n+BpyNMccymKRq9N0Vb7Z58Ht4S5V0?=
 =?iso-8859-1?Q?3jr/DSOFZx7W8l6fVw17eTfNtbpvG1xFwQXWXjQmqG6gDc5F+9wuu4REfq?=
 =?iso-8859-1?Q?gtaHHi3TIbHtTTe8mf3numJueU3Vwr92yKH1bkJJ4tM6tlFTbXF/9uGmBU?=
 =?iso-8859-1?Q?sGy+YlLxEAxW/nY5IOsAXH1GdBE0MDFvUzbVpuRl+XHfP+GF2SLUn1SWOi?=
 =?iso-8859-1?Q?x3B6jcSerLNvgRcD/qrhfERdI9SYJL04asMs0X39IsuUelofrPkJY+1JwV?=
 =?iso-8859-1?Q?Qqu4MC1QzstMu4s02I8kpnIQtjUOvg7dNnewmp6/xTzrkJ92YgjY16MYSK?=
 =?iso-8859-1?Q?TbeWGc3J7K0ZmoILPbHpPIgyRxZK2rPEF/BDX1YzPUkedzor5QNBGtS3TO?=
 =?iso-8859-1?Q?KT8q/TFw+rnsI3vQbA5CtkApccbBLuTtKyDjAhW+WRdFJJFywUwwjSjFy5?=
 =?iso-8859-1?Q?i1NsJelLCzvh6YUHyHbOzwJxciMwwV6CagnyOV5ufTNhmHK+VWikH2Radt?=
 =?iso-8859-1?Q?Q7T8F5xf/CSf4Q5HUXaAUTJWnQThUOqQNjwAGlPzHiQZcfGaXxoELgbRJP?=
 =?iso-8859-1?Q?I/vCjeWbeFMFEmECiAYvEf/2H6ER214ps9CPq/MVUvupIybhkCs+yKZVPw?=
 =?iso-8859-1?Q?wKiHh1Q71TvcguaxOcJtCiQ/J6HDRGfePYzMnglYfbHLLafejst7Y3Did3?=
 =?iso-8859-1?Q?TUsedtytXC8cGlFpKZCRQ4GgeZELH0T0/ZT2SPMFF7ny1c5n17W9oGkL3/?=
 =?iso-8859-1?Q?3hytv78pyccpQryR4w/kPHdn3uYrax3FaEihXyx4Lu40ScZDZDMDSHyfjj?=
 =?iso-8859-1?Q?HGgByGxMna8hOc0K30jHFKURIzclUMgE+UB5+TsriMNpArCLmGPuUnp1qm?=
 =?iso-8859-1?Q?IcBYYj1kEs8Qr6WxXwd2a9DmpobLXXErw78uvBags1GcZRGnXLWhT2Tja2?=
 =?iso-8859-1?Q?Sn/ais4zMcbYnd7BElteG1R/vZzEC1JP1l2sbMh++JUk+0QQBhazPemg0H?=
 =?iso-8859-1?Q?uHsO3hNiYafjN7rL1q4eS3NPEY3igrETjgxNYnu+TwfPX2/8uNPSAcNj4P?=
 =?iso-8859-1?Q?1QnDLvJfilBylnFa0zZJgDkHFJ+vEAe0FVTCHu8tiI+nqodTzsP7Toh8AW?=
 =?iso-8859-1?Q?UXH0rfyESKu2bvwPBvxXrdTfKluhB+OWGK5Sa9uyl+JvhECPTjpCKznawk?=
 =?iso-8859-1?Q?MOIE2suYqESUmnEopCgI38QX4L4p/CKmvwJVORXdZxENYRSxj9Ao5fPZFN?=
 =?iso-8859-1?Q?QPIQSHCbWFjUuOiCAuFNrwQFNBXG2/gwd6lni01fAtPFwmjxOxTeky8hoz?=
 =?iso-8859-1?Q?SJbvvbhB+IMkUlH6Y2SBqHJ0NKQxMX2nNtEeXY9yy7kOB/RT0EHjtj6srF?=
 =?iso-8859-1?Q?5HPnKkybOl8i0oCfrdhqZbf+GLEg+bdybDfQtO9uNA9bU+60d0K3z1tT03?=
 =?iso-8859-1?Q?vAi7Y4iYqFBy81OXx1UWeD8apijqASS9pqBjNr3PCIvoB+tGFexK5Se8Rz?=
 =?iso-8859-1?Q?kG14HFSF4EGS/teTAHNEZanCHrcYVDxetdl2sXdIGoR3aQjr70Qe8xZ4Hj?=
 =?iso-8859-1?Q?LbPd2AVVEsSNMUxWxnSeXhoh4r4BYtMUjl?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d759ba-d9c9-40e8-4d9a-08daf896efd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 14:27:17.8394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ndPD8s87omLhyxVbP4SzjlpIT/Q67m2xP7fYbFwnB67s4UMQPQ1QKICq57VE9Krz/M5DQBrzLxonaUt//FtOFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6678
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split process_file and send_message into easier to use functions.
Making SMTP header information widely available.

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>
---
 git-send-email.perl | 49 ++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5861e99a6e..42f135a266 100755
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
+# Prepares the email, prompts the user, and sends it out
+# Returns 0 if an edit was done and the function should be called again, o=
r 1
+# on the email being successfully sent out.
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
