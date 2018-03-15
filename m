Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 748FB1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 22:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932947AbeCOW6f (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 18:58:35 -0400
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:63072
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932670AbeCOW61 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 18:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=s1N/+o8XnmC6CkBrVkzmTpC71HeCld9R3yvhViwz4ok=;
 b=f+P3SB6sPGbPubyvjvrToP8p0nX5f44DWacBkE3Lv5A7ycAUp3BBtcYmwUywywq8O7rtwI2dhCG3XUU8il6keurBqMfPZhhLfFNfGkX006M3Rfb2YTbL9ObHnbXPMHfp5vMv85kGDJRwf+YsQ2uw/FHRC7QshZCAiuXG3b+K3+s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from rem2ua0031cfw.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Thu, 15
 Mar 2018 22:58:22 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v12 09/10] convert: add tracing for 'working-tree-encoding' attribute
Date:   Thu, 15 Mar 2018 23:57:45 +0100
Message-Id: <20180315225746.18119-10-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315225746.18119-1-lars.schneider@autodesk.com>
References: <20180315225746.18119-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO2PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:104:6::21) To MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 13e6ae74-5b87-4fef-18c0-08d58ac84254
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:VJB3xh15mY8t88fNTlxAYdSzoHENVPemO3UDG0MUEblFU4Tr9NBqIoC1tnhQ68Q5iQorrvoABjUqNbH98Ix5fVBDbrgTZLNpBuQeNu2/DYLYDYW0YDxbCy8a9ABw0cJb3bhhVah0RR7t1orAIKVU9mJh2cIrcjkUSiEUf1mpadfQa9GiAVeDzMiTux5ZiLoff5JC6FzeMDYPtPxdTT0rQk8K1Dq0k7SX7ub/eekzVGOgNE1I0wSBvnlErLZ7NZDb;25:k+EgchAPW0n/Im+SD1DL7pEy4b9uiydz0Y9XSYehu0z/k+tbRRzlQ7Y3hKJ6Wo56kHl0mil38+ExUIWEqFtdRNsEM4C0Q8Kcmxlu7yqC1z37xCSxRAkZCA8Rp6L4Dt2gt1MPu5AFh1mMbGMYWNfEUt6eqYU2B04FwO5aPIIJ4/WYdbTtSO6ZKr/L3qazCfXusfMm8kQeMzykhY6gDCBFzAsRKkxheKGTOneHVWuq9VSiAFna6VjQpsJpvYmJDLoZhwEifhJLBMsbvCijk/qBLPn2A/IS4P7yW7KNAgOfvmv7BxKL4q3XcwV7q7BocMuDDWgku7Fr7rnaetVEdnAqEA==;31:C5cskW9LfxyMMP8quo5Hn2NHTOPRXjpKWa5dXTRvRgqNm6ou6FLEhKYNLEVHAMM+WfQ7G0SvLgoY/2PimhK7Xu8zyjDfAWFW/bu+kybF4GIwkor5t8Yqvg4PvZfHu4pffV/axhO7BdvFe7hOoVDYtJtT5cVySlM4TOfF3gom66A8h2SrPpYuhwFe3OkDKRRMOrS7I+8tG2Ex7oNhGVaEj7PvaDZlQx5IOqmLzsVg+04=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:DDZFJ4nYxeo7XzNn7/9IDrRt1ubdZIcvOQrVK5SD4I5NZ/JYpPJwXmioxSM8apcSdz6t9B72uWkxuW8ATy6km+3qIDi51GZQYC3IKYn1m9ahakBGogJlL82FHPlPr06e7g05GSdnQ+JQrgCr2039/oXYnnJPI6UCkfS3AgVAkMtQKtpGZJscJJoSNPuyYDLzq6QCjYJzLQQLXoeOxLOOuwEv5GjLPOpKwTfV7ZY2vkwAo7rd+8pfkvS990e9KuZlQEdYdnNQd5XdPqZZOygp9P1ykpy5oVr9jXjBOi/S2n7wKVR1Y5ercb9WAo/ljwo4Ft9seoIFDx7Cm1rh4Y+R/iZMXXUmb+JL98WYMAr/BaPMWYEh2no1h7TuoZTsCzpBGQw5BMHEknYUMFl1G9pN3iNFfwtZNh2FFrLv/2UWoR3+hlrahxq+GMHDShVnrhj5erycwgIpMlK3kCOmQ5cHc/JvUEZqexZbJg1FuqtvycZoItXhFLD1Hhx8NJlF9k4MF51EM/ZvXCtMYRpwJoJgKRaGwBrbjXoYmeO3iB3gGM0iFxpcb5juaNqPzeCA6j/f4cwJDfyrFBwm62sX686m12S+YzglKnzY7YmQ7qdyLfU=;4:xXa4vP/8kYd/snosLFb5XHO5Cla+xOJsaFqX0GEpR1gxB3rdqiA3cZeoH1z6RPnoFUjfWqBLwKwoq6iy6VHZZBGK0qguVf/kYoG4l5MJVBqz11tVugCu3WR804OtC9uOyGpDl5MboOjC2b/SwagbQdy3vRVfNfWLbI4JaFfhdhFWRHdGdJgv2t9UIkT5ykmZqvcABv7zIqq+Ee6I1NvxMvhkqYJcf4Q71OYXYX3KQ2YfYN052EF7c5IpsfKb23Q1vwUPXftQGmOYqdJMAOXEOCS20GpdQV0PkJ/YOsfjVBlyYztdrXv/sET6HZHSaapq
X-Microsoft-Antispam-PRVS: <MWHP136MB0014848B7A6465F7217E71FDE8D00@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501276)(52105095)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(366004)(346002)(189003)(199004)(85782001)(81166006)(52116002)(53936002)(51416003)(76176011)(1076002)(39060400002)(16586007)(2361001)(8676002)(105586002)(47776003)(6486002)(2906002)(478600001)(106356001)(50226002)(81156014)(2351001)(26005)(4326008)(8936002)(2950100002)(6116002)(68736007)(3846002)(186003)(66066001)(8666007)(25786009)(59450400001)(48376002)(86362001)(386003)(6666003)(36756003)(6916009)(7696005)(5660300001)(97736004)(7736002)(305945005)(7416002)(316002)(16526019)(5890100001)(9686003)(50466002)(8656006)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:rem2ua0031cfw.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:IM/bFiQg+A37FLKIGeNw7K7DQ5+yomoHX6rITCTpD?=
 =?us-ascii?Q?gV8ieehb3TOajb80tOAm8KNkvtrV8ivfXHFKjDfAyTxtd5zwWpZvIUsHF6tg?=
 =?us-ascii?Q?kRMakv48IHXfYQ5c23tyvxnOIhuXFbuF2qrsnxbyvDxr2co1Mw3/YBeLtREY?=
 =?us-ascii?Q?YU94Jr1GtB3yXUGY2icv94dGNb7s/Qa7+VDoNBwCL0Wv/H6tpv2SmKj49MmK?=
 =?us-ascii?Q?ntIeSyvFzz3qQfqzPkgolOc0s35UxrqqBu8NUgo6iRu5+0RzW+KO/0xnm5yu?=
 =?us-ascii?Q?AjoOWNszlFADjJX3juSheUguSC3sE1tIzzMEL49Fu8qCL2xOD6Nzt/6VAdvv?=
 =?us-ascii?Q?8E5sdEpFnDRBBGNZyH2YdWSnES0DxM9rjdolMiAZmwe7kSi4l7KFp8aGbg1b?=
 =?us-ascii?Q?J1tbDkJcbIjz1nXHpblHIM1lDbFpnvH/f0crGPRhbxwtsOArUTN4em9J/k7K?=
 =?us-ascii?Q?U1gPOtabTDw1uwlCJpc3NEY9+qm46Sz2kYOg1czvIm58czZVGLwRpVScYoqF?=
 =?us-ascii?Q?SLQD/Y+U8rjKb67u22Si51dSk0bJ+w2bNhgK3+iryqJuMEh2GC+lfSIzJTtK?=
 =?us-ascii?Q?FjPMZ9qoHyCf/TH4iWItipfN8OA5mGl9ar102t+zWs5A2Y6DXYPvtIFkwHG0?=
 =?us-ascii?Q?ybp3cjaZzbVMrUtqow7WwsqUbaX0IZcpayFTc2Piqd74iRjklQwdK19hSPBK?=
 =?us-ascii?Q?YHYVdSgMgx+YKWfEfWTzf4JJuZFkC8MTckMSBRu/o7ASB+Iq8wKFE4liXIk/?=
 =?us-ascii?Q?vcIbPpcH0bsW22UvRE902+HwvN/oqsanqseBN051uL6u0K1iUfUXDwy9uIvY?=
 =?us-ascii?Q?goL+6E8zXRGhjj28RYK5priXczMApvJelyLll2m2KYfWavVe8fedBYfZL35M?=
 =?us-ascii?Q?F2A/r+qhh36DKqUtmaDXovEL+jjFFt2QXCrZusAV70D+BXFbjmdXwJuEdzqq?=
 =?us-ascii?Q?8FdPNHsiuezwjPRuUJtgvK5RmDMo8TsTuUfHLg1B8s1HclW++ybJOUEf5YCA?=
 =?us-ascii?Q?4UkyM9nibb7xiYnxwMSgmAewFlYI3pEkYilrtINrtx2ia+y1WC8D07SUsm9o?=
 =?us-ascii?Q?xzp736a0hgDC3PZNwJ2NrzwYekImbc1IIIwTVVCvOC1NYxJqaCGSlIy+cEfa?=
 =?us-ascii?Q?6oGfDNKmSZJFKy5PvIE/3+fsh/juo5fPrwZQcuQ54wgTOMbD3qfQ/UnjaoQS?=
 =?us-ascii?Q?zGbkJxtdCmrlcPoKeyHzkwOQa37FhFVQjpZeYLAMi16XLuu09fsKILHUi4Ai?=
 =?us-ascii?Q?bWwcvVypM3RcKYdYivutGu5IXPC4ORAcj1kUKknhUgtOkPpbhm3GorAhtDk6?=
 =?us-ascii?Q?CtGvI5ttpVXbQQ9ElVJHDj8HewnErrnGDjIW2mgSkDu?=
