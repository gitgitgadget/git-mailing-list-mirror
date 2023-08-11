Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629FFC0015E
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 20:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjHKU0E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 16:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjHKU0D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 16:26:03 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2425018E
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 13:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691785563; x=1723321563;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=8jNvF0VDUnVPtvecq31FFr+BG8hPFBVzTDrjVkEhOXo=;
  b=n/MlSRzLQla4O3rRoVoGNStkt0bdWi/w9KgDBMnXOBQxcvl24vfIJRkp
   bBCuqZ3Rrw54mldPBwSY1EQOu1f5g78l2X3Ol7BjqXsO3Cd+QTuqXp1W1
   3Eb3viU4XAqh44psLVciKCLU7k+ry2AKoANheewL+xnQjqvdP2/1u7vAw
   nQee3cGLLXIgzwJzGzdYuC8Hd2N2bFEldgA3M2S5JIq73XyuMVEXYs3eU
   ucEmmI9vbWL1t9TEBTLvbYZE6vINRenisx+IJpx4c+0IRUSQ+kFWPuIpm
   7ju8sYvTsy9+7I2M2kZoz8udc1kBbPO+CqDbX2j0exjQHt4hWNPmipBc7
   g==;
X-IronPort-AV: E=Sophos;i="6.01,166,1684771200"; 
   d="scan'208";a="240683122"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2023 04:26:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFTKFd9K6Lbu8t2T2uxTQz5tr5VBU/JO2XgTPLARaGAUaLrx3bb4QLfEhfYGIB+JALwCeHxHFGzDflZgo4rUP0bN0TCRR+BHRn/67KWcdKmFb17fkR5lxHM/76jtOw3ltlqcLyXaIh0sOCxctm+0iffT97FAHFq55BeYnQ/eJiVFIG7v1LwBpS6G5Y1lh36+EuekZ3tSxOqdgr+pd8aYQomk3z263NJj8d0LslTtZQy6JI8tk4gaEDjzdkwDY8EMwd3AuZ7gsY5r8+BH65B4DPEzK0+2echONwpDrkXpJbhplPLC71BE2bY3sPMdCBjrZSmDvgwXPN7UD0ebPfwtvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYBDN3Grj0oG9bfN2Ypmc+jJeZFY9PUzVkFwgjkq/nM=;
 b=HhzCZk0aHiVrOeTeeU6+iImvQvqJpAq+kcOQ4apVwqOQGv/88as0J+oKFMNTkL9DjWEL/UTx9vVHJ5ysF9/1XEcGw0n7BkKAQ/cJUwsNiKazjbNl4DCM9oNFAoVL/g8bvlnkDPcdZxIcE71RsDUp2uB58cjEJ3ah296NpiKobpmSfmNwMio39DbIlQcxdzIpFe0CyzG/v8xC0im6eigZTHhbf/S19IY1UMkMewEcSjLFCLgfe1/45ane9ETfq6gteiALvJBaiMByfwHc0tFiDA1muJLJQjZP4ED9RT7EfMVz5vO0IRWSOyg8zofhtqcLSHM9jwdSaGzSMYsfQb88bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYBDN3Grj0oG9bfN2Ypmc+jJeZFY9PUzVkFwgjkq/nM=;
 b=UiErWNVtV7b+6RrAZdv8FGln6Gp3Gv4zR7XoLhIl/vtwzYN99uK2/ZV4qLnjcwgT4szl/0C8FKYbF3C6fphVHyW0dsL6/XHk/D0kyapVa2oM6ZPCZHbMQQJvDL8f4EhMpIyTTIysMbwwLi8SGGaL9KZppg1P/fc8hbO2zurt7HQ=
