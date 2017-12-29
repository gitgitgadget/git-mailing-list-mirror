Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29B721F404
	for <e@80x24.org>; Fri, 29 Dec 2017 15:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbdL2PW5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 10:22:57 -0500
Received: from mail-dm3nam03on0112.outbound.protection.outlook.com ([104.47.41.112]:7200
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750869AbdL2PWu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 10:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=cu/WxgZu4A+kbGJBzuJagzqbpv+o3LxxVkud7Wjcj/o=;
 b=ib3EY4B0BJWBVRccL7JmWpn/PTO6StyNvg4kWE8kQ0AM3/1gvs27LFex4pcRURj3SnpWS9ug9RknFFAi+GvZbKArgVh8OnG2F1apCtB9Ek/ofy06WLtjoJE2LAEdMjEdYxyxyYTkoWGK4EXWmSQ1uZ/LtXbhg/Qp5DI3yC3KD1w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxBook4.fritz.box (93.219.84.3) by
 BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM (129.75.91.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.345.17; Fri, 29 Dec 2017 15:22:46 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v2 5/5] convert: add tracing for checkout-encoding
Date:   Fri, 29 Dec 2017 16:22:22 +0100
Message-Id: <20171229152222.39680-6-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171229152222.39680-1-lars.schneider@autodesk.com>
References: <20171229152222.39680-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [93.219.84.3]
X-ClientProxiedBy: AM5PR0502CA0001.eurprd05.prod.outlook.com (10.175.37.139)
 To BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM (129.75.91.24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fd796a7e-bbff-4dd8-0793-08d54ed004ad
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060);SRVR:BN6P136MB0017;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;3:c8TYJ24oJXGaJfstyCh1+N7uQvN8hKytLxwd2EWowKmCN1K7uYe0Crl7bm/+PlEWfggEhlhGVhH1DUAoRE2y8q+hRq6qQ4VUK2lvWEIyyZt5dMLDX5OGzfdTNl02WYebY+fqXV4IpCcz+B7jC+/XJosoUp8iWw7GyIDZLfRtlYHV0YsEOAAOgSeszjkvC0LSdbewiPV4JTyQw6OydcGLRSd0TCZDnusvLA2IoMDEoQXmMWhdU2VIe0Z8eQc4IylX;25:yfLQc6vf6q3mETgkcfNdp2Qw/dY4ajfVUD+35yWbhYTQjqXE5FaJXTpibmQ8JHW3fHeZPMk2TOOfBYcq3hLMamEAYn+ffAqqpH81kg1t/xsoFRFsFCQ+rzwzFQ0yoavQCb69wMQ26HLImq2Ro0+Kb5NTJnJqF6WLHfclPv32/wWRVeod/G7ALhq4vDwyKLhh0MySZALidErfQvSbsHXff4obnqp3X+h4LwKTPpdEABpJbojv1JNXI1G/bdaiJFTzl+5RrHZxMzTb2GEThIkKDLXL2+OmujQ1qZBwk6B7T6q5DiYWrsh0DgFOIhJ5IPRjTQ92eZU1Xibuvz6LBYuBBQ==;31:yjJBaWSF6aV2+ihRA3K2d6AhmPXYB9PV/dfgP96k2Tb7Vl93MNENP4YOibpaquiffD4GSeoWXjE+IAada9t5bWKY7Fhj/2vh9QkDaIgA7e9Hj318DJP8OTrcYb21pfb4NEnNjVVsSA82amGLuKzdBmQLKYirsKZAI+rfJi1R24efqpS8/iLzstbJ9JBugIg7k/iI0iFlP8GEoYYyw2Gcn/alxEgMjKklrgm7dPW6u+Y=
X-MS-TrafficTypeDiagnostic: BN6P136MB0017:
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;20:mU2CmJeA0MzOrZ7EKz51xeiKxIjhiYFdPFvHVRpTjotgvows5Kbr9U7n1NQTOFxjRSEh4wJhXJ60hcKu6GuKlQcActZOwwLyjpi06Fnn76VXWJuIwXqnU0DmovOhCdsEEyci6qlvplyjHby+jGCva96hbrprnhapNO70NJvU5Xiwij7Gcss1Zxno6xh/nGg4IEFhYVxpdJiyU2N5SuhL1JGiOOxPz2xDZpmHgURfdty+kgWBvLrlYjznvQ28zaEiD1V6lh4ABuCklJs5xLQzOX56+xNXZ+dJKH0xwBcjGJSezs0lVBiEidN9F51gPsNfMKgfoN996KTHiZTmeWzMajjY6il6z20/hz5IgmhZQE5L2D0MmTWCBx2crpUxeMDLyu+nIwzVR/F/jrI5ykpLwg98DNyFwYy5e8FGuIsFD6uAiv36m9bkD4Z7My121AF5KfcyFQZm4c4X+8PuUFuFk7Jq3cqgA4+dZbAOkQfYMWjrodkV2UaGUQXII46VKZXOALePzzoDYk1nSPSozIBmE85vpAo+F1wJPXXT/jZIbJ2vba5bYS8rY9HfSdD1uRKDBMpZSqQRx/4FJ4/C2ktyhNPzysvB35IaRaLz3ejylU4=;4:rxNDW1dEZ2TuHIAIBfyqCyq2fPvXUqgzm9juWfwfE97qS5UEQgl5sAeNlpvQJA/HWjIKPgutbNBxHCj8bEsJ2LV/9smbm7o9MAwBIcuFoyrj0FesNUGg+UuTRdjllm0wgO/Ko42hgTRqOUkeVW3KAYIwK+o6557zIV7cKZawqF1tvF8aazh4V7pVoKkD/rQDK8KhkZnaOWjCI7Cf/mYV22HdJ5Jxve3lLW4huqY4e6Y0qK4gzvE8uh8rJAoWzPSiZqBc9sSAlZVKLjF0MEUKtQ==
X-Microsoft-Antispam-PRVS: <BN6P136MB0017D9A2AEBD7CBB75F322F0E8050@BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040470)(2401047)(5005006)(8121501046)(3231023)(944501075)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041268)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6P136MB0017;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:BN6P136MB0017;
X-Forefront-PRVS: 0536638EAC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(346002)(366004)(376002)(189003)(199004)(16526018)(4326008)(6666003)(2950100002)(478600001)(6916009)(9686003)(53936002)(16586007)(6512007)(316002)(6506007)(68736007)(386003)(86362001)(8676002)(5660300001)(36756003)(81156014)(76176011)(81166006)(39060400002)(8656006)(33896004)(25786009)(51416003)(53416004)(52116002)(6486002)(50226002)(3846002)(66066001)(7736002)(48376002)(2906002)(1076002)(105586002)(50466002)(69596002)(97736004)(85782001)(106356001)(2361001)(8936002)(47776003)(2351001)(6116002)(305945005)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6P136MB0017;H:slxBook4.fritz.box;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6P136MB0017;23:QwYq1QN164oaIJbTeXXv/4TZqmf7pbtzayx+jItiT?=
 =?us-ascii?Q?EjSyabqBYL7Cno9+pISXNQRrHqIAktl1WDq+Wq7vcZfqRmUtrpXQeOKc1y75?=
 =?us-ascii?Q?rM8hGc271g4evexVk5cilZ/yRaES6c8vHmb3IxrW63I1jDOWd3EKVloh8n1W?=
 =?us-ascii?Q?dDGExZwHsMJKJTIwqkZbGK9X8Exr4tukpWXxcg5GcIgee/IkMBZg4GRPtQRV?=
 =?us-ascii?Q?IWyxl8tPHpYgKJxNK+9NlAYcULDPLvi6oVk5llGTlbNy7Ax6QhPMtR/7tS7a?=
 =?us-ascii?Q?9Hw0WIrioJVkflUZT1kAqtfkMJKWYrVTOlf/6BiJ3jQ5VTl64xbTplCfFuee?=
 =?us-ascii?Q?aQEQ6NHMdFMF9EpcaKQsrI0PunM8Iq/vj7CCSwWjJLHLxbxWrmRCQSVC8kBv?=
 =?us-ascii?Q?GGl+KfYWo4oSjLgUbMOJyQwoIXUOS93t0put2qH3+FXEo/Wyfizybv4NGBmX?=
 =?us-ascii?Q?MEuvAkmPPNdLaSQuU1L2Wd8FV02i7/KeByayzkZ3R6r0/iFRahAuo6pODvQC?=
 =?us-ascii?Q?4mZymzGYRhCZhc5Qy7ZL46nFeCI/mDEblePc2xvfeMGm6kePtN7njLz9exbf?=
 =?us-ascii?Q?RPXqHB8v1eR0kM1cRzEUtqYll+JL+xv+jxrO/ul4H1LN+b9QuhNTCdwfRk3O?=
 =?us-ascii?Q?QroONNplkL8u/7t6uF12I9nAycfSncFSVCRe5Q3bs2qo+sZ54qmKhoojrnR6?=
 =?us-ascii?Q?t3FGZamo2/IeJRhCAa7GCQ+wgLkZS+U/kKMR29fj0K375g0arS0qN6KdjmXg?=
 =?us-ascii?Q?0AGhhXTCd5bxrIelJt7V/j7BJYw4fMn2L2qCZCk37w3sN0K3uUwL0lnsfmLr?=
 =?us-ascii?Q?Evfk2bZcfxh+g/67Yr78kDOEo1HM+bWdm22rlAw31iWCaufJIZMt9kno+7q/?=
 =?us-ascii?Q?zdpUg3RKKLZDSfDZ9bEBQWPPh8corWGB9WvTITjUAxKBoB0VExcianaAIc/8?=
 =?us-ascii?Q?soM4ShmqiNv9UwoqRaYJo1HWgiClfdBapj/GC4hEc63L12Tuc5klhdWoKhYT?=
 =?us-ascii?Q?eEff4uG7gyjdTtvfzUeAwKa/869G6IceCoCs5agzI5c7qbXB0Bd+UkTAq+WF?=
 =?us-ascii?Q?NeaFf8jZ3fOED3yPO/MOxBoEKiThPTV53WD9h3ow2O9u9kvnVK4jFYivJeXi?=
 =?us-ascii?Q?3+j9TUSy/qvvTyHYWUQvKLhEap7ohaRXrIurIBqVmPwCIA2RzpGkiN7iP+LH?=
 =?us-ascii?Q?oNGdy+6dK8qNyEB++aHqD/VdHEdh8pIbpGoQBaTUEFoPXnS3co0Td3MgJUGg?=
 =?us-ascii?Q?Y2Yu9l2afBR/g+YgOdHmhX0SI8qXaKmer7rTbxUmRpLHfo5drT949R28Vik2?=
 =?us-ascii?B?QT09?=
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;6:6UibBrSerECKiosjlwNpKv9/jViwv3KRB0/9TtDOYXjAeifToxWefxOaegiooKt4QIsglXV6HRhhd9vaDfvANA774+sWvu/d6R/6rabB9eWp4u33YU6nRalXLAsK+UPT0KfyVbE0BhoKoHibYcIPisnNthIzAQr6X7QGTUDSY9RqawBzuJP1l46LWcxfsQvO3stT5qtP8UX4c+9esTiYd9c5YpTIWVdTmzZV320HDARKRAKSijmaI1DPMQIKh46F9f6eAOeisKeu43JiV5LWgeoWIRsbvHkQvwO4RPGXvC615iGHdSEGDvml9AP+uVrRarjLVNyqpFUYf4Mt6wBMGtjhL/pRGmsEnS+DySxEc9o=;5:o1EcUQDA40iOi/rJ4T1YPlx0wcHRYIt3RhIxzEPGoQtDzdzNxIntllnbrNWJOClVanBdBiqpsIPvNSN07kh1Bu79g0T+2MGKbYG06WlFmEwDFE7ADDbXbyT+fbM3AK+Sg8kLMYUJlI8WRWAymuMJ7prj/vC62OKX1rCvMW8tawI=;24:4eYxTJJIKBkru4WQZc3l6apk7aiQoTxF4vg7+c2/7cOysjOQLjWrT2bXHC2eJqszxOE7pqgN1/SPXvVKIQtl5YTrkM0llTReRik7vpNvpU4=;7:AsOF2qaKK9UJxZd6pvQFsF9oB4hw1o1ZyQrccU1o/UsjL80WZgdjEMfHVrJbGBL3+Kb5zhXKeIZSsXabtA5qK2lMc2yNg2ICTUjErA4d7jQ6MPrRIvjAlEBWYJxV5u5HWhgHyTXeyj3CFl7Z+js/7vms0fUU7mwGxwrYnjbl98LhQR9D4q7arQFDI7kq5Kk3Vs0KowAUJHTolMFK3CDRjWFTLb7HtDh9FCY+9QewTASe0SFc9iEnl3GJqC8GZBzW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2017 15:22:46.5936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd796a7e-bbff-4dd8-0793-08d54ed004ad
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6P136MB0017
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Add the GIT_TRACE_CHECKOUT_ENCODING environment variable to enable
tracing for content that is reencoded with the checkout-encoding
attribute.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c                    | 28 ++++++++++++++++++++++++++++
 t/t0028-checkout-encoding.sh |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/convert.c b/convert.c
