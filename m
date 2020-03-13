Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E7BC10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 12:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1268B20746
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 12:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=InnovaAS.onmicrosoft.com header.i=@InnovaAS.onmicrosoft.com header.b="dyAwWcKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgCMMN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:13:57 -0400
Received: from mail-eopbgr130087.outbound.protection.outlook.com ([40.107.13.87]:6219
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726605AbgCMMN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 08:13:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6HlDgeQc2oG2d7Uh6dUQdyPyIO9wWPNQgqRUbjuVqX+GxhgSvywXVyqkRG3SG/LsIId9vqZBSJFxtlIlV9fhD87nx7hYhSFuj7vroCwUfSzv9zYuVXDdBRr8Yx7PBlUrPPLQne8SToQI9y/rA3a2H67rKggwfP2D8M9bWiFvucm14puib8r7QNvnW/07X89VqoeNVYonD4gDSe3In2ItNy/x3z9b7rx3mFLs1+kUbQ7oCZBzPiuJh0XrwONHkvhsSGm/wuEilZNiQRJXPzS7EFmMsXJ5CCl0cmbQkM67AYLGDLlHxFbDBFo0sK+3nvTIfFxKKLISHOzm29eGfEm9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuTGVvZU/GVDWIRfvlzmJKGzB3GMsf3pc9xcy4UCR1M=;
 b=O/VLEjPVh73adcRmsf9rrkv+6JihrJ0lqPhpkdlrfWv/i73shbqEYdf1i/u5aVSE2Fil6i5fNsO+7+8ZAmwVnHjgLYqHtPMcLagzz12zEU3WJMT6SbrZjtGadBJ3BsTw5d/9ZrUca9wBn2XyJ/S11DxiDGkDKr00kpJx6HG/Pt/pqbEtGj6hs1i0U6/GKmTLxxE2zsbzhMKJ2l8HaFCLPiCK6+IRzSRgMCT9xpr5cVDbgNJGttqVBwUfZ8FCYJM5K8q0dqrhbbzgFqE8t65I9Qn1rGdYB9GVgrXoymJNNYJ/wApmiN2g/7arJYkHUN/lGfDrptUNyWymX8JRXTzotA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=innova.no; dmarc=pass action=none header.from=innova.no;
 dkim=pass header.d=innova.no; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=InnovaAS.onmicrosoft.com; s=selector2-InnovaAS-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuTGVvZU/GVDWIRfvlzmJKGzB3GMsf3pc9xcy4UCR1M=;
 b=dyAwWcKOjknQeJxWjUXnjnD2G8+T+uLtnOaU0/6yVwUxD/3vPQhhcPIauWvoQV1jwyMzOzvtwCJ2oh2/DgbRT6bwUE8ULUQ+nWja3muo8/BFhoeBBX+/hjSF9D4mI/d5C7hf1cmzIdcp6wQRAfc5fZ0NkKeqN6MPjlI5caIG5wA=
Received: from AM5PR10MB1556.EURPRD10.PROD.OUTLOOK.COM (10.161.92.147) by
 AM5PR10MB1636.EURPRD10.PROD.OUTLOOK.COM (10.161.64.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15; Fri, 13 Mar 2020 12:13:52 +0000
Received: from AM5PR10MB1556.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cd87:bf66:b0fc:5e0c]) by AM5PR10MB1556.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cd87:bf66:b0fc:5e0c%7]) with mapi id 15.20.2814.018; Fri, 13 Mar 2020
 12:13:52 +0000
