Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88028EB64DD
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 08:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjFWIXb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 04:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjFWIXa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 04:23:30 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2082f.outbound.protection.outlook.com [IPv6:2a01:111:f403:700c::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123332123;
        Fri, 23 Jun 2023 01:23:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ID/9WDNwgvV1fFaNZXtUwLtCG954okV0R10O1pnyak55K0a0IYAmM9B27gn3NpzLCDCWkt2VLHWO6N/NWaBHSdHrTMWXwAgXHzRRoorPLDClntWGQhAKJSchhHPdWAzPvxeEmsCW9JxqlBNCO25fbRMJ2niulZg7PlY4lQ4I9+wgcDSFw3e4JBCP8mFuzlj7zLIfqgwwqG/VVKzB8slw+JQV0FgRnSXU/eP6Uq6Bd8MtG4EDVQsv+O4vlHb8MHqo+4BMwc8sFI5l4vh3Og27CImFLtXLtlZqlmYf87NPuYe8xpMpOv05I4X7olXc9a+V6cf5P8oRUcnBG0yyOvF3Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcwmurSDMFBi7TeAPyHhyj6B7ebMW3r6jAir8bGvvLY=;
 b=g8Zjmllp2Jf+ectTL5238f8CTiRrmP8F03hAsGqiE1RrdDFm4cuXNfmZBS/igolQ/oPoJ42CWg2/WI1SMF28PaAdmAifoT6zy+CxHJ2CzL1t2K6V9cXe1yELxs7/XnoUV8HYWwtGisl1nuiAfLz3U7Az7SwE5Jt5um8I47LINywcNuYxKJd4NzqXE89Uh9xEGYVpPVLxcPPHZNCLY/UgINNxHKbzAekcBR/tN+xrazTfAkorHiq/H0GV+XZeMtm10Ot/BwrCva7sMHaqvdB+Ar7p0IWxkzdmcYjpBsuee9OLA3CA3rrn7DE/NQEjvN1LsSLaVW/QSbKh7/NLkwK9Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcwmurSDMFBi7TeAPyHhyj6B7ebMW3r6jAir8bGvvLY=;
 b=PPBBUec6T5sR+fMQROlRfavLKS+MzPvx85uyw17EU4YTXgmXhWsiXJ0EDqW3Cl+bzkWTj7JIGtbzGyGSZGhubcZqJdCezg8G2Ni7am6zxTcpsV7/0W1u2VFIs8ciRyOQU1wT/MztnGrXQPs0IcPu7Zo5uJreJGTMjoRQJWuYpZYVRM+h/s3R4t1W/E5oA3nW+064hkM/00AzPZxR8nYTxzSf8gpfvK1TfjlGZ/7QJto/gdBd8G9wBJj+6p/i8zpbt/BEibqSHUJ/pWXxuMEHOTheTG3vy3pYVbx/aI0vPYjgYVEbFqa4p+KA0KjwrUSAxVA/ohqnSW5wj6HeWZGNwQ==
Received: from OSZP286MB1968.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:181::10)
 by TYCP286MB1969.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:138::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 08:23:22 +0000
