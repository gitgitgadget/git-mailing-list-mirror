Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04158C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 15:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC2D4611CC
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 15:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbhKSPKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 10:10:15 -0500
Received: from mail-cy1gcc01bn2015.outbound.protection.outlook.com ([52.100.19.15]:48455
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233869AbhKSPKP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 10:10:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GysL1ThPINEhTV0MJhSSOPVGo5SjGwwBwd3xEXuxWSZxbgbDHZ39VNo3ER1psTDsF8IjDf8ySnYOZ7CauPIQ4s/sh937wEHp/LG5Cl2jwb5AdzwmEsNfu+gnTBFKk6q3GX+cDc5UedjLYyxGbXrMdFfHnaP3RlDJ5WS41x6SONiW+PCs2wCmhA+tCuZWD1FVOHmB0zZwpad/cK46K+T0ppJ2ydKCxGMAlVOWz5SZsSIbe4hN8Ziqr1u3+It9/eSf+UHAuqHLZrzL7VWuKot7UiSaiGirPAhnLiRH/nQwyANZo9EywYkF5LFkRDylxfCRUB83oqVhyv0kNWb9uK0iIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOcErr2cIKnWcyGIzLiUS1Fy3Tfv+UPlV9YI2xo5up8=;
 b=PpeKzAN29FWHR5qLHFFgyIQSpgaFGb3rZuupp7XWZV0g/MKDj+I/gAP/Js+DcvOQ/64ZyiuHjEm6762OA7/uY+knPatZo7NMHOfu30eAkYHDFoOrxF8mKfheeMsSGKGZUBCQhuwnif3D/JxePa5zQAHntpYCgFXGjA0tE2w3DEfynQtw+w5eOZGx7ZY7fB/c2pzv2G1qoat3ooi084yUGDvTsEfIwcqwC+aBBrXyaUxoYC7DEeZIKyrLVwR+jWx+HEoAkwVeOe3tF1COR65A1EQIBuG4WG6hn4U6BlqcfAyyM2DnbZ1VI6YmT8vdf/D+vX7RlHqKF0tZ2CeRdL/jWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOcErr2cIKnWcyGIzLiUS1Fy3Tfv+UPlV9YI2xo5up8=;
 b=Rulh//D5k6aE+g8vQpIRStF1tfTMzW4fiTd4DFykZrOF/FOH1KWJ6hzpqQyzfG1rZ05vCcn5MErAUvIg5KugIQhSI/QfCF0gKuAvU/EiZBt8rgz7QhDAO/pijOr3MTiNqB2p9xQguOFlY5Nn64nhHZV1fRKbsxXCLMz+k/Nc1N4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4207.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:94::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20; Fri, 19 Nov
 2021 15:07:11 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.020; Fri, 19 Nov 2021
 15:07:11 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v3 0/2] ssh signing: support non ssh-* keytypes
