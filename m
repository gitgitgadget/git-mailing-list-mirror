Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DD7C433EF
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 12:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381203AbiFQMAZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 08:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbiFQMAY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 08:00:24 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80080.outbound.protection.outlook.com [40.107.8.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E221268983
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 05:00:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmc41eKDYjYzl7hcfrjigJaWtOtOIR1r5uAh06y0HHH0dfifbq+WyLjMp6rJkx5vGT+fmP4jS5erxyUtQmaHZ2vznnEnbum103dAwyDk95k1RxOjXi3vyl8SIwdSt0v9+ZqWHyav2DhOWFGUH5GOJMT+rjD9QcN/C3ZsFzRBxKQXf+0O1oo8ir1uKBdQjv+LouezbMvctN3zfFUc/Y5JAoitJ+ucSLWf1mh7/xAne5wxdfp35FPtjugL4yUSGa12h1hBqe4dliwSY8Ik/gAZszewPasMK/T4XTjQS13Qa2FvL2OcqfteApPGPhQL5oRyIn4ZZeGDpLXdhlpjm6a90A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGy4755wxCA9nzScYO+RhyGPL8lOtJm8I5sOoJkSsUU=;
 b=jwzHwL47c6rwbfWgd5htF/0tp1EmMSlNDYO0Z/BeKc3ZXm6RZv1iNXJSA+M3SZnsf0eXn8bIeMCMgWZz1q7CaVTnUzhEIwLmb6lf6Os8F5Mrdbk56Ssrcb+TW2PrdT90QXjnxKE7FfttK5PR0ccSDT7NSjqfnrtk7a1MUqOvIgNGlIn1yVlpvwbQmCF8AH4kCNFabhTbkoXMwVb3xPpQuASXkGT4XCHUc1obkww4bmGnczjKL7wCitqPFQLiXlGo3+/glac43iiJz8JwTMDIPNWMH6gBD7Lf86Zb1ZNfc7FsN/EgSvZ+/2TxWVy/+HXZFTrf5iUwXMOpLskW4RQQ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGy4755wxCA9nzScYO+RhyGPL8lOtJm8I5sOoJkSsUU=;
 b=C9oARTk5QFvx4jxjni9NngqEqMsDtYKcQ/4XTMoPh6+InrjOZfXmRiyFR/vXPSwXd/2qjs8jtPo25aEmB47HKWQUC/Dvc6O9nb+b6uTxRU6nNwbDuUT6q2ezwKGv+hSqaxoenOVULNxnrTvp4GZvOIB5BDfH1PBVuErwBgRxSCs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:259::19)
 by VI1PR10MB2687.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Fri, 17 Jun
 2022 12:00:18 +0000
Received: from DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cab:bb41:3f19:896f]) by DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cab:bb41:3f19:896f%6]) with mapi id 15.20.5332.022; Fri, 17 Jun 2022
 12:00:18 +0000
Date:   Fri, 17 Jun 2022 14:00:16 +0200
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: send PGP signed commits/patches with git-send-email(1)
Message-ID: <20220617120016.txjksectzdugqiod@fs>
References: <81caab7d-777e-13fe-89ea-820b7b2f0314@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <81caab7d-777e-13fe-89ea-820b7b2f0314@gmail.com>
X-ClientProxiedBy: AS8PR04CA0136.eurprd04.prod.outlook.com
 (2603:10a6:20b:127::21) To DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:259::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46f0743b-1454-4563-00d7-08da5058f233
