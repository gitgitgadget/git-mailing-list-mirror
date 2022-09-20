Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EB5C54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 15:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiITPt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 11:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiITPty (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 11:49:54 -0400
Received: from us-smtp-delivery-120.mimecast.com (us-smtp-delivery-120.mimecast.com [170.10.129.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474FB2AE32
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 08:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mathworks.com;
        s=mimecast20180117; t=1663688990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w0WC+dE7md6NNL4SexOAvNvpwiHt+4Qx4XE+x37wJdc=;
        b=KBVZF2xdEhBJMj8/ATEG5nb+Pn6dngaqLuRbRpAewYmZK/ky1MS79wHWE9EnmtvAr5FOSA
        ++h3fpOM3WWSSGA4Y9Hm/yAGcaqRB0oD4vRCB2pkhBa2q+5cWjETh/ZzvPkK6zEmbC9BnB
        E2n19+KgRyT+8M/11y8UlTBBYhZRcxo=
Received: from na01-obe.outbound.protection.outlook.com
 (mail-centralusazlp17013033.outbound.protection.outlook.com [40.93.13.33])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-5HnpGlnAOTKnMJrRvGx7gQ-1; Tue, 20 Sep 2022 11:49:49 -0400
X-MC-Unique: 5HnpGlnAOTKnMJrRvGx7gQ-1
Received: from BL0PR05MB5571.namprd05.prod.outlook.com (2603:10b6:208:2f::17)
 by PH0PR05MB7639.namprd05.prod.outlook.com (2603:10b6:510:20::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.9; Tue, 20 Sep
 2022 15:49:46 +0000
Received: from BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7]) by BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7%6]) with mapi id 15.20.5654.012; Tue, 20 Sep 2022
 15:49:46 +0000
From:   Eric DeCosta <edecosta@mathworks.com>
To:     Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
CC:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: [PATCH v7 2/6] fsmonitor: relocate socket file if .git directory
 is remote
Thread-Topic: [PATCH v7 2/6] fsmonitor: relocate socket file if .git directory
 is remote
Thread-Index: AQHYygYG/MAw2aEgS0elkxkI6ScFd63ifRItgAQ2QACAAEZdsoAAB0KAgAALWfSAAGSeIIAA96CAgAAUikA=
Date:   Tue, 20 Sep 2022 15:49:46 +0000
Message-ID: <BL0PR05MB557135D925C638CC0A05D155D94C9@BL0PR05MB5571.namprd05.prod.outlook.com>
References: <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
 <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com>
 <075340bd2a713905d8bee4f53765dcbcba9a17c4.1663358014.git.gitgitgadget@gmail.com>
 <xmqqy1ujf5a9.fsf@gitster.g>
 <5c50a3cf-c5ac-6b11-2548-8400e5574b32@jeffhostetler.com>
 <xmqq35cnco3h.fsf@gitster.g>
 <40b47246-adb6-cf56-02ef-25ab1429a42e@jeffhostetler.com>
 <xmqq35cnb6fw.fsf@gitster.g>
 <BL0PR05MB557100B0802A8407C9CA55BFD94D9@BL0PR05MB5571.namprd05.prod.outlook.com>
 <454ed375-471e-44b9-f636-d1992e4a3c34@jeffhostetler.com>
