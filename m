Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F3EA1F462
	for <e@80x24.org>; Tue, 30 Jul 2019 17:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbfG3Rh0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 13:37:26 -0400
Received: from mail-eopbgr780084.outbound.protection.outlook.com ([40.107.78.84]:24088
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbfG3Rh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 13:37:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZ+Gs0Z1PWYbSBNTGYn21/50W166kfGt/0NRepA7lQCofgXfvt7l+d7AiQvT83Cqo1do7fcSS3b3lEWGKoaRCLCnoanInnvDBi4UIwwknIU9/Z4OrvfrSJHm+75IR41RNJr6M8mL4a9BTwbE8DxtdaMOxLxvcV2dguqBzv3Y3Sz/dAh4TeQueImHVQeJIdn1oeiVNKJ6RX224kjtB8Ofk6PjWWQRDv3ZAQihhW+xIgOmHHyro+8mRyxnNGT1A9+KQwCSUe10ZKq2s8c12TSLECezyyEvWFW/x/KdxNPH2derD9FdJaa2GDRAw9D19QqFug57lyE/5VWRLp93MTMuTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTjn2AgxqMHKl151FUhdSRdtYvpY2H2XLYPc40KVXZI=;
 b=l7+cp+PlYvgibb3xkWiWNCSShgEss0pQAwbb7m1NS58b6PrsSm2Rp+nF7St2CPafIZrmLbBJJcTGcEq5B9CMdP0y0HoWdTF2wOiFrscRwJdYgcLCXIc0Gu3JuZTfee2jcKsuYicj3cdMhqe9qYRKH4sgntj0oeUj4+lgwdFmFZxvq5DXEF43K5HzEaA0Kw6syGdTrw2OJEKT6ju5FJpjSfK0OpEQ7KPXo6YM67baSzaOg2KNaAvYEUBN0EqIu3n9D7lh3UOqYrVc3Vx6OTs0vyTgZRYYD9t9OemkIZzdHuAcT3gTLpbILe9ucYBJMtN9pgzUsec3lq1t6pHMm9ORUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bentley.com;dmarc=pass action=none
 header.from=bentley.com;dkim=pass header.d=bentley.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bentley.onmicrosoft.com; s=selector2-bentley-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTjn2AgxqMHKl151FUhdSRdtYvpY2H2XLYPc40KVXZI=;
 b=L07/tsDgsOW3ooGS7Pkc2k9nsFBxMa1dCEoFodb6Q+fSaaJ9OKBXezugDsDPJN5qY9RjnRpV2wlPZjV37QdmE273k38SPyQchDXEb5gN1E7yd4Ga5PuLOKqf7T9c9FFKL9j04EFvRhreGUosGdLqDfMB2Ajegwxtq5+j+BVSeSg=
Received: from BL0PR1901MB2097.namprd19.prod.outlook.com (52.132.22.19) by
 BL0PR1901MB2180.namprd19.prod.outlook.com (52.132.23.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Tue, 30 Jul 2019 17:37:22 +0000
Received: from BL0PR1901MB2097.namprd19.prod.outlook.com
 ([fe80::2d4f:f059:cf4f:8f7b]) by BL0PR1901MB2097.namprd19.prod.outlook.com
 ([fe80::2d4f:f059:cf4f:8f7b%4]) with mapi id 15.20.2094.017; Tue, 30 Jul 2019
 17:37:22 +0000
From:   Philip McGraw <Philip.McGraw@bentley.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH] git-p4: close temporary file before removing
Thread-Topic: [PATCH] git-p4: close temporary file before removing
Thread-Index: AdVG9CjdiOqwVlefRbaG5Wv1p1dyog==
Date:   Tue, 30 Jul 2019 17:37:22 +0000
Message-ID: <BL0PR1901MB209738ADDF9D931253E8C317FFDC0@BL0PR1901MB2097.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Philip.McGraw@bentley.com; 
x-originating-ip: [64.90.224.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbb8122c-861c-4238-b5e6-08d715149444
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BL0PR1901MB2180;
x-ms-traffictypediagnostic: BL0PR1901MB2180:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BL0PR1901MB2180591B22580E2681EE30C9FFDC0@BL0PR1901MB2180.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(199004)(189003)(5640700003)(66946007)(52536014)(66066001)(26005)(7736002)(53936002)(5660300002)(102836004)(6506007)(74316002)(305945005)(7696005)(66446008)(64756008)(66556008)(76116006)(316002)(476003)(486006)(186003)(14444005)(33656002)(66476007)(6116002)(3846002)(71200400001)(2351001)(8676002)(256004)(81166006)(81156014)(55016002)(6306002)(68736007)(99286004)(6916009)(6436002)(1730700003)(9686003)(8936002)(2501003)(478600001)(25786009)(14454004)(86362001)(71190400001)(2906002)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR1901MB2180;H:BL0PR1901MB2097.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: bentley.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EvAtZ+t/y8qxIZgTh/iRv3wYXYWdQk/8Mnd1MZ5/CuZpT9S5OWph/PCdpzkiKHHu7TEjQO9h7q23ObOhHfwISpd0Ob58+j/1cHQpPSgw2sz/HyYEocVjkpsXwpDr0XuIqdFhuMQIudqUJ+bhG5gBjMEw9PR8/5mmEwG4/EubCA19Z3v/JMI1MyHa3KdjrQX3AVPdwRYN/CPDWvhGt+4iFHjZdoCNzHK4Dp6I3vZKJQ0sqwd5ayCyXJd4Yf3n+HdJ7PRQRHwNv7rlp0/UvgX7nY83bWZbBxES/ArbKHavn3Qo9IFAormS1bo2boyIlstFdPHPsvA4BplvYH0fTveaEdbyoaunA+WsI0qwSHBEvtQcPImFA7mUTOO1oFtdFxnaP9mgvywbAJShaoyRySuulcXIEmLteWAe72KDWNoQ00w=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bentley.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb8122c-861c-4238-b5e6-08d715149444
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 17:37:22.6105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 067e9632-ea4c-4ed9-9e6d-e294956e284b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Philip.McGraw@bentley.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1901MB2180
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

python os.remove() throws exceptions on Windows platform when attempting
to remove file while it is still open.  Need to grab filename while file op=
en,
close file handle, then remove by name.  Apparently other platforms are mor=
e
permissive of removing files while busy.
reference: https://docs.python.org/3/library/os.html#os.remove
---
 git-p4.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index c71a6832e2..6b9d2a8317 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1161,12 +1161,14 @@ def exceedsLargeFileThreshold(self, relPath, conten=
ts):
                 return False
             contentTempFile =3D self.generateTempFile(contents)
             compressedContentFile =3D tempfile.NamedTemporaryFile(prefix=
=3D'git-p4-large-file', delete=3DFalse)
+            compressedContentFileName =3D compressedContentFile.name
             zf =3D zipfile.ZipFile(compressedContentFile.name, mode=3D'w')
             zf.write(contentTempFile, compress_type=3Dzipfile.ZIP_DEFLATED=
)
             zf.close()
             compressedContentsSize =3D zf.infolist()[0].compress_size
             os.remove(contentTempFile)
-            os.remove(compressedContentFile.name)
+            compressedContentFile.close()
+            os.remove(compressedContentFileName)
             if compressedContentsSize > gitConfigInt('git-p4.largeFileComp=
ressedThreshold'):
                 return True
         return False
--
2.21.0.windows.1
