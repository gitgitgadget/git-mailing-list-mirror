Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 685121F597
	for <e@80x24.org>; Fri, 20 Jul 2018 16:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388004AbeGTRWc (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 13:22:32 -0400
Received: from mail-sn1nam02on0124.outbound.protection.outlook.com ([104.47.36.124]:17920
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731583AbeGTRWc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 13:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jE7AjoflIC/EaXQU8XHeVEUjec/FC6uekJljn7d1AJw=;
 b=DYXIvDFLLokP+WzdNhEGkGKzmhzVXvYVMKX6UmKVk1Kwg345rcFpkTOpGk0yMb1dQx2gdiG7unZlw8H3IbBgnKkRpNqbglsFI/tyWC1K6tgTO5iql9CYGTmVl1hP9fxV1QZBchU76lGzU1OWhf/GrWPn4jSfsRMAVU41/g4YsBo=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0929.namprd21.prod.outlook.com (52.132.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.1; Fri, 20 Jul 2018 16:33:11 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0995.008; Fri, 20 Jul 2018
 16:33:11 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "sbeller@google.com" <sbeller@google.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 06/18] upload-pack: refactor ok_to_give_up()
Thread-Topic: [PATCH v2 06/18] upload-pack: refactor ok_to_give_up()
Thread-Index: AQHUIEdZkU4NDCEqKUuPwJpAG6gYcw==
Date:   Fri, 20 Jul 2018 16:33:11 +0000
Message-ID: <20180720163227.105950-7-dstolee@microsoft.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <20180720163227.105950-1-dstolee@microsoft.com>
In-Reply-To: <20180720163227.105950-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0084.namprd02.prod.outlook.com
 (2603:10b6:405:60::25) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0929;6:zAlXMnM0Jxr9BER/y0z6HyOfA5OppTrWYYMMxjkbQ4oikrHv6s8vyU+DjokCBwfU9IcxU6D/0o4R9M+liOZb2hLFNRUTX+5EOyNAhOjwBRCP5raimfXXfu1IT+wNnyfQrdDc4kYEw4sunLSWr7WFdzLPGCEPAghf6zP+X6MVq6bQXgHdcx7yhTrHq2JT2hLbmSVTbptHfBeV1BTMLScUq0Uqtv+ZmACE//UwTnnMGh8rohdlCHcW6sMXa9zVfPhs/D6Kw6L3W6XehWab99k+5kppStM/FQZ6TDcyRHS3tOUVuCPVoADOGG7F02TCTfviaLBzNUsnpvqjjjqV0sEnZAIjBNm6fB8QOGr1eFpvRCHFqjA+7hPoxvDI673QWFbAelPZL5fjiItbqHQB0ODqfauPsq3Vj1VjiVZK+6opbsMdP5PUa5lFAqya/luFa3BeHc+IpykXjRtRk+kXpOwQ+g==;5:HJ0C5TYf45HDWOtTO1R4a//ZJy3te6pYu31n4UrKm3UHdWHxvgRmFawa0CCeapGxspDt6n3C6CYMfNy/JRSJ+g523TZ1ObNM39J05UNJptT0ev9wCs4c0eCxkwZdyTr2xWwL7QLlxesWdEKEGx+XoPepalYbRdSvoB+J5hfnRL4=;7:Ve/1YvskUjEn3icMd5IvzHl5LI39djQDk69aSKnYlRK1hw+SIH93TL5/Ngo7sfu7yfEQDQgGw71bptnEFGkxdZiRvpnpWQ+QtFONy95nP2nBeqtn9lPkPTDzOAZH5rzdA/zwqzdkmmRIDgu51TtXGH/tSXmh+uxkqifNqsk16m86sPX1jEu/g6i3yNWn1bouM5pKLYb8ory+WwzwF/djwLhi/MA5rfMdVCWgjWHpZreIYDNhXrfN7HHRpzCn2fho
x-ms-office365-filtering-correlation-id: 8820cd58-8bd2-474d-ee61-08d5ee5e7b5c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB0929;
x-ms-traffictypediagnostic: BL0PR2101MB0929:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09294F93CF423357ADB94B71A1510@BL0PR2101MB0929.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0929;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0929;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(396003)(376002)(39860400002)(189003)(199004)(6512007)(305945005)(7736002)(14454004)(5640700003)(6116002)(6436002)(105586002)(54906003)(53936002)(25786009)(52116002)(76176011)(106356001)(2501003)(446003)(46003)(478600001)(68736007)(11346002)(6506007)(2900100001)(2906002)(5250100002)(386003)(186003)(102836004)(2351001)(10090500001)(97736004)(6916009)(8676002)(107886003)(8936002)(1730700003)(81156014)(6486002)(4326008)(486006)(81166006)(10290500003)(39060400002)(5660300001)(86362001)(22452003)(1076002)(14444005)(316002)(2616005)(36756003)(256004)(476003)(86612001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0929;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4RbfLm0U6TuoVjG2gwI7MWxxf6QLpnSvtRZ3oHgZBGV2evD2tCMt4B6wiWwjqLryIFv5Q9r75r5dgeDyvUYRVR5NcTWlampOqiSijzjw9bXaR7g0k+KYxWVNjENvOL/qtZ3k7r3UqUlA8veXY/ZA1f1ByXiJAJEwf2t0iaB3AMOf1MUxKTdcg0++Qq0wJMcg6zS5EksIvWDRNWM6cxoM1hFE+agWdiGoJktfzmlLWp8w7buhhtVGPZrFHnvzThnoSHZBzRxjMmsvw7SUJ45ZVn72nSbilDifMKtYh1xop5bTSh6aTLuHjBGyto1g1lUumaM0KFBV3868cug4W/l7Il2HbsFjz2XWtmisu2+IAHY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8820cd58-8bd2-474d-ee61-08d5ee5e7b5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 16:33:11.1991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0929
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In anticipation of consolidating all commit reachability algorithms,
refactor ok_to_give_up() in order to allow splitting its logic into
an external method.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 upload-pack.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 5a639cb47b..9fe19003c6 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -369,34 +369,46 @@ static int reachable(struct commit *from, unsigned in=
t with_flag,
 	return (from->object.flags & assign_flag);
 }
=20
-static int ok_to_give_up(void)
+/*
+ * Determine if every commit in 'from' can reach at least one commit
+ * that is marked with 'with_flag'. As we traverse, use 'assign_flag'
+ * as a marker for commits that are already visited.
+ */
+static int can_all_from_reach_with_flag(struct object_array *from,
+					unsigned int with_flag,
+					unsigned int assign_flag)
 {
 	int i;
=20
-	if (!have_obj.nr)
-		return 0;
-
-	for (i =3D 0; i < want_obj.nr; i++) {
-		struct object *want =3D want_obj.objects[i].item;
+	for (i =3D 0; i < from->nr; i++) {
+		struct object *from_one =3D from->objects[i].item;
=20
-		if (want->flags & COMMON_KNOWN)
+		if (from_one->flags & assign_flag)
 			continue;
-		want =3D deref_tag(the_repository, want, "a want line", 0);
-		if (!want || want->type !=3D OBJ_COMMIT) {
+		from_one =3D deref_tag(the_repository, from_one, "a from object", 0);
+		if (!from_one || from_one->type !=3D OBJ_COMMIT) {
 			/* no way to tell if this is reachable by
 			 * looking at the ancestry chain alone, so
 			 * leave a note to ourselves not to worry about
 			 * this object anymore.
 			 */
-			want_obj.objects[i].item->flags |=3D COMMON_KNOWN;
+			from->objects[i].item->flags |=3D assign_flag;
 			continue;
 		}
-		if (!reachable((struct commit *)want, THEY_HAVE, COMMON_KNOWN))
+		if (!reachable((struct commit *)from_one, with_flag, assign_flag))
 			return 0;
 	}
 	return 1;
 }
=20
+static int ok_to_give_up(void)
+{
+	if (!have_obj.nr)
+		return 0;
+
+	return can_all_from_reach_with_flag(&want_obj, THEY_HAVE, COMMON_KNOWN);
+}
+
 static int get_common_commits(void)
 {
 	struct object_id oid;
--=20
2.18.0.118.gd4f65b8d14