In-Reply-To: <454ed375-471e-44b9-f636-d1992e4a3c34@jeffhostetler.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5571:EE_|PH0PR05MB7639:EE_
x-ms-office365-filtering-correlation-id: 7b8a6555-01b2-4b11-7316-08da9b1fbe16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: z48ySx5Bfzb8CzRMU2G/J5edWZVtK4kRjtzXA3p9WAmkZ285hDPj85QPr20fzRXMQ2BIM6UL4sdOOYJh0q999VSnmm57542igbtwIR/bGlTPzuzGIxKKvtOR3DUOdooupa+2wGB7c5FEbrvC3QByfSnCn7FznkgvmF0v055C4tSICZifsgYzxCXv6LNnviPSYkfnjrkxGQwRg1KJ4+VUXrG64X68VhV9D7jih5FZekdr9K4T8Bf9Zm69FFQmhFbPlj9oOv2RpUAgqESPKU5TGi+BsbXJFndSkiSJsVo4HImF3uTkweNdAPNrpxDwRVCmPC9ElcwxJXheqLTydxUV/feDVrt+4Po/sNTuQWXJiCbVH7GZQEkNlWXxE+bZ3K4KQemrFmQQfDUy+0qIH4t1ttTYDvu6qLrQZgygYvoDPDLfjgFUCftz1Gq1GpojtwHZiz2ITcFmsJW2uaHOSGeTuXf8bHnbiNiVxgiXxCS3rdXZKWlxkvqDmZUIAyCzaLYF2CogvFrvid1aEBENQjdR4oXkvvqBtqt/PQOjkgznk74wZb+Oyunecyov5qksF9q3WbTB2jdswSpHCviHY9lnT6ugv/YnkqcxNxkIkAbzq61z8AxBebbdGNhHKUbH/TOKuo8Xx2SpmZjoY1/u5TU0geoPEFJjrxNjliwnhqbMqvlz7V694HE27mUEyX/rtiYQ+2fs+/6zJ0KFvAMrr/CxHGJJM4f5EpD2pTROMkXHTb5hy2vdGf+1+8frJYHY7pAsHm58KmC2/Gt5eMQwBqVbed4naZ515CEhPKWlH5ivuRc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5571.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(71200400001)(478600001)(7696005)(6506007)(9686003)(26005)(53546011)(2906002)(52536014)(5660300002)(8936002)(33656002)(55016003)(110136005)(316002)(54906003)(66946007)(8676002)(64756008)(66446008)(66476007)(4326008)(41300700001)(66556008)(76116006)(86362001)(122000001)(38070700005)(38100700002)(66574015)(83380400001)(186003)(142923001);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?f1Qf18rzJE1zEAK7wWxmAevOtVHHV6yCiVfL12MZEPUCpPIqJB9JoKJjYZ?=
 =?iso-8859-1?Q?aKLzRcUDjJoTWkfj05pUR1oiFfgK1IpHCz6ERfMBwnHwML5A8cu+D/U1CP?=
 =?iso-8859-1?Q?BjNHAkXCgBpIzpkfMH/nEIp7miKTQdwX0mgnfRKcpMq9LxUS5JWIVPuuSc?=
 =?iso-8859-1?Q?dK4+xgZv5be0IMUD+jTPiGYM+rGV3/vxcWFsyaAspoKWLx/vM4dHVkTpuw?=
 =?iso-8859-1?Q?dP7q5QeXmlXVALPTrSaYG/7w6jxdvC9fC8vHfKDfH+px0auEyH4MOeq1dg?=
 =?iso-8859-1?Q?T4cqSVFnPfUWtinP4nrYcLp7PRMqyDPJ+cw0hSXpZXNGyovgkDq8U44zb3?=
 =?iso-8859-1?Q?UOOYwFuKJM79RUIquQDzlZIWeKVKNTE5FLGEoS6ejOaYO9oheIieQQg7Yq?=
 =?iso-8859-1?Q?J4tJXFR4wZJnK29+mTpd/5ogfP2GnbdKXglQFyGZfT1rHX+SwolKLna6hQ?=
 =?iso-8859-1?Q?ZADntJcThNWvgnKJaYFpZVD8gRyVJ48U+xDgU2zELTHsEc/Du/5ceEoyCS?=
 =?iso-8859-1?Q?SYKTZm3NKQsoJGIDyESmCb4rsBiXbeFk+IN/o4IZjABXHFzJs2prl/o9xG?=
 =?iso-8859-1?Q?oYwxuZNcAqFc/8vILAEK+4BviO/+u1pn6MsFnQOpODOrS2HwU7FHr9zUre?=
 =?iso-8859-1?Q?8anujOy1vDM97qo9DuTGjVAlEnjSp1B87awVOOgpA9k80rIaupaNYxRVru?=
 =?iso-8859-1?Q?AZBPu7q//CsGXXQpWLeujCkn72pQrL6mbtmgu4BtyTufoMHhZ+F3hhYsB8?=
 =?iso-8859-1?Q?HjcYVpISDmWRb8WjZbPSrpL2NmF00xK4ptH/4GSf+tRS+sbop66LpKhpCr?=
 =?iso-8859-1?Q?+lBKAR1YBO5hLw6ndhGT8RY4BFNN+GL3GjWAvTZhhPbMubXGMoZczxGHCI?=
 =?iso-8859-1?Q?hlgr7kNAeQU2tPqCnTQ7mX6F0C2QcBKZEmKeRaZem1rhGtzuDH/BCuC5PY?=
 =?iso-8859-1?Q?W6nScmgvBoSsOYw3jcEdnzvvBiRpzNTf/s9IAlWb/KHcNVBCF3wGr54PKO?=
 =?iso-8859-1?Q?KMjK4JhsyTUiDegzcyoYVVN3HIt4JGpplVTUXtt7dAMNR8RAZGgFoivU1O?=
 =?iso-8859-1?Q?aMHSQWocOwJ+OUl5jg8zsDGDNEdwJwZFSMET/YK7GoaxEaAsIwdh2mPINq?=
 =?iso-8859-1?Q?OZoMbYuX2NFM2hOSmENgRjOnNhspViLBSufVQcn4vST9WxWDHHPAw/gn92?=
 =?iso-8859-1?Q?sBjBJ6NUlNRiTn6830IqMlYAXGQsXL3pYA/bXRv4TxCyZm3F1WG/JPjueH?=
 =?iso-8859-1?Q?w7TM4BlLyTKyig339U7hPaTeDIlfNKBRPnGSue1eJwAqlW17COKyS5cO/J?=
 =?iso-8859-1?Q?Ir5YkYoPasDJ9NZegZpaPh36vZoofaN+E1a4U+fUnNP9DC+UUH/CFKsVPd?=
 =?iso-8859-1?Q?WgyfCVYxV+P7JT1YGdssN1oVxXa65RPFWfwooyxHQZYYeQwogYCsUMieTO?=
 =?iso-8859-1?Q?QVioNg9Lafr8cOH/PODWT+k1Y3fKBD+lfsGHpheNl/adO62Mvc3rR3ophT?=
 =?iso-8859-1?Q?ABeiPZW0VRc93gOXC7TLBU94/KZfQYvvES43EgdaeKq8sUEIF4iU8wcME8?=
 =?iso-8859-1?Q?HGK4RZqnLzQfzKoLfWLTYObxlV2pNsXMtpwxbGWBWRyTBbn29SdaHjC9p0?=
 =?iso-8859-1?Q?Vv218BV5d1MDZHcGT/2ulNOjhPh5qZ9zUl?=
