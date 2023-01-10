Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8189C54EBE
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 08:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbjAJITG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 03:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237848AbjAJITB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 03:19:01 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn20824.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::824])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8AE43189
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 00:18:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gj/hbqRt6JGafDwVgZ/GB98AqhGE3853rvNoDoZlBKqV5c4JbRfAQIbHZcyzs4f0Lsn8RayGKNHqcA/0lriu4wDpxKxUq45c4h2ghA1IJw8NYdd3tzIbVdH+9Qrf1fP/Ju0Eshz9RWOMFUImovp/7Eg9KR4sHILtpwvKn6PKPafh4Svx3YqkILWxTohFbmnCEsG8Gcuov5k4If9OOQUbvRYOkJ4TAs4lR3IzKvYK3jjnelfi6+JthlIsbaO33kI/bI0XZx3OftUmlITsOw6LtQSBNrm08PuY+oQnyIxHVmnjpFK/+C+03NsqZJB9Nw5LmfB7SDNojpZV7BcqdvnKCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMAbnhiisEnnKrsAGewLq5AuqgipJC4QPhpJbMUEz4I=;
 b=YhmivRppXQfkSIw8v1KwdKkrdSGLtXRUpSO7umAGNt3X/sqcDwHoC+Fqmus/1ql/fHAlZQYT9JRLDXeAOWpj0tdJkgDoVGS1mk6Y6WLhkuiKHLc4ehapPObQFCiNqxnkrdpKZOQSUVaSk7goiNkX1FCOQ4POeUNgfml8C6Ill/o+s4/w3NYsoH8aai9pyUUN6EOCrgCg2ONDTgdbCcWW3rnEoqg/eT7Mn9nZn+cYO7KPvhARRy9LpftSHLoXaZ5TiXGdDy9EqYu6BpWmbrCgfZz8QBdSZ7x+U+6HVOIejK+71g+OF60Bj7AKksqXzb8Lzc7gH8IoZ7czNIqlbF9sEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMAbnhiisEnnKrsAGewLq5AuqgipJC4QPhpJbMUEz4I=;
 b=PLSmGnckfP5YOfXsJ/TVEhnkaa+2eovNSnBugiRPasTn2DHXwDeSJgIOSeb4FBPfoZcUbdMf+Mc3fjF3bwj7w3TtlQpaObTuDS+DcA3N+MBo3wgej0kKY1+xf7pdn4kRINktGN1NKJfvJHgL5PcOtdCIHcC/KChjkbBniPaU/ZJGleyj+BgkW+51lztAyykNrel/jLMvfPl6InWJ2UOIjjxMmUXTxxTmrrhXRVstuUYrR7Vw2lfMp2qZWQjmTgcbyrk8Cv06QjNTcBZSBrcPiYoEriIixnJIEsTPR7C83pTHf20p+EQZzVNrPlUq2aUHYWs0i9wfoyf9IdT5oPOaeg==
