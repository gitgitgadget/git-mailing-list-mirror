Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFF8C05027
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 02:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbjA0CDC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 21:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbjA0CCj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 21:02:39 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2044.outbound.protection.outlook.com [40.92.107.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8CA46D48
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 17:58:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDFZe9bGhQvazy9WYS9bLeZIljA3iXlS9FkcyAOtF5vSGF4bfbROpKjKZid5mEYTtEV1SkX25RqvY/Zy/Rz/yakfQIiu+OY52AQ+7rtDRLiYWeuobiEufGD/nwgX6sopS/6ap4vtI/o89m9A6mVlfJYPIOz2s6/19GThdgZPFCHQNtCHycRS6Ems17+HS7gcPgHO4kJJW6bhPBy0HmAQMveRGG+pZAGdnxuxNZKeqbgbMwlJ+e/JSD7xB0hBnfWlt8YRoEGuQe/du0ZpZnQRyHpC/IaCBuvPPp2OBQWY9nASZh0IzPsUhs/pBqBkz5jtzoIBOs21u5N+gzwR11Roqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poIVs7n2L1VLigkcRovsBUY82NvF5gcSLil2yyfJYU0=;
 b=YnajW3wVybk1vj9okGlYc6b7HKx2a9dcsgPGfVy0VXZd6pmo1Cgq8qX/edEJ8UeTcF8Xkga/fUdTx9Cbte3iWIwhXcF50/gCNWzbFB63Tjpkr66f8kA+6ga6Mc4atTOrtfdoX+M9ogVg3ywdVe1R5Lf9sj9ZEARchwTJu3UGvQd6m3pLv1dVmZ5XyHOlDVRgdhZxc+G0omuiO7uj/5uR6aUqAviNUmkBq/Ckfsj/ingdCPJxbFAcR1JDUtQsMqMwcMu+tCoZIED3fh4dUlaOQuJPCeOXGPt0rpPWLor4ZivJejEvAvm9z4NbYUpweoz2rdb/e3OCMeox6XSlbPWNsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poIVs7n2L1VLigkcRovsBUY82NvF5gcSLil2yyfJYU0=;
 b=pMD8mEhz2Y/C7i+hyhvgRtTwZOC16lsLxVPZeHJTNPBcDRyRSsDm232CG4wMlG/Abmwwy6+iAh3aKchu9JTqaNzDOBNHcck3mKMsxFMPPhob2Y6j0sJX32usCXHUtUzewhnUotuu8sgjO+1wNZSz5aIq/uzefde8gxB1x09604U2zUH1F+fuO9q1c55TFjSDJt78hblqE4G1OXPWR4E1XHaA6BaSzPQqHDlo7PQhMsqNAENGQP87jsgEQZxyVY3iAIQ0Y1o7FSOZsS24V9UHL9r3N48iv/cXXn6yC7qn9y0Wg6ooyaxfQJUs7H7WedZvLoJYHZqD5xox2LZnTmcLgg==
Received: from OS0P286MB0211.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:aa::10)
 by TYCP286MB3116.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:293::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 01:57:09 +0000
Received: from OS0P286MB0211.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4ad8:84e6:805f:b95c]) by OS0P286MB0211.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4ad8:84e6:805f:b95c%9]) with mapi id 15.20.6043.023; Fri, 27 Jan 2023
 01:57:09 +0000
From:   Yangyang Hua <hyy_41@live.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: When using several ssh key, Git match ssh key by host, instead of
 hostname in ssh config file.
Thread-Topic: When using several ssh key, Git match ssh key by host, instead
 of hostname in ssh config file.