index fc8c96b670..ca7b2f3e5c 100644
--- a/convert.c
+++ b/convert.c
@@ -257,6 +257,29 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 
 }
 
+static void trace_encoding(const char *context, const char *path,
+			   const char *encoding, const char *buf, size_t len)
+{
+	static struct trace_key coe = TRACE_KEY_INIT(CHECKOUT_ENCODING);
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
@@ -316,6 +339,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 			error(error_msg, path, enc->name);
 	}
 
+	trace_encoding("source", path, enc->name, src, src_len);
 	dst = reencode_string_len(src, src_len, default_encoding, enc->name,
 				  &dst_len);
 	if (!dst) {
@@ -331,6 +355,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 		else
 			error(msg, path, enc->name, default_encoding);
 	}
+	trace_encoding("destination", path, default_encoding, dst, dst_len);
 
 	/*
 	 * UTF supports lossless round tripping [1]. UTF to other encoding are
@@ -356,6 +381,9 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 					     enc->name, default_encoding,
 					     &re_src_len);
 
+		trace_encoding("reencoded source", path, enc->name,
+			       re_src, re_src_len);
+
 		if (!re_src || src_len != re_src_len ||
 		    memcmp(src, re_src, src_len)) {
 			const char* msg = _("encoding '%s' from %s to %s and "
diff --git a/t/t0028-checkout-encoding.sh b/t/t0028-checkout-encoding.sh
index 1a329ab933..df3cc91269 100755
--- a/t/t0028-checkout-encoding.sh
+++ b/t/t0028-checkout-encoding.sh
@@ -4,6 +4,8 @@ test_description='checkout-encoding conversion via gitattributes'
 
 . ./test-lib.sh
 
+GIT_TRACE_CHECKOUT_ENCODING=1 && export GIT_TRACE_CHECKOUT_ENCODING
+
 test_expect_success 'setup test repo' '
 
 	text="hallo there!\ncan you read me?" &&
-- 
2.15.1

