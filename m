Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C84C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 08:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbhLII43 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 03:56:29 -0500
Received: from mail-am6eur05on2061.outbound.protection.outlook.com ([40.107.22.61]:64384
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232964AbhLII42 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 03:56:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F27/4HJtRR467MidcXM2t0ykJ07NE0MKHcn3SML77UwyyHcCLbqwDM5TpKBZVoLQ3mOn8ffJ3nSmrqoPlVFN/PUhrPgSHKVqOWixZTJRBB4sRvGBfcFMJrs5ZkF5nZINcunOV3oToP6hO3gQLhf62eoXjwOAVLqcH+C3UFnAF6iBRBgp7IpCpTy3bdYc/Uc6vFkGAKYwgkTJiWCIX3eR1bdabxQgQSwm59T+rhqydsfvsxt6zQri3aUdAUs2dB06jkR3tENgO8+4IfOGYcPTZQl8bSHzgLgovgxyWpoKtcPWOeUCZGnAFU5OySmM9DdBt0Hy0+gEVlP5WOPaPt/JSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6ru+Es35gS2kbjH7z59FnIUypNKemjNa//yMlOshns=;
 b=QrnN3BLw07WH+ex8xn1M8kVTK8ELWR8DlikY/vTgK42rPALGWtXlifOzxHCPacDw92JlpsqVOJovXANJVcVBzxgl/oEaSxvkx/p84Z74PFFwkTSMas9fiip0HehwIJzbUejYkeFd+3uF2DJILCb/5VvwgQtUsC32ChXvui1UEBbvA3ObaheeMkAOWGX93O42hK8Yzx+GvbXwyfzXz9KM8CJAfgYbuQx2HgsBJWvVyIoEGxHWebP31d94ESnl9hTQegoBuzJxoPH89va/3W5zl+incOF7b5eUFSOkhVSRf8ATU7x3deyVRwUxQy1dMGYztfN/Orm8gBvaBr9if56BuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6ru+Es35gS2kbjH7z59FnIUypNKemjNa//yMlOshns=;
 b=uhjHkPtNZCS54pCvkjZluuQRiGY29688yDxq14NbVAEbZ4J+xzniNPjp379LF27W3SXoXSISBmxxsLNOCbjVbEqUYxjrl4m1m0vZYUB2p3js0yS1b0B3gX7nPyra1mv91W/AJJImv11OaYVsqZzPvOV1p5FSYxdpl+pMSzS88rg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3851.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Thu, 9 Dec
 2021 08:52:53 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Thu, 9 Dec 2021
 08:52:53 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v6 2/9] t/fmt-merge-msg: make gpgssh tests more specific