Thread-Index: AQHZMZFP2uywjTKQq0uXSEDuCS1VQ66w2kTEgACnlWc=
Date:   Fri, 27 Jan 2023 01:57:09 +0000
Message-ID: <OS0P286MB02117BE1F8660BA82064AC2491CC9@OS0P286MB0211.JPNP286.PROD.OUTLOOK.COM>
References: <OSYP286MB0215D880FA9D82B74E393DD691CF9@OSYP286MB0215.JPNP286.PROD.OUTLOOK.COM>
 <xmqqk019cmss.fsf@gitster.g>
In-Reply-To: <xmqqk019cmss.fsf@gitster.g>
Accept-Language: en-SG, en-US
Content-Language: en-SG
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [h79AXaR/FxgG5ymazoNMjor4v9kfZgAQ]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0P286MB0211:EE_|TYCP286MB3116:EE_
x-ms-office365-filtering-correlation-id: 0f9853b4-192a-46f3-50f3-08db0009cd0c
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SweaBv3QabkEW0IkxMqgY80332b6J0ywb5KVSpoNMSdEMD1jPcY57wdGQW8dGlU2y0Rz11gXsC9fiwySPb+VR0WGS0JLPi2piDsDRIKmkgkpC+kwmsmUwQX854nSOzjQwPaxeTa8sbbLEuRfNZOGOvD7gQ8Y9RT/QZzoIxFbzX0thhigcp34nNjuCRv5MUL76s204x/1LN1WaUNbW5oP02DjUoGY9PuD9BntwV7sAu+2j1tHP+YRqhgfql3/nVUnFfbA/e0WMICuYhDEtI6v86RrCWjE3uwjS4mhZyRiP8xyHcMEYE6WNBag/0urhAv6kYq06/FuJBwFUsRffuU2gGzpWkMcKgjWfEI9ChNTcM3ZkHrYYhVg643ranzYYKXXcjLXqMJqm0o+Ez1u8kcWybVxrJ2j2hN9tEj4KLbqr7SQaI/bI/eN0Vo0/PyqwMI7tCHXQ48etc1UWgHWOkIUZj0FTNYUSLNNNRgdzFh+K6ZcOWU5Sl6CFlNqWFgS0CxNKG5jCym7Lnj5KhSFSKeqfxc21QU0h/iB368tCBJjFlW1Dsy2AGqyF+HrXQejEN4GkJfWCCs4rC57v6Rg4scm9ZE7/4thTcl5VDjooy7o11YYBfJAhaPNBQTsxdEeowuSDjy0GF44VS0+8ZW4TX3DdiuT2Jtvpsn/SZgSrOI8A54=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SYNlXRvbCmDVDG4lsJ7vjUz4FXGvIu9BfUUQXVGaM+QnldhuH9w442rgkZPq?=
 =?us-ascii?Q?cdoYHgxO+hRKwgVQDl28Tm/Myy3ZljMHXUbqCs6CXfcYbdSpKfKeiwfXAKXX?=
 =?us-ascii?Q?PuZVHyqFgeMpLHvIXXNW2sJZVTegKuerVF7onOHdPqZfUECezJg2pInRMdTE?=
 =?us-ascii?Q?PRVkhr/pHl59zP64ZmPUMzWmAo1/XvbQyHRiV1rQl6f4EZqAy7rw0iwF4/or?=
 =?us-ascii?Q?mNiWxnzlviRyI8Dj+KpfOqXXYV5H5/ynj7tqpUy6dKQ6jigY9ANtrfxLngA6?=
 =?us-ascii?Q?1XyaR5TM9NeOtu/1I5esevIc+JIVYRPw3Sd4YwP4ryonES0EapGhMna2v91c?=
 =?us-ascii?Q?bWHCSSXVRgIzki57NLonQdowDELDesbkdB8aJl/QA8Ox3oQhOE7MOL9AMXse?=
 =?us-ascii?Q?HxF0huTZ++U6Eg7EvyTnnhrbY777z1vcDhLtMNGdoYQ2h9PPbH+s6O+sfvyq?=
 =?us-ascii?Q?M1VdITzWvFjtK7KPJJzXJdqtjsIHacye0Thp6du5+zx9ec8B909JcrLNglXR?=
 =?us-ascii?Q?X8C3UOxNwUUvliRWvqgUTC/80ntw/5hv8Yp08DRHb/PTaCJMyg5xAySPKSqG?=
 =?us-ascii?Q?6saXn5CMgpfcWr/p3vbvy6OgwZJlGXrjuo8HHwL3JUYTbLZ9ua4JBlVNDSUt?=
 =?us-ascii?Q?UE707bUQxQz6kdkl7J/5wiixax3dHEqmv4wrdjzsSN/ih+wuJ7kzXj/slqA4?=
 =?us-ascii?Q?hEVb+88VWg60VZhHwpoPZh532jDFbDMXygPnOkvt6qZlqHMQcbjHfkVkpdB7?=
 =?us-ascii?Q?pfqIdPNDRIRsidAsykpYma/Ge+B8l02xu9dFpHO4qZCwmXa3ygJrZSzILqs7?=
 =?us-ascii?Q?IjpW6eFcHvPVXOuWBflM1VdRqkYelNrg1kNDYNrjJW8/zfGc63gQWHf8WXfJ?=
 =?us-ascii?Q?Tq5y6CojTPvRqXEFmxF9vAuBzmmdjAJ9znBxh/IlFNN9od19d1wRQiNO3MrL?=
 =?us-ascii?Q?tSJ0FTti9yD8UyNmo5fPpK9NT5NiB5P5OK6/sX8znMYtW4JmmYDeyWERrdg5?=
 =?us-ascii?Q?O8UQjTtljn737QtGN6KTeFMKuc1GZsD200JDyJHU7V/tahVo/JmYw/aafvvk?=
 =?us-ascii?Q?gL+JOqc+PbzCFG6IEJyRAB32SjsEGlmByf67AMinFlHPvnCIF481cJlwjsNE?=
 =?us-ascii?Q?ybFeFVle8rtKUIpENIOnsQFPpKXN3SZQocsGM6LbfsPxzcAedhOA0+PLtEIV?=
 =?us-ascii?Q?o/3S8aIJdxPOmn3i61NyYF+Pos+idseLNylca4oA0X1O4pSbZZwYgqRvzPNm?=
 =?us-ascii?Q?2iFxcoclgFkibrUGg9zC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0P286MB0211.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9853b4-192a-46f3-50f3-08db0009cd0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2023 01:57:09.7430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3116
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you!
I understand this feature of ssh.

