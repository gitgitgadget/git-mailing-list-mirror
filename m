Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7E231F404
	for <e@80x24.org>; Sun, 15 Apr 2018 18:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752982AbeDOSRN (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 14:17:13 -0400
Received: from mail-sn1nam01on0137.outbound.protection.outlook.com ([104.47.32.137]:22656
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752947AbeDOSRG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 14:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yaUADw0XnPfew4rIa5KMoXwzc/QDX2kr0/riuU/vYR8=;
 b=j62MG2erNADA6nYZr1IthCz8oyQbRtql3HtaQEkQtmbCnSYzHgYFpzP7iYSw2aMEC7fojJSWTjyGr/1yuj/BYs5Z8WRu4n7Y43Yyf7hk9ort50nzKcztUwa5ebW8QuYlkmYt4yI46WURt9suPmE1ranE88/o8X5jqCzbC2VWvsU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from remj8gtty1.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.675.14; Sun, 15
 Apr 2018 18:17:02 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, avarab@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v13 09/10] convert: add tracing for 'working-tree-encoding' attribute
Date:   Sun, 15 Apr 2018 20:16:09 +0200
Message-Id: <20180415181610.1612-10-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180415181610.1612-1-lars.schneider@autodesk.com>
References: <20180415181610.1612-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: AM6P193CA0010.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::23) To MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:w/MpFecFEWmUcVONyao482iRahNoKWj717NRBjEKlEqErw/Ov0HY4Up5efNrwqhI62fwF5dA/lKqzw9jN0GUQTvvsVs7wTZ77FzK0ry3iNIml1CNoeA6Ngm49ykiMsYEvVilRX1kl+Wm5C1TgIlPjFyMIldsnla1necrHkYJh1kUsWYcGMOETy/khVP9/AIZ0NkXQUouc3hKKEs13fc+E//0NSzmnbTGpolJdh2n+8/GRBLDvhjLYUtbdIpTscy/;25:9sDvi3mztL0o3gL4yISizZt2rDLJDP9ZYaNlnFiP+nMZzC+a8n0s0MMV5v3xdADGAAhAMz5leNN6uMESuPjSm9fWk6HgzfDziHxM8Uo+pTcfhX0SCmynvMG+hQmNwBixLhdFQGUut1AaMNaO5ngIRdWMii6lRrOgNoPqDSpyOJsjRU9eTePbNlu6dKxdmjrootumH1closOaxiuSMC+0v9SiQoih7iBEOavobUuktiAmElJaWLY0GVD7gjxJnbCSLCYFPw/zN8NkLMrkXYYQ5laWCPI75A/71EKw/YuUoAyX35HzXIl3fyWkjnPXSb+Cs7sk77cMDZ3oBeEqp6RCnQ==;31:g3gR4oQ+oGU4hkwDgseWQ1YUuu4/d71XDaRG2edOpGhjnYN+jUNoLOE/zYnO1tt9Eo8w8zZgsLhwYme8lGrIwGE2KFIvbum/0Rk/jm9jA/MsMUkHJIKW+6i69zfTbS7ZRqYq79we3hJ9SCq1XygU/RAGJqH+Tg762/UzkiT0aWkTYXbAC3JtXYgmGBfWIcBECVHHI4JyCcP/dTUWWBfWykP3/mxBttycc+L/E4lDSyw=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:Lm768rXkvBooiIZLM9DDkg/uPiv1dMg+q2GB5y8fKiBKlWvBMQNEeHW9xoZl0C8WJBFpWkeUqMuHcxLmAzeTo/HzgvuDrk3UJGJXw4tqH1jAKVn2GvzeICniNI+OrZoseWD/VGage1B+O0yTvUyQkANtTnAoKooyLUIMpmuRZCaJDAKvNrvCbAG7KMzH/rdTXZr4/AKj/9nTz+5wMkLiS2YtrgWehfKcm3WfLBnoVwEvU8EWH8eOYnKaFT7OxW/5LvqcUAJVBnCBljgvMCe24S8DVIuU7QALIzybx8pLdBmzXYwBV1+MktR4OgngGfi4sdLXEsc4D3/zKnG3zvr4NwIvrUKnBx0qXh0MWVivyjeo3eTXjWYZgU9oJ1FHP9MyjYcnXD2ObmUrBC1JZB3YwwDOCkK2hdlwWS0grLei/hMSRtc4qJwTTqtbvXmgmxZm3NDz9HO0ayFv9/i70cx1uiJtStr4YH9nwNZ4riX02Xq7TDhrLY3ylUyS7y7a7sVQE0jyVg6wUBdJEV0R79PkNeFFDoVHwGvhmmOQHEqziKyDL+cB2wEqD4VJm6oUn9NkpNjMxYzDf+D9SazjGB5yI0gpO9s0qo0ieq3LO2xohME=;4:jQtaCVi32j0TJhjcvvEy0b1jgt4iCI4nwxtVZt06a+4PosvTLzNvUSxH4WX5ghw5MNNzyLICbJkic8udTsN15tQXVZD5HxbrZyGZ3tj7pSEHax7d7vyC6OIfXe/edgSlNdA+GM1LeXXN67NjCCsX9TikZlz+SnH9CfYSTCpbK3CoNPryX2i+ovaVIUty5Bkl2yvBVKRVzjPAU8I/FPYAwc8UwvMmiyDZzdx701sm5pGKn1ghsCN/aoPPUrYiuaV0VREwCvQVXmSI8ninJgcuM6KgrVf5++aR3ecO+Kvlr0ZDZs6Ua2ILwEJdzrno64MH
X-Microsoft-Antispam-PRVS: <MWHP136MB0014E616F48DCC75AFE689DBE8B10@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0643BDA83C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(39860400002)(396003)(39380400002)(189003)(199004)(53936002)(86362001)(8656006)(7416002)(9686003)(106356001)(76176011)(478600001)(52116002)(7696005)(51416003)(386003)(6116002)(97736004)(446003)(476003)(1076002)(4326008)(5890100001)(50466002)(26005)(68736007)(16526019)(186003)(85782001)(59450400001)(486006)(3846002)(36756003)(48376002)(2616005)(956004)(11346002)(105586002)(2351001)(50226002)(8676002)(7736002)(305945005)(39060400002)(8936002)(66066001)(2361001)(81166006)(81156014)(5660300001)(25786009)(6916009)(316002)(47776003)(16586007)(2906002)(8666007)(6486002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:remj8gtty1.ads.autodesk.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:upItzj0ocQar/rLh4GXQlh8jL0UljMiYAprP4Gv6C?=
 =?us-ascii?Q?Slie6HDKoXw8qCAQv3g0q+03yKJJfXz1biwCvvRCNNjSC/VJxz+JjuJ4N+9g?=
 =?us-ascii?Q?qfetqvVcNfxE213SHXdAWbdystovAs6wbGOE7GkrHZQVZb4T9YnpkMR3EzNM?=
 =?us-ascii?Q?Mfl1vVmH05omOCV0piZuL5rHo2OVGrLhx+IMPggMS/T+POfKNpw5sp4o0B2w?=
 =?us-ascii?Q?ZzNVGJh/yXXtOL+youhsY8W0Uidqk6AGNq2XnWVdtx/m3i0l/93KGxVmEjIS?=
 =?us-ascii?Q?oBoD55yj/jxBiHiBYSV7GZwGEEKkQHLsmiH7T67ZLyD514eqEgSQYMno4c7Q?=
 =?us-ascii?Q?IRFUFPw5WrlTfILa6pG9pYKrfhC79W2A2g2+BtSyvfNCx2y3PJTbQJ3491CP?=
 =?us-ascii?Q?zhd8rKRvqKZ++xr0Ea9PM2rNuLKuVQclSBD7y/wna9DP8NbrzwR52tjHIsL8?=
 =?us-ascii?Q?0FDBIc4AFYKyfeGfyecdMOZ8LiS+EL/oWzN1AAjj7NXTGL9430TGVyslx9qw?=
 =?us-ascii?Q?b9ik/LFfa03UQk2GI5r9nN9Bd6hHIyoDb+ti6sQPj4HNYXJABxfmGoC/7Y3E?=
 =?us-ascii?Q?4jgpQk5HUbIy42zdK+jFmJnjCKQURx1RFADTkZL3LrwJO1zNSXxRdYvUrPKA?=
 =?us-ascii?Q?kAgoiBL+6AvR60LbRAA8+azxZHO1YwcOCvP7jOPJ8HAoOtkV/V1638e7d6Lg?=
 =?us-ascii?Q?oFEvv1fckxGiBEfVDs75He+Pb7TM/KFgHgELsxYVX8P7bldCmwiscmaO/ZtP?=
 =?us-ascii?Q?In8A0Wel+W7sCu4kZC/QsXgh9X7lHK1PS4p/N7Wx78vPiHEK0bCLwm4pmPnM?=
 =?us-ascii?Q?LARyyFkYQyznTv/a5sji+7+sImFu1hjtUnQKB01LNyPx9SPF63SySglSHLVP?=
 =?us-ascii?Q?6GMlS5UAB7axqfGDPf0NCJfSiRNblx0Ny7aU2k3t4jEGV2TdVutwNu03n6Ox?=
 =?us-ascii?Q?BypI6BAelAgUJISOB9e/R24QLC0YOTEwXCddXmAauvJCwShVgoUzBl/qwSCv?=
 =?us-ascii?Q?kp8ljdngYhVUddlla8qX8oNOrc38zbgjxlPcBGBnGo4wOPeaeq9x+BEqScdW?=
 =?us-ascii?Q?oQewzAyJ2MOpaog5Vt19HlSBc8CnkGWHDf9qrYof2AIfZ3txdANzNoAfLuj5?=
 =?us-ascii?Q?4oOrJ5q71R5axImfyTrsM1XRq+9Pg65wWj6Th+x/GVG1uRFq3nvFmLoBKkeG?=
 =?us-ascii?Q?s8qw6OgfoG1trFfZDpkCCFY1T8uKaTGdll5TZ/RXOFWBnQVDInYQtAsmffK4?=
 =?us-ascii?Q?FrUSTMM+xY+dL1f3tbsBc/PFGTLVDu1f9O6tXFaprrnYsLsRCmc5lxhcW0f4?=
 =?us-ascii?Q?Eia/PbA0XQ4zLfy+vEvsU/tteuVb3jzzDSL8S5lR95UKIaZTYQ5gY6uggQI2?=
 =?us-ascii?Q?U8vjbJWC0z6jr6sg1nOavEWRAZLfI8r8y1Bl9XR9malbE1J?=
X-Microsoft-Antispam-Message-Info: 2JcJyb82sDS9sD2F8tnVB3J8tqiniIvX22vv3DEQS34W3pwVf7b2x5Q8ytKMTYe+TWa7jME7FThqZHbVJfYPbprYtWrNFMcHR/+0kWrKbSguKES0TaCJ/eiJW1k4EEDN4HxAG4NzkBaUHSgv5Ob2tPwt+8sRz49hmR8RM5iko6brAvw+A44UPeFGrkBQJ6Np
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:GWfk1i8DryqdJY3skPYvbDlgw0j5TeQABtjHVWv8rMGJsc0JLXVY9QkjHg2YoqXjBhRAEnupv1t7JBBi+Wb6UcnJmXs/9RK/xwj50ASfQHC7X6miEd9F96K+NNIaLu1n2zlbRKS7V0B5ZjA8K5x1vtHnrEmVoBLL28WvdLGCdwhBZVfRNrioSO8xL4TDS5aMaMhUPG+k/DeqtRXPy5XAIV9rtnwyPVqJ4ZZJzf8q7pEbiZv+oBtyoXi1iMsAijnrN6YhK+cjpvKvJcqU28YlB5l4Rvr9etQeKy7fNXORTbGsjVqVR/h+GWTFr01U5MWnKWAVoWqa4Vc77rYBTrF3bj8znXSGWqo4BMelvsEUxKgCEnNsyCQMi6+qNVZ7TWy+LEgymOB5s8c0OdRYjumy2w/2YuwHh6fLCeLC3JwwZsvk8mIUMebTqJ0tkD43/UFIesQ38u1RinM09NTc2DLgpg==;5:pZHDVmEY65+d9yTVeXK6eL+KAZyLWPVKTen7R+8U2tNWx1bzaHj8HfnSKLtbMvYLzIOy6eJCeUf2L9sZzcm7JJvOxLiRvPxZLn7e6DQ5qgvJayN4dh7luPgcggK9JtyG8t+FDJXEVgrAEaWhbgpBbzQEw8vQeSFtWasPvhWfCN4=;24:GO205/e6ydfSWdTyULxTzJJvO70yI9NqYPZkdal3Ccy5jKsF8o0ZuD5XHwuP0N1s1q3jvo4Ax+pnqZp0c0OJVCcTHXttYNpJRIjbcHlW8kw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;7:eCDhAcgtjAb4j8mTWI1BCBjYYVb7yk57/X+Y88xpC4vvYIyr2Uz5vYh+HQLYnv2vXCfxvgN3Kf56cljCBBmCDsOlZwSvXx3NzMcui3thRS1GZ/qBsd52wlJ/qD6PEVdmO9URKIbO5oU1yomebFu3b4SWkN+9j2mRVg6I5PxbsR9+fZTvVw/o2cJJHOVum39gBT6xK9/9I7aFUArwhETyCYjayUQTPz2dsn0dKGTTc5O4E9MCRPLxYrjH+8wVwFrs
X-MS-Office365-Filtering-Correlation-Id: 15263e41-20f4-46cd-8261-08d5a2fd1788
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2018 18:17:02.1321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15263e41-20f4-46cd-8261-08d5a2fd1788
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
index 0e7930c154..bc35c33249 100644
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
index a318d03232..026544ce09 100755
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

