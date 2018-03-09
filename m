Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA0D81F404
	for <e@80x24.org>; Fri,  9 Mar 2018 17:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932475AbeCIRg7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 12:36:59 -0500
Received: from mail-bn3nam01on0118.outbound.protection.outlook.com ([104.47.33.118]:2112
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751495AbeCIRgy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 12:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0FhNnc8vDSDGItH1ynWJkeHjAoBB3b49PCehSQPXGUw=;
 b=iJEKedey86UE18TItGJazwrz9Hojs7qzDaM/6H3Z7nIIMtE2Dp18g0UjkLX3eAkBRyEUYMox1d3sH395SS9hrw9YPpZkmeRplB1D9HLI9VQBhA5Q9E6UN3vT++NO+CtLUZrLbUu7N6WA2i0lTJHLegd5QK9Ix/pBOvldqQfTQHg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from remr90mpm73.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Fri, 9
 Mar 2018 17:35:53 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v11 02/10] strbuf: add xstrdup_toupper()
Date:   Fri,  9 Mar 2018 18:35:28 +0100
Message-Id: <20180309173536.62012-3-lars.schneider@autodesk.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1a27cba3-fc9f-4716-315e-08d585e43685
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0015;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;3:xKp2WSR0rAX00ngI78pN+btj4XLnY07MjM9/rSAN27NU+eb0/3gUxXjHLQcjaA3aAvu4/Dc5+TXHLKIVeYc8Zjv0JriayG/w346/QbCpI0RzLChaOiMWSM3Ff8Q9092uSewGW7md4CHMfG1ZBxcrpXHsmf+5MjDdDnv+ty5eb4vHZkiPbCfXLqcgHA6ilkYCr8Usgt1tA/g3Be8AQJhb0UJTeJIvJQee/ByK2qoTXe7dw0+MoL/++P6aZYvl99Yi;25:iMbZpq2owDdXxdXzBBGLSggB1lRfUG30cTs+hZi+2JIzxCUCo6nWppm4wmowBHJE8j5MYTuriGUQApXxbMTM5wxY0izmY3ol7kAB66UYGNr7FhCrhgiWbewZ/ak3L95AMJ99ELtNMXeneKXO0HcK1DbGmKfchZYDXav2BD0hfnnGTwaU88YYeAq2eIR0l10R5bJOPB/Iiuyw8QrXwsJzXgjeXTVRdBwWLVIhThhnoVF8LNlXV1pqG5oJYPobDqcYXAiGwjFauau7dfNWVzMvfWAfbtsIWRxEDp6TVQdflM8xT8tjfiq5sd23f96z5YE/mhkld3kmLW84ebs6Y4YXSQ==;31:cc7y/YaE/lQNov2VsEb5fo04NjlYt7dTyvcDnTISCEmK1LH3XC8USQBLcEV8aG3w3lhaiM8059aXeHmQA/chxQRS3gOaB5lc1aNi7SdH5dlPw8bbtbfSmmWJmPC9hjkZmYz6zZQvzIl8z8OIh+R7D1CapTgpjrM2SIu7wELXXcZbDxMERPHqzLXwKvKt33QBMJXPMIjo9Mdu/bJW60njfCshiEPH2XQ7t3E6CptCoCY=
X-MS-TrafficTypeDiagnostic: MWHP136MB0015:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;20:4mdQMuW9mvtKZffOrw0INmWn/tPPY5TOAN00CNjibenVLRdy2jitdMJzP+uhpwZw9QMd1GyaVp+w3ISVbxihMi1WE869eHA8t/t9mhKamzmvknkiVk9fYyI52kHSnamXe/GzgEMJs0Hkpx9K5eQr+Jf9fJb0WSrws+8kt2yhMqsX/QfWhJvjxwVMq3lAwMMsvsa69OOBThawv9yeLXINrdmhHpHDBWpLSjEM5qu31lEv0+u1QqChjlo6eZn9OpRvfx74IwwYcRc5xv3ctJIVljETXIGUYeGRzrIDNrloTY9TyLeHXmFSl/SDFT8rl3dAC0HlYG3f8sKzznCK4tEI+01PYviNcEfQGUh48sNOeuT0KYb1FQfDIp+2GeTd5Nf3qAwJDsiDU76ZeJZvf6vtaGDC8ph8Go5MpyoyQXO4ZZPJBapLadx42NKauygGOvbtbpjgEtRb7905Ee7ntRyhXQXNU6GE1t0AEqNx5RvaF7M8yicZLxqgQ8gWIggVT2yiBG8aVHbbjaZKxCQAkOag80RmibdmJVJVqaF90KiL6hacxbIcXsVg383sQjDkXOMqhMucu979smqhoCS0hTF+ph9SSzzk/zyYpu5Wz1HSer4=;4:ndoxhcy9KxGNYvLizxhfLYvL/kyS2hD9jBWMJTBRvOffp3F7le7HW/8SMp8q05plQzJPF9DcA2gmGj0/9aoSTb+d+kmpXcUSdJlxpM1lRb79PDrnO2Te40r94vFgATlzYXaMXsFbP8I32gL0jkoKTXNGMPRhZuvGZF6Fyuy5Ty8EFAYRtOXGsAOgsdtHg+/B6PYtOmNO8znA9+LLheoxajU8Yl66F8UG3nZ6oOYYa9ITgjdxB1XwaUE0Nqt6szxKRlA4mntoRKCvEtUaCnJUTBmtOhwGUlNr6QfqTkqW9KZL3hwsBcHn+xi7H87h8mGC
X-Microsoft-Antispam-PRVS: <MWHP136MB0015EE14528CCCD9D1F0CC20E8DE0@MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHP136MB0015;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0015;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(366004)(39380400002)(346002)(189003)(199004)(50226002)(76176011)(8656006)(7416002)(25786009)(106356001)(51416003)(8676002)(2351001)(6486002)(2361001)(386003)(105586002)(68736007)(8936002)(5660300001)(39060400002)(7696005)(52116002)(4326008)(50466002)(2906002)(48376002)(81156014)(81166006)(16586007)(6116002)(86362001)(575784001)(26005)(3846002)(85782001)(316002)(9686003)(186003)(97736004)(16526019)(8666007)(1076002)(53936002)(2950100002)(36756003)(6666003)(305945005)(47776003)(6916009)(478600001)(7736002)(66066001)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0015;H:remr90mpm73.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0015;23:tv158ahBhqLe+86ixTRYCFDGtDs9c8/55qPHGg+47?=
 =?us-ascii?Q?fPnxe1Jl/OYuMlMRHPYYt3GqL01PoY9+G+B0DIxzOkzmmDr5AeWR2txIkWKQ?=
 =?us-ascii?Q?RfQeIBAoGArPJB7wki45H5wP8sYoDHb0qrMOSzzhqkbC9EOWaL5+pRv/fMt0?=
 =?us-ascii?Q?HekhSvBWnBIfhxSX7A/FGI+uJkt9BIjCSQ+a2pVMfK5UWwDxJHkM2WJi+sF+?=
 =?us-ascii?Q?tTJj21GFva92frI8d3/XosO1AcMl+EYqit3/X1EtMLrDMtA+GC/IKofcmB8K?=
 =?us-ascii?Q?97Vk6iLhqOIvFFqCk1HF+uYG73Dnmkg6J0DFJt09i5tzHBQZpcJihbKUuAQO?=
 =?us-ascii?Q?YGKgR0dBcDSzVvH6hp66mC+QNxz4iROM235yIeWIw9cCZACkOaUb6DDs8EKA?=
 =?us-ascii?Q?9DamgKcpZmIOAQLsuVijmwFeamT/dY+OUh5/m00vff68tSHd3HqvJPVukjMr?=
 =?us-ascii?Q?uGkpaJftwBHWJVJ6XV+GrDCjuJfMft2Bi6TQtlVZOj12Nd7xgvJYK7GLoxg6?=
 =?us-ascii?Q?g7cdx3m4zx5EYnOmGc5gJhqahbmGdF77IR5PL5xNpW19dYXXooiiY+JOMSZh?=
 =?us-ascii?Q?O5iuuLl6Q2TKpDWxxpQxIlNd79zTeSzraIYW++dRBEPePpQsXeMyVot5qxpr?=
 =?us-ascii?Q?liEWwERCprtK/9THHRzkX49GDcAzD46Md6o9Nom8Cyto1Emqhbl3AsXue40l?=
 =?us-ascii?Q?I6vwu0MSk46Uh2a5IxHdxVmQMvwYHRoD746ybRfd2gircB87kXrv8UEAC4YC?=
 =?us-ascii?Q?4PgiHScpqgucqIMKHOFoGeHEsbzOTwuYjJ+JN0cKTpkop2ucuczPsAELofnV?=
 =?us-ascii?Q?wOWVik5PuwuYsOrqoU/QhnWUDWqUCFQKRQoKkRf16LMVhJ+IbaNaR/7XB9n+?=
 =?us-ascii?Q?aGsHrRA/zlLQlWW4rkLL/Vb25TpYNhn+pIz6wnrzz9bjtBpeVz1NHJSh5jqf?=
 =?us-ascii?Q?izrQvK8JIR/Co+V+xDm9yWfTYYGqKZRQTjf7VO6MPrZUPetSol9RaTnROEfA?=
 =?us-ascii?Q?EKcjyHcG9rssHZcvtImuQOU1VNa73hmboVaCkGDIC9TusMPHbLe2I19YkR/0?=
 =?us-ascii?Q?oBV8yZy/tBwzo8Y9tquci2IHOURfOuOuJm4Piem9oJpPHoI4UneyiAHdNfiy?=
 =?us-ascii?Q?IB+1nkA5sgI6yUDXvaS6xBsnzV/0OgP9xKJlvldfyjY4ewKEOjUjb7SJoTg2?=
 =?us-ascii?Q?GTqwlmz0hnzFfiwD4DssQxzaBAzLcgdT2q5Op09tnugJQuSbhA0F0gPsbshm?=
 =?us-ascii?Q?mYBmizk1/8xqSzmDafM0NgaL+gPcSTeMgaDGO0RKNjUuYsWTrrcZCnSR0L6u?=
 =?us-ascii?Q?69SSVWkyVMMn698VW4j1mU=3D?=
