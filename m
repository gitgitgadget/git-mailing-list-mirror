Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07123C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1E2F61B54
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbhKQJHX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:07:23 -0500
Received: from mail-ve1eur01hn2212.outbound.protection.outlook.com ([52.100.7.212]:1921
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230064AbhKQJHW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 04:07:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USypRFqTh3UxWyajLIe7EmbW4jR3Jc01lqi+GTa4C/R2Hju/A+jyeU9Y9DZZnYFN9I9wN723sLdWJMe8DdhHqfnMkT+eSqKHoCLrtUb+bHZ2+WMHdgs+AF+sbVeRj6GxQpYH4mbLwY36U9UstB1yFsjzWBZcCjVbFFcpkRFG+fVmGi5yuZUNk3vzlVpcwjJzukXJciAxM2D76mWXyTkqvDSz4HJ6bE8OPoCJIWZaAB61ZYBj6CnWSgKnQUpV3WXwIrephEMfyl4IabUf31BDQyySgevAfkJBLiA1d9EAJ1uGpSi0x1YDDfutG7B1ZtX92OBv/BQRAx6UBpnD8zGdEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clv1M22Ce+Fbpizn77ebuLrIGTJLCp+R8FBS57NVZvg=;
 b=Vs+5GlxG+EgKPRfvZ4H+XPoTsmesimhjBqv5InkiyORiZfOUKmS7RSUpn8lKLcMTrg6+oiWvR/fsludsZ3uSgLHak1UVWcPzI1M3OjLCC6ZznduWP5LxAE+MXZrA4HGkXEvEClbXHnry6Hu5blhxWv8SpilgsyBPiUrxcprHZ/wgVw6hUMrkPDKY7uj87rHq5/L7oxA2jlsgeN/RPVq32gnLqhQen+f8ifAirVI7DhjqovNmQfz2AB+QWvWyxiTXJOe4OSMKFcbpfWUbniO4hwyhVXNIeWG2Zbrko0LPMYtz/FeBRPImVgCFYnz17MsloLdLjrv07jyPL2X3KQqxsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clv1M22Ce+Fbpizn77ebuLrIGTJLCp+R8FBS57NVZvg=;
 b=ijgHqQEgLDtgRNw0bow/2Pohj+/DKi9kHhTsBwXqMRl1qogBFzISX+0lDIgveCHR1QXC+fpCKN2AK8CBZpeNrP2d8Se4VZzESjsVEZ4R8HxPiZZqxIOX+rWo0SD7sa2WnRc7bsOFOr5GVpe/xBD9EOQK2dX7ONjZViRNr7Bc250=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3849.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:43::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Wed, 17 Nov
 2021 09:04:22 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.020; Wed, 17 Nov 2021
 09:04:21 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v2 0/2] test-lib: improve missing prereq handling
