Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E6881F404
	for <e@80x24.org>; Thu, 15 Feb 2018 18:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163675AbeBOP1x (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 10:27:53 -0500
Received: from mail-by2nam01on0096.outbound.protection.outlook.com ([104.47.34.96]:49632
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163662AbeBOP1p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 10:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vdsIZTE/RwjMxlSiA4ULsptZsQzqibKcBmUAQeepFSE=;
 b=n6zdQBrrDyJNak1dCtYjjDNXL+RjrQLKB5mfDsXAxlIUbBP4z/76ZHl0S7xGD/mCJFN/482r63VDfuV9jzodFSNwISOw4+FUpmJQ0+S75ccpfJkUk1AAiWfwbm4wFe0kiJeHkoiGwJDqSokZV14MMDJJSD3tn1SdZ3WdihJaXHs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM (129.75.91.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.464.14; Thu, 15 Feb 2018 15:27:37 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v7 6/7] convert: add tracing for 'working-tree-encoding' attribute
Date:   Thu, 15 Feb 2018 16:27:10 +0100
Message-Id: <20180215152711.158-7-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215152711.158-1-lars.schneider@autodesk.com>
References: <20180215152711.158-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [62.159.156.210]
X-ClientProxiedBy: DM3PR12CA0049.namprd12.prod.outlook.com (10.161.151.17) To
 BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM (129.75.91.27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2c1af903-98ea-4c7a-1f2b-08d57488a674
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:BN6P136MB0020;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;3:HMhjJgNZM3YxpDbgas5iujkApMiUZfEbIqHGAHtvJt4VeECFo8xVfc5deyDbT0Dqa4zXZrs3QQ4AnhG71SjPNeu8SAWpqaOmEGiS5QyMR1Vb76On9uL4k3226lS0A/gigyDshf/YTbQT97L54DIPmFC3RltIG59S4ykfQGG/E2QBiJzTvjwpmdw6RvTlXSPh84EfhVlguIJBGewj8IjWR4WAtltqN8hVxgAnNJLPi27ZYeqv66LxMENZhehx710v;25:vBq+XCJSf9ymX4ugqzx3vVac/bXSu/b3E8WPHKJySpFYNIKgzEhWtIWgZg9SmH7oBYvBme/4qTl6SzY1mh8HyUdyNp+HG3AalOZ4BksQuN3Oi0tWECdFcWYWs0FrdwB5ckhdgLfbDIDUDQZgjOLKioW7kTBu1DUk/dJBTfD/8UcJlBQH/tHnEkSRTORtQvys8cD+rXERHhrQA0tXq7H8puOmf7J+j2GfCY4fsf3CelUCzDXaUBCzCGgj1+6paKFjb3cAWMAxd3AOR5i4mSSquAXBtPPexfOZ5UPZtkWrBad+mtNGtv1LJuznW3KKuU5FEGi9pj9Rnk7hn4/ywqwl6g==;31:DqoeSWnhdiA/6w7OIMIavueTyTKnECdR45WlZ9uWzkxLfJ4/iIml5bgd0EdkEtlUiKwALoj72E/uTIoJJoeON/hScScijKkTnJltlgQFg8w9GtL7Zn0DQ3OhlSjQM432Kgun6MA2eotURoHwGc5/0BOeBrPbbkeJLKH2NBfVfRdOypOlRio4tEAHTwTL9YRU0f2xIn+U1CX6xffIl73Pi8BCa7gE0hN43fuPBYD5vns=
X-MS-TrafficTypeDiagnostic: BN6P136MB0020:
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;20:/m0UAM62o6S4WXVEoMutFFT6/36s1OIDnR7sEqaD/dh8afXQ8NbwoeeCKykC0Fnv6ROazz3T31x931e6eO8BxX5pD4gq1xiRSRzKIKbTen4W8R6O0K9oyYGzYEH9URhcooelHc/ur7rB1jSD1q9Q0Z6Ytt4lfiQlKtkiXOVlkR+IQvqknHD/OYdOa5RRKxCW6HP1bRXeyvyK2121lSHrKwA6nyk9KwBjpGMUnra+LwlVicVhVLAFubBV1I3wdmpSae41UszuqS/mDzHkwbINRMclaAzcA6dEHe5G+P/egF+6S37yiaQldGjZ7BC86dfu0CfYOG3gkhcGJQ1FcHluPRK1MYuIYmjTy829RSY0bc9kEXiUlQfyHKXDn8ne1imluhuDrAgyKWv5VCyd7PdZJXfBw4hPFImJydgGa+iHHSl5NsjM7zZX+fYtNSOhmCNlNkbe37bpgndpgw4DXOQFVEMWfTSgUep+5eV2clgIP83foNP+ZguXchSgQes+IlZtr2skJ8AfCXDX2Q0hm10/74ZgPcmNImhkTzrs5rHuwev4H6YCwAkJSj3nqPNdoJRuOQmnoFWeMPbZ6B6mLyu5jlYhls83+0lst/haaN1Okm0=;4:JC+u5ogq+o9lH+urIvlBuqUkpWq002a+uk9leFXKRGphoIO8ai1ZEp1KGj84RLm1EJA9Riri+reXaKE7/gqoWWgA1ZLleLirLWSfowN/mgG4702jfDJlF0v0T1WxfIdYZ0OQXANtCCjYxAmiMxpmBH9A7smRHf+swBGVmKaIl7Nif/K1fi1DYmHm/SvDlKMpp+Y5INxE9PpHvGkIh3PVKanEhDpyJkSGDtz5wNFc6QgFskCI27yAbJGfg759X0r/Fis4SclJDDinnDm6ywTX2HRNbUOUSq/gOyvQ+EVQCvbDmPgO5+ysqGFDylwkkBMe
X-Microsoft-Antispam-PRVS: <BN6P136MB00209A7BCDF6122E64CB6544E8F40@BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:BN6P136MB0020;BCL:0;PCL:0;RULEID:;SRVR:BN6P136MB0020;
X-Forefront-PRVS: 058441C12A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(81166006)(8666007)(85782001)(186003)(5660300001)(1076002)(6116002)(50226002)(3846002)(86362001)(305945005)(97736004)(106356001)(16526019)(2906002)(478600001)(6916009)(26005)(25786009)(81156014)(105586002)(8936002)(48376002)(5890100001)(47776003)(51416003)(76176011)(2361001)(36756003)(6486002)(66066001)(8656006)(8676002)(68736007)(50466002)(316002)(7736002)(2351001)(7696005)(53936002)(386003)(52116002)(9686003)(6666003)(4326008)(39060400002)(16586007)(2950100002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6P136MB0020;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6P136MB0020;23:K4f60GkwQ8M9KhTsUL5jKFN/kntvYUzGzat+Jky0H?=
 =?us-ascii?Q?5xBJle8nLwC+/qH/BtW0EEZdGzmqIOz7D9/vRu660nBOThj+GbSUcrxjtayN?=
 =?us-ascii?Q?s5N2DF1g8q2a3JP3YqCHGUI6LmHWjbPzKPToK4RlnbTXBq4XdfSA4rLx+/mF?=
 =?us-ascii?Q?g8QPCXOdlsdus3wDY1faTJAjwolsSK4mn/4ui+5JlxVKb89FA+59YknoyyOw?=
 =?us-ascii?Q?OsdMJ6reOuiKUqKCclBnw3tKhYNFWj1Lo8ru8yuRxMgM4kiNvw1ueFoy5wCv?=
 =?us-ascii?Q?nz8RAb9iFGNLnhDvnQkDpmz7qIAiupNZ1JETDVQaQm3QhzTY0ZHROufXRcHO?=
 =?us-ascii?Q?mrhjUgnv/SoZ5FTzJWR4laRX0XovPc4gyxFcRsyQnXS1+3RXywB3ZT2tqNax?=
 =?us-ascii?Q?Ir7Q+xi27VLul4hpDOozyKxeWdJfMkwZUwOYG123ge3Y51A/QPOZ/YEEt1TO?=
 =?us-ascii?Q?mn0b4Xhl/A8MZd9gVVmWsTfoYwxrWwXCdW6i1z9fQj8L2gJ+kMlhtF0f4Afr?=
 =?us-ascii?Q?Uy/VT8Js+5lPgWMDDwcavTygUgkeOwkZJI3hqHX1TV3hChXOy4SoDn92hwOM?=
 =?us-ascii?Q?0jDKRg2OF6BukCkyHcGiLcHnGkBA7lJEMABuze65Z21BrALq214yVomJ+VeX?=
 =?us-ascii?Q?l9LkTujAm0RFP+kHpqfKxzt+6oSLe24DqlTFmhOwIMU+drLpgFd1ROdW1XEC?=
 =?us-ascii?Q?jFzhYoQEwAs9PcLg3dwey83ytQZdJ83RRkGldNgCfwXj+jAZEEcNmQJMCcns?=
 =?us-ascii?Q?bLaY1yXsvwbPWKYmS+JiT2gkZ68ZdxPF/EUOlYgRqzYa43htLxmsMLkVzDlb?=
 =?us-ascii?Q?iD3YwK6zt4GIUOx9AEeBokAnMYNgHNFspxjI1O09grMT56LIr5ichpN/025K?=
 =?us-ascii?Q?jhrg3/ZVtUz63ZBCnb056FXwvuDdedZBhkntLGgftzMiOATXljC6g3r9DDo2?=
 =?us-ascii?Q?FDKs6oe+Y6h7ks5gQ+UcYYnNHutpvWU6nYzk/foMWIMjkUYMvO7ray3oHwaQ?=
 =?us-ascii?Q?1wag2Y8xFQNZh2K8s6uN25AMdxKL35qsUTKgz7bJsry5N8n/WMiq/fMt8w+n?=
 =?us-ascii?Q?fm29BpqVV24BXr1skGkLjZD4JgALsHxJik5zNg74d/1b9GxyAimaZdsR6YW/?=
 =?us-ascii?Q?gQ8BV4PopJTXAnMISgmzTLXsGupq2bYabNzx41VSt1RFicZkz9l9kMgtBYu1?=
 =?us-ascii?Q?1xdhl03E8gZ+ZZhLuYj9O1dQDQ2i3fYwSYqgvWWNrkFlGp7p1NEyQWpH4vlu?=
 =?us-ascii?Q?QrB9GJgfikcx9f2wC+whhHuLSMSkU+5jExCLM0D1qiOLcNpGeJiAJBXEPz7L?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;6:RzqAWRXoDoylb2KqfJQjS2oa2ECTv8hpHshLjwuIedf4nb5ZWX2i6fN5tgjznrQFbaA3WiSHkeFCpI0rW7UwobuRE2ucUpit4pNpO7OfhiErg70j5kljMdxtIXGTs1X6C3NopnyMvrJMlkGv44vm77GmcU5oTr1o2v9gkUQQu9y5vGr+ZlRlliH8hPP2eD0OSk/G5Flrg9fRm3D1Cj76GXEYXVbfoF3hRDtYaesMaBVqbKNaWJNkiSs2bm6YQ8pwz0HRmRyOV1n/plN7AgLTafIOt3AyfScvwGWQEN17OQRKWctPvhw18pOEJ+KXToqR7LDa1+YS/69+0nPq5Q2Arjj0glngKDnUXxVqCuvZprI=;5:/TM9SR4B+JrmdQqORR4QiXv95RY0ABW5PpAQ+/gqv/lOy1lUPIAcCqD3+fsO6nteZs/qvBd2DxUH7f97gWBNRFQiAhr+DGMjy++KirseOPP1Fvkmb99ADCMFDRlGFSElc7C+flX0xSfO52yZlJEO0glBrIipbJq/UYG5SdlBin4=;24:steko73z/FpJpAbfRsUMH+/q11fJBbU4Rp6WHYZvV9A/JhISlqvw/k6YjgFfB4lppojo5iQYw3hyOGZ3N2WzCCxLzIVZn8mRLUub31qcaVY=;7:MFyV2DzjEzwdG4j2dQoaGyb8MvcsV7nFmEqdcBsrIvQXFt8llFz7a/PceJLvmpLhf9ICmqA7ti2XCCgKN5mwcxZ96HJwsg3fcdTf4YaJCDeiMB7fm/FnCZMARfrS5D6x7kqvMBrAThR6DhF66QD/PF4pn48Lojk9BLmOYPmEfRgppi6bzi535gzUJSmIvEUKRCGAPrXB4uHKYMOUB/bwX5IIrGC1pgDYx0D5OA/s89iDSvlQpcDNJk4hBzI1mLdr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2018 15:27:37.9014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1af903-98ea-4c7a-1f2b-08d57488a674
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6P136MB0020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Add the GIT_TRACE_WORKING_TREE_ENCODING environment variable to enable
tracing for content that is reencoded with the 'working-tree-encoding'
attribute. This is useful to debug encoding issues.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c                        | 25 +++++++++++++++++++++++++
 t/t0028-working-tree-encoding.sh |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/convert.c b/convert.c
index d20c341b6d..c4e2fd5fa5 100644
--- a/convert.c
+++ b/convert.c
@@ -266,6 +266,29 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 
 }
 
+static void trace_encoding(const char *context, const char *path,
+			   const char *encoding, const char *buf, size_t len)
+{
+	static struct trace_key coe = TRACE_KEY_INIT(WORKING_TREE_ENCODING);
+	struct strbuf trace = STRBUF_INIT;
+	int i;
+
+	strbuf_addf(&trace, "%s (%s, considered %s):\n", context, path, encoding);
+	for (i = 0; i < len && buf; ++i) {
+		strbuf_addf(
+			&trace,"| \e[2m%2i:\e[0m %2x \e[2m%c\e[0m%c",
+			i,
+			(unsigned char) buf[i],
+			(buf[i] > 32 && buf[i] < 127 ? buf[i] : ' '),
+			((i+1) % 8 && (i+1) < len ? ' ' : '\n')
+		);
+	}
+	strbuf_addchars(&trace, '\n', 1);
+
+	trace_strbuf(&coe, &trace);
+	strbuf_release(&trace);
+}
+
 static struct encoding {
 	const char *name;
 	struct encoding *next;
@@ -325,6 +348,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 			error(error_msg, path, enc->name);
 	}
 
+	trace_encoding("source", path, enc->name, src, src_len);
 	dst = reencode_string_len(src, src_len, default_encoding, enc->name,
 				  &dst_len);
 	if (!dst) {
@@ -340,6 +364,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 		else
 			error(msg, path, enc->name, default_encoding);
 	}
+	trace_encoding("destination", path, default_encoding, dst, dst_len);
 
 	strbuf_attach(buf, dst, dst_len, dst_len + 1);
 	return 1;
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index f9ce3e5ef5..01789ae1b8 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -4,6 +4,8 @@ test_description='working-tree-encoding conversion via gitattributes'
 
 . ./test-lib.sh
 
+GIT_TRACE_WORKING_TREE_ENCODING=1 && export GIT_TRACE_WORKING_TREE_ENCODING
+
 test_expect_success 'setup test repo' '
 	git config core.eol lf &&
 
-- 
2.16.1

