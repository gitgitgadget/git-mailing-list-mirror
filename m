Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E46C6FD1C
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 14:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCYOQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 10:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjCYOQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 10:16:16 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2072.outbound.protection.outlook.com [40.92.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9F7EFB0
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 07:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyAycFFk2PBxhcRGN4g7VebzUHlUieQrChTObzgT0gQAnKweKHqo7IkM6StBwgT054+b3Sh1SZ9tXKf9wGYUvnX0XhPWv3w+B38z/uadAgxjvtI4xaO9U5vDlO2Afjh3OfzXDvYBIPLJbtpi1LNKMhudWxJDUABiG2tQz7pODtVkEFmzM1Db2Vbr6HtSfLKENJha3cbQdCIiLxsxCDNtXvifmm503yWmQpQNLmQJmff90+otR4eIVn0PErZjtqJXT4MxisNrQgbbkJjpNZNJcqhzB+3zp5DjVgZ8P9TcH0u1AT2+j9fMPJ95NtlKSVES25mWaYoyPGKFnNw9qpXvsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9wpPWLQBSjCxj1QXIV6Z79kcCwWJB/mkfPIRONJ1Zk=;
 b=ONjID0DefOvjD5/iAj5wDYTuSvlDcf0oRyNWEE1OE+4meP5WDinampqSurFQ463DK/dkIiFuwSOeI7TDZDOSKPjNlU6z9fdQcLe0XmsxMF9cfns6SCDTZy/QGQFRciJibI64187A9Fe3GuH0nG3QnavNciIm9YgKhv/wUzkWzIa+apD6WfBz85HFN41Vu1oUMHUBntx5JkR++gzEvTga4U65bzIeK4bFXYuNlVy3oYM+mmUWes4f4RX2QbCuCG5eqFyctkWdB80KP5ap/1wEI/P+DbuTgr6f3iG+KQa0gA5LBtzzLqLaUhYn70Q/yp8V7CtLl8WLHY2KT2p0z9o2OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9wpPWLQBSjCxj1QXIV6Z79kcCwWJB/mkfPIRONJ1Zk=;
 b=j1FOn2okv2OY4HYhWkGj0fMoEPBPygYDhto7x+5djr/8mBYraYkiqyDO4xK35IT9VY78F8ZjdOdjQW+/u4WfZDjy7u1cpOY/8zLhEZO4XLLc3WG9XJFTi4Dq72+DLNBK430zetxurWAZ4sBd17bfH8IHQe923XNvTsupsbYAiGI8rUkjJKKEwm1t29ssvL2sONAcjT1yGP6owQHb0Tln1mzhKsQaOmkw9vr5Nuu1byVIYj50YP6FuzPDl60StayNb/9vUmGTWEYXva4KiYTm4N9649/YKgbECZs/UG2b5IwunRsnipHfe5b5Tdpdyy0jGiH+Nf7auBjWcxj0syos+g==
Received: from MW4PR20MB5517.namprd20.prod.outlook.com (2603:10b6:303:22e::15)
 by CY5PR20MB4698.namprd20.prod.outlook.com (2603:10b6:930:2e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.40; Sat, 25 Mar
 2023 14:16:12 +0000
Received: from MW4PR20MB5517.namprd20.prod.outlook.com
 ([fe80::ae9:1282:c6ba:d6d7]) by MW4PR20MB5517.namprd20.prod.outlook.com
 ([fe80::ae9:1282:c6ba:d6d7%8]) with mapi id 15.20.6222.010; Sat, 25 Mar 2023
 14:16:12 +0000
From:   Mario Grgic <mario_grgic@hotmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: git bug: Perl compatible regular expressions do not work as
 expected
Date:   Sat, 25 Mar 2023 10:16:09 -0400
References: <MW4PR20MB5517583CBEEF34B1E87CCF1290859@MW4PR20MB5517.namprd20.prod.outlook.com>
To:     git@vger.kernel.org
In-Reply-To: <MW4PR20MB5517583CBEEF34B1E87CCF1290859@MW4PR20MB5517.namprd20.prod.outlook.com>
Message-ID: <MW4PR20MB551709099740DB3777C5CEAD90859@MW4PR20MB5517.namprd20.prod.outlook.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-TMN:  [PEPVea+xjovka/lZln08VWD6RKBVpQxH]
X-ClientProxiedBy: CH0PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:610:75::6) To MW4PR20MB5517.namprd20.prod.outlook.com
 (2603:10b6:303:22e::15)
X-Microsoft-Original-Message-ID: <717F1092-F252-427A-B9E0-FA52EABC05E5@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR20MB5517:EE_|CY5PR20MB4698:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a29810c-fec9-4e94-d60f-08db2d3b7c7b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4SscFUqYUK44idgauDiehi6qPZ4pm0r781Kpbva3R9fKTONLpdScefPNVFKVg2y4kYvXevSdF9u5bn3EG4nvIULZsj+YQBa7r3Jmj9H9ypDFo8Uc2s6OrexHulVkmWVlhSteffJhKXtOG9hPVrZvx3zqX6cQw3CnC5xb0VHIWPFCcDVAYgOlFMhXSWzdrgt7p+f32ykTq18jENHZtkLstZzJmZP10jbAorszUfjgjrlweHdFo+QUYDBnffYFi4aPmQlX/20rDpH7gUKRn847rLxrvWwL4I28USULZ4ZL7yz/qosA1RnuLwOb3u/yB1gV5LUJ5Bg722Jxv/X+NtTk27LvfRXRIa+7MJWqu7exiqsUn3j2W+9WsafQPYCRy4Chfq+8dLER95Q/gxLOyoG7fvQzjZAmUg0vgfYzgi0UqJsW5uhatWv8xPXkWgbogYZxiy74W53je5jxd3P069wp/cf//REKAXQuP0y9rcWZcLXF9LM+vBLj3m/ER6OqoueQDraCHrs4Xvo0R1B1CBE/9C6wfWvHGShJ1/vca014cRAgKoYHRITgV7e29TsVIQlxvHdpuFePlsPFN4h6NZlBqx/toPXPKu1ijWhxd2p9Sj80F6IIYNqwROgrEH9LJC+h
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mDI9QjSP+3WQz3Vfw8HIciiNHZfjUff9IBLu3X1+Rxf2LUE/lbB5YcPC2r68?=
 =?us-ascii?Q?e99qDJhT0MRA8dvkgDBjVuG6kmDCbAWEN7ndiuf7rNeF1oT8LrVswDw8tA3u?=
 =?us-ascii?Q?3wZqLfzLjFd9frN3VZ7IQMRTMBMu/aDisYxrmmOK5HHYgJYLCiIlTY6TvqSn?=
 =?us-ascii?Q?R6cBRR4wfx7oMyfd3goPEYXnW5NEJLkt+yfNEg8O5GvT1X70euhxfIyme+dV?=
 =?us-ascii?Q?mzjH5XS1kdXv0Z5U5zDh957sIYszV640iDwpcm/urQ6b0Hnx3Syn3n4J5K+7?=
 =?us-ascii?Q?051X4TnF8EEZda7B+za/6HceiFZell2L4xlkAu3TWtQInojouFSfw8iRcSJQ?=
 =?us-ascii?Q?TNNyFMOAglFv+W90gM/WuqGefngzDp9lblgLWebF6OD0VQS/EtRB5o//7LRp?=
 =?us-ascii?Q?UUfuj8IAYZ098SrEcpS4wOYV2dQd0a/VHct+xFyHIcYo1je3Y4kRAo0twAg2?=
 =?us-ascii?Q?99icuACdsp8sirVrWfSuLfglBvZqkAyZFY3dXKpysX3eUUOUbcL/MBH59Xji?=
 =?us-ascii?Q?oqB2gS5iH4vS/ixuYuZp6vwABa9fsZEJqDD34LaIKOPCfDmomo0Pb75Xkziv?=
 =?us-ascii?Q?CirupEHIfr1WvZiZTUeKjXsTmVFCSVfIGg2UZdm85APbPJwyAfokYv+abBe5?=
 =?us-ascii?Q?jTWKA/jI6mGvhHb2OUe0g2U+9TkrqR8hawcXdBqrzga3bxbkrQ1vC0rMhEvq?=
 =?us-ascii?Q?kW2YRnT6L6FH3p9a4vXD6S/LEuzJ4zba2sNXR3n2SUudZSmqFr6c8gAMRDNj?=
 =?us-ascii?Q?lGL8wxgCTP818rNI1vNweAvRUmyONB/KSHhlfclvSB6aqMMSK+BHfSWlgGZN?=
 =?us-ascii?Q?cq/NXopKl6t0TrFL97zxYNzyQkIQB9578Am1KNdPQdyou3hiHQTVvBiLGWrg?=
 =?us-ascii?Q?jafFRy3WDuewnlu5HGNR2d9b94VI3a9NMXs62Y88nm2sFluxZ/8H3cQel8/I?=
 =?us-ascii?Q?1vjnflO/h2om1XD0Bkjq9KSFy8h9xEYhqpi95VytFAPsH9lzdfcHoC8mVb8q?=
 =?us-ascii?Q?qxdgCxXwnqzAHDXNlEnq+MmdL1VlBVKMgDY3RvWB4RMo+AOVCh89qQB05t9J?=
 =?us-ascii?Q?jrTw3Q7PtgPDEuLMILHXiWTXi0tT7xaS3S/ngAicdVpon1beb1/PD8jPUuTN?=
 =?us-ascii?Q?0t7dpBzdT4DByXWDc2onbj592hyEIF3r/7oKtbCYwUPI13qjHbaPlvdNqtH6?=
 =?us-ascii?Q?OV+ZMmExGiUt5SQB3WT2UnoXKQYAPzBwNP5pph4T9VIukNcToTittP9mVew?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-9803a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a29810c-fec9-4e94-d60f-08db2d3b7c7b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR20MB5517.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2023 14:16:12.0492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR20MB4698
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to git bisect, this got broken in the following commit:


commit 1819ad327b7a1f19540a819813b70a0e8a7f798f
Author: Diomidis Spinellis <dds@aueb.gr>
Date:   Fri Aug 26 11:58:15 2022 +0300

    grep: fix multibyte regex handling under macOS
    
    The commit 29de20504e (Makefile: fix default regex settings on
    Darwin, 2013-05-11) fixed t0070-fundamental.sh under Darwin (macOS) by
    adopting Git's regex library.  However, this library is compiled with
    NO_MBSUPPORT, which causes git-grep to work incorrectly on multibyte
    (e.g. UTF-8) files.  Current macOS versions pass t0070-fundamental.sh
    with the native macOS regex library, which also supports multibyte
    characters.
    
    Adjust the Makefile to use the native regex library, and call
    setlocale(3) to set CTYPE according to the user's preference.
    The setlocale call is required on all platforms, but in platforms
    supporting gettext(3), setlocale was called as a side-effect of
    initializing gettext.  Therefore, move the CTYPE setlocale call from
    gettext.c to common-main.c and the corresponding locale.h include
    into git-compat-util.h.
    
    Thanks to the global initialization of CTYPE setlocale, the test-tool
    regex command now works correctly with supported multibyte regexes, and
    is used to set the MB_REGEX test prerequisite by assessing a platform's
    support for them.
    
    Signed-off-by: Diomidis Spinellis <dds@aueb.gr>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

 Makefile          |  2 +-
 common-main.c     |  1 +
 gettext.c         |  2 --
 git-compat-util.h |  1 +
 t/t7810-grep.sh   | 15 +++++++++++++++
 5 files changed, 18 insertions(+), 3 deletions(-)

