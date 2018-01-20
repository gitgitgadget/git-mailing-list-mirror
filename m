Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0E491F424
	for <e@80x24.org>; Sat, 20 Jan 2018 15:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756322AbeATPZL (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 10:25:11 -0500
Received: from mail-dm3nam03on0123.outbound.protection.outlook.com ([104.47.41.123]:24431
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756103AbeATPZF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 10:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=SmP2goOzJ+1neERd6Lpi5mu66kcPRdPn+FmO/vf6azU=;
 b=qGhxDdtBu54UdTaGdPqx1p6dZx4wl2zO6smxdOHgQZpNbWooMJy220e+jI9HdLBuYmYy8vhjGQ0JVziht8Jixs8zCCv89xVuSQTFITVKTZAy3HhVyQJcJHug3w45ped26hU+tpCtZNxYy+/bfDX+Hfr5nWWBeoWpYGanzBmXJfs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxBook4.fritz.box (91.89.52.221) by
 CY4P136MB0022.NAMP136.PROD.OUTLOOK.COM (2603:10b6:923:12::25) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.428.19; Sat, 20
 Jan 2018 15:24:56 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v4 6/6] convert: add tracing for 'working-tree-encoding' attribute
Date:   Sat, 20 Jan 2018 16:24:18 +0100
Message-Id: <20180120152418.52859-7-lars.schneider@autodesk.com>
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
X-MS-Office365-Filtering-Correlation-Id: a4aa7c98-7ee8-4d06-5584-08d56019f755
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534125)(4602075)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4P136MB0022;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0022;3:qvS8LdEr1qfEI9dXtvQXbR6DtmvXcioS2UEXyAXUfOeexiISsycvTPcI4Qp0C7l4Sdl3PaKoPPvhQVExplGoF0r+Q2CNQxk8j8uAmBS+QTOSPNtt1qmqC6tLAZkfDFyCj9wCL8a+4W+1b2+ys3znqbVr8oRwd+Fbc6QRgR7Xt1iSvcpgUViPgP+OpMUJDarhQ5MMaAsJRzRQRO34mLUTRkMyT2bLsYo7fd+z3qgQOBhMS+OPwp+3jey3R9lKop89;25:kGnMeZrEEloWjtSD6De311yGDI50TElaUDAKLhEvOOEydSkYK7SOWDIPWzqVa8ekw9pv+veK83GPv3flhTCde9+KCAwUDi31R1+K9EXMFfv3rGmhPpqbDHhSSy5wb6jkfIxO5TZ9+Qhbu7Ej7/iyf6ZoaWBQP/GJ/wvAK11VlbL0iwE5IpZ7sxYMWGn6bNSPOEUkuYhrUVJbIUPnoql3i1dlFmfNb0VvWeauCEAT4hMv25vfI9GS1+AWM+WZU8cO4kaZ8Fz6l7509gcSCCpU8Z/A5D8yoAmSXzjLq/+rF5QB6kQmafpN3K0dlPvTZOxcSqOHRMOX+iWDiEzmuH1tIw==;31:Ewd3tHWjb+fe9+E2LO43sBAC3fazp2Qx7/BMqveM6/Qh2rPDmp3VtsvQhNpi7n+2X59CmNsJv8ugwMyRSjOXb6EVvBIMAPR3DqsWDu9NnbwNl91ZGrDjnctCj6eTYzsQzz8Py3B6EoemHXImC8H/GgkqvZD1t3T6RiFtfvxBoG7Upt9c3jI6YYt97o0O16+Ms/lChx1g7YABl+jqY4pU966Z5Nz9kDr49OKkgZp6X/0=
X-MS-TrafficTypeDiagnostic: CY4P136MB0022:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0022;20:aKeVupIbWimzHjKnlZ9KCQ8k3EnMDKHKJvpD1L3WeoHknhjFgYj9AWVM3cpXrPgrL6MTWjoeR5JHqznDPE8REaXRZfzlNBC3dkH3F5nTwUHxCmTr3HTd8q6Wk1/Ay3lR94C0/kqCPGoq8Sqb+eGRVMzQJEqQjn82qUfS6d49lMm0tD3DOijV2JSOG+VHtz1eSTpH7E0FWPf7pdONvsYpMlkDuI4k9cDVZd6kImglZ4IgIH0da2CL+9r8AFD7Z+bbFky0Zmo+I5i9cXYtwNSh/jMKNi4WRkcfiVhm6vD1gzGZtLdhJcH8MEvNJwuJo42U1E1Bm6RBxpLyFcmHpMUUc8pZz4A6pTaZHNYUgchlGxMybzBOnxlv1KjsjkE4C+/YovMDc1gYMG5grTYPD5d3e8Dcyxpj3uCz1Zw1rVfdk81qu1K1bTz9WC83bVtb64id0RKdHXzi0XX2UALZPP2UIF96wasQCpNFbWOhIzcl3D4HU/YTxu0IOzIWb2THgbG+E+Sx7cXpZ/WCEMrfKK7COXe8n5bDVCTMqLa/6qTRrG6VRCkPBhqdGYnQtqedyhwtjbK5tn3HAL5NYqi+jA4Xk0YjJ8T5uFxC4BUF0IZnHoQ=;4:cXkA4Zvn/BCj+rJ/Q70tLXAJ5Bd4nQAVf+CIn3TLyJoXe/KyGxVopJNzspTbjLGWHf/0KDdO7EXbXCfB+wSa7C7u0+cLwm5TNfPlcb8HD3kw2S1DsqBtiKdKlUZ0Pj5I6xk7PPXHp7QWp0Q7nEhjhwnJaKqXHLh67uKuetYzBhg8qyxv9puSwCNp/LJDiOBu97pucxvcG8YQW9sOCuawn29EoSZd2+PCwsWyufFuUG9MiX4Gn9d8YDftGEWuWB5Dz070QV3KGuAKVvsPE6jG4th9ZihJqdmAYOg25ae8SEh4RRfn4dIi3tafihfWapst
X-Microsoft-Antispam-PRVS: <CY4P136MB0022A106120C0E094A79A9B1E8EE0@CY4P136MB0022.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231023)(2400081)(944501161)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY4P136MB0022;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4P136MB0022;
X-Forefront-PRVS: 0558D3C5AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(366004)(346002)(39860400002)(199004)(189003)(97736004)(16526018)(478600001)(68736007)(48376002)(50466002)(305945005)(16586007)(25786009)(7736002)(39060400002)(3846002)(230783001)(50226002)(316002)(85782001)(4326008)(8656006)(6512007)(1076002)(53416004)(86362001)(2906002)(6116002)(9686003)(2351001)(69596002)(8936002)(5660300001)(36756003)(26005)(66066001)(2361001)(52116002)(8676002)(106356001)(81166006)(47776003)(81156014)(8666007)(6486002)(33896004)(6916009)(2950100002)(105586002)(6506007)(386003)(51416003)(6666003)(76176011)(53936002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0022;H:slxBook4.fritz.box;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0022;23:qAsEAFcgd5/S+CSqVPfiYaokfxgewdP27fKu5dpsn?=
 =?us-ascii?Q?JcI+qkcmWF9q1oUj1OvYtlgeANClJJWNIf5hDiPQzxoSi+d6i8STCisgkIs2?=
 =?us-ascii?Q?oW4VfFoT+610buORTAQQoD8cT3lsxDHSKst5Sq+mgQT3gTh/F72nXnRRmC7Q?=
 =?us-ascii?Q?Np3QL0HYmEKuix+HVKv4mcIKhSv+PfI0pZbwwzxrmHrYTshmobJHi+6H48vG?=
 =?us-ascii?Q?jvsc7t52q40hn19s9U77v9XbY1sApbPyot84EcCi6kEp+ET5vfi24anWxLWS?=
 =?us-ascii?Q?KUajafsCYNKO0Ct14bQ4As3qnLT/uHjb8V7LhzwtBY3om0zuAWcXJjorSKx8?=
 =?us-ascii?Q?Nc1tcxvkBuBqwmg3Zg37bMKTmDhwQtMPY5dtiZtyGhfR6HAqQPYzqjrdBJJs?=
 =?us-ascii?Q?sjHCofh9k/bO7248LsIgIVRRMfRshqT2RYbGa8zGNRpOPeV1tuygzpda5Gxg?=
 =?us-ascii?Q?CP0hwcIDQYxyrA/oZikw+haLoK26aFf6YIwbt7rwr7iP/rWrtFIHj5zw+2Q1?=
 =?us-ascii?Q?o4BuPwh9cL7tfPAEbQKie9i8IkY/JnXFqSBWAyVYEJcWPE/ExhXbIR/r5+Mj?=
 =?us-ascii?Q?6dOGnCNu/OWRMVOch43NPrYFo6ixdJGmxpdwf8mp8v1um/vxfTdqlo+rG7RF?=
 =?us-ascii?Q?Z54v2LkB7M05o5PObwDJfMh6LuPkQH8yVWyYpXpZToJ/1gMWZ/Iy8uKK3E36?=
 =?us-ascii?Q?CrSzSDidjip9VGSRTPQt4VRfjFMZpcdJ20DgOWnuimZj8dmcSyo9jpLbxX+b?=
 =?us-ascii?Q?+a1WCd0pXY1n5o3VKpUB/8CIqIcMq6v+HftBraWpbuMsM9ghDyGJcWG6g51W?=
 =?us-ascii?Q?JTX4cNast7M3+vmz1FG8Gs1OftZ1z4nVUEcv84AF7IQkVehPmfme8fhkWp0W?=
 =?us-ascii?Q?UdD6L/RqRx+aMDfZaM+sumhfUV89R2Kw41DdFKzlI5AgRxf3RaVKYNYwYqZi?=
 =?us-ascii?Q?JOG4Veslpg70JVcxFGfiyVndAaV2831YTspAA6CILNgZ0ZKLJclbNeZOD/gl?=
 =?us-ascii?Q?iiFjAQYYmnhDUH2J7SP8EczBX9hvSbqCkOkNvUvUoQbNDu7TmaEIrcPf2iAn?=
 =?us-ascii?Q?hs64S+GCDzvvJc6EXIdjnkopKbXQ+R6DljhC/c6WuojyJPJ+6nZiD6taMESH?=
 =?us-ascii?Q?6DMfJM/OclBbmGDLmXAOgjFbjpVAwGEFYD5zdy6lpsVkc7hUbyjawq1bBZL9?=
 =?us-ascii?Q?YKSAxiH4BIPO+y6IN+QFOR9C9Pkfw1g5k9GDvFJvVdLInAdhWUI2EubHrcn7?=
 =?us-ascii?Q?E6ilVKpUoaLPEcyo0Pkb7oGdQjleCaoSTFUpQXDTyucSolcSLTKnSoyOKPij?=
 =?us-ascii?Q?Vz2U/5W5behx7bFiRMjl5JkSa+tIsPdQnkV9gLqS9EgIis1qg0hgkL9G/GJu?=
 =?us-ascii?Q?sXdyw=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0022;6:4oqDY53HlxAyiYKd4R2kk4yM6ZGg0f/oWULbem4YcUTxyjCY7HZI1kG+9/12TLNyRfO/kL7lc+h1BM2+S/8b+E0+92YHTY49UXqd5xdsONwSeoiSENprjMNjeg+lkPW+j0UgKg+DjlUBvf/Tc2kwleJ0UZUCGNt+EtwPf/XT7mMf4nQXXNxHha4DPsSP5F+flM6Cjr/szSTPKIjGBKpeN761M7Mt5FUGX7QuEWlK4xZd4rCPqCpDmeWvYYLTLJMnoO+3rDPLiHqqqz3Ns456kkf8Pg3BPoh6itGPFyxUOD3RIGm3BZNvjpvda/KHb++jPGF6Be8Rus4NdJ/Td2XjI1U1tQ8SVDXOX9f5Iz9RCs4=;5:PNKpn9wholPHGpoGlUf+jFvkq4N6U5LRqnHPuMdH6gVaYaNUyAhdUOaQ4gtT2gCCTo5JqRP5rbizqRdheh8/rSyHFLbfjrvD9iSMRo0qlzX4VbjHwiHFgW3zyjzE/7clhvUfnUqK8OPwvyNRL3N+oR43omQjdwULkOyYDTLnWAQ=;24:Vs9W7TtX4lw+T3WarPXE9PpFWLFWG52AtjPBMoySONdXVyK3qxc0rfLhkx5xEl/LgRSvzgvybYKprQ8ZEw6WK/ZVH0Z1xhDR90RCfWAN1yE=;7:CMrYWbJOtgDGwzuBTWh7ZpjM7n+Lwd2okN0Nvg/IEzM+ACNTjlpG9hAywWnGmMa3Dx6Qy0CQFoU0qOhu2B9bIKUMFG0uoMvoq6j5oSjdw/0F/nAJ8UcEdP2dT3/Gr+533i/KZOfuE239S1C55ooGLnFJTYFy3D2Iwhemhz8QwQt0NKLE1IZr3vTCb9Vqx5oCDKFesajmcmuVL6Xqkcf/KJdBaEJQobLTvhBEO0JgEqsRZZdKSzCuLAiEyt261Uio
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2018 15:24:56.4056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4aa7c98-7ee8-4d06-5584-08d56019f755
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0022
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Add the GIT_TRACE_CHECKOUT_ENCODING environment variable to enable
tracing for content that is reencoded with the 'working-tree-encoding'
attribute. This is useful to debug encoding issues.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c                        | 28 ++++++++++++++++++++++++++++
 t/t0028-working-tree-encoding.sh |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/convert.c b/convert.c
index 0c372069b1..13fad490ce 100644
--- a/convert.c
+++ b/convert.c
@@ -266,6 +266,29 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 
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
 
 	/*
 	 * UTF supports lossless round tripping [1]. UTF to other encoding are
@@ -365,6 +390,9 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 					     enc->name, default_encoding,
 					     &re_src_len);
 
+		trace_encoding("reencoded source", path, enc->name,
+			       re_src, re_src_len);
+
 		if (!re_src || src_len != re_src_len ||
 		    memcmp(src, re_src, src_len)) {
 			const char* msg = _("encoding '%s' from %s to %s and "
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 4d85b42776..0f36d4990a 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -4,6 +4,8 @@ test_description='working-tree-encoding conversion via gitattributes'
 
 . ./test-lib.sh
 
+GIT_TRACE_CHECKOUT_ENCODING=1 && export GIT_TRACE_CHECKOUT_ENCODING
+
 test_expect_success 'setup test repo' '
 	git config core.eol lf &&
 
-- 
2.16.0