X-MS-TrafficTypeDiagnostic: VI1PR10MB2687:EE_
X-Microsoft-Antispam-PRVS: <VI1PR10MB2687C76152CA15A999CF7D1AB6AF9@VI1PR10MB2687.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1n+FGj3UkE9x1koTcI6uYQZ8+mhU5rcrH2nYUBk66/kU2cE0HuXm+gl2bY4KyDdQILWHEI76aFwFR7kg9kogOfuviFJkH6khzAM0ybOXOcsxqkL/mcyBWcPi9OJY5copQ3tyFzNF1gWtqYBQ4CzrPCdn4M7UW+eBYcD8aHNsCIJJn/D9FkCKUjDCZyzo8BqCJLHZfWnNcsVUDORfNljyHqvIm0JdKKKQVvTm2P3wBNVnMsNuM00q/gg+PtQ+wFaAp0arDkFiNXiCEAYpj4m7e/IaSFb1BmbCsGQn4XYWkS/36a/5AoMWss0nvIO7VafrTvlZVYAA5tkV/UM0Nuw4oMFIFnhGCX353dlLxfBk4+sVIShO2GCoqW8TVJieYUtBJ37y0RA2jNgtOen8BY/K7fFZqG0ttJNcWP0p/Hd9SZeEJtl2UNRU/Gqu3Q2vGr0mpeM+O9e+bQ3yW+vDuuKlXv5LQpLVLVzNn5BM2p5qI4oa6VBQESJTxLGSe8ttDtwvuO+ht8GWtnzs9M1kx9bNxNHE2D5KKdIXYPQxV+/G/U1qJxA71YTjDltMoQCvt8Fxed4r4i9pjbGQ4LOaVMEoGbvrm84nsJIY5XDzLIzMXoBDIgdL2kKNhDWl+OlkWgkpUQE3qZlCSwZEKq0XBwLEnTGPWX1FD7svK0lrTVIMCMKllb+35AC62R0ml1/+XBXHlvzI9uZZK/oqfH8xwed3Z/Ru0ynZtAULxkOcPCZwFWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(346002)(366004)(396003)(39830400003)(136003)(508600001)(1076003)(41300700001)(26005)(186003)(66476007)(38100700002)(6916009)(4326008)(8676002)(66556008)(83380400001)(8936002)(316002)(86362001)(66946007)(53546011)(5660300002)(6506007)(6512007)(6486002)(54906003)(2906002)(3716004)(33716001)(966005)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU9ZZWw4UjV0eU1WdXM1SS96cWFtN0dSYno0bW8yWUpWY0FxY1Y4Z0ZxY2wy?=
 =?utf-8?B?ZDdiNXgwODVNbDIxVzZQUUtBVlB6dURaMjllV2VQcW4rUXV1TGlyVHdqdUpS?=
 =?utf-8?B?UDNieEtNckhWeXFMUnNtcUdoS1U2ZVY5eDYybUVkZ2ltd1pMbzBwaHQxOWpN?=
 =?utf-8?B?TUhmcjIrYzFkYmFidFFSeGJmTW1iekhoNkZMQThPTFczS2g0QnRGb2x5U2w4?=
 =?utf-8?B?N1V3QUZiZ1Vaa0Ywc2I0cmUxajNXNDFiNmRpR3lBRzZYcTNxZmxFcjk1Y21o?=
 =?utf-8?B?ejY5VlNUZzRNM212WldUZ2IyQWEydVg5WHJ2NktoT3BTRkN5UjNYdzRsTkVs?=
 =?utf-8?B?L0xjNTFIRkNjVFZuZDF2UVJ1Z0tQdkpXbG1vMFlzVHNSc2puTTY2KzVFME52?=
 =?utf-8?B?Mmo4eXV6ckNsNmlRdmdWZ0g4ZE5wTlZxMU9Bc1V4ZnV5d2plQisvTHUxcm5X?=
 =?utf-8?B?MVJnR09hdlljWkdPczJUT3lhR25taXc2WExaeXF2SzB0dEhBWXEzcTlWODFE?=
 =?utf-8?B?Z0FCVlBIcXJ6MVh2MDZWUWZ3Y2RORUtSbUc2RE9LTDFjUkVqOFI1K0tGQ2lB?=
 =?utf-8?B?UlJqWmxhZEtZQmlab0luc0VEU3gzT29MaGl6ZWF1SThyS2pBWWVZeFRuUE1L?=
 =?utf-8?B?alR2WW9CT0VpMEtHOXpzU1psU05UU2M1ZFdsM0dqbTVpT2hNSi9Ocyttamxo?=
 =?utf-8?B?ckY5em54U2RSRGJ5eHNoWElJVldwTnBBK1F5MmUwdHo5NVpZcnBkS1czK0k1?=
 =?utf-8?B?VFlhZzJCY1NsTVAybjg1SXVDWjZpalRJUlUrdWZ3cmh4VDdWRSt1K2ZLK1Va?=
 =?utf-8?B?UnFMQkE5bFJhaWtzNm5USVZLYlhBWnN5UVZTaVRsOVM4UXpVTUtmODVQSEYv?=
 =?utf-8?B?ZjR5ZHBSNFYyL0VuemlySkI0KzRGZUFESEhpb1JxWGdmdWgyTzRtSGh3cG5k?=
 =?utf-8?B?b0NuL2lvdjBuNHpRbDQxRlVCS3JCenJUSUVJSXRReGFJeVJZZGluMTJkV2ls?=
 =?utf-8?B?dHRxSHZTZ21vb1RpM3hVb3FVYnpBR2JIRENmcXpmakF1eHFXWWtXNCtkQmNN?=
 =?utf-8?B?N3VRTSticUNBaURpK2ZnZVE5UnZ4aWx6K2ZQajhMMzJwVG8wRWtYb2ZjQlJq?=
 =?utf-8?B?ajhaV3J6OG1NRGJjZEdnTnllN1hib29sUlgrc2xTSmJBRmhaTnRDK0FocVNN?=
 =?utf-8?B?MjhwUWNVL3FmbFptazNWbFhTOU5GVWZNVkhJU3lmZERRNE5hWXMxSTd6ck9M?=
 =?utf-8?B?Ui9jWmQ5N0JlV1JVOS9KUHBhOUlHdDBUbWtiVjhWVXdXR01PcUlQVXY5U1M3?=
 =?utf-8?B?U0dCYm1iOFhnck1YV3EwNEhHQWVUSjlKVnp6N0xablNRU1BTaU1ZMWhXaXQ3?=
 =?utf-8?B?ZUt3QklnSjZudFdrb2hqanlPMlByQytnOXVaMk5WdGgrSzk1Sk5Xa0I0M1NY?=
 =?utf-8?B?ZjEzSlhxYTNwYWhoVmczU25lOWVQZnZqaGdUVG9KdEdjQVVTSWh4MkZmMitZ?=
 =?utf-8?B?RjEwd20reWowUzNJZ29RcUtvc0l4dXk4cGxoOFRFampadGtINFZuSzVmOHFL?=
 =?utf-8?B?S1R2b3VoWGxZVUt3V2h0aUJoNFYyZlQ2bk1KUkJOWGZIRmZvTnIyVFp1WTRt?=
 =?utf-8?B?cjFCZkRWVCtxZ0dFbTgwdG42bXl0N1JmU0VhNklYYklMRXpmakRLckRVMnlk?=
 =?utf-8?B?UEgzUm1qSnJsTGJhdlZ4L29QN2h3Z0FwTXRhSXRCZjRvR0lGdCtlbHg2a0kz?=
 =?utf-8?B?NkloNGl0Ry9jZ0lKRnFuUStsOUxCYWxLY1RXcHNIK1VVVGpiMmdoNmxoM2o2?=
 =?utf-8?B?dmVPVFpyeEl6aDRtSGdtMnZqSTVYeGtTUHNGeGJ2YnpaNkxEQ0NWU0NteUk2?=
 =?utf-8?B?L1p3Vk5ZRXErNUV4RmFQQnBsTSt5dG44UFBySXBkMXF1d1l0TTI2UFBmYm5o?=
 =?utf-8?B?TzBXc09qS2xNYk9LelNKeDJyVVl2QnJIb3JqODJjVlUwL3VHd0dTc3dnT2ox?=
 =?utf-8?B?WGV4cmVCSWZFempxb1BLcGVXcDVabmRGZ1kxZ2c0NFVscW5mNkdZK3FVY082?=
 =?utf-8?B?OTMrckRleDBJNSsxK2l5d2ovTWtDNW51VGswWDJwbnEvbGVXaFJnSS9NZFZm?=
 =?utf-8?B?Y0VwTEJ3WHorNDhjeG5WclBLZENGaXNCN1ZJZDQvYTBNYTBEYWRpSjNNVHFK?=
 =?utf-8?B?OWdPMllDUnExb044SCtXVmMrekxVQm9hNWg2QzBiRmFpMEgvdzJwd01IZ2xz?=
 =?utf-8?B?c0pQdTRwUUJOUFVqVHpjdlkxR3N4b0J0RHo0a0svSFdHcWkwR0FsYmVneUMw?=
 =?utf-8?B?eUI5d1dCZ1R0NEE0clZDZk02Qkh4b0FmRVd1TElBcDYveFpIZDJtaTZQZ3Vm?=
 =?utf-8?Q?5/M8qW0SOR8WFKio=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f0743b-1454-4563-00d7-08da5058f233
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 12:00:18.0255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dIO5jisAfQ/PeweH81J2bVzCFoZcQJ7B7CDSMVX5ykBe3ERlLqrks82S6aUEuKivbAEM/UXFoSs6791PSwG9eHNX3gVD9eS0BnvEH/cedY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2687
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17.06.2022 12:24, Alejandro Colomar wrote:
>Hi,
>
>In Kernel Recipes this month [1], Greg mentioned that 
>git-send-email(1) could be used together with gpg(1) to verify 
>authenticity of the sender.

