Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF87B1F404
	for <e@80x24.org>; Fri,  9 Mar 2018 17:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932457AbeCIRg4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 12:36:56 -0500
Received: from mail-bn3nam01on0113.outbound.protection.outlook.com ([104.47.33.113]:10015
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932252AbeCIRgw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 12:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yw5Cre1wefirxNri6ORzCepBwKORD3Rrurh/nB5Yu1o=;
 b=iufv1xskWlJG+13dW16nRX9tO2vWkWUltwXtZlKsofJHGLvElh5qPgjWhCBXayai7iyr82/MRDSgxHYbqRO4zSi03ZiRfKucVEXvgDovfrjDM8dUTOreoSsP7Eg9F+aLlws5+Kva5EjS/OBk1OSiUU7zTBeC6d6BV0CZJifJ080=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from remr90mpm73.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Fri, 9
 Mar 2018 17:35:49 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v11 01/10] strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
Date:   Fri,  9 Mar 2018 18:35:27 +0100
Message-Id: <20180309173536.62012-2-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309173536.62012-1-lars.schneider@autodesk.com>
References: <20180309173536.62012-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO2PR04CA0119.namprd04.prod.outlook.com
 (2603:10b6:104:7::21) To MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bc0a9f80-4222-4ee6-8284-08d585e43490
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0015;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;3:I6ZuCCIREohydN54kJ2kDtt24IYWdwJKS7GdYtVzLl0rGvy1/j+Cexvw1V/r79O2AkwLo6gfKBoUPHSCsZsY+rg97DzlQAXhVA+Oeznl91D4nJFS0ieRYNv25EDjiOl2BiHB9xyc5E3aiipQSSrN2tbzvcxvb75SibA2nMricS9bWRxwHhTZlZEEZe7d3GS5icSSt/PfFVh7oQhZ6IdcDtirxD3u6qNbfg+31diirphU3lvdvKMHt34W7LoDQFqq;25:rpVCZOe0vJEZcjQ+1JlNU2yJQL5+cRY5OZDGggrPbDIg67DlJnQ4XrX8APKJhueMZgzmScituU5djDFNEMOUDgWjnvNsjOilmWZaqevvCwQi6xeUnqmUOGcYtDR0/RIXs/J5gfzN1uhhySOTVZ6oE2oDY0XcU8DfjxxRfC2Ddo0fZJ3Qd8CIyHuJFher9aO6aVXI1B7MabdHrxmDjCx4ME46MNeRTSsv9L8H3O+FFbU5xbaQyxGZ0907czSTwdGMIvg3eOIaIAHldmjy3T5JyHDEebiIoUlQ1KAUM1pFyZpp5ECmR2GeTq+Gar5+Juk2NbsUB/tYNKF2vYM4fpJWQA==;31:zYXAug80JOl+cXR6aS30nmLpxsv8XxVXYiuKL7/m1ScJQun70UN5hHNRFzR0gNe2kuDfQtAQq2Ds5Nuq4gR1zx3VtJFEnfQL0UNovCqHrK5+Ak78xc1DZ43z3rHGHmXz80iVlLz2E3GS1mzJy/1PkH7eIrU0JFJDRyW6JL4uMukQaY/iFYO+iJNtuZ7WjsC0Ye94KZ76i65KpFPfwhvCeVWVertWU3y3fEFM/rKy4SQ=
X-MS-TrafficTypeDiagnostic: MWHP136MB0015:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;20:TKXOBtCbn5JFLrdxu16wisatE0/ipyfbg/XaQkd06mvI8m5ZwvYDCJKhmebejcL8FmQgyegwH8che90aW/rtr3jYdqn5IUQa0kTx9QsMGPOU0Sg2trL2UHnzBo6JicoanR5OFaND2joZGD9oaP44ELB0RpjmI/26fZyoyBWb1r2FPHAeyhVy6G5MAGCoRS14a0os0aE4loPBG1IboUJdGUI8fnt1RpEuKf9vIbVwd1g7+7jlUSA8yNQs+agFmpAU1N4Dt8lSEGHtiWLApbFM9e91BRtbWjd1KkzLynpGy6a8Ta6WnAtGu9HHYbBtiSi7JR+H/swNjZD4bDQR+5l0vmW4EV+lyEX2NUqRPUVvxIlbtMG5qzakdbHF6dlolSIWzBLIs2oCcwfcCU/5vdCGS2bJv36ETxiirw96FuvgK4AgWc6ZHggTENTv+7MYze3xOhebcDS59DMiwiTy44DkVmuMxIJBDNrBHNQKddwf23fz9fmPtIB/2H2lfSRo31kHmFst2U4BZ6RDQfSE5wrZQvOAoeKQXPul26psznSVt4aGk+u4oXLr6Y1aLGscrJQyLVLNQWz4n6RBnrDH7akPaXHjFy06WLpR6nFY331EOWQ=;4:RfOxd099oOT4648vV2NzN3cvt0NCIahRNuV68tnsqfz3pu7HQoUGV6Rwf34RaDAeHyvvyLt6nTN/Mc8TLGSt1sAa5GCL/Sg0VUhQxrCX3jmpZO/qhcukXcx2UZ6n0GdXybvX/XLGue/7u4tpildizkOXOYHN/ndAHIWh//s32U2Ht6ErJ2DWNjMNzadi2DBEBzt9FIXutu7T2gtX8m/aVuIqdo0vmISaxp2pKznlBOxWyxoi8SRZ+zHRPWdvO7pqJohro8IuVYeEESOp+OFHzwB2tRqWojM8haLH3kcWO4h73Kk/V1fkCKzIfiPfaeqR
X-Microsoft-Antispam-PRVS: <MWHP136MB00157843E196C0D5B02FCF9BE8DE0@MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHP136MB0015;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0015;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(366004)(39380400002)(346002)(189003)(199004)(377424004)(50226002)(76176011)(8656006)(7416002)(25786009)(106356001)(51416003)(8676002)(2351001)(6486002)(2361001)(386003)(105586002)(68736007)(8936002)(5660300001)(39060400002)(7696005)(52116002)(59450400001)(4326008)(50466002)(2906002)(48376002)(81156014)(81166006)(16586007)(6116002)(86362001)(26005)(3846002)(85782001)(316002)(9686003)(186003)(97736004)(16526019)(8666007)(1076002)(53936002)(2950100002)(36756003)(6666003)(305945005)(47776003)(6916009)(478600001)(7736002)(66066001)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0015;H:remr90mpm73.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0015;23:w2uUhGV/NZFwNJ3qSDrsYBWSrcgWEFot0/Gp1sFZ1?=
 =?us-ascii?Q?dfOM3mP762fh839x0T1fCj8KsAc0YrV4NM/CcDWM3ogR2cJE9fGtKSgifWb9?=
 =?us-ascii?Q?VrcxNAL3T5e8fTJn3ZslSvFgeRhkfy6oclQ8OSCO3JMkFeFH8ebl8ZuO0DpS?=
 =?us-ascii?Q?Xqy+2/q2DuPgjoCGE1T1AoUS/ipzkaxYVnCAehm8rlW+e4L+SAwZ1D65s4/V?=
 =?us-ascii?Q?eGznHDEMnOh3+YXGTw96FZnFsOOFRq/0rn7QQbq8U6JDs6Jy4SKyHYrg55h8?=
 =?us-ascii?Q?Q/TMSb4avPucXjT1pEt/XECxOowwPn5ieltiATYi3Ki2IHl9IV9p50ikylAA?=
 =?us-ascii?Q?/H1xOtNVIU36+5DBpEz9d/VT5SDm32gRfu+4Jhfq4kVTmnz9EjDe7U0NPCr9?=
 =?us-ascii?Q?p8zRyYh6YriU8Akls8Q/4NQKaIv3Tx47nb2akzKW/fdRdXkRg7s/A2rYNZYb?=
 =?us-ascii?Q?vWxQAy2SKUUtfk/MRjNQGdxQte0o6e1YilrwBuLcFQ2wZm/SXilBqXlDOJRh?=
 =?us-ascii?Q?Gj+umwejaaBgAlh838fPjLtuD7uSwM/P2DGUysMUTjK9GEep1QqUPybPguqu?=
 =?us-ascii?Q?WuuFqzV4A7Wd65rtdm2WGV4f6BSA2alUo5nJ9z5pwCm++pG5JIic60EWCeAW?=
 =?us-ascii?Q?HQrumUz8CjQkoxOo3f1pOMrRWLpu00QZxp7PVBEi/dIr9x8Di5YIH+CDQKLg?=
 =?us-ascii?Q?Jbpwb3a4p/UAZgktV+fUpuVxmNtuqXaCLYUN8dZ/ZkHpuO0LZ3Jf4EGiEe55?=
 =?us-ascii?Q?jvMpqyOOUQTA1nTG/mifFUjDpPQFXH/BKo7i82I/DUQ2YhUesEnO4ObkF9Gc?=
 =?us-ascii?Q?XttUqi9rQaIHeZrJ0F0nNDjz9ocbeUEosA/+ZeNUcKDsX4TwFsvz8wFKRjIm?=
 =?us-ascii?Q?9aRHlURurZ8vONc6+ZfGt7XYzO3eBCHhroa5yczfRynC4zhuvDgTnIBKippr?=
 =?us-ascii?Q?WCeyMCy1U40dnO3hxsE6isua4cWCaX/Lsl6f/7Yd1oe2raEBWSzax0IR0fUg?=
 =?us-ascii?Q?s9UqjP9zOyMXWpIgiB1aMXQ20We0G3k6NEVQJDxt+rT10VA1UkgcfzQ1Q2DM?=
 =?us-ascii?Q?9v4titovP3XtL3UooZEPtej/QavO+5Xzq4kjkHPGGEPOI0ntpDsBIhh9+l8S?=
 =?us-ascii?Q?Ln/SFL2A1SvIDMQOW6bnpuQ7aLH/tntr1GBl1YKoj++i5tqz5M18rWE0YIH/?=
 =?us-ascii?Q?Jyb4Gypeq4dgjLVZr+wP2Uo086TjheW07r7hZTTeUcI3ks/DSrQyce/XtnOz?=
 =?us-ascii?Q?1NDFNydeqO+bfd2TMmq9gjlr8b1F8AKtywQQlN+l3QqLMsjdAuy0lofO2l93?=
 =?us-ascii?Q?Q+ddCwvR0nIZJosHDws6LTy7BBYrpNGRYVicy26TjHb?=
