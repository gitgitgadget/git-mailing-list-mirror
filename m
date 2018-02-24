Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FCDF1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 16:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbeBXQ3s (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 11:29:48 -0500
Received: from mail-cys01nam02on0136.outbound.protection.outlook.com ([104.47.37.136]:30992
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751475AbeBXQ3k (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 11:29:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=34WNHWiT1qIt3QiPL0ptklBQXCEkEz1zhP+H2u2Tk+8=;
 b=BkJpgfTEEbbH9wjv0t3hMMsoh5ZmQJFt7+ndoB/8XkKmzHz2NNdjAOTONYWWCUi3vm0olbPIYVJZTGhLjPgLUyNyD+wZbj2J/rTlc6B7CZ6LTesWAP38DO6yrNz7tytIzff6blXGGsNuH+MPX3TtAOZ9FYl+cMtLHPwB7DmYBNo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from localhost.localdomain (132.188.32.100) by
 CY4P136MB0007.NAMP136.PROD.OUTLOOK.COM (2603:10b6:923:12::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.506.26; Sat, 24
 Feb 2018 16:28:46 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v8 6/7] convert: add tracing for 'working-tree-encoding' attribute
Date:   Sat, 24 Feb 2018 17:28:00 +0100
Message-Id: <20180224162801.98860-7-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180224162801.98860-1-lars.schneider@autodesk.com>
References: <20180224162801.98860-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CY4PR1201CA0003.namprd12.prod.outlook.com
 (2603:10b6:910:16::13) To CY4P136MB0007.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:923:12::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 729e638e-c5c4-418f-3cbb-08d57ba3aef0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4P136MB0007;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0007;3:M9ouG367LSMB4KwkbMmLFtF+8THN6gvts1TPdtfNbgA5PUmjh6oOdKnaaPaCwkuRl+H9f9JYg8HZJy9B7wxAx+76iTbRo7HUR7Cnl52aIgqOo0rcoobQKcSUFIDet1DhQw5DvO23Wx4xaM3R6MhgvMlEpkcMmBfQEce+c4/EZaLs7uEGpfAee6OKTn28rpGzMoGyz8qNImmLlaYNDByKJC6xm4YAps2Sh9rJKwfcTJPl17bRL+PNesBVKGK1542k;25:qhSPU1z8Ee3HAvtEBvLQ86STf97RMopy00ZxW/rWgIw9oAOZQCy7Mdx03GwMmFmEerYf5GMtTF5SXXW93yWRyng+bjOlweHokRLKqH9Z+NPtEjjcGBcpxSZ6NT8ScfZxGfbOxpGk/GkY6vc50LGdzrSG2D2OSd6Lm4by+yuLYmWL11lZKQY760sPyHq/f6NrHug1JOnYTniHsxhgsc3kvNwt9nh6STTLfDHm0+QOPvyRhh8DjEl73gmi/YlcCYSnYNmjjnyPqFIQQphETWGZQH6gXDLUsMxzUB7r3Kut3FlcyrvPZeJtGCCgwPxoHP0EUnftuOX49MKyf6xFDUY3Lw==;31:f0ykq2zb0CtJ7sH4iwtFT2r2JayyalNA5xinoWKL6noXziSz/EPMI4iS8gsVK88KGqvrSYKw6yxLRoPzV8HooVJhuU4XQZB1dKd01p/0vp9WaxJiPzggq4ohHHoxNAwvnHTK+qC+w6k8orbM/pFSkoIN+ts4NmCp/434Y+hoVkC+k5pOGlNz6mCaNNie0F5u4HNr40ycd6blKVsAv4XBV4qF40WGMTyFAoiXxOz5Ask=
X-MS-TrafficTypeDiagnostic: CY4P136MB0007:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0007;20:W8DGo/VwM0KiTMJro/8V/yXFBJaQfy29bOh+TiOPYibz58VDv2fNO4SQXsfKOqnuPW+LUd/aFufvukRWstW8BbLHCo8Fn4TSOxwdwY7xwAo3vsthGmLlyeg/oxqXX748/romazRxfik5pRozstnbXM/pbcOC1zulgjNTbVE0aqdDFxxbmwNFfrmSLzeiXZ8AoUQFpOgTL5kGmzD+Jfoea+xeHAge6AYWHz9x7yUXVQJQJqD+ADsomuwEI2Z+ooAgQFyNZCnQ4QRpAUL+XR1SkFnlcaBrcEFGucP0IMhum630n87KZhqTUJ3zQ6gOH7f6RrpxPRK2nrHDd/IipgvxWbc52X6YnlKt8LwbQo+Y3kKG5wggfiOJEjclC+a7O7Lg8XhgvXYhQcVUZNPw/z7Pfx1/2lGiYbX95U2aXjMMNwV+ulY9a3lFebdRF6hXTDbR9GVBOPPHPoDq10or7ELTVENUBSzuxCGn0jgm6wn+04Miao0XHOgvJKsV7qQkZsIwJ4YLjmQ0k/dPGwJZT7aW0daJi630BXDsusNDWkVAOcYYZ+bNoYoe+kDi9ZXmDrU0Y5Ib23+TvW/IQj6kgCvkup1UCpCilXvUvhtW8T3ekqg=;4:MbwpPzJ71Wu8YkZ9AM1eo+J8U8flbM9b9BCjUKOJc2ZGH9Ib4pk/t+EmCD/zJPp0Jo9anTvLYVsnLUSPx8at8tLIeAXIspfPJ1t5i3L2TCQBvdPvSgfyaZC17CxAosTZpZWXfBB0gErvEctgyh25QGqNcpOlDgcKFUI9hHh2LF3V8thG/hU2UrD410IngnEvRx5CFnY8W5o8NguOIIBMRj5Q5bZ4fEVqUHSBe2ZtGqCkmpAXcJbVbcDN5S7MM4LH
X-Exchange-Antispam-Report-CFA: BCL:0;PCL:0;RULEID:(3231001);SRVR:CY4P136MB0007;BCL:0;PCL:0;RULEID:;SRVR:CY4P136MB0007;
X-Forefront-PRVS: 0593E261C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(199004)(189003)(8656006)(5660300001)(7736002)(66066001)(50226002)(47776003)(97736004)(8936002)(6512007)(9686003)(305945005)(8666007)(6486002)(106356001)(36756003)(2351001)(2361001)(8676002)(81156014)(48376002)(68736007)(50466002)(5890100001)(85782001)(16586007)(33896004)(6506007)(386003)(105586002)(86362001)(26005)(6116002)(3846002)(1076002)(16526019)(186003)(52116002)(2950100002)(51416003)(39060400002)(76176011)(6666003)(4326008)(25786009)(6916009)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0007;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0007;23:gzLAL8htWsQnusF/nUyW1ygHATkeDlppypwt7xzR8?=
 =?us-ascii?Q?SVuhGFRGcGKdOyTzeq9vWJjSmalomvaPWc4iAWVdtyHMqPwsabV4dC9wW4VJ?=
 =?us-ascii?Q?ZVx2IRcGvY55RlaB/brjlrenMcNa/+4fbmU3lpzjVss684CDtLWXs2W3oPtv?=
 =?us-ascii?Q?6jWkAmDvOPR1alwtMxP2K80wQN9qhK+JEhiidevSQ4TWrd/8mcLO58MIS471?=
 =?us-ascii?Q?Y1OAkqEpd64LDOkgL31nIa1Sa2wissHXU7WuwPMEY+ITZoh1FnK7wySSTzPB?=
 =?us-ascii?Q?n+JexrGgyi5NrdxiBiFbJifZlnRQmrrjI7HHcZnvPcy7bqUUsF8v0TsUMvxh?=
 =?us-ascii?Q?m9mlgjThzWGKaBYkdvAmPyX5nQZq4s4lygrapzQjjECVUNqz9jS+gfo5TOM4?=
 =?us-ascii?Q?zAk6sHZK86xInI9rbixD8V0OllQb50fI/8lmu2LF8ZxsJn68+tfI4yH151km?=
 =?us-ascii?Q?xJslEAWna/udLRsQdApGJ8jl+zxCqV870aCsbEq7DbOgAahcUEOT/GmZxZ92?=
 =?us-ascii?Q?PFjC0si2zpdXrW16nPA1oJw3MIjSIybyrmibBrtbtL1ehhbCYybpxs8coJVx?=
 =?us-ascii?Q?oBaCOyPCp2qQaO78FnjVQ8FlM7AjTw4zijMzX4ZgrZ4biSWAOdOvZjFhMzwc?=
 =?us-ascii?Q?9TsGW1oizKvEHujCKQlppUx9YEMyFqdSgzcIcXULroQ/hXAkVIphwjYrQlML?=
 =?us-ascii?Q?3sj77/1uiI+vz3W2D5Oq6ufPN02xBrqz9wP8KgDqWX9Bw3ZSU7Wi9x+/TtVv?=
 =?us-ascii?Q?OdV5aHOnnB6QZ+xnzEg8l9rUYnsei16nOdCAqFB/UwvCYo6ucfV+cjObu2DZ?=
 =?us-ascii?Q?gSvu6BiM8+oAhdmqG6L+nw4GSiYi/16AKedWHIh7Gt5VFFmSpxdtsahiA5z9?=
 =?us-ascii?Q?gYVyAL0lgUQonp+Bk97VSq90t3l5KYQoi0mi+/lqvhm0nTQNdI0ZbL93wco1?=
 =?us-ascii?Q?AwKCH8jW5NtF5sDSN7IIoTk2xuzi/jPGq7sYSlq2KzCsTg17+uZpU4nnZiyy?=
 =?us-ascii?Q?pFVvJsPcPVxGAmMYvUFMdSxGCIf684c3Z4OOKpQ2rKxrbv4eTPcz+/giz3Po?=
 =?us-ascii?Q?K+TX6qFnXOJLYGm85OKumYrC0OwyGxHzSzXY3QE0y7svd6uqkwbVBcnHy3xS?=
 =?us-ascii?Q?lPlgeC+QK7EFJPd8i5c11gJHHH4Ym9y?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0007;6:7SXe3l8InipMlMQFIsWqUFwQ/eutE74T/3biJvM0OWzsErbkA+Aypfe+PH0ykUQAvtSC7266d77QlllGFm4BQkGkwK4U7Lpjwsy5u1//NGlO9sDPxwXsDkMrMF4auT5PWnp3Sg6k1TRBDbL2+ssM3nrmK3fkNjrhI8pwOPMXJzz3n47Kl1D/qc1AQps0M/fT7aAfrs2Ub2pFXb1KjpUP0o9A71I/54tOKqTF4S+RUnwlMqDkkloU9LLVgqiO0NWtB4TqhlJK90iGnkRNOItAC2G7AC7rw7hWftYRff5oJKqAgDE7ajK/HkgnJmQkaMpT4Tv2C7YJJlu4V9sFwGHbPrRIj5cXGXD4b5mjR12v8Kg=;5:mlLhSXtrSa2Ud4AVueN9MNOxImRoesWG+KLYWi7ZBLQrbls1b1SJCisOjEkFnVSQWMVzxDyvhEOuoyEBwFYG5o898X4jnGsOtTjUQF/RsXNbJ36QeJFTvd2iC5Mw13r74eWNdUa/78O695Xlq/YlzyhrshkwSJkU7gggmQHrpVE=;24:WqOMdDC1WtxW4zFQFHylWJP7FGQOA9a3y1+lSrQXFUZgXzFpRi7mR6wdM5gn2CqtNyjwgEXapqJcJ3TeAvpNbA5G4Akg88RTSGkv+nyczOk=;7:lXwX4FVRp6QJCZPCZXZNA27Kwmss2+CA9JP8tdbSU16bpoZq73JV74YmeS6RGUG7cAVdcG3CtPjheMK+irwnBqOLwz8j0Uy6SuGVhUVuntMw5ws+2fd1a4/YbzRLysP+zkDMSMsvRlKfj1/0Vl6yWVmBUQ9l85yji6FGxRvQhLhz6LxK3JEO2HMSIyM4AwaWsF3aglgEYS3t7MjRvBtE5k60AzUuIsPvWdO9Tq3vkQdJolZ0U7pxFYo4J4rDmfQv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2018 16:28:46.6877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 729e638e-c5c4-418f-3cbb-08d57ba3aef0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0007
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
index a55bbcb6d3..8666669b2d 100755
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

