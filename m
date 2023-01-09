Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8607FC54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 02:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbjAICW3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 21:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjAICW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 21:22:27 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2028.outbound.protection.outlook.com [40.92.41.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1152237
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 18:22:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XH+rfG+6shRkP8xVceuAKdjTc3fO3+oGWBWkfPJ9bZrHBR8epMmQYcCtnKMu1LyFq92qY5esHwwnH3wDS3egWz4tdZP6IHEChtpos61meWIN1Mjc5te6mjtjrrdKUj9+LWCHcy5YdJIbM87UJCCQoCeg2KhLZdrnVCLs5OcgamyDM16mywGA208qbyxmaW57DGtIBviTQjN6jkt2NnTdYGz7MrSMTZwnbYtVTpc82VpuF8pmvPlPmFn1GbzXPWfgq6J2rYKLLGTLLRDgGAZuxnXOOdcBCrmWSRmDNYUhXCIoVnZCSF/tglZjH3DRLevsAoA7neMeACrhsssTyF1Kgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/9HtvdzKeVK26JcFOiTYOPoXyseyPH06oyDfP9nhyg=;
 b=b74596kPzKOutNWFfyF4vecDi+uaE47Z+YKrH8uFrx9/ikmfwZAtINih1Jxz6BaLhwED4y+I7dMeVOXcSGWjaPQg9+TSDgO5+U3mIJhjMb/gP72cpha8fgEfWFHDsgjpPIg9p0pdT/aAzvisytRS6qdg9FVctDXfZ0RknRdYGH8S5put1p5l2z2XRWSgI+gSNhKuIeRdnqICGQQsthWv/WWcwQD41AKzHjqmqAc3sd42KHhTi+D//pe0qxceGZZlJ38CzcZcl2kAE54gnNHboAPcfQSr4nvkSKnFw1cAg2pnMoQjmREHQDJvU13MoSsGgwT0KLyWb0jPWg4Ya565lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/9HtvdzKeVK26JcFOiTYOPoXyseyPH06oyDfP9nhyg=;
 b=u5bsl2J93cyD65GY4hB173GMxPmFVKTZnEnPnZoJfY48PG4qWFIac9v3VhEzcAiKORHADy1C2BaSgvbtIM5sZrzfIz4eiO+BTqbo4aSceD+YpDq2c85DezjwTBt1vQjTqPecfm9ZBLnXD0WtUE0VtiesLSyFcJ5twMs/U17hfeFKumbmOQgfPvD9Uf1NCF/T1X3u2Z5yYd7ZbaZAdt+zdj49NdFxhZg/PmCBukR+6u4B9pKmdNR1zKZCVzLETBi4e1Sci3CzjcxX3lrpN14it+5HYtQR4Tct5PQ7jL9GwfDbppF8F/9TBZGntrr+oUDmzqvyCSZWD4vEq1hbRTV4Lg==
Received: from PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21)
 by CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 02:22:25 +0000
