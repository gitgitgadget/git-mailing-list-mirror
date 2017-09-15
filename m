Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F40920281
	for <e@80x24.org>; Fri, 15 Sep 2017 16:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751400AbdIOQ6W (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 12:58:22 -0400
Received: from mail-sn1nam02on0121.outbound.protection.outlook.com ([104.47.36.121]:18560
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751364AbdIOQ6T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 12:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kdelKa8cgYp4D9WMQGdSbTlXUO0Vx0QZ2mhdEiHhoaQ=;
 b=LHpZZ89Yi1yxQGYI1ptlEsO9TiXRZP1m8bXq/Z1kYVOlEKEG7cf9ewdp3/jnYi+MVJcN7oVzJEIRh7Ae6AZ+jado88A/2REUp4O1cfchN0Mo70osyXsd1sIZUb3cWF+14WiucrYZkJr967xF/GcbXcCnzyxAz3DjJ48Xm2CK/8g=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 BY2PR21MB0082.namprd21.prod.outlook.com (10.162.78.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.77.4; Fri, 15 Sep 2017 16:58:15 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, git@jeffhostetler.com,
        kewillf@microsoft.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 2/3] sha1_name: Unroll len loop in find_unique_abbrev_r
Date:   Fri, 15 Sep 2017 12:57:49 -0400
Message-Id: <20170915165750.198201-3-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1.538.g56ec8fc98.dirty
In-Reply-To: <20170915165750.198201-1-dstolee@microsoft.com>
References: <20170915165750.198201-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1::2e]
X-ClientProxiedBy: SN4PR0501CA0038.namprd05.prod.outlook.com (10.167.112.143)
 To BY2PR21MB0082.namprd21.prod.outlook.com (10.162.78.14)
X-MS-Office365-Filtering-Correlation-Id: 25ccaffb-fc45-43d0-e91d-08d4fc5af57f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:BY2PR21MB0082;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR21MB0082;3:I9+yeVwOpsKnbybjWuUrzXbao44hyuhOUEF1mvqC7FCTd42YNi2QnL5t2CdNqV6IE8RdILLl7mrnAsQ9YaUUDFytliC1KNiJzxMgMVplazy/9OrHGduuKjCR662SmYeLKHxQznO9rPPTJAGJjhWxDjRzSAglvAi4AVk3dikPFojc41NWSaBCXYdN2/tzbXBHCwGkgUNV8Kt5CAzwvSKzWQyVUjOHNTrSzKA/Abj1Qhicq0MpOx6NzYNhC2Y+MvpJ;25:sNuBgXCJJOPykIjwU7ea1HckiJ9278Ls2i4Qe6XaodK4XwBSRZRp0oXGSeZHS1HREKAu2NQ5+LbE9HU4b7QPMyg6wQAR0BzuO9k1pYAfjyVCELrTDzJzwfgbKQwbRUjomFGI9Nx5FawO6L96XyXV3Ou5Zn4tBrzmRFxiY6IGSjL/w9kgO4p5IUKmF2LjX/Nxox/yryxV3r5/GqhL2joik/Q1dDz6URXfmkTHiuiqrONb/41HS5hw1uwceT+FhCBNXwAm1cpB3H3W43RESFCFYTb9NuRwv3BrNJw62cUqcjDRNhi188wmjHFk8EUQyyLY0l2dAat1TdVV8XW+ekkkFA==;31:TTKkq/lnNZ6wV9uDACQ4pBxO15005Vhg4JrFiHuFQsE8G1+lU0Kme1q/9XedBCKVOq0j06QjHkPLJwnTKEz/C+oLM3yTz8toEWfTkILgIdPMx48q7eEDCs1LzufHBLznzklunpXnjIkIV0f2+AljciOMvZTYDMdJx1OaHd6/o7AlRy20ngOAo7uTuVpEiVgAjKwEFa0rddeA2ubVU6mP8MRAFGL/pVYELbE/ZQpoDZ8=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY2PR21MB0082:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BY2PR21MB0082;20:nr7FWfdTGHSdgh+6IiDKL9XJOckOo2LC6DqmZi7fRn6JjJTcZAoUFDlZbiLhMDAa2yQZzajMjXySNYfu0xQgIZz1WW5ib2r4PnXjfRMd2xeR6qtiK2fKZdKLmN4FZHM/0x6AjzijPit5DtSmM+S20WiP81PEI1V4yMineyn2qJxKdo2Qp4m+/c667WXkTeJi40ms5NAJCDOWho+vbBtiO/1nDkdMeo6N6VzB51fJzW3/5eNcdM9qSGk4UYzveSfyftK/QhZDzD6LVu3ZffC3BbgkmCB6RCvnQQN6MdvMPjpr8X03duw3xPwDpcHENI7mPRkN9T3NrXGUE7lJe7BvASSwKIN/1rCLOiqHTdmXBnNkoPruadCzYlPSOnNf3DhI+Nn8/llDBjqHwaPM6tKmupwEvpt0K+S5IMYLrlNXk2DZTcKPR6LjgS6dOIhVQtf7sAgNH6JO2jB34m1lTSAzl5yuaJpxllWSEyBmOYaqgtr41eOgNAQs3Zx0xq7NmdQW;4:1OTjRI1TGwb5mKft6EOgYn4LXEnmH8mUFKFUDGIEujYIR/Nse6P2i/bnj8AYp3aWEtkjnV40rtpFgiFnRXdC37pPTgn2lrhANjPTCkZmsVtge5kYJ1bK0+UUbDxwqXN8+Ugrrm698V+EqqMEUF1nkQpcCk0j0jJDCBiTqeBy88pmMah3EAYDlT5CHsMKRHs5hWQM+tRnhmGClPXYXNvF7ItZ/1miDPhmhbvBiSg/iW+NhEamnLPzokI7OLu7/aJNK7bAmB+giFlxTYwczcepjPgEAWZUtNZ/qWv5tPKsK121qTT7RfZc+/82jjYM7NomnabJEZe5hgDX73HJSPiU+g==
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171)(17755550239193);
X-Microsoft-Antispam-PRVS: <BY2PR21MB0082E6F22AF0FF8CC57EC2BCA16C0@BY2PR21MB0082.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(100000703101)(100105400095)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123555025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BY2PR21MB0082;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BY2PR21MB0082;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(376002)(346002)(47760400005)(199003)(189002)(8676002)(5660300001)(81166006)(81156014)(7736002)(50226002)(305945005)(68736007)(47776003)(8936002)(101416001)(189998001)(76176999)(50986999)(86362001)(86612001)(48376002)(50466002)(2906002)(36756003)(105586002)(106356001)(2361001)(2351001)(33646002)(1076002)(4326008)(53936002)(25786009)(110136004)(107886003)(5003940100001)(6486002)(10290500003)(6116002)(478600001)(316002)(6666003)(10090500001)(97736004)(2950100002)(16586007)(6916009)(22452003)(8666007);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR21MB0082;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR21MB0082;23:riqWJZnrSW9jrVC2iHTSLclmSVcIcY1MvqahGcUgv?=
 =?us-ascii?Q?16uhHm65NdIO1pfp2mfYe6ZG+d6+mE9r3XYsRn2AtjtLQKBnCX3i/l4SfjGJ?=
 =?us-ascii?Q?Ay1bATNHE5EhYYW9w2/3tUQX+lrjAdVGpGMryxZf79lttQvCOHP0UBx2LyD3?=
 =?us-ascii?Q?bUvvDjbQmLWV/B6Zm67+yP5A6Mofl/rOojWV5qXXvG3r401HbJQkL+Hoga9J?=
 =?us-ascii?Q?6QmcMWWfIbR9jMFeqrUvGr/r8K+KUNk+7FO1DUwLpRJOcteOqZ9yuOftNHEz?=
 =?us-ascii?Q?CWkfI0dxfAHegtin6gPJXH2mImUEYhsSGwTo2bvgVDDS4ah/iPhQQl49Nog3?=
 =?us-ascii?Q?sRMkF1XLsXSWomicc1aqxt8OnfFfiWF0R1wVRZaLaSXyZL0ZYE55Hj4CCYUT?=
 =?us-ascii?Q?jWYUdQJ4G+9EnTr1VQIZY1sJmZYrszbYZQ06zqVWu7+BoCW4/423iiacT7Q5?=
 =?us-ascii?Q?dhJHgwqGpxQFY080GFRawL7eymGOkVNnadhfjBVJXIy4XwfnEAaaDhkoGY6n?=
 =?us-ascii?Q?vAH5OnBbtJCeYcAI6tG78Lm2bzOxXCxi3qATFGS07Ij9F2UO2VFu/ltes38S?=
 =?us-ascii?Q?Nol3CkzC89I99L7L9Zh31T9zDBuqlJ32G7SvtZk0DTcq11x87FdyS8LjRFIp?=
 =?us-ascii?Q?D4N0lHbDHqVHomU+H+0WmS6fUx3PxMg5RWFkpXdYwzP1Kzi3qlGXZoLpgyyh?=
 =?us-ascii?Q?iEk66MGxQGlSANnuJZYc88rvXiTsC2UDBEeyHhLjpJIf/H7qSW4rOT6SyPLu?=
 =?us-ascii?Q?IklTnYgcUIH/yrBKXBNk+kFsWOEDx/zr2Y7Wwn9TMDrG+iVu7y7wPgotgerp?=
 =?us-ascii?Q?s2yxyEi2HwPuoFI9H42EnLqa0HUeVboPz576l6I9Ub7TGqZrnkgYAcn8TL5a?=
 =?us-ascii?Q?L1SsTAdiBjd0oilNt0UQs0WzQNEOW/koEq17TmZReJ1Gz0r2SrG5wUrpGF0V?=
 =?us-ascii?Q?yBmYp+yUBHmg8BFi/uYcMJ+EWm9u7QtuBcGmD6yEI6aWjZalNSDyBu7aYriI?=
 =?us-ascii?Q?e6D8EVCG6T5ooLJRTS0Y4w0YQjStD+zV3l2O0qpDY4Gd/IuLQDLtsjzOZSwb?=
 =?us-ascii?Q?E1iabO76ydGRELzClZY0iLE654zXB6jgdlUfRtB5Q41totapWC9zwj+AzM+Z?=
 =?us-ascii?Q?NyM2zQrcSSjgdXqpy2pOeO7kXa2VkuNbXfyum5tWoKzuB9x94LkBvjPHWlhW?=
 =?us-ascii?Q?+NT376z7I9xx0HkqolyJyFNzRby7blbDUfPbUdMCRi7Lr6IDd7feZL8tw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR21MB0082;6:37dYvhvaQORjeTcqmEPithy3vvwdEh7gHMa/s6yyECox1xW/K0IjFNh9QF6kJ5lJQiqnrUwm/AYv27Tf9k3fGeVoaEOyEjtZRgqEVNbtsIFOvhjviJKvgVw8ZNiaV95DrKQ9WIGyAHRP41vP6zerDA3Rjtv1OAS3xM0nx8APEQgamR09aTXth2mcICh4cb9Y1qMr9yudBgj2krK1ZLUtd7Q0PgBAloiDCMIxfmxreNTZJ7T1zAsbOlghaoXqlWkSFhoW2BLPutEXCTng5Art24P+Xm+rXmAUbJIXv9OzMwmVuAKAq7sonO6KEMoDCDxFR7l9mNFEwk5GK9FlO1Xm5Q==;5:oOnEkBRxzqlEuWI8+Xu5fKXzsgxjF6gyDtI7dClqiHAnC19a57WnP8cJTDhOvcxwxvfwvquYzuzTHnju5/so72yxFev8MBdhIVxW/VxwNjktTg/oAlE+nK7Kcky8fyfWdXV2NJjP8cF3t3TVfkd0/g==;24:+vmlI33a+HOOY2msXEZ0fo5z1nVvUpaqhUU/8rqk4TxOd3C6bjR5jw7Zj/7FvsQ+X3yOSshvp4emfuIq9+snzySgFCASZHHqSQXhtYerSiU=;7:bpPOduov3CZv2f4UdSA/6Z8saIKmbw0iOCGBc//j5X6zXjWqoHpBRkyKqEc/Yz7bJAtfm6ygjdvlmGGXm/pAlT+qJvMsMWs2DOA476t9yLUi1sVMLUOzdknbQrlcLRo3EDF1RXFtE+KtvSCFNQrG81SpG/1Jvg17/j/65DlAFjBDFp8mwpaL56lnT8l6Io8OmXtQLTqrty7kEVX/zOfzziedGtM7Q4Nn8O7pc7luL3U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 16:58:15.4483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR21MB0082
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unroll the while loop inside find_unique_abbrev_r to avoid iterating
through all loose objects and packfiles multiple times when the short
name is longer than the predicted length.

