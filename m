Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F86C77B7F
	for <git@archiver.kernel.org>; Fri,  5 May 2023 14:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjEEOwA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 10:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjEEOv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 10:51:59 -0400
X-Greylist: delayed 55619 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 May 2023 07:51:13 PDT
Received: from us-smtp-delivery-145.mimecast.com (us-smtp-delivery-145.mimecast.com [170.10.133.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B601117DC7
        for <git@vger.kernel.org>; Fri,  5 May 2023 07:51:12 -0700 (PDT)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-2tFv5ofHMZOdiQKub2JNRw-1; Fri, 05 May 2023 10:51:10 -0400
X-MC-Unique: 2tFv5ofHMZOdiQKub2JNRw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2AgUeW3gSa4pwKYnPqpbdmAj2OBd3WRd+VPWl45GZqMRPOHOS3XKmalnf9u8zsxd97cZynQRg6qDbrMcINf/YDFnUtZuxTs3yKhKQknt/wxUcbF8JQ3vtVcUFCvNaWcp82Ly4K7O1CP7PJ1az7uIAtYyvShqkzeBpUbIui0mJuA6UPu/OpFmdmGab0wIELUW9NpSTFXgqzPKQwdhvywZ2Q1olMDzsNpyb+URzgfn9MQQwxUTdkq1l9tbjfocwmmeHMamkJLCesvzU/swn1ZDl4p9KFQgAMXc4ly+MYvrdcmJDQ38iLZeVLHqLFUN+d46HegYCKVDPuPeqXABepXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iu+Y4yOsLvGy4mdRWY9yEpMqRKgjWFLwI70eWcFv6/4=;
 b=SaKQigUhGB7Ste7O1AyFdwRRuIaBDZk3DZ9ZPIfuS9L6AIwqnQF/H6Gfyc/piA2m1Sh0fVoC5WIB+0y2R7Ij/EbVIlqnC6UheoSS32Jn8jHZaf0HwP98HVOivCZRYWFzotMBBRba0ljR84cS9AUYAzCeT6sH7OYgnQNtPvCrVb1O19Cqi/Euwr4iSyl+HZjVsiZvSTvUCCakWR9K10MULM26z6CgsPuXjWi0ET2VnGNtKPUqwmD7it2SHE5CT8QkZrfv4biNVK0Qx5p47sBlcJZjIm3+0PJ9UvUVos9tjWeNhvlA+SWbL+5NrtLMwdSONDJF0FE+OKXjaaVbg+HE9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=benevity.com; dmarc=pass action=none header.from=benevity.com;
 dkim=pass header.d=benevity.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benevity.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iu+Y4yOsLvGy4mdRWY9yEpMqRKgjWFLwI70eWcFv6/4=;
 b=ayCX4IoDvaISzAIg0ACj5DVw7EjECa1TrN5L8zBn4GyqwU6bSeStQbJoWQZRF1rJ1WD9qeE4AxCvRUatI4q5YbCoPWGaVF2juPwYjA1+0lF2QGZpFZPP5eVwiC53/OHeQqjDLb08bzIu5fjZjCzWYewdpcpJ3xzcJakUOJiY4hg=
Received: from MWHPR01MB2318.prod.exchangelabs.com (2603:10b6:300:29::13) by
 MW2PR0102MB3561.prod.exchangelabs.com (2603:10b6:302:d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.30; Fri, 5 May 2023 14:51:06 +0000
Received: from MWHPR01MB2318.prod.exchangelabs.com
 ([fe80::56b1:d0ba:db8b:52f7]) by MWHPR01MB2318.prod.exchangelabs.com
 ([fe80::56b1:d0ba:db8b:52f7%6]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 14:51:06 +0000
From:   Shafiq Jetha <shafiq.jetha@benevity.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Suggestion to provide a way for screenshots to be added to commit
 messages
Thread-Topic: Suggestion to provide a way for screenshots to be added to
 commit messages
Thread-Index: Adl/YOs3NOSblOWnQ9e1660pTYpR1w==
Date:   Fri, 5 May 2023 14:51:06 +0000
Message-ID: <MWHPR01MB2318693B28B740F75D90E1DCF3729@MWHPR01MB2318.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=benevity.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR01MB2318:EE_|MW2PR0102MB3561:EE_
x-ms-office365-filtering-correlation-id: 770273b3-934a-47f7-8189-08db4d7827d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /DX3Hld/q9u2bHbfsgFKJubPtvOqIY9QDec2Svfnl9GsUwR9YhosW0V3014dAMC7tfZ7jQvbW9xzVAuLe3PeweaI4YMZNuFHGD7hYdn2f5H7L1nAtEW2WxcdDpbEGXAa/mGce7GSRPjGx/gGY+lcy0PYskV2u8NWEIzuYM+NhCWQsZcdtYOnY0eftzRrHh06pMQ9SWH7YBvfVSbswuI8kGnv1Dh7rp6JNFmMcDuGFZ1FcN2mpZVT/TPTkXRvIgT44yPd9bO2XYNKlmWTYxosvdVtwbozQjlvKoHHhkEjU8ES+JBG+94Yxtz1YEWURFkvFuArY8QunR48TIKEG+DoApUg8628ofDG3nEg5YBmdn+uZ1HMCkBP9nSNzsH39N+pauIh+2akuE4ScCAMv3l3CL0mUJFwSK3ri+ZJsP9S1PlILK7Re47MifT4+zb7194vh5a32vTJE+mM82AID0jo9yu85sU8lXqd3grXzaH+fQgOIlFJbYeih/Y4ysz55twij6VEhXGvnKd6l6nC+eUnUDdnXR/H/Bt69B8jnx/HYO5igQh5HnOByXn6UMF2hkSMPRBvjzTjq1A89xcIR5t57qZyt/JOmrIqb7quMnSlVxkrvNiAwS93KWD43RWNUhEy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR01MB2318.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(376002)(39850400004)(396003)(451199021)(26005)(41300700001)(38100700002)(9686003)(6506007)(7696005)(122000001)(316002)(55016003)(33656002)(52536014)(86362001)(8676002)(66446008)(5660300002)(8936002)(66476007)(66556008)(76116006)(66946007)(6916009)(83380400001)(38070700005)(64756008)(478600001)(15650500001)(186003)(2906002)(44832011)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lqueiGbb6b6z0DQl723F9r5orAsWrJIj2GZ/9Q8l0j6xbB/Ke6aSqmI7ka?=
 =?iso-8859-1?Q?odQkqNLoEiVt5dpBbusOhc3P/iQ/Meivhm/IqCt7VlkTpebvjbTtnU2Cbv?=
 =?iso-8859-1?Q?GtAZVuPSyPJpmT3wCYeZ2nrTXRvVrXUpy2dGkzpNZIWXHOA+fsZT9UaNxZ?=
 =?iso-8859-1?Q?38upagDL/bv/fb50ymk6ItXzzRDQjFmERoX9kvMLwgLNU1uOmiLDHVX7Xk?=
 =?iso-8859-1?Q?+Y83//1npC0HfkLO2cpitukzzzPz5KwpmpODnYmhM5dTscnOup8FX8e3Cv?=
 =?iso-8859-1?Q?EYWbO0R/VZ2AWFtXl+xzXlo4mutBh0e8hC/nitHLgcJ1BpQ+gmfhMBKNxb?=
 =?iso-8859-1?Q?UiVSUhqvQW5tXu69TbY30aEDtqfPqDgzxzxcW0P+CRqGGgBZgXgTg7oJKO?=
 =?iso-8859-1?Q?eD/rU2vM5DXruR8/4yNuxYwrhCZ2xKb5wTAZkCpjJW97Jd187Jh4Zpk4mU?=
 =?iso-8859-1?Q?YzTON2n4xtZoKvEayZdEH/OZHc6fECOaHbQPgIRkYLOt9br6BIwFkzhIvG?=
 =?iso-8859-1?Q?feIqSG478cV5stRHODdxvQNaJ1q6dTu/Z4vS36QkgeXhLnlK5/WrojiHMe?=
 =?iso-8859-1?Q?pXS41UfUAyU+zIhANrKKA7+hjzqsrGIAhAaIzm5Qi10h+ZqR7NUntoiHes?=
 =?iso-8859-1?Q?uE/i//F5UWUHyX81psa/9XWyzKN4CPfpeiqKW+gHGNbzvUzxQg+PBMtpkE?=
 =?iso-8859-1?Q?uAuiPFDR92+MVXEBPTLiQdezHfP6q1LROwNlDayY92wVNcKyqle0xwFG1S?=
 =?iso-8859-1?Q?J5pmbzjbSrcv4Ws+jJEpwYmKEutSojtH8KJfAxOwytGol6kEWmfLmJfAPf?=
 =?iso-8859-1?Q?11tVjLOy5mfYgEAy0AFbvH3kikQp/Ak66VZHN72uFpfREspl6cf7GpKabO?=
 =?iso-8859-1?Q?MoUVEqpYqMHskdSD5WAlTHzVNWsBauFF4MmXl8fpqtAVKy0noW3YPmoqAm?=
 =?iso-8859-1?Q?ot+Fs9rt/27RM4zQejVyOmycm8hCfFXE5cREJK7GeipQ8lBuu9ekOhkogU?=
 =?iso-8859-1?Q?dwej0sEWFDSiJPv6U5VCL5UPHyB5gow0twpaiFFKm3pK/iW8R7sCVevoGd?=
 =?iso-8859-1?Q?59QZVZyPtL3CrzazCy6bhb0g9zYMRVFORxxVHqcFAVMHQr6jnC8S9/CwDx?=
 =?iso-8859-1?Q?+H+nSFwOuLrNj2ePN/DQ62ChMY9RARn9z5Cu1Zme7ZABBKSK0VfVqlmbaA?=
 =?iso-8859-1?Q?x+vJjid6WeSA03oIJFdTlqL0DWvgY24sej1Vp/fx6XHREXPPuF4JgLcSTC?=
 =?iso-8859-1?Q?K+IblyPKzzAFd1zVZzQLOw+oDJqmxnz89yYSOtwgSDiy25zvlvZkrFOaex?=
 =?iso-8859-1?Q?ZvXOGLDxa+NK5KbZrBOL5JU00GlrLo9Bbhv1LGT8RS8Nft4wKbEGXqQ4ev?=
 =?iso-8859-1?Q?8LQ/JyFXVqF8HuXf4Xge/LSQIujoAfWHFsD+oUSEldd9QapQna/HvglHdQ?=
 =?iso-8859-1?Q?+0rnSeqFqNiOmPwgt4wZYTdZP/iQVcWxERzDaebyWEsmSK+/mvDU+Jg/XL?=
 =?iso-8859-1?Q?xEHrpV9pw4MExR8Wj+dOlvuBwSamdqu/U5dFawwxL0mwOOuyLxFx5fXqy6?=
 =?iso-8859-1?Q?uxdHbfyDgg8pyzUBCpeKVWbUIbH9Y4uVwt8nBuRxf7n2OXl8T4zUNPeB0T?=
 =?iso-8859-1?Q?2jxLh6Al2FxDgq8OcoPcw8lWSCdZyhs3Db?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: benevity.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR01MB2318.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 770273b3-934a-47f7-8189-08db4d7827d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 14:51:06.2570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 16550523-17e3-4640-b0f6-1017a8b74396
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Bo+k5mBQ0ZM8Y62Q7ELlRye0uEFkselNH5acPLqgQt29R8NNbSJk6HjMN3YBWfSxqqFkB3N3ePjcAPBqM7+QNqG6+AatUd8ZH/ATLKYRCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR0102MB3561
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,
=A0
It would be nice if we could add images directly to commit messages via git=
. The reason for this is so that we can view the history and see real examp=
les of important UI elements. Usually during a PR we provide screenshots so=
 that people can see how the change affects UI elements, or to show the out=
put of specific commands that might show specific data in specific scenario=
s. I can also see this being useful for people that work on projects where =
code produces some sort of visual output where words cannot accurately desc=
ribe the changes (a picture is worth 1000 words, right?).
=A0
It would be great if this sort of an integration could be considered, and I=
 know that this would mean updating the clients, specifically the command-b=
ased clients, to interpret these images and provide a way to render them or=
 display a link to them in some fashion. There's also the question of wheth=
er to embed the images directly in the commit message or to link out to the=
m and download them as artefacts of the repo. And then there is the everlas=
ting question of whether or not a git repo should contain build artefacts a=
t all (since it can be argued that an image is a build artefact).
Lots of things to consider but I hope that I have at least started a dialog=
ue for this to be explored further.
=A0
Thank you all for your time.


