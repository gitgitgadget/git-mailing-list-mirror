Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A867C433F5
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 05:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbiDWF2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 01:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiDWF2R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 01:28:17 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-oln040092064029.outbound.protection.outlook.com [40.92.64.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DFF16FACF
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 22:25:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuEUDdnOWoMVzkx/ww57XjCnel+SZARh4YpQGD6EnIwUbNw2Aq9TnQDaacnVZS31UKaakvfN4JEtc0AstCIo3bj0zHjvt6xiz/6mdBiLCTgZxmLU1P9iKugCqJ/85tsJxLl7yNB4UVJgrqwBqSls5wTdFglA7CCcpQV/KWxw1EE8QIjnxvM4AMUUVVrL6Y2fqXNRxDecZPzAy4wDwNlj02HUUxYM8fPIdHBZEsq4moLmNFlEI0upkGZtob+ylIviu9TPuwNnOl54aPCf8nWc+2zdVQzrfvUBnKtjIXY5RaTtiYnuQlKV8/6IMdnRgLg/1A3MNT4378oJtXaEICOBiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17vIkY7JbAqSEEXQd80uzNTQnXrGSsbewq1XAj29fW4=;
 b=ho+kTfEzz8bK6lg3cvWhEeZ+IHM48gqy7ngUT41ZXw9Gz9t8YUB8pUABMfAHJFyQpFKG9ityX9UXTLxSjgTn5jM8Avx2+PdMg0D6ZSTeEGY+NxFKnvP7na2a/2s5nOvEOJmdvV7lEqEww79dupyyp9QhPl1Gd7yFHwKyLurAy/bqDAmZ4hk3LhHus3cpFyYx/xiXfxGYoFFU7m9VMNoGsSGWKeVvVA/s8rYpFU9JvNijK/WB8EPqkRNDsLqYbD85gUn8F+vtgzhtWnBsAQY6eRAB/aC4OT45Z4sWpMBWXkgkuT8JYK1Czl5DldB5hfB8XE1D6FpNzZbw0So/UoAyVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM0PR04MB6019.eurprd04.prod.outlook.com (2603:10a6:208:141::13)
 by PA4PR04MB7581.eurprd04.prod.outlook.com (2603:10a6:102:f3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Sat, 23 Apr
 2022 05:25:17 +0000
Received: from AM0PR04MB6019.eurprd04.prod.outlook.com
 ([fe80::f595:9597:c055:dfe4]) by AM0PR04MB6019.eurprd04.prod.outlook.com
 ([fe80::f595:9597:c055:dfe4%7]) with mapi id 15.20.5186.015; Sat, 23 Apr 2022
 05:25:17 +0000
Date:   Sat, 23 Apr 2022 07:25:15 +0200 (CEST)
From:   =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To:     git@vger.kernel.org
cc:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: gitk regression in version 2.36.0
Message-ID: <AM0PR04MB6019ECF053F1FB7B29D75AB7A5F69@AM0PR04MB6019.eurprd04.prod.outlook.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-TMN:  [QSDqFkWja3d0kf9pRL///hMwO6mc2FwIPBd/xGJga2xxZ6GieAWnqmh7horb1T9v]
X-ClientProxiedBy: AM6PR02CA0027.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::40) To AM0PR04MB6019.eurprd04.prod.outlook.com
 (2603:10a6:208:141::13)
X-Microsoft-Original-Message-ID: <95a58d73-29d9-371b-65de-45f8b1b8d165@live.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ee8d0f4-7207-4b9f-a06a-08da24e9a681
X-MS-TrafficTypeDiagnostic: PA4PR04MB7581:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jH1OISHA5k3DhEY/I4DCUNk4Gsj1ie0+/gWpj9V+K2IgD4VU+a5PwrdI0o9/PlxoaijANbhQct1QqKDjsQZPALMNm9Ghz6YWBhjIeV6k3W801cL2rUNfQ6J0nzvvLrdIFzLf3bktneH6vaYQRPM7PSgYzZ5cFz1RTv+OcAdaqV4OeNE9id8cvrWAcMw/zARww38DGEpxMWFGHElw9NNAYqXyQt6A1r6446Z+svAJbCoAe+BwYUjvpDzLtT0/JAwocu4Q4NzCH7N11fE1ie5XC/b5r5LatSSpdHqQfAE1L3nzkwIuLPOKeGrpM8ojkRGkUrEK3r3SMfMLdMzc5HHnIPS/2p7neOTsgvlNHPstM/ZYJTUyIMlmqYg0l6za1uU4FaZr74NjjgUOtOAOZdgtq+ak2NoXhZRWQ9m8j5vabeXdrjWyyV9jX6JkNuq1zcPXsRPnVvgvBJurUCXBS6VPch0MRS8SGpWMKSKSnAyqLFGb7v2NKtHxZsgY5uN2ae/kDcIt6TyKoaxAX/bGjdgf9FtAI3DP4R2xJl+LwT0CuAc/AJjmMhb9+mka/PJ5rJfXrAAeQqrh7jVSDc9HqY954c8zyVKS64n2OqC++l6chYsR0uzckop4dxN+HmjSQva0
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/yVHrEmczUHhAhL0s38N+iC65TtmJTPBX+JGeRgOQMaAfw6D98tdsCILDg1+?=
 =?us-ascii?Q?qiEu1EXxUc2NHSN0jRZwZujs18ZibrsMf1MUeadhAgYSsSyrhwuiYLmU+dE4?=
 =?us-ascii?Q?FvUDeFgb4KmX+81s17uLnmQsPsR4+dDp56Wo1t1b3tYfttvgX/gy5zYcE4fg?=
 =?us-ascii?Q?0ew3w7HJuIIGpGmO5rajLUiaC93z+xZlirxrW6Hli6cVZW3D851nRmMYRwjN?=
 =?us-ascii?Q?RUUByylKwWgY1QoE/ujd6ci82zpQpBtEmS4A/9zWn/MjzDOvM40PWEjw7YOy?=
 =?us-ascii?Q?KQSGiyjgUfU+BH4WDk53fM1qe220uKu09X3wMW80nUZEHmFfM6CL6SivjN3q?=
 =?us-ascii?Q?o/tIg28ln3fukjwIUYC7qUCz3bGQfihIgo9uZPUNAshHuDabI9l5YRiMsHtO?=
 =?us-ascii?Q?U5R4+t8VWoANIZBZLVc2MyRjrZts756ZAgYz7Wqxo3JyT9q2thZBqWuogSVQ?=
 =?us-ascii?Q?3LnbVlrCQ4MCXAZqkg7HyzYtUAhwKGlWaEUEC+Jufx2xofLLR5+zdkpHDiOT?=
 =?us-ascii?Q?wIslG6GEvM+DRtAPfUelqAc+UjLG0DdkhsGwuBcGhflpw6bX6O87X8XjKdGM?=
 =?us-ascii?Q?2b9bYJXIGbpssEAEtdmRg7yGc+OONVR+XcfekBNbHD0zghrPW5/01dSkBxKt?=
 =?us-ascii?Q?Z5aHJb7imEoLqRNM2nKjmq/e8HGh157Rh6dSod1Feh14qv/MUOkVld+mRYl3?=
 =?us-ascii?Q?AZ4pN30pofOD7Fo5K9RHgpbmCdHrh0hJHmwOKUn0lW9za1bgX2Z/W/JfQNog?=
 =?us-ascii?Q?ml/Lt2NrjGs0JY/ez7puiEFVIVwFZujD3F6CMGdDQ99X7cP9WeHvj3+uyvkY?=
 =?us-ascii?Q?ftqnw29HIn/W7UceMzA8awjhF59gqdOgNNtapdbbGCIplGALvHoTv061blvo?=
 =?us-ascii?Q?Af+PakPRqaHBFHMvCqQnaVqGYLTULNeIh5a1dsWheIhyZ8Pviu+ZqfnhCzRO?=
 =?us-ascii?Q?yFIFp4HxzCvzjSXYsGuCET+/4r/ngp+cq93EbbYG+Kf61ChZP77mQKMP2E4C?=
 =?us-ascii?Q?cTyuttlv5EEDH8/P5U9RbglELagl8yRcZCXn2e0PJd9/Xfl1afAIVW3MSLvX?=
 =?us-ascii?Q?jIuJtFy8lbE13vkygB7RcxtxoT+5jK7e4a0jNDpUZm7EYEkPPbvuOsFYiIUO?=
 =?us-ascii?Q?nZqqxjGd3z3nLfTGqvq3zIKW9R5brCSxcVNdyJItOaJ1LcdILNUdBTzmUVJ6?=
 =?us-ascii?Q?C5YfgVCNjUCxP2CLXj2vq75gK78sr3Sz6KeWLFyTN6N1GF/DR7yJlp00pgq9?=
 =?us-ascii?Q?S2zyszUTXXM+ZQ4/XPxmc+FtaeNLqw9EEkkBG0CaSgbjEw2zSu3oaYPA/Pe8?=
 =?us-ascii?Q?UPwJqlYFKznN9rSNnDKhd183SQS2ZsAS/4yFA1V4+VXpd3MELx8EfdODYgOh?=
 =?us-ascii?Q?xlcJTgUQI1TGy3b7I0EtEBNXa6d1L3KNfmz3BwEuQ6CwrAOGjJpNtSNnliO+?=
 =?us-ascii?Q?kmz45N0PkYgXBfbJRuKqufxNPJUHE7sgwonaHeb0UiSsO6COUSnWUw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-03a34.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee8d0f4-7207-4b9f-a06a-08da24e9a681
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 05:25:17.2870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7581
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git 2.36.0 (or more precisely 244c27242f (diff.[ch]: have diff_free() call 
clear_pathspec(opts.pathspec), 2022-02-16)) introduced some change in 
behaviour that causes gitks highlight feature not to work correctly 
anymore.

Here's a quick reproducer based on git.git:

git checkout 244c27242f44e6b88e3a381c90bde08d134c274b~1
make install
git checkout 244c27242f44e6b88e3a381c90bde08d134c274b
PATH=~/bin:$PATH ~/bin/gitk
# In commit 4c53a8c20f (Git 2.35.1, 2022-01-28) (2nd from the top)
# right click GIT-VERSION-GEN and select "Highlight this only".
# You'll see 4c53a8c20f (Git 2.35.1, 2022-01-28) and
# 89bece5c8c (Git 2.35, 2022-01-24) highlighted, but not the surrounding
# commits. Exit gitk.
make install
PATH=~/bin:$PATH ~/bin/gitk
# In commit 4c53a8c20f (Git 2.35.1, 2022-01-28) (2nd from the top)
# right click GIT-VERSION-GEN and select "Highlight this only".
# Almost every non-merge commmit will be highlighted.

I think this is a change in behaviour in `git diff-tree`, but I'm honestly 
not sure what arguments gitk passes to `git diff-tree`, so I'm struggling 
to figure out what exactly changed.

This issue was originally reported as a Git for Windows issue [1], but I 
can also reproduce it on Linux.

[1] https://github.com/git-for-windows/git/issues/3815
