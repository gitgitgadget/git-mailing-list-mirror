Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B63FC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 09:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240296AbiCBJDs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 04:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240307AbiCBJDq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 04:03:46 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50069.outbound.protection.outlook.com [40.107.5.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9091C1CFFA
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 01:03:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwju3pQ1sXg/sM0DgHukDjyOm1fHl3Vo4miOfTNxXvvfetoSSdJdYPMpbjrCoLm04qkmx8iM+T7vxVIfFWOteJ6zR5BEouYzLLqSpfKIzVDLDqUtR2CF1+jr0GN0xxTXxhHnv1E9Fjj1i15jqP5uO5ahTEh3bAmUh9nwfNbEl+pv6PkYxQy2WwNAhQiMp6vSgpAcU2jrfG84kwVuybeaQFFLjClla2iQ+YXm2GQhAy6BYmDOYLSc1bInHCdiBRCQsBdNgWoir08xtBiTTPfBb6P0bd7mZgUP2w6JvMoKfTNzHyvxlG2KCZrtJoGKPR4RhMSDSlRKTCiU4HAZQPvppQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gzEmdB7TOjJdgm5yNk4kfNj0jcmrRCgK//WSqqvDLg=;
 b=CHSaD8P94OXkZEW3V4YNeoi1HXyAXxIIymFWGwqhnZqqA0LHYtJdMoFe5FYasyK71SyQ3Hi2AvajpPMFNmR0ZN8nJH26wipoIBfCIqbuVe/IBYx3P/AVP/j4kLSbxXMpl69QT86WPAyZUxiBC3GTW9LgjExGRr0jeaaSGxAZ1qfV7DiBosEb68LXD6VtLohOV4aLuHmbbBF/I/6fG21ifeJKxZ4nrc4U7jRgN192sqJF4x1CXRtElQnq2451BtYhdxYnq4JzE2w/wLBhtcvddhqpqKHrgKq1UjQtIFm/jdjOulXWUxWammrnXoXusKF7uJ1YTGNxWj/fee7kKNs2NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gzEmdB7TOjJdgm5yNk4kfNj0jcmrRCgK//WSqqvDLg=;
 b=FM/1AXeY15pEf/FaAYbcmqpAjmWrlkc8RhBTSYufQvgIjbyhRkkVln74cM8X9s6eZ1LZuBzz5q2+Lk0zdtt7eNXRJk1cG0B60tx7cv9UCu2O7WGmKTOzKCQ9EVosMK3MMQAqHyLcpKnrQdUkW+q5DWBUTVCNUnbmlIZhKn3VIaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by VI1PR10MB2015.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:38::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 09:02:54 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::116e:6242:98da:22ba]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::116e:6242:98da:22ba%8]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 09:02:54 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Todd Zullinger <tmz@pobox.com>,
        Henning Schild <henning.schild@siemens.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/3] t/lib-gpg: reload gpg components after updating trustlist
Date:   Wed,  2 Mar 2022 10:02:49 +0100
Message-Id: <20220302090250.590450-2-fs@gigacodes.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224100628.612789-1-fs@gigacodes.de>
References: <20220224100628.612789-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0064.eurprd06.prod.outlook.com
 (2603:10a6:20b:464::34) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf8ad8e1-d100-4c85-4fbc-08d9fc2b7017