X-Microsoft-Antispam-Message-Info: xxKGblZUZXy034jCRvL293gYBgoVng1f4yqIa1j4X6xgm4X/+yeAB1q7eaIL5i4FdkvQICM9zATCIPEIfXOXEwojZTA9Q6TnI+y4EKU18XMF9dYJ6hJ+1wqaT2htbWmh+GJJcew5jtz+NwnaDFCl6435BL/UuP3Nf+kIVakRf0HbJUQg+NUVseDaDXxYZUE1
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;6:djPL+uOxrzyJkOc0gaaUrrClUdMN/UK90Xi5kHkaSH0TUXyPM+/lL1cmjFuVTYktTeToTAE+lbgFVaVkDfbzs8S/u7FfEhFeoR+2gV7ar5dNpLy9mUMszm0jzefdPhxlRZnDU3PYAYBDI3VUt3nQaADHra8RnK//DRxdKt2Nwl01H/XVNxkV3VVtNSK4c410GqJzxWb55W+wh7xxoP5FRYOOw1DtAvVGwNN2NbT5mSEH8tWMQBiwnJyC75/fskcDWvXXqL6R280wo3wiipPboPMtqBLbo7Xo1yKciV/fqo2RTn+0xxr2NmA9/BF/ssJQzW4OKsvwHkrW7o9yk8cGJoxKvllkIKPeZQjLroOUv1A=;5:GZF2agH+QNJ4jfSkrtzyLuN5sNoDCczYw69M+wofFotB4xarIJ4trKqaLFd0/MHSgW2dMl35eI0FqDo4w9MjZ9iT9aORUG/pDM71+/8REU3aFVxi2fcIm+JLlf2NnawHrFUzDYKTTIIGHi5B3j+WV1uCfzpgPTpBNX939qNmYGU=;24:PGsfD3eI4JyrV16Eja4Aog4iL4jMPgW47ZV5t3okR2bUKU4ly/iOSRyHY2sBnu1B8QTHguehU6tYizx77Z0IrxrWRrDvFmJWlHMDrtG0q0U=;7:IjUZKwQWuhK8vezrj9Yzpw32jdBRa4/jfMIM1sVeXKsN59OR2a19uQByvjUeNoRIiktkOjw2rQ4PdSLcL17qiBGRjdB0OWJW6ui4PgPJvBfo8e31soD3CN/gK7sRU2s49Q0kxwm52tma/ue5LwQR7NrnIX9k3igOUTr7OfbVwzIhiaa9h0xrvKm00Kp5GCGzY1UcCgR72JaQea1uTcIAAi6WEu3GZQ4CQXMMfNj+w5UR9viCix35AHxLmrGakdB4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 17:35:49.8247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0a9f80-4222-4ee6-8284-08d585e43490
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0015
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

