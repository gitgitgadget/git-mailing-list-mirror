Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9DAE1F404
	for <e@80x24.org>; Sun,  4 Mar 2018 20:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932157AbeCDUPq (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Mar 2018 15:15:46 -0500
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:20096
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752007AbeCDUPn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Mar 2018 15:15:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yw5Cre1wefirxNri6ORzCepBwKORD3Rrurh/nB5Yu1o=;
 b=anUtZcevxR3lW7AiqUqj6Re3/MKzBkPQHrkfzeSy84twJEkI//O/VMww9rFQ/XjV2LuTnkzMSB4VOgsksslRkSIm9RfiI6lnC+NcidIJ1UbLJ8VwlCtpDoNFFuQfOYjTH3s8UYeUbnwUxL7p7LWfO4scNlzGiy+citi9XC0HRZI=
Received: from far8gsqyz1.ads.autodesk.com (132.188.32.100) by
 DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM (2603:10b6:23:8::20) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Sun, 4
 Mar 2018 20:14:39 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v9 1/8] strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
Date:   Sun,  4 Mar 2018 21:14:11 +0100
Message-Id: <20180304201418.60958-2-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180304201418.60958-1-lars.schneider@autodesk.com>
References: <20180304201418.60958-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO1PR15CA0113.namprd15.prod.outlook.com
 (2603:10b6:101:21::33) To DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:23:8::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 42e06915-747d-4783-5958-08d5820c9070
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5P136MB0009;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;3:PDNi6IRvQQ6UGDR+M0Yl2rF+9MxLSDz2KSRXsIMKAplqLS6stwbiyJAihzfk2KgadjtaMH4bReElp0CmKY3KFTNxhwyd/7092pVy/EuAEe6UBlS5ISYh3RfyYCxHq1wCnoucBGu5acxteCOzV+neaopaQuvNNqVSeOO84Zq3mz9kV7GUBlmr80nj+2iTthbRqHLDA6iaC0seIcx+8QZe01t++NrtWxnysZdYBh4WHurj/SgPtjU8Bx+WcAP5H9Kp;25:AxAHGc/s/PEIvNbhow8rQGpCiu/qyWyGlsqS6FSLo+QpmlW5uzYBuM5WfgIsWJPyUgvQjY/vHSlpsbQijuPmJ/KvGr0pFspAxUFPcaXbwndMEydZ2lhndwI7dTi6Tsv4ZCdzyAVrQQHizfjQkb8ooflETqkZRH92wsb7MZHabjwmTT/DN5PPmHPv7bPlJejTav2CKqqdFU1594bSotjLuhFtxB+L39Bp4VKxG+AeaZR/W2MRC2lFnUQgJvWfx2h9qx5UMK+9Vn4vfLxRjmoLnoIQRoyNFNnVqawYSGGy78YbTeTtCdog/deqfHHpphANVOZZzAiDddBsF18uvIvmOQ==;31:hhmCuFKB/KAQehlQ4ukeglR6pTW7kVw4BM+jTbtbnLoZC5FeMSterUR8w7o9ELIkAEDUzESaUIY5fcro63zLGRhBXTSANLlYBwt3oDM0+W3PtkcWNY0YxqMoQrCHjlYtKY9T2mCYMCODcahiLYaRXrtHN+QYY7UMXi0qTl7AEAavc8BLVCh09mq2/w/oZfRbRYapQ3f0nWHGjl+b5a/pfaVF3gqa9199st/3I26GRYQ=
X-MS-TrafficTypeDiagnostic: DM5P136MB0009:
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;20:/+HiZ7QhiLgCd9I+V2Ct8y7Fa4e6iJE9DP/Pp7s3d4I2+5l+1T1Cq5KtNce6mqYVNN/FY6suLo4qBa+bAzazykurBD3sC084D9DcbzmuXyFI0p3y4vJZV0i3W+XnI5E2FtIrRkeM4RJ33lc7mE0mJVM7Rp81e++8Uanzj66bowq/O1/AxTfvpWGyUuRQ/Fxa6df6cBEKFKBQ6cUAnQzfia5V7Yk8UUDMdU54CE7tFFgRanV9a5iPoJv6bZtfGF8Ry1/+28yFVwIkocQIPqobh2C6n9Fkrya2lHxbJbBFh1fm/1bE0IuV5MdgoU5AKphp/DiOPUeCmWyDWQWqIPKg5ZRLfthV0fX8u5HaqAOsCPJMAHAHcIdI9nNPL6SoyGc4PlLI/wihkdR6qPsa0TuwPaWUH2Edze4aAIylp1zee47/EMEZmMQg9Mac8IzmcXJzGkP5872AYemzHdoz7F+Xjg9fD9nsCddYzD3NvdzvWTEl7DOnEkBv5nvJY5aac0AGwJge82biFNnDk6Zhh6TV1LTvWWQ7Zym2CvGzp3Zt43L8hDdnbXjqfJoIrvtI9nj64TanjESoKVXinc8T0ok8nXO71Vwo8BX3fVzgGw2FkLw=;4:ddKthPIwYCIxv+jLEUTx+FFaIFSn0XGDv6Is84BXu2Ogrg/Td1LmOJddxcVIHCWr0S2+jrRjLJq6cIGQSJYk750TdupwVqjIT6KaFmzWXw10gOQaTpDc4WMXrqAmqF7M5QmYif0v9A4kwg+iD8S5DmGtMd81W4Esnf2bkAMea0DtxQot1TYksbpQTmR91kiUdoNTFiMo6atHZDBTFuJj/n12KG5q4GOR5SGotFW8VTb4WsGoq6eeGFXjWmSKeDQbqB6YjZcRRKsIc5QmmXDO19ltWWHRiKu6wlyk+7f1VSlvBywKhwte6n/aX4n8Kdnf
X-Microsoft-Antispam-PRVS: <DM5P136MB0009D352FD82F6CD9ECD42CCE8DB0@DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5P136MB0009;BCL:0;PCL:0;RULEID:;SRVR:DM5P136MB0009;
X-Forefront-PRVS: 060166847D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(346002)(39380400002)(396003)(189003)(199004)(377424004)(316002)(1076002)(8656006)(2361001)(16586007)(66066001)(2906002)(68736007)(7696005)(85782001)(52116002)(97736004)(105586002)(51416003)(76176011)(106356001)(86362001)(2351001)(47776003)(6116002)(3846002)(48376002)(8666007)(25786009)(6346003)(39060400002)(26005)(4326008)(50226002)(9686003)(305945005)(386003)(6486002)(59450400001)(53936002)(36756003)(6666003)(2950100002)(6916009)(81156014)(478600001)(8936002)(50466002)(7736002)(186003)(16526019)(5660300001)(81166006)(8676002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5P136MB0009;H:far8gsqyz1.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5P136MB0009;23:aD2ZHuYxjG6glNert2gCh7E1cvnWo4eM72jyFseF0?=
 =?us-ascii?Q?QDF+gj42pDuW0ftrIi5nCSvGLxvOMKwp4jCregZsEsNOJ6CGjWTtIG7+2vxp?=
 =?us-ascii?Q?wvwUKcYP76spqCMeV5+w+jQT7A4a+BOFWWPsery7/v4LLqTb5WMEREED7t6Z?=
 =?us-ascii?Q?fz0TLWWNyv6lkUc8eh2TdB0I+jQ1+xK34Wt/8iv5PkNmXXNtc2rdEl6FMCjD?=
 =?us-ascii?Q?pFrN59L+a5nrbETwgTtqvBylXY4oydmgvdIrIBJrIpjPXXZV8RLSmVNgFrnA?=
 =?us-ascii?Q?9HfTdWgWnQ7+qa4s4Lh4PgsYP9GWXVcec5a+sGe0I1YiG1Er2TVDkKn1GkV1?=
 =?us-ascii?Q?0P3vZ1AVUAQsJy4+pdTBR1uj6kLJqJSXZWF9Oq/iJ78G81vpxv5aumPgXAot?=
 =?us-ascii?Q?0VKbJLPw2FG/CSo+z6h0jbCO6TCT15hjS3bQtOKTXiOrWgqDY/gTz2b7VHHD?=
 =?us-ascii?Q?379gVvioqbaSCB/jqHpeSYIPR9HJq+mExDXIvt1bVmpXh2vMSHFIOquuEHFU?=
 =?us-ascii?Q?P1sUW15W0J0gQG3U8nKkc19RiUdrlcgHqQLFOWdADfPfdldZ2HlOFaX5QEue?=
 =?us-ascii?Q?YTopkFPzqPn6fvV+oIDvwwNPR632SJGxZXVkpPRsmdqW27O2J+mW/P+Lr8uU?=
 =?us-ascii?Q?GqjyrkVO3DjsbqlRZBpT7xD67RECJqKQmvKztdNGG/DUScm4F4XBStdny9x8?=
 =?us-ascii?Q?jMbwXhi4nKbmFUCacJcWyBO+Cm5hbbB60gGRMI9Fz5wM0tkNKRmSf9pNgQos?=
 =?us-ascii?Q?BbOW4fKnttTpJeMMOdVw1d7UKf2ldsRxobGxGAxFjF8MjdXQ9rMsXSK6WUzt?=
 =?us-ascii?Q?uRxoto9brbrE/V5FQMlpCmV7XasPo3sxKA0yvT5qPbJY9TdJ/abVsKIKLZtK?=
 =?us-ascii?Q?ksIss7TGS1mD13P3iryAJtkCRzKeHLMz3eiXqf1PTwQ1DrXkwoag9rt3ZtJN?=
 =?us-ascii?Q?43XTt8LtM09f1s/CouFOizwiDoJYXWsOady+BGpp/l3MjN1599OdXz1vr+LN?=
 =?us-ascii?Q?Qq7RberaRiw9mp+Y8CffS1nGmYrZTcSwBuA5sEDax2xzsLotZaAzK7aQdY+q?=
 =?us-ascii?Q?Hxa1ZqrhgasRIzL1OB8F1Rv3pvHDXiQZOau8yu4JWAxUh/IAXQSIAhGYfXZJ?=
 =?us-ascii?Q?YTNkUx7iPCNx11KdhtCKtb5xCgWGbRlsz5Xkc9GAKWX13E0NgZ6FAjWH8rvl?=
 =?us-ascii?Q?0M3UJAdGF0aekrNVsVz344jtnMQcrnyiNbhnQONGVtD+i3lglV3N3WPRIUrb?=
 =?us-ascii?Q?5OKL8F9MgW/zWiS3bNWKyYrqFIGHJxePYHUEM8qtFyS6UHX15IKWU8mVcGkA?=
 =?us-ascii?Q?pSnjOaYEKyY2szldvQHBGBnwJZJMRESVMpEyl/ipXLX?=
X-Microsoft-Antispam-Message-Info: Bnh8csfiWr0KRoNcUEtBJI/mjsJ7vtUW2hBxmACi6tmPn+KaHA5DA/dutx9YkgvJF9fvB5KikwW+48HXg6J4FaE5fhhBn2qpOJnEsIoKbaN/QqTUq5coWmY3pnqTohP7Cgj+BUk5/AUT7UgBxTX3/LDR2SVNj4yNRB4ropDk1/RsIz6po7L0BI+xUV+Oor5x
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;6:vlI738F9GyakXZFAOMWcfOyWiil3zcny1L5W/iULtXApy3NC20hRit6NBq6thd3co30gNu8AArTgdNN0X0Xj0w5pA/oj4+IIxDiUa1G3bhZoEvELqVO+AaUpbtLxTTai8vAANTDS9BH25wIMdipn/O+9SY9RhHWi0MEQjMfUyHssWamontQVijFdzbQLdAteRB6lyl3aE4dv2ChL58FBhvN8nBq8nPHoYzcEOJq4kR1LFCk6RFi3j9S78fwiqN3n0Klv3WWpVBAkxksTwC3lMlLgtCRYt5IrVsKRonV5ZmcyywifgYIm1Qu+sTZSPf6rqgk5G/4ruBeA4N5M9/OIUtB5XYfDQ0dRCDxdOW84kAw=;5:/G8/xS3ik7K2cQj4r/IbB9rJrKoetGZ4gTe1jgKUHTWVfqYH+Q+IjIqhd2e+BI8ev1rrfpSSbzyI/3av4en1I+v8A3+gT/4QsAYFQ+f+qWx2oi/SErhwUTfGFVH0c+20WWimCbwe8G+OQIehrGI2E0izTfBA1OZSr47Gd8Rev2A=;24:GQS5yjwL/sOtabHmet+DvHykVdEweQr3Q1tw1dfz9AdFh11OkwyfB7mdZwQ+XJNFynkmOFvGag+ylmHXSDfXwPuJzy6gYBvZyHfq45MdSn0=;7:vh4litEAdiUBxFoTjqmbc2msRqIMKz0Xs9Qa+CDFWyTfiCj70Mn9qfrhdHgEfKtP4aGyEJILfPjvOzWpp4W3QXikASyioZTd8A0AUd63PzVFJSCWzp+tTXEBe8Wyg+SrZAAnl5Y7kysup1stkHCpFWm5cr9aGgtJMagLCzQnY7C2sOB3WSilFDhOZEdEDCYcPBDN5Sqh/lzlfHusnVHVgMUHA9jU+jicuzTtCpkauGr9SxuYCtEIF+O7CxQuiaIV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2018 20:14:39.0105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e06915-747d-4783-5958-08d5820c9070
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5P136MB0009
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

