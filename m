Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CB091F424
	for <e@80x24.org>; Sat, 20 Jan 2018 15:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755320AbeATPY5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 10:24:57 -0500
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:63120
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754051AbeATPYu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 10:24:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FCxraRMnCsmziHGCvqa2ta7/P57crWbS0KMMSLmmZLM=;
 b=kvQVTV42fKBiWWL1qHyTDCy3YhEmYv/ZQ8MyPTrTtOC2tHk77/ranrRZGMHPangWSWpu72Yvg6qD0y7JQD5emRuND6UQvpVNjJ5f9mUY+F+ZJiqOJ7zC7ynYSjai5smL/rWx4TB5RzivO5Ns0DKynYP0DcoKS6DOQytmbEiOCu4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxBook4.fritz.box (91.89.52.221) by
 CY4P136MB0022.NAMP136.PROD.OUTLOOK.COM (2603:10b6:923:12::25) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.428.19; Sat, 20
 Jan 2018 15:24:46 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v4 2/6] strbuf: add xstrdup_toupper()
Date:   Sat, 20 Jan 2018 16:24:14 +0100
Message-Id: <20180120152418.52859-3-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <20180120152418.52859-1-lars.schneider@autodesk.com>
References: <20180120152418.52859-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [91.89.52.221]
X-ClientProxiedBy: VI1P189CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::19) To CY4P136MB0022.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:923:12::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae667b20-7fe6-4574-0b11-08d56019f1ba
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534125)(4602075)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4P136MB0022;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0022;3:TVRvkVTJFkROtNKpDXXzEBo91v3Stfr4NH/hdWR6tW7BNASb0G+84NTT9e3Dg0/RkJYhe0urxLv0Zqh42vO3f3pTPhtanj/RH0Cng9toQrgM8mgODzqTJIscELiw1nJtQoBQp6vYX4+fuwEIJTMZkLhvtPePHTHoPonCPmrIGSpY+a2awVNgHlGa4jEZ4J+f5Ce7gRaYXHXZSJmbCojc9T4UglCdBehZBAyuNtadY6YAvkdC7vE0SrkMI9h+Cgr1;25:MrspydfhHJaFOwuOtQhE5oYLCNz4vw/HGDTCO6EQiLjDBh+R5OtDTtm/3hgu0VzJQG152vW93/EN2xw0EKadaYKJFt3mvVwJYoDfUL/EgxNDbEHuak4QGy/WZFPqWm7PRIRMkt6uZdGxGkyadJQLs4u0ZB8qk1DpHRbNDvuJ2Wm88bGsVgFjrYa0KeuvalIqvINq7noe9uaiMtmbyley8pdaXwjNv8fAQHMt89t8k3+fdJ4fik3J9LhqiqIKKNtLRfdjqNcwv2tv0UQjniCZLYpW4ysrRejBajN20bvlj+iyaMosEim87McVdGDlRY72+HC2uonyGK7WXfJ1/Bjb+w==;31:Gq/uw6VpR+0Rvr0OIJ7DX7MZ3YbG7GD4BoH7chQE1s5hXHegbqg76Dx4iwUyWbCjop3G8UFrb+BqrR3URn/CMXg97hmWRjR5yn0Sgg53qVoCAvyS0SEEN28950hfexxz/M5u8kK0KIXzH/MhGNyyn5mRaMp0fUaCDcAKN1JrErfJ68voHVakZ+FRtciIQmu0pXdwkN/kjlN8BoFbbTZEdCOXEN5ypVwF7/yZbHcu9G4=
X-MS-TrafficTypeDiagnostic: CY4P136MB0022:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0022;20:eT1F6JK7dE7hQ5su1ntnhIhPMikRUI2iXbWv3TQ72hFNh77jusOqyHq0jUjg2iq0cOuT3Cm5Wo/M2fu88+BLmvS7V8Ab+c0udYdgeVI7+MafDQXciLTgV3kHdguVJrrupRziElcpmvvncP5Gm3KAN8+X3q/QB4BsoVOZ5mniTBIN8J0sp6uuGYVcvtK9EoOJ/hPKqDjMOMkl1CUi/FqD33IFEv1Ptqiu1GJQxm3EdiyqL0HqaYY5vwiOqx2u0UeH/L/6bJwRelO9yJx7gL3xdLxvvIlU2FUiVL4RPKqWmEINaTTvUZfDtXwSIFGtI28jjfiXCd7YRi/Vm8n0n0hAV2DXjnN2rI7VjHNpJUOIgb+ZCD9+2ogmsd9weq44IoEAdDihnVeQT/VeqtUxW4YfwvTS6g/8fnemgkU8Osb93KWbVzO9eZEXm3WBkX6KpznTFupVhLJO/ZRFt+Oj/aFlfoMcqKRACddxgkjt83QhbckvmCV5UYVEUJYt0xq3unzFb+Hz7DhYkrq+3R3oyuv13o72wxfp317hyRshamVZtI3IPbYVNi2ozVtfLzmgxR5wi537AG01QSpD/3DkocUfFIz0Er8sdiQxPff+gpSWgTc=;4:kE1vCBe0UbepBwlL2regvjhoxD7GVUbmLPtv+6Yisqdg4AFdMeocL1W1dlCIMci4gtXFWydL4Br9K+JAh1TJJACRRvOc0AqlQ/bkwufHfshILkuN1E0XattUg4d/XaVvjYYny4rblNJHc52OfHv1V7jmHlgs2u8qeP3Dw9UHJwwFPYlA/xm0r2wo5l+4Rlg2FvADuFP/fGMaHZuKgnHIc4DAz6pcB97eywuPKSLr4HYf3AWo3LyJ43FAKNF1K+wBlNIANa4P/6yYArUKNpa9t0hBaWyroEtsKwOZH+gkNkC6Azy4dQVResu2VvapR2n+
X-Microsoft-Antispam-PRVS: <CY4P136MB00220617843468AA0C844DE2E8EE0@CY4P136MB0022.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231023)(2400081)(944501161)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY4P136MB0022;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4P136MB0022;
X-Forefront-PRVS: 0558D3C5AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(366004)(346002)(39860400002)(199004)(189003)(97736004)(16526018)(478600001)(68736007)(48376002)(50466002)(305945005)(16586007)(25786009)(7736002)(39060400002)(3846002)(50226002)(316002)(85782001)(4326008)(8656006)(6512007)(1076002)(53416004)(86362001)(575784001)(2906002)(6116002)(9686003)(2351001)(69596002)(8936002)(5660300001)(36756003)(26005)(66066001)(2361001)(52116002)(8676002)(106356001)(81166006)(47776003)(81156014)(8666007)(6486002)(33896004)(6916009)(2950100002)(105586002)(6506007)(386003)(51416003)(6666003)(76176011)(53936002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0022;H:slxBook4.fritz.box;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0022;23:SXuJxFo2TexeqOln29Zl+LFwPs+t2ArNKSIGPnIOA?=
 =?us-ascii?Q?TT2EBwdDSVb9nUwx6kHbPRd3FOUVCQw2SL7O6hiEjFriT0fIZ5fmnKY9oL/8?=
 =?us-ascii?Q?cLs5OIekw3HW9NHmLjV2KcpX37BmoLfU0vd4kbIv1dfIVGqQs2BHjiTRERxA?=
 =?us-ascii?Q?wqkoUQR8PfIFxj0f+oOMT+KMm5qWk/iO7KTmP8o6knfdIU9DZQszgWYkGJ5J?=
 =?us-ascii?Q?smRCQG5xnjtVGXndbsaG66OcG8QxC981bJma1McEZ158Rb+/MKFUUlQH+Bo+?=
 =?us-ascii?Q?55YktZ7ljc38v+yKAOvv7hJ/ETcHKSa63KmgkctVW4JrRDQo8MYQ0lciyTlZ?=
 =?us-ascii?Q?f1RzBAR6HHVt1mtbSyk7XhGp+TXXre+Lbj9AKwz37KPakc46oAyvjrvmX4Fe?=
 =?us-ascii?Q?LrF0HW3IW8j8qy3piKsmn/vVkEHF+PbvKyBmz0l7cvNFfm4PW7gnMAWia39g?=
 =?us-ascii?Q?XDDHB+HLnPxeY9o5P9U4j+fj8/kC9SzRpk3Rws7tUrqysVqhI7Xns1DUVCRz?=
 =?us-ascii?Q?ndFlPUCNoEzA9H0qsEfeidjT4Hv2rg4k614AJRjTX3xXd5YFZ332v6QgPi4A?=
 =?us-ascii?Q?4nEvnItC0pUaJki4R673L0jxmAn8gIo5iyyhZ8GcMJJHavnAZYTRYKJ0AJuP?=
 =?us-ascii?Q?a82YghLcR2Cy+iNT3lbinYu3tT2ihy5AO9yU8yyFOMc6dOMF1ImawoZdQZUi?=
 =?us-ascii?Q?irk/Z6UDCUbr9q1WRniU6lb7jQs3F2FYYnWZ15d/TxN1lyEqfOFSzB9fC+WN?=
 =?us-ascii?Q?sodVytMoK8Qeh2v31y2FWnVyDCyKd4jhEvMh+BZEajSqUlvmtUPWv04Uouff?=
 =?us-ascii?Q?gUU/wKAe8RtuJLt1Z3F42OJ2LYG+QsjV7gc1xJFzBmEMnqF008jytPgJN6p8?=
 =?us-ascii?Q?vcbtSNCgVwtBJ2B+hCoVRYa2usNpd226edBYuT3HZUay0x7nRCGz4crZebrk?=
 =?us-ascii?Q?mfq5XIqXbgTf5ldG4ydGIiJv1kdSnFI/Oy5dnD8yIXhhkKC/2fQA191VKVZ4?=
 =?us-ascii?Q?NTGfmHWMWl4tPj7iL6Lu0uQ1I8iPd9Lrbw7FV+MXQ8u9szjscI8qoOsnbgQX?=
 =?us-ascii?Q?XgGyaXUbOq89WwhgCDmtf5KTAB0X7dJdSmPI+xT9BXiE2i+d2sgazdRVjtsD?=
 =?us-ascii?Q?96apaEDp50JRVmAynINuAdbDcJT+3UUKWLq3DD6PxFILzGMZrNkJYX0wGZnL?=
 =?us-ascii?Q?kK7Q3lPD8IgEZVR49Q1Y0wZlw32grzKZyDrpExA4Wk+PQjFn2uSDGYseJeBI?=
 =?us-ascii?Q?cro/YEypbe+2Az1G6CtjXjfV1muDH3352jqHBzAM6d3igx5WqT+HGLVnKqz9?=
 =?us-ascii?Q?V0Tt2cNT3ZHH9tTGXPWNg+9czg6HgbY7OPyR+LV5EXB6UKgX36sCUepb5FQb?=
 =?us-ascii?Q?tYWxA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0022;6:tiWWXYhvdvYyk2c8RiA4b0ARgTa9yj8kHC8QmKuOp3y3uS40MqdmGLrNiDa0clNezoRqqY7qE9plL1Jaa0/i3lUyWQ3ZCIqa/4A9R/L1Y2UOFLJK3KGxlI7iKBcq7K+TzOaEjbKRFxdRH4wHbos5w9PDmbDZvg5G+fOM5VC26HXCo4tNdBWy4zQh+8IHTlZu3n3Jjfnd6q14B+sXDloaOXVOeIo53jDtTzxW4aRYoHwVzbqguZy8GoWqZ/9OPKXeMwD6se61SCgu60FSR3eI/PV61rVpisfqM6qDXV8REok40AFmh4AhsOFh3TMhb0RKtDmFtJk9j0DCp3HqS7l7cF0G/jV2MtXKFWPk1+gSqco=;5:tnO3svOwINV4C/V3OmQdpg5f1TVwXb41z9hclGuNGFxdQPiV1Vm1oNhMaGh2i8UL1EOipMJr1XUaJCKuTQfDmDHPj89M8KZNm0Ajt4CKktV/K0Jy1qsJIlroF2gQIKMfGH52sLzEVHHJNWPD4bOluLroVfSmv7mUE0D0pnMqoGI=;24:9e2oF7fF9JjGJO8zMOTvmBTRjDEAWbfQ1UO/3ecf70baIEkAZtkwHCM79B8TSD8V3SdwGhWzEzTO9PXkn1TP/th/vHvH9BqBE+tgQJHp9cI=;7:03aW007SBpq+69G6U/zIjqoMxBahVhER9P/FZ/GA8LU9q1UgsGqtLHI/oYR8FOqSrLXdOtirMv++tfw53NHZC/QYW7mC1x1hlC2eOTNcRfwhfIVxtrLiLtaJ9pxZqCG0HdLk20VKwEH30D8LRcSlQ4obZb/yD9lJD+Q0YHG/MCuFGMybrlvg6U9PSIcFLL6tc2WfcFHc+nYFNJ+4S+BW4gu7+hFQPOeKLvKpACGDI/DafLl24UbHAv0DXyUevFoy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2018 15:24:46.9993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae667b20-7fe6-4574-0b11-08d56019f1ba
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0022
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
2.16.0