X-MS-TrafficTypeDiagnostic: VI1PR10MB2015:EE_
X-Microsoft-Antispam-PRVS: <VI1PR10MB2015C76B19DDE19698839DD0B6039@VI1PR10MB2015.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3K+LaGpc29xgGMEVF0lyCRzJA227xvCSZr8GtikTNlA3W7aUAlZGU0KflUweycRFfVemtSa0gQotghl5bcf903ZzFI5NlMTr8/hhSvl1Oc79cgYbns9kzWH2ybO4wuK3EjV7LSP0qZeHZHNpmuBDBn55JF05eKQqhfdzO2iROKFfM4a/d9KVTJs2LACbaAeM8jTH448MLmxaw7U3pQ5ICDF3FrkBJgHxfEIfKy34pVrdjQg1LC5iE9LpVYOkjuzZ84G65Iq9iYAOvjtYaiZjZoFG4mKGfzDQXbi+gkDcFJs0bJTvhiRX9E5gdx58OcE9UDsNRXVD9rsnzUi4azXTqd7sgKPeXZbGW8KPT9MbDoXVOvn1xZivzhWuDlUHDpENK5kSJ0g6ga0XWA9mPcbxMUghsjdt3RCgSLogMDw3u+l8lej3cH35kA9ZYV8V1zvSIJE3QobuewtoNq0W3jVzSkC38sbF0ywBXW/QEQl15rmkl3MFK90108VtbzjZCIwxwYBIfL+zIeRyrax1k7y6ANOMOKNiTDsgUpCx11g0AyWenfoGhNobrrj5RcWffzZeA2jKkjc2JoL8IcVJeHy0/7f2aKhLJY72cfJcdSCu72xS/SY4sm5ZFJd920MrgDMUh1daelYbDaAHnBd820Rf5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(136003)(39840400004)(396003)(376002)(346002)(36756003)(38100700002)(186003)(8936002)(5660300002)(1076003)(2616005)(4326008)(6916009)(8676002)(316002)(66556008)(66476007)(26005)(66946007)(86362001)(6666004)(6512007)(6506007)(54906003)(508600001)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?APst4oCAeCJ+/PlJL4w88wntdJ09RFm5+Cx5on++wHkeJVQa3tZPyOt6BWSZ?=
 =?us-ascii?Q?5VHffqZ4i4tId6ddJ8NQyBSux32N7pToBpTe2UADGvceaYwhey9WgMRrito9?=
 =?us-ascii?Q?UFTAQ5FtSq+23Nfvt2PbkrL3ERY7l/euEf+6fJ61iYDlUZoeCk2fZyu3qfdp?=
 =?us-ascii?Q?EKFMlGD9TVdm/607Pd7+9aZMupcC9xXe6/WhmfgHNyOOw5TnRAZRcEi79mMc?=
 =?us-ascii?Q?0p4oZmeopLoXdkLF2ZHxLxd8p2Vhqi7bD50Bk3m4sabe0XirWcB2YimVYU6t?=
 =?us-ascii?Q?psffKSCdhje4sztEnDc1BRhyouYRXcKBzpb0WtlwYJeRvkmEgsnuwjX0njeF?=
 =?us-ascii?Q?2bx6GdJ3/wOyrrhG0dEwFV5rJWvwZQF+Uon5xN2a5+dwgXpY7RFYmRSDb1vs?=
 =?us-ascii?Q?eOx2GGIwpcYdXy8/yHQ17PXf6DGm2VSVZxPQS+c6vfhFF9OqEzCSJ+JxI7Zi?=
 =?us-ascii?Q?nNqZF1mwriy6sS1/jfFL7LEyYW54M8tiYwJMCf40cyv8O18PlMU2/Q88chpq?=
 =?us-ascii?Q?fz+Cpy5daFtCV2J2sxm85ULqyH7xR4uOzMP39d3joswngHUc2qUqCz0YUvHT?=
 =?us-ascii?Q?JcJx4akzY59Rum4zGYDFjI6nIaG7mHH60pADYpHHAMTIopDoRWRu+Vf1u166?=
 =?us-ascii?Q?ESv4tZCaYWMrXD33IbOCwRAw+Jiuf94Eza8sAh1tmAo6Migw4p5sfSXyobwJ?=
 =?us-ascii?Q?msiKx5/QqFsLU6a7Z1d9TKw0ERFRmEAgvWzRMqH2hXIRypR5wSUbD3bnw3HX?=
 =?us-ascii?Q?gutPXSe4GTNLNi9oFC5IKqU29ECdhtyxKDAnFCRCCzdNczFnnwaQFXq0CNFI?=
 =?us-ascii?Q?HLotj2hG/p9HAG5VvgaowOYNF2Fm04QryBmo9R8uFWVZddNYYEtPnnDDSQk1?=
 =?us-ascii?Q?a7GjedotWbmEnlYqh4QmlMzazqUR8owqyz3CSP2nur9XT2491bABmxNyP4Rq?=
 =?us-ascii?Q?hhFxb4T5kCfV/YlikZjfM46yhpg13IZCV8zgzSYbsseZGJkeaiz2sTJnBfwO?=
 =?us-ascii?Q?V3Nz6IkIcw/XUA4uyhtiS3johmaSzIMgyqU0rOMCMjIKq7A5lCJ+yiNURwvs?=
 =?us-ascii?Q?6JcE3G00rmPwK34Gzzr5f7j1XHy8P5hgVwHpHlvPs6H0oDNaHUB5qtZ1JZ0J?=
 =?us-ascii?Q?E3u09y8ltSL7XfyzQzuDON+KF1vwJCuoXBaHn9ZR2hxLT8bLfnyOgF0HnEjU?=
 =?us-ascii?Q?t1kib6qFTS1PcdOvmRQwotu43qwWjA20gPylKRlfXJcQSC3UkWRxm5qkCnSU?=
 =?us-ascii?Q?W/QZIqrax9LhoEYHUPCPM9vYrejmEJ2sUYd1pVDOKhsonumOi78OCxPzr+5S?=
 =?us-ascii?Q?0hIk+s16RmwBnOMX+1tfaTttllaikgNb7nwmRhJ8qyYaWq49hBj/Ii3yDd09?=
 =?us-ascii?Q?xNdCmm9CI93Vn+dUbC4DXLBtuNTRO98sJVn8rPcL8e+4het7ruLqMvITU/Jv?=
 =?us-ascii?Q?yeJWktPbXavmUnectmIHoR+m3NBTTP6nutuMO/6clsxOQm8eFAZyIcJD4Glb?=
 =?us-ascii?Q?nqXjZ2kuPocgzkUYtzCi2CFsntrmwpE+9WFzHmOdpvHfu3JKP71LSkFXqyMI?=
 =?us-ascii?Q?5Av4btkLzp8RMnquOlXQ3ov/6bbar/9EKPxplvWe76zAHqHB19fjzaLtuzyo?=
 =?us-ascii?Q?zqLj8xIvf92RsiOdHTSc0cOgIQZIgJk/EgvGbkroYOSNBQmzfj0fSdFCwNKl?=
 =?us-ascii?Q?347MlW3q7MYtUM9Pr+wXwF7ONT4=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8ad8e1-d100-4c85-4fbc-08d9fc2b7017
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 09:02:54.4786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQn1UcKlIaJwFqDF37P28zwzRRh8moVLQAp4YOVd0iXkRV0P1f3XYSqCbU2kV9ItN0kd/46k/bxzKLZ0+41RliMI6CqMY+3UoVQt/L7qj4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2015
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Todd Zullinger <tmz@pobox.com>

With gpgsm from gnupg-2.3, the changes to the trustlist.txt do not
appear to be picked up without refreshing the gpg-agent.  Use the 'all'
keyword to reload all of the gpg components.  The scdaemon is started as
a child of gpg-agent, for example.

We used to have a --kill at this spot, but I removed it in 2e285e7803
(t/lib-gpg: drop redundant killing of gpg-agent, 2019-02-07).  It seems
like it might be necessary (again) for 2.3.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 t/lib-gpg.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 6bc083ca77..38e2c0f4fb 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -75,6 +75,7 @@ test_lazy_prereq GPGSM '
 	gpgsm --homedir "${GNUPGHOME}" -K --with-colons |
 	awk -F ":" "/^fpr:/ {printf \"%s S relax\\n\", \$10}" \
 		>"${GNUPGHOME}/trustlist.txt" &&
+	(gpgconf --reload all || : ) &&
 
 	echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
 	       -u committer@example.com -o /dev/null --sign -
-- 
2.35.1