Date:   Thu,  9 Dec 2021 09:52:42 +0100
Message-Id: <20211209085249.13587-3-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211209085249.13587-1-fs@gigacodes.de>
References: <20211208163335.1231795-1-fs@gigacodes.de>
 <20211209085249.13587-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0187.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::12) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AS8PR04CA0187.eurprd04.prod.outlook.com (2603:10a6:20b:2f3::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Thu, 9 Dec 2021 08:52:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d8f7f45-32c6-487e-4d4a-08d9baf149a1
X-MS-TrafficTypeDiagnostic: PR3PR10MB3851:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB38518AC349FFF5D9289ACE7CB6709@PR3PR10MB3851.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: scuSjRABQMOi9sCsBPRbr3UjWD9p2vz0AIFgYv+F/cHBR48JWqbZpcJuXKXHUhCw45/LhfHVFRGYn2oG+7XCJPTfJYWWEflLxUMuZHVmKoCIRdqTpcL8WwO7wxsfhwH5mhx8fVvs89A6rrlXjWJrk5Z2AznXwr9XGm7wkoYGU+Vd8V8MSlvinSNf6LacxLx/T1PIykLMT/bR/z6KECiNvy3/grRBlDUpKUHSNsp87o86w2gk4WYpiaR6MYHGAiLFNypfq0lKQqZaOF2UbfQwhylVC2x/H3PnG+zJpriGjnVJZvF2I2p5r5+iQZ+ifKmuq5nQf9ED8iTMoKU7wrOsZe8UeO/KVJvO9RQfvzHy9vQyHUJdjayrlA34cPxLv9JLBqX/oKKUR/KD1sZfshlUX/RmNTbKX+u9ekBq/MOVeTyoLpLBl0ymx5K7gLPVh2YbdVMBVM2bueYXn+w9mQ5OzGJROq5FyTUDRwZYCyUmfByRpwaicmEFE1xHdkOJPyr6/tDTEL2IcUa7YIX9g+TCP7royDBRPpBikM0l790U8rriabJDnwW3YZjZnUxf6m0rxftHTKEIYmYOFG6KFnZvmHLPcqyUVS00zLanD2XhUHxyT50MCdTFNlKPm9qhCcVxTNST9Sne3KiXKWLcT9+HZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(396003)(366004)(346002)(376002)(136003)(8676002)(4326008)(36756003)(186003)(316002)(6486002)(6916009)(2906002)(86362001)(1076003)(6666004)(2616005)(66946007)(6496006)(38100700002)(83380400001)(66556008)(8936002)(508600001)(107886003)(54906003)(5660300002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rbBDVtd45h0t8qSrKZVn3p6CtJpjE8lE9L9xpt903uHBslhvvKb6/Nfp9g+O?=
 =?us-ascii?Q?dSYqGNVMjZzMBt/X+IrQCWhuUCGmrD6lhLgP41Fomypaa7/fJc+cCk+KFeyc?=
 =?us-ascii?Q?I5VmSyDzuBUpz2gvsK95QEaZPJhzgcbIBb3O+rKT6yVudRpA1FEStxKkZ1No?=
 =?us-ascii?Q?yuYpslQ8oLLTBUeGv+O1063TvUpsaW0xv+boMtf0dQIKDBuBikUux5P8kdyi?=
 =?us-ascii?Q?2pQq0JzJ7IU76gim7HHJdRfrxMmolv9JMYBnRol/CIDcVeAb9NQDlejwCa1U?=
 =?us-ascii?Q?+BGAjTes5Wp7bM3kAGbl2tNWh8sy2vtRyZrFgNPeQCKR/v5XaBjpv9wZq+S/?=
 =?us-ascii?Q?qf9A3ZFafpMsa5xeRLLmnkmtfina/ujAqdILbp74BY9II6pWNOYYS8wzHzA5?=
 =?us-ascii?Q?PJ5bFMgjE5C3aSBEGVlW2Y4FqaXOTyz5qoticYU88y8/WQc23Bm686/pQ1Cy?=
 =?us-ascii?Q?4Xix1in/YStMEfctZ9KsLm6JOXqKg7bgvrD78EBqxBBL3IXpJz9M94rcxmcg?=
 =?us-ascii?Q?3c/Z1QwkqURJP+hqltbtAXxmlvUHc4u0Cb9CwDMG5omeuNMgBGL2m+5kR3Qu?=
 =?us-ascii?Q?WshYUcVN+SuTBDqsQgjUH8pD7v522bqJJeYCDVevTinUUEhMYn4Rzh5Mxp5K?=
 =?us-ascii?Q?jLvA9zcSZrYGQGPeWDDWGW9Yrb3ZaAp8fixKLvUJU2REv+ou72+WOSjIzG1U?=
 =?us-ascii?Q?iIqIVS0teQkqxCUGeFPxrng8U0xU7/czmnHmg9jVyEdUZl7H4c2PsHlxwEHe?=
 =?us-ascii?Q?kCI0WuFj9teE0VTPzVY1kx8zW6WzSykMXrfxz/X3aBEGqAiZVlIXiFu0d3DX?=
 =?us-ascii?Q?NHEHBCd3FZCyaYl5+yskIu98xbrNyrBt8qNHFJ7rT70QeB1JYm0IX3fBO3zL?=
 =?us-ascii?Q?w7YvDRF7E+w20z3drhMRMSc+jkmqzDTMgSXnaeMGHWs2aD3CNnIXSi7GSrUa?=
 =?us-ascii?Q?gTy+N0pWmk5zqqlZZh7LcsoIuruCT/1u5E7cdwAOdS/mr985qJKOYPnVgKJV?=
 =?us-ascii?Q?iPqS68k8AgnBH7S+2MlzFj6gKlfQRB0kh0S0uJbB2j4a7I7DFBJx53A9G5BA?=
 =?us-ascii?Q?PYvisiUxrXFHHb1NMvbNvM0vZwSrT6WPJBtO2cnVzFuLzFUSLCHSRwXyZO/3?=
 =?us-ascii?Q?ofAn+b13cUnbyIcbV0CdqemLA6rGn7KtSr50WsH29L3BDR+LzWD0eaPyY78k?=
 =?us-ascii?Q?SCootId8F2YhzSkHw6dPD6AeO0QYXt7mc0CxmAmkLXcwJxtaS0lBCOwZQQ4B?=
 =?us-ascii?Q?JQXpHCWNf7v7eSxvR499uAe+CbphXuz5tOEMPWDWGI889YF5Q9hxdvlYocsG?=
 =?us-ascii?Q?B1d2hOoVi+J1mvtLFs4VXB2KZPEFPf9at10vfE0NslVsQmfKCn9j4Rund7Tb?=
 =?us-ascii?Q?0Bsf9o8lwRs2Nap5fa4SfM3D/cAMrjdwJrNRwdnyBCbFR1t8eIVCBwDEMm2M?=
 =?us-ascii?Q?qwVzwepKSJjUrOig4tHAochyqVbJ58iQ+XrvCGmThl6Tb9MQ0opyY3GCfk5F?=
 =?us-ascii?Q?TBtCdKSbRiQ0BYulTWhYPGjyfaKLIA67B+dJ5fuhgxe2vavXzPuFOj/KdpVy?=
 =?us-ascii?Q?GPUF/Ep7baC9Xz1sIU/zFFl4Eup1fXK4GjMN2HjQo5Q+zc26JYZE43QU3iCV?=
 =?us-ascii?Q?K8mkkTIheh/n3pUz4kGJl+A/KiakKaawOhJvjEi3yPbzFservVLigBEsshO/?=
 =?us-ascii?Q?zsYE+sMJm35SxjrZa1/PHyhB9EkajtQomiNuCyN5YFLQoDRBc+9mEqOrWwc5?=
 =?us-ascii?Q?5vVdF7iI/w=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8f7f45-32c6-487e-4d4a-08d9baf149a1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 08:52:53.6033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8o4mLMw+WykIvo+rx/jF0tLqH/ul7jg3hS48MH5BJk4yWN+L5U6YteepiLdavpKkA93IEOxc0m9QXSPVuLQCRv+Ne4fc6+IGH8wUJzhz+nY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3851
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some GPGSSH fmt-merge-msg tests were only grepping for failed/successful
signature validation and not checking for the tag in the resulting merge
message. Add the missing grep for it.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/t6200-fmt-merge-msg.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index cc68bba064..eb2a9a4a78 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -124,6 +124,7 @@ test_expect_success GPGSSH 'message for merging local tag signed by good ssh key
 	git checkout main &&
 	git fetch . signed-good-ssh-tag &&
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	grep "^Merge tag ${apos}signed-good-ssh-tag${apos}" actual &&
 	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
 	! grep "${GPGSSH_BAD_SIGNATURE}" actual
 '
@@ -133,6 +134,7 @@ test_expect_success GPGSSH 'message for merging local tag signed by unknown ssh
 	git checkout main &&
 	git fetch . signed-untrusted-ssh-tag &&
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	grep "^Merge tag ${apos}signed-untrusted-ssh-tag${apos}" actual &&
 	grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
 	! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
 	grep "${GPGSSH_KEY_NOT_TRUSTED}" actual
-- 
2.31.1

