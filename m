Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 705521F404
	for <e@80x24.org>; Wed,  7 Mar 2018 17:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754702AbeCGRbA (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 12:31:00 -0500
Received: from mail-by2nam01on0135.outbound.protection.outlook.com ([104.47.34.135]:46532
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754516AbeCGRaz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 12:30:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yw5Cre1wefirxNri6ORzCepBwKORD3Rrurh/nB5Yu1o=;
 b=VhNkRAsmSQf6yn9Z39et4xS//9bRUptD53WE9M0AGypcEhBTy2OCvk2UYwUYzrtJvTdJKx9wib+zm0ClrNRWxunoEye0MINTVy7p5IWlyhsboGiIIJ9JkAH4YdU2FYw/+01k9adrcNcyp0gVzyJmGY9gguilWECl7NGU4iOLTyo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from neu8r3hm32.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Wed, 7
 Mar 2018 17:30:49 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v10 1/9] strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
Date:   Wed,  7 Mar 2018 18:30:18 +0100
Message-Id: <20180307173026.30058-2-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307173026.30058-1-lars.schneider@autodesk.com>
References: <20180307173026.30058-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO1PR15CA0083.namprd15.prod.outlook.com
 (2603:10b6:101:20::27) To MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2a56cf67-1752-4710-3081-08d584512d2c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:zIAUA8zMQsyLJdYMm6b05VynzrLrbt6b15gxGJu/6eqTyaOnms9c/6W4JNCSjgvZ9nrSKFDrie/sizrp4nsvWUp+LgJEExfTgJFJPbX1x1uAtYeUSk8qySu5IPNeI4pvxwC/YeSUBWJpW/0sZwJ3X+g19ZZ2Qru2IOjkUNzPRlZlobYGf552WXV22UqHeAeP8C7EP3hnVi8xcWrLeLgllaxMFJF/yOVkrQDvTvGxnD6Yi/lsFz3c2btAb8ycOPaQ;25:FomxD3UYoWoFZ9YC2WL08i8aKUAfgrlqsfaM4NqeelIEIGoAopTq1cT3zeUtW9Rhh3fhoJ6ZmC+cdQGjlW3ncA+lEr0yEZxRqHRh8dVtvJNQ/Tgza8J8bX4zZOkXD+2SMr0TZIdk4+8jpmpOHyHNK5iM55APiLDzuIFT3IdO98dPYc1QAfnq7PxSP/18gtexiBoUJ5JNmYodFSpmBAQ3xg2n+T9xoBvHOAbRa7suQmDywOBTBmRUydIav0rKZxSCJpAUZ62NMJIcG/3ZDuW8zF9oRyB1K/OkOWkFdouxEF0G+zvg93V9CzggS8hb3btGPrbDcXuDhuzz9g4c2CxW9Q==;31:atJdIFSowhMXLF/nhUIXiXx/AFOhywicblr0g7gOQsJiU6k23kB9QchKAO/2W8dyRDzgVgso+Dldtt/rPcyeLmlJNNMAz7S5bRNZ4o2Z/bSF3pk/DktUhfVvw/I+x1PB2yJk24ZPZtp45GMMWE4Sw9R8YYgrgzfKKWgBxFJGBzN8ALlzdLi6fLmuxQKfPwBSMPZ4waj08bBxKShyo6/6E29uT2u35V5/R9rZcj3YEJA=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:U/lQWVEVsd0JMgJljWra8M/0iH7c59ZDPEDlrwvlBOgbBO656pPLFKAbf6hs7rmXD33rB7XPrG42t1GZW5Hkf9+Fh3pn1s4mICgLv/uZLAHWIv1vkk3ml5C5/bPzZsji4dUPaHmL44+Q+QOrT/C79ktiAcFHtz+yfrfDfufWXNToaby2MrtTscAz9GElCeQZES+cmPnRC4lDLvwCyUJHyksPD1IknsNsYGHCPYPUl2bZYF06HGysyPKfzk0rql1w949FP86T4P2mKucFAPE1SAqJzxVll1NjUkLBI9CWk2tRfs42Px0eBWtj1P0OAX5aJfoxZqzrGKBk/O8MaW1YuqZCvy/+C44holItfxZ1W30cZFNIMVORXfP9q/B0S3bYF3yw329j8k0Qpyaxv4J2kFnP/eprPTf9xcT6mEXBM7cEY7vNhZhB/mRJFRA/xZwC4AloudN+Onk1liNuCXQe0pQaEP78sz8dzfm2UW6RYIQhkRQj/gJvSYy4/J9CzXYn1pq30YwfT5kkQmYCQo+mmXG5eW1nMY/YDcqdbVR4hcf78lTuVwxE4tP0Bqd68kv2QfSjSijaknXNzeyDMoIkyGieL0dyHD2VXLI102wR2mY=;4:bqKAtZBCjM9uhV9IL4SRRe1w3a6bm9kSJGSGZclTd9WTSsi1I0TmQhP1/o45iUAQ9W30t4ALQLTBfQWs68UsEzWErRlQz4nZt2dGu6pF1PBtDIp6XWZ8/JW4sICFIXriK4RHOIqYsRWPpyJ9QZOkKzDNVihyDO1NMvxq1QH2RmRTnBsm9IgfnjsGT9eLkA3LzB62GTYDM6EuY3KYt1uhuxhH5OoE2/oMU2bzwlrCrQSQKaHa3gxkoKDj43WMAYoBv75lUYGqiz8mx7UuddSEiHXFS7DThf19xNnnOZ9wz4R4Hdcuq0VyRBTslPeQkUN7
X-Microsoft-Antispam-PRVS: <MWHP136MB0014EBFE9152AFBE27D88C6EE8D80@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0604AFA86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(377424004)(199004)(189003)(68736007)(36756003)(53936002)(9686003)(16586007)(16526019)(186003)(59450400001)(6486002)(4326008)(26005)(316002)(8666007)(386003)(8656006)(39060400002)(76176011)(52116002)(7696005)(51416003)(97736004)(25786009)(50466002)(2361001)(2351001)(105586002)(85782001)(50226002)(86362001)(478600001)(6666003)(2950100002)(6916009)(2906002)(8676002)(7736002)(48376002)(106356001)(5660300001)(305945005)(81156014)(8936002)(81166006)(66066001)(47776003)(3846002)(6116002)(1076002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:neu8r3hm32.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:zQkwPWLJNswdq//uFe0ymlufye9315Fi8FRcr/y2X?=
 =?us-ascii?Q?j3T8IPNh2+fbw3H/wz6vgEXBCka4KwOa0+2KB9VZvqYNNJdBFzfYTgKtc7im?=
 =?us-ascii?Q?PBV5fyfnnEGMOfW57baCFWxP4RgEf8qUHxzQRT2QrGuPgTaHzhzptEkw7mlm?=
 =?us-ascii?Q?WnEB420nuDQ0dFlPqFgOmiX6Aq3Hlg6KXevk6ax1XQHW5g4CGn6XSMl8AHmw?=
 =?us-ascii?Q?HltDB0qm4aW5P83eaKdg4oiLqh2WHDSpCJ0Nbqs0XWAQBO9BIGFzFkgfwsO6?=
 =?us-ascii?Q?agbm0xqTidGwo1OBZO3/gy/dO5ILNaWqv6Iq6kTN5NxSBOOTMSz02QwcK74s?=
 =?us-ascii?Q?gfu1fT5Jf9eaSR8rJqBFXyXO+aEWjcU65Cp4mK1L5QLIfZJT2gyvhPrStW2H?=
 =?us-ascii?Q?wjtkCZD3HsAHi9hOsoRlAz0gF0i5XgxM01UeO0oesd6RyGTGpBgQz5R3kP+m?=
 =?us-ascii?Q?ncanTI1y5bPbarcLCHOo0wsoxIkMp15dj5efzklBGLwI39AQXQZGz730F1w+?=
 =?us-ascii?Q?rI31Hsm54Q9FgdxaKqTUlpJbk9rWrYcUBABkVhRkugqsa7ru0nqiFmYgQVt1?=
 =?us-ascii?Q?F16l8FL6zP8eFaxFliP61JvGHN6gTVxJ+6lWhkQZwGKvRHeqJA90TUmGTOms?=
 =?us-ascii?Q?ytJQt5n8FctrhO+mCae3Tt7HNZSPJCY8XHteIqgDLFXbAf1os2+QTYV9Ouig?=
 =?us-ascii?Q?t/EH4gnbhWwC23bXW5uAlsDc2udu8f1zZp59zBk5yz75+H5kcVb9ZZRP63Hn?=
 =?us-ascii?Q?GpebL2yt65cuoz4ayFFN1jue7vSffy2PWw8DVgoS1/0Vskm+HJ+3XuC+IELr?=
 =?us-ascii?Q?/5GtyC0gTtlPVwGcxNGzcPyg2Ih4o9wo/HUpPtZDV0VE2wAfcT7Hgmh/hSbP?=
 =?us-ascii?Q?LoEEZ4Y81AtdOpmDsOphmAl8V2dPqNS/4POF/ArfFVlnwsjKIAaw4fMb7cjq?=
 =?us-ascii?Q?gY0oWXB7B+riA/pMKQb+zsg+Gk3WyCUX57s0wvJRS0jDgS3WGtkfHK8Wu/L2?=
 =?us-ascii?Q?pw5CnMIlql/2PC/v09jxqRWrtag1FXBs3uKa1Om2UHJdSCfwR6c4NCx2rQRj?=
 =?us-ascii?Q?z4i07g0dUbeacly3Zopx+Z54M3xR3ZD2L+i/jbPaytlM8FIN5hP7IoF+15TE?=
 =?us-ascii?Q?FDN85Wg9GdAuQfStma6LUwOzsEhw3xvdlHremyD3h8tdfxXyyfha/1p6dB8T?=
 =?us-ascii?Q?HzYx8gQesoosXWaeLOnO0U0ABF/E10GRNrjB5QqFTIJLSwAH9NNbT2yeWKOj?=
 =?us-ascii?Q?dCqPBJYfyPQKCMzCPkRdRvLqUUNX7XHLY2G8P/NyMKvMHBPY7pclJtEa9Kpp?=
 =?us-ascii?Q?l1vjySKGDiWWSqK/EsSkC8=3D?=
X-Microsoft-Antispam-Message-Info: nbqfu/ta5YkeCxjBEtTkmlIxS1M8SUzvkXD+1voKsdsUROrIuKdO8Ucm/U9H88q17jZjChx4J6BXYHYZDfX/uhJ2Wl9+WbCqp9AriTY+0tjrPHvtu2sYdFuqDE/xqEhsHuzSSo0Id0vqqGrvkkU2ei0Slki4Hlb7DOAI/9aHIqVMWg9b+T8v0FolSWYEZCY7
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:PJSdKfUC+QowoErlEWgaRnkjrFDIJxolzVkeNVbQqv8cInrCsEqzRzTUDhdK9J3Xdu5DDi1l8THAJQpfBZ9NfIXSvllhjqEmNyIPC9nMyjNp9IvXUknxaDMZRtwX0mI64dbkTDrixSDmQS6YRJc358jmGlNagFoiil92HSYiatcfr0jC8Q9XyTvl7wz0VinJtyt901BhHxfEMqKuWZQkyGGWXOwT7p4gB2OwRKWaa11YL6evgDLkoc7vEtU8EfGcJoVJzl/JcISahCfCakRGwizxjG9TiffgkAYG+KsgINfLPNw4GNVx1m+W7vDT4RoWF/VdmZRIampw9PYgPCVlc84t/uPPNDAj8rHteWFaQYI=;5:iEjkQlhyPVafOWovpJr/l/lnwq1jDyD2CR5EGUF6N9bWjgLDaYCne1K+1npr3Fn6V8BIiYvM6w+rsvP24sIFatQybnIf6ujEn7KptHAUnEcFaHtJvuvMhKWQwKEWOvHGYYQt/j7FqK5tbW7LmVA+NtmZsZEKXNJuXGr3aYjR68k=;24:c5WbZ5g8kko+2CPKWHPP4L/0Cp0wTx4l2FVIJlF5dYuFPwv3Qvcw1H3rSgJutSp6K4WJoD2bKsSY8ODmbXiM/T6TN9vqrHA9j5J7LBrJDns=;7:IKfSPSd0Su+7tnQoSzpuLRjcg912vCP32JJmQKJvTUSrP0a+Veuh+F7IJTSMyZjL7hny6jlFl9h7S6inOZLdSW32pdi/pmikgDJsLM7DCQ7q6A3nFttmucz981ceP7mMION9ICSm8/GKblEInpIVgwirfTNnpYEd9SBvC6CSuhspYly4GQuvxa/TcyW0f6xUlyBUdqr9Cj/HVCoFOqOMPBVjFdXB/GKbIWlsMqVDE4RVvON23rW4OlR1hY9/FfPP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2018 17:30:49.7099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a56cf67-1752-4710-3081-08d584512d2c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0014
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Since 3733e69464 (use xmallocz to avoid size arithmetic, 2016-02-22) we
allocate the buffer for the lower case string with xmallocz(). This
already ensures a NUL at the end of the allocated buffer.

Remove the unnecessary assignment.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 strbuf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index 1df674e919..55b7daeb35 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -781,7 +781,6 @@ char *xstrdup_tolower(const char *string)
 	result = xmallocz(len);
 	for (i = 0; i < len; i++)
 		result[i] = tolower(string[i]);
-	result[i] = '\0';
 	return result;
 }
 
-- 
2.16.2