________________________________________
From: Junio C Hamano <jch2355@gmail.com> on behalf of Junio C Hamano <gitst=
er@pobox.com>
Sent: Friday, 27 January 2023 12:56 am
To: Yangyang Hua
Cc: git@vger.kernel.org
Subject: Re: When using several ssh key, Git match ssh key by host, instead=
 of hostname in ssh config file.

Yangyang Hua <hyy_41@live.com> writes:

> Hi, I find when I use several ssh keys with the right config file
> and clone my private repo, git can't match the key by hostname.
> ...
> I think when git read ssh config, it uses host to match the key
> instead of hostname. Is this bug?

This useful feature is given by ssh, and Git does not deserve credit
for it.  The config file of SSH allows you to write multiple entries
that points at the same host, e.g.

    Host host1
      HostName host.example.com
      IdentityFile ~/.ssh/id_rsa_111

    Host host2
      HostName host.example.com
      IdentityFile ~/.ssh/id_rsa_222

so that you can specify which key to use for the same destination
when you have more than one user there. "ssh host1" uses id_rsa_111
while "ssh host2" uses the other one, both connections going to the
same destination host.

If host.example.com were a hosting site like github.com, you can use this
feature to say

    $ git push git@host1:/me/lesson1

to connect using id_rsa_111.  If you use

    $ git clone git@github.com:/me/lesson1

there is no clue which of the two entries you want to use.
