Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF58C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 10:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbiBXKHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 05:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiBXKHH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 05:07:07 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150048.outbound.protection.outlook.com [40.107.15.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9006B64C0
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 02:06:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIIQoVeZ4sZSWQ4BDfH0qM3TGrfLdthIY4dvTa7nKlhQRlwfKfCKRmTLPWlbiqxccgbokUcveAJGaWjZmPXkqkKXRIexy0WPuvyAeYx2fQMasVOhaJf/lxJpszimTb9orOho16mDeahNZiF/ZSWz77WFY/nb40xkj0mvE3i4x27zfRpBxEU05OiW6GdGqRMnK7jZCGrQrtYnIrahGIT/Mbr9ldE/j+7FLJ+b3mgczyJdaqx01EnoDF9fmclPjQABFyn/Ow89AjN6fPXw9ubxCVSUoyc68Wf3SL/K2FR3JDqW7nIvggFqS8/p7lSJwQRlmxZJIs5CtFmlxTkKSI4iZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mp3CMNMTbgO/xPeP+EKXAIAuT1Fom572fodin7/55c=;
 b=MD1IZFiCIwlZdd2TlZwNZUm9xyjKAKCkj25tPwc1/hgFEMZCM+m15cmp8wRT4te257HCcI8Jekxlg91N99z5Kx5clSrIqjClqqGViNdDTGxvzKmX5pyTt/K8+iUBKq+4Mcz3f6SDf27yTz7JZ5i6YvbFHHFNmQDrQTN46aKJVutAD96dMZ6XszXNoNLensI+v5JTGizWnXIeiKcQenmdbQYmySRmVxnJQLlPZVwRvvAl0cATm3kSxWdWKppoN60jS9dmAr/Mz7aNrjnp/eokrnrAIugZZ+xZmvdqL67+bR1hlNnUGFu2MHI+m6YPrcZyCPkXeE/26K5DdrI0LhnyWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mp3CMNMTbgO/xPeP+EKXAIAuT1Fom572fodin7/55c=;
 b=u9r2qspt02MPIZ+lXRPcM5knyh5WUrYKJXRemm1jHz59oznGZ39pLf1iApNYH82snYsWXzfX+X6xOOv+XZaTTiYKqrIZVPdwVRh5X+eJY0Jq+gU8e1BwqlcVxTieWyEyldOi8wDWqmQyZTfaWXYpv+zC7VhMgm8UhxGb0ErWwqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by VE1PR10MB2941.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:106::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 10:06:33 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::116e:6242:98da:22ba]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::116e:6242:98da:22ba%7]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 10:06:33 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Todd Zullinger <tmz@pobox.com>,
        Henning Schild <henning.schild@siemens.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] t/lib-gpg: reload gpg components after updating trustlist