X-Microsoft-Antispam-Message-Info: aZy+oVorLKHhWMZoh6n1GDnDLxIKg7uSucH5Y7C555fHlU08MpWr40L2oKstFpVurOgjHSzd8RkRIWeOkhF58YbO8vKC+q8N3+8TEB+tgPEu6BASH0nM3BU6DpyfWjex5j/fu6pGs1NlfFB9iVbv99208qgygfQ/FAlmB2jg2aumQayOhMZy1hwUxYEaDgll
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:Q/BjDcGend8hY+3sBi1KBQFA8uFqdQDK5gUDH5h5DdnitxPDCkzHumPPozqx5fbwdmLJVYEaJ0bf+/6s+sM5RDwYwQM+IZZOl3toqf7cHQk81yQVWCCvb4DumWjak91Pa9OCyqOGAwBAgfjkAVfAahYEeoyl548mF7JKsgDOqWGGFO+9SYNc8/4kpaxzNwRc8yiRbZkeAidSAjn73/aEZBxmck6+//esftBhnFoXv2jmY6oETMRw4xNjFeq1IE3rXfGwf2viqJPGUb0G5ySUB0UBQY9ZPJtHJhe5h0qM7FNybgDIBREHWlhLHZKjMsJbtViN/LekerD+4Th8AxSDy8JYQ3W2IEZlocW6ybcYuDU=;5:uOc9RAZ1vvhc3aGAx98kRnSQRTWYQ3TUqIQXjEGevMR0fCpwyrn/Ckou3ZN0JHj3+u8DNSm2h9u4qNE90F/yvItV6WsUjoNN8SwzsKeAk0fi0uwxvKQNzEHl0ss9PznlImeckP7DxduYHum4OMGTAohMi/p1JCLMB0bnDsJuS0c=;24:/Qvven5HihPZ7NWtUC5P0HS8mOnXGOcll75bcv8+BGtuY1s62cBVFCdmGJT7m+VLngnNALWgcywIjS5d4gee0+CpEwQwAwUL4alC2Ro/l14=;7:DPhYvoi9MHVlctQ4NmNsTGDLRN/3RwQHNySzJLQbTB6qkNbl05Uix4QO15YXJm7NuoVgjN0hPkgTY7Po1T7P4NJFT5X7SXQhs9iSzqDKBjfI0YKWipueFRIQRMQnNQpdgl8Eikk+SVfVwst+DJAAZm67F/ognhlPW4pDILk3fZduXLZ9k+PRrj/2abGoy+MixwpxME6/vPMHjX3rARNzd02E9mQA95djmdh4XjUSZPmyDIK1YcinZiXY+OREGfAX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 22:58:22.8224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e6ae74-5b87-4fef-18c0-08d58ac84254
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0014
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
index 3cab4fa907..ba6f2019a3 100644
--- a/convert.c
+++ b/convert.c
@@ -324,6 +324,29 @@ static int validate_encoding(const char *path, const char *enc,
 	return 0;
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
 static const char *default_encoding = "UTF-8";
 
 static int encode_to_git(const char *path, const char *src, size_t src_len,
@@ -352,6 +375,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 	if (validate_encoding(path, enc, src, src_len, die_on_error))
 		return 0;
 
+	trace_encoding("source", path, enc, src, src_len);
 	dst = reencode_string_len(src, src_len, default_encoding, enc,
 				  &dst_len);
 	if (!dst) {
@@ -369,6 +393,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 			return 0;
 		}
 	}
+	trace_encoding("destination", path, default_encoding, dst, dst_len);
 
 	strbuf_attach(buf, dst, dst_len, dst_len + 1);
 	return 1;
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 1bb528b339..2ff7541b34 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -4,6 +4,8 @@ test_description='working-tree-encoding conversion via gitattributes'
 
 . ./test-lib.sh
 
+GIT_TRACE_WORKING_TREE_ENCODING=1 && export GIT_TRACE_WORKING_TREE_ENCODING
+
 test_expect_success 'setup test files' '
 	git config core.eol lf &&
 
-- 
2.16.2

