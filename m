Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0760DC76196
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 15:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCYPj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 11:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCYPj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 11:39:27 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2109.outbound.protection.outlook.com [40.92.45.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053225279
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 08:39:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvoPYg50k6qZCT5zF4kX3wU4Yp1lZrT+qe65ckS98cELjCcbiu8/gNgXUk5W8TJQUJVemSy3Hb2Vi+bCnq7/ShHlzPFUtYn6MrMw4+9HDYyu2bdD3MkbEIFi78lx2EhVTbq3/WPZM4Zn/Q08f3XP28O5VOUwVKHAvcbCRB/Ruv1d2HXR/2JRPrdB7fsfu8fw5+oVArNWeTkc2L+C54mVbc+7zqyzvyz7oYwtn5UwQ7bpnWHEEOhSVatB7pmyhQNRPTx6UUjI9ZK//FLOWgdytVbtqahQy4jYS7hzKaECZlylYE5suqiVYzD+XabSooaWsUoYt/fmXAHl0hOJ9rnnsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fprMP1/Sv2cfNjnlWYt3vyDqEb/krdPEhe/Ib9b3so=;
 b=n4h3ztDg1YdRV3SnjV4wSWXrhhhCYv7vI9+lNrW1s8vAMLwt01TYwa4aCTPz8vMUEC6TPGcqMbKTifpoY6PP5J2UdvidFRUS4bWSan0tEsDLLpaGMGi6kZp5EIYcTfFTdX/BZo55hmHMzxLdj6nJbqQlrcF3Fc4C02Ag22GE6sp+ZOrr9S1M+hVNmioy6Ha32bjUpjBTU7P54vi7b+4JAgryWymtPVhwA/U5Ww9NySvCuWZT16jYz42KjSbQWFQ93ZYNEpeP9oUCuefE+RRJslEXZAAMy/DHhZ9DZFWSqm4Vm8p0YwfTFllvMqn9ESHi2xSFcMlSpMjzfJDPNCiDEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fprMP1/Sv2cfNjnlWYt3vyDqEb/krdPEhe/Ib9b3so=;
 b=M4jJjD5oPdfASttVEpTrLU+TB6uM9+8d9EJ4rlqLcxyELqt0eO6tAsjfZyalw2SQdJ8vir+r/eeeHmKoLCZEvqwS6e8flNWFjiIuxSwws5igSX6WEuO4rULIHJ9lhXGGmYXjhqI92IMlARTVqN61rbbTJXh3HvXbj3++OEkIpEwXRVndnJyyCuw+So+JCyKV1D5gMgqtBXpCR+ijBxacI3CNZ5zgGQ1bWH7+rxe0NXNRLCzb+08AXveyAJr5Ecm0R54fTqRyCYNzjBSbdvWQQl3D41Gigf9rfRLwhDjZCwQNGu0RtwOQlajnsXgxLeeJ18rMyg2xPeuFzW/h4rzSGg==
Received: from MW4PR20MB5517.namprd20.prod.outlook.com (2603:10b6:303:22e::15)
 by MW4PR20MB4545.namprd20.prod.outlook.com (2603:10b6:303:132::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.8; Sat, 25 Mar
 2023 15:39:23 +0000
Received: from MW4PR20MB5517.namprd20.prod.outlook.com
 ([fe80::ae9:1282:c6ba:d6d7]) by MW4PR20MB5517.namprd20.prod.outlook.com
 ([fe80::ae9:1282:c6ba:d6d7%8]) with mapi id 15.20.6222.010; Sat, 25 Mar 2023
 15:39:23 +0000
From:   Mario Grgic <mario_grgic@hotmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: git bug: Perl compatible regular expressions do not work as
 expected
Date:   Sat, 25 Mar 2023 11:39:20 -0400
References: <MW4PR20MB5517583CBEEF34B1E87CCF1290859@MW4PR20MB5517.namprd20.prod.outlook.com>
To:     git@vger.kernel.org
In-Reply-To: <MW4PR20MB5517583CBEEF34B1E87CCF1290859@MW4PR20MB5517.namprd20.prod.outlook.com>
Message-ID: <MW4PR20MB551779102E85B305E9F675E990859@MW4PR20MB5517.namprd20.prod.outlook.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-TMN:  [4qcylDh1p/a2zGyLzaqiavTDXNBgcs8f]
X-ClientProxiedBy: YQBPR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::34) To MW4PR20MB5517.namprd20.prod.outlook.com
 (2603:10b6:303:22e::15)
X-Microsoft-Original-Message-ID: <177DF82F-B7F9-43BF-8412-454F4DFD6666@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR20MB5517:EE_|MW4PR20MB4545:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f70a2d5-bce5-4a5b-38c0-08db2d471b68
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VA8TSBG7YcC0dOa0G7Zq+uX22XJwHm4zq1PT2H1ktviWnNki2bj1gKwlzPL9ILZyc87VBkEspKZcJ4u6whAORllRKCNt1Bii/mAwfsxG00hqGyG7tVzJ1q3dhQNoMsO8DV4yWjLo9KU9Od+fZFo833eovFmKtghQ7dMh24ggMtdujmNfIbKFtBhj+e7ksoUPr0lsIzTMuTKaZVnIGSP2eMOrSGfxuqy7ZzADUxq7LX+kpyBma1L8ZB3lBhbwn2xwoaXg82JcTsLfb5eQlsUpGHnDGyAPEfNZBcjryekm3zvCE0yzl1Z9e9pIFWzDXS4eziXTnavfe1jkeTajoUy6VdUJXYMMK9QyJoQUxeR+LY0IgQFfZlkXMrwRo0LZXOPv92S0mkLq47pcAES6HjBZ5AcuR7KyJUjrV5Dg7IENS3gImq88TnbR4cthe8wmSC8Bk26NFo5vnX+Hl30pXo0v6H5RjEPnxqQT421uYclpJbQJIOFnAhgFO5V4BX5ilfyHDe18jfhOmeLcTNF6nZsCHyWcEl07/81uchtqRPGXtpEyZvojOexgujEfqXba2rlICZF7DkSYELu/IbkeB7JTNe/JnhSo7R8YSXjVwnqz3sygS7HKjXYg8d/vceU8X1Y+
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUhCb0tVNjFJMzIrYm1UM0lzSU5hblZQbTg3TW1VanJIT2JYY1FKNDRTamJW?=
 =?utf-8?B?UTZLeGUvaDV0ckltN1VGc2Nla1UyVGV0MVpTZktQOUdRY21NRWQwdVorbUo4?=
 =?utf-8?B?SVJhSUd5dlJmOHZ6d2F2UWZJbi9oOGFTM1psRFdnNWpEdVA2cE9hOVdJVzdz?=
 =?utf-8?B?ZjJXOWFjU3ltTG10cUhYd2FYSUFkMzhtb0ZqMXIxMHYyajhxb1RFcEU0UUdi?=
 =?utf-8?B?enBmWmU3bkdhRFozYkV5SzdSaXBESXVGUVoySTJHZkRZOEJxUzlIMW4rUG13?=
 =?utf-8?B?NzM2TlFVVnZWYlRNeGRqOGh6bVYxcmlPa0RUUnZoQnFWaUtvNDkvaDBnYlZV?=
 =?utf-8?B?eGtZaEtrRENSU2ZMN2FFL0hoRUx3S1N0RGM0dXl1TU9NV25oYWZtSE0xTVpI?=
 =?utf-8?B?TXFuWmR3cDZhY0llREJjRnVnbmUxOUkxZHBSemdDZkJzM2VrTVFnYUN5S3FJ?=
 =?utf-8?B?d3BsTDVHTTM5SHlZeDdRY0pEb2VKbkpDNW5OdFJIRldHNHFxRTh3c1RKK1Vr?=
 =?utf-8?B?UkJCMmw0ZHlPVGgza0RtRkJjcGVEWm1vSlVlclhFUmJIcWplZmRtODR3NnpT?=
 =?utf-8?B?UHdkVjVtclFsRXJvTHgwZXVNd1UxWjhFRW9vOEJaajVNKzEvQnVNdWlxY2sy?=
 =?utf-8?B?M2I3aTNQT0VhRkdHenM5MUU1aFB6VWtMUEtzVEhUR1plcVhORTJDa04zWVVZ?=
 =?utf-8?B?aEVaTmJGSVZKRmxuTEZZNEJUMENWMWFHbFRRWFg0ZStFY3V5UVEzTmg3c2F4?=
 =?utf-8?B?bmRpMjBYTEpOdzZtaTBNVHlmZk9PeE9rM0JXdnhxam5TSllTYkRRTUwxNVVK?=
 =?utf-8?B?aFltUWV6M0ZtRTFrNzZRTEdSS0VXbnREOU10WVpIQmE5d1YrZlJtVXQ4eVFj?=
 =?utf-8?B?U2FSQ0Z5aTMvemZvUkhRekozd0x3cHJQV2VOQjBMZGd5bS9iVmVpaE5TOHEr?=
 =?utf-8?B?Q0lpTVA2TWFPWTVlSmFhZkhhQWNwQXp6Zk5qeGVNL2RLQ3lYMndmbldOMGZK?=
 =?utf-8?B?RlRWMkVXYlJWYkh2SmF1aTVVQWJJQlpnSzBRNEFjT0VicWRTUUJXN0pSc0tp?=
 =?utf-8?B?MDAraGFZT1VoMUEzZ2I5UHloai8vR3ppbkRrbk5pQUE2aVU3enU2VWQ4by9x?=
 =?utf-8?B?Tkc2SkQzd0p5dTVYQWJoQlNaVnkvcDJWRG5YNFY5UnJERHRPRWJ5Qzc5Q1VE?=
 =?utf-8?B?aldsK0YwWkVyY3lacTRTR01pMm1SbzYrcXJHWDh1eVd0ZCtibmt6QWRrWVJp?=
 =?utf-8?B?WlRnbUZFd004NnF4NDFXUEdWcngvVkpUS3RwMUk2VnBLVVdNNE5abFA0aEhK?=
 =?utf-8?B?TnBTN0JPVUM1S05nL2pxM0VCUmRuMnVKWUJ3WTBZQU9SNUVTa3AwUHIrMEN5?=
 =?utf-8?B?OGYxVWhGNDNsMHdGdklWSkVkWnVIaSt1QVFCcWtxazRaZTZXWEpuZml3NkN3?=
 =?utf-8?B?U0hmTVIzMGFWc21qRlF0SG45SjlzNFN5czdSKzFKZUkyNjFLQWJuR1J3RXJk?=
 =?utf-8?B?QmdpZEJER0lhNk91TStuYnY2blk2bmRBTDVRbWtOclJVS0h4MkxROCtzTDV2?=
 =?utf-8?B?UWhxNW90UDE4aGprSVgzY0NLVUszYTBrYllpeHRTbDVjcHJ4TTdnSDcxL0xp?=
 =?utf-8?Q?g+ed3ulOobzEkKfIN6KclJdxv9i19rB9B/MjyL0cnAVQ=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-9803a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f70a2d5-bce5-4a5b-38c0-08db2d471b68
X-MS-Exchange-CrossTenant-AuthSource: MW4PR20MB5517.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2023 15:39:23.1108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR20MB4545
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Confirming that putting back NO_REGEX =3D YesPlease in the Makefile fixes t=
he problem. I.e. the following patch fixes it for me:

--- Makefile	2023-03-25 11:24:01.000000000 -0400
+++ Makefile.patched	2023-03-25 11:25:11.000000000 -0400
@@ -1554,6 +1554,7 @@
 		APPLE_COMMON_CRYPTO =3D YesPlease
 		COMPAT_CFLAGS +=3D -DAPPLE_COMMON_CRYPTO
 	endif
+	NO_REGEX =3D YesPlease
 	PTHREAD_LIBS =3D
 endif
=20


Perhaps the real problem is that the build system should not use macOS nati=
ve regex library is its configured to use =E2=80=94pcre2 library.