Date:   Wed, 17 Nov 2021 10:04:08 +0100
Message-Id: <20211117090410.8013-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8P189CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:31f::33) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS8P189CA0006.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:31f::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Wed, 17 Nov 2021 09:04:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6163600-670c-47d0-b31b-08d9a9a93ebf
X-MS-TrafficTypeDiagnostic: PR3PR10MB3849:
X-Microsoft-Antispam-PRVS: <PR3PR10MB384968FBE42D42F0B4C5C144B69A9@PR3PR10MB3849.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1BfSrRmfqEMguQvSkP2ytED7u885r7y2USLc77SAeVj+PH4zq2vZ+VZ/X6bh?=
 =?us-ascii?Q?Ya+YpCpnLoxmI41LKL8DhAkOnD34AK5nG6/KG5/+zZCIKA1ALJWUJ10OPC97?=
 =?us-ascii?Q?UWZthmCNMmJewnLmjkVS+GHkQXF40Dly7pWZqTxegK5q0kY12wjBSzsJg6xU?=
 =?us-ascii?Q?WjHYne/vHmLCRE1qh2myuXmWSNotWxItL7lWXuV2lUuYq2A1BI6kcn+NO6cV?=
 =?us-ascii?Q?tf/6k9zijjLwpJhjthqR6VhN626ySLF8w14BRjNm/cS+XC2O7imj4exmkevI?=
 =?us-ascii?Q?P3yhRV6KIY/sHqklL3N089VHrqV2SlSZxnDI+lcw+YZ10DI4qdnTzeAQ6v1W?=
 =?us-ascii?Q?faxdkDU9wKSLhdryQHaqCiRSHyyzs94c2uWInLO2K9O+4ln4ieE47EOvak65?=
 =?us-ascii?Q?6S0Z4pKrq5cxQNwfCLBkcfgvmQlADFbo0Mqkp/c/HnMKxmPN4wYrInLxWfoC?=
 =?us-ascii?Q?/tuFR8RopguJ7EzWTCn5jeME1fAMwi8M6e5RzK4t/UeUy5tyhDHrHyC27Em9?=
 =?us-ascii?Q?I1C66hN5nH5vYC4L5gZlEEFhM0ovunT+FB97ag+6SEVdJmifgUjQ/o85WYez?=
 =?us-ascii?Q?yWBuMpL2r+ekdp/WWmZ6ELeQWr/iU9p4r05S7PN/XoB9jKbXTnIK6XRu+m4G?=
 =?us-ascii?Q?dQkMjKyDdV2ox3Wu3+0Fq1QQj5PKaHxcyBg/s2ViCYbf9m2udhR2QUCO2bN0?=
 =?us-ascii?Q?YfNwzCzJUehQd81i/fzT8eYp0Uj2ThlgXN47V2+HUJoVPLy9IINLgzhYZKbc?=
 =?us-ascii?Q?Oye36DD+VUN+OrrEMp33ZSkxQH1ZfbUK+dRrla8JvHKGCblFbPSfZg6jjD7W?=
 =?us-ascii?Q?TQlISipSbHTqkB7Pd3y6/tJOUvVnqyyGMWUPlbvWA/yDOj1xEl2/H4fgdieC?=
 =?us-ascii?Q?PlCa0qcRMseYwIjX253OeemKA/JhsFYuZ8PBKn+a7vFxmCWE3MR783wG4BRe?=
 =?us-ascii?Q?T/71A6aPCDj2kdhmDrZWTDH1laK0GQIdx7ipNvkTVeV7OtJc+spyvEbYCIzT?=
 =?us-ascii?Q?GNfqv8UgA4PTgue4PUPSZNDKqAw0i+7+CVWT5JWIqArFawYbWLLiGtF/QRaS?=
 =?us-ascii?Q?cNCA1Kssxvc09TdO908J5IQVVQ/mXhijnTaM1pt2CX+Gg9xT/Jo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(366004)(39840400004)(136003)(396003)(346002)(376002)(66946007)(66476007)(66556008)(186003)(54906003)(38100700002)(107886003)(966005)(6666004)(508600001)(316002)(8676002)(8936002)(5660300002)(2616005)(36756003)(6916009)(6496006)(2906002)(86362001)(1076003)(52116002)(6486002)(83380400001)(4326008)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kvnJFrFdH0MC+LQpr/1ZFkl63YBCv+9zVCNdf5ZBAy9+eElIJ7vgssnGbo+V?=
 =?us-ascii?Q?7X/6TYGlZGRbJP4HB7hPajQoJUmd4394c+Kyh8Q7kPOJ0gn9JCs9hQvAeNPE?=
 =?us-ascii?Q?4ssNj8Izs96wMXydpuyBXLrOEAxekImalP5yqbwA8XRa9JiI6q3t6CUysjAq?=
 =?us-ascii?Q?ksYz1s37YEVoh6pO1MB2W8lyDDh87GCyOiFJrK0PX61GVEEyLzsSIf3A846t?=
 =?us-ascii?Q?jrlueeJLOmZ1ZtLCs5J1Gy1Inuzh6uSAgzh3PVMptA4Rz76W/5bQ3sK8p/Ix?=
 =?us-ascii?Q?09iKNwOZr5Xbyhfi7aD1UfTB6HixZF0FUIjy03qf/SwoEV2VElKkYfYP9bEd?=
 =?us-ascii?Q?cdLstg++Lce1oVTNGupUBUJGU4c9N+oS95Imj0DgFxr+3P7U2njA8J6z0WX5?=
 =?us-ascii?Q?r9Zf4q1GTqV8Twfp0zhUpt/OBM/iNIO0edew7+KIr3b/2Eq5d0/QVIZ4qrUj?=
 =?us-ascii?Q?Fq2thslQFLnbAkzLT4ea7+V9viIGFCFlSKjODOREjIF3UqSi3be4OIpO4uiR?=
 =?us-ascii?Q?ladYUCCUa/mtf2AhxgO7j67A3zPa45xGTEwYZjA/Z9HUlq8MEkFVsE7rmJ9d?=
 =?us-ascii?Q?RZpZlaw6HRuwolG3Lr9rfdm/N8aWuqUzbWyMTJ8cxzMwUHpS6SlDJ6XqRNpP?=
 =?us-ascii?Q?VO9s5Gk7uDJ9dtLiKTulijdlWSmoEoei50No+OQfbfwXgUCU3BDqytYzn8gQ?=
 =?us-ascii?Q?krjS8Mh3VI7VoL8P5oyc7AC+7TBWO5FkJqIxnbrirNrPxkNPE6q8wHFE5iI0?=
 =?us-ascii?Q?sHoZgYyhg6GDrquS2FYn8R1kVnmS2/qZBAWAysPdXULgI150X19TBNVYP+qX?=
 =?us-ascii?Q?Ke7ILnObf6nwpurh5NfO4HB0/un0VMEuLeeyoFXDy6+nUhpZ3ORiCwHtAXog?=
 =?us-ascii?Q?+iHdi2JM6ZzQQ6f7AvNZPiLUpBqpXyYl/pHT7kTSDERa82wlaWMVozDtqA/u?=
 =?us-ascii?Q?qjpCq/V9vc1eIttO/5IEFKQLfu+ny3iS/TpmbhaMhhwcwCUZcHPiFJdprmtc?=
 =?us-ascii?Q?EYJdwnCHjjiOKuyQxbWZMJZFmNna/0+SPmYcauvyrHuy5XtFuLg3KhJ9mgn4?=
 =?us-ascii?Q?rjp2r3F6ySJQmQKM1Ej5On9z4AvW8ouJty3OdWzSxbTYYw6+JkcSMQfsz1l0?=
 =?us-ascii?Q?hY7vEXJM+qV356S87IKqeKxn05/ROZD4CJeKVJfIQzguEPqFqqfOzXsaDMw/?=
 =?us-ascii?Q?RFIgpdjND3Nhz4UBAC4xCAyH0v7O0kQjCCT9vfBEJ+gcFvgSniUruAhDi0A4?=
 =?us-ascii?Q?Z1Xhv7btO9ZqUb+hCItYzf3Ys1UBQDfGGmhU1P3SnpGV896jE+ObeVAApRlA?=
 =?us-ascii?Q?dIILSNaZWq3tsd7/vmA6CT8T6O2GvUPVcG+oMe3KrvLwBvO7gvq3uLd7RIgm?=
 =?us-ascii?Q?j8GlZF1KNLCULXp0riAVZbTC7ZkYvS34SunwUWvJKqvlJa9w8HQaOmKaYFnN?=
 =?us-ascii?Q?Tc0Q8f7N1+1xuiLEBEqaGnvzM1+Cs+uMnSI5F3SYqyVEZbrdImSTKGVxK7Jm?=
 =?us-ascii?Q?8FbKnQgSnRW0re2x6gRF16slwoWrPtrb3BEQWkJQVAP/AEDWXtTYFOp/65kf?=
 =?us-ascii?Q?RrUdM4swAIdLE29tG7U4aTXBQa8Hvv+S1y3d4eqgLZy+TE8Cv48dy3i5Q8Yv?=
 =?us-ascii?Q?yLaaaSa3hRKnoxMM6afRObkSvNcHDfQTZAd54dm+L7zD6xrIQLs53O1Z/RUt?=
 =?us-ascii?Q?d1ZtuQEowMwl9hlmH+aZJw0YT0go6BRIok3k1yGLhe2WyVR3ALQaziDInGfa?=
 =?us-ascii?Q?ntTyTk+B7Q=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d6163600-670c-47d0-b31b-08d9a9a93ebf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 09:04:21.8098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2CmM2IHU6nylmVSjPUMjoxnLfOn9vd0CF2btw+PydJ3bQxjPMciYtokj35XS/PLjGzGRzOev85doW69vpHnkC2bbpxhpirh1y+DXZBT6fw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3849
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ssh signing feature was breaking tests when the broken openssh-8.7
was used. We have now fixed that by checking for this exact case in the
GPGSSH prereq and I will improve that check further in a future patch.
However we are now in a situation where a broken openssh in the future
will result in successfull tests but not a working git build afterwards
(either not compiling in the expected feature or like in the ssh case
runtime failures) resulting in a false sense of security in the tests.
This patches try to improve this situation by showing which prereqs
failed in the test summary and by adding an environment variable to
enforce certain prereqs to succeed or abort the test otherwise.

