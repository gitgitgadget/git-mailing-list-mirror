Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D811BC6FD1D
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 17:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjC0RWh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 13:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjC0RWg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 13:22:36 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2077.outbound.protection.outlook.com [40.92.22.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0874235A9
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 10:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itvsonSJ++Bm5d2ooRl/ryodWkVubQ8VQLJhW+FGZU/xvMg6BEs7wL1DAm6wlGiyG7VEp0/ia/EA39CPguLkn9ZyasLKbYclMSzXkTe85mSQYNS1DY5afvhIFj3QWhV/MF6PkknnhwfvEW4RvFGwEXFZRKsDjhtXcnMtFLARA5b4/HyXyUgaU4rb3xXeCrqC7q6XFwwgi5TlLdSaySUwZxyAM9RyoPjLoQLE0uYws2XsPVXQ5xb7eRVUgu64tr3FruWP7t2n3fJyUCqOmhcWCqe+pNwnA7YUhsg9KHqpEgP3Wh88+LxIE8XiqrMvgXmBIOm1cUSlD9oy5oyQ+b9o8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqPN2BzGufBpK+wDbJPmWBdzXbP0ByUtde1PMB4r7mY=;
 b=EdykFIlpVUPQpuKIP6UP+Xdt37E3F/SOqfdbTHjASQTLDvUo5aB2JxjE+wKRCCJIZibREoBm9EmfeKFeC2C+6YgvZO0Pq6M47lndpVVcrKGqi6+veZEpPRaVYWawf8h4X70SOzPYiIaHPbQUtvUjIm3QiSAdCIA6wzvFbTMNZZciEHPmCk160nsbBY+QR/t9bHVH4rvdQ953z9cDJRJLK9uP8epSg0JrjlecsCT8y3+MubHgc8abvOQmsk8/kErGI9qC0dcfGI01tk8WNropAWOljGJcjlojnc5hG9IXndPgGPk7u/qfCaabUt0r49cSLu/uTGlKBYHH+XluLvu0Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqPN2BzGufBpK+wDbJPmWBdzXbP0ByUtde1PMB4r7mY=;
 b=XxsGFMEzZkfX4Aq0hqMyt4+PgtRt/hNO9fWB9AoPEv++PS884rTHWXiA7JogozjTW0DrOzRDJRxcmCCEEOzCws4M1+lEOmjNfVo45gd4MP32dvekmphaA3Q2dgTy2daUwz+LgpBYztLvz04mmThDysstXtNKD7JO/ep2WK7g3VsYA/6NBPkjsFIhHjKbbg3aYBIH49z5hRJqJq8T3kZoFpC7IZEWL6bDSFSfmA4r30a7U5lTO9jPaobNrUVLWbqXOvDpVO0jK8f7HovYXNp2FGnFC9vm3FqXIHkZA/2xf/2rOIPKCDItxW6BGw/NdeM5oeRnDvgIF/nSmwirf+6IwQ==
Received: from MW4PR20MB5517.namprd20.prod.outlook.com (2603:10b6:303:22e::15)
 by CY8PR20MB6278.namprd20.prod.outlook.com (2603:10b6:930:7a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.17; Mon, 27 Mar
 2023 17:22:33 +0000
Received: from MW4PR20MB5517.namprd20.prod.outlook.com
 ([fe80::75f6:4d32:4ddf:6c6]) by MW4PR20MB5517.namprd20.prod.outlook.com
 ([fe80::75f6:4d32:4ddf:6c6%5]) with mapi id 15.20.6254.017; Mon, 27 Mar 2023
 17:22:33 +0000
Content-Type: text/plain;
        charset=utf-8
Subject: Re: git bug: Perl compatible regular expressions do not work as
 expected
From:   Mario Grgic <mario_grgic@hotmail.com>
In-Reply-To: <xmqqcz4ucg1w.fsf@gitster.g>
Date:   Mon, 27 Mar 2023 13:22:29 -0400
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-ID: <MW4PR20MB5517E2591A77978709695AC3908B9@MW4PR20MB5517.namprd20.prod.outlook.com>
References: <MW4PR20MB5517583CBEEF34B1E87CCF1290859@MW4PR20MB5517.namprd20.prod.outlook.com>
 <MW4PR20MB551779102E85B305E9F675E990859@MW4PR20MB5517.namprd20.prod.outlook.com>
 <xmqqcz4ucg1w.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-TMN:  [t0SKWzhp/9XjSwLXAhU031cpt6W71Rv8]
X-ClientProxiedBy: YQZPR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::19) To MW4PR20MB5517.namprd20.prod.outlook.com
 (2603:10b6:303:22e::15)
X-Microsoft-Original-Message-ID: <8B19BE1A-BC09-4B69-B35D-D4E94D7027CB@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR20MB5517:EE_|CY8PR20MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: d33977f9-9fc6-46bc-6b2d-08db2ee7d9e6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nncIz6IjBMRfUXStWUfjzAJLzaTrWzgwLREOK0HGSwdoLChbTk5uT1pX/8Jy7kHFB/mJCEk4N1HuZ7ptkDMVLY8ng2bK82Hk8hbd9/Ucy1i3Vq6GzczB14BCdX2EAeoo7vn4KKRJAdUvSX0ts9AROsXhnr1h07g+gD1ee/qQhiPO8V0gb0XX6wxRkB60m3Qd9jXMCWdTs/oROo5Ljwe7CUky5LKnGfDaS18BN1Bf/kdsgHh4AtBnQrZ1ja73mu/6jNPQZmt4XeGMLQP6N4YM/MI6apGwH+FvXLhsq87Idh/AxFwaRH9LhHRK6TgQecEUI1l0/cCta9l1qMz6nv3Y9Iwrp3SLUY0I3YEPry1Q5e4RIeYf114uT2f5L+0JU0+DwKdG7lIsbxUCK9tpLiim9yTdkq6cKjncrcdvE0EZI6sbTG1PKgIHVYhyPunofWtHUgU6IDL2ZQhNcYYJg3F6qd5RjGorfNmicJ8w5dQTJRhDmGDybu8HkW1nmbG1jyoi4c0/VXq/UDuCpUH7pO6/dD5Vs1FjwS6Xns2YTR4oHgC9iqN4q8OUj2w4DUYwu+gUMyTrWgY/poNqBNNmgFmZMBuJkVVK+liFcY+mb+SENss=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjBCSm5BUFhIb2NxbWExOVhNRzAzT3RNMkVCQXB2ZFdCcEl0TC93QncwRTlv?=
 =?utf-8?B?d0Q0RjRFMFQxcGNtWFVMLzhPRUpIZGtaZzZjWmIvbXIyRlJpQSs4SWthdHNr?=
 =?utf-8?B?N21IR2RvSHpSVHE3SzdNZUc4MG11eEFkMlcvN0lXZkZrakdMYmZRdU5nTzdt?=
 =?utf-8?B?dWR1djZza3I0YU1zUkp5UzRvRXNFNytGZU1oY1BhNnZoeHRDaDZMTW42a0ZD?=
 =?utf-8?B?bFRWWGpBM0FXYnBjb0owZ3ZUTHNrbEdPNUdYN0VsTWdHTVAvYWlhU2xTYWRj?=
 =?utf-8?B?S2Z0RE5vTzRDZmxocUc4TWNETHd3TG51clByZHJiWFVQdnRGalVmMmZRU3l0?=
 =?utf-8?B?UFk0VnQrOUxCOE9TSm9wUzlOU3Q0MWlwNVZXUDdCN05BRWtOdm9Fa3ZCeUVr?=
 =?utf-8?B?aGUvc3g4dFJzeVEvK0VPV0t4TmRUQTlmdldyd00vMGRLQTE1N25rYm8yS2p4?=
 =?utf-8?B?bVpzVWpuMDNGVTFKaFN2ZmFrL0lWYUFMby81cWtEaHZLeFlCMzVTTUFaelRQ?=
 =?utf-8?B?OFRuWHJid3V1OG9peXltMzJnWlhod0wyaFdsWU03RElOWkVnTjB1Tjd1cDZG?=
 =?utf-8?B?clBWUzdXemJzcXVtZ2VhVTFWVzV2VXVCenZhSnU0eGZ0R21Sb3hJb1o2cmVH?=
 =?utf-8?B?bXVqSEh5N0xobXFkeHFrOWIzTnJLeFpLYkVJb1F5UGtlY0t0ZStzMnFjVG1R?=
 =?utf-8?B?OUJZdEcyOTAxV2EwVmhIZWVPcWlYOTIrZ2hiUmtoWmNvZ0JVY2FHeWFJb09r?=
 =?utf-8?B?M3lOcnBURUdZNWJqcHdwcW00MDYrK3RseDEyc25GVVR5UFh3eUVWSHdkYjZV?=
 =?utf-8?B?Um5ReTNUUkFwK29jZk1MWDRLQVJianhmbTdiaE84N1M3UmdvYWY2TWhIV3F1?=
 =?utf-8?B?dGVnVTdpNFdmN0dTd0xBMzVGTmwvamZ6UURqRzl2ZVdFbmNBZ3N5aUUvZity?=
 =?utf-8?B?MXF0Nys3T3VKNVh1MDBIaXJjRDJsb3dNVGppRmd0SlgvUDZ5VEFjaG5HZVJ1?=
 =?utf-8?B?WG1QRzYvM0FvUE9xL3o0Y3ZyVmNmbGFwZXl1S29qdFBDcjhBRTFrQnhJUTFC?=
 =?utf-8?B?S203T3VKeTFHdkZwVTRTUnI3MVc4NkptZ0NEaFlTa01CWkxJMnJRZ1Vpa0NR?=
 =?utf-8?B?WkdpUmpCMnpEbExDTGFMc2Nqb3UvL2d4TEVPa0s4LzlLbXcxeG9mL2dRYVFn?=
 =?utf-8?B?K0ZaNVhVeDVBWnp1cnVFYWUxanJobzVnQ3BtRDluSGhIT1hYcjA4Q1E0VUE0?=
 =?utf-8?B?SHptOWo4NTBSWFpkNzVlbE1qWkJiMEVtazBvWldna3JvUm5aOWlVaElkbTdy?=
 =?utf-8?B?V2JaajZFYWN2OTk0ZVhXZUc5d1phOXhONjBWMk5aRW8zYTlOS2w3NXZRNnJh?=
 =?utf-8?B?SllmQU9tNE51RGQ2Z255N1JxTENHV0dMd1lvYnFHcGVObDRoUzV1eFhwWi9p?=
 =?utf-8?B?QTZQbXpmYVZGNmxRTjdZbjhzVTRiT1F1SjJWdXFyYWJ1NGJHNzMvOTgwQmRi?=
 =?utf-8?B?S3pvdmxqaVJKSFFtcG4zWGI5eFhtZDZXSEZiMTdkSS9SU0dhemNpOEJiU3Jh?=
 =?utf-8?B?bEtYYnRYbXlhNmFScmlWMisrbWw1OTduVjNWQ3FJcTgwZ0pvMkxvOG5YWFdR?=
 =?utf-8?Q?AZTH60DGmLpxgfGWLl88y/eZ/ZJ5Bilw0g4/ne8YAPW8=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-9803a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d33977f9-9fc6-46bc-6b2d-08db2ee7d9e6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR20MB5517.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 17:22:33.4317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR20MB6278
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In my case, I compiled git with pcre2 support, using third party PCRE2 libr=
ary: https://github.com/PCRE2Project/pcre2
 and PCRE and multibyte support in git works with it just fine.

E.g. adding and committing a file:


```
#!/usr/bin/env node

console.log('=E9=A1=94=F0=9F=8F=81');
```

and searching it with

git log --all -p  -G '=E9=A1=94=F0=9F=8F=81=E2=80=99

works.=20

Again, perhaps the solution here is to distinguish two cases:

1. git is compiled with native regex library on macOS=20
2. git is compiled with third party regex library with PCRE and multibyte s=
upport on macOS

in case 2 everything works.=20

Case 1 is perhaps more work on macOS and a feature request.



> On Mar 27, 2023, at 12:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Mario Grgic <mario_grgic@hotmail.com> writes:
>=20
>> Confirming that putting back NO_REGEX =3D YesPlease in the Makefile fixe=
s the problem. I.e. the following patch fixes it for me:
>>=20
>> --- Makefile	2023-03-25 11:24:01.000000000 -0400
>> +++ Makefile.patched	2023-03-25 11:25:11.000000000 -0400
>> @@ -1554,6 +1554,7 @@
>> 		APPLE_COMMON_CRYPTO =3D YesPlease
>> 		COMPAT_CFLAGS +=3D -DAPPLE_COMMON_CRYPTO
>> 	endif
>> +	NO_REGEX =3D YesPlease
>> 	PTHREAD_LIBS =3D
>> endif
>=20
> It will unfortunately break multibyte support on macOS by reverting
> what 1819ad32 (grep: fix multibyte regex handling under macOS,
> 2022-08-26) did.

