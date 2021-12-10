Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9892BC433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 10:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbhLJKle (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 05:41:34 -0500
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:18113
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229619AbhLJKld (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 05:41:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3OrJQTKc7e4bvrObX2EMDNKZ8Wg0ev9BweGJnDfQKWL9ikdiSa9Z8fdOp9ryb5eod+ZgmrJaNyqwkVwCX21FMNFYIVyccyg24wBAXeOs880a5yycMpx9rtZMsc8wCxp9C0rL+PetEnuYWIIR1k5DQa7dBfDW+OzSQ1FDneytzE/IVqOoUM45vkQd4HZZHxxDLWpPKFMIW37UjF+XpHdXKSiBKwH6w5bspS/jiECIH7DHIa+TpkOUnJfKBWtYYrJjBJKKuAXpPwqxnzHY/umUpuIkCBMNIcnilTv4OnPOt9J/rcWjLFDLaeY+jDiB4pLzMhRJzf49L5wEEikD7lH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMyVStMwjimKY0kLkmak9h/JExZtPaY2koY2CvcxqWc=;
 b=MDIq3SaoEJ4wqrco1ubW+tSKcRjTudoXXqx2roLokZU7hp0yQWZeO8SXZ2/pkRwPLEEJ8zeIXf/AqVt707+7Kb9SErtrESQyqpmvOf60MBaVO3k/uQWVILUKObQq/7CbvS+YzRfYbnE4msIJTiLYafF991nTJQQkkDq7aPZHYL/XlvwXA3X0kO66+W+lyl60I6AMy2DNswHcQYoTRk+z60qo49td/y4LvKNWwHKQtgrzgBg9O8su6sm6u79cQN9ZI60/JO43b3gqa288StVhkhYIJ6/c/6clOv8oBq6yiwcGRJnjfnWZHiWvbhrcwTASZP+cVfb/r1ITAjVb7bhQbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMyVStMwjimKY0kLkmak9h/JExZtPaY2koY2CvcxqWc=;
 b=SxDPCzkXtA5VYdQ/gbOBOjOKpYnIbRaSx5ZpDydFdKw5co++kYgPA36oMQlm1kIY24OcZcIq4/sNzIZW4MlxW2YPptTpNzGdza3vm0SqB3P1GQXUN5ZMV+/k77lbo67VA07RzXeMjFDzLnT4gEqiF36OwBqNNcnZXEFHsRQUfAGnKMW6CDPRK051ewVj5uU9lonTpj9PtxoYrZtE1deB3wdYbmHqlHCGc2EFUWQSvIdlQdqKQP8rUDU7Xr5/jmoOtiFzAUOYij0JZdOh0E3XOK7SS3pWlVOcBiKAyRTRVtRLnpRZbi8hsTFX1OfpMOu3AZPG3yzJgFp3cOKRnuHc9g==
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR12MB1315.namprd12.prod.outlook.com (2603:10b6:404:1f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Fri, 10 Dec
 2021 10:37:57 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4755.025; Fri, 10 Dec 2021
 10:37:57 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Subject: RE: [PATCH 0/6] Transition git-p4.py to support Python 3 only
Thread-Topic: [PATCH 0/6] Transition git-p4.py to support Python 3 only
Thread-Index: AQHX7TjcBdyuTAN1MEKv4eIoPWSSjawq5NKAgACXQiA=
Date:   Fri, 10 Dec 2021 10:37:56 +0000
Message-ID: <BN8PR12MB3361388476E57E097DEBF9F7C8719@BN8PR12MB3361.namprd12.prod.outlook.com>
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
 <211210.86r1ale0o0.gmgdl@evledraar.gmail.com>
In-Reply-To: <211210.86r1ale0o0.gmgdl@evledraar.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edf2395a-2f0a-451e-59f1-08d9bbc92148
x-ms-traffictypediagnostic: BN6PR12MB1315:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1315272C62BFF5CBA91F4BD6C8719@BN6PR12MB1315.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6syPuwWomGFrE5XSrs3vGrN+LyeVq8ATQeGzjrV85yPCFcwPIBiBHjEO/JByoWtBj+FDD3cZ6IbD+damIazQaB+xpuEhTQratpxy64tif9Tx2lCyjTa8FfghPPbyxzvhjo0n+qCwfS0gtGoLcYZTxb8QWMP+kluUbB8sbOcoZ6GjApuH3WbkPJx85sohMy2lAwvWeQJfVNbtYnOvdFUuCXceAg4nRQ/h62qrf9cetaBbUX0dnOM04xwkhvrlGa4qP+Y4N+9gNghdjpwy0n+Lh3mrIU2MilwxNAApyMRIwpeS8XdOu2sS7JXUldCdm4z73BnXOj8kKBH7vDveSlPZ9woV10n5qcUSiGA3pkx4IHPQt1ExAMgHR/pJ2JjUqdLojmEKozqBX/o4pqSY17gXu/wg4ruuyQ2Fok3md1eDw6eA/mLhC62V+XBaNl1lfzxGrau8JkSMg3Ejz13iPqjV1IBo6Zz1Q3DwLQnUOeA9p28DbFCXQlQ2XYhwptuUVD0kn/M8wkXX5FS/jGkahnV3ezvjh28RULCpkeSwIkjgpfVEp5Ypemtw6D9gbuxKYGIJnygyaI/BINZ4irkZ2JXdPNhFoV7oExhgNqxgfP1wkptI1XaHlR5IcXg3Wwumfujvy3qfPxNZg1qmRsoxttUsiHI1i//IYYIrmDTpwewy/XXuE0bBXRsmbzOT/Vi0cTYkFe3lyVo2dmxn4V1LKK6KZ8WrWCUVKWP4JR5wtEr+8h1dwvbRvplkVWIFWmVce76W1D3UOzvsHuCby2kpb0KxLftIfxeni2aIznT0krpo9sStW4BA+0ap+okjQi1mNbd/Z8dAd3nocJ6qQjCruS4todDqPipp70RvyVNUHPes7qs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(86362001)(66946007)(76116006)(66556008)(66476007)(64756008)(66446008)(6916009)(52536014)(33656002)(71200400001)(122000001)(55016003)(83380400001)(38070700005)(316002)(9686003)(54906003)(7696005)(5660300002)(966005)(508600001)(186003)(38100700002)(26005)(55236004)(8936002)(4326008)(8676002)(6506007)(382644003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1v1dXjI/NqZfJhaaZ9v107c9+eFNhzOCcOuHkA0GZkgs7VsbHc2dqByW57?=
 =?iso-8859-1?Q?L5yhi/CWLQtPXLleQFPkOm50Wv0jxha1jwx1DQ31+uvCovKMJ3NJYV0fP6?=
 =?iso-8859-1?Q?Xw1UT8lqMSbtvCOiR6z7X7uyMerOqgHreLBXn4WNRyMGY/kFJLX19DCiGy?=
 =?iso-8859-1?Q?+lR3ydmr/nxwpu+GZ1ct5IT6OCth5vfkMfuW4oyTxoH0V1G6E8u4IFt+AR?=
 =?iso-8859-1?Q?N63MKEGVIuMOO9p28YARfk8PZ04Nl8g2hDSNgX3IAd/IQRiujk5mi9xiTs?=
 =?iso-8859-1?Q?AlisNRyaoKmeXgV8PIdxT4s72eV84aM+6s7IrGjBa7cIL6+soTwGTIDqto?=
 =?iso-8859-1?Q?Kbuett1eq8+ISFJgm83OzQo27dD5Tqtr7iDfHKPK9BftO5q8uSU39E6BV1?=
 =?iso-8859-1?Q?8mWB9EgGw/HgmFzxJf9sYxW1AM4Dm7ZSm/5TvKjSSGutt8bdTsa4fPOyr5?=
 =?iso-8859-1?Q?zNFkKvhAErMxqsfE6zLvDYtEUTJ0Az824Dom2sfs1ppXCJyy/XbRXh4Yqy?=
 =?iso-8859-1?Q?ZV6n24fucSoRCn0jTr6POln+oKC4Zay4qXDqNf3tB4gaKZfDeab5B4Nnsc?=
 =?iso-8859-1?Q?WZmHM44peyPTPiCJl4ND1IdH+bvdcOzG49K/G9b7CbLPIeizM4rrcmD0tw?=
 =?iso-8859-1?Q?CVnc2W7Lj9P/tvDS0Ce7td9FEWfvWXKyXFRZr1aEXKHfcWFS99f7JJIFfI?=
 =?iso-8859-1?Q?6ALMejL+vIX1pCeAAJSQNJUxXu7NL5ysbsHFdqEeeKgv8ztC2ucmKu3asP?=
 =?iso-8859-1?Q?cM4aIZU5JNsyH4naQraUp5hKNZ5iJBN1eYxS2FFJyRU3w9JOSlo+BxVHF7?=
 =?iso-8859-1?Q?wC0shum4MA+gsWpUTpPaunPS46G8mClBwdo4Ve2Z+mHhwYQF3YVT/cb6t6?=
 =?iso-8859-1?Q?vDOJXUBjZT0z5luqsAjNn9OHErYwJysNCYEvQnp2sUMaNlNZxggfqHy8Jr?=
 =?iso-8859-1?Q?ttl/t4LpmseG4QKnnEuUwIM+3vUDm/WnN1PBjdgdrvYajYnMvGKPDl27Qw?=
 =?iso-8859-1?Q?OD4BCb9q0PKkIJ9C+gEj472gVTWSkOgHLezzexg300+qrJ8T7JseUSgXne?=
 =?iso-8859-1?Q?RIzQHgQhTJ1aNw8wx3gSvDUX1ZJjdv46AJnfTlASdzuKErP2Bc4dUQXyQ2?=
 =?iso-8859-1?Q?/QQuG5If/vf6+nGHo1I8FbL3loxKEvol4vjSrkPdzkPFUW5vB9Jxdob/1p?=
 =?iso-8859-1?Q?zHk/Ff2fomq+A4L7B4CUjyQa+V6F4zBtuoO8E8UG4d6kF1NJItqC+b5Zuv?=
 =?iso-8859-1?Q?0dZoM9RoYqidth1/uJGj0vxYzl2lbGcsNlf1v6MNt7jiE/2+yVTC9W5DCS?=
 =?iso-8859-1?Q?J0uuoC6BtxA3t1mZfHRvJ0+QnqnutChmuI4dLRMYTsTKvKKfYHfLfjmUkE?=
 =?iso-8859-1?Q?1boU6D5DMcN3XJIjibxVQhlxwhbdmVkK10ZOe2D7VRANgLauuzT/zfTTqM?=
 =?iso-8859-1?Q?WLpfKPSA/NB7wfeZyyMnC+GFU7L5DJeVez3XrB+VepDul+vQpCxvBWJPJr?=
 =?iso-8859-1?Q?6rfLppvkon+3UmcKsZ61c77rijxPOFG964qETiBHIgy4kYcJb/cRVsdYJW?=
 =?iso-8859-1?Q?S0z3EwLcJFgXBc0VBQ7DG3JlWLXs420zbbAC4krdHlKQx5qaYPO2eQjR52?=
 =?iso-8859-1?Q?NJooYNbrgS6NyEGH9mnxHoV2mQVJd4bD8Hx0Vg5DQ/89pMtGMuJGsUfyPW?=
 =?iso-8859-1?Q?W6FnTqwKYHIXEjo+cxs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf2395a-2f0a-451e-59f1-08d9bbc92148
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 10:37:57.0096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ypa4Uskk19qSC6N2CyGdWm5lQ0yBXWWn0KlUk+Tu0shVyeShExzZ9gFZ0PD+6xGuKARZKi58wvQ2o6ho7SR7Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1315
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The commit messages could just really use some extra hand-holding and
> explanation, and a clear split-out of things related to the version bump =
v.s.
> things not needed for that, or unrelated refactorings.

Yes, I am getting this message loud and clear. I will resubmit with more de=
tailed commit messages today.

To explain the story here: I started using git-p4 as part of my work-flow, =
and I expect to need it for several years to come. As I began to use it, I =
found that a series of bugs - mostly related to character encoding. In fixi=
ng these, I found that some of the troubles were specific to Python 3 - or =
rather Python 2's less strict approach to distinguishing between byte seque=
nces and textual strings allowed the script to proceed Python 2 even though=
 what it was doing was in fact invalid, and was potentially corrupting data=
.

A common problem that users are encountering is that the script attempts to=
 decode incoming textual byte-streams into UTF-8 strings. On Python 3 this =
fails with an exception if the data contains invalid UTF-8 codes. For text =
files created in Windows, CP1252 Smart Quote characters: 0x93 and 0x94 are =
seen fairly frequently. These codes are invalid in UTF-8, so if the script =
encounters any file or file name containing them, it will fail with an exce=
ption.

Tzadik Vanderhoof submitted a patch attempting to fix some of these issues =
in April 2021:
https://lore.kernel.org/git/20210429073905.837-1-tzadik.vanderhoof@gmail.co=
m/

My two comments about this patch are that 1. It doesn't fix my issue, and 2=
. Even with the proposed fallbackEncoding option it still leaves git-p4 bro=
ken by default.

A fallbackEncoding option may still be necessary, but I found that most of =
the issues I encountered could be side-stepped by simply avoiding decoding =
incoming data into UTF-8 in the first place.

Keeping a clean separation between encoded and decoded text is much easier =
to do in Python 3. If Python 2 support must be maintained, this will requir=
e careful testing of separate code-paths both platforms which I don't regar=
d as reasonable given that Python 2 is thoroughly deprecated. Therefore, th=
is first patch-set focusses primarily on removing Python 2 support.

Furthermore, because I expect to be using git-p4 in my daily work-flow for =
some time to come, I am interested in investing some effort into improving =
it. There are bugs, unreliable behaviour, user-hostile behaviour, as well a=
s code that would benefit from clean-up and modernisation. In submitting th=
ese patches, I am trying to get a read on to what extent such efforts would=
 be accepted by the Git maintainers.=20

Is it preferable that patch-sets have a tight focus on a single topic? I am=
 already dividing up my full patch collection. I can divide it further if r=
equested. I am happy to do this, I was just worried that it just might make=
 longer to get all my patches through review.


> Some of these changes also just seem to be entirely unrelated refactoring=
s,
> e.g. 6/6 where you're changing a multi-line commented regexp into
> something that's a dense one-liner. Does Python 3 not support the
> equivalent of Perl's /x, or is something else going on here?

I will improve the commit message to explain the changes being made here.

The regexp is matching RCS keywords: https://www.perforce.com/manuals/p4gui=
de/Content/P4Guide/filetypes.rcs.html - $File$, $Author$, $Author$ etc., a =
very simple match. We could keep it multi-line, though this seems overkill =
to me.

The main significance of this change that previously git-p4 would compile o=
ne of these two regexes for every single file processed. This patch just pr=
e-compiles the two regexes (now binary regexes, not utf-8 regexes) at the s=
tart of the script.
=20