See also:
https://public-inbox.org/git/xmqqv916wh7t.fsf@gitster.g/

changes since v1:
 - use \012 instead of \n for possible portability reasons
 - fix typo in commit msg

Fabian Stelzer (2):
  test-lib: show missing prereq summary
  test-lib: introduce required prereq for test runs

 t/README                |  6 ++++++
 t/aggregate-results.sh  | 17 +++++++++++++++++
 t/test-lib-functions.sh | 11 +++++++++++
 t/test-lib.sh           | 11 +++++++++++
 4 files changed, 45 insertions(+)

Range-diff against v1:
1:  69e77cd854 ! 1:  775c0e5ef0 test-lib: show missing prereq summary
    @@ t/aggregate-results.sh: do
     +then
     +	unique_missing_prereq=$(
     +		echo $missing_prereq |
    -+		tr -s "," "\n" |
    ++		tr -s "," "\012" |
     +		grep -v '^$' |
     +		sort -u |
     +		paste -s -d ',')
2:  12bd18c5ce ! 2:  eb1bbb8d01 test-lib: introduce required prereq for test runs
    @@ Commit message
         test-lib: introduce required prereq for test runs
     
         In certain environments or for specific test scenarios we might expect a
    -    specific prerequisite check to be succeed. Therefore we would like to
    +    specific prerequisite check to succeed. Therefore we would like to
         trigger an error when running our tests if this is not the case.
     
         To remedy this we add the environment variable GIT_TEST_REQUIRE_PREREQ
-- 
2.31.1

