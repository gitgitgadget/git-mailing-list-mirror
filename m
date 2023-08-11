Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CB6C0015E
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 19:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbjHKT52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 15:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHKT50 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 15:57:26 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E658C171F
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 12:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691783846; x=1723319846;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=HTJh5+CRH57cv/HERC4ycdWi3Q4ef4OYRse4sOYb1hE=;
  b=GKE4STUvO/23y9/gx64dXFpDP40iVRV3NfSKsos0gaKmGSMyrFWoWnvO
   Xq9FJsEsl5kXSvb2v/a/juR7cr5LETxN4hcZKG8B0J2Ul9jLJMQ6Y0xLx
   6PfaIudCaeggycQGC+BRdIHBqeFGszRCZ9Z8Kwx2HZyhIb1lYkRwEdGQx
   r8JwUHjBtkvzgeOGPPLu1W6B7mDPePT7qbKDR//b4Hx36jqXmUzS5/qoP
   MMoIpY1G/fi+8II97q0BHFCeP3uN2Rgk/I1lRv7bN0MfGypIHJM6W43Km
   MdMyzfipda2jDDuAq5FImwUm/9jvCAue19D2SYRbIu6rqX3OlCk1g9D5L
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,166,1684771200"; 
   d="scan'208";a="240681724"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2023 03:57:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsPanpq50/FXNKJG29Pvgbt62ugooFo0/Vjq6rZNYZ5ZZ76Fv3qtRGS+sLwV3c6Enb1rDp1FVSpuF2hp3yBc81nHE/erstfRLndP35pYOf3xABQql2bdhLMwgJ0IYKWITQT7GTLcsyBFQ5qVUlTcNV691IdCxMsyMa7WZ2UNtz9AVZN8GaBj9ulfR5ruIXI09ErNMYYbYkkgK7lSUUqiOZyc/mCyO1O1+jjYJ0DFeiCeSUJFImK+bdhB2hezQlUjmJhfMjRFpxDCyCYz2mp69dLFwQugd5bnZkA+PBCW3U1cuoToQMqjHNyzj8o5L7SgytrPfvGSplwbnZERw+o+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPQeawk2tLkRDyBA141uJnLTZuLZbf/gl3qj1RmjSLo=;
 b=I8i1jukeDNoQhjpXOIa49+S+M/O/vDwOvHtIvWYkCbPwNLcSiyDFZ3/+msF74XsuP2qB2gyPi3qAjNeJbHCda7iekK86bjZlrzuMyXxbLPc8YpJJqx4MoSMbsC5RqRAAEYPaPkz+gA/gEIcDknX6vSHhXqSQnYAa9nMzAHjxPRlWo71u9t+z/7bzaIIp2T1byEowasQ+N/IYsDw1s3czxBr3RqnLhn8iaD8QmEbh5oL+9h8FgLZxtj76JZzuNPH+waum/7DnPj3nsjdhbpqGKILpyrOFGGUjt1lp2pBC/uzOqAuhFdH9c7CC2bB1KtyPdU6ssAyFPhNl7mibVMs2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPQeawk2tLkRDyBA141uJnLTZuLZbf/gl3qj1RmjSLo=;
 b=HjO2KWDPtnn0LnvU1gM4G29AFqEMsaWp2+m4TwEuOMnwomQSZT46Wxy58ai9yF+XxTVXwQH6Jh/i2hh5vqcnsH1TRFWkZPPPZn5FJdS8AIxhFpwLjkqe74rxLCm10+5VEbZCsDxrhw55VlSCDfEXlYlv8r8FHOqvWPWLflgzAR8=