From:   Erlend Aasland <Erlend-A@innova.no>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [RFC PATCH] Make rev-parse -q and --is-* quiet
Thread-Topic: [RFC PATCH] Make rev-parse -q and --is-* quiet
Thread-Index: AQHV+TDc3v/m1QgNGEWfZA7DBJTSnA==
Date:   Fri, 13 Mar 2020 12:13:52 +0000
Message-ID: <4B2A0C64-FD4A-457C-A7CF-5B680AF38BC9@innova.no>
Accept-Language: nn-NO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.60.0.2.5)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Erlend-A@innova.no; 
x-originating-ip: [92.220.124.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 285b73ec-94c3-4920-61f0-08d7c747feaa
x-ms-traffictypediagnostic: AM5PR10MB1636:
x-microsoft-antispam-prvs: <AM5PR10MB163633FC4285DBEC51AA48D09CFA0@AM5PR10MB1636.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:586;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(39840400004)(396003)(376002)(199004)(6486002)(316002)(6506007)(186003)(2906002)(66946007)(66446008)(64756008)(66476007)(66556008)(5660300002)(2616005)(71200400001)(86362001)(91956017)(76116006)(36756003)(6916009)(508600001)(6512007)(8676002)(8936002)(81166006)(81156014)(33656002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR10MB1636;H:AM5PR10MB1556.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: innova.no does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AaWmaXNfHS2uGOM0s7vV7NCxeJTQKh4Fdn5/26EG762A8OLCWhAZh4i+OBht7VOgzJgdXj9SJvptWkWPc5FIC2XuekyUTJs492QGPTZPhxLg2DFbl1K30yGC7fyrcSmkzojNl7dmRdedYfth91EtnKtGJIIzzomf6WgnUAJUW6Z3cV5qQVWSiFdJiucT9OA0mROaMjv651qI/4lwwLD693K9o92JFRHZu/AXzEJOjO1XWNUxGtEfUs9cqt7AtiUY51wIXcjvS4doZQETdM3q1MFla2HciKbJjhbvAMHihgjqH/lEf4DB05z7JdFzyDViS8ojxwAlazqPThA0aowpNifF5qqVa0gDU8+fSCO9r/qS1xmzzIvj/ReaTyIfOeCpEhN5O+Pz2kVHQ78J9CJUVFX0gqEN4KodhKO8I24gL7UWp4jBKDTbq3iRDH2s62RS
x-ms-exchange-antispam-messagedata: ZyrESdbNLFxJ51JirlciTF0CPYIlSOQzdL2X1zlVmyCSEUgi7vhDOxa9ohaYBW69qfxZKqOPUEd/5prS55T2T7EMonC40kkYryt4QupCZk2vOva+y+3TYcJ3X1S4Gg7G9vb7K/gLZUCDw5oXGh+1Lw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F7571E328605FD4686B451283C8AC759@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: innova.no
X-MS-Exchange-CrossTenant-Network-Message-Id: 285b73ec-94c3-4920-61f0-08d7c747feaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 12:13:52.4749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0b7619df-4c48-4446-b5bc-62bc2f3cd746
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZCNN8dvsjeDuCCVEVK3Qh/JbemPHezEuzPy59FNYiHiXCT84/3JJJYG03DNmexRqBR9oK7x75sizHkTq2gxdGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR10MB1636
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If rev-parse is called with both -q and an --is-* option, the result is
provided as the return code of the command, iso. printed to stdout.

This simplifies using these queries in shell scripts:
git rev-parse --is-bare-repository && do_stuff
git rev-parse --is-shallow-repository && do_stuff

Signed-off-by: Erlend E. Aasland <erlend.aasland@innova.no>
---
builtin/rev-parse.c | 25 ++++++++++++++++---------
1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 7a00da8203..5a8b404ec7 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -874,24 +874,31 @@ int cmd_rev_parse(int argc, const char **argv, const =
char *prefix)
				continue;
			}
			if (!strcmp(arg, "--is-inside-git-dir")) {
-				printf("%s\n", is_inside_git_dir() ? "true"
-						: "false");
+				int is_set =3D is_inside_git_dir();
+				if (quiet)
+					return is_set ? 0 : 1;
+				printf("%s\n", is_set ? "true" : "false");
				continue;
			}
			if (!strcmp(arg, "--is-inside-work-tree")) {
-				printf("%s\n", is_inside_work_tree() ? "true"
-						: "false");
+				int is_set =3D is_inside_work_tree();
+				if (quiet)
+					return is_set ? 0 : 1;
+				printf("%s\n", is_set ? "true" : "false");
				continue;
			}
			if (!strcmp(arg, "--is-bare-repository")) {
-				printf("%s\n", is_bare_repository() ? "true"
-						: "false");
+				int is_set =3D is_bare_repository();
+				if (quiet)
+					return is_set ? 0 : 1;
+				printf("%s\n", is_set ? "true" : "false");
				continue;
			}
			if (!strcmp(arg, "--is-shallow-repository")) {
-				printf("%s\n",
-						is_repository_shallow(the_repository) ? "true"
-						: "false");
+				int is_set =3D is_repository_shallow(the_repository);
+				if (quiet)
+					return is_set ? 0 : 1;
+				printf("%s\n", is_set ? "true" : "false");
				continue;
			}
			if (!strcmp(arg, "--shared-index-path")) {
--=20
2.25.1

