Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1D0C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 15:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADF376112F
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 15:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbhJVPMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 11:12:21 -0400
Received: from mail-ve1eur02hn2203.outbound.protection.outlook.com ([52.100.10.203]:19196
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233086AbhJVPMU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 11:12:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXRDL17v1jenuOlR7k+Gn3lo6AwVmhgn96X5A0JVXBNKBCMVBraCVrLyFkzSeFY0fUcOA3dPF0V5o99bUjutD0Y3XUEFud0jul0/88YunYhlCPPEUIH9PaMzZR2i1yoZy0xVONwr2T3ao4OX12cDpFr97Q7PUiM4IzGgOaDwR4blP8gYSJQ7NxFGypYy3cLBg+pZgmwDN8lkZs0SKupRTT+HBSnzGKHpiuRGC7IhhurFkBhguIgJ5qf0D8n1WmKZDX6B5yKs7grGQmQSpHppRhR5TH40hLaZD/J8PBdVNG+JqJhJB0gjGpqq+1GTTYuNaOfM87SuTDBzv2cAjw6CBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIB3HUU0sePcj8svCrcvP+vpFBfoH1/4lEdYte0lD8k=;
 b=G3S762J/ShBt90T2AoBWMAR3bH0bw/NT4rAhm8BuFmu404+4cBpMjG6oQgcEhInJU4VpgC0bNmMP0cLbVrSqXHfClwZQe3sm+XRlQ1SMk2v6u9A05LbDPh2H2OtQs1i9VPVTOWo1wNJ2QDTxFkndP7FU4KgZtYqf4WnN2iAnn1OdHTrywfpMQlzW+NjBQ4ykyCo8k9diPaCk59ojoSwJlX2xrbTqeAa3wDz25EvT1ouuNmUv8PuwY1NLrT5BkDm3s8mSgRaQEAekeRKkUUpiLOrVCcfVuzrIKExrNJZlEEWXLi7ECYHNTAj7p6ctRfMu6qBG4Jh3fqOmbP7JE/IRrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIB3HUU0sePcj8svCrcvP+vpFBfoH1/4lEdYte0lD8k=;
 b=dhIYc6K17azKbK2ZBzV40Vhyw2tHv5KaKygTkZHeBPtcaeoDPWgwMs6i9q4OtgMb86b+AtI4ZOfqmuajo4QyM/2Ldk8pBIS9j16P9g1Lh/LBd6dLM/7L9Iw3PwP5ZLrRjVeDSCRpn8Q7N4+UJiozZWEBz4nipcI9CiEFvM6Ki0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4637.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:15b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 15:10:01 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 15:10:01 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        "Han-Wen Nienhuys" <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Hans Jerry Illikainen" <hji@dyntopia.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        "Felipe Contreras" <felipe.contreras@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Gwyneth Morgan" <gwymor@tilde.club>,
        "Jonathan Tan" <jonathantanmy@google.com>,
        "Josh Steadmon" <steadmon@google.com>
Subject: [PATCH 0/6] ssh signing: verify key lifetime
Date:   Fri, 22 Oct 2021 17:09:43 +0200
Message-Id: <20211022150949.1754477-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0197.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::22) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS8PR04CA0197.eurprd04.prod.outlook.com (2603:10a6:20b:2f3::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Fri, 22 Oct 2021 15:10:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00c486bc-b90c-4fa0-7d2b-08d9956e04bd
X-MS-TrafficTypeDiagnostic: PAXPR10MB4637:
X-Microsoft-Antispam-PRVS: <PAXPR10MB46379522BD12DD1538DC0BA0B6809@PAXPR10MB4637.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lQSmxFr/wRhSOkElC0Y8wyHdAvoDrz53997IosGi28Vt5GyEYfyyD/y3jG+Q?=
 =?us-ascii?Q?/wk5QxbpBdK97nFuCw23vCUGhhXnC50ozmTaJEpaA7ftQ5JMW3NpTmq+cf3+?=
 =?us-ascii?Q?97we2/0GFQODZ4kq1Mo90caNnqZIiQGVNLB0Hl3+kFGcXL24TZ2JJ9ZG+S1X?=
 =?us-ascii?Q?eac8aIYrqymrF74Bzk2p0JG2EwDhVySp5I3jhBBVo+ykenMRKCO6e9buLRFb?=
 =?us-ascii?Q?1Ol4Vhs+/Z4siRmDpXk2Tpsogr1ip+bsL61AlXQlBmtYwNZe4KBHRl4eIKHb?=
 =?us-ascii?Q?DY1R5XobKpTmMpTWzAna1m8xQOIsxRprOa03Uqjnosytmm+vfauu+cpSndOM?=
 =?us-ascii?Q?5BL/8z3EUoQnOPhKrdDL3J5DG/6kjhsfYt4Usv0g09xQfFosZ8vDgLn8nOGZ?=
 =?us-ascii?Q?blKtTuq+FJkEPa6BiXUUaQ1C8AP36YSmZEkQ9WYJzAKJlR75tpm9EpK8GFbn?=
 =?us-ascii?Q?akzxsgKi0WIevOt46dQuwtGdl5685qGg+AtWfQ30hXKxQ5vaaR/XOlkJOX10?=
 =?us-ascii?Q?GcnTd0Onrl5bSpqRTyh0cXm7kA5g2OwC6oiRfj9upZZC3DgT2lEuY6mQ7lMN?=
 =?us-ascii?Q?Gl8XTG/tcm5lX8EB7WL8EQWRBhYE9tkQbjGQq5DblqA+VNwu5qpUfyALRvRV?=
 =?us-ascii?Q?PWRLHPGzfmYVjjlEq4yryI91i/v+AVr3tIBe+GP17S5tMJwJrYI6KzfFFJTF?=
 =?us-ascii?Q?z5h2ZdW7Nk+AGFpTCOzJerYFdkrbHlAv0b1h6ir5FLf7+iT7dR3FpjylHiV6?=
 =?us-ascii?Q?HffgOwjKelaKtgOxMt8oRuKnj0X05BgF7oYcwbWbviT/HrCzLai9luR5QoIG?=
 =?us-ascii?Q?PKvbnqhQGWkHZrGJM+usovDgfyYEACQhtCWEwTzjErBwkBuc2L2Klm9WTXTA?=
 =?us-ascii?Q?Gn+bH7DGMMbj1Rx/ceeGNAC07Ov2JGD7s1yxXBY9dn/r6gnorZkyxeccSclV?=
 =?us-ascii?Q?/dWN25eSGocZw1fq5xHpKkARYk6E6Fzsp7r86ZASxBFg3lx/wCsb5PDjaABL?=
 =?us-ascii?Q?mvsDNsHQ7DCiy6HgVzklHzx3AQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39840400004)(4326008)(7416002)(186003)(6486002)(2616005)(316002)(66476007)(66946007)(5660300002)(8936002)(8676002)(508600001)(83380400001)(38100700002)(15650500001)(66556008)(2906002)(6666004)(54906003)(6496006)(36756003)(86362001)(6916009)(1076003)(52116002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?azmtVbRaFwNLda3ojaZeb/daaUHR75I9LNCtU59UXJYDHZ7fakRlzP1J/Im9?=
 =?us-ascii?Q?VSfuz4G2HJW9oQKrd0Jgz8SN1tLaOCzKbysT68vPMJvv9MlGk7UYSIb4RMq0?=
 =?us-ascii?Q?fWEcBUiBFA6miShQV+gqK9tdjArFJPkGA1cRBJNctdB1/9oHTEExQZkmrG4P?=
 =?us-ascii?Q?HsRqa30rrH/5XXHNWMRr9JBSJzYGFG1e1Ab1Nxmke1l9V15iiN+vZnNnZ98s?=
 =?us-ascii?Q?6+3TEygmXqbF84OpwxAwKGrfSti6L4xgwKWDhWs8dxW3wB5/13baYrc7Uutp?=
 =?us-ascii?Q?zgZvJw/1ZgQjmJws7qXL6eIh+DLJ3p1paZssladkvqznuWik+w2gUNfobStu?=
 =?us-ascii?Q?+OiFDOnsDHntzimq6iu9yA1qlpn9OKxZWa2JgUYacUziF0EpHh9d2eOgUogc?=
 =?us-ascii?Q?Y2yVecyhWwAjwJIhvPAuuIxQHkbqD5bPVrsVCz3+DJpUkDWF/BDoUHP1tauu?=
 =?us-ascii?Q?3SsyZfc3n779ZNj7fL/3GwlY8zIPxcH3cdAAVk78NU4QXCGJFLi6s9R6Zf8/?=
 =?us-ascii?Q?kjFLku7slMo2gGDY92QfZXKScDsA797LY9yvNKf+Xe7YDjg+gSgiKSflajXi?=
 =?us-ascii?Q?HccYPYsOj4+tGK+hSDNraxY1zKhN5P/DELTHVOYvy9OmwO2FEvSrwfOtRtOt?=
 =?us-ascii?Q?pbSiQPxrC8px9tzB8qXyoTVvFDeNZ2UZiBE/i4ZAzZ09ESaEvmzHXNL3bvVu?=
 =?us-ascii?Q?xjlwuW2T4ud8uPRpP++2ekvKpw28a384IiH2cixSNteP0FPx4VlMbF+KfHdw?=
 =?us-ascii?Q?aEToxJjTryKerNtcUnfsBwPVIE6T9w+PgT6EKxS/sU2h+11GV18tuRkUE4fl?=
 =?us-ascii?Q?bCNrcAjOyIhhmNcRzV4AuebrtlBoFu8nJYjpvnuqdhGRuxDsI7sGlJ5bAPe+?=
 =?us-ascii?Q?M5I/y3zyX4165k1P+vs1h6T/N+F1pkYRIBrbI6iEGVDc6c5/yQ9iIanhl6iX?=
 =?us-ascii?Q?zGqyiH+wNqHAoOkAM4CGpW44yeBiOuuosehSu93nLylwl2W7MTI5nKdgBY/X?=
 =?us-ascii?Q?FbimvdU/mQqQhO6L+bUtUMPO/rDCz/dFpm5eTlj5q2+q74ysA2aOYifrtv+5?=
 =?us-ascii?Q?dLF8gbSAtJrrBvqV0Fb7e3SnTcZM32T4i6UUDNVOAaOx9HBKEEkPm5T7wLvo?=
 =?us-ascii?Q?1f+yV0KOE/JG9ZBaVkHQB8QmkaJW7+oiqAsfzagkIlZ2Mba1gw5MqobnQlJj?=
 =?us-ascii?Q?edRwYpU1+QC1qrpPHH+M63LU+3GyqiEj1TLTehUyY1fD2MSq+WzaXgRkySEb?=
 =?us-ascii?Q?O6fHEk5bvn9mOXN5ASBvqozd6Y23uqogFHlymquQCbA+cOAHgCbEv9VrcwEF?=
 =?us-ascii?Q?cndNsThi0GJjrNL6soEcsooqDkCr9dvfP3uPgfFEk++/PhLUeMgT2qSMAz7a?=
 =?us-ascii?Q?YkbFqgi8GtBJvCwFqGW31rnnLyJ6s9pcxeT7HAL114ATrNNvhiT+h03+hLoQ?=
 =?us-ascii?Q?EJOAoPTXnssIGRxpc1SyLu+ARPO/L+C6ri8Sz52P5Ardi1XeuONzxf4aX2IO?=
 =?us-ascii?Q?HYbEJInNtsM2tdcaE+RKz7Rc2ShFjHe2R7Zw?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c486bc-b90c-4fa0-7d2b-08d9956e04bd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 15:10:00.9119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fabian.stelzer@campoint.net
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4637
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds key lifetime validity checks by passing commit/tag
dates to the check operaion.

I'm not totally sure about the way i'm parsing payload info via
parse_signed_buffer_metadata(). payload was just an opaque buffer before.
Now gpg-interface actually looks at it (thats wy i used a seperate api
function for it and did not hide it in check_signature).
I chose this approach since it requires the least changes for the consumers
of this functionality.

A cleaner way would maybe be introducing a check_object_signature()
which takes a struct object instead of the payload directly to avoid the
parse function altogether. However only some call sites already have
this struct. Tags & fmt-merge-msg use different ways to produce the
payload and i'm not sure how involved the objects creation would be or what
side-effects this could have(performance?). Since the push-certs use case
will never produce a object struct we would still have to keep the
existing check_signature function anyway (or encapsulate those in some
pseudo-object :/).
The now used parse function also opens the usage up to sites already having
both infos (date & ident), although there is currently none.

Fabian Stelzer (6):
  ssh signing: extend check_signature to accept payload metadata
  ssh signing: add key lifetime test prereqs
  ssh signing: verify-commit/check_signature with commit date
  ssh signing: git log/check_signature with commit date
  ssh signing: verify-tag/check_signature with tag date
  ssh signing: fmt-merge-msg/check_signature with tag date

 Documentation/config/gpg.txt     |  5 ++
 builtin/receive-pack.c           |  5 +-
 commit.c                         | 12 ++++-
 fmt-merge-msg.c                  | 15 +++++-
 gpg-interface.c                  | 79 ++++++++++++++++++++++++++++----
 gpg-interface.h                  | 13 +++++-
 log-tree.c                       | 22 ++++++++-
 t/lib-gpg.sh                     | 19 +++++++-
 t/t4202-log.sh                   | 43 +++++++++++++++++
 t/t6200-fmt-merge-msg.sh         | 54 ++++++++++++++++++++++
 t/t7031-verify-tag-signed-ssh.sh | 42 +++++++++++++++++
 t/t7528-signed-commit-ssh.sh     | 42 +++++++++++++++++
 tag.c                            | 12 ++++-
 13 files changed, 341 insertions(+), 22 deletions(-)


base-commit: d3b4e01def5a9517c919f0b815c1b12296dc3dc2
-- 
2.31.1