Date:   Thu, 24 Feb 2022 11:06:27 +0100
Message-Id: <20220224100628.612789-2-fs@gigacodes.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220203123724.47529-1-fs@gigacodes.de>
References: <20220203123724.47529-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P193CA0100.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::41) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 449f8982-672d-4f49-b20c-08d9f77d5599
X-MS-TrafficTypeDiagnostic: VE1PR10MB2941:EE_
X-Microsoft-Antispam-PRVS: <VE1PR10MB2941BAB6DB24FD4CD48D30DEB63D9@VE1PR10MB2941.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EsgvaGXciNv8KTX3//VWEUWlQLHluJzvv2Ig6TS2RN1MqXqediuIVxAAgmBoujv7A5hrySxfbRw9UOJqkWP6O3faQX1GxcI0zcnnyXp0inuUwMHlWLCtcBDxOLa1KCvYoEXj8vNer6OmWwiReDtTocecGTHHcrlDaYDpC0R+HCL5d8cOLq3wZ3AWPW56jZawQrj7tgYx2l4IbZ2Ukeor1CD1aSGhLbF82lJ58eZiPUDLpOfoag4sC8LGgxPb64v4IcdpB/aq/crIiV1A/bnu9oiYZVHramUrVhPs/4RF3WcPlW361tbRxJbSzhh0+dgCVIbuYJowEPzvaej+1uTer0SrFn774R8nqLZS9A6T9GWrL48tWUYpyVbuyRo5J05oSX/1mBoQy3BjC8Wql50H6KUDRirXhP4QUShI+kXRYv5cv3Nd1OXkEFS76JTCvCg9Sa/h9WoezMIXPneFQA8j52F8nJ4RBrG8TVoEBOV3c7Y9MoOsOa9Yy+aAUSy103ntiQPYYPS26JDROfc4gm6ZlUYuAdM0C1H916osG9QVJj7bF6u1jx5q18advLiFwVhxbaHumg9P44e5BdhAsR+9pPguaGvxVkgZb1xfbrKBBk0kBOjYkWqvATyiQf+0VjGZWCMWz8puDir12mufVR4KUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(39840400004)(396003)(136003)(366004)(376002)(346002)(26005)(86362001)(2906002)(1076003)(66946007)(66556008)(186003)(8676002)(8936002)(66476007)(4326008)(6506007)(6666004)(5660300002)(2616005)(6486002)(38100700002)(54906003)(36756003)(316002)(6916009)(508600001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NUySGDzlF71955oGTB5JfpOxS3N0QhKGvRGqgJPdhXgN53b7ye0JwvFmuRMB?=
 =?us-ascii?Q?T+iWLoC/wbRMKCb6292hnVIEZzwV6nbsbcxRYuOGq9ohdWek2QFnaZ52uU33?=
 =?us-ascii?Q?Nk0qvmfK9aJgxWSBJdw9t138KaOscVfuyUfWRgu7F0xe15uXEPpwT3PHHxnn?=
 =?us-ascii?Q?3o72JJJoADvREUCBtysRBdYj322cWT/+OnKZJ9eW2X7NoeHnUq80SVk+LltC?=
 =?us-ascii?Q?p5JQAMbuso4kMPRsdQJ4UgvFWsEkoi/hDJWDedtUjRQ0GYaAT3SioRqgwGkK?=
 =?us-ascii?Q?rpuFW6FygXqwrwTLf1BJPrD0LCuVvVOI7IGZxDR5okrHFw1M/OIQSB+K49B8?=
 =?us-ascii?Q?xoAzIakaynTSs91i03WyB1Yi0DbAHUiwXzrtrc44l0V/GngvH/4LruAW/W/x?=
 =?us-ascii?Q?V8vM43S1mSiTxrlZ5xX8noQdhCPGv7Rj4jQAJKZwnHft1xEJjGr7efSeETBI?=
 =?us-ascii?Q?7UNy5SdW3gBFaLJkvkTt4WqoEDFAXfMZGam7b1FymjtSKo8SdfvKOxfXxbKg?=
 =?us-ascii?Q?JOJzQjv2Dy87kVYNDe0DHcCsVhDoU0uxIZc8KNFrwqDrD302YhRd4YGTzjy7?=
 =?us-ascii?Q?xdYiYX3JQI5DcyWnhWmx3bwZD5CYMP+ha658QVN52ssk9WKOJNu6a8XyRjsW?=
 =?us-ascii?Q?qyyRKei33opicrBPfVaeOMyAj8deav+RO2dQW/e2rCPUSgt+iz7T0f+uw+qO?=
 =?us-ascii?Q?8QWr+4INXl0UlOYkNrDIDeJw6CfhBw3dhSuw91eOOPG3MQszl43C9cq3GgMd?=
 =?us-ascii?Q?N1UkbC8C0YyqDv7Xf94O3QiJvUwnFvNwfn/qs7G5Gn0JKVUTWNPRicgqp7MN?=
 =?us-ascii?Q?FzhMHYQb7IHFk9sbvq1YBt9bO854nIm/O5dhifSjeTvbzggV0TmpJuDYS+vP?=
 =?us-ascii?Q?3oxBkpTHd6m6KAjB86LQY/Io3Oooji0QkzHsdYmS2kNhwTdsWvr43Q6p5Fco?=
 =?us-ascii?Q?hFVXx9Th3W8koGsD9zCECh3PVfxfDFhtjsWoikonN/Azp9xDDpxfY72PPtPS?=
 =?us-ascii?Q?YAmdUvILhT3SZcrdWkrXPD3tbvUqKmhMOErjUvmEfLgL68QidjS62fRN2tdj?=
 =?us-ascii?Q?wV+GOcQi2XTvSz0jVL9pPlecSOoYhBsKXroCk966YIPKYr4jG8CiNjeMh0ji?=
 =?us-ascii?Q?v3LpCKm9M3gcytLFo3nAnTh8Q7hcQ1vPpzKZyh9W4iAXGJ2+3EU9fTm9E2kL?=
 =?us-ascii?Q?gbXg1z12MSuVbhX7TKnl8AFgjoygHEuZjBXJD53z4tYJoZRYoA/+l/Q8cgX2?=
 =?us-ascii?Q?IdP85qOkPGKJFvDBIySLbmzqo1q1ivwKt6ZqfvegQuBx12R+buPNobKKsHRI?=
 =?us-ascii?Q?DJd2gKpjS5icyP6SmHcyQ79Wdkcnklw1Mhdbso21RwB8uxq/oARsN3w4MRk1?=
 =?us-ascii?Q?8NY3oQx5gvKrvmCqBxI3GgUmDpfYB+HEgTDCG78b/qmcdnkvN4KP09U59uRQ?=
 =?us-ascii?Q?TdlG4MzVWg4d6Rxn4Wg6YA/IHv2Txeh3h4TR1rlGyymFiP5yL74Vvb7Vfw6/?=
 =?us-ascii?Q?RHM5aTCoe72bqkCBQZ0wH1GCg9T6AZ++8mhfWiyfTMXabIpig8y7x52JrTKO?=
 =?us-ascii?Q?eX36ZYMXC9l15EsqwQDX+8PNkI4vo1XW2Ds8UHz8EAv6CWBj4NGTrpL3ypBT?=
 =?us-ascii?Q?YBjCTozAZ+qgc0OxcGjR5p9OM3myGu912CSTn9cjeFoesXqIVlZTSHgbbu1z?=
 =?us-ascii?Q?nSaa0OJCNSsG1WeOOV8/lguXvqU=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 449f8982-672d-4f49-b20c-08d9f77d5599
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 10:06:32.9838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CauERL9IohKl1D+WWGpPhRKUDiz0G9HzHIpK1N2hHBTIwASoqMDJVSvtklADOt+v7xaq26FdTf/ia7o9dNAfJmLZLpKYVNyRiqDvcGQ+wM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB2941
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
index e997ce10ea..2bad35e61a 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -75,6 +75,7 @@ test_lazy_prereq GPGSM '
 	gpgsm --homedir "${GNUPGHOME}" -K --with-colons |
 	awk -F ":" "/^(fpr|fingerprint):/ {printf \"%s S relax\\n\", \$10}" \
 		>"${GNUPGHOME}/trustlist.txt" &&
+	(gpgconf --reload all || : ) &&
 
 	echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
 	       -u committer@example.com -o /dev/null --sign -
-- 
2.35.1