Instead, inspect each object that collides with the estimated
abbreviation to find the longest common prefix.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sha1_name.c | 57 ++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 134ac9742..f2a1ebe49 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -474,10 +474,32 @@ static unsigned msb(unsigned long val)
 	return r;
 }
 
-int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
+struct min_abbrev_data {
+	unsigned int init_len;
+	unsigned int cur_len;
+	char *hex;
+};
+
+static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
 {
-	int status, exists;
+	struct min_abbrev_data *mad = cb_data;
+
+	char *hex = oid_to_hex(oid);
+	unsigned int i = mad->init_len;
+	while (mad->hex[i] && mad->hex[i] == hex[i])
+		i++;
+
+	if (i < GIT_MAX_RAWSZ && i >= mad->cur_len)
+		mad->cur_len = i + 1;
+
+	return 0;
+}
 
+int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
+{
+	struct disambiguate_state ds;
+	struct min_abbrev_data mad;
+	struct object_id oid_ret;
 	if (len < 0) {
 		unsigned long count = approximate_object_count();
 		/*
@@ -503,19 +525,24 @@ int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
 	sha1_to_hex_r(hex, sha1);
 	if (len == GIT_SHA1_HEXSZ || !len)
 		return GIT_SHA1_HEXSZ;
-	exists = has_sha1_file(sha1);
-	while (len < GIT_SHA1_HEXSZ) {
-		struct object_id oid_ret;
-		status = get_short_oid(hex, len, &oid_ret, GET_OID_QUIETLY);
-		if (exists
-		    ? !status
-		    : status == SHORT_NAME_NOT_FOUND) {
-			hex[len] = 0;
-			return len;
-		}
-		len++;
-	}
-	return len;
+
+	if (init_object_disambiguation(hex, len, &ds) < 0)
+		return -1;
+
+	mad.init_len = len;
+	mad.cur_len = len;
+	mad.hex = hex;
+
+	ds.fn = extend_abbrev_len;
+	ds.always_call_fn = 1;
+	ds.cb_data = (void*)&mad;
+
+	find_short_object_filename(&ds);
+	find_short_packed_object(&ds);
+	(void)finish_object_disambiguation(&ds, &oid_ret);
+
+	hex[mad.cur_len] = 0;
+	return mad.cur_len;
 }
 
 const char *find_unique_abbrev(const unsigned char *sha1, int len)
-- 
2.14.1.538.g56ec8fc98.dirty

