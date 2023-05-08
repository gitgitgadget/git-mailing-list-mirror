Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46E5C77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 14:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbjEHOU5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 10:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbjEHOUv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 10:20:51 -0400
Received: from us-smtp-delivery-145.mimecast.com (us-smtp-delivery-145.mimecast.com [170.10.133.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A23DA0
        for <git@vger.kernel.org>; Mon,  8 May 2023 07:20:02 -0700 (PDT)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-310-aVNGcCYKO5e9G4yNTySfGA-1; Mon, 08 May 2023 10:19:58 -0400
X-MC-Unique: aVNGcCYKO5e9G4yNTySfGA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqNDAwzD97hSZYIkZe0Nm0TO8S5p/jYj/n6Ra0RRADb4pQKtIOTLwq280L2jtZ8wo8P9f/g99D2J6vIWW7StBcuQib7Mc3ivrlxf8Usm55uZSykGq5wI2Q3o5t3dzHWjknaZklwknZIXWyWl3413AE3wQkIWKbgLwhq2kvhXCuVVpTZU/KbUb2rtISRQmPxX9LRDQuIoqr5DyByy+fpVfMMFIbGpPZj8yHkbiw2bqs02m69anC2lqFoOZjAt7x1E4Lxy89SUeTqSeoqYWCACEBfBqZZN/RJlWmQ3iAuRxH88QKmx1B16g3+x6d+BK/Z/mpvLCsLea11TwEZwfGw7Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMefy5oCIqPe5CdbFSe6KaFvNtxPWw3QU2tFUisGIf8=;
 b=LCo5CU5rcBFSp2ZpY3yrg9FIHXlIflljjZ7NHDu4f+njKHTHEX8DGx0FavHLL/MgGj7tft1djDyoLwuIYSFmRhYGI58R7AU8YqjzREnnvZqAjxPAgRP1/gIdYlzdXpjhIwDhkSdKwpNkzofCo/nVV8qIETRIgcH9sXMYwD7c6AZ1sPL8wuBi0TaxAUZvxgvajnjTG1TzPNrrWMSRe1rajOLgZfEmwviSTJ1BYksj8ZN8ibsOjI88+nIQbsX5OC2BfTLadtFI3mdmkqtkkwLI1IejudUVesrITG/0QPG9yI9qPaf8xPigPEiACfB1U8LFGp8OyDZnTSxAxqdQzbgHoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=benevity.com; dmarc=pass action=none header.from=benevity.com;
 dkim=pass header.d=benevity.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benevity.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMefy5oCIqPe5CdbFSe6KaFvNtxPWw3QU2tFUisGIf8=;
 b=KtPJq4FtYebTF0AaOc138Ho5atefyHkNg2ZoefI1P7muxJKZfnupyDZM5hVyoluHNc+D/QixUyzN/oqwZvaNJ/oXLeRZPVxGbmwoiWqTjvQY9NxA9UYHkr7h3CX+uSot7+ww1T+z2Z6Z4llR1ZTqqYYabkj012oqKy5EAcH0sDY=
Received: from MWHPR01MB2318.prod.exchangelabs.com (2603:10b6:300:29::13) by
 BL0PR01MB5140.prod.exchangelabs.com (2603:10b6:208:6c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.32; Mon, 8 May 2023 14:19:53 +0000
Received: from MWHPR01MB2318.prod.exchangelabs.com
 ([fe80::56b1:d0ba:db8b:52f7]) by MWHPR01MB2318.prod.exchangelabs.com
 ([fe80::56b1:d0ba:db8b:52f7%6]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 14:19:52 +0000
From:   Shafiq Jetha <shafiq.jetha@benevity.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>
CC:     "erik@cervined.in" <erik@cervined.in>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Suggestion to provide a way for screenshots to be added to commit
 messages
Thread-Topic: Suggestion to provide a way for screenshots to be added to
 commit messages
Thread-Index: Adl/YOs3NOSblOWnQ9e1660pTYpR1wAmG24AAAYLyYAAFAd45QBVmzQw
Date:   Mon, 8 May 2023 14:19:52 +0000
Message-ID: <MWHPR01MB2318577FFBB21ECA369B1684F3719@MWHPR01MB2318.prod.exchangelabs.com>
References: <CA+JQ7M-MHvtLf=p5+JWEG6ec4r-X0JzFxV0eVhrKNWv8jNLX1g@mail.gmail.com>
        <20230506115437.61969-1-tenglong.tl@alibaba-inc.com>
 <xmqqpm7drvz7.fsf@gitster.g>
In-Reply-To: <xmqqpm7drvz7.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=benevity.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR01MB2318:EE_|BL0PR01MB5140:EE_
x-ms-office365-filtering-correlation-id: 7e85f5da-0224-41e9-b7d6-08db4fcf4a2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EYtaogB1EvUwHoHB/IiI98XSFVVVYqKZ3b35Q+4cLKoQ+nY4iN3Ood7jszUNb0fFxjpsgnqbVFy3JoQTRsdEfB/NuSxjv3rQENPiLMQka6ISMwzRX5qDB9ywUxbZySiqmmeLFU+5kysEDIgtKJKqzBpYftoQA0dwTnSqtt787KnA2kIj+oqfV1YE1YNLLz1+RZX9zYG063qBsnaD1cj2Wk5pfDzmWFykN5c8kdWWMQlPQt3POeIdpSbsKcaO5SCM+Uzdet6odXJr/vQIvi+veYHrbRxoXGDu8WfeTyU8yLg2ob2gB/ItdoWcspzmuEeEYAMX5G6Bj5NfL3Fgpik3o+8al95hjaFJsaJwFfcJJSNZZ8SUQuC8lkLTHIpQpr6L6CyPhymUfQVgSkUOOBa4GihDjL1OXVqd0UtQD7S1SgGITSowG2eeZJfRcMXnYFDbBGtrtwNgy4z+E34iqkKIBt+Mm3SWoX6dpfxmBEjcIrixXqcFiaXPqUXJHbav4H0pDo3ElhfVOFxGw4bqncuPr/bhUBVGcmTZpV+4f0LfNDPuv6dm6B+GFr4F4sc8pqvaOa3BKFG0adYAuHp/If+fFzwQZE/HCiM/WlhBLcZgcNg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR01MB2318.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(396003)(136003)(366004)(346002)(376002)(451199021)(53546011)(66476007)(86362001)(33656002)(966005)(54906003)(110136005)(66446008)(64756008)(4326008)(76116006)(66946007)(66556008)(7696005)(316002)(478600001)(55016003)(52536014)(5660300002)(71200400001)(44832011)(41300700001)(15650500001)(8676002)(2906002)(8936002)(186003)(38070700005)(38100700002)(122000001)(9686003)(26005)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QRWAJyMtu/LAjW2oQR+ZJXSc/zyDxf7XMQB4ILdqIvLuytbcBc/h+cwOaxpg?=
 =?us-ascii?Q?AmVpEWI3W3iK5kNDV8IQqx5SfPMUqky/FzTGkdmnBjlcTrdho1AEraqoPpmq?=
 =?us-ascii?Q?8YFJII3zoqKoxRMt9d2B7lA3++h5tY4xBYCQRIu/aix4ddTAHvlkEXjc/TyA?=
 =?us-ascii?Q?FmD4zapW3CRJfOdcQcst2XFYKIqYJeAhdELKba43/lanBQxAidECPnxmmqJ1?=
 =?us-ascii?Q?MDLYH2uepKikA5bN3n+NxS7KwWDTAIJvHW7XbpuLQSNMfXD5a/ZGJI1tAVE+?=
 =?us-ascii?Q?7MJpFmpwH0op8YWu5y1JZlFymuP5+qGXHLfS5+eAqj5HM7Q7zfpbsvkGjvxD?=
 =?us-ascii?Q?/V88plAMNMEqkvVEsDXzXFl8Beflris/XuXf0PasiWf+twMHoO8r4IvUOzHI?=
 =?us-ascii?Q?4cUE52VsFxmEZBsFNIqmspdYyiGaqP41wQPiQFPAys1SCrDfBLhiF4IvU1CZ?=
 =?us-ascii?Q?LgA/nuLLKP6pVRfNAvIjn4NzFeV6Ws97eQvA5v8gdRELAfNdXFnMudLIeDj0?=
 =?us-ascii?Q?CKB//pSPqc9IZCfY4xzzmD3Oug3eB5+40DV+aTUEqoxHehbSmg1neGE2CFKT?=
 =?us-ascii?Q?2ep1AXTWxSnau10d7gDBC2KwiiChPQluWMJNO90ZQbVYtACEE5jibAnx+3Bh?=
 =?us-ascii?Q?Uvrse3HkFvs4B7oC9yXhcC9uJh+DdF8gA+us7+RIgw8zbHMsafrls1XTEV4r?=
 =?us-ascii?Q?Dg49+0d7hBLOX5lc59XSV7L0/aSv1wJ0xyYe4rqnPg8yV2EEdJpwTrgFwkHf?=
 =?us-ascii?Q?wTAAZduZx9qARl+RZH/BHipLor2d+MfY8Zkcmn2MniYspeuKlOjuR5824Wrg?=
 =?us-ascii?Q?APtty6x6zejoqAWnsrU4NdKdD09IPjaIW3A0EsdlqQ5DiTcumglRiE5EuYL3?=
 =?us-ascii?Q?phV/hp+iz2xbowwkDOA1bnox4RgkTDgkGKzjW1QrIZlgUNHgWYcGc1fTsPni?=
 =?us-ascii?Q?e3hMtd3f9iLnh+jrqIaR62mxIcRwbrt1Xsm0S0F57ho9aNz1GSCOY9OYaFnU?=
 =?us-ascii?Q?Z7luJzj89a8ZhJ2L/Yapv+lUSAOd8qI+BUvmaccmUdd+kLF+S201uPM2X7Y3?=
 =?us-ascii?Q?tw3d1hUv7V7RNT/XXvZ5oqGyXDGSgeTeyDnOwKyQ1EQzPulLFEU0+H5/ggpB?=
 =?us-ascii?Q?aKqM0aT5YE6s/jZdRuhPZpD3qxd3u92oLeAQNPYZd1WMPJMQz+b3qCtS5eFM?=
 =?us-ascii?Q?RxDzg6oCmFvATI85TF6TE453uqwFuEq9Gi3YhsoMlJsJrC+MXxXHhbPthPk6?=
 =?us-ascii?Q?LHZGj7piyFF2BQhFtEQfaiYdU6KhoehSSrt8FDZbGeNBE+QFydn6HJQbUqXM?=
 =?us-ascii?Q?QdPDCmGONkI7qhAjPeoBQrHbZbrcfe1ZV3robaORWSy+yjcQ3mlAX4tJ+Aq1?=
 =?us-ascii?Q?soBNMmS/rqIyCfQiHgkwySQ50AxPt/8mZA5uzq3OmRADtTKImFAstsRXtZAJ?=
 =?us-ascii?Q?Av++gkx0uRBjP8hdaQYd9ppUXLNB8LVp6rvJh03NIFWh69Q57udi0jG26uhr?=
 =?us-ascii?Q?u85xokURh60ea/KjrAgBmzaLAtipvlg0pwGSXyEnGqyn6zwvbrjjOLtfjGgz?=
 =?us-ascii?Q?pDvlZeo1i2x6Gh88N3/dSZPBatcefdiYXCTMzITA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: benevity.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR01MB2318.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e85f5da-0224-41e9-b7d6-08db4fcf4a2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 14:19:52.3863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 16550523-17e3-4640-b0f6-1017a8b74396
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +gZlxopceqPAeloxH3Ch/KdfIopqRUoWz/PRg1I8cyOHDkThBcwmsEnv/JHb1HrTye0+MS9WjxWBePWT8Dosk5U2EXJV9tdCDKL7TV4C7nM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB5140
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes! This is exactly what I had it mind. It would require a lot of organisa=
tion but I think it could work really, really well if implemented like this=
.

-----Original Message-----
From: Junio C Hamano <jch2355@gmail.com> On Behalf Of Junio C Hamano
Sent: Saturday, May 6, 2023 3:28 PM
To: Teng Long <dyroneteng@gmail.com>
Cc: erik@cervined.in; git@vger.kernel.org; Shafiq Jetha <shafiq.jetha@benev=
ity.com>
Subject: Re: Suggestion to provide a way for screenshots to be added to com=
mit messages

[You don't often get email from gitster@pobox.com. Learn why this is import=
ant at https://aka.ms/LearnAboutSenderIdentification ]

Teng Long <dyroneteng@gmail.com> writes:

> I'm not sure the scenario of using git note to save the binary is=20
> suitable, but the above context may give some ideas, maybe.

A project could choose to store its commit log message in some arbitrary bi=
nary format, encoded to be safe when displayed as text by accident (e.g. "C=
ontent-type: text/html" with quoted-printable, or something silly like that=
) when shown in plain vanilla "git log".

Then repository viewers can be taught to render such a "rich" log message i=
n any way it wants.  I do not know if authors of "gitk"
(bundled with us) or "tig" (not provided by us) are interested in doing so =
to their ware, but there are tons of GUI Clients out there
(https://git-scm.com/downloads/guis) and authors of some of them may be ent=
iced to add such a new feature ;-)

