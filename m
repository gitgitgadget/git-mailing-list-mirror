Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DAAC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 10:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiCDK0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 05:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbiCDK0N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 05:26:13 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAD2194AB9
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 02:25:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfNAc2w6GAXM1OezgTUu/L39iVYsli6PgZkVk2elMYkigQd7PwaXlSTKTO/tGw11ph0bhlQqz2LA9UPGQNC1J21W6VTZ18tt5adJjIZvSCmV4taUySKew6rdeR7NGlrbYKa6XMWt41xA+FqJ0v0lU6cm0/+rzcOCC9nwt8yMyzLRGvO+DIeBHNV4CSQD2KZpN/ZooZUDHuqKh0Oa0LGkFWp9D+GIoUWVxIJLH88DqXKavE895asijrh+cUXIac47MYYK/N1cCtNHa+Z6+EvCHP21EZqzQJSGZ07tDqihjsVXK7oLJzloDXVTuezby626qbHUK0IMxVeOzTVwsJxSVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gzEmdB7TOjJdgm5yNk4kfNj0jcmrRCgK//WSqqvDLg=;
 b=M6LGEZWIJhF3Xzld04mJPMSnum4c6+nuYOpswTzs5b66n1ZpEy9+mW009qxgwEluDiKQgO6+CwOPaTuSifJS0faQvBBw3/Te032mSqkQTwuHNT/kynKinlzDKl2vvfS+TXF07CIs5ZhwvIGcLbTI/Hjr2bcxu9YDxvJ22vzno8J0e3quYEQplP4C+HVUGMZmUZ2FS+7UeoyEwCE3D0pfsjLBpTlqFzzS4JYBHQRlh6q0IvW8OGhx3wHI+qd8tf00PzsLBIr8CCyw8P/143jBLdqDXeLou4jZVO2xuU+MbMhvCE9bSnL3CBnRJARcoVjyaJq6nPSwM3WYS8+y72C4qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gzEmdB7TOjJdgm5yNk4kfNj0jcmrRCgK//WSqqvDLg=;
 b=gno70pZlLywOetymrsIVuFHAqbzmGjSTUElj/HfJmDFseyoKM0Wv1c3EpVT8SiNnOKDK6rfSMZbHmb6Asvt/2OONS0XLVShTVr/g+Ryl13J8X8mARnylu+XocCg+IvdJhzGSooIPSXdcVxatcaorQgBdcrdeC5rKW72G4C8djPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by DB6PR1001MB1222.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Fri, 4 Mar
 2022 10:25:23 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::116e:6242:98da:22ba]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::116e:6242:98da:22ba%8]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 10:25:23 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Todd Zullinger <tmz@pobox.com>,
        Henning Schild <henning.schild@siemens.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 2/3] t/lib-gpg: reload gpg components after updating trustlist
