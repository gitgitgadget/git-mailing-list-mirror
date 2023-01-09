Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B599C54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 03:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbjAID3W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 22:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjAID3U (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 22:29:20 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2029.outbound.protection.outlook.com [40.92.22.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169FB5F82
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 19:29:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1lz6EGzeg/OrTZiByPJDmnCGblBhk4qTdlRCuW2lzE8S7/8QqJH6sx2xkW3voznUURuqySMM8irUESWRtwZocOw1D2wrpf8lwwsQXu+I8CNX3ucjhWC9D0YB+tbK1ESUTvuDwVu/+juGIaRJEQq0+nOMOlWvB0r11XYit7SpeNlsVeIEjJKlPOSEMgLNTsLvr+lSb0geu1iQowCK71GRW/br2r4qO8AS0dPZ7wXVtT+jo58fhYA7yqIKrrlXvUZvbrAfimDA+XsYt/oHVHx3NM6kDETD1T6lawpbkVWIygX7w0mZTiHdFaCqJTMr50LP9NR5Ze39Uv4VYOwi6BRJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nuhjvfc6GLQgcPvs6klwRGlnmMg7cbP4Z2hYv3qNzqw=;
 b=nsCsfFTFc84MRc9du6F3kw7s8RKK7dzHBw24vwkcZAMyYY4TviRI32cLM+tnCNzkwbjog7ojZtmyyvLuj95MPxVlaBPRLeoqDIJ2pOfqcgavz0aqnTvUJ6/pNMFqF8yMSAvwCgzu/7bDk/1vNrFwhhnXoh2DubdaqJ2c1nYyqDh1AJun+efxu1zlepP+KUXdaIWauAaR/lhhr/W407gUggw3kp48+6zoGn3GOWSbNNmE1DcVjfOJFFYY/8Q/U17wz+y5YUZ58RNGToc6SnfG3JIW9xS4Cqa/t0oebgXe5sfX66iOh/pUB7gfBEocZToBaoZbHURj9ug/BlrHZtNlsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nuhjvfc6GLQgcPvs6klwRGlnmMg7cbP4Z2hYv3qNzqw=;
 b=P+Q5+oQN6oThOa/rZA4DN37tRUj7cRvAp7VQ/PFK6TqimdPrXwUixVeksz2C5tU+KsFGrvj47HdrU2zhpFB7rtMxews8JZNkFkb5UzJtLB6WMcX6f7AF0GjVGuq2JOso+U4LeKZNK43DygrSXJhDARk0VEOmv3VP31+9CpsmUcISM5kKhnQaP7bom9T8oQ4n3UPt6t7moCgPQ/21zhKYaqE6WWSBRb+sYH7WcUwyi70REyyya/7ousbyXr/ZCyNTEuO+hqDONzGyE7uWknu3WZPhsNVstquSixhl9hyJFhcAz56a4K935jsLJW1NSQtpqDGfiFq9PR2QOkvDYeZ3bw==
Received: from PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21)
 by IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 03:29:17 +0000
Received: from PH7PR12MB7795.namprd12.prod.outlook.com
 ([fe80::436c:ae9f:c5a9:b22f]) by PH7PR12MB7795.namprd12.prod.outlook.com
 ([fe80::436c:ae9f:c5a9:b22f%9]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 03:29:17 +0000
From:   fawaz ahmed0 <fawazahmed0@hotmail.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>
Subject: Re: Reducing Git Repository size - git-filter-repo doesn't help
Thread-Topic: Reducing Git Repository size - git-filter-repo doesn't help
Thread-Index: AQHZI8zQrYgXZgWbmUmkNkq+e9xLvK6VXqAAgAANXps=
Date:   Mon, 9 Jan 2023 03:29:17 +0000
Message-ID: <PH7PR12MB779523B6D7BA03A8725ADED3F1FE9@PH7PR12MB7795.namprd12.prod.outlook.com>
References: <PH7PR12MB779560B6C003FEE76E4F2471F1FE9@PH7PR12MB7795.namprd12.prod.outlook.com>
 <017d01d923d3$20b90bd0$622b2370$@nexbridge.com>
In-Reply-To: <017d01d923d3$20b90bd0$622b2370$@nexbridge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [H+9H4kCInv+nqaNUlk1xZkd7jWwcNmXeDLJb7Q2liudHiVpBn/wPtA==]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7795:EE_|IA1PR12MB6649:EE_
x-ms-office365-filtering-correlation-id: 0ee1dc65-0011-46e3-3492-08daf1f1b065
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9TYorR1jYkR8HKcTPb6uFvdME6OOZd0b229S9Bmmc5HVN8wD9uZpPLsOdmFwHQ5Tgoz4+vNK6kREm28p0O1OwxUc54Sp+mSaRZtHEUGK6pmIM2yi+FVSO+vnlkFfoqvZNq00WYP9ZD0MwWpcI41C70D6IuZ+jpVWlpBO+Bv8SoNrcmzSuyAJYN7Nh8bi2Vtgfv3uyKgER4kI24QCX9xpY5sHGB+yPjINACETvwEj5QMaFiKgt2sSVtj4RMp842WmtmYHlNn3PMPSLQ7UeYFwvfNTUkc1QVlZhKg4Re6znU4xkTGhvLLJ6ek0marD5QlWseKksiNH+mdpxVvuyMDNHUb0FOrFJ1VF7lDHXHy9KvM2ur+8XRJzxPHojLv4eEzPhQcoJF1cA2bYu1Xfq5RxDrAlZU5zMe3F3b+4kp8GSYiONLifgl8wMvIH6drC2woNxBUXyd69cA/JAqeRMKjnXgzoPHV1zGNmx/fu8waG0+ig6z0NIedclootCVBxxZBpaMBpk61Stct1n3y5pW0LufYJCk7vwZ/suIinNwnNW0s3vmMsm0O0RlPEd5TuynNGk82/a7Cat7wdeIyInU36IzzfdVcKhwbx5EkqjPqtZtEhAiSrL+AksTCSiSBo8YbtO7u7zMcq7qz3gNXIj03uintiZ1ZINMAepUXQGDUPEENw9oc674d6RfMJJIqyW3R+
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+MKdqE76fE1FPzUrShEFklQVO1BqCo7OIuviGg8fKRxxMnMBPrm1UOB/MD?=
 =?iso-8859-1?Q?fl7H9r/kosBi32HAOOYaeynPaNa7dMJjxBWMe5+dg4N6FJdMJcuBk+AHOm?=
 =?iso-8859-1?Q?+1Y4b28HFLev0ozIYF6LsTBZaz6r9QHGPYK2QpO5+jqczTgMVXmezCP8/I?=
 =?iso-8859-1?Q?E5yd0L4gKDzmQxPyaArZgrvPQg293m91+igBGHC9ix6Kt4ZsaIbbIJ1soC?=
 =?iso-8859-1?Q?7q6LKyZQzOpw3WTSwPLb6MuZzSV9xHsNR1aEcob9SSd0QjzeYIHfaO50CZ?=
 =?iso-8859-1?Q?zInsAsGamIPY16WzKtgIUPVMwsQu4dwnQ1HIGYAL6kP5faOcVqzCv8Y3zi?=
 =?iso-8859-1?Q?sUvjI16uJezS9NYGY1iG6icp4T+9koLvqca7Hk6FrpZp58NyQYgmQhVKWn?=
 =?iso-8859-1?Q?00gHiZX1kHqkjthXqWmqhw1BXZJ5dt08SQGdsipMzXSTut9S0vbk/210A+?=
 =?iso-8859-1?Q?N/vBqNxfBhu0d/Ga1ISt1+/kSaCXONpD0Nf3EoJN4tR/dWdnSF+8y7bFqw?=
 =?iso-8859-1?Q?aF+Yv/vJpB/yH4QhXBiRrR376nD6J8lNGxB12jqkULeanZWVDYD2yTutsY?=
 =?iso-8859-1?Q?gAIz7D6ue9UGE0gsd6w+Po5K+oqwJgsNchDXNgI+Ia/+/LRkGd6s4xO3ju?=
 =?iso-8859-1?Q?TIlCeDu5kHtWhWSpnVl9TmVYacjpG7JBad+Sp8X7vRvnMFoS8Pmo0EQmat?=
 =?iso-8859-1?Q?wZX4hjP5sF059ilW0JI9uHItJuzOQ/ctJyRf0Y0239dmbMvirStbo1gEl0?=
 =?iso-8859-1?Q?PXdC725P0HjYy8Ue/gNI0HQeDyy43yo7+x0YTYHA6wcFRVhS35XABXu98y?=
 =?iso-8859-1?Q?2ZkClRaCjx21PsaCab/hei3VxQc0NEk1ccp8jfoec7bZuxv+cHBHF89Op+?=
 =?iso-8859-1?Q?bXgHmOhmGlB3dWGDy86rNfa0dLnIwa9pucasoNlHba5NwswXxOvp2b635m?=
 =?iso-8859-1?Q?CHtyxTKcChTMPy6m8Z0sy7B69dLI3IO0+GOHAsxsCJlaISg2mY5cnTsa7N?=
 =?iso-8859-1?Q?zcCjSSbvU7JPCHj0Pu17Td5Y7Vv81JHvZfofqVm3prVyXYDO/0U4XmGlNu?=
 =?iso-8859-1?Q?/1xAldX68luboAOc16TTGyOqbuC4Z9EF3eipWfenD5WPom5P/xaUToi4t/?=
 =?iso-8859-1?Q?67fukHtUoBdCyYzbqYBwn0KeUC3eEvrb2jT25vDyxpEn+ztwImyzrviRAl?=
 =?iso-8859-1?Q?PGZiBp8sghnDKiqE/T4p4G3GD3KI+oAzomsf6g+UnG0ZlR+QbivL+rnugb?=
 =?iso-8859-1?Q?yDbHEBHxlKIrdjog7AGztOpQAAU+wFrlpIsD5vXfDaBtoxfnk+uhb3xuxb?=
 =?iso-8859-1?Q?1D4y5goZMIbZmogMzy5wdNHBjqrRAKZvUwNKwqUaAkJGA3s=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7795.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee1dc65-0011-46e3-3492-08daf1f1b065
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 03:29:17.4712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=0A=
=0A=
=0A=
From: rsbecker@nexbridge.com <rsbecker@nexbridge.com>=0A=
Sent: Monday, January 9, 2023 8:06 AM=0A=
To: 'fawaz ahmed0' <fawazahmed0@hotmail.com>; git@vger.kernel.org <git@vger=
.kernel.org>=0A=
Subject: RE: Reducing Git Repository size - git-filter-repo doesn't help =
=0A=
=A0=0A=
On January 8, 2023 9:22 PM, fawaz ahmed0 wrote:=0A=
>I have this huge repo: https://github.com/fawazahmed0/currency-api#readme=
=0A=
>and I am trying to reduce its size.=0A=
>=0A=
>I have run filter-repo script on this repo (=0A=
>https://github.com/fawazahmed0/currency-=0A=
>api/blob/1/.github/workflows/cleanup-repo.yml ) The commits were reduced=
=0A=
>from 1k to 600 , but the space used is still same. (i.e size-pack: 6.47 Gi=
B=0A=
,=0A=
>https://github.com/fawazahmed95/currency-=0A=
>api/actions/runs/3865919157/jobs/6589710845#step:5:1498 )=0A=
>=0A=
>Almost all commits of this repo were applied on partially cloned=0A=
repository: (=0A=
>https://github.com/fawazahmed0/currency-=0A=
>api/blob/1/.github/workflows/run.yml ) So I guess it had never run any git=
=0A=
>maintenance task in it's life.=0A=
>=0A=
>I am not sure what needs to be done to reduce it's space utilization. (=0A=
>https://docs.github.com/en/repositories/working-with-files/managing-large-=
=0A=
>files/about-large-files-on-=0A=
>github#:~:text=3Dless%20than%205%20GB%20is%20strongly%20recommended )=0A=
=0A=
The first thing you can try is 'git gc --aggressive' to reduce the clone=0A=
size. Github automatically does garbage collection. If this is a question o=
f=0A=
the size of the working index, look at the sparse-checkout command.=0A=
=0A=
--Randall=0A=
=0A=
------------=0A=
=0A=
Yes I have already tried git gc --aggressive ( https://github.com/fawazahme=
d0/currency-api/blob/1a1fb65703a2fc352b0ee452ce908bee545698c2/.github/workf=
lows/cleanup-repo.yml#L78 ) . I am using sparse-checkout to manage the repo=
sitory. =0A=
=0A=
The thing is the space utilized by the repository is not being reduced,  ev=
en on deleting the data using git-filter-repo script. =0A=
=0A=
Thanks,=0A=
Fawaz Ahmed=0A=
=0A=
