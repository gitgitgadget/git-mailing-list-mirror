Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE58EB64D7
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 12:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjFWMoA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 08:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjFWMn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 08:43:58 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2119.outbound.protection.outlook.com [40.107.104.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD44273A
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 05:43:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FofESTaNZNPA7GnSFHhsfYd8XQq92ewFoNkwoCNPKN6t0fuqu23eIziwtgLmL6iYXRK40wb3ft/n3iVeu5WSqIYBTnIffm6DGgGYYzswSK/7JVtPo+VFESQIxeP9NNdy3+6PwfHI3YGN5KADbhH+xmr3KJkgA54xkTvPQMsQlj8W7Rum6XJhQdeKxAs5ov5N7nhrcRW2ST1u9rexwahabpI35sM3/yPZwNbFfVwjhQupYf6D/dRoAOUKDwoSd2I1QYEm6wPrwUP4G1r3i5Yob/CcxtKwWz4ANjOTAp8J9Op4zEIiVT6xwB/LqNEav9XgFP3TkzkmdUmJ0ILVVgSuYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5Mw+z3kfp212kHuWOe5/g/AK2ruOVuRYn+LxMTRXhI=;
 b=i22YPI9Wm35vsaxwaQsGzD+2MQ7KzcCQq7Guk2329vBT1+fxFviJjqpO7XEZKPe49fMINv44b0yM9W0WeATjFZCgyrPTQAwGArn5B8zSecFLWT68MAZoZqW73voXcprAnz5SR6GNxBRRdNH80zvx8KTNLMgUGVJpGFGm0sdiElGJin4cpMjDFS3lNzrSwgHwHQwULPHsJv4So+J/RBxP/9YlZxomVXgy/L/c43k/FtKeBqylTXg3cI4IPMU1kZr3KsANPg12b8vqJ6w7PQn3Yy3Axwt8aIZ6rboncGC5VlzkRpgb5+cpyb3gOHzEi1XAwsUqRCVtrVYRmi5VU3Pi2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5Mw+z3kfp212kHuWOe5/g/AK2ruOVuRYn+LxMTRXhI=;
 b=ctz664yU9qWvb+IxYVyNVaLafMnyZsXQEJ+YozJ47ZzFniVLUDhnXJybceJX4FSeDa59B6mXb4S7mSSSCEIP5kV45Ixm5ENLxnqGLYUfYUFLzMGtSl33Qv+h+rxf5hBmqgaYoFaJ8gENyiZfJJyTcWhnD75Gsh4EiuLEF8uLMSQ=
Received: from AM7PR83MB0418.EURPRD83.prod.outlook.com (2603:10a6:20b:1be::11)
 by AM7PR83MB0468.EURPRD83.prod.outlook.com (2603:10a6:20b:1b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.5; Fri, 23 Jun
 2023 12:42:34 +0000
Received: from AM7PR83MB0418.EURPRD83.prod.outlook.com
 ([fe80::37fe:4e6:d28d:fa51]) by AM7PR83MB0418.EURPRD83.prod.outlook.com
 ([fe80::37fe:4e6:d28d:fa51%3]) with mapi id 15.20.6544.006; Fri, 23 Jun 2023
 12:42:33 +0000
From:   Premek Vysoky <Premek.Vysoky@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git apply fails with 'error: git apply: failed to read: No such file
 or directory'
Thread-Topic: git apply fails with 'error: git apply: failed to read: No such
 file or directory'
Thread-Index: Adml0C0BoV7g9ueIRD6rtF+KvPKsBA==
Date:   Fri, 23 Jun 2023 12:42:33 +0000
Message-ID: <AM7PR83MB04183860D4E70F935319E9B9EA23A@AM7PR83MB0418.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=65964f8d-8a1b-4cc7-a665-86ee90347e85;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-23T12:39:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR83MB0418:EE_|AM7PR83MB0468:EE_
x-ms-office365-filtering-correlation-id: e2e81495-dc90-41b8-29d9-08db73e7511c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EwPlqLvPi3TSWtdvcZFerBQWn7WUbKEETMvH50z0Dz1Y3sbOTBPPfzCTkaaIqrJu91h2KQRgCyEffCPMNFVwPflEs8aWb8AJvoq3GJH6CgsbTFNS6OQzAsssGspPxi1pFatGBOrCNbBNu/HB39wAeCUe3I+qpU/MK40GZ0ORh6Xn5CDmsLapNRfsAnyUUel0lS7LArBoo6gLMa484ykvhyUxXaa2hcnMkyqAJSo2mnQVA6hg2o8pPGPlulvRyC2CaEVdfq4ISGg9dF4A88ZkNLGLP2hMgauamp4YSf92S39KjH91IRcH04bKZH7z8no4Ay8Wx09k1jWSUU4sqpFvAKF3a6IFkOBb2x/96cMS7L5kBXw31zYreQa1Kg/rTpsZaaaVL8I0nCokcwuVuR5yZdhozYcdwVgKQhVGQF5AVhN/bqAXBx017e8MofPDNhXkt3FPR9fOBdj6qabREK8X/uOcq1oHT9OQCvac+TiL04mP1hyX4gLCZ1sn1Xjg/3uhkKi1Ndb6de/NQVTm+wUEYcxMc+95zGEJP4djvOvbPmJWK2B6gLU2TEQvv0+6733LLdd1zL8oUqmc1wVQnakDSCzkDq2++FRKgoc/WqDnjiYyie9odCDjIxoH8DF/7jqTOcvPEAVu2V6z+7/hRfAkKJHF8uOXSiSgq2Uhg1yEKVDzSjH71wuFITPYH0xM6qG3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR83MB0418.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199021)(186003)(966005)(71200400001)(7696005)(9686003)(86362001)(6506007)(10290500003)(478600001)(38100700002)(82960400001)(122000001)(316002)(83380400001)(82950400001)(66946007)(66476007)(6916009)(76116006)(66556008)(64756008)(66446008)(41300700001)(5660300002)(38070700005)(2906002)(8990500004)(55016003)(52536014)(8936002)(8676002)(33656002)(460985005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fgxA2zDSR7DUM5C0onDKFooSZwNmkdwOapbinrselrHHCj3ps8X57SQUoXFW?=
 =?us-ascii?Q?8CuUZBLp7LP53VyxkBR7pAozRNL7e1R/YT0EGkZxpquPWZv7IbTGg+d7IaSg?=
 =?us-ascii?Q?JzrX2sBARPAS+UkLQXlFf6u8aRhzuNy8hQB+gM9VFJAiMVYs5+0cosNblCuH?=
 =?us-ascii?Q?pS4SJcRomG4re6JRLSN1Do6itX7ddzusB26KfKwlinRGaZmXQCeVrEA3F40Q?=
 =?us-ascii?Q?myozG2FCh++PNF7bqw2lUCZo7aHNBNpBpLeet+ko0jGKipYD9EjZgvMNn9oz?=
 =?us-ascii?Q?51n37NeMXixDdWInklHUG3ry+/TfpffL4YhsAnHJM3ni8s26JQ3qrIz6onfm?=
 =?us-ascii?Q?6sYgLc34NnXem3+M+Pja4zPNApq4jT9PI2Iv+xethZCcvu68hbxxOmBH7xmK?=
 =?us-ascii?Q?CVSKSbnceZC0kwyDgFO4lL7dO4SgsKqMRsRjrAxL2pHFp7c8S0/he6Dfzyri?=
 =?us-ascii?Q?WR9gD5xhd+lw7eQ7+ZeZU7KAjluaXavdh46/xmysCsIAhygOFgxvB9K1RZ02?=
 =?us-ascii?Q?/YXlOaR4TdEgu2cgnaTQDOwl2U0AuAxIZF+qA64VEKiRf3aJF4ZRft8/JIIQ?=
 =?us-ascii?Q?jIvH6dJ4vqgd/WmCNWwDHQSvUOMhoNfoTT/D6e4tKQXUbX99IaVVDIoD8i7x?=
 =?us-ascii?Q?bhDVhf0c2x1uyhIS6epllju4cP12Q5aOqxbJc3spT9eb/+BPCYDZ+iEUwSns?=
 =?us-ascii?Q?/cR7M3mKYyGc5QEcmRMgUcw0pvVE7ygHk091G696SWIavlkDsA4pEyWfYheI?=
 =?us-ascii?Q?iWv6q3H+5cYUxpXSyo3KmstDCPKh0PopX5rA+nFcW+TH+iPalk604Znt8XVC?=
 =?us-ascii?Q?+VZEo9kRhXwZNlraYFHKXRyPjXg2OhokYHBHig5Ki0pnmJ7diVNXDCH77xXV?=
 =?us-ascii?Q?MvpL7jST15huNMrCKuQQcZDRKsy1bVJbPPOjcfKq/ACgc50lgA5x+c7W+ibV?=
 =?us-ascii?Q?Y25mlOyDcutjOIIpxgDHoxYYR9NyYJwjTYQCZP/DgZSuFpcuDXgvtuVTNBqQ?=
 =?us-ascii?Q?V2AxQU5aeRelnoesKXenSfpgQ8hxgjgq3hsCzQy6gdjCKx27e2kstVXIOBRM?=
 =?us-ascii?Q?pWgcyb0iBmBimmW0jZm+MlkyHiUc+zbnvnQMqFueo08YyJrHwOY9tiwE70B4?=
 =?us-ascii?Q?h2fP3ADc+laNe3ysIme1LCRgEjhHw/SZSxqu4v2HdmysyRPIyWMpromjR9Ao?=
 =?us-ascii?Q?jay8eNzluieulCWTULVkmXLipSja4gMelzmvWV8PRaBhV+QWe2cgcbJ2cR3C?=
 =?us-ascii?Q?BEaz5r37QRDeB+Z3+K666IfmYBbjq6XX3RAtH+RhHTQ1HRYb/cwnyv7gyW5J?=
 =?us-ascii?Q?zo+VR9xB8chIIl05eArdJ6GH8R3HVWvdj63gDXG2fND/jZQb6jNYri/KPcBe?=
 =?us-ascii?Q?Gh95Z35kLP6aRhB6GmP1nkIlMYgrX1YHr9lGUt5TnvIEcvXzUwLIAAmEExrO?=
 =?us-ascii?Q?O3bWrX/G/rs0zIDG3PvE8c0LXzu97fqJMhRkHq5+2W+PZqaADuFBCp+TdUVF?=
 =?us-ascii?Q?SSPppyIg9m3gj2j8sDJH8uwWzJTPd3/Uw5zBuK+B8EjxNPa+mHLwHiMnEgOw?=
 =?us-ascii?Q?JxzIOveE+VqdsR8t4mTdixytUishTZmi12zVsMuRL8yGoMHwG4QDHE0H+wUS?=
 =?us-ascii?Q?v6JIF+SOl+/evcm/9ZC64tnaoXRwm+8nYnpYPAFNv7dB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR83MB0418.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e81495-dc90-41b8-29d9-08db73e7511c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 12:42:33.7955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0RJxfUYasHBaCgqJirWmunAG/E0ioc4Q3QMk9lRUOfuv1bmsOB/0ZJ1oP6TNRIqPzGT44T26c9DYTm0gxy5UAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR83MB0468
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)
git clone https://github.com/dotnet/llvm-project
git -C llvm-project diff --patch --binary --output ../llvm.patch 4b825dc642=
cb6eb9a060e54bf8d69288fbee4904..30e9e6bc2e9f04e0a75daf4b8088ee91f66069da --=
 ':(glob)**/*' ':(exclude,glob)**/*.dll' ':(exclude,glob)**/*.Dll' ':(exclu=
de,glob)**/*.exe' ':(exclude,glob)**/*.pdb' ':(exclude,glob)**/*.mdb' ':(ex=
clude,glob)**/*.zip' ':(exclude,glob)**/*.nupkg'
mkdir foo
git -C foo init
git -C foo apply --cached --ignore-space-change ../llvm.patch

What did you expect to happen? (Expected behavior)
Patch should be created and applied to another folder

What happened instead? (Actual behavior)
git apply fails with 'error: git apply: failed to read: No such file or dir=
ectory'
(and returns 128)

What's different between what you expected and what actually happened?
There is no error. I tried -v, --reject etc but wasn't able to get any deta=
ils.

Anything else you want to add:
This happens in both Windows and Linux environments.

I tried analyzing file handlers via procmon.exe and could not see anything.=
 git reads the whole patch and then shuts down. No indication of a file it =
is trying to open.

I tried excluding more files from the patch and then I was able to create/a=
pply the patch, like so:

git -C llvm-project diff --patch --binary --output ../llvm.patch 4b825dc642=
cb6eb9a060e54bf8d69288fbee4904..30e9e6bc2e9f04e0a75daf4b8088ee91f66069da --=
 ':(glob)**/*' ':(exclude,glob)**/*.dll' ':(exclude,glob)**/*.Dll' ':(exclu=
de,glob)**/*.exe' ':(exclude,glob)**/*.pdb' ':(exclude,glob)**/*.mdb' ':(ex=
clude,glob)**/*.zip' ':(exclude,glob)**/*.nupkg' ':(exclude,glob)bolt' ':(e=
xclude,glob)clang/docs' ':(exclude,glob)clang/www' ':(exclude,glob)flang' '=
:(exclude,glob)libclc' ':(exclude,glob)lldb' ':(exclude,glob)llvm/docs' ':(=
exclude,glob)mlir' ':(exclude,glob)openmp' ':(exclude,glob)polly' ':(exclud=
e,glob)pstl' ':(exclude,glob)third-party' ':(exclude,glob)**/tests/**'

But if I do the opposite and create a patch with only the previously exclud=
ed files, I'd expect that it breaks. But this works as well!

git -C llvm-project diff --patch --binary --output ../llvm.patch 4b825dc642=
cb6eb9a060e54bf8d69288fbee4904..30e9e6bc2e9f04e0a75daf4b8088ee91f66069da --=
 ':(glob)bolt' ':(glob)clang/docs' ':(glob)clang/www' ':(glob)flang' ':(glo=
b)libclc' ':(glob)lldb' ':(glob)llvm/docs' ':(glob)mlir' ':(glob)openmp' ':=
(glob)polly' ':(glob)pstl' ':(glob)third-party' ':(glob)**/tests/**' ':(exc=
lude,glob)**/*.dll' ':(exclude,glob)**/*.Dll' ':(exclude,glob)**/*.exe' ':(=
exclude,glob)**/*.pdb' ':(exclude,glob)**/*.mdb' ':(exclude,glob)**/*.zip' =
':(exclude,glob)**/*.nupkg'

Only when they are together, git fails. Size of the patch is 1GB but I've h=
ad 3GB patches apply successfully before.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.41.0.windows.1
cpu: x86_64
built from commit: ff94e79c4724635915dbb3d4ba38f6bb91528260
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 22621=20
compiler info: gnuc: 13.1
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
not run from a git repository - no hooks to show