MIME-Version: 1.0
X-OriginatorOrg: mathworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5571.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8a6555-01b2-4b11-7316-08da9b1fbe16
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 15:49:46.1155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 99dd3a11-4348-4468-9bdd-e5072b1dc1e6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 59d03YsZ56VeA3ekxrbjtZ96r1w/OkuI5wfYTLLiLvm20xo7s3LLaFM5cpfD6QAkcAWiHYsM/DmLigNRSMvK0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB7639
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mathworks.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> -----Original Message-----
> From: Jeff Hostetler <git@jeffhostetler.com>
> Sent: Tuesday, September 20, 2022 10:36 AM
> To: Eric DeCosta <edecosta@mathworks.com>; Junio C Hamano
> <gitster@pobox.com>
> Cc: Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>;
> git@vger.kernel.org; Eric Sunshine <sunshine@sunshineco.com>; Torsten
> B=F6gershausen <tboegi@web.de>; =C6var Arnfj=F6r=F0 Bjarmason
> <avarab@gmail.com>; Ramsay Jones <ramsay@ramsayjones.plus.com>;
> Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Subject: Re: [PATCH v7 2/6] fsmonitor: relocate socket file if .git direc=
tory is
> remote
>=20
>=20
>=20
> On 9/19/22 7:51 PM, Eric DeCosta wrote:
> >
> >
> >> -----Original Message-----
> >> From: Junio C Hamano <gitster@pobox.com>
> >> Sent: Monday, September 19, 2022 1:49 PM
> >> To: Jeff Hostetler <git@jeffhostetler.com>
> >> Cc: Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>;
> >> git@vger.kernel.org; Eric Sunshine <sunshine@sunshineco.com>; Torsten
> >> B=F6gershausen <tboegi@web.de>; =C6var Arnfj=F6r=F0 Bjarmason
> >> <avarab@gmail.com>; Ramsay Jones <ramsay@ramsayjones.plus.com>;
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de>; Eric DeCosta
> >> <edecosta@mathworks.com>
> >> Subject: Re: [PATCH v7 2/6] fsmonitor: relocate socket file if .git
> >> directory is remote
> >>
> >> Jeff Hostetler <git@jeffhostetler.com> writes:
> >>
> >>> Aren't we in the middle of a transition from always using the global
> >>> "the_repository" to a passed "r" variable?
> >>> We're getting closer to being able to hide the the global symbol,
> >>> but we're not there yet, right?
> >>
> >> We may still have code that works ONLY on the_repository, but letting
> >> a function take "r" and lettin it ignore is worse than leaving it
> >> explicitly limited to the_repository only, no?
> >>
> >>> I'm thinking that at as long as the global exists, we are not safe
> >>> to have multiple "struct repository" instances, right?
> >>
> >> By itself, Not at all.  It is the code like I am criticizing that make=
s it unsafe.
> >>
> >> I do not mind adding
> >>
> >> =09if (!r)
> >> =09=09BUG(...);
> >>
> >> at the place you have the "sweep it under the rug" band-aid, though.
> >
> > Appreciate all the insights and comments. Where are we landing with thi=
s?
> Very close to the finish line and I'd like to be able to push these chang=
es over
> that line.
> >
> > -Eric
> >
>=20
> I'm OK doing it either way.  Junio seems to prefer the BUG() version, so =
let's
> go with that.  That lets us make progress on getting rid of direct refere=
nces to
> "the_repository".
>=20
> Jeff

Sounds like a plan!

-Eric

