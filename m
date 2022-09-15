Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252D6ECAAD3
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 12:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiIOMXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 08:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiIOMXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 08:23:16 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00132.outbound.protection.outlook.com [40.107.0.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECE693222
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 05:23:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IK290CKSUsmfiRe3mWPzWDrPVJjQw2Gw7rRxSoI8A/XmSHz3g3sDO86JcjM57wxTwryk13ISrOgTIK0xCObnwN8F4Pl9hwRktqwzWopcBcElX52M7QZdEn9UrH/7Z/zXtzVJqt22Gub2fc3QnY161B0NfiJUuO6qpvyHJin3dhXGqE7otqu+GMgXvJiH13rQhmgTqrgj3OvcI2Jh4geIIdyS4lHQdgGL+icRaUZIZh5LW2SFXaQjF/0WT4eeG09lkXe1kkHEwRCG1udeEyba1+qD/IAUSap8lpkulkRYj+9zBK2/ErdKSeek9VibBQtmemqIseUAi0WIpkGuHMSO2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhzULpzYP8UyuyQiHSgrAB5oWZlHotnBJxaSvIirG4E=;
 b=O96rhZENRJn7JoAbMLINHcGEzIWnZOssoVma6xx66rb2ZKt9V4a8VJMJuX7hCGcB4dGMPbY2RF0D/zq+THCJ2O6hiDZxikuC9z3N/XwPghatoE6JsxSHXYXXiCEi7EnfHGtPyaozM2/I5A6oY6Vv9Cr4NIYK8TRAfjD4tKM0RhfdWR3udKCyMZmztp9Kiybdma4n76z63OX+M/Pog09jLZBm73/rcZwW+KBjUuMXq3iQ2kPWvoJMEZQWyGmTVymTYYvNjDoDiLFGtJEPjAeWme1sQysKrBmqayaPlpS0oiRMyAbHbM5GLQHWD//p2Fp3c3PIPRItbVXigcQs7DE2MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=praim.com; dmarc=pass action=none header.from=praim.com;
 dkim=pass header.d=praim.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Praimcom.onmicrosoft.com; s=selector2-Praimcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhzULpzYP8UyuyQiHSgrAB5oWZlHotnBJxaSvIirG4E=;
 b=mtEWeNrKEkGZMCS5mxTaszZKyrSZ3HiNz6+sxaLPC2L/tpm1ryZe/KaNdv4X8UryTC8nPEuJ9CpU9qgnJ0DLqvxPVS3SevAnGhcT0jLYnmADRNsuWvfTxpziV7iTwW3pk+EuwbOivMQ+E2NagJaIoVJxoWILxhq7GqiBeMgqBHY=
Received: from VI1PR02MB6301.eurprd02.prod.outlook.com (2603:10a6:800:17e::18)
 by AS8PR02MB8390.eurprd02.prod.outlook.com (2603:10a6:20b:528::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 12:23:09 +0000
Received: from VI1PR02MB6301.eurprd02.prod.outlook.com
 ([fe80::70af:ecbc:e86:3c7]) by VI1PR02MB6301.eurprd02.prod.outlook.com
 ([fe80::70af:ecbc:e86:3c7%9]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 12:23:08 +0000
From:   Tadeus Prastowo <tadeus.prastowo@praim.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [Bug] Behavioral change in git clone --depth=1 --recurse-submodule
Thread-Topic: [Bug] Behavioral change in git clone --depth=1
 --recurse-submodule
Thread-Index: AQHYyPb4t6uTE/tzXk24T0a4E2+0nA==
Date:   Thu, 15 Sep 2022 12:23:08 +0000
Message-ID: <VI1PR02MB6301891F2C862773918CB659FD499@VI1PR02MB6301.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=praim.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB6301:EE_|AS8PR02MB8390:EE_
x-ms-office365-filtering-correlation-id: 96f6fff4-956e-4570-baef-08da97150c6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k2WyLR5c655oUcx79LBC80oAIdjAcIHwVRBlK4ewiyR1mXHNCstL9XgXhlUThBIY517fYFTsXxkG1cpt/jVmYbBlQLV87c803cPBMoSfa1KCWc1Kx3Q/oyT9ZUvEtsFSfdbYSS4irdcSpb072QDYId97CP5AI/w21/xKobEOTYTCXMwwu51dtKGm93LEKLgRyJ99sOAqxkaAG0fjX9pIem4veCmoIXcYL4/OpcIFln9zd/5wfyF/KvPB6Lt3b9vBv6XxU1GSJBG0hkp+f/YqSA17kkxsppyGOIsPB3QNWg7q43XGr+8bBYj2s9anZz/hV9cD9IiZVrHxyNqh/8QmiQw2XCJzpV0S/vWyaGiNNOpH0OUXQNlJwroJIOKjoPpv9l+I4NVcvGfqDRNJWC8CQhP6gH6ZSzzE8YzGG+h5WcveecmuTSSh5HZhL7QqCmOkOjCmtGiGAdKQiiGyrBZF0DEEy9VAId1cCZtOeFvQdlemOSUuj8MslIA1Izq1NsbZgTaHl4ve1wyGuGsIShbRXWK33k85euXunNIFblzFbJ/LzrmIWAA9tx3vvjZL2VcR8feHaIKfUDKcR47uefy8jMmRYaw33FEqvR+b7IF+qgZiEjPfNmD8UzPEh1sSQ0r611yps5uS1YPsvy5ur8OM3khZQJDhxe8Bzc8xF1fodBgHcD+50sQnY0MGlMpa98XUDaoVx6Y2+NoT51rAx1DvWzq9zmSU9Z9ggSSCpNbQUTAW0Di3l7fmNcfxnAo45Z1AwEbMBHnaeWUGEEMR7lf1lNOoyR2xFEYksKHhtYJ6ZOg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB6301.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39830400003)(346002)(366004)(376002)(396003)(136003)(451199015)(186003)(2906002)(8936002)(6916009)(64756008)(91956017)(83380400001)(66476007)(66446008)(8676002)(9686003)(478600001)(5660300002)(66556008)(316002)(41300700001)(38100700002)(33656002)(55016003)(66946007)(122000001)(86362001)(6506007)(26005)(966005)(7696005)(44832011)(71200400001)(52536014)(38070700005)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4d4LURIkF3LaA2PUj+dHumiD5Gbgo4Ybv3zQ3zjdI++vGfrj41u/ZRrPqY?=
 =?iso-8859-1?Q?sclVyOzIqHV7lrHMr6pUlRa0gN20I0W6UMpQ/tEPrXVX1ykbmq3CO/jAJu?=
 =?iso-8859-1?Q?KH6M+UclNKFAgwqILo7AIRdVMQoShWTJR4uHD5VDKEKnKCyecCC0TTmziw?=
 =?iso-8859-1?Q?y07Jb+axhIRg0gaNM3H1SQSeqrBJJN2ntBs7K8ZiPRD6kP3PIw8tIQyjuq?=
 =?iso-8859-1?Q?kQP/Fp9kwgUqJdvgiLve0mke/+zTupcSTnQR9MI/7BY9DgXgRD0mvttMUL?=
 =?iso-8859-1?Q?rQsskn6Ya1/jpWfd1Kuay4XOAu4NfdEwdpdGdAUPhO5MOUpsgh47R+Isvh?=
 =?iso-8859-1?Q?XywNhSzB/smjzC0v+G0ZJzcfHvCzjrBSEJZdYoxL0c9x73UUAUzcQDB3Vk?=
 =?iso-8859-1?Q?B1H5dj8ElinsgmElFicT7vUJmOo0ouyIuL79uNOp86eHG1S3uW68SKNixt?=
 =?iso-8859-1?Q?9wE9xGHzR9N7Mbv32ZMCU38POpsoNIhjsl9BdT1D6bXQ6RLlIJ5pWKrsU/?=
 =?iso-8859-1?Q?ZXseffOhd45Qzp3irrPb42FBJQEPszRXpNfdTkjjmh/+kV7PyRSmNvOGYd?=
 =?iso-8859-1?Q?MKAZ9Qiwnk8S7G90qMJrLPeaupUJFtFuST8YLyUymQKvylUXSZJwCvuoT3?=
 =?iso-8859-1?Q?A84moQyKY2iuc90KKnZRNUfI2iwM1ca3/Ay5CxlKSzGslVePAKTJnwGg0f?=
 =?iso-8859-1?Q?a40Wq7yULwxC0w7PknGH+Y6w+YD+maO9an4A63hOaeGBPdqlDLcnucgqXB?=
 =?iso-8859-1?Q?I9Gc1NAXLfq1fi1M5L0pmTeaVFxBdMEspLJhOLYmjpGscvNvZUQJ6PF+oG?=
 =?iso-8859-1?Q?FbLGlwuDEe+yeIOirnO78a1LS0+gpTFbQHXVcV2l5yL6lk2v0XJTKkqfRf?=
 =?iso-8859-1?Q?4SZUSXX56bfF5RHC1ZWKXyEM8L9nZ3cjZSOVNfY8Gz73AqOtH5jOByhRpB?=
 =?iso-8859-1?Q?ODaG26WCrfn+bvATWyu7s1IpikNZXjo7pLG/3bzJllxHBVgbVvMt5tV5Iq?=
 =?iso-8859-1?Q?lVeVaNa/Ds9HIdk3VZhSgAio15rwVsUuDAN1UTtRJnTANNTYjK05n5/OJP?=
 =?iso-8859-1?Q?tX0p71PrGI+2R3oL7sBqTFQMyQBvZje502KlCdwf3bO0T1ZWiFCxHbNl6+?=
 =?iso-8859-1?Q?aFDbjjTH61d3pcJ/qEuuq5+zpiYcQuYS46lhLe8t0GajOGxgX5eI+rcTyD?=
 =?iso-8859-1?Q?mSNRkq0rOO0lOMJvaBt0+ME1znWak/e3FuR2aEu6h6XwGbdUUdW0FGhbI/?=
 =?iso-8859-1?Q?oCcLDiz//3DnjyhhdybW2OnlLBNIUK7AJSKfqyuNLEn5J0jm85ffOIxK/0?=
 =?iso-8859-1?Q?yOMo8TjC40LcPQuznqlDtV1sjLTOovxRkKpOub2UwT6arK0f4qqVLkjdMa?=
 =?iso-8859-1?Q?Hj3HbYq7MDTSTVhQ1R5BhyZ8uIVQfFJFMUbEkKut/LKnOYY5rnKuynigtx?=
 =?iso-8859-1?Q?04ggoW1d6WbcfGDmEgYfhJbKodmJ9pgKGAMvTTx43NMEzhEJ1UB6W4DQno?=
 =?iso-8859-1?Q?jFeUMhw8qOdJVqFsFc1eWHl4f3dtkgIefErpBGENCa2gy/KPlMxZXHbnCM?=
 =?iso-8859-1?Q?7CtlvNLEghJCQwFxpqzrcIW70rXyHWilcqoXBBEDi3zEYmJZe1u5B8NrFK?=
 =?iso-8859-1?Q?hSu8y531bU5618V+2vzv5IUVETVKIFqPHx?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: praim.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB6301.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f6fff4-956e-4570-baef-08da97150c6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 12:23:08.4634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4613ef0d-4c9e-49ba-b4d3-f00b8cfae777
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bcZqclVPCPCdUCefc0rQPBB3/67EVbpgbP4xUxnszku1le7zVFdEb5Rgaxs+FkS0/5uYeoXXijg4E3rlWZZ3lIzvPRtiSViyTDHfWSvM1J8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8390
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,=0A=
=0A=
First of all, please keep me in CC as I am not subscribed to the mailing li=
st.=0A=
=0A=
Expected result when using Ubuntu Focal 20.04 LTS:=0A=
=0A=
$ git --version=0A=
git version 2.25.1=0A=
$ git clone --verbose --depth=3D1 --recurse-submodules=3D<submodule path> -=
b <branch name> ssh://<user name>@<server name>/<repo path>=0A=
Cloning into '<repo name>'...=0A=
remote: Counting objects: <number A>, done.=0A=
remote: Compressing objects: 100% (<number B>/<number B>), done.=0A=
remote: Total <number A> (delta <number F>), reused <number C> (delta <numb=
er D>)=0A=
Receiving objects: 100% (<number A>/<number A>), <number U> MiB | <number V=
> MiB/s, done.=0A=
Resolving deltas: 100% (<number F>/<number F>), done.=0A=
Updating files: 100% (<number G>/<number G>), done.=0A=
Submodule '<submodule path>' (ssh://<user name>@<server name>/<submodule pa=
th>) registered for path '<submodule path>'=0A=
Cloning into '<submodule absolute path>'...=0A=
remote: Counting objects: <IMPORTANT A>, done.=0A=
remote: Compressing objects: 100% (<number H>/<number H>), done.=0A=
remote: Total <IMPORTANT A> (delta <number I>), reused <number J> (delta <n=
umber K>)=0A=
Receiving objects: 100% (<IMPORTANT A>/<IMPORTANT A>), <number X> MiB | <nu=
mber Y> MiB/s, done.=0A=
Resolving deltas: 100% (<number I>/<number I>), done.=0A=
Submodule path '<submodule path>': checked out '<OID>'=0A=
=0A=
Problem observed when using the same Ubuntu Focal 20.04 LTS machine but usi=
ng a different working directory:=0A=
=0A=
$ sudo add-apt-repository ppa:git-core/ppa=0A=
$ sudo aptitude install git=0A=
$ git --version=0A=
git version 2.37.3=0A=
$ git clone --verbose --depth=3D1 --recurse-submodules=3D<submodule path> -=
b <branch name> ssh://<user name>@<server name>/<repo path>=0A=
Cloning into '<repo name>'...=0A=
remote: Counting objects: <number A>, done.=0A=
remote: Compressing objects: 100% (<number B>/<number B>), done.=0A=
remote: Total <number A> (delta <number F>), reused <number C> (delta <numb=
er D>)=0A=
Receiving objects: 100% (<number A>/<number A>), <number Q> MiB | <number R=
> MiB/s, done.=0A=
Resolving deltas: 100% (<number F>/<number F>), done.=0A=
Updating files: 100% (<number G>/<number G>), done.=0A=
Submodule '<submodule path>' (ssh://<user name>@<server name>/<submodule pa=
th>) registered for path '<submodule path>'=0A=
Cloning into '<submodule absolute path>'...=0A=
remote: Counting objects: <IMPORTANT B>, done.=0A=
remote: Compressing objects: 100% (<number L>/<number L>), done.=0A=
remote: Total <IMPORTANT B> (delta <number M>), reused <number N> (delta <n=
umber O>)=0A=
Receiving objects: 100% (<IMPORTANT B>/<IMPORTANT B>), <number W> MiB | <nu=
mber Z> MiB/s, done.=0A=
Resolving deltas: 100% (<number M>/<number M>), done.=0A=
error: Server does not allow request for unadvertised object <OID>=0A=
fatal: Fetched in submodule path '<submodule path>', but it did not contain=
 <OID>. Direct fetching of that commit failed.=0A=
=0A=
[Analysis of the Problem]=0A=
=0A=
I can see that the number <IMPORTANT A> is also reported when running (rega=
rdless of the git version):=0A=
git clone --verbose --recurse-submodules ssh://<user name>@<server name>/<s=
ubmodule path>=0A=
=0A=
And, I can see that the number <IMPORTANT B> is also reported when running =
(regardless of the git version):=0A=
git clone --verbose --recurse-submodules --single-branch -b master ssh://<u=
ser name>@<server name>/<submodule path>=0A=
=0A=
In other words, while git version 2.25.1 respects what the `git-clone' man =
page says about the option `--recurse-submodules', git version 2.37.3 does =
not, quoting https://git-scm.com/docs/git-clone#Documentation/git-clone.txt=
---recurse-submodulesltpathspecgt:=0A=
=0A=
Submodules are initialized and cloned using their default settings. This is=
 equivalent to running git submodule update --init --recursive <pathspec> i=
mmediately after the clone is finished.=0A=
=0A=
End quote.=0A=
=0A=
[The Bug]=0A=
=0A=
The option `--recurse-submodules' is no longer equivalent to "running git s=
ubmodule update --init --recursive <pathspec>" in git version 2.37.3.=0A=
=0A=
Now this report can be regarded as reporting a bug in the documentation, wh=
ich is correct.=0A=
=0A=
But, it is my desire for this report to be regarded as reporting a bug in g=
it, especially because other people have reported a specific deficiency in =
git submodule: the branch information given in .gitmodules is not used when=
 git wants to use the option `--single-branch' on a submodule (see https://=
lore.kernel.org/git/CANNNLMC_XEqjYPOig+pbqrS30dPCTmcDSev6yg+5EEBkJCaaig@mai=
l.gmail.com/ and the StackOverflow answer refered therein https://stackover=
flow.com/a/61492323).=0A=
=0A=
In other words, it is my desire to see not only the documentation be fixed =
but also git submodule to use the branch information specified in .gitmodul=
es when using the option `--single-branch' on a submodule when cloning a re=
pository by specifying the options `--recurse-submodules' and `--depth'.=0A=
=0A=
Thank you.=0A=
=0A=
-- =0A=
Best regards,=0A=
Tadeus=