Received: from SJ0PR04MB8289.namprd04.prod.outlook.com (2603:10b6:a03:3f1::19)
 by SN4PR04MB8350.namprd04.prod.outlook.com (2603:10b6:806:1e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 20:26:01 +0000
Received: from SJ0PR04MB8289.namprd04.prod.outlook.com
 ([fe80::1032:2a66:96ce:fef6]) by SJ0PR04MB8289.namprd04.prod.outlook.com
 ([fe80::1032:2a66:96ce:fef6%6]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 20:26:00 +0000
From:   Mun Johl <Mun.Johl@wdc.com>
To:     "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: "fatal: Not a git repository" issued during 'make' from source
 code
Thread-Topic: "fatal: Not a git repository" issued during 'make' from source
 code
Thread-Index: AdnMjcTVJgLV9DzbQRekliVLGjBYJQAAz3CAAAATMUAAACR10A==
Date:   Fri, 11 Aug 2023 20:26:00 +0000
Message-ID: <SJ0PR04MB82893B315F130DCF181D78F49C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
References: <SJ0PR04MB8289FF1D6BAC59833D922BA89C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
 <034501d9cc91$069bd360$13d37a20$@nexbridge.com>
 <SJ0PR04MB8289D45EE7A495B0ED7F69CD9C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
In-Reply-To: <SJ0PR04MB8289D45EE7A495B0ED7F69CD9C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB8289:EE_|SN4PR04MB8350:EE_
x-ms-office365-filtering-correlation-id: b18c5d30-5bb5-4cb7-b90a-08db9aa92d4d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CkFMWDXR2hiGaNWaN8++oTJJU54IP+VxKlkcbNg63rCjld2gNQlmorgQ83gN82NRJ9a0d57ixZzQSOl3xQTS5flJxYMQ0DJV3ZHQ6n5HbBem4776SHdSg2mSNpN5jrlC22Gji2Ftc3eahjkTtW680S0/1Ad6F80FYfMfQ7iQNL/zp0nOaLPJdaN04f5h5Xs7+TRcyb60TxAaakxhsD/fsnaouJWSFkommkWZdNH+gdxPwC35CgORaGeZxMteH/X5lV61RUdj3AL9dw9lvzIrA2Br9g2kTbZvaUZsN6BFPgkXVtwculSiiF5CA0e78c4KMPXXHWiXuXdpfrUINR7Xti35z434Sv98SIOSeo378fePAKhgLYWn8XOFg88E4nZIPI/RBm2WR9YJ1w37deycJh0adnaKI8Z4Ndoi9WASSmMXpYdaXy6ofMLPYkxLazi6dlKH2xopG9r6ywwDCf6itdT0TXYTRUWsQO4ZFO9WLbOaHYy73A/0hs6iP27bEU3TZZ1MqLVggIYmDnfDeFTV+3rpYyctRVeAaArCwqwg/yFB6F/r8/1h49s9guLTzuj26Ottv5ulVXr2QUbOUd97dOVuGeiNTt9czjwGmlZ4Db5wHbdVprNJ1FgQh8j5KKWG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB8289.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(376002)(396003)(136003)(1800799006)(186006)(451199021)(38070700005)(41300700001)(122000001)(82960400001)(38100700002)(316002)(8676002)(5660300002)(8936002)(76116006)(66476007)(64756008)(52536014)(66946007)(66556008)(66446008)(33656002)(83380400001)(110136005)(86362001)(478600001)(9686003)(6506007)(26005)(2940100002)(53546011)(2906002)(7696005)(71200400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ppjV6dgNvE7ho0Hmr8tHsf/Ufch4TjteRb0hHvP+0sh4saId1H77a0M5BQRJ?=
 =?us-ascii?Q?o+fnZ6SPJ0lu8Fnl54x+d44I1Qw2AoGJLc8qFTHDWu4HAo0Z78l2VYWRueIc?=
 =?us-ascii?Q?1d+z7xvn2ghZgqN86eebWe9wYYLRzAwKE/9zYgyDNbS9ocT6Hfvxqz1adNQ7?=
 =?us-ascii?Q?bDjCPWe0TjEo6qlEyHC+licr74c8Dl+pmRQS9L5uts+hiVYfmAHgTxP7xc8A?=
 =?us-ascii?Q?j/dW2jwkqNA8IRFuzr6TZWPqDKyGfiPq6DbB0cm+yQaU2mV0tp68RFaqTpd4?=
 =?us-ascii?Q?tT2D8lwXwfbAJfYAg0LeSIN0zSUA26mQMpYGT8OmLfy+WZMFXqdEoQmqWcIM?=
 =?us-ascii?Q?C4VbijKPWkl34fvBOusy4HUDS2PyC9jeN4ihiOvzRCBlBZFUs14GIchyOuBR?=
 =?us-ascii?Q?bCwrDpVPeCsvgfe8TTAW6E8dZh3xIccwUhGEKAtU4tohUoX9+vVSa+bM17nV?=
 =?us-ascii?Q?RrSMZfivufA/xeWGDiHUm4WGmToVlpyJuJljyVTfdW+EKnJERWSbzjQUuu+w?=
 =?us-ascii?Q?ZqgLngLEdts2VSPcS85JARuFkp9QQSTIKhybTb82x6xCmKRzT8ClZSTPcCyy?=
 =?us-ascii?Q?QmWkG5P5UCWjipU50l9LZ9AuPMQY3NykT6PNNYaM8hDYdwavHREy6uT/Is8A?=
 =?us-ascii?Q?x/LyigJFYXlSlYlwrWgD8BNkgQvBEL+I6ozF9hgVe+fhKmKzBGlu8h2yHJ5A?=
 =?us-ascii?Q?Q90G+V3U5x4mxeApF9KJFYDNqDFhWsa8J6eTDX8SaDHhfVMahPNSopFiK3zp?=
 =?us-ascii?Q?GcX77qg+lv+oPJ1Ezjw638vAoRcUj3/XOxn2ML+buM7n4NuxWTf8jSBUhtQd?=
 =?us-ascii?Q?fDRJEF6oS1Hk3Ofdg8Q94I1ZxbxYHpqZvs+2A+SRUKko66LWtfgBZML1J0mU?=
 =?us-ascii?Q?FRObwdW6fzvdkZwJE9kEjUvTDHcHHCy0MDYcQlk83d2+sAmk/MtKon/Z6jif?=
 =?us-ascii?Q?QZa3vUL/jEb5pWHu2ufwuODo4SKM10NGnn2+O/k5NvnAqdnbSLdyXAkvU5/U?=
 =?us-ascii?Q?mFIxLyHBMnVxlmNBdzhEE/OKYKNTaGuHkCqfDjxuCxgtyZx5U4a0c59ASF5R?=
 =?us-ascii?Q?QPX7ht7N/TIjL4dtMbZb8pqyIqHb6HgsBpkG2w9S2StYDLxN22BzY3qwESOY?=
 =?us-ascii?Q?eoRwL8agCA1IUrnphbzcr9i/uymUHuvuCO/8ROscywJMfYqPe/8GysltwUcD?=
 =?us-ascii?Q?/sASegYUAtvDqXPAzbFACreXUtVIAeqOgBnPvVGpGOAbdSeGYdvlbs6rH6GC?=
 =?us-ascii?Q?8soYkaIh5roAgnIwp6oOMQl3oXZkOuckFPkzPQEHalkQIUsHA8upB1/zIgnd?=
 =?us-ascii?Q?GxE4AXfHRpz0+HYh3cuUw8OQTkeFVBdORPT7O+Oweb8EvmKEuIR61NkgtOrJ?=
 =?us-ascii?Q?gDsBxhKJQxwtdnlnbSmQ+3ueBaZpUPwMBKQ1/aPodyEOKgaswXsKNHvXO2vI?=
 =?us-ascii?Q?zAn5+C1Sc/Vv2xoSNF7xekeJti5rV8iYHSSsOenZ5FZOPkb0VdlsDoC762uY?=
 =?us-ascii?Q?EIy04SlDLFdpGvSR3V0jNImy+2j/IAvLW1zKwR7JOlWOQd8PFKMiVxQeTy9y?=
 =?us-ascii?Q?F8ZTdxQxKBl6Wn6RFqM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5mHpzdILRqL/+CMTbLpieAqrSvnfXXcGIhYN/SVMZfBR2o8iFWne+mna2HJq9lXb+ihmTHRlTq8fOkF3QPjQPBXXmFE7m2NC77ZzgUs5KIvstmnWZ7knH1+Ha0kyaSVsxAeDX3/3llQBgQwPDzCKN0oWb0tTQM+0X8Wl9ZzbJfekByOZu4bH1JxKE82riUgl0A9xVV7YQX/4bDpvcBwXA+SCTKF11e5ogAYm1H3Sg0cItmD3MJ9zE4dpFnCxKqfc/7LEtF4xKrTDAnWhF0Jeu5QXsr2OCo92BeqVcawrqRcTh4aigoQOHYwFapT6eEE79dvYI96pvrhtaaLNRr4F2Y1WyC/jEAn5FP5lnDC05qrPgqAfily1tIqWXCuGhOJCS87haSKlGN4eJ3ptUusfL60rbWowJDwI3VVYr1ZsxYkJ2t1dSE5G8av1gqsD+Pn6rL61dOAmVMmUqLuZT81XePeurhWoYs3F590xsscoIqGqf4pNOZnDfPeQJ3bRCe6RaBKerv43x70UEprLy3Hkp3ijzMZOnRPvarruk1jYbpXiuuh5b9/A8rmngt1hCZKQeo/pbZ43Pk1v1u5vppuZXbDnE6Dr1RXvKbELkHVPE2cbO8PwVAFLBRwQxi9AHOoWWXdhnQDSCT+VAyeqwtsSGyNPp98OrmYqfcTQ9A/jotQaS0MaB22o8FiQJFJapDhCH2AO0sTZ1YsBwsDNjy4uFmxWdmRurUAJq0E04davKvZZyJuQBeITb0P1Z2PWR+cdDesaFvzNKpAQpo+dQl4zpKEe7IHn8cU+DIWsLDzJv2ywoH+vWd4bz2zgd3WkP4lJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB8289.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18c5d30-5bb5-4cb7-b90a-08db9aa92d4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 20:26:00.2841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kj2nqYSESXdEBuKVAg8Q14UmYekLxO49orUGSCnIF46Z3HfO03AC2N2dbTiHF2JbRHkwUmviqy+iTRVIx8uEhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8350
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Sorry for the additional reply--I should have mentioned that we don't have =
a git repo yet.  I am just trying to get things setup so that we can create=
 a proper repo and migrate our data.

Best regards,

--=20
Mun

> -----Original Message-----
> From: Mun Johl <Mun.Johl@wdc.com>
> Sent: Friday, August 11, 2023 1:23 PM
> To: rsbecker@nexbridge.com; git@vger.kernel.org
> Subject: RE: "fatal: Not a git repository" issued during 'make' from sour=
ce code
>=20
> Hi Randall,
>=20
> Thank you for your quick reply.
>=20
> I'm just wondering... Can I "trick" the compilation process by simply cre=
ating a .git directory where I am running 'make'?
>=20
> Thanks again and best regards,
>=20
> --
> Mun
>=20
> > -----Original Message-----
> > From: rsbecker@nexbridge.com <rsbecker@nexbridge.com>
> > Sent: Friday, August 11, 2023 1:19 PM
> > To: Mun Johl <Mun.Johl@wdc.com>; git@vger.kernel.org
> > Subject: RE: "fatal: Not a git repository" issued during 'make' from so=
urce code
> >
> > CAUTION: This email originated from outside of Western Digital. Do not =
click on links or open attachments unless you recognize the
> > sender and know that the content is safe.
> >
> >
> > On Friday, August 11, 2023 3:57 PM, Mun Johl wrote:
> > >I am new to git and am trying to compile git-2.41.0 on RHEL7.  When I =
run
> > 'make
> > >prefix=3D/usr/local all doc', I get the following error:
> > >
> > >fatal: Not a git repository (or any parent up to mount point /tools)
> > >
> > >Which I infer means that I need to do the build within a git repo.  Is=
 that
> > correct?  Or
> > >have I missed some basic step in the build process?
> >
> > Yes, you must be in the cloned git repository in order to run the build=
.
> > --Randall

