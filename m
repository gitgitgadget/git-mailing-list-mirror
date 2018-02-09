Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B4C01F404
	for <e@80x24.org>; Fri,  9 Feb 2018 13:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750973AbeBIN2x (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 08:28:53 -0500
Received: from mail-dm3nam03on0125.outbound.protection.outlook.com ([104.47.41.125]:61739
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750924AbeBIN2v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 08:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8o3sHu6rkjUymqBr30CM6mUK0fpAASLNdWncZq/XpwY=;
 b=Vz6y2lJNbfVACpxPqPCKAB6lhqW8KSbLr+OGzvYksGw0q/JmPpbNujoOC6tUBuJ0C6CaXmE9/SMu24s1Qsth+XplW7wDMyMQF5piJ3ovhq6Dg2OkSnDUQSjais1/rtdukHIDOQSwhMq8rQmz98t1uu3lp6ogOP/IU/NyIrIj7tY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 DM5P136MB0028.NAMP136.PROD.OUTLOOK.COM (129.75.96.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.464.14; Fri, 9 Feb 2018 13:28:46 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v6 1/7] strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
Date:   Fri,  9 Feb 2018 14:28:24 +0100
Message-Id: <20180209132830.55385-2-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209132830.55385-1-lars.schneider@autodesk.com>
References: <20180209132830.55385-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [62.159.156.210]
X-ClientProxiedBy: DB6PR1001CA0018.EURPRD10.PROD.OUTLOOK.COM (10.171.79.28) To
 DM5P136MB0028.NAMP136.PROD.OUTLOOK.COM (129.75.96.155)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 48fbc85d-0776-4fb2-a963-08d56fc10d91
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5P136MB0028;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;3:pK6W2SH/6I37ULOEJB+o5xnlEmlug6iCyvAaKEfKKEnjmjNbDUTNvoOWW0tR7/PnzYdcw+AT2WUUZOTAICNegWixi3DxxpTgaBO9TZPwGd6y1Tw/0sz7KYvKTEmRZPAsFPN6hV1LBcCDLVuzE33u1/xRO0d67wcbIUVf8WUF4AQd56HIHYxMPJ0MtQusTecWqM1pirzt5Pcobzf2egjRZ9QgXMGtb9SijDBbNHyRfmxx+n9tR9JVLJ9TlXAyM7or;25:6iYyrMYT0dtIl8g9vFcTjTpNs5V5TNu0dwtZJboBRot0xB9lhzx2Mr+cXVqk9jK2BLRtCM8CiWnOXCoT9YLBUVSy6ELBWe9sygKm4wqCiL6b3gDmvqm09kPISg0DHVb2kcrzflmKYLt/VfbQhNJWKfL0Si/rqXNwzlJLbP1xaqWFa2cdszK6smT5CvQBzWe8jTWl24pYIOpx3WAABWz6HcfegyZEJ9ROoIhfB4oMuxBQijjOUfGys6yqayT4T7svKsGYkQEcaV3O15gX725Aa6EeuE2yqN4H2MPCRpzm1p1LzaaqQ2ptKPBJnzpY7GOpqv8Sd07Lqlz825nfgAqd1A==;31:8RS/vORRjzD/7mEmpmR0ytWsQy8TvH/fJRT9pgCAJM+Cv362P0AcERDMq3ecQgpDCryiSZ4O4eT7hFpolFyzHXE0iBNJIyySQi9xgwc+31LLf4xDQUnkf6dSexqm75/e4DbUxCpWIAYjAENcDI+wDUxasWJxCKRMb5nLNhORxzuAplkpi5yeOX+RxxVj9o3SFHDCEulvYDrELDcQ3QtnDQzwWBQ/W1CA8nE/Nr9b1po=
X-MS-TrafficTypeDiagnostic: DM5P136MB0028:
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;20:G3ENxRPI02H1/xpxLXMcHBXZznP4nBQr1tWDgn8soUpEjHBHoX32iXO37Sq86sphJeSoOKvc/s1oN33azfANiiFObkk0OhSo/2z8TKiqzYdEj+i9tlRW2ArdcuruyWSYml6gSJffNV+bgMLwhhmxz0PSgGd1PpVBD4aHKILr/Gyo9RtKBO100lYYTNMd1SkPg57isteOd/jPWBEXZcqtSjB89fNteuqDSmgC37Xm1M+lydb2SC5cDLAwOwOFDWAmSaQ0TnO3SOG9rQ4wrWKcu/zso0J2sd0kl476oRE7kFNnSdaohWUVwbTMiuHfTyAc81S/MoZJLJEntJ+rFIth0Q2Q3pyXqrSXGViJQbzh3wfWk+SqEKecocK021yTJarg962NOOes6T8OsjIZVpZfpy6Lh4nDKtrT4MN1HMJq50vLb3cHK0cEphvHMMHZFR2QJCs9/EkJczCiKehdcC8esOE5qLp+pKowJxqjIhVb+k4m4P605k6JOU3crstbCv8wA+ozcKN36Oo/yZTAEvWe7YCZObuNLVEhPtmLVjXV+wuw6yMDK41y98GTN/1Bvx+u2WgdriWWs0MFurEqgNlxTpgGq017xEmNaD4Lobogu48=;4:SKlOE4rzbaaeQDVTjXlIiWgJqX4qeN8xOaM49kLXl5yv675/oNLuspdvHGpTxJNrslXrhQIXbwv6pIeAUsULuECG+Dvu9aRkQfMvG4sPOeuFTDf3Cm2D+YB7HHDez5xZlYVy4Is/hAOaG+e57FjHMZf4gqCqhTwD1+qhq44PilOaWMSKHLfzK2xbC/zVGw6/eP0dz0dOlnU+egZKEW8T/MNW4z/PmXlAFdwwB03JWcnRics5/S+AAEVbINTkCg8nXF21kPEwCtZhGGhtIB0xZcdZty4WUU4hBnB1kWlV73qdfAxvQf0asX1fwvTxbVhS
X-Microsoft-Antispam-PRVS: <DM5P136MB0028A6A33A2D6BBA8B68868EE8F20@DM5P136MB0028.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5P136MB0028;BCL:0;PCL:0;RULEID:;SRVR:DM5P136MB0028;
X-Forefront-PRVS: 057859F9C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(366004)(376002)(39860400002)(377424004)(199004)(189003)(97736004)(68736007)(26005)(2361001)(6116002)(3846002)(106356001)(2351001)(478600001)(53936002)(86362001)(9686003)(1076002)(2906002)(85782001)(36756003)(8656006)(50226002)(316002)(105586002)(25786009)(52116002)(7696005)(51416003)(7736002)(386003)(16586007)(50466002)(2950100002)(4326008)(48376002)(6916009)(6666003)(8936002)(81166006)(59450400001)(47776003)(6486002)(66066001)(39060400002)(8676002)(81156014)(76176011)(5660300001)(16526019)(186003)(8666007)(305945005)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5P136MB0028;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5P136MB0028;23:VEkX5+qXaE+yy0wIANP2OvYBLdfQWb6hXmoA4JpPM?=
 =?us-ascii?Q?8GSxYxhP5AO35mRh0LrZOLQdgQvO4vI4GxgRf1uyjwJZ5NgpP4LxjnaawBTu?=
 =?us-ascii?Q?tTsFbITBLhtPFQAhgZjvSq8rfTE5LNSyWuDOJJxk8wqhYyXZFuIfEGlYLgG9?=
 =?us-ascii?Q?AYcCPuGImSt9u8Z2QnAL1P8hsNGwyq/WGe6aG/mJTxoO22XkQwwJvNNhCUHt?=
 =?us-ascii?Q?Ts6DavQNx43iThhbh7Gw+oH5zAkBaMSvn7eMPPM7ObMbQo7t8skKjE4NWopZ?=
 =?us-ascii?Q?NjYaFvim+OCZS9kF4y4dJ6oFQLqUG64WiWJv4OvEAEXMklelrSlk4RMb0b0F?=
 =?us-ascii?Q?ZP9/27cWes9UQVkzyPsOASIoHPT5NwHC+3nkddTjoaRCt2ohNEb/InHOW2rA?=
 =?us-ascii?Q?cKAucZh6yFNMkaU7XNj8GpTPrF8EtT08lupPw4NPr8nhoTJYFtR2GdAXuR8D?=
 =?us-ascii?Q?1dfo1SrC+LDz+sKfTT46fynl7IhrHcy1X1Z38XcdxfKoewv1Xp0R3arM/N3F?=
 =?us-ascii?Q?HcOxsQPs29PdTr6TJ8wL8SH6I+a+xoBP8PpStTsv9YU1zOPw7hD1Pw6weMiq?=
 =?us-ascii?Q?DjBhE7W7CKqSo6CJPPkZSOGWYjL/nfTjmexYGpdbzW4hs8m1yXcpqXRvV8hZ?=
 =?us-ascii?Q?O32cSSzgXYA8yg8yolyfbMcdlUvJPkUOCANOVIjDy2A7G0Y/jcmXb8ZzcUB1?=
 =?us-ascii?Q?VJHY6W5vWIHKxi0iIeojYySsZaDnr+eFKPqHCcTEnULvLcjPQgYkdzttWh4b?=
 =?us-ascii?Q?uunBH6SwytVUzlStlSAXnq/52EcPwSBjEcaQTQAdIuE/PO+JOFWIJvYIUIKs?=
 =?us-ascii?Q?0GydS77eFTZNrUxGiGTWIAFC7QHZoP+Qv49NaYitEn/YSwH0Ljs7CqfvMCWB?=
 =?us-ascii?Q?3RclHLg7a9LAebgQVdD6nUQJ6pPCvTQLYspFZ02fHvAGBNCLP7BJ47RMgvIX?=
 =?us-ascii?Q?c+sy3WgfiMsrf5ECxtgdEpOhl+5Ygt2vO35MLPxwXKDHsaVGaD4NCZ2s7YQs?=
 =?us-ascii?Q?tx4vcO7reWEcLtAukw36hqnGFix6dFtbfHi2zJ7xUW+aI6WyUFioNV/wIDXf?=
 =?us-ascii?Q?sdRVS68ViyY5q8I4r+fMiV3supoRuDP9OAo+WRyDAznf54JO+jjdLiysnhrM?=
 =?us-ascii?Q?N8N9jH2nqYfiqGGL3kNCygNIacQNhfRkaHeOq2a6G4E8M+tLcogslsqmoRb2?=
 =?us-ascii?Q?k5Jk79xLZ5hOTUrRAA/DOGmBzsKA501g0deOAR/5JbH8BTX4dBmHn4t1oBal?=
 =?us-ascii?Q?u0xCvR7F2OEx8ow92s7BE4mRsjxvESCCRTQXljnjstzh2YiuCdPjAJe6W1jC?=
 =?us-ascii?Q?eLk0aVeoTTbyOCeOupgwWQ=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;6:HJjzf0eQBRYiEGCLMKtSHHtskM1+6GZ5byA22MhDQD0/KhshwXAVlmPAuZCeeCCWA7AGlJ15PzNP46hmVO95XVAdjBJNWAmZguv3hUAKRfi8p7pIMmLAZH7jHSws4t+q0FR0B8bQEPkWPcnEVELtfyfEjrg0q7Ir9XRETOgqLY9zTY6qOOKWYnHoCSeIJv3MJpBF72pYj6Ty3/hhzLWWqq1nYYRT++Z1io7GwyzBQSftWCktGm9zYx5iPDLkqoR660IZPSPAsD7ltPlO3ILLUV8C1/grOxlwCTAhmL2fLz0rpMysoYvGTQ2uzPQ6L+6gaAA4MUmDEWG9hcyIxFTG7PAx9f+LsatcN98N5+ucYpQ=;5:jJ+ziEt/5fjqzJX4n8AUQfLQBPvBuFUvQuPH9sjpfUKYzpZ4+squoXQ8+Uc2fsPZcTLD3BKAe3p4LSaiENzxL7XPeAFGReU3Cqj6TEDtu9U9rvbOHcv9wDUWCkC51ZcwPGvEFZGBbl1wa85BQGT7ijDSypHg1zBDOD/XUZIu2ns=;24:9wjG11UKrN4GBT8DgvLmzeKrTwKuXERKf+YeikUD40q8RanerILsxKLM3yVLN8ZKhbvQqlGKMNdzrjMCcwtpdrNieaM97sxfFKjDTtqbUoQ=;7:fq6EFuKOF9Ejb2DJNaWNuvgdO1E3/xgsAhIBdf8wEfTwWa3QG+BIIAazGaxD3uqTSk4mR4DlqTndLfiaEbwHEhQ/sa/6YyXz9jQ5eUOpLfmJ1+c9LmcDBSqgzypJUkZ116faR2X24ANfdy/K6YpYCi4voNcJewxFuSYu0GRvUBKbepuihWdyQdrCIvqlra9idmbTzDsD+69HOp/tSx3A6tkEtnbwcBc8+LExcd1gUuYVI88QuxGacrplkGIL6Mtp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2018 13:28:46.2626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fbc85d-0776-4fb2-a963-08d56fc10d91
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5P136MB0028
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
2.16.1