Date:   Fri, 19 Nov 2021 16:07:05 +0100
Message-Id: <20211119150707.3924636-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211117162727.650857-1-fs@gigacodes.de>
References: <20211117162727.650857-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR07CA0054.eurprd07.prod.outlook.com
 (2603:10a6:20b:459::32) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS8PR07CA0054.eurprd07.prod.outlook.com (2603:10a6:20b:459::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.18 via Frontend Transport; Fri, 19 Nov 2021 15:07:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7989f43-081f-4ff9-bdea-08d9ab6e42ff
X-MS-TrafficTypeDiagnostic: PR3PR10MB4207:
X-Microsoft-Antispam-PRVS: <PR3PR10MB4207B6B3AF8314F688C99138B69C9@PR3PR10MB4207.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y4gJ6DISKTSkBL/OL7nM4a+uVd6891a01dQu0ky0muKVxA/PzGIRarNwGN+k?=
 =?us-ascii?Q?/zR4bqxobyLg3iLq+PIklxihkQcv0S0IbM0qcyWSZqG3kudXeTz35/e2bUck?=
 =?us-ascii?Q?4XpevYaFf1EPJrx3kKmxChooIPJE3toESEoTjvdiNWOnIQJqCuMNkC2uVC5X?=
 =?us-ascii?Q?jA2pmfcVGetRI2W+U6n63kOOJvWyqWaXZTCP+RnGCMSCf0BptSRwCrm0/zBY?=
 =?us-ascii?Q?G0cWhuFOoiDijcmeeCVF6iyehphuzegX0KfdBqAQvn5Y8q4qUQf7lbWerWAH?=
 =?us-ascii?Q?bO70ZQdZK/Y2zL6YtYBsOjrayNTBJFOmDs7iPZjAccj5SHAWpOWHpy065FwE?=
 =?us-ascii?Q?zeRWLxA2LlcYeCaiCTUe6v+9dI62OP+tkGFYyE2Z/uaMgzcxiXTqfORkkf7j?=
 =?us-ascii?Q?fxF2UQkxfptrC/d4H3I54bZJToe3ffwk3Jb15v8FCR/yAc7yV2jmMeZ/jO5s?=
 =?us-ascii?Q?xTxcT4aT3ZNevnGfV5TYFjQpGqLV3RropFhLG6itM2Q5oR9mEFe3PxcmF1SH?=
 =?us-ascii?Q?+c4iD7OGVZjIN/mIcn3HVNIqIUy6Mm0k++38O0W915QjTdwnmJ83eRZUcDTu?=
 =?us-ascii?Q?6BGKWKSie5Jsf7nU+PllAxWKpkN77j1lBtfZO7tbk67s0P6r4fnlhpn2maRM?=
 =?us-ascii?Q?A580qL/5Ey56uaA/uoHbxZvhBbqwOivSRpJE1YfgTwkjetFaaS1vRiRo90od?=
 =?us-ascii?Q?9AL5ITE5tXOYyHWjetwLqb8u42z3yyFWJEXHyxUOjmW6bQxgGN7AZzsayLXG?=
 =?us-ascii?Q?tGATiyVqsUO0L7MvSWxB+ePHO5KHNuRr1i6Z7vQoEpFzEqvcdIeWXgiu0MGh?=
 =?us-ascii?Q?gvi+hUmHv+C1S+xnwUW/FbJzBd/z7AQn8aef5Qb/YqpDhQoUFCrV/Q9dzKP+?=
 =?us-ascii?Q?U4ljW0IU68sYWiJT4MfDGh0Zea16KUMb6b63bOU/3MRLVEPxrO7HOzLVFjUF?=
 =?us-ascii?Q?YoNK5SSUgtfh3zeO+WTy8Fq3mZ9AjzNYTqHp/fRiVW5ofyHV6MQIjs3LPp5C?=
 =?us-ascii?Q?vlnlwj4QaBBz4rOD399aGaJIcQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(376002)(396003)(366004)(136003)(39830400003)(346002)(1076003)(86362001)(186003)(316002)(54906003)(66556008)(66476007)(6666004)(6916009)(8676002)(66946007)(52116002)(36756003)(6496006)(83380400001)(2616005)(508600001)(6486002)(107886003)(4326008)(8936002)(38100700002)(2906002)(5660300002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wAHQ/2Hg6yS3RxGh/HV2FtYjgVENp8bCE3w0zq98Pqaibna0asWxXYSRMlzz?=
 =?us-ascii?Q?96VD0yTMDIyy8xQYZ1usG5NCBZCCYfGIH0KLYoloYxe2j2FMbuLDDg6lNoWn?=
 =?us-ascii?Q?EB/1GAsUJJDabny3Nw6dlR2YZ+Fs8usInVhrrKo0QLrfMREoQQfO94hUehi9?=
 =?us-ascii?Q?EGPQ28J384UFG8yr3Myl4jRvNSL+sKCPuv0SnAmKXTzxM2FzIjYSfG//R8nU?=
 =?us-ascii?Q?yeUPCoj4oZltWWNIuaMr5XGCJSPbM3qmmXAHDeecoNvarXMWqpLrkLF39bq8?=
 =?us-ascii?Q?FU8T2hjFESxYY2y5D2ysG/FxDggZYYqYPoGvmMLDQItrbcM7bcpRhUE0pID4?=
 =?us-ascii?Q?4nkRNM5bT+wdAPO4Azaqrf2uX/DkIHMXAATth0/tPLpgJdtoxfERh6sTWKAo?=
 =?us-ascii?Q?lLMJVzGhC7T5UFqY+Vot8ChkYoKMgcDkXfkOEBMoSjJ9Y5vKhxqN/q/woc7h?=
 =?us-ascii?Q?yrywiqEtnaxkJW9rRade58qVRRAoP1NE6A3GLC/eL2q9cJyQVyLVPc1tgTpN?=
 =?us-ascii?Q?obcMs6uBJtPPUgO4QjHXu4bpzlGNYAuPkOdnTGCspf5a/fHKZTILD1oz/nws?=
 =?us-ascii?Q?qM1tP5S9OzTt3ZaxxIlMYoh9XXi0lATI6kV8hKJ8xRMTPDmTb3lO/uYAMvVH?=
 =?us-ascii?Q?iD7j7Qvj+pPDgus4Wjk+WfG3cN5xN0cqqQT9x7KblEYEEaN5ZNWNVFHJWHPY?=
 =?us-ascii?Q?YsMqbzd2kG/+TxxuBaZLrboyjDPBSPgvu/+VXStZhIM7p6RqY5FR+tas/jt2?=
 =?us-ascii?Q?EkqVli7XR6g1kNwF+ZVHMod4QsL1o6HJM9N82dE0k4XUdomX6qPiGSdbxhLe?=
 =?us-ascii?Q?vJrVPuOomiWhfUgdCSgf8bRcWSktxGFyBoAUmMZ62usod0rjK7NiKzDg7IXv?=
 =?us-ascii?Q?XaqPpxoNLrudUfWjFLb7FXDulDcmhgixvKw2E/twFZebgVJ2vdSy6XY5tWJX?=
 =?us-ascii?Q?vN9hogvYujCeB5r8M1rDvQjn9QlUWU1eAWD4zGgBmN6d8lD/JgwdwmPFMWLj?=
 =?us-ascii?Q?IMsM0w6V3IdJ7DApPdIeuyy+scDuRM0x8Ms7krmHSGQPt2w/Wk0mEThRNNqU?=
 =?us-ascii?Q?AnFPZFrRkVbQpbyOENMYSZneaLbKOuFmeQ6837Qg9MxDGcQWYnEI3CZePRN2?=
 =?us-ascii?Q?BAg9tcU3y2OKW0mCrZET6Ew1NzaSyNWaSlJXRkUp48Kw8Zv2tcjykW4IxMn6?=
 =?us-ascii?Q?/PTeek4yBns2XIAgo1hSUQC438ZWo+99ABYryentSX1yfUf/hoMBMD8aQJ2M?=
 =?us-ascii?Q?xdVBieUMtdFY5gUX0fWRr536UaCZCo0KbPfmMSHk0aZuS0pDUiru4MU/3qvu?=
 =?us-ascii?Q?7OyEJFEVefl1mDukBerrLies767B8vEetJzdL2wQWMzdLZEyaX+g5Zb+JRjd?=
 =?us-ascii?Q?c+VDIf4qnGG43Cw3vI5alFGn4gkY08ox2zVq8cBYvIuHYcRJvGXAm9+jAtB7?=
 =?us-ascii?Q?UiWH7eEhUWxysSXj3wwOwupFqMCjabSVxB1RxvzrHnsYGKzMQi1/3sS+1Sp3?=
 =?us-ascii?Q?C6gsWNImjGo6Q5aVMjUedM1ZGiVwOhwScTUqgRNplAPpEnNomKCkXb42Egai?=
 =?us-ascii?Q?VFQIXQxRKVbnBt99VYKSSt4YoRZ3nq55dWPeaB4Km3kmXXssIXLRbGXa78TU?=
 =?us-ascii?Q?wwbcY5NeTTr47FrhBb65EaFkp2Aq+4CcQZgspVmeOA+1Q/pa3Wq11G+E0PUO?=
 =?us-ascii?Q?Ux1a5sCVHadU4YT/OuDyb3CemrmzXE50rjhuHIacGWx2JbLQ/m9Q4nlQsPPY?=
 =?us-ascii?Q?aR0cp/AAAS/7qbCFw0GyheRZa8M9Rsg=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b7989f43-081f-4ff9-bdea-08d9ab6e42ff
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 15:07:10.9788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIfKTG2jAEL5Q6ShJ0g8DYep6vMUw45m4MoS0twhvYKKsaxpG278hddK+szT46rEV8giHc1BosWDr0Q5s/Ecb2eDJSTPDAwGfzUClYmaipo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4207
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

support generic ssh keytypes using a `key::` prefix instead of relying
on ssh- prefixes.

changes since v2:
 - no longer hide that we still support `ssh-` prefixes for literal
   keys.

Fabian Stelzer (2):
  ssh signing: support non ssh-* keytypes
  ssh signing: make sign/amend test more resilient

 Documentation/config/user.txt | 17 ++++++++++-------
 gpg-interface.c               | 36 ++++++++++++++++++++++++++++-------
 t/lib-gpg.sh                  |  3 +++
 t/t7510-signed-commit.sh      |  2 +-
 t/t7528-signed-commit-ssh.sh  | 26 +++++++++++++++++++++++--
 5 files changed, 67 insertions(+), 17 deletions(-)

Range-diff against v2:
1:  ea032f98f0 ! 1:  865a32d37c ssh signing: support non ssh-* keytypes
    @@ Documentation/config/user.txt: user.signingKey::
     +	directly (e.g.: "key::ssh-rsa XXXXXX identifier"). The private key
     +	needs to be available via ssh-agent. If not set git will call
     +	gpg.ssh.defaultKeyCommand (e.g.: "ssh-add -L") and try to use the
    -+	first key available.
    ++	first key available. For backward compatibility, a raw key which
    ++	begins with "ssh-", such as "ssh-rsa XXXXXX identifier", is treated
    ++	as "key::ssh-rsa XXXXXX identifier", but this form is deprecated;
    ++	use the `key::` form instead.
     
      ## gpg-interface.c ##
     @@ gpg-interface.c: int git_gpg_config(const char *var, const char *value, void *cb)
2:  5054ff0e76 = 2:  868cb7f524 ssh signing: make sign/amend test more resilient

base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
-- 
2.31.1

