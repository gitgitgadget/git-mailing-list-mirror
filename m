Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B85C77B7A
	for <git@archiver.kernel.org>; Mon, 29 May 2023 18:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjE2S5Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 May 2023 14:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjE2S5X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2023 14:57:23 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2064.outbound.protection.outlook.com [40.92.19.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA687BE
        for <git@vger.kernel.org>; Mon, 29 May 2023 11:57:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mF7Ol00lnJScu3G7Jz18/oxvN9PW9AiY4lGbSh0z55Loq8r7YPexqC2qqCLDf48vKfdrTYFqpvJL6JIiBzFDi5XSX9boDjXSVPiqbPtAacHPfspJzBqnZIAcfKLj+JMBabYRG8kpMOaEY6JT9p20+4QwnvO1w2t+MAR9U6X5Fl8N75AqE0fpaYgvc+g0Popnyfu3GLAY0ad2csh/FPH6+Y6JZ/8HRJeLwAktItn+s7/Jb2+D5NPFBF4qmnRDbIBw8+HTQ1bGegBYIlXqY0I7ynMz0XE+pcCEY4UnsSGdEHtadQAr9pufhkfP/vA8GDflHxb4kE00jVOzfhdOiUpj1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnjTZg/2xjQ/Xiuoq4op6LIdEX440+xJ+A/5Tek00TM=;
 b=jwUpoo0SkNGxZ5qEBV1/kcU1KoCyCbCDsc/pzO17df3t4CHjqze4Cbool6bSZsTFEiRiA6v7BdRb6mHj7Bprw1/TxWuZNcUDgOWthJO6JeqDwQtKaSsNwOOeR2D2CeiCTfUEaYT0j63xT3liP3wpJYiEeHSkBBMEjdeo6si1FuK639C5hqN+tn97BaGvN4Uw04lvS4w+xIv+gEgP0pLzW3/tdZ4Fp3tmUkDKW99LBmgKJj1BD9Vl1XxpqMcBm1Y7KMdDVJ46bDt0dxSvLfwfqclT1aXbFT9gLj/+KSRLdlDxONSgromJKbd7evl+RGtHzaEDUivdEXqXzNTC6Qsy+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnjTZg/2xjQ/Xiuoq4op6LIdEX440+xJ+A/5Tek00TM=;
 b=A//zmJK45UjXLtwNgfGnEQ/xmyWj3i8YtBy7zO7ggATraLo4im+Y3Jgvknr+6gK+x3N52ZKjju1b5y3S04ZV6MHnfqAkRHTJ6lCBCKW57uXnxgc2TKIn9wi9akqBaKjyCuRQ/xx4IGY7zTUzbLR7wIjgka1ToWczjdW96IRybbWCHgiTmDwNFk5qSc9mwwE/XyXw21SnMXMaW9Z3qxrag1H1Z1z/fgbMv1wS4SwKAUyrnJu+rFTDmWH109fpondRU4DnLiv/NIk7wFLKITltt7LtKKWZVs7XtSDKPlhaGkPXaESM1aZV8LnWjYAs2bWKrgEkUbeGj7tcMYsSDW8/Dw==
Received: from MW3PR13MB3977.namprd13.prod.outlook.com (2603:10b6:303:53::24)
 by BY3PR13MB4852.namprd13.prod.outlook.com (2603:10b6:a03:364::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 18:57:20 +0000
Received: from MW3PR13MB3977.namprd13.prod.outlook.com
 ([fe80::195b:dbb9:6d29:2f8f]) by MW3PR13MB3977.namprd13.prod.outlook.com
 ([fe80::195b:dbb9:6d29:2f8f%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 18:57:20 +0000
From:   ross thomas <rossrecovery93245@outlook.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "litvinov2004@gmail.com" <litvinov2004@gmail.com>
Subject: Re: My git repo is broken, how to fix it ?
Thread-Topic: My git repo is broken, how to fix it ?
Thread-Index: AQHZkl9lJ6x4guGw2Uyn9G7JHOeD/g==
Date:   Mon, 29 May 2023 18:57:19 +0000
Message-ID: <MW3PR13MB39777055473DA7A5B5765628FB4A9@MW3PR13MB3977.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [TrzOaKGDYAMFihbcWf7b1wLLj6ZKZvqmXw1hkoA+bIU=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR13MB3977:EE_|BY3PR13MB4852:EE_
x-ms-office365-filtering-correlation-id: 761752be-93d9-416f-379f-08db6076878e
x-ms-exchange-slblob-mailprops: 63KnrMPNb53mKQHjPtfQjupABN9KfqYSSiOPBcb7JBynlT4hdQ8IDACGMsQedyeJgjLBzsJCYtm1NffMN6w1LwgJYgKNbHdzNLrLQhbBGddm6GQ+Mo7/On4f8goKoadMek/KqlOrQgZe18dUqVrbDckynfJgxRoSXYUty4jDTr4icJaNw+jeTzoVE+s/aJ8PWCFPHtebbNLwArUqzhBy0sO/ZtVMYA+McExsKaemSWAK9i72XccAsFZUmnj2sfQEROUNMCjOQxcebmggblVoUVlU5otPSy2vGMAkltViW1HRKxcHIWx3ywWcwJbZ47YGudIt4NS7KtuMyvz8xxP5EBWVYe6+5G1Nh/PY3/c6ljkby5gJq6GVm1+IUCyhwk4mSXTNjzzHK2HtoVe4nAFpCna9fa0ZgODGwr5m60NFWlurF39oV+Jt/V/j0dYVXUytcCgSJLwqWOWJLoEEbxPFkodTj5kO+sbtIRbUS+7YXPnC0R/S7q7nAzhHGDIpfyJhG+C2jtF+EriLtNUOMb03G7xmPVclFY3coE+8ja1VBPndMSglT8LEQYqAS5Z800n76Sp3+yJsdDLbFA+79bYMCSCBlw8Zjp6vti3s6yOpw5dxfhIn36HD2t94sdsMPHZMiob2n20liYjgFEHXTw3QwFyoRIL3QzsFRTUvop1WRq6qznLfJV5OExMVWHmXn8gQ
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W0Davy8tTxtUHmczmTCh7MeTIGiNrvfZrxJua5nB2OCLMK1WLjlv2mouT2wgG83OYtDmy3GD9AEY6v0poWHHg29TTcQOznm8USp38W4b25nWJlyN1YIkSSQISJac2eKxGN06uklrOArHphV+QU+2kAu/RmXKhehWsxxK5MRQSaHG/lIa703TQTB4OTtIJuaA4QvoCAgsgFLqq8YT1c4MlP8lx10MGXkOxjwE7vfxZ1r1w0hXIsGmRlY/R4aguNPC6bM1P+y6uT6PxTyN8q64EAY4V+92muB6vY2iRmfUcEt9+twSXlyQTn0GzOAjkYhSrcmi+0jSEHlDLq969P0o/TYRKkwysIrgcqvXHoRhNqR2z8aY8LFeO9dqpqKD0yy1X/adhzUwCTPqHfu6Z48pFkJemwob7eQ6SGIFkUpxJp9/8wKU420lQIy7MVvL6SP9A1olFBrgrSJMEns7E/PXNAWU6DFxAzwHGpbYsA6BjsZ7UsolgwgyNQhJM5shjW7gpbcqWKdGgO+pa1MzieBK3O/CkkE6n3Vy+3962oy3jlRmw18QomrF4BRudPlJ8J+GLbyScrNDCWVBRIqay20gy20kwwPyXhYRzACATzTDhm00AkJuffFSpCG0u5VYipUYvi177F7kEOegAx0pmmlxjw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0dqR2dualEvTzZVOElTTUZBcWM2ZjVablZlN1M5aXFhWEZWdm04TGdnVm9I?=
 =?utf-8?B?alFhVE51WHlRbHlsOXZUZGM3dEE0Z24wT1dPamx6d056TzgxbU1qUEtNRTdu?=
 =?utf-8?B?OXMwUTA1UHpmQTlUMEMxZjVZTzcrbnZDRThsWmpDSEU3ZThCdVRCc0FNb2pu?=
 =?utf-8?B?Tjc1T1NoU2dydjhkcmtjVVZaUGNiM0kwU3Z4MmQwMzUrSWh4VGM3NW5yMWpM?=
 =?utf-8?B?UUdxQ1VjR2IySytXdzMvK3JvWXFZdGVtZ29pS2JQQ2MzWGlScUM1Y1l3QjhS?=
 =?utf-8?B?MEY0NG0rVml6NlVVYnl3dUcwSndQUlg5RFlHbGE2QnlTazhuWng1bStoTm9I?=
 =?utf-8?B?YVJMdWhwYU43Q1RLMm9RckhMQmVOdGpiNzU1YTh1c2cvNmdrL0ZvMSttU2xv?=
 =?utf-8?B?aG8vVE9KdzR1UUVQSG9pVWlOVC83S1B3ZjQ2dXVtZE9BaHlpalc1QXpiSnM5?=
 =?utf-8?B?d3BERzZLNVB1NHFKODZRelVJOGxTWlJCMlQySkNrdVBTMUxrT0cyWFBQVmZ2?=
 =?utf-8?B?SkZBc2VCS0JldkZuUnZEQm0vcjhtZTgzVXZtQmUxSCtvTjJhSU1hYjdMWmRF?=
 =?utf-8?B?U0dEYU9wUENPTCtML3F3aU8weFlCS0NhVFZuN21kdzFMZDFhMVVxbjJ2SkU5?=
 =?utf-8?B?MTQ1Q0xyUEs5TDVqaFYvZjA1K2luRDIvV2NHVVlvVTVKY3dDUjJSWlVXRWkx?=
 =?utf-8?B?QS90Q1RrcFhtWnVqbHFycnZMNVFHZXBreG9sK2VkcFZKRzdZTVFBMW9JMFMx?=
 =?utf-8?B?czJmV0dGaFlYZ2QxQWwvb1hOOWJKMG9KQ0ROOTMwUEF3QS95OWRZUW9sc1hm?=
 =?utf-8?B?VzJQTzFnV0JkR2QyNmN3OWNGY3VYMHJuNzJiMFZDWEIrRDVyQjNHcldGdE5s?=
 =?utf-8?B?OXgrazVndkRwZEgwdVFaRUFvN2VkY0xrd3lNbUxpSXA3TEkrb2E0MUdJTFdW?=
 =?utf-8?B?TWNCYlplcEZFcitwY3JCVWRiUkRsbXNPaHQ0RHBnZkYyV1duODZrU1Z1YmR6?=
 =?utf-8?B?Yk1GcnBHeGdNa0RJRFJoMEYyNEpsVlhWR01kTnVvWWRQNjJkRHZuTmRDU3Bv?=
 =?utf-8?B?Tm1kcXlFV3Z2NEEzTlp2WHJGdTBRYUw1SlRoQ3gwSkVmL2ZGRGo0TnpnZTRQ?=
 =?utf-8?B?V2NENnJXaUZhclJtUjhZK3c5eHNhdXdoc2VIUVdZY3JxMFVMaUtteFQzWGtV?=
 =?utf-8?B?RkNhZjBYRHVJNWF4ajJMWFkya3d0bmlhaStjUExBWE8rdFNiczdETmFEaitU?=
 =?utf-8?B?ajAwSjFXR05SdUs4MzN2ejdrV1hVbjVIeFA3YWIrM3RmVDZ2NHlzSnNETnFJ?=
 =?utf-8?B?K01lZ29kZUtpdENOQWt4UjJsbXA4dm9TTjkwQUVJWmJweGg2U3hPL1NTSmRH?=
 =?utf-8?B?RzQ1ZXlLUnBMYnFxVzgwZVBuQUdsUThXcmVaN1dBNHdJTXJyclAvaUVEQU5z?=
 =?utf-8?B?WHZWSUxQUW5OSmowUEY3SGppQzBQNmt3QkVJSUlsSE1qb1Zyb2JRcHd6U0x6?=
 =?utf-8?B?d240TFlzSUViYlUrUDZMMTBiSjRmTzJtcUJ0djU0SkpLSnl1RW9RU0lHU2VD?=
 =?utf-8?B?bUVScURzbkpPR1NlZEpRVmpUT1JSejh1TkpKTVVHQ21nempkYkE2TVpCRlBW?=
 =?utf-8?B?UDNMdWlDelpDNFV6MitFNnJJMjJZcGxsYkl5QUdjMThtUG5EL2lCL2NXMDZI?=
 =?utf-8?Q?2tYLvK58OPVacHI9Vr0m?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5263FCE5DEB5D04DA2F3F25FEC3BC753@sct-15-20-4778-2-msonline-outlook-da780.templateTenant>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR13MB3977.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 761752be-93d9-416f-379f-08db6076878e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2023 18:57:19.9711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4852
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SeKAmW0gbWFpbiBydC90ZA0KDQpTZW50IGZyb20gbXkgaVBob25l