Received: from PH7PR12MB7795.namprd12.prod.outlook.com
 ([fe80::436c:ae9f:c5a9:b22f]) by PH7PR12MB7795.namprd12.prod.outlook.com
 ([fe80::436c:ae9f:c5a9:b22f%9]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 02:22:25 +0000
From:   fawaz ahmed0 <fawazahmed0@hotmail.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Reducing Git Repository size - git-filter-repo doesn't help
Thread-Topic: Reducing Git Repository size - git-filter-repo doesn't help
Thread-Index: AQHZI8zQrYgXZgWbmUmkNkq+e9xLvA==
Date:   Mon, 9 Jan 2023 02:22:25 +0000
Message-ID: <PH7PR12MB779560B6C003FEE76E4F2471F1FE9@PH7PR12MB7795.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [tBrgaB/3HkbDbsX1PA2kJ2L1M0xTeSqgLgTnbZdJKEBPFM5cYMcD9Q==]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7795:EE_|CY5PR12MB6455:EE_
x-ms-office365-filtering-correlation-id: 910ceaa0-cc62-4785-6dc0-08daf1e85908
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: efsBOCI+piDGiRrMWP3ZILCN4FPzlYEV9yvRv6ZGRmClIKvFWGlZwTP8UmVNGFuuWgb8FQFeFhXu0dkqtvmHYncSF1oGN3IFCUz617Ih+9p8kaghzxF6YZvX5iBea3ivWKgnGKsqGRvBIsGnpegVxdle+edJp9/K5s2s7p25ZRRkNgINBqE6jlndZ+Nbq0hpPpzSrGW0UrWeaGqaeiXmAHOySI/PmEgsaj5ytI+EOKU2jUVM8scqh5l+76afK6K4fnZT6dCkz+UBbkBzxS8n9T+ynTAoLu3749TjyRSaHRFaNGB1h0LzczGzWoIYmlFzw2tJil6DvUfYqohPZ/DHvjzO2nthT2RuyZxdkPUNcPEATKRdnkRWkhlcQS7uXACZj0RerEXSfhM6VUvv/71Z/vMwLKobqDL6VK2FCtac+TYDKxySCJfXxEMmRAk+rfr0U/Bc2+ezio8QzhcRSIgTUa7RfbPdYLbW2wWVfNm9ZRHZKiiVYl8mVW2WvgI4pifL/FjKN7f2XfJEcrJy9k+U4Pp1GrZOid4ZIia2PIuiMSS9fr4LX2LSteBu/1jQ2EWiLh5nrxzOcmHlgzPCuzhCPyCUjrbt46TQ9XI0eb+DvLcpCoNo30ncvvM2ASOwo4Kh
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?859xufD9+wz2qlDH+zLTZc/Ve7LanAVUSGCqoEzbGV9vT3Hu3JVzpCKU2J?=
 =?iso-8859-1?Q?V/XNItSQGFL3T+rsuagmMn7pd3LifFa3nY8mpUaCJBGB1L+c1i1l7YHzZC?=
 =?iso-8859-1?Q?GIj4KhH6hqCzFB03+Dtw+c2k7Biwe6OxwWVCqSTtn2uhIVSZn9/AiTyTNH?=
 =?iso-8859-1?Q?79SadR99mPfuT6pGc9xjv4BzCh/GSHugH3xTJVq1Ryeuac7LW05TBNISZn?=
 =?iso-8859-1?Q?fCAxJKPv7W+VkZttUBi/VIIhx92oUEl9HMEQeRjmy+E70gumVeauDrAYPZ?=
 =?iso-8859-1?Q?Vs2wMfSBk+Y/4zEcrU9ZxvtomkM+SuJy4jMlelwUhoOrcBgx1ouColwlhq?=
 =?iso-8859-1?Q?dAcC77XONGCaNIYh3I1yyG+Uj62esBKZNZrls6iN1K8Rsjpk3oZIuLJCYm?=
 =?iso-8859-1?Q?+C50tfA5eKLtLcX0JmTA2pRJZq2kL9Cws7DaaaXAeiq8i3Z5YRgobILi4/?=
 =?iso-8859-1?Q?oq3aUoZdwgz/2kuODHVszJYgQFa0t8vQg0u7DoW/u3Jkyv/tMtdERwJCIp?=
 =?iso-8859-1?Q?E4mLCi7nV5cVApDijpSkeNokSgbWHYfV7M19PsqjZOK4In0lovdw38YLgU?=
 =?iso-8859-1?Q?NZGSXq4Il/84IC5VQQO+vJcGTIDGFjFflvODUgPtqFIwrNpjVdTTjD1FVX?=
 =?iso-8859-1?Q?ZfSAjFTTirlb/ctil86HfIp4hTEPFGsytLGqmm+LWnrLSX+bl0AV20VgyW?=
 =?iso-8859-1?Q?LQOiLLlmkEnn5r5VbEpmp9sMiOcPzueMudJb5bta/CLdcJIh3YdKNM6ZiV?=
 =?iso-8859-1?Q?/Pj7oFRMJecYQLa0mXUQOszEp8P9/5NAlLd7p+ylDOvZF47gFtwyQkUEM2?=
 =?iso-8859-1?Q?F2P1tkx0V5YArgNpeerhsG7MnfUGwdjOlEWQCHBXXTfk0OdORDEnLLGZO6?=
 =?iso-8859-1?Q?js90r12Cp1UDTwsm8Xae4dW5ttiXcPFC2vtthdCzWJqi6R3SJ7GiTgJYHm?=
 =?iso-8859-1?Q?tDpbqyEfoJBvzje76ibfP3Vd+XZ0+KTZs3jYgO2Z2oxTFeiz09h8aeSOD8?=
 =?iso-8859-1?Q?GAm63bBVHMt0r4vQF/DQkJTENwCPiaX+gaIO7+yp4VhoFuEQokYPdOP+HN?=
 =?iso-8859-1?Q?Hxyev5ZROzE8klIK1rEnlmigIEKfEpMDGkXSMlUKsFXOCIAlEtowYgAXfj?=
 =?iso-8859-1?Q?axLEeX2eJtTbm6YpJrU5zB3R695iLTdDtjhhX+ifhTbdXraV7/P+qZNyQJ?=
 =?iso-8859-1?Q?wSHa05rHhALMt+Pme6lHLtDxWh2edI7L1BcLi1SDjkfHzgDR81xCcnWKxK?=
 =?iso-8859-1?Q?0w8/hBqOdoMj8hrB2NTNb1gJSQcpHFiFU7mlHfSk8SEzT3JG+5z0hIvK0E?=
 =?iso-8859-1?Q?PfV/Qotlx1c3WxYQhjg6HD6oynIwui0LRVqUHypiN4MIO9E=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7795.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 910ceaa0-cc62-4785-6dc0-08daf1e85908
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 02:22:25.4309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6455
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,=0A=
=0A=
I have this huge repo: https://github.com/fawazahmed0/currency-api#readme  =
and I am trying to reduce its size.=0A=
=0A=
I have run filter-repo script on this repo (  https://github.com/fawazahmed=
0/currency-api/blob/1/.github/workflows/cleanup-repo.yml )=0A=
The commits were reduced from 1k to 600 , but the space used is still same.=
 (i.e size-pack: 6.47 GiB , https://github.com/fawazahmed95/currency-api/ac=
tions/runs/3865919157/jobs/6589710845#step:5:1498 )=0A=
=0A=
Almost all commits of this repo were applied on partially cloned repository=
: ( https://github.com/fawazahmed0/currency-api/blob/1/.github/workflows/ru=
n.yml )=0A=
So I guess it had never run any git maintenance task in it's life.=0A=
=0A=
I am not sure what needs to be done to reduce it's space utilization. ( htt=
ps://docs.github.com/en/repositories/working-with-files/managing-large-file=
s/about-large-files-on-github#:~:text=3Dless%20than%205%20GB%20is%20strongl=
y%20recommended )=0A=
=0A=
=0A=
Thanks,=0A=
Fawaz Ahmed=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