Received: from OSZP286MB1968.JPNP286.PROD.OUTLOOK.COM
 ([fe80::34cf:4115:d2b6:7377]) by OSZP286MB1968.JPNP286.PROD.OUTLOOK.COM
 ([fe80::34cf:4115:d2b6:7377%3]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 08:23:22 +0000
Message-ID: <OSZP286MB1968CC1BD59489496919D16B8F23A@OSZP286MB1968.JPNP286.PROD.OUTLOOK.COM>
Subject: Feature: Use $HOME instead of /home/username in ~/.gitconfig
From:   Jovial Joe Jayarson <jovial7joe@hotmail.com>
To:     git@vger.kernel.org
Cc:     majordomo@vger.kernel.org
Date:   Fri, 23 Jun 2023 13:52:39 +0530
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (by Flathub.org) 
X-TMN:  [8pbTANAnCjnsLxePSdT96IvZYqNIwE8SuoFEn1J/EsI=]
X-ClientProxiedBy: MA0PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::16) To OSZP286MB1968.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:181::10)
X-Microsoft-Original-Message-ID: <ad3c957092618186e97cb262ee1349042e1310fe.camel@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1968:EE_|TYCP286MB1969:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e489835-6f7f-4c23-526a-08db73c31b77
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DTqRefZ6djL3UpqF2Peer5Th4QaJGzSAlj+Y6kSGtdGNraMaYA0ukkIMsDGfmySjeRlV9et5s0yicDkcwZiUgZ2z8qq52pDmGM1B2KjKF7y2SFOBifOub/pbpCdqaEz6dz7XsLzuM+xLV5L20ZAqqAGZehN83rphffaa9VDzCWu3CmQ9R95DDhauA1y/l6XqSY0KFvtO734wQx7m8IKnwDDUzzhffaT6botqv+3UEFQQ0rEsX16v4+kJznwRKyPSoBF52oa+PMHzuDTp1er5WGntCrgQ1vrGChLVr1nB6lMnZe7PyUsYG+RpVk6h8ZNXfpDhnagaP2SCbQYlRgF4OcRjcGwQ0EJkb3io81r+fajQjJGM7yvpgxstv/oD7Dyv0ZRQ7LaKPnkMreKyizxJBtRLBZ9RjsDLce4dkZ2ube+C/O43jX+Nebv+DV080d6/MCU0NuQ+XKQR9sb12I+TLwnBjIwzp6wfuEtx1gEtzySLvKTB5MMFGDMA0BkMgKFO82RBNHzOk3J1xQMK3+tJRmC+GyHHb2lAMaGB3TYuD411SAc+edhnYJ7Xm1hXYmP4
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE5pdklDSUtHOUNXUDQycjA1cnlISlQ0VFRRVUp0ZGVDclNWQ0pUSXdzU2c2?=
 =?utf-8?B?SVRlb3IvWDZHNzc3Rkd1dEYwb3hpU1FjTyt5LzlBb1FpMHZZWDcwOHBVVWQw?=
 =?utf-8?B?SnBhUHo1MzJBaTIzWjJZTmRUV1lCZEZEaEdlUEpLMVIvWDFyOHA1SWwrNjgw?=
 =?utf-8?B?aXdnaGh6SEVkSlFHOEEzbk0zVTlCelY4V2UxQ205MVJhbVVqdzcwM2RDdktv?=
 =?utf-8?B?bXQyUkl6T1ZvWS9NcGRlWUoyVGs0eU5VMUFac3M3VzM5b215bERjNytEdkVN?=
 =?utf-8?B?cWc3L1NPWHZ2d1g0eXZXeXJDdTdHUTNsWjBBQ1NqSGNERXROVTRMYkZnODhk?=
 =?utf-8?B?YVpFTk5wOTFzcExXWnlwUEJSYUVoUDZQdEs5NStka3Q0Sy8vbmdhcTBpNit3?=
 =?utf-8?B?bW5hRzNPaERxZFB6WnhoTWhsNlpqSFV1cmhDM1JveUNKTTBlVHZYL1lXZjZq?=
 =?utf-8?B?MGRhNEdNUzdzTzdxemZvNGd2eG1nbi9qeFV3Y3pTakVRMDNkcmlYT0Z1MHRB?=
 =?utf-8?B?d3lsa1Y0eXNkbmxBclJzdXMxRnN5UUZ0UlpDcU5XVjZHVHI2RUdBZGljaWkr?=
 =?utf-8?B?TWQ1MWRWNGN0UjRWdzdNempuckJzY1lwWHNKaDhIc2cyZDVYMmJ1VEdzU1gx?=
 =?utf-8?B?OTNvWkpHWTVTUWFkSm9sZ1BVTVpHMUxFb290RTlwd2t4ejlFL1FrckRqWFZC?=
 =?utf-8?B?VXVhZU9hb2ptbWFEQTVTcVdyTTBERlE1cmhKSFptSHRZMng4cWdNdjZNYzhx?=
 =?utf-8?B?clExbFZuR2VhTXYzSDI5MmQwdlduK1RkRXlZcmNGalhORTZIMWNMdHRjamp5?=
 =?utf-8?B?enF1a2EwN0hqRXByNzAyVVNnMkZnOUlURW9UQmhpS2N5ZW9aQnlIeHpyOUY5?=
 =?utf-8?B?d1F6TWxYZmNJSjBGbnczM2lPQ0o3R1BPb01UR3N1MXo2YzRqZ0VjQTZKMmNH?=
 =?utf-8?B?L2pmR3FaVGlFRDJOTng3ZUwvT2tuZGgzMHM3OVZmK1RocVk1Mis0TXVzaVMv?=
 =?utf-8?B?QW9JUVZYYjkvVnJZYW03c0RlY2Z0TlArQUZ3YXVRTVhpUTZBTjRMTjhXS1F2?=
 =?utf-8?B?ci80UVExU3RwZWlsRmNRU1pXOGMrTzlMaVJpR2FSOWxhQ1ZiUFR3OFE5emlV?=
 =?utf-8?B?aXlQYmJNNC9TMWlST3RLQzhwTVdYbm41MjRwTm9CTExka0xNVmdVN1JFUExU?=
 =?utf-8?B?b3J3QXI4R1pWM0x6aENTd2h5T3hScXlNUFFRMGV1WU0zZlhyNDFKZ2ZKRjJJ?=
 =?utf-8?B?c0Z0ajFlZkxFR2x6cndPc1NkVG43NnVzbVpTK2hYckRaN3RTcGQyQUdEWlpB?=
 =?utf-8?B?RUxudVUvVUsxVlU2K2NvWXhUODZScEl1MCsvYmVIOG44WUdFdHhVY3pId2p0?=
 =?utf-8?B?NFAxblpOREFBa3RkM01iWjVaeFNIZGZhT2x5R0JUb2JKMUJTMXY3ckNNRlAw?=
 =?utf-8?B?MmZHV0R1UVUySFdlUHBhWDFka3c0NDJNN1d4Y2VXdXp4M3BLbERpa1pwb085?=
 =?utf-8?B?dXlIeVNVUmtkbVdYVDcxd1ZEWHp5WkU5Yis2Nk1XQWlhTm9MZHNrRUVHVWZy?=
 =?utf-8?B?WmtVLzlaWUFsUTJRSDRITTBzTksyL25PaFBoZ0V3bm9KaDBOazVGUWM2MHNq?=
 =?utf-8?Q?TBzpxJyZmD8PD8bNyU3OqU7MLXP/iq/uK1p/rwhU5ms4=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e489835-6f7f-4c23-526a-08db73c31b77
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1968.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 08:23:22.4046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1969
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Currently the `[maintenance]` section of `~/.gitconfig` has something
like:

```ini
[maintenance]
    repo =3D /home/username/.znap/repos/asdf
```

I'm sharing my `.dotfiles` across systems, so I'd prefer
`/home/username` be replaced with `$HOME` or even with `~/`.

```ini
[maintenance]
    repo =3D $HOME/.znap/repos/asdf
```

I'd be happy to make a patch, if somebody let me know where, in this
huge repository: https://github.com/git/git

Thanks,
Joe