X-Microsoft-Antispam-Message-Info: LlpWKtHOOOpwhob/SzCyi1hHFwPQjFKODP1179c8zPmbJBJsDkcU+t4SQua690IRe3Z8CgyBElSgP35Kf2Ok7vrGbQI/I3Wx76WyLbn286oK3y/lb1dcexV7p/jje1CuNkmazAjnJurNjkAGGEorlNI2zFioUycUyWlH7OZKmRUXv7+2yQJPmNCFrGJeemW9
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;6:xSo15voSFB4/3/z3GsdT/6ERApfIBKwAS37xZZJqLFUSY7TjfZTuXx0QAhrEK25goSy5OwhUixnjGdtp6MKoDiwsO6JJDCZEqDBQgTTVg1xbVj1SXDpK0PTlhNiBFABGBAHSAsoimvvmq/zi0Qr/RWkispNwRKktJJKPDH83arTVa1Wi8MI2aHKGBkalaS5bjHl0Y3bqwPKLOo9rtDoDwnF2ficYqHRIDCFzVcqjcTJQr56Nc8oDAsovLNQa0Ny6AjZeyGAJL7Gs2vOup9zHQ8Cz98NK0rw+tdGB4su1g30tjeJkBxjGib44NVSwF9ixcVh+3+mjLZs51VMZ6DZNgg/LfdlnDnbiAmhwV/2Fl28=;5:/ThmurLGY/nFvoSEGGcH0EW6JO5099fDow94UwLW85M+9x92JrVeEAu7eR0UaGcekhacqANIygKrew9P19/hoHX7l2slSjiuODf14I4KWDhePgU/EYWTwf75o/ZQk5F4lkJG42pq1VXf2qc+mcZiv2Gg7P9qcFxzBfsFauFEMAk=;24:KtwUX/H1cvK33PLBFZ2jiZwWQ43nJw41brAejIOylGAR9U0y35+qjFxreeHwS2uhiG2HYvRdUrxcfDl6BWC4VHS6+1DD+67n+Fn1IoKJvdE=;7:KHjcGYXM8WHdxH97NWGkBPh0r+FN0NW+W9uitP8yNPvYUC03afcjNNbKUqjTXi7HFaNOVgEubLOOGzM1igMptZOLlPO/a7XUv93FDs5yRCtM1JfSgvXIMZE0cwmdHjKeXJxbBphBWU03gYV2DIoV25JBTAH9WFWuUbE92risgTIvjGsUqfxALbrmd+dyas0iDfP7yBuuwxATu68RJ6uco8SfbKE+3nwiXCsDQ14lxNCfbdWqlfZcnJ/rm60VVGXA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 17:35:53.1060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a27cba3-fc9f-4716-315e-08d585e43685
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0015
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Create a copy of an existing string and make all characters upper case.
Similar xstrdup_tolower().

This function is used in a subsequent commit.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 strbuf.c | 12 ++++++++++++
 strbuf.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index 55b7daeb35..b635f0bdc4 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -784,6 +784,18 @@ char *xstrdup_tolower(const char *string)
 	return result;
 }
 
+char *xstrdup_toupper(const char *string)
+{
+	char *result;
+	size_t len, i;
+
+	len = strlen(string);
+	result = xmallocz(len);
+	for (i = 0; i < len; i++)
+		result[i] = toupper(string[i]);
+	return result;
+}
+
 char *xstrvfmt(const char *fmt, va_list ap)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/strbuf.h b/strbuf.h
index 14c8c10d66..df7ced53ed 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -607,6 +607,7 @@ __attribute__((format (printf,2,3)))
 extern int fprintf_ln(FILE *fp, const char *fmt, ...);
 
 char *xstrdup_tolower(const char *);
+char *xstrdup_toupper(const char *);
 
 /**
  * Create a newly allocated string using printf format. You can do this easily
-- 
2.16.2

