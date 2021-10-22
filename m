Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928F9C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 15:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768AC611BD
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 15:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbhJVPMe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 11:12:34 -0400
Received: from mail-ve1eur02hn2210.outbound.protection.outlook.com ([52.100.10.210]:57385
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233321AbhJVPMa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 11:12:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUQMmotHrp0kqVlWKTcwqw/KF6gVGwx56xWN6iw+Oa2wZPlLne5fERG1NKvUu19KSir9JJPcsWUiEXJdIc6omgXjNMk1KBU+wxI/KOk64dXch0EMTxOHOQBfxLcm1+FtZnXr0c7hUXb524lndZXZPEYe+vvikLOmZWGFg+kYBnWV+PG5TizA8jrTFpxI0kM25rAD0b/cLBb7+ul9JS/iv1FGyYWZuDrqPNuylKoeiltkbhIzj5K50cV83WQN9ua5cGak61SDJMZ3G0FtlAWcI+GKwy96OY99/v4WUbuS/QvhZEw5GYioqIesW+6ibQeHWvNEZpDAUZ4sGbHTsjU7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2m3MoZMDFSS6kUdf+pP37jjV0Q5VRdvKIMtmdZwEGY0=;
 b=HS1kgWTF2Zq+AsEH4OK5CnX0d4aq/jj8gKyDER0MSEiP6FahuJIiW8Zzc7H//9kqYhx2KSXpRzuGZmw2EJUcbMSOBJebi4trl/gfQnjnjn16AiJvbnxrw+JxoeIp8oOoslJv700mO3JsvGZog4hfRnIgaSBUusXQZ4JryoPLK/BxATK++udVW+O0ag+twmX2SLStqsUQSkIWVKOEM5ID8uk4/KYUVXbPE3Fz6B2FYeNIx3lQJPYIeBMLatThO+GxbhYdIJb/a7z60rXdwdY9Jx++nCaW1oyRxTijPdSoxaZ9q9Wb4e8GIUeWxSk59h6hi9+Ix+Cm4R6EtN+el2FaRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2m3MoZMDFSS6kUdf+pP37jjV0Q5VRdvKIMtmdZwEGY0=;
 b=FQpd2hncgJq9ojJFBzTL3ZJydpGjzP29aqG9B0YOXnJdhMIRHIWKQnfQ7D6rsSq04GFqnwYuUXhiaSJSr9rc8cTv1rIA4ubKHILwPv6ObWQ6lFZs3mnQZJIyqc8iAWqoxEyM3bfhmgP/d2gxMphDlcbbbGnFyzHFCzDcCwkSrcc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4637.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:15b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 15:10:07 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 15:10:07 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        "Han-Wen Nienhuys" <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Hans Jerry Illikainen" <hji@dyntopia.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        "Felipe Contreras" <felipe.contreras@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Gwyneth Morgan" <gwymor@tilde.club>,
        "Jonathan Tan" <jonathantanmy@google.com>,
        "Josh Steadmon" <steadmon@google.com>
Subject: [PATCH 5/6] ssh signing: verify-tag/check_signature with tag date
Date:   Fri, 22 Oct 2021 17:09:48 +0200
Message-Id: <20211022150949.1754477-6-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211022150949.1754477-1-fs@gigacodes.de>
References: <20211022150949.1754477-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0601CA0048.eurprd06.prod.outlook.com
 (2603:10a6:203:68::34) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM5PR0601CA0048.eurprd06.prod.outlook.com (2603:10a6:203:68::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 15:10:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e633094-1515-412c-7931-08d9956e0878
X-MS-TrafficTypeDiagnostic: PAXPR10MB4637:
X-Microsoft-Antispam-PRVS: <PAXPR10MB4637B266DEA108603598AF9BB6809@PAXPR10MB4637.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:82;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kdGsnEj3lJeQPq2C6qpoJRcwZONF8eCET7N5aCKarbVJyzgZ1QdSzE3Gf7Wx?=
 =?us-ascii?Q?p18eYW5TKTxlwEzdV10Vb924gGMEVOyB85EMUCZ+WMYGp6zRkWc2fudVCLSL?=
 =?us-ascii?Q?IpzObjQcuwW/q/f+NOmPgBn+VWx6IncVmnyLfkiLrJvk2IMpR+1M0pKOEI0+?=
 =?us-ascii?Q?ArgK8hDMa1gRqk5KM6H3TVNjvcunC8wujNvnb4HeYfWoon98qAcrGxPSfz6A?=
 =?us-ascii?Q?ijyN/azUmVv3G9livdeJMmLzJWAftDE/pWCY5Vr+E4X2z6pitSACblYvRxqr?=
 =?us-ascii?Q?jTd/nxzirupqB8mdBVCpttOD7TZC1GTv/euN1YJQsaafvxkbCm7diOypB7pg?=
 =?us-ascii?Q?b8JWT7bnBBtWe0TK016JBPIp9sgWzgANR+cAdKyhHicH7H6hlFHZcg7ZgjC8?=
 =?us-ascii?Q?zOlGtfhju/KIPXtGJ6bl7DvfSK3FSrrEI+Ok9xJrspPbJCnJbpSYVAV9vR0t?=
 =?us-ascii?Q?YhSPOuKvJ/8HO6RFEcha6U9ZbXGi9kCFcVDWWly0rpPEzRN5tTLnnBEbRo6f?=
 =?us-ascii?Q?FDLa9uRCk2ZeNDYQV2ie1UDIq9UuQaJ18IeA0tO+5f2aIlF63/i3tuxTs5nc?=
 =?us-ascii?Q?a3JKXosePSZ1DHduSRfhf0E1gOaq8Upa86GsecHhoqcSJu6HWEy2nNa3p5is?=
 =?us-ascii?Q?DU4jB7gd76tejpUbBgd+jUXsIFs7g9J3+7OKUGyUJPGJFZmZZRaAApHibSRR?=
 =?us-ascii?Q?fdkU6PiBEfMjOqwnRO25MrQPoriXCiOJ8ccxbciI8h2nHqxDh2jsruH+o3Hk?=
 =?us-ascii?Q?ep2rc25+7yOJ3DcCahuH4T/QBG76CI9oQgR4EjjucvJbIu9nGttjecgwflt6?=
 =?us-ascii?Q?bU+v9tXxV1FOph+1nPqu+zkyND5uifnY/tSMzPvGsI1YxzLwmKKTqhsboKCq?=
 =?us-ascii?Q?hLP/VqPMX7xhH6l8yrLPOoBdwxSPsAKzDP+inkv2whXZ32Jtlf/8325nye3v?=
 =?us-ascii?Q?Rbs+wCDuYCSByAkrvRiTrU3H64d5HONqnbnazgXnk7mKZjqnTst91Dxno+ty?=
 =?us-ascii?Q?WOf7BRK5lhbKP3At6fzVy7awAw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39840400004)(4326008)(7416002)(186003)(6486002)(2616005)(316002)(66476007)(66946007)(5660300002)(8936002)(8676002)(508600001)(83380400001)(38100700002)(15650500001)(66556008)(2906002)(6666004)(54906003)(6496006)(36756003)(86362001)(6916009)(1076003)(52116002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9mT4vDelUcyjP0PQTNmq0EPkhWwKGWTXWfWp1lJcbkEx6vDrUP8r9taPCevy?=
 =?us-ascii?Q?gfvGXNUJbaD1wOpFwrq7Le/IcIlpa1H/uooDRKhczMsYsP/rfYaof/VMD+Yt?=
 =?us-ascii?Q?g31wmjv420qt0PzJ3q56x+qyHgi1LT+Y8wBmK+Bf6RWxtt0RUncyIKM/60dN?=
 =?us-ascii?Q?C4YYqDjEDN8Bw2HERfdvlQcGn28yjWqSA5gnGsG6b4y0KdkgzTjLxouYuAYT?=
 =?us-ascii?Q?QdtSG4+Nq01i4zdyyr8NM9xP3o9XlXunnVp5HF6A/6gd+U2lYlAOpCyq/2Ie?=
 =?us-ascii?Q?0nG/cxK4rgmqcmb5C2c4r3FBBiy4fSTdHyJsfC1xkv2t1+RVXCj2G2MLQQnG?=
 =?us-ascii?Q?J/W/6rZDWYnl3YghKpJxaDU74Xtft/qLEKi7Yy8o+Fdf32bslZUmx2eZdKtL?=
 =?us-ascii?Q?w5XIAbtCO26AVmkDXITa4edzG0ZSFYylKAg30y2nSRQfS4OAbm4ZV3oTxy+l?=
 =?us-ascii?Q?CPl3aLGkTyMZPQ36bxupIBMrxbSUELgYDG/j6Ry9N8KMNSnAeZ242FqXvpWY?=
 =?us-ascii?Q?2BKGk89YGTDdMRrcmK1/DzJcOI7UfNL2Hc4OxwcL1eHKFDEYCThpb7Os4vpQ?=
 =?us-ascii?Q?XaNlHWFTepIznRlYekzoUChkcty5TufwNYVpP00mWQYQtxeOdXZC0tr33gUM?=
 =?us-ascii?Q?7iSGoGUO/n7GFLxV0t1Q8efmeSrBrWpdBbbuN2gwN0S0LRl/I+cEHuIcsSDg?=
 =?us-ascii?Q?MpM8Vvdx7pN25JiQaGtyQAgrv+6e/1IyX3i+i8nh/TRahJNzZ4HJI2BPVwvS?=
 =?us-ascii?Q?qv9sqEwl1PX1PFlkjWJZtBoK//ht9whOaHzbQsHyEZbBkN7hlI2GrXMbrh/L?=
 =?us-ascii?Q?u8jtRPuOkMGxa1Gw+/8euMfX96DSbzniq+Qx4bpg5ToeI0Hp7RvZ6qAcyqHW?=
 =?us-ascii?Q?xmmakUreSw9D/YzjSSF5TWwLOCEWQvr5dTgzcIpG2oEEOdLtGMlfQDjsCQLZ?=
 =?us-ascii?Q?Aeyo6ASWYS66nXVR1mT6Ae7K/IU19zdanYG/UCYGqbqwljMAConxxk9WS3Q7?=
 =?us-ascii?Q?ybU/F2+GBHeq5AUTS7ABV5dnr0Lb+rLfPDznaBx1gXCJ9vd8/uNxSAkGG0bP?=
 =?us-ascii?Q?4aK6qzlO7trL3h3VWLdeZR8RObKQpUsHf3kF9XjXUWks8sAHceUItS8rmMdV?=
 =?us-ascii?Q?BL05tJXS2Xbnvhw5waKnG98e/n60gQk0/TOvDQG4ZWlKdEF6bVGa0t76G+dD?=
 =?us-ascii?Q?JRgurqVeDo8FnlEAE9S88APLKB04aQX5+oZeD18zc3Fk6oLDfB2hSqxWj9O5?=
 =?us-ascii?Q?9MYU60TaIL3cjVgdGsKZ/fvx7mOH2YCXMcfN8FB+y/bsYtagI6dbDEQfdQyU?=
 =?us-ascii?Q?urKc5+T866rjqVaU5J0B+3r2D/x4vF7BsB03kTmjqiBFb7GqXuTUmliGCiN5?=
 =?us-ascii?Q?Jl4YSRdY7sdlCIMojejR4c5rNkqZaSWyFt8Ao3ybuN4vB5lxv+hcfKK3JTH+?=
 =?us-ascii?Q?ggqMR7ZUIOpTmYIfKWtZexx1DDOAdfaA1wgUqeKdzAqeR9ArpsftgBWkaCbB?=
 =?us-ascii?Q?In7SYn9QmB2d2jt0z3xHQ2GMYVHKfMa+yLcV?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e633094-1515-412c-7931-08d9956e0878
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 15:10:07.1436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fabian.stelzer@campoint.net
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4637
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Passes tag date and tagger ident to to check_signature.
Implements the same tests as for verify-commit.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/t7031-verify-tag-signed-ssh.sh | 42 ++++++++++++++++++++++++++++++++
 tag.c                            | 12 +++++++--
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/t/t7031-verify-tag-signed-ssh.sh b/t/t7031-verify-tag-signed-ssh.sh
index 06c9dd6c93..1cb36b9ab8 100755
--- a/t/t7031-verify-tag-signed-ssh.sh
+++ b/t/t7031-verify-tag-signed-ssh.sh
@@ -48,6 +48,23 @@ test_expect_success GPGSSH 'create signed tags ssh' '
 	git tag -u"${GPGSSH_KEY_UNTRUSTED}" -m eighth eighth-signed-alt
 '
 
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'create signed tags with keys having defined lifetimes' '
+	test_when_finished "test_unconfig commit.gpgsign" &&
+	test_config gpg.format ssh &&
+
+	echo expired >file && test_tick && git commit -a -m expired -S"${GPGSSH_KEY_EXPIRED}" &&
+	git tag -s -u "${GPGSSH_KEY_EXPIRED}" -m expired-signed expired-signed &&
+
+	echo notyetvalid >file && test_tick && git commit -a -m notyetvalid -S"${GPGSSH_KEY_NOTYETVALID}" &&
+	git tag -s -u "${GPGSSH_KEY_NOTYETVALID}" -m notyetvalid-signed notyetvalid-signed &&
+
+	echo timeboxedvalid >file && test_tick && git commit -a -m timeboxedvalid -S"${GPGSSH_KEY_TIMEBOXEDVALID}" &&
+	git tag -s -u "${GPGSSH_KEY_TIMEBOXEDVALID}" -m timeboxedvalid-signed timeboxedvalid-signed &&
+
+	echo timeboxedinvalid >file && test_tick && git commit -a -m timeboxedinvalid -S"${GPGSSH_KEY_TIMEBOXEDINVALID}" &&
+	git tag -s -u "${GPGSSH_KEY_TIMEBOXEDINVALID}" -m timeboxedinvalid-signed timeboxedinvalid-signed
+'
+
 test_expect_success GPGSSH 'verify and show ssh signatures' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	(
@@ -80,6 +97,31 @@ test_expect_success GPGSSH 'verify and show ssh signatures' '
 	)
 '
 
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-tag exits failure on expired signature key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_must_fail git verify-tag expired-signed 2>actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-tag exits failure on not yet valid signature key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_must_fail git verify-tag notyetvalid-signed 2>actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-tag succeeds with tag date and key validity matching' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git verify-tag timeboxedvalid-signed 2>actual &&
+	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-tag failes with tag date outside of key validity' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_must_fail git verify-tag timeboxedinvalid-signed 2>actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
 test_expect_success GPGSSH 'detect fudged ssh signature' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git cat-file tag seventh-signed >raw &&
diff --git a/tag.c b/tag.c
index 3459a0867c..d26053ff4d 100644
--- a/tag.c
+++ b/tag.c
@@ -16,6 +16,8 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 	struct strbuf payload = STRBUF_INIT;
 	struct strbuf signature = STRBUF_INIT;
 	int ret;
+	struct strbuf payload_signer = STRBUF_INIT;
+	timestamp_t payload_timestamp = 0;
 
 	memset(&sigc, 0, sizeof(sigc));
 
@@ -25,8 +27,13 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 		return error("no signature found");
 	}
 
-	ret = check_signature(payload.buf, payload.len, 0, NULL, signature.buf,
-				signature.len, &sigc);
+	if (parse_signed_buffer_metadata(payload.buf, "tagger",
+					 &payload_timestamp, &payload_signer))
+		return error(_("failed to parse timestamp and signer info from payload"));
+
+	ret = check_signature(payload.buf, payload.len, payload_timestamp,
+			      &payload_signer, signature.buf, signature.len,
+			      &sigc);
 
 	if (!(flags & GPG_VERIFY_OMIT_STATUS))
 		print_signature_buffer(&sigc, flags);
@@ -34,6 +41,7 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 	signature_check_clear(&sigc);
 	strbuf_release(&payload);
 	strbuf_release(&signature);
+	strbuf_release(&payload_signer);
 	return ret;
 }
 
-- 
2.31.1

