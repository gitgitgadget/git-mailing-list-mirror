Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C48FC43381
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 10:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1531764E92
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 10:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhBLKNZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 05:13:25 -0500
Received: from mail-eopbgr130097.outbound.protection.outlook.com ([40.107.13.97]:37764
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230272AbhBLKNS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 05:13:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isuMCVHT0xgfhl588xhaWKb3sqGKixmzIAu+bJcwv6J9xABW8dmhqEZdEMuEbzYpqB/nV/sAM6+fQSIub0OMuehz7CIFT127aGxIz4Nfj1QiYk5W6mWb+ANM00gLPRcahZVOx+YUvhVPXepKmLzJOd1b1GpXGFPpXfdA7nULPiaAVLQyyfosQ/L5hbFt6cyP/3ZcQJkSu8zYn0Gccc9LyAuG7dyORaTsNNaotD5GnBeKyAVXbsnQyFDHUlO6eQGIjYq/DltWHOPLRSnPMLq+JAaGvudeJ6gkvnSQjgHzkYzPZvcP+1oYe3o2a20JHuXoQJJajXiqJ8OZoe2XM0poOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krfdVNbIrxkpP53R6fuViwi9tgQ1gPFLnCF+dVIlIZE=;
 b=EJ5zxz/+BZiKI6a6hJ2oLf4JCseM0gh7K3TmPPUj18y+Q69+a0V7RvL1h1KUNnB8sP5/YeYRrDRhCibZoT6ifwbZYrVPmERoDnPKUpKEcl+Se4mjOtNAagcTqUhA405vFptXWpc94a2vDMgoI15iJYRMsnA/cgzQD5AKKQ/Z4Q4B07SzNahjR8f6x8f/L8VR3Ddr4ELIm7Ufj11uXiizvlOQXlkMe4RIvp3dW3jx8S//Yxc5M92MuNnPV7ZULTvQPHdmjRfCAxfQ+L+AayY63w8bArTZihuiP8aeBJcBhjJlXyDcJ/KzGTnkAL4z+Jz/jgGk5ryaASgMU7qCIVWc3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krfdVNbIrxkpP53R6fuViwi9tgQ1gPFLnCF+dVIlIZE=;
 b=iAgk0nAcDWoLRZso+vKljyeFgbT6aejkElGP5A3o3tLvIe+W/YPmoelyEjZVEu8rxVHEvz7vLMzkDpfALP7AbQjxaOBtEONND39Cm9WgNU8JpI3GRHbEMOzTrxx+MserHdGqMNGuk/G4XxoaTJsKoaS5NIN5z8lZMbBIxSo70Nc=
Received: from (2603:10a6:20b:1bd::8) by
 AM6PR83MB0231.EURPRD83.prod.outlook.com (2603:10a6:209:69::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.2; Fri, 12 Feb 2021 10:12:28 +0000
Received: from AM7PR83MB0434.EURPRD83.prod.outlook.com
 ([fe80::9419:d8c5:480e:4789]) by AM7PR83MB0434.EURPRD83.prod.outlook.com
 ([fe80::9419:d8c5:480e:4789%6]) with mapi id 15.20.3846.004; Fri, 12 Feb 2021
 10:12:28 +0000
From:   Rene Schumacher <Rene.Schumacher@microsoft.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Git Commit Signature Encoding
Thread-Topic: Git Commit Signature Encoding
Thread-Index: Adbz7Oh9PSrPF9WVQ4qtX5G7B9S16AAAkSXAAAn7gYAAHfmzMAKAnREAAKV5mGA=
Date:   Fri, 12 Feb 2021 10:12:28 +0000
Message-ID: <AM7PR83MB043401AAFD7377B99CA1BF97EE8B9@AM7PR83MB0434.EURPRD83.prod.outlook.com>
References: <AM7PR83MB0434B67B0F15E4433347D555EEBC9@AM7PR83MB0434.EURPRD83.prod.outlook.com>
 <AM7PR83MB04349E882710B0EC0E186A09EEBC9@AM7PR83MB0434.EURPRD83.prod.outlook.com>
 <328de960-ac67-e313-ecc3-b5b505e42bea@gmail.com>
 <AM7PR83MB04346479474921F3DC0688CFEEBB9@AM7PR83MB0434.EURPRD83.prod.outlook.com>
 <962853bc-9e60-968f-c64d-35757f72e8d1@gmail.com>
In-Reply-To: <962853bc-9e60-968f-c64d-35757f72e8d1@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=af899022-ec31-4d21-8132-e29f72659cf5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-12T10:10:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2a0a:a543:d741:0:a0e5:595d:fa63:db5a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c0b379aa-7ae6-4b07-a9e1-08d8cf3eb403
x-ms-traffictypediagnostic: AM6PR83MB0231:
x-microsoft-antispam-prvs: <AM6PR83MB02318F4C1B82A89246642F17EE8B9@AM6PR83MB0231.EURPRD83.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lXH8Xe9UmegCugd2+cYYJdKCke5CN/DN4u46JvKkWLd5vgwQ7KrvztwOGfarprrWVcQvACVBEovEvC9abaQstA0J3OfLM9VHn2QKdm5stPCBZxBUH/fArfTdlHMLe5HODDySbsIxbHoLkk7N9kmaTJjGW48p2eGM656QCXws2jiQhAHb3GDZphNBs/KOaKrNr4mr+3bPe4mHAE0k0PNPMrG8n+0b/+znCbA4XnM2+UcOF1fkEPeygo22UW6hqOmILdRMid3/DFstn3mbmfy5XFz0h3sowanXjGNcVvT/cp4VvZYk10APBnZGkpnUhM0r6m42YOeGCifpKR22Ffnz6L/uzRNAsHNfSK4+SILtFJqAmzh3CTw0Pee4lU8Oxcbv9f23De6VZesD6BsENhDzf9NOo4k1ISGRH6foAOAyONJntLQPhjB8TS5COuMzaPHswDEFJT6FUhPLvXhEdKIAomuxYeUx9ioTcM6QNCdRNKmxwDQmKjGtQKMkf5vOSN0RQHvfz5t+8yRUUfK29OrBBw5dPzKcgqs8tivpVCX6nydPhE8aqUJCoQiEjn9UQWxauK9sqiCsdfyJS8uZuSQA5BV1xRlpbqNL5MebvG2/yeo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR83MB0434.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(76116006)(7696005)(52536014)(8990500004)(66446008)(10290500003)(316002)(186003)(33656002)(478600001)(110136005)(82950400001)(3480700007)(5660300002)(966005)(66574015)(55016002)(82960400001)(71200400001)(2906002)(66556008)(66946007)(64756008)(9686003)(66476007)(86362001)(8936002)(8676002)(83380400001)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?gSm//dwpFcJrRhi1JMg0040ys8yMsZWhFcLfs33cWVa9/KE7CW0GybMWPA?=
 =?iso-8859-1?Q?MFYQ+9NDUwxi90Be3vZrm3wEHT6eCAKZbhv41GnWqLjuRkcqv7+TMdvkpO?=
 =?iso-8859-1?Q?radimlCP66WWjMu1A3sPltOns/L5D9AEI7zgBS7gly1L7Dr+INKUV3ZAB2?=
 =?iso-8859-1?Q?5Ak8z+pf/pI8JdQB4F8Dx9hkHgY8wmUWPezgXwSuKEPYeSDldFNhZTgekE?=
 =?iso-8859-1?Q?FUCXSz2opWtLdN1T0pIqruqExojq/0HgLmIdQCRu1IxzKlvFdlh0fu+8kP?=
 =?iso-8859-1?Q?znz8eF6G2gNyoot/76aCtMFYojlO2M87DXGMxE0qYYp0DnUAi+EtPubcrm?=
 =?iso-8859-1?Q?kUbSU3nmQ9s1LXsbIG1BJVuWmTsHerrIsE0k3nCmgSPukSJCDQ0SKsp5L0?=
 =?iso-8859-1?Q?dntd9rNl16XRpfnf9A+Yh0p44yaoZsNoF/P45wT2L0SRkYZQlnq7DpLHRR?=
 =?iso-8859-1?Q?yHwZauVI1MIdBnozGzxJK/FkWuLIaOPxjFVsID7ynUubV2La+lG7U8DZ/H?=
 =?iso-8859-1?Q?WfiO5cTFQuH0s1PyBpBqgFhTt0cO1spjJZ5zCUeaK7sy6frHqaKXX++zM2?=
 =?iso-8859-1?Q?rqZWc+uJ5GlmVVHhhhu4yXdO+VEJ0L3LAoc0lUukTlUnHKKVVY7ccxJcFJ?=
 =?iso-8859-1?Q?YzS8YKBxCJ9gS9MYQpXeD/1GoKujBkDjO/QF+PzbJWBROKu3IcCtqfa7TX?=
 =?iso-8859-1?Q?moXU5u/2pDedE1TloEBJVExekBRu8K188A8Fbut4M1iHt5gemv+2wnapPm?=
 =?iso-8859-1?Q?5rut+aSChSSNLqraxMeCViUuhmHc+GiNRTU8nTvhHBnWEX3f6y38GcaWk7?=
 =?iso-8859-1?Q?3Rw46R0fMhdcWP06dPuQdRtodLA2oJ1ORk3uKoJP23qTNHmqixZwIgzfuC?=
 =?iso-8859-1?Q?P/n6GGQBbWcXEPSEaTg2KXvgZwxeWzC4N1ToF4mSsBITgMRIliwvVV8G9Z?=
 =?iso-8859-1?Q?I1tKNuz+8WE4H5iKfBc/t5370Zqb/3KZvj8aIs1tgwLuNVnBWUJ7/nSB77?=
 =?iso-8859-1?Q?YBfEnLYV726I+MuFYWbPGwmS5gdE8Vz6C4vJqPMvOARlBImz33xbmo0Pqj?=
 =?iso-8859-1?Q?vtridDeDgyWcSdOuUzvOLQlUN3syAjdtATrUKjv4Q44ZeH8kcWF3KNlwkz?=
 =?iso-8859-1?Q?b89I9tG60jOUpgfo9MmpRi9rg4C+hND3MlESCa4jm+Cld/ah6t6btTzCMT?=
 =?iso-8859-1?Q?gIA4Xw/nNf+/Tnch0X2inoQF+8+B27XrouDWOQ4nPFqH+xRAKyeJPVsh/c?=
 =?iso-8859-1?Q?44oVjAipHOl1v1kWmfDKL6ifMhB2QrmV7pTBkPs/+eyS6G7BlPI1DY/xH+?=
 =?iso-8859-1?Q?A7gWA/Vw0mwDs1+ZZPlkS2dDnln3X0rdpJwcQ4xTt4dak+BTbXVIqB0jID?=
 =?iso-8859-1?Q?pWQYhQ5hNYFCx+sMTMYIRQ+osW/AeC+tqPDBcNwRkbtmAxVY08jllRiOKO?=
 =?iso-8859-1?Q?dPL8CsTMJQ13JH6r?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR83MB0434.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b379aa-7ae6-4b07-a9e1-08d8cf3eb403
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2021 10:12:28.6373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jVdGsShKszh3iuZ2RlZOemq/58jOcLVxISnI5l1NkdwYhw0UBSpid45QnTKdH+BsryADHPfydcREfysouz+22w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR83MB0231
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,

thank you for the feedback. Perhaps the reason really is the gpg4win instal=
lation. I'll put together all steps I followed to set up my environment and=
 create an issue on GitHub. Thanks for pointing me to the correct repo!

Cheers,
Ren=E9

-----Original Message-----
From: Philippe Blain <levraiphilippeblain@gmail.com>=20
Sent: Dienstag, 9. Februar 2021 04:13
To: Rene Schumacher <Rene.Schumacher@microsoft.com>; git@vger.kernel.org
Subject: Re: Git Commit Signature Encoding

Hi Ren=E9,

Le 2021-01-27 =E0 04:41, Rene Schumacher a =E9crit=A0:
> Hi Philippe,
>=20
> thanks for getting back to me so quickly! And sorry for not providing all=
 the details right away.
>=20
> I'm using Git 2.30.0.windows.1 (I believe that's the latest), gpg 2.2.27 =
(installed via gpg4win 3.1.15), and PowerShell 7.1.1. You might have seen m=
y second email to the list in which I described that setting the OutputEnco=
ding in PowerShell to UTF-8 fixed at least the display of the =E9 (and prob=
ably all other umlauts and special printable characters). The signature out=
put from git show --show-signatur is still printing the ^M carriage return =
character at the end of each line:
>=20
> commit 69022a47744fcb3801572ac5d14295bcab274295 (HEAD -> master)
> gpg: Signature made 26.01.2021 17:55:36 W. Europe Standard Time^M
> gpg:                using RSA key 3848D5B2A3D45419D7F564F97802B995CDB4A2E=
F^M
> gpg: Good signature from "Ren=E9 Schumacher <rene.schumacher@microsoft.co=
m>" [ultimate]^M
> gpg:                 aka "Ren=E9 Schumacher <reneschu@microsoft.com>" [ul=
timate]^M
> Author: Ren=E9 Schumacher <reneschu@microsoft.com>
> Date:   Tue Jan 26 17:55:36 2021 +0100
>=20
>      another commit with signature
>=20
> diff --git a/file1.txt b/file1.txt
> index a7f8d9e..6ddadea 100644
> --- a/file1.txt
> +++ b/file1.txt
> @@ -1 +1,2 @@
>   bla
> +blub
>=20
> Since git verify-commit does not have those carriage return characters, I=
'm still wondering where they might come from.
>=20
> Cheers,
> Ren=E9


I've tried to replicate with 2.30.0.windows.2 and gpg 2.2.27 (that comes wi=
th Git-for-Windows), and could not, neither in Git Bash, Cmd, Windows Power=
shell or Powershell Core 7.1.1.

Maybe if you can provide a complete reproducer with all needed steps (git i=
nit, gpg --gen-key, etc) you would get more help in the Git-for-Windows iss=
ue tracker:
https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.=
com%2Fgit-for-windows%2Fgit%2Fissues&amp;data=3D04%7C01%7CRene.Schumacher%4=
0microsoft.com%7C914d70147a1945878c8208d8cca89a3d%7C72f988bf86f141af91ab2d7=
cd011db47%7C1%7C0%7C637484371825641164%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w=
LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D9=
LgP1MLTk6s7ON4bXbS1rgSvxYKw3yytBP7D4P430oU%3D&amp;reserved=3D0

Cheers,
Philippe.

