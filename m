Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33C8C05027
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 06:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjBNGCy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 01:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjBNGCx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 01:02:53 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2026.outbound.protection.outlook.com [40.92.44.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AB54C1C
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 22:02:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOp8rYxmVwylsMUDIY56MJ4udyOIXXW5JE6TBld64ECsZ77G7GJKsdHmyOt2DJShQN1+YgpF/Kci6jogQiT9yKorc0PcNpWiCQ5maYbLxl0DK/QM8GhIapm8JKh1A0HAdOSp5wGXrMae+OY0TK4/13kY6OxIfYp94iIWBp1/BsHDYwsn7Ri+cjthPG9QpWNR5Lo2CqWyC/risZvjbSa95lOXuJLLIZoDtdn6aVCHsMR9xiwEBa7BQQKnnVPxSdwcVy+GlVuCr/bHGKCskIYBdCHD6YWG/VGEtXS0TcfiztXCJg/Eslga9F7d8bW8m304hpAVl5eAUM8nY7ltxVDPDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4agcyQm0PKJzQs3ZrfEETekAxbreF17WWEENbfmfc3c=;
 b=YBoKSVeG5w1ERI9Mt9Zwvmj0PofC8Vgy/1C4DYmczT4ingAHqxEGk9jjsMDw945FnnRVP06mnliJNE6KgieQudgIiCB9odJZ4fIirJEBKonW8ChEe+pydQdfcCmYRKcBPh8zNnFsjerI5ZVImErzjnjeYVMEP2VSPTmtIqz+gzIQ/+3DWiXVxoli/UtgmwxcWayUr+yOXYc/x8CE1i+X6Mo4dJ6MTpky4c2UKCAa50r7itMlWlBbkyY5Ae3IIavGBXpJZzgAzD0Fc1IY5RZFswhu+eufueXQv74m48ww8C6uTgrtnS7l70HiPyYAE/CsM+wLW+V77SJAN8lgjIgowQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4agcyQm0PKJzQs3ZrfEETekAxbreF17WWEENbfmfc3c=;
 b=OhOZBym3MpUG4WQjNvLJCBAjZ0VUV2/bVNsvS7QQupiFaDGg4QwkEXoW5EK0Xj3ROrEkT04O0MhVS6BO1uCzGQLTPE9F22wBen2cZTHQhjgkYKMemqvKi/XYQQ7OCks4uajrzbtj6v0ABTWX0SiTaFe6KM9JVljHBvjBided3k5AMlCuX+Kwaqpfxvk8wPlPYJDm6veeLmHz6QwM4UolQcETdhxSp+/d0fQKCt64yCwAfHRBnkOEoY6Y0OSL6bUIHMvmtEQTYUzryDUIx+RwW5vqO0DjB4+CP8vz/RIOR9yHrdUSXfre1y2j3Sx8/BgthVBlMsQxEIr2GZm/y9r6Xw==
Received: from BY5PR14MB3560.namprd14.prod.outlook.com (2603:10b6:a03:1d4::16)
 by CH0PR14MB7346.namprd14.prod.outlook.com (2603:10b6:610:194::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 06:02:50 +0000
Received: from BY5PR14MB3560.namprd14.prod.outlook.com
 ([fe80::e468:409b:bfe8:4a00]) by BY5PR14MB3560.namprd14.prod.outlook.com
 ([fe80::e468:409b:bfe8:4a00%5]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 06:02:50 +0000
Date:   Tue, 14 Feb 2023 14:02:49 +0800
From:   "L2750558108@outlook.com" <L2750558108@outlook.com>
To:     git <git@vger.kernel.org>
Subject: Gitk : When the number of commits is small, you can roll up excessively
X-GUID: 05F0581A-A606-498A-B942-A358B302795D
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.178[cn]
Message-ID: <BY5PR14MB3560879E6CBDD493C873DB18B1A29@BY5PR14MB3560.namprd14.prod.outlook.com>
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: base64
X-TMN:  [J9SQqdgt+O2HUEAxYiw7pCCxf4T6W0taHcuNeYn+zis=]
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To BY5PR14MB3560.namprd14.prod.outlook.com
 (2603:10b6:a03:1d4::16)
X-Microsoft-Original-Message-ID: <2023021414024351476513@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR14MB3560:EE_|CH0PR14MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ed5d3d-bcae-4bcf-b7b4-08db0e511a4e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0G9egQmL1P9j1JRVdEk46r3g+a0Fsz2T/48mtS7SKPq5ObwA52MjDP3ZQVV7iXDwmYWiNpAse1M2IVDYQ/qikE4LWK+KBGlK92d7wf14hDb1fNsytUN3i7tCxpiT5tlCTr+cKykKQsP0z7tMwTEErSWFuMWHOAlFLPOdyhOY/82fXcYTuhvOEUYp+khJoZmqkkKXa5GKPHo/qw61ReDLp8gticApuHal76Bf0xSDUJhtJ3DjEE26U4wGG8wI0IN+AsK9Nfd1olta8B2HkLsKTOrHE2hjwhaw6jFC9I5ymZ4iQ6Dj0ZQL1tVGR9iCtTAEQZi+oNPr3Xd1MMCRCHUhj5NXKuqSCtgpCxIOWiAX8KGSDMLGJQFkNqzrbOo/D7wGR0L+E2Csm4WycgWmbnRX+GV7l2fR1veB9tkLySNGXli8+vIEp2qlykvAUuDVqu8Tc7htzRjPt9xeWPLuv+ffj4jJtZxI7XKVGZurAl/TdoiTbvftJxnpXA8D645XAcdS/9K1M14Qdonw5msK2Gh6soYPpdvVNlq2i4qNec5/2rIT1wOcjQAUWLaqHlTk56YYXEBnVTe3rZ3ZQ3MiaaH2hEpghGRKk3BFsJhlwdY4ufI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4hdXoKcNEMq0+Aeo/xO1ijIDvH5cE8Y74o4xxd+PJ5LGqfoeJq+Q60U6cluv?=
 =?us-ascii?Q?D9UImcJPgtWdqmpPYemmEZn8D/Yz3HGUGZVJPA9kNB8DwoR+VqODgLSK4Ig/?=
 =?us-ascii?Q?npxKjV0xhDi7AbWVbFykbv8hGE0OkH3HXSB5tYMJEoIrpKLonCt+kFYRBmPZ?=
 =?us-ascii?Q?ewFOkFmfvx79AYM/8jLq4mhQMoEmoSkClfJ5tgOHcmZr8S2UsR+BFF3xcn6r?=
 =?us-ascii?Q?z8+L+SBWDEU0sySQJ2lLZLJC2lK+GuHPK8wH3UoeWG49rgrttFhlnDkpu7lW?=
 =?us-ascii?Q?Y7ESEjR52vbB6iaaiwlwrU7/tNbgg7l15OfVBwBr12fjui9rwWnr4Behyo2r?=
 =?us-ascii?Q?k32LTf5E3dpzpARleME8tZI2cx4N8ycXVSzy76efDqI1sArBS+l4dasXtH3G?=
 =?us-ascii?Q?dcxEotDLlBpXCGhtcC/Bl/uxDsQGZqziXCOSv4Jyi4YYmyx8ocikUIL95FP1?=
 =?us-ascii?Q?jG+brOxuK+VkDHi5bJkQKv5x+B6an6sMuinuqEGlQ8SeZZ6yLXWSjYHP7r8d?=
 =?us-ascii?Q?uEdlryqDClovZz7LPDMApFMzI8Lk3sHBvkUZ9Iu2jKLlnwKo0Ddu2v7jbz+x?=
 =?us-ascii?Q?23YfBGXMMII7uQfxp3XeUAJcuAW4Q27qNAURlaw+AkkD+8OV+agkrUB1QDgp?=
 =?us-ascii?Q?/5s67XxEfDnUJkH46TvZtqfwDwiYjKAl6hE8kXaUGBEsQu8efY61EV56XzKH?=
 =?us-ascii?Q?hJC1mjP99PknrQHRy62vi8PRlOHDHPSG0Kre8xsNS7zXGUGyd7JxOmfBITf8?=
 =?us-ascii?Q?oQ2o8HXSAgJC/LDR7aCcpavY0Cnl+nfcKl2fUjBCdZykJP7wxiIfTiIdoAKV?=
 =?us-ascii?Q?G0ykXm2FDR6RdG+Ruz9rzfNS7/cwO7L2A6mpwZxO+r5ld7l5dvDhX8/I708U?=
 =?us-ascii?Q?N9nBIbR+8WYSN2cMA1thvPGlQEfSiBE/dBgprEFsRL9b53/cLQFE7b7AX6XC?=
 =?us-ascii?Q?0vkviKfQzX06tAiazjU77ajiymD7bLj/5mg9Yygza0lWNfVKlzsYKfJrslzn?=
 =?us-ascii?Q?6gdV2Wm9rPaty6j8/t6tfBg2UzbpujaNw3praicEalciV5vQZXoils8weZcg?=
 =?us-ascii?Q?t52O0JOKFUg/wejhRt5aco2hRJvvr0wFyUKS5zN3A6SyAZb8tDAFoxAOJwTK?=
 =?us-ascii?Q?iEAnEY3arCAs2JCrJ2Iamu9lF67Z3GGkunNWfOoz260hRDUvvriSrYxZdXHM?=
 =?us-ascii?Q?YfGXSOD5Wt7eOxIBpJeUcZ9PxwIxmdOVxOObyYb7TAw93E+Ha4A/dpHN+aVB?=
 =?us-ascii?Q?9dZiUIvh8krL+yCoUuB/FP9v7D3ry+aLmy/XdcUQDKkGKof05N7LXq/WkM7E?=
 =?us-ascii?Q?MKA=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ed5d3d-bcae-4bcf-b7b4-08db0e511a4e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR14MB3560.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 06:02:50.2856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR14MB7346
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

R2l0ayA6IFdoZW4gdGhlIG51bWJlciBvZiBjb21taXRzIGlzIHNtYWxsLCB5b3UgY2FuIHJvbGwg
dXAgZXhjZXNzaXZlbHkKCgoKCgoKClJlZHVjZSA6CgoKCjEuQ3JlYXRlIGEgbmV3IHJlc3Bvc2l0
b3J5CjIuTWFrZSAyIENvbW1pdAozLkdvIHRvIEdpdGsgdG8gc2VlIHRoZW0KNC5TY3JvbGwgdXAg
aW4gdGhlIGNvbW1pdCBsaXN0IGFuZCB5b3UgY2FuIHNlZSB0aGUgZXJyb3I=
