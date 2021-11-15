Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274B5C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 16:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03F3161BA9
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 16:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhKOQLS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 11:11:18 -0500
Received: from mail-ve1eur03hn2202.outbound.protection.outlook.com ([52.100.16.202]:14145
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236608AbhKOQLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 11:11:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfV2zOsrB+au+UXdqRI+V6fdZfXGS991GRhW4Sq7G8Nv4k8PeR0s75Z3mJplRE5DKJ4pgBxgzyobR9nDgDDyv2ImBzqlWNfn6hX+Asn8lMIe/tHJpjcpuJsFY4dDV0PK1Arjze3ZJHaMErsRO1Zmj/R8/MOjs5FP12iWSpsqcXQKX+fY7uTmNfV0k9/VTS7JdCPmfyJC82sxY/eWW2UXGsU2JN3uVZDHYt5ZJxvyEHIa5QTeBVllCXv85PtHer1t5gYPQBbgS/4qO6OAa0bQjZR4JhoMmg8fp5Ww7URy00FqvCt2s1SpcxnqPmIvYMgAoZi3EMsfwxTn9ZEzHWO+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PPebgTZUeB7CNIbRheCnFlk2vbBtOtr6ThIAmIuHr0=;
 b=lpS6h/tDdrgAeJLtu83sItLzwoHcwABNwpMiaJyiETbmtTco8MR1PO9odPNarwRQnmqN9LNYD9knX4bXDnkHN/RBETwPmMbGeJTruX1RmwX6JQELnJZQdQUnqvZfFD4rPEOgC2XdsgWWQof6E5hy/nVan8EicnLGP7O68IO0QtwoYtW3c69gr2dCfb2tC3RBs+i3cEcOBk39hIkN6khujUyicFcomstIrwuy6jdl4+TtgM3JLPgLecqXCvO7yZMbqEGWOLuGhfFVIODCNf3W5i64zUNyWXeO1k+4Yg8waPJgrN06NK+TddF8MljH8UEkD5teQ/dIcecr31eEbHOsGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PPebgTZUeB7CNIbRheCnFlk2vbBtOtr6ThIAmIuHr0=;
 b=PI5mI75EPlnlcqCs6OLr1hwwe+jFu9TLyvs+ynESRtsFrPkIAMUELYGYzhHRECt0I0bhvJMXAaRRCPHAQIkoisOdWgGLNeCslioGCBx/2mdKeO6kb+3R8rU7xwSeVAnGRW2ZD+tuTX71ezY85c7/OmjNO51TmIB1i5Onuh/vUrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3866.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25; Mon, 15 Nov
 2021 16:08:19 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%4]) with mapi id 15.20.4669.022; Mon, 15 Nov 2021
 16:08:19 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH 0/2] test-lib: improve missing prereq handling