Received: from SJ0PR04MB8289.namprd04.prod.outlook.com (2603:10b6:a03:3f1::19)
 by MN2PR04MB7054.namprd04.prod.outlook.com (2603:10b6:208:1eb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 19:57:23 +0000
Received: from SJ0PR04MB8289.namprd04.prod.outlook.com
 ([fe80::1032:2a66:96ce:fef6]) by SJ0PR04MB8289.namprd04.prod.outlook.com
 ([fe80::1032:2a66:96ce:fef6%6]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 19:57:23 +0000
From:   Mun Johl <Mun.Johl@wdc.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: "fatal: Not a git repository" issued during 'make' from source code
Thread-Topic: "fatal: Not a git repository" issued during 'make' from source
 code
Thread-Index: AdnMjcTVJgLV9DzbQRekliVLGjBYJQ==
Date:   Fri, 11 Aug 2023 19:57:23 +0000
Message-ID: <SJ0PR04MB8289FF1D6BAC59833D922BA89C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB8289:EE_|MN2PR04MB7054:EE_
x-ms-office365-filtering-correlation-id: 2227b391-3705-4bdd-7a9f-08db9aa52dc5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ifZcl+OwN8D6Y6i1lg9m4ck0C3PqWXuuVzbs3Ny0fJdIwO7j4g3zYg8qaUEwrhKGtbhWk/AR6zwmeGwRPy1pBZmy5sTu3xMpnI76w2ByTmUpSlcelkFDLGNSqUApK6DLZDgOz6Bk9IL8bNfLeJ3PshcJ0ySMzXYwAwxOc4eghuyQ4A7N34L54XH9fD3k2u/y9Y8EBvABJuQAFc4FknZrWupbTH/emFbN+3aK5rFY7sy1g5t7iRmJioyb0A+cCz2aeL4xIQnX58FJbcVLVsVKPpUir4CtFbxxCr6JbomyvtIozjuyFVMjh/QAOgwK21CJXqnUSaHeB1JC871cKBz40QfjIQQKWbhDvQphsfLvLdDsghQjFVUrmoMQCk2JM0efr4R7eQep051Dn8jeWVSuU9a0nRfzp7rWv9PkDVzGHa+ZX32IGVijN+CjJj3FduVWLB3tSLQ0XRpDGH43e54sEBB9Hp9kswJgj9zC+iZtTIMbkyUTHI4/FcO7RgLVYZ6EnjKAyv1W3/vZFpvzNlDW2XdSQ10jtbZbDueoQxFU4IbcPdR0KLn0z82wy1tyL4e66TeFU5n60cVJaWEn092XsVf4HaDo960uocgmUAVIMTQZjT2Wkc101M93O9F0jd3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB8289.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199021)(1800799006)(186006)(82960400001)(122000001)(38100700002)(86362001)(33656002)(38070700005)(55016003)(7696005)(5660300002)(8676002)(52536014)(4744005)(8936002)(71200400001)(9686003)(6506007)(6916009)(66446008)(478600001)(66476007)(316002)(76116006)(66946007)(66556008)(26005)(2906002)(41300700001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?inhz1X1ivnGNvYz6u7pktxG1J11X5o+KBN4cK8/FkFRJOhFe2sfK2yHpXI/L?=
 =?us-ascii?Q?liww/z6iTLhgJGY7vYY6cQfv5a0LldeCXiwrNVwjgunwlOOUsy+xTfps0Q4n?=
 =?us-ascii?Q?aedATzGTYeuj1kR0NG5v4pms5ZcgZeFJJACVf9AqbJDDLrll3FxN4WSszoxy?=
 =?us-ascii?Q?5Yr9KGSYNaOWiqkLDXcOm/o1LmmqQg936HBnEYS2Eyb2Nho1YYLkcmrnyGRl?=
 =?us-ascii?Q?TKHvnttzWyBylbymTqsrz9ihJ3ajX1yxdricdU3Dtdt7p+hysWsz5kgrB31L?=
 =?us-ascii?Q?rq1/dK7UHK+E0PXXi6QLVdgO3jshkTjLqDbf7mHD44u3x5hbxZTNuvJAjC77?=
 =?us-ascii?Q?KlR1wguV4o3rmrtJS0bla1sbqAmQZzxBiGeSaDUalqrnjq4P8n78aAAyXcOd?=
 =?us-ascii?Q?4QNyMWwMPY338xR6Ru0OO4lyev7p2x09OcmQnUWA8BIyF1R9ZcKlwQTYLkvB?=
 =?us-ascii?Q?vbrd5l1urr0li9xXYXOuTciVrnpymlCAcc3C8gNWYU37lrnl8Kc30l7l5ShG?=
 =?us-ascii?Q?B3RoP1T0YhhyZKJNbCc4DAqdwtwMnqlTqbTRkqa8jB0DLQHMrMimcF4IbLLS?=
 =?us-ascii?Q?iCcZ8dhTU91nOh/fzCFHPQ8UWFrhGLY8p2kGFbh61Iu584gPNYsIm3pa3opv?=
 =?us-ascii?Q?PuTNjV44CWYKSTQSyrOpeTqAuPc54HHtH994GxC/6PZE4ePiX/pDQLRdRCXV?=
 =?us-ascii?Q?rYJNWcgjboct5C/BG0OvG6ndQwh9eN/Ucp6T1sXDVHouUdLjrY78O0ytjHWK?=
 =?us-ascii?Q?cVv8EejGmsYg+US+SYklXklazhQc/OfDRHHjf47nQbCK6n8hWGECKrHYaP6Z?=
 =?us-ascii?Q?B10BxW9GmFFD3oLfMZZMVaII4ZQzhchuqWsIUZ1fgXTUd90aEohVPwbpN8OF?=
 =?us-ascii?Q?Z5cmiW0d566sdAPMJ7aqQNXAIEnjTars5TQj9DxujldEnJu/9lG/kZHw6uHy?=
 =?us-ascii?Q?LemG5AkfWoAtmHE5CzJ/9Cf7lLbCk3zhKQubEdgZ14zGiTdeG4qe5C+TGNR+?=
 =?us-ascii?Q?NAF1UkXyGobpYv6SW34V0cLirnhCr8Er8VyUZEaWyVbqpHFa7gyUaOkrunz8?=
 =?us-ascii?Q?DNFHFyxQ1/QaCzjWfiy8tx6UZpd6oE12riHWOH5jQ6Ks0jx1/ILsZNgY1DGL?=
 =?us-ascii?Q?1I0l8EhGESxlLkLYhk/7yAqTx9l9mghpvYSFRe42V4GC0w/zRJNocPAcS4Fh?=
 =?us-ascii?Q?cJNSuAv9nm07/WaGdJ36MB9YgGIx7ua7/KUdJHIGmDW4a1t7+LGpNacO2HEE?=
 =?us-ascii?Q?/jPgKYVD7fz/1n/SRC3F7tsZY9u4kbYGome6/LyEME5birv27GtiaAbTGQrq?=
 =?us-ascii?Q?j3fmuWP7pUIcds/j2lo51uYm0A8fsMzVJYHkP84XY7sKbj25HYeM5ZG7Wy+T?=
 =?us-ascii?Q?OKHCHZaDrypG2TQn/dARvYI5LT4oALbKisqdS+TB1RXnYx8ytRwkMTmtDxty?=
 =?us-ascii?Q?pQZVgmETnJ1VLsKS1iUhhtopZkMwJ0Uo4GK8QON3bsmptLb3oQWMbtMUC2iG?=
 =?us-ascii?Q?2BT4ZlUwUdKvHULAFznzC4LPcHmxsfjYBlBGZEx7gEvBPrGOC6a65+FBSTwE?=
 =?us-ascii?Q?c6lyhhxRQ7fm7KJwrqA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: absrY2CWmVlW7WurLsRoE8St01oJ1j64zHGjtBE+a/cbfwXHLqhL3WtaAzUAF5h99wcvIF1iJNsWSRhZJfmjzKWI2pkN7ESPK369m7ChElkhf+8bf5yrkz0VnFrnYv6mXKG8DNBvlJCpMP6pybbcHIR0fC3p9d1mDTKYyAsLX64IdBEIgOERLSkHwWmSuCEkcKLFjhUqz8Ruu3rDc6zF4gU/fcOnEIPkB/0ujiF1HrhPtlVynALj65+15Ayn52lvKkG4SjvCJ90d3AjssP4LByxzFJ82ethVMRQWnkKSK/8sUAhEZwY92WwrsKkBQpjpENdGilvTP0hYb1unBoD3SE2iFyWVpfTt1edJhYp40Ea4vnwv8vYZHcNldmtsdL3NiYIgoHmmsA5D5xpOgbz7aOo+oIrRGV6LqnOS6roDCIM7xd3vca8YoaGbVfEzT+wponcNe2Gi7Mb3BPEWnohrJ/LO72DehiLmQ2CbY5EkOzR4aRVJQ5dC2Bj45zMKGJ/lelGqXmEa9AtWdiUk/TWlqBPRWtGE34Va3uFza5IbATs5FCwy0y1GWbmHsZNN0FXFGemA2ErEkQjN/DPIcjhX71xqJ5tcVDFlMIc4gZPY/2MN3nXHOpgp/e1KYQbZE6qfMICxY/8Z/Uw6NRx6Nmk9WM1LOebtLUAekD4933yMDZLxAC4d2PWiqnbkixmgfiqIh8cmBDG0trIj5whZUli+RuuLYlakgrzMpuU8MAr8fTdZNVP9cvthoV76+TK25j+FaEs8zK5v5T67YVTv2wV4ZA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB8289.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2227b391-3705-4bdd-7a9f-08db9aa52dc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 19:57:23.0689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3nPenNba3pfPk9gv2bXz7PWCIiZ5AMvDGZIA0YAGO/KTLKTRCM8S8Z6Mpz42PMVIOqa8aMvLvjQXqeItQzhmwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7054
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am new to git and am trying to compile git-2.41.0 on RHEL7.  When I run '=
make prefix=3D/usr/local all doc', I get the following error:

fatal: Not a git repository (or any parent up to mount point /tools)

Which I infer means that I need to do the build within a git repo.  Is that=
 correct?  Or have I missed some basic step in the build process?

Thank you,

--=20
Mun