I think he is talking about GPG signing the email containing the patch and 
is not referring to git commit signing.
Using GPG to sign your whole email adds trust to a whole lot more than just 
the sent patch. It can verify the authenticity of the sender, and all the 
rest of the emails content and follow up discussions / review.

Including the commits signature in the email might have some benefit but I'm 
not sure about how much. It could decouple the trust of the patches 
integrity of the transport used to publish it. For example you could forward 
/ copy a patch and the recipient could still verify the original authors 
signature.

Konstantin Ryabitsev has done some work in this area especially for kernel 
development by using email headers:  
https://people.kernel.org/monsieuricon/end-to-end-patch-attestation-with-patatt-and-b4
https://github.com/mricon/patatt

>
>I couldn't find any documentation about it, and if I create a patch 
>from a commit that was signed (-S), the PGP signature is not part of 
>the patch.
>
>So, is there a way to PGP-authenticate patches?
>If not, could this be added to git(1)?
>
>$ git --version
>git version 2.36.1
>
>Thanks,
>
>Alex
>
>
>[1]: <https://www.youtube.com/watch?v=nhJqaZT94z0>
>
>     - Start of thread Q&A in 1:56:30.
>     - Greg's answer starts in 1:56:57
>     - Specific git-send-email(1) part in 1:57:50
>
>-- 
>Alejandro Colomar
><http://www.alejandro-colomar.es/>