Date:   Mon, 15 Nov 2021 17:07:48 +0100
Message-Id: <20211115160750.1208940-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR01CA0071.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::48) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by AM6PR01CA0071.eurprd01.prod.exchangelabs.com (2603:10a6:20b:e0::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Mon, 15 Nov 2021 16:08:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f517f3cc-ae25-484e-e9d7-08d9a85223ab
X-MS-TrafficTypeDiagnostic: PR3PR10MB3866:
X-Microsoft-Antispam-PRVS: <PR3PR10MB38660972F9D47178D471D59BB6989@PR3PR10MB3866.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7RITtbvD+R1z1cJREm5KN1mdlCPa5Jfwc7kdUMKhwvcBEaFN4DFLe91bCM35?=
 =?us-ascii?Q?mGVvyqQKi0nEFcgaIt+btVZu02oDzPk8o8pX28h25+39b1oIOcs6L/2QvkIw?=
 =?us-ascii?Q?FLAvmAKern1SYSmFfrgaXJZGZkLQBBiXckkHL6uUkXTBp+NUr9YuweYD2MqQ?=
 =?us-ascii?Q?sUhYLH/+OFCOsuWlstYmLpzgIPF0QvgkPkCLqCDrlaiuBRLXOwK5Dvhp2JRo?=
 =?us-ascii?Q?NeJDBeLOk0+KqYvtzr9udfdD5R5Yx6UncNHZVoR16ZfkvvtuCE7IbExFtikS?=
 =?us-ascii?Q?NP4dXLequsZxckEpYfXm1Lvh6Q3ZXaLBAqTYp0hhquvY5ZEGI+drYsF4R0zI?=
 =?us-ascii?Q?QaKS0X2n6O0TeBskU+yCu15/r2tuoBNi8nv+FJXoZzG0qFcgJ4TPT//3NDya?=
 =?us-ascii?Q?vlrS3EouOJzLeZ6dJMOebPNdMtBYGhaTsWa6k9dPhJI+6CrMrJ8BPRbxsWDl?=
 =?us-ascii?Q?zhBnZ78di1fN8y5bl6/5h7MO/4r4sV285878Jy8CLfOnvN4zIbUgA+cVF5iV?=
 =?us-ascii?Q?xZ3cJi9X4l7fRlVHJORB/YypRfqPYOnuaHKDpJcp72aimfQeXM8r3d968gKg?=
 =?us-ascii?Q?alUkUKubvjyzPctsInlPveJ4vocJaQJh5x9VcSH3tn2GIGRMA/y4J3MItdfy?=
 =?us-ascii?Q?CXlgi8gysr/LzUlVqvpYTfVn4ZApFPQIP1c2paPY/G6iLWUg6o1hXlO1wv04?=
 =?us-ascii?Q?RcOn6l1nYowkDKc8mY/TRqe3GWTS4rgURgB3e0ehQ3qDi/Z2nTYFZSwvx0Gr?=
 =?us-ascii?Q?O1wAYFUgQ8U3TsqEQMBkFGjIgZ++CO/O7rylif7HU7/iPV9tmG9JxdsOxgCU?=
 =?us-ascii?Q?hxfbfTQk49nvnCRzRLvpRI06JDZuTlsCK4Dq6jK34oLpQZFqawS8sdJiBnfa?=
 =?us-ascii?Q?MXNvRn4RsTLkYjdFbHpa430ebErypoyhhoOQiy1y+PDRRQsIK6pwy8xiCGSR?=
 =?us-ascii?Q?ZVAbGGJIJBFlR30g1ARR1CNccOTNXCPQ4yffwkFm3cINt5gn3Shq8jaF7EFQ?=
 =?us-ascii?Q?PhGJjAudO05XIPYxqJLyGbEB/HSTd+JSZjh95aOCGM4DagA1tOkUg3dfO9U+?=
 =?us-ascii?Q?Yl3FArQ4dDwcdnvRpC2zeanRZc6UF5yA/lD2XtrsUUfUQoDHfjc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(346002)(396003)(39840400004)(136003)(366004)(376002)(2906002)(66946007)(6486002)(86362001)(66556008)(186003)(8936002)(966005)(316002)(1076003)(6666004)(38100700002)(2616005)(8676002)(508600001)(52116002)(66476007)(107886003)(83380400001)(5660300002)(6916009)(36756003)(4326008)(54906003)(6496006)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UN5sizuap9vNLFdAakQhg3bTxP7zoEOZBJNZbNvmatO7MOHQtdr62kvK2po0?=
 =?us-ascii?Q?zGtnzwkzKU01ilTp32ZAbRPDPCYJmLTBlTJT0wVwdagqXutPtqyhgiK3Ny/e?=
 =?us-ascii?Q?6Vjjo/us9Q9aqekpgbmEc7XFR/k2m0PBFAJKScwT2R/mfa9qsVUIeGPTv5qJ?=
 =?us-ascii?Q?0LliyIOE4MasI2rnDtN+mMJ+KdN5gO55v/3frGfRorhJxQ4NfA2YOxmoXGm6?=
 =?us-ascii?Q?r8HT4F5wuLaWlmIfhP+M2bMhE9Ut6n8lMMt0eL92oCNvATu/YbRQARyxdIti?=
 =?us-ascii?Q?NgYEVsPvPlu3A8w8lEkkOw2huTA4qM1GgkiHuXLvTxoybxW6X14cRcGFLSQk?=
 =?us-ascii?Q?tS1wYXsB4J5Mrnm7YRYVTZmEkjl0hDdNLoUVzfau9AcvhDIVe1cdbZFXaKNA?=
 =?us-ascii?Q?65CYXc71sXq6zGnCpFXofK56EA9cB80cQqAFvOd7DJyUfpKYPeVjO4AwoCoe?=
 =?us-ascii?Q?C/xB3tfIxZrTw55Uaiu6QlCxKzSkvVeKr6euAQZS3xp+pUgHhs30KDELHmKn?=
 =?us-ascii?Q?DvqcAmo8JOHOOBIrXlpxD56R5RkIWnqaFzk5rux42PssaFMdHnFRe9OJU343?=
 =?us-ascii?Q?+qEUuoIMNWAlisLhch2JbPlv7LcEOj5LZcHoAu+KpphLn+4J6bhUM2vdVpIA?=
 =?us-ascii?Q?iDAQ0xzh41ZvAU48pdFkqZPwHTMQLGfTF/j/5EoKZUewF1Bm5vsWiyFVPkkU?=
 =?us-ascii?Q?/tu07fFdzyPHxjIq5KvI96239oiriG6eVJNqvpZhq7qhOjlY4UEvTfD4g9sA?=
 =?us-ascii?Q?sjy1SdCiF22qDdaX5gIA2x9/rBdI4gRnkQZ5/Re9H6aVu3PkkzHVELH7OvO9?=
 =?us-ascii?Q?B36HWPh2CiyGxbHSri0DKTFiVcGT5MG+VvoP8DkBekoVffi4XDrQ7meQgN+c?=
 =?us-ascii?Q?76oKEgJhtzP/FVEJJ35NTY6/NLstLzHOalC0HrZorV/3muHlusIMAF+/lWhB?=
 =?us-ascii?Q?KBPvSfUU0LHfrA1//wM9DZ2T9cSoC8doN+0pgYJ0+iVOkEkAszrW21nYLkwt?=
 =?us-ascii?Q?yKeoaiwRiO/7q7fVm8DPirzr4Ujxx+m2CJsfy6VqeXhjvhhyAGlVeu4FI9tx?=
 =?us-ascii?Q?h3As1zsnp7NQfyS13lHJEVEmJ5D0BixyW78QG/kH9koA6GPrkJ3eveA/ez9I?=
 =?us-ascii?Q?pbqDeIyJYt6aP4B3V4d/ksWj99g8zeIn5SaovvzYeFpS/IP7pXtO3UJV05Ot?=
 =?us-ascii?Q?/rT6BPZF4K/pOlyosG8egS+dzKdVkgMwCxz1ZhE29qVmGbAVUjWLCQrZ2RZV?=
 =?us-ascii?Q?YkGLZl4qPvmMQ0dpXKjMl4TKuOCjw6LJoFUrk8h25wsPZdoY/JwCPO6Rs1/z?=
 =?us-ascii?Q?iyPsuJlsJpmCNSFAWeGTBzSGxjppZq1GhWT/NAvkweQVYTnEhUCA8fR6RTvF?=
 =?us-ascii?Q?GokRPwzJ8ZjSXH6wvIFPA8txNO73yXzOkmJdRt3+i2SrGDIO4JPijNKw0/uH?=
 =?us-ascii?Q?c3D/da9TPphoyWIDHMnjH9Lv/FZ9FbUd+FSSSuAG+6F3L3X99T7huHCyAXbU?=
 =?us-ascii?Q?Fn5tDx0imAig70+ynWxPl2VGQavnf01JlD3vU3gH/DycYmR6nHGuSW4J0XSj?=
 =?us-ascii?Q?Jm8St0yAxMUXkaXLrzFjN3rxVnHt7JY2nMHPPrWBN5UBOGv94rj5r8LqVLbK?=
 =?us-ascii?Q?Q02wYUZ8Mnbc7l4a7/EZlNI4afGjpnJSIT50TNr02VtAOOA65G/DBqmgUBgw?=
 =?us-ascii?Q?s2VjZeGiksvIkGAf/s3FO6FM6+Uh6ezy77geczJlhwyQU8vUqZw1bv/4RkBN?=
 =?us-ascii?Q?6BLeqGk5/g=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f517f3cc-ae25-484e-e9d7-08d9a85223ab
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 16:08:19.0313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nYJunztnpG9YoiqmDB10DQFqV4FzDH03x68leCx0K1zNvnmcaRls83OZu6N/93vFJCtpoL3MUZelCcjshHYT6YScoxDzpQUjHu+LdXHTsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3866
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

Fabian Stelzer (2):
  test-lib: show missing prereq summary
  test-lib: introduce required prereq for test runs

 t/README                |  6 ++++++
 t/aggregate-results.sh  | 17 +++++++++++++++++
 t/test-lib-functions.sh | 11 +++++++++++
 t/test-lib.sh           | 11 +++++++++++
 4 files changed, 45 insertions(+)


base-commit: 5a73c6bdc717127c2da99f57bc630c4efd8aed02
-- 
2.31.1

