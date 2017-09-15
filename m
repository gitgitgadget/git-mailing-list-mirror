Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5287B20281
	for <e@80x24.org>; Fri, 15 Sep 2017 16:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751407AbdIOQ61 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 12:58:27 -0400
Received: from mail-sn1nam02on0121.outbound.protection.outlook.com ([104.47.36.121]:18560
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751369AbdIOQ6V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 12:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ydoM5Zd80sTUumgPxMs/bwoeFgj1sBhMsl7FcnlNWAw=;
 b=FvmlgO5yRlTaIQn+APDzzzlUO9fn/s88Sfp5k4a2Sj8z+qNJLSd2ohc4o/wnsz6yEbK8NSZh4FvwLn2wss7utnXlX93Ufn/HCAB05el0vuWSmEfMTDGuy/mgw8/7aNZdzt7ItbzIF+Ba4QyT3det7FSgfr5u7PgigpwhjmWAAho=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 BY2PR21MB0082.namprd21.prod.outlook.com (10.162.78.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.77.4; Fri, 15 Sep 2017 16:58:16 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, git@jeffhostetler.com,
        kewillf@microsoft.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 3/3] sha1_name: Parse less while finding common prefix
Date:   Fri, 15 Sep 2017 12:57:50 -0400
Message-Id: <20170915165750.198201-4-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1.538.g56ec8fc98.dirty
In-Reply-To: <20170915165750.198201-1-dstolee@microsoft.com>
References: <20170915165750.198201-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1::2e]
X-ClientProxiedBy: SN4PR0501CA0038.namprd05.prod.outlook.com (10.167.112.143)
 To BY2PR21MB0082.namprd21.prod.outlook.com (10.162.78.14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0115be5-2901-4cc7-43d4-08d4fc5af63c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:BY2PR21MB0082;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR21MB0082;3:mAmUdTFGmPPanbswi3nn4K/lFdaUCzzsPe8CpRslBehk776xhwIKNfiTD1f2tuXm/Oyedh8IsOdcTtgXxC2bg4b6GEa0GkpZXycnTHu1C1Lw/BRTkYxJVozppUw8DcGunyIlBB8BNU8pTxUzVJoK56kbjeDWYqRX/laeix1GGO+Jkk4fJo8UA7xArQ8iqubEJWlZiC86R0CMu3bhHC8LAA3neSp9V9h+hPFCJQNcvtEJS4+0zD9uZ9aNcX4H6rJz;25:G2PyTYcyXUkaAUPTS91r0RKBGZ/rXihTcAAXrTomRuYpBijgksKeE3sRxVnHtsb8k9Az1BrxTgq5n0+IJtrH77QYO6mKGDWajzCprhnrwSD4tBv8d27/9gk+VoX2Qr2qJDkvaEqY/uLKyP3KM5zuVqzEHHLRYha4e0RNWdYRmTb5eRQ768gocLTJFlayeKtBIuEnDmquN6DAX8jOaNwqEuNgC4ggmcK6M8QbE8VqYZQnajSrY8kmCnkjguZpb0fv9bLYZSCcY3R23EVheNvplIFKYSYiKXjfTtf0nvcx2yuHXrgEjJ8ObSnu5hYJHyPU81zYnpbFIknBQnu3c2ZOdA==;31:/h0qFtaMymOKVG7QRwzT6uO7ZoXaMXx0U+nv/LpHgQNukEa8RYnDrzhp+DQ2v7epS2HzEdBJiZ6wU4Xrg7j7aDfd+Lc9Z7IRgvbpHlD/Sdpp5Hi1NT6RBp22ky7f4KT5gv61ZQjkIkZzv8BL6I0Zyj1iAPna5DOEMHuEMcnSwFuMT2lSgKQXGAp3dtTtl/HOciXgSHydC+bYv9eM5qkg+Cu9d6QUx9vtoaDZcmr/6AQ=
X-MS-TrafficTypeDiagnostic: BY2PR21MB0082:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BY2PR21MB0082;20:E5PgSOFLHJTDKcq6gTFh4DJFgEkZ3aDDH2TPvd91y9U+KBMMKJzfQtye+7NTL0Ahe1g3IRIogob0DFPBUnd0oRe9g2Ep1oCxH/M5MKDfMFLIvIoALmzlDZR0CYsC2YLAqGEXFODQe+6qR50DkluN3YENuX3Svx3CbznU3C9WWdiW7PZ8ZUy05Zt7VPdi8S55ACak1ld5WO2ygXfJPX4mVZdauLDIOQlKMgTGOTVB3CFjFoKTayD41gF37YX2PomN5MiBK1wYzFxJ3f/Umr2RW8kxmtnK+TTOlujnU/Xf+1HTQ66jBh3SEvs4q5xb6HaA3QZMsRt2dX1YsCHe1WPLlGu0PACZrQgsluZYYGZpNb7JvHQT7dUEptQ+HzYfOn16wJzud4jsuamQmAeJXTDol0HtfC08WKTDDJHoc5LBfyePuHF1MpC1+aXSVSsLkHkRohzOwFQGVe9t+ePhnQ96/u7h3uoC1wXFRiwBLOGQrxCITCzblQ2CAayX6hMbxnh2;4:GvZbmYSCbtkD0GgYzPNb69q/dOb1RoM9DSjzGOcI1F/MzWbp/ooIIfQFQl3upsU9oyBTJ5cHb/9x1+VADOZcqnARqN+fYOyla7q+4dMorw3IbR9AJUNTb04rPNHiS/SaylNePn2x+IiNik/fpxBqf8URsAj57Wm+KpQWHT0TE8SRlpjDFnruU+iaukSQYQ4KmNZb/pFS87kAazfi5Aui2i79os7jKzHsCh7l0K6h3DC4meT9yCpihN9y3FQv/9RlLOZv13gXHdaEoVWjYT+6zIENwF/L/gpNk090j5ogtaY=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <BY2PR21MB0082A0292F369A717697AAD7A16C0@BY2PR21MB0082.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(100000703101)(100105400095)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123555025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BY2PR21MB0082;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BY2PR21MB0082;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(376002)(346002)(47760400005)(199003)(189002)(8676002)(5660300001)(81166006)(81156014)(7736002)(50226002)(305945005)(68736007)(47776003)(8936002)(101416001)(189998001)(76176999)(50986999)(86362001)(86612001)(48376002)(50466002)(2906002)(36756003)(105586002)(106356001)(2361001)(2351001)(33646002)(1076002)(4326008)(53936002)(25786009)(110136004)(107886003)(5003940100001)(6486002)(10290500003)(6116002)(478600001)(316002)(6666003)(10090500001)(97736004)(2950100002)(16586007)(6916009)(22452003)(8666007);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR21MB0082;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR21MB0082;23:/YgKE+xQSUzdz1FM2L3ssmEC3YcltoSM3ZZTviTXU?=
 =?us-ascii?Q?oDcnKsAEcBNfHGDahXbnQKu2nkjOWBTLVcplKHmnCVDTws7lOK405SD98cnn?=
 =?us-ascii?Q?BlJB67x1iQ4nScY2PkM/xCKbA5sc2qrZWcnQRUJiF70cpi24zU5fFG3vpf/V?=
 =?us-ascii?Q?Iu1AWdECdBNAZZfF0SrzvC1fgRATKSGnGR9JVPzo7LcORSSef6apbEXWeJ8G?=
 =?us-ascii?Q?3mlf3o/D8OAusdppGBiqqza4+l0NoiEs2KwmFIX9RmY7JZfq0pZAfexFDqTw?=
 =?us-ascii?Q?OEKPnSdEs5vXeY2Qwq4b9f8XAW4BY/6axplKfdQ2Ccdo9jDuwyfICJsB/Qob?=
 =?us-ascii?Q?EyViEQTYgLTXVjOReyMldY7A0Z9+YGnAMeRlFSN64XTpXnHUhB8b36fXUkmz?=
 =?us-ascii?Q?o/fvZR4FAg9AV8jmOFtbvZ1J0zpBYJYxBmMXtItZPT1cJKTPzKQCW3Pr8vns?=
 =?us-ascii?Q?AeU4ftnYyQRRe0tvexov0OXX03x4BrxR3LVDNHJ/S1J3SrWpNuTNLkYpCSvc?=
 =?us-ascii?Q?9aj2aHRpV0SoeC+cpXKSrFyo2p631oC5xH+wMiSnvRXdOi9Z9wvgb4NXw9LG?=
 =?us-ascii?Q?tWpe1Iq+gtsilrtTN/8Ymhn+LVXW4sqwJ892sFrsdlkCmlh8KZyu3bB0nMTb?=
 =?us-ascii?Q?AjLLpcnxFfxBdAdROsybJ4+KmXXI7pbMfUodIPi1WtSLEHZeoICApK8s8RF9?=
 =?us-ascii?Q?PRI/rRnz69gDJOuuDCfyYeV8cE5J1p7BBWjrGrvLaFAhtJeXrrFSUL7mcS+S?=
 =?us-ascii?Q?jnm91logSL3MXIy8kX0YO5MzJeumM1ic5QsRzjIhlZl4zqlKdOc8VSAnzg66?=
 =?us-ascii?Q?Oz5fAPVqYjm2xOF1kGezNUykaeccVy/OzjGuNVv8SWuVa2xJ/0O0jn0Ggmp0?=
 =?us-ascii?Q?m+HrX8RD/IdbtoGj///PIasAMKkkHUt148mTv7/nkacXbdzYdtjL60tlmSgj?=
 =?us-ascii?Q?nanrGiQla3P8LrRnx44CU45HBrbCpoC9+W8F/YwHDRMYi/HXkBBBPzXHrkKE?=
 =?us-ascii?Q?Dy94GYARXdaKXqDzfik4bVnP2nrX5SpA3AJ89od/jHUhZM8Zn7s2e19qfxyX?=
 =?us-ascii?Q?znKdBpwObN6nzo5xGpGbEGG/3eH+Iswk1qI1thpiYPOFM0FxRHBUAWMsvXAO?=
 =?us-ascii?Q?dWG4+urnjfu1rn4Wen0GGafp/cUkSUgDOPwImUEeiGI3KNltJ0p+ZINxlxtf?=
 =?us-ascii?Q?DgsNj1Mh6KOiV2S7sUTTuQZLwT3PEjH9nJLz8bdzX1gV0FXdYJzprqLOw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR21MB0082;6:UvL55qM5PdAMbZV0FVIZ5ReSIoOupIkcIiN6uleTUA8/TxdbbeR55i1hjPdLfdTvMN+/odKWOsYg6WVNSHNavJcLbBE3WpY6aFjHAROx87lZ6BnSmarsGO4QOOtXV8VXSptSbxftyLWwvdPTIW9ZZ+y7yWihxTsBrqtHHZ1SaM4L+gZzrUf2KVwZ1VcmhQIyfPS4goHbDDtO89eMjNu10aJUh/38/QW4DlJIS95M38PswewKcDrxGr4ZAXdP/oBbKU9/TNNW6dwhuutRSuS4Ci57WJDJ2tM4nV6Q+CxxYcvmCMR5bxVllu3JFMMImC8m9XSeoyg54PgrFmgnmWlLnw==;5:zh2GzBPtReYszSxRVoMHfmD6kyNJM/CWDkW+IJZ5FJEBKJOpuv86XBN1Ndob1QGF3UcYbEB196Yu0s5hQwdaL0En4zAu+aSEtcapA+6xsP2dwS3AfDBPxoiNes9rtU66W/Dup/YIC6huna8IfVFGyw==;24:ohckdyHCCZml+8Y6Qs9BIbu3oG5Y7bh1ZXtYjOoBMCacwCg4tumAHg46K6HruSuAqOZo7jDXhZK/AwckJ2I04rpM/ZjZ92yC/n10gRtdGs8=;7:l0Hr/jK9K4ci6mjcdIjWTXJ6aabeV8/4JKQLODPwxabhoWdOEJw8T1sLMRXCfOGYTz6EBhHuapM1Y4S8CD/UB45V8b4wzyLDD+tLse2IjfMZlj7uK0mwuxgpYXrEk0LhQas2v/SGQZGUQh5csZabxC0MEKCXaIzOSdbUlkknuN8bt6j7IZnXS+jo+tGbU8uxPBW0i5Jbf+A5lPScvQ6ZD8O1SDuIjLTtw0kX474gTMc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 16:58:16.6670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR21MB0082
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create get_hex_char_from_oid() to parse oids one hex character at a
time. This prevents unnecessary copying of hex characters in
extend_abbrev_len() when finding the length of a common prefix.

This change decreases the time to run test-abbrev by up to 40% on
large repos.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sha1_name.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index f2a1ebe49..bb47b6702 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -480,13 +480,22 @@ struct min_abbrev_data {
 	char *hex;
 };
 
+static inline char get_hex_char_from_oid(const struct object_id *oid, int i)
+{
+	static const char hex[] = "0123456789abcdef";
+
+	if ((i & 1) == 0)
+		return hex[oid->hash[i >> 1] >> 4];
+	else
+		return hex[oid->hash[i >> 1] & 0xf];
+}
+
 static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
 {
 	struct min_abbrev_data *mad = cb_data;
 
-	char *hex = oid_to_hex(oid);
 	unsigned int i = mad->init_len;
-	while (mad->hex[i] && mad->hex[i] == hex[i])
+	while (mad->hex[i] && mad->hex[i] == get_hex_char_from_oid(oid, i))
 		i++;
 
 	if (i < GIT_MAX_RAWSZ && i >= mad->cur_len)
-- 
2.14.1.538.g56ec8fc98.dirty