Received: from PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 08:18:51 +0000
Received: from PH7PR12MB7795.namprd12.prod.outlook.com
 ([fe80::436c:ae9f:c5a9:b22f]) by PH7PR12MB7795.namprd12.prod.outlook.com
 ([fe80::436c:ae9f:c5a9:b22f%9]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 08:18:51 +0000
From:   fawaz ahmed0 <fawazahmed0@hotmail.com>
To:     Elijah Newren <newren@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>
Subject: Re: Reducing Git Repository size - git-filter-repo doesn't help
Thread-Topic: Reducing Git Repository size - git-filter-repo doesn't help
Thread-Index: AQHZI8zQrYgXZgWbmUmkNkq+e9xLvK6W8qAAgABRgns=
Date:   Tue, 10 Jan 2023 08:18:51 +0000
Message-ID: <PH7PR12MB7795ED45E989E2EDE2364049F1FF9@PH7PR12MB7795.namprd12.prod.outlook.com>
References: <PH7PR12MB779560B6C003FEE76E4F2471F1FE9@PH7PR12MB7795.namprd12.prod.outlook.com>
 <CABPp-BE_FLFL3-s3936zWWfaORBPim14A-oqVNo+8gx+CMduHA@mail.gmail.com>
In-Reply-To: <CABPp-BE_FLFL3-s3936zWWfaORBPim14A-oqVNo+8gx+CMduHA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [L4E2POffmSF+rrZ89Me0YRJ9piAyTMPDUJVVOFjYJpEIupPwxUh/qA==]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7795:EE_|DM4PR12MB5772:EE_
x-ms-office365-filtering-correlation-id: 8f672881-a1ce-47f4-c8bb-08daf2e34eb6
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hT9NoJDv6N1gxDwKJFm56UMpo1xJeuzzIvMmW95KLxz0I9hEaj5oKYwY0cSm9q6lgvnC6tTDIcsI9mPYkIxRpBMlFTg77LM1KaNjKix2A9o5EtjF0dOo8SJoELgoJBMvvRAjnvBkwyX3dQWcUHuxhaU1+Ps2QEC5WVw5P6zQ9zOq2r6Q5qR+wzp4EtQU4ZdLd72KCLPPlKdX7AuvcezbEFVjrh9yPpIXJMWtjynbmR/Qm+MuCXws5klrzU+ZYNKhXa9KMCKGDjSilF612KHTYGmN1hErBIdGEVgMtzItWqlqH000iE0opPBtQF7x9MNhcwTHhqEaXdYEEcDe0uIj43AL72zMa9GG4+KewQFwE5wsroNRYWMOTSBEnHLQb6Zq9qnV3X44TCCE937jEEwV9wd1QXbrEbi9HWlDp8kdNcQUNCvsv3ynKHMrYmipmxsji6qQzy29oVuUnmPX7moMze/+bPC/R3MbjXztntKjTRaMdEXIXABk4gQ16M+tG9XJ8V0jAVpxSuBg6kYT+pKjCtI9evh1fWiTntXAaxCXPdQkjFJ7gwNKt5T/VIeQ+x+VtoRkS/qECsrthGZVcSgXzLq7fD8hMNHRRaH3HAlkLfYP+4O0FYWA2N0B5JxqFez16kmmvJcnWuOBwRz3qf/VpJOfN/racT+D55HjGpBPwNz7w24GCCXsYEmOfLBboxSt
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Vfth5K+o1Cfb8AEreOM6aMJwR/rnVHQ8kdKNW9Z/lNhGdVgondkU+UsZyC?=
 =?iso-8859-1?Q?eft1EnefU7JrwcfmWecur2UbjmyCmEh2XEMKV3MFgP+2zbAlFVH6yaV9a+?=
 =?iso-8859-1?Q?s7Y6HsNN5+RGRcz+xPb6G0I8S1enwkj9+vu8E++UMq8FTn8kzgGAnIqvXA?=
 =?iso-8859-1?Q?trK+1Qy2FE2Lgu7XNbO1jWa76iFUUY6CYWaXJyifMIMR+fzj6RQz+5FTZ6?=
 =?iso-8859-1?Q?M/kZHL9dnqOFK8fNacjZW3w0ShAgeYQEefjE0kdLvJ4Irkv3d/a/b9prLy?=
 =?iso-8859-1?Q?lZPOp6CNzyjBlB67rPaZxZpEYje15w+r5CYNGn1k/ULxF0J3dLWb3bpcB7?=
 =?iso-8859-1?Q?UzkVJ6yRd+yq9ClWo5CRAMNAlFkFLIHz7CoUd0BK1Kvip29+ZNdGpDuaAt?=
 =?iso-8859-1?Q?v80uRzcnrA85RcSgPRogKCPJRzEn2MZoUEX0ESiRpytuc2u0ULpDpc/U5R?=
 =?iso-8859-1?Q?wGrWqSLrz1M9S5rMq0ViqKRQrwBCjLQPKvs4h2J1mhahHvUJSeyoLVc5o7?=
 =?iso-8859-1?Q?NSLqLSTEC2+/tTvMB6D0AofIF9xdjy61N290HAJy885X4G1Fg5G/+r4IkE?=
 =?iso-8859-1?Q?bSc0Dcndmu3LJN51+LtufkoFVtaeVGujje3DoREXZ4s0qHk0rrxeZOOeAi?=
 =?iso-8859-1?Q?8UVLmJH7/BhTQkYhti4WaCK1t21u3Z2upMyD8YTlrJWsMaHZrhECH3LnNE?=
 =?iso-8859-1?Q?6W01Bw20LCn+4tQa/K4x0EAgIWUYFMrmIzRwsgTnKRI4sHiQ/uVCEdSk4S?=
 =?iso-8859-1?Q?3uv2Dtf1nmPMd8dF8yYuQWVFyfXHdEuYNVEvM7rmx+ZAKA82laK54aFY88?=
 =?iso-8859-1?Q?KAn2knYxXNxMCXXEeJ3g/znb9oVmvk+bnOHMJeZKN+wTNemJ0/ERaaFKdp?=
 =?iso-8859-1?Q?BeqIoy0344IX6cdQ81k0IcCgpE34Uipl3hCyBfsyPIAt86/TTcX7otCqvj?=
 =?iso-8859-1?Q?bxcP2PBMfAk1/pkompBy6Azn24xorAG1Cy64KZHaKtjYuJlBtTwBXzmPSm?=
 =?iso-8859-1?Q?8Pn/yAqUqCj/9/gxGCxmac8yGtC4cLJ+cAhm5hxMcD2C3lbIrr84FCMnFq?=
 =?iso-8859-1?Q?nfWOXQRMrSa2V3I768IqIkxyBAjnTHWQBquM43BQLpg5kAWL7omZ++Cv9J?=
 =?iso-8859-1?Q?L/fZ8TdEp7yj6Fg5YoNb4+XIPZLjEnKk4eJR0Av+qRCEPOOGQCaNI2Fj7i?=
 =?iso-8859-1?Q?8PKekZLwPgaDL3EPGmCmAFQ00IOtSb7MA96XW8Vv4U24LlzGnJk0haQulJ?=
 =?iso-8859-1?Q?WIsHQ8w2qidsIu1ZdFnsRyD0hoPiNhxztNydbJhN+uvYJTD5MuecdoxIwf?=
 =?iso-8859-1?Q?tC8uw1YSr5BFFFwNYTZsav2GK5EcO1rOIdiu3vkBR4EtV5E=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7795.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f672881-a1ce-47f4-c8bb-08daf2e34eb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 08:18:51.7978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=0A=
> Note that git-filter-repo only changes the size of the _local_ repo.=0A=
   You made an additional clone within GitHub Actions, and then=0A=
   filter-repo shrinks *that* clone.=A0 Even if you had deleted all copies=
=0A=
   of older files you don't want anymore locally (which is suspect as I=0A=
   noted above), your force pushing isn't going to shrink the size of the=
=0A=
   repo on the server (i.e. on GitHub) since there are pull requests in=0A=
   your repo that GitHub won't allow you to overwrite via force-push, and=
=0A=
   those pull requests still hold on to the old history.=0A=
=0A=
Thanks for your inputs. Yes, the issue is with the GitHub itself (I have ve=
rified it locally), so when I force push this reduced sized repo to Github =
and reclone it back the size gets back to  4+ GB.=0A=
So what do you suggest? =0A=
=0A=
I have already contacted Github few days back, and they have cleared the ca=
che etc for this repo.(but that did not reduce any size). ( I will try cont=
acting them again)=0A=
=0A=
=0A=
=0A=
=0A=
> Why are you cleaning up in a CI task?=0A=
Task is yearly cleanup, to keep repo under 5GB limit as recommened by Githu=
b  ( To avoid receiving email from GitHub : https://github.com/whosonfirst-=
data/whosonfirst-data/issues/1507 )=0A=
=0A=
=0A=
> Could you provide that number and how you got it, so we can see what you'=
re measuring=0A=
I was checking the repo size here: https://github.com/settings/repositories=
   (it takes around 1 hour for github to show updated size after any commit=
)=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
