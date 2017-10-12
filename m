Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8299520372
	for <e@80x24.org>; Thu, 12 Oct 2017 12:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756879AbdJLMCy (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 08:02:54 -0400
Received: from mail-by2nam03on0109.outbound.protection.outlook.com ([104.47.42.109]:35352
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755854AbdJLMCl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 08:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=YJ40VNgcBAH5qefwDwimWsvzei2fCA+4kKzw7f6gBI4=;
 b=JfWrExbDx5//zAFEQDwASiGD6NFxHEN3uuWjiylcHxcvlPk55wZ3T1MkEkmc88yswbDi8rKh1aT30zXsBIMequyzTg6OjqlEmrBsC59F3DzL89CfFCqpDn333F5GiF9OS3bzSzFxo6HmFbNe3oBnWV7/Fvg3tb0es8KokCNw3uM=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 MWHPR2101MB0729.namprd21.prod.outlook.com (2603:10b6:301:76::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.122.0; Thu, 12
 Oct 2017 12:02:38 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 1/4] p4211-line-log.sh: add log --online --raw --parents perf test
Date:   Thu, 12 Oct 2017 08:02:17 -0400
Message-Id: <20171012120220.226427-2-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1.538.g56ec8fc98.dirty
In-Reply-To: <61168095-d392-39d2-ba65-823525239b5c@gmail.com>
References: <61168095-d392-39d2-ba65-823525239b5c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1::2e]
X-ClientProxiedBy: BN6PR20CA0066.namprd20.prod.outlook.com
 (2603:10b6:404:151::28) To MWHPR2101MB0729.namprd21.prod.outlook.com
 (2603:10b6:301:76::39)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6735617f-d1c0-4f58-c41f-08d5116922ab
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603210)(201703131423075)(201703031133081)(201702281549075);SRVR:MWHPR2101MB0729;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0729;3:a/DaacD0z36c5Een8Xl7S9VL7vwHT6XResRdAVUN5nqH8an5yIXpHTLMlKJ8iErAvEh9F5OQD5toOaBuOQwSyhxOr6SpesakmP72/uhix3kzKhAEaNyZs2jrbnoT0fBA/+6gI/cL8lWrudyJwmWq79OpjEJYmrBc7HcbxU8vzrSbYcW3rIMU8jJSfzA/KwGyswy6TjoudAwWYmt5SR0Zai1IEY2ypn6OFJQ2mHZt6/Ox77M7MurCOv1K7/5XFoGp;25:8JKO3dCpSAAW20zqKtf6sMyw4t15jbLh7A/bZy/VBKbzvGu50PVRbco+BpaOaIeAsWvEkmrCkd6kqbWuYzvWb0F1Zj4j9BYwWNhT5GeL1R6ZUJ0lvBUiVdCuO+y6DSIILgZr78yktxfg44OFc6Xkf14BPYmZ5iQqNA717sCPazB6dDZH6ROzpRLge9QxISt5uneNxbFOXIt+Jc4TyQRrYPj4hge4OEzANqif2B6fWZWF2ONH3sWUYLn9eSJFlqN8OVX9QUs4OWUxfI2rAaO5LNgw7LQMMSSlmcs2ajX0Z7uSwkLig1B5AU7XFsXBO062v/rcH8ff7smm/0Z1e8NHxQ==;31:bkJIGZvAiI2M6xBVWeOnXbFZPkxLTEJfHQD+SCsyCer73BRntvP8aRrEr9F5bX1Wsx2nTu/fVG1AbQMNmCJLftNDFRYBTuv0jgVGaBaTR2E8etwW8swz0jyEnBOiYa0jog3lZPIBVisi6+T1yBRGJ6jM1Ou3lLYnci4ratxS/kO/BDehkQJxn5GsJFD1iyZcMJFzb2c5vu6WeM8xpppESVaz1CwbFICMGrC/G3yrQJ0=
X-MS-TrafficTypeDiagnostic: MWHPR2101MB0729:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0729;20:lFj/UfkG5l4jA3H8IzOfycAApFpIMmQfiE18U9bmswezsQwUvgs+mJR85kj7dP8eER1kplG7yNyXdPnuUr3gqCG/I2M7/SdRxfmQYFu9TPzENf38xObCKLre3w4HNZ+OyCc3dLyJhH56JDLNG6SKyiQ8BbAb06xV8C/DcE3vqxfs1336pNqYzwjpln71E8qylitJ7tq+XAiWwKuNLXp/v3fSHHpnQZdgM65TbbopYEZ6VAALA3+cEbtgrIKabnyREDTzw72H0iLLPMpXZQzeI9H8eA1kIhCIbpGjMjJ0ovlDs8pLQMD3cggjqcbhswc6JOJ2V0VmfIo5zk4fKOlHJNqp80grwpOF47apXO32+Hmu8xPOrcAgRl1vkKSo+5yg8+Zji+diWDS9N441CHk05v2ZSbPGvBDUujlK6zwwUEPV01buR7QtAmIqjJeFkuQW+rg+EKVC+4luVyLOLErDK5RYs5UwS9wnCZEcbcYzqhNqaD2kpbk7q6zT32fo2AgB;4:kyIzUaG2sZAlSOjNson0Yr9aEBHWHkBg+jVu9dO02j6ojUwWlFfzMyCTtDjJEATScxrIHnqrT+BT2Qy8ogRVE61TMv2EJVl/CiC5PX1jrrgGE6JD2EkXeOpNQgwGoHlnEepYgZp+sLsiCMeLiwlV2BdBSMztbO0JxHX1mP4AvocTrSKkAFL9QYGTDROFwgj+J6VZVludQUE2Ze2oHChfwf96wmZaHCZeFk/ApA9lzJ9VLTJ1va/5S2vEKhUX9Z1B5Xz+/rH9yLbsELvq5EQjReHuRHHOK9VFJaY85cSdzog=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <MWHPR2101MB07296F6D9C9C2EEF44FD8C37A14B0@MWHPR2101MB0729.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(100000703101)(100105400095)(3002001)(6055026)(61426038)(61427038)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123562025)(20161123558100)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR2101MB0729;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR2101MB0729;
X-Forefront-PRVS: 04583CED1A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(346002)(376002)(39860400002)(47760400005)(189002)(199003)(76176999)(189998001)(1076002)(6116002)(2351001)(50986999)(105586002)(106356001)(230783001)(53936002)(2361001)(10290500003)(6666003)(478600001)(25786009)(47776003)(33646002)(36756003)(305945005)(39060400002)(4326008)(101416001)(107886003)(6486002)(97736004)(22452003)(50226002)(48376002)(68736007)(7736002)(50466002)(16586007)(8656003)(5660300001)(2906002)(10090500001)(2950100002)(86612001)(81156014)(575784001)(316002)(8936002)(6916009)(86362001)(81166006)(8676002)(5003940100001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0729;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR2101MB0729;23:n+DU3yO+daSWPyNbOcvEo3rphzHH2BoBjFY1HYF?=
 =?us-ascii?Q?hdXwdn5+zc5m5aONQxvgMQPvn3C6cHRCw97PtdxuF4eevmOeDenqqzjQGGZQ?=
 =?us-ascii?Q?m/V3tt17BJ8BJePeuSMEM0jlXi2atOUDdi9XbPya1qY/l7lasePHlryIC4zB?=
 =?us-ascii?Q?TQ+JIRrgIjPaJrFir7CKJ2irBDXkol0H8oN9ebnoK52x3ZS027eYAhSQQqIP?=
 =?us-ascii?Q?SFQ3GuRCWHOm0Nqf9tP0K0qUb6tu8ZtdxYPEi+iI4YUfG5bWM9AEY0LgiktW?=
 =?us-ascii?Q?fI62v13H6dkYFtXyiooMc2hAaMPXcLz3hK2oeOiRFfxR5P748/sART27rk/g?=
 =?us-ascii?Q?OxjFiGnyaumKsw9RH/RENK8Cb5YaQe48GsNOrID2oOB4xyyU8ECJJ8oQbTw0?=
 =?us-ascii?Q?fEKxBUtInNR3GkFHd2LA6jFIBP4uHzb6+AI5X57U1sxVqP4xswykRptux/ZF?=
 =?us-ascii?Q?2pxtZZhHA9WzEKT6T//Lt79VdmhmrVVyuaLYCV2b8YRB7xaEY+ookTzaTE+i?=
 =?us-ascii?Q?KyvfgbgkZd6YUMLA27l+YBR7h9zk7aCTk6952SRixRKcmGtCnlNFjNvNvtJZ?=
 =?us-ascii?Q?26DBDB3MXjjFGZx3Wgixz2wMvGMc0KevVKVt9yaEH86zEi9OUfPYBTK/Cj4W?=
 =?us-ascii?Q?94I1I6OEE6X92t16uFjiI7IT1p5hWRKjaD2wOqQ8iLJ9ajuk/O5JoC2oZo+z?=
 =?us-ascii?Q?bwJHJc4qwqOicfy/GyB21/uDxL+fxkNasotQ3ipefcP+sa+AFAkKQ80jm0Bz?=
 =?us-ascii?Q?0/6KxYEz2dH3tPcIRFyTPor8A/5QbK7XM35/Elc5EN1kcA9BcPgwukHzJHr7?=
 =?us-ascii?Q?R4FCQgjhlpE2nSasMNw4u6JZDStd7aKhGUCQPIhD6HrP14sa0wDzxyZKlB36?=
 =?us-ascii?Q?7FNjB/vwSfmqwcL/d7SJCP4j/4AvmMcI/zRaoS5nfN69qcgO1u8ctwzYbyWT?=
 =?us-ascii?Q?f+hB4/x46cGib/K2BjnfXfVo90i/5HADCDmen0xtjracA32G/jt87XTXZE5C?=
 =?us-ascii?Q?hkCKwUSn08zdT3WyD/M2Nv2VkNkrjW9nTRzR7GlvisLTEjcISIej4/7aaJPn?=
 =?us-ascii?Q?JoQOd4ZluQh8ZIDc4B1kyi29ogVAZQalfT1ANOGo3Jg/NSnxPFjv0CvcT2VF?=
 =?us-ascii?Q?URrL/ahRh/3gPeGnS1Fx0FRJuqrHo97MZAo+faFfBMasjDedF4MdOeoZg0Jw?=
 =?us-ascii?Q?Fx7t4Db00wgV3yXmhU4YOcN/Apy00gkw3UNWuve+hKnMGKKigLxPL1vItzAh?=
 =?us-ascii?Q?ZrFOL9VnWdknVJOYDMdBIqOp0wEPgsOSkhC4NlEPXaxIeJN94n4Ms8DKMRu2?=
 =?us-ascii?Q?Ixg=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0729;6:PbzF6mySXFGp7Diacc7XobqHOmb6vcqELLDLUv9klnFiUoPu2h1YfNBAsvsPFVYFn2xONfwdQpgawb1VYjUuJc1vnqrunrjcm5VQCLVaNzK/CkdtlGR4rkYDz3BuAC9CX3a6R/zBUBSqTOlJnzEMCBG19rlpMISrYo+cb1xBwNbZa3uKG6U1wYeMffj44DRU7ze4NE62AV8YXjGSmLXcSLaz6/isuSBR0voFryagHXCWl5IQcbxF3RY5fHXnNslZssDZ7Ha611zsyus1gHVC3TKzULxodFAhiy+Wq71owcmR8oRpewvXoYfKVUQXGikgV/lQsLcJS0HHo1zx8PNdlA==;5:Hw84xEeFc27BIrlxvPJ1O2c1uluIqN0GUluZaUI4C1YM2RL9pLDfJXqifFCSNknHzLf1kiItS3iKrBbP97RRQjElms99jS7bdTTNukYPVBOf2YWhgAD9P7DyZT8ZS1Wo2LHxRxkaLPu77n0auL7KE7+HqWKh/tv1nTiywchtTPg=;24:uN5Lu0zddvbBWMvV0c9wmfvhgJ9l8agZg+VzfAAeyiLve1zXcGEKCIX3t1SaRPd7W54qFqecS7jPFJPoMPXCk9EEGAAWyp8rt4EbHeKKatM=;7:/os2dXL4ALditZIQw3LkdnQK6v3MZn60UYWWL2ipCjNiWtbr4ggrl4A/CFnXsu65s4m6nxilqkc3CfBQMUyyo3x72Y557uE1sCh3JcBge5gEPBT24jqs5nHflXxL5Ys4Rd4iKlIV5ehkqS5SX3TVhArEJIa6IDUWlLzewvnH1+fRdg4LtdFbcUqx/uKj+Xov7L67erI2e9loyLsPOYnT303sFjefTQHw20is6I2xQ6I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2017 12:02:38.6213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6735617f-d1c0-4f58-c41f-08d5116922ab
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0729
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new perf test for testing the performance of log while computing
OID abbreviations. Using --oneline --raw and --parents options maximizes
the number of OIDs to abbreviate while still spending some time computing
diffs.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/perf/p4211-line-log.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/perf/p4211-line-log.sh b/t/perf/p4211-line-log.sh
index b7ff68d4f..e0ed05907 100755
--- a/t/perf/p4211-line-log.sh
+++ b/t/perf/p4211-line-log.sh
@@ -31,4 +31,8 @@ test_perf 'git log -L (renames on)' '
 	git log -M -L 1:"$file" >/dev/null
 '
 
+test_perf 'git log --oneline --raw --parents' '
+	git log --oneline --raw --parents >/dev/null
+'
+
 test_done
-- 
2.14.1.538.g56ec8fc98.dirty