Date:   Fri,  4 Mar 2022 11:25:18 +0100
Message-Id: <20220304102519.623896-2-fs@gigacodes.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302090250.590450-1-fs@gigacodes.de>
References: <20220302090250.590450-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::19) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 664b820e-d155-4418-6271-08d9fdc94a6b
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1222:EE_
X-Microsoft-Antispam-PRVS: <DB6PR1001MB1222F80E756FF6BC7F452DE5B6059@DB6PR1001MB1222.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UVNucGMT4GDuwqB8veEwr5pueMq9x1IxDvY6lER1vfo/kgg6nJCzJvTKuC+9+luNCPjMgx5Y5o32O4M2ok368HtGJVwjIUH2lSen+wDeHQi6/aoB/FajRbPHTC9WHUraph8VSCG7n8YjF8+vqpwQK+oFW5vXA2IIplPe7TiQNQJbSu9Nh7P8x8749eCNw9L4fKOhexoxKwaRjLig+P8L8ZAPKQpyeZYG/DDU1lDD21YC9gNuVFHtS/UWiyqZf3JqrlW5L74j6NIwLxVmKX5OflxqtwMkpnBSninwzcb/N4yO2pIKbyukZDdD8pzIXfpCmoJS/86x7KN7kVh6nlPbIl9f+2UJi/gAVQjQrTx+QkPZ0bE2mNUM92McwEOFrAuZKk0qPAcecMINyRVXWY8zD/dFQ7C9u6atu6GoCDoBPtuvn1YNaH2ADHPiCIX4fzcmISjiTaUEG52wyEYDReSFQznrQ/IQHE6f6rr+mpWLxlx7/1lVSFOFizSrxbK8gdLEohv1NcUk82zpLU8lJOX/4V1naKUWKenWBVB9FKhvWQt1ttcwX9zsZOD7095McI3KLJCqDwbkhfJhfIaiEa8QlvaOXdYaQJm0Jl0UcufBm5Mu83jL6wBVykC729uj1BzMzGOAL1YV8mU8rKjNKvUSSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(39830400003)(376002)(346002)(136003)(366004)(396003)(6666004)(54906003)(6916009)(38100700002)(186003)(1076003)(6506007)(6512007)(2906002)(36756003)(508600001)(6486002)(2616005)(4326008)(66946007)(8676002)(66556008)(66476007)(26005)(5660300002)(8936002)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A6lBMdNQKsNd9uEg8Kvvu2A2ygvqdNPMIfjv4FEKh9K/9laplHT+Jfyjb1LJ?=
 =?us-ascii?Q?d+r3gyszIZI4uILUtp3m+U5BsW9clYKyew55uQrxBr9q1LqXNd8mQ9lWE//U?=
 =?us-ascii?Q?dVgASp4H/PS9VlIHkqzTD3FT1fMcmUPWE8W1TivxdavIZaTzsVsENKnhRHVw?=
 =?us-ascii?Q?37nYD9sNYNEeIhvon0OUIWr6ONplg3WiQvYZ08D8K8l86mjlzrFoL6D1zlft?=
 =?us-ascii?Q?borJO7EKJb4SJ2tWAAOeIlwW+++Ocgig/nALsF3lMsRW5zinLAgMzrPooiqP?=
 =?us-ascii?Q?cxl/Mh7R2F3aEiM6Sc4M9mpJVitjvQXyZK1rF/H+po36tuiXDAr1dy9zDr0Z?=
 =?us-ascii?Q?rEJFxYvUZGcW0iFiJphs7AeDD1ok5kJs/1AjeqpDLnU8CnfTi9/13yoOdepA?=
 =?us-ascii?Q?yxHPx13j8x3z9cPGe7Y7P1MvHTkvfJFyZa1+Ud5JHAE1F4LxtMP3VcJJUKf0?=
 =?us-ascii?Q?/QEmbbtwEWYKMsSYK66JhNvZMtE3vr+f08o7Y6B2Ms5d2B3X4HMCEqIwBORk?=
 =?us-ascii?Q?08x7freZ5JAhKTcv7fkHkhHwKu6N/X9J7UPvwxg3+8Cbvdnj5CCkS57V/J16?=
 =?us-ascii?Q?Wcq86jOTMSkDvY3Q9QD40OTg5BW2qXEUBM7H9upXBVCrEhcrv+ocEcySiq8b?=
 =?us-ascii?Q?Ut7IffPVwWCd1jxIE5wT18eRoGTACB6MW1EyuDMSXhKGCw4RUrajJseBeaR/?=
 =?us-ascii?Q?D2uFkvzUtY4xkOWZ9rdQ5clnoifEdeXKX4E5Q5OEvALrzhb50jD6xlovKxgN?=
 =?us-ascii?Q?VSI+YHaE3kdicnwrJNyqRCbaTTsstD1RBuYUW7uDfetEuF+ry4CJn7JRW7Xk?=
 =?us-ascii?Q?2wdNB8TECK94y/KydMqp3dMcVYTOF0EGQ3UYmRCT5XA6/6C7BaZbXWQwWSB1?=
 =?us-ascii?Q?VoeDamPhHlrSmoHGG2KIKwlj9TU8vudZU+TBsLmWaVWMx7iV3JKNYyDLDcNs?=
 =?us-ascii?Q?Lf1/EQ5zGsuHzm6HFc7kL8kKVIn6D1DIn4zdS8uLX40zoGD40aZYES3aUjJx?=
 =?us-ascii?Q?Y6lGuF+9dcr51IkRXqmXwCz0ihl2Jtmgdnm+yhPYSwak/BbXrCDz8xKYIbrb?=
 =?us-ascii?Q?SVnrfqx3RajtgkBKaPfgjQhdN+x91nM86F6Cv7MS5PnBia+PgGSPUj+pnnh9?=
 =?us-ascii?Q?XlFcfdhEH2fiwtDh90B/bf6h4jC1NtgjN1hyE3nYx7FpZdRGV+MH/zQuLLp0?=
 =?us-ascii?Q?rcPm61XrKutWzNiJkbe5QfN6rF73/UHhQVQWHFG970X0NGUR0UhcOFMnYIr2?=
 =?us-ascii?Q?u0ZqyE5/uHl+bzB4jQMgU2wyuOmi2CiwyEBc4AHyNWoHT2EkX/PfIfGx7Bal?=
 =?us-ascii?Q?hk3owWC9CpeewDnjNnvmbPlerOxPLOp+YniYUg/beQcHilUhJUDjqxveklBk?=
 =?us-ascii?Q?dXvgJUPURkNuku6wwvsfjC65/Jwv+0H3re+fZwZKvVEPjborE+xO5QT2YB8/?=
 =?us-ascii?Q?m80KVEh7n3f6KYExkGCS+MgbRE535GrMSwgqzCn8qIPrb1v1XAtV5EZG8S5e?=
 =?us-ascii?Q?NukQYdD5t5HOh3BGc4HuhS7lyDd4cjnO90gb20AQ6rwrAGpk8xeLLd8Oy2QA?=
 =?us-ascii?Q?qz7enhDif7k6JnWO9pZRPgK2wPLnaaDY68x57ZWeFP93A/X2V0IOmHqErpny?=
 =?us-ascii?Q?mOUWgMder2I1CVp+YOz/T3EGUE0mXxSJreSHsVNAAMSxWpL4N68Xmg2G2ZGW?=
 =?us-ascii?Q?7lQRaUWCN7528wfFDKwmftBslEE=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 664b820e-d155-4418-6271-08d9fdc94a6b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 10:25:22.9378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRBQ2ctpIaAG6VEVMo+SedEYv2eqqMZLBOTMKlJ4Qpv1mT/NhpBC3wLEAYL7Vs28/b/WghSNGBtCskRJUVC0X+deomvxUj/gjGGYnDamA3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1222
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

