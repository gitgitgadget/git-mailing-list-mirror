Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA354C433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 06:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbiC1GNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 02:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiC1GNW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 02:13:22 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2078.outbound.protection.outlook.com [40.107.255.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8014F17066
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 23:11:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqsUBxWtyBt+cRVj67xyHFn1bNgFIDZMYH1x+fQFd6RxnvvhqgQ6Lql5R/LDgfIzvKgMRye90Y8RWZ85Y2Redwmi4RqM+rOqy5f86s3DUMwUiV5DjfoB7HDHRAgd1oRRlXKsGcJUAQP1qP888+OGrhrMVAow68ob1cwO3hZQdynYtyrcZhGcYg53QeNiQ0ELyfN8oiQyG5YGuCqlSl9i6DtrhndCytVFOxjZe6IuF3QVnpyJfISVuqzDOcjU1CPQhXNPX3JuS+IgfBTJbHfURmn78T6W1IsKiyARC+og0F7JzBcNvaIDGcNB7VFI4fq5BfjDRWpDvkxOGCZ4Z4/Jxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JZn3lFcUsnzoMruervWQfmsthu/2LmBwXH3yyr/BCM=;
 b=WQfjH6CKFuGzGNzi1p0z7vL/TRKx56vv64wizLDwJV422nBB8aNbeFcmyBq0aVMD0+iXt1vqaKgOSNeH47sy+MDjFBsDSVbokhgZG14nFV18s6g8obaGjXb+KKTNLH6Z17jYGgwTTx44aeHqROLr1nCOeFUngNxNNrSluY1nQaCeEkto7co/6ETx8TXmqDbogg92o8nCf65T3U8hpUIFNglhIIknt7JDNhVOPc8E7TtP14Xwz+nr+aIC+1kM+Ct+kfaVeCqSKnqQVIIYeyPxtUDePNap29XvRgHyh57q+olLvAhjSQgfVdP9b9VHibTt4CI7696PvHZfl5a3PLqe9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pmease.com; dmarc=pass action=none header.from=pmease.com;
 dkim=pass header.d=pmease.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gitplex.onmicrosoft.com; s=selector2-gitplex-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JZn3lFcUsnzoMruervWQfmsthu/2LmBwXH3yyr/BCM=;
 b=EmMnijjY5Dyz7l1lza7vPafVKt2W1npetwCG3MSUvPXtzbUKTBQ73IORniCDGGh1gzk4GJkr7jEn/ubKOf87KoukALrswI8YtzzK5w5snxhoHOA8JSuUWe2neqB+pa1SA3yES1JNBdC63CWavIsm9gHDnoxnQixGs4wENPi2Frw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pmease.com;
Received: from SG2PR06MB2966.apcprd06.prod.outlook.com (2603:1096:4:70::14) by
 PS1PR06MB2632.apcprd06.prod.outlook.com (2603:1096:803:4f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18; Mon, 28 Mar 2022 06:11:37 +0000
Received: from SG2PR06MB2966.apcprd06.prod.outlook.com
 ([fe80::dce6:c14e:154e:242f]) by SG2PR06MB2966.apcprd06.prod.outlook.com
 ([fe80::dce6:c14e:154e:242f%5]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 06:11:37 +0000
Content-Type: text/plain;
        charset=us-ascii
Subject: Re: How to get the original raw commit message without removing extra
 leading/trailing line breaks
From:   PMEase <robin@pmease.com>
In-Reply-To: <xmqq5yny62s1.fsf@gitster.g>
Date:   Mon, 28 Mar 2022 14:11:35 +0800
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0D9BB163-A369-47DE-A0DC-AD396FD6DBE4@pmease.com>
References: <1BEBB3E1-0089-44CD-8D3B-3AA424C90E48@pmease.com>
 <xmqq5yny62s1.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-ClientProxiedBy: HK0PR03CA0097.apcprd03.prod.outlook.com
 (2603:1096:203:b0::13) To SG2PR06MB2966.apcprd06.prod.outlook.com
 (2603:1096:4:70::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8817608-3384-47d2-8dc8-08da1081d144
X-MS-TrafficTypeDiagnostic: PS1PR06MB2632:EE_
X-Microsoft-Antispam-PRVS: <PS1PR06MB263224510D01AD8838A10A30C21D9@PS1PR06MB2632.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pd6MQLqX5kTDPuy4Jdhr+LXIMziA1Q0J7S3Tr9M96rEGzHgWh0P/xNkWsubsrAEXda56L3ojMIMVRi7SmZ3nxJSfcGjTCbdesr76U0OxfGrwOmVi+fuOOtN8AVHRu/UeDlta5gXBVEV97PwdRVTSjY4eas2E5vjL/h+mwQPNh7pbJ/37/oNVHbOV0lbPWca/l3wDQjm9nR0C/YgV71H9uciI51CK7nNJglYBEgIdhEy+klBvo1qNDhUZDKjK74JvF5fC8wLnT5yMuFFOD1awwNMjqx/oDFRT313OEBrVPZsmb3i00oVLVOUiQr4NpIytCMmfFxDkmxTnx6G1FDsNuA8DWQyOWBHMQ4HO+iK9gmiB+Cz08GtzwfUkB06osQMlggiGCC7lyTmkqpjCMbYAZex2XSu7xE+6b6WFObycOESe9el2Y/LaJbQef78JSsGcAPQq5h+9cEMF1JNnAK+NKQq4O4FrF+6pCZBbZajtBg5+jUBJFBeIU1wEiAgzXndNf4kyvgF6TABo3FYkGqhfNG8p/OkWq2OqbuXtjNZI9CPp26A/FDjnEOcrEUJO4yWaCYxaOBBVU+PVpmntOhByljbZnULeBZMSfONblFpCZxxPIfGi/qcL6rNAr+cjdz2zMdLPWWLQmyzMIc9lyk2Cb08anhDNV4d0mbrQtD4OZ2K2sCb5gYLXreCpOF8KlM4+5rLCggsmizhlhaGYbXcBWehK54xmvFblR7WeQxuOy9h6/nAnXz01gMzyWjeAbNpAz/SRemZSN66Agj0gcdrQKaVjKfARpYkHf9yMWSmeLSA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB2966.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(136003)(39830400003)(376002)(346002)(366004)(38100700002)(66476007)(83380400001)(2616005)(66556008)(8676002)(4326008)(6512007)(36756003)(26005)(186003)(8936002)(6486002)(66946007)(316002)(4744005)(38350700002)(15650500001)(6506007)(508600001)(53546011)(6916009)(52116002)(2906002)(5660300002)(33656002)(86362001)(226483002)(15583001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0O5lprH94MJ525/0+UJKxj397Pz3gZ42iJFhDY0mg9TX3EDUYAxvC6B9W12V?=
 =?us-ascii?Q?YMTvTOhDHgslWXhA7yTQIeK6MFlDLGCh/zfT8Cdsbg+94+bRJDwamMcL1Jg1?=
 =?us-ascii?Q?arWlqQk3iNR1rUcnb6+ZskT2lkwfwlzm3WN5Oceh4UsYTTZPWFwa4ujDrm48?=
 =?us-ascii?Q?FReQvM1YX1usco1PCAQsNk7Tvf5SwbITvcysaIOlPsj6DhhvrOC+5onxtjWQ?=
 =?us-ascii?Q?+luqOEl4qLUoYb/MMuaobGu9xiznTzVQMJpvNyXSIkF8Vl8vnvbgLx3NG4xw?=
 =?us-ascii?Q?PNTqHrgX2xXHLKdded/ni6+toM/vmMI7xbpGmGzDpkFgXb8YBG6VR8gdwfE4?=
 =?us-ascii?Q?JYZsocef9peotCVL/oJjs3Ou3eUftF0p3y9RoqU7sC1oOd2SNWerUHb1ZhXI?=
 =?us-ascii?Q?7dCqUkDee4/M5dTKpOv0sWpZtFNNb8EBGMxahYA+C9dtTd0wm4Hs10l9MYA0?=
 =?us-ascii?Q?iU+R7d+eL89znQfzvD5LjJanTA8GmOjj+LmvOq8m3Q0hAgXbOHRrt7ivFN0B?=
 =?us-ascii?Q?VEKeH2NdONu+oVbhR7zXKf0XKmTDt3cl/7GBppN9zBj05ru38O7L/lK50lz4?=
 =?us-ascii?Q?XgIKlOroHF60x6n5srWumWkH8aWg/JBQ8Rc3wdGV3SaWP+TjT+ExcFCc4xY7?=
 =?us-ascii?Q?t2R2dfC74nParc6QP5TDUgvUba84h7cBEP59jUMtcI4fi9pBjRbn7yDYql0J?=
 =?us-ascii?Q?04r42fEg8z6xcBvmPo3zq+LOZE1fItFy/5M821rDtGZ+SQdwPeAJ+42Usx1C?=
 =?us-ascii?Q?C4X9HHUL6R1cjnNC6X7+4R8lehczSx26enF6JPhl8ojYOOUBzhP6YaXUk6BV?=
 =?us-ascii?Q?kOR+wMMWIqvXwpSuSyhHnJs2nMm8qiLIKYOv1wAv5Pb7Z+ZfQwni/yfJq2qN?=
 =?us-ascii?Q?YHrttvbmpJeugFmjnMryPSFCVG8yU7XHrRQWCX3MsxXYHGKLa5xelkGt2rCR?=
 =?us-ascii?Q?rCJVqIzwDpAhC7dx2DJkqtYpqUj2k+nsLuakUJn+m1Y5CJcaYlaVjxCD9vzr?=
 =?us-ascii?Q?5A09O5oBViiMvjhiRN6184nUbVEOA6X46uADZVHGH4xahxeKmmkmhxfx87OB?=
 =?us-ascii?Q?6KrwEK7GDo5HIMqroec9ol9BGOuYzg39FSPihj3HCVq9LpPJeHHbTrPaHrE4?=
 =?us-ascii?Q?PXlzevpEHKNRtzL3b9Dvlo9gMVFRcbbo5fLah/MEpL/XfbcEpvSKhhZSRUCj?=
 =?us-ascii?Q?+uth2mHRdRc1Pal/tVPcwmC5Gh2jLjqwbn1ucJKrfdFiAX0FkJDCd7DzUymE?=
 =?us-ascii?Q?PSLOtnFgPKR/XtxKxiAjV2bNhj8/nA6XbMpGQ7OYtS3hB5ew0Ln9gXi3XCIK?=
 =?us-ascii?Q?2yIBtER73Gpht1NOgPWPkg+VK4T/i4YZSXHWBxyQ2jgLuyGslS7Y2GDgGGO7?=
 =?us-ascii?Q?fRYlGFpx7uf0jc1/yfc++J7NIfYZLRfABheU/Ag36BQTo+NVbfIDMLCqlFcX?=
 =?us-ascii?Q?rc4SpHilmIin/WyzTiZKqbzP5fOGER2bWFMuVcxvZ0SuVLSumX2T2EnxINBR?=
 =?us-ascii?Q?YHI7BTpCHg8+3zNe5nDsGiuXPZ57Zr4XLy+X8ZV+ixuKxVsmvwNip3Dq4Jjd?=
 =?us-ascii?Q?gdbCr73jUluvPUv75TR45Sh8qKKSn8VWbIXpNIsj6sUi/qOHzJDRnTevReKs?=
 =?us-ascii?Q?qPyGGQIfHwVA3aHfKrX78pCAnHmzsFZCKz+vyvz4IITWOpEr/hmGM75IqyLM?=
 =?us-ascii?Q?0TaNUFct+8vR9qebtbJAZaM9bXdN8D+PVJ9FS8xBZNcoPTOr/QmeBp4siNGv?=
 =?us-ascii?Q?geqW6CQm5g=3D=3D?=
X-OriginatorOrg: pmease.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8817608-3384-47d2-8dc8-08da1081d144
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB2966.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 06:11:37.5040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1cdecfba-7dde-4cf3-9831-7a4189f20315
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qjjot0vgsmis+dBKcayKhbzf6tCBzj9GVF9UQ0Mq+DfW5xcBuBc5ObDAiXlK8PogqxlojbkmRiS+9zvHHjjGvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR06MB2632
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It also converts \r\n to \n and remove all spaces in a blank line. This is =
reasonable for a readable commit message, but makes it impossible to verify=
 signature in my program...

> On Mar 28, 2022, at 1:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> PMEase <robin@pmease.com> writes:
>=20
> [jc: wrapped overly long lines]
>=20
>> I am using command "git show --format=3Draw <commit hash>" to get
>> raw commit object in order to verify the GPG signature in my
>> program to customize public key loading. However in the raw commit
>> object, extra line breaks before and after the commit message is
>> removed, which cause the signature verification failure as git
>> generates the signature without removing those line breaks.
>=20
> "git show --format=3Draw <commit object name>" will not give "raw
> commit object" to begin with.  It indents the message by four
> spaces.
>=20
> "git cat-file commit <commit object name>" is what you want, I
> think.

