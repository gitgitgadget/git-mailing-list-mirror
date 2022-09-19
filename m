Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31348C6FA82
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 23:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiISXwI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 19:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiISXwE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 19:52:04 -0400
Received: from us-smtp-delivery-120.mimecast.com (us-smtp-delivery-120.mimecast.com [170.10.133.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA9B4F3B0
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 16:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mathworks.com;
        s=mimecast20180117; t=1663631522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VlWfuokbh94PPsaTDN1HL8dIDPZtwI2q7QLkG5PHHJM=;
        b=iU5pbKRHU5yyP/7QHUcZBQYaQhqb6vol2pI7CZhYHC6QxTPhpJ/sg7U7DiaOEw0tTEne6p
        +Acs9wzok2SMkn0phQstWnGYXO0NUSK8wzcMKUUk5iilYadHJDhJ9vkSRl59XN68dI3kRR
        NhopKm4uz1AXeGfkrsPGS/QJ6xA7HQw=
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eastusazlp17010004.outbound.protection.outlook.com [40.93.11.4]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-Dut7bjwOOvWKJBfqF8wFNA-1; Mon, 19 Sep 2022 19:52:01 -0400
X-MC-Unique: Dut7bjwOOvWKJBfqF8wFNA-1
Received: from BL0PR05MB5571.namprd05.prod.outlook.com (2603:10b6:208:2f::17)
 by BY3PR05MB8020.namprd05.prod.outlook.com (2603:10b6:a03:36f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.5; Mon, 19 Sep
 2022 23:51:57 +0000
Received: from BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7]) by BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7%6]) with mapi id 15.20.5654.012; Mon, 19 Sep 2022
 23:51:56 +0000
From:   Eric DeCosta <edecosta@mathworks.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>
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
Thread-Index: AQHYygYG/MAw2aEgS0elkxkI6ScFd63ifRItgAQ2QACAAEZdsoAAB0KAgAALWfSAAGSeIA==
Date:   Mon, 19 Sep 2022 23:51:56 +0000
Message-ID: <BL0PR05MB557100B0802A8407C9CA55BFD94D9@BL0PR05MB5571.namprd05.prod.outlook.com>
References: <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
        <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com>
        <075340bd2a713905d8bee4f53765dcbcba9a17c4.1663358014.git.gitgitgadget@gmail.com>
        <xmqqy1ujf5a9.fsf@gitster.g>
        <5c50a3cf-c5ac-6b11-2548-8400e5574b32@jeffhostetler.com>
        <xmqq35cnco3h.fsf@gitster.g>
        <40b47246-adb6-cf56-02ef-25ab1429a42e@jeffhostetler.com>
 <xmqq35cnb6fw.fsf@gitster.g>
In-Reply-To: <xmqq35cnb6fw.fsf@gitster.g>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5571:EE_|BY3PR05MB8020:EE_
x-ms-office365-filtering-correlation-id: d586dd6b-3506-4305-5205-08da9a99ef9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 162w9sq0AxOvR5D2zOYH51q7fd5gD+ve+5CF5t0jYYWGppXh4TF1NjpsziYdsgiMh6rnR8KGlDY8/id+kkC7WFX8wUz2TXzLl9RrEpccwbP4kyZ9tC3ysH3l/Giuxdczwzt2B1nEvqPao4qhaokwf+L40dEPGc09bS3+sljYisdkJdn/IhpICekwjVBgV2oWsfgbF90o0SKDMU/s+QuwTPvd31AlPCNdG5dbQ4YmFGcDQgIhFO7GcHRqpVpUF5Xt64iJiWlq2VfQKjUlcwZvVzKMIrQbqZPfNpxDu9fLOPSP6NXKAeYHEs4COBKQ6/Kvl3k7vSx6vWpx/EwwU9wZg4lC2GP8cfLpNXNpYF+H7WTSFJBuzmgzDu30h/+D2/IIb3YVzfimPlZvYvM+0fiaoLukBkOzUWWErT9wkOxLGtrws9dQPEpDx52CU6vMgwRfo9C+PmoKGs7mfaUjGzThK49hxWJfRCfs35nwDgO2H+9Ui5BPYETTn/pjgWtDlUz7MxXP7KqlRFqcEeT856BlgPKg+DelV+fDGuiKShUkmBlQuIH3Puym9uvgftsqBVt2HdPs1V3DMl3lo9LtrJleEOFhthUX5sIwDbuHfP/ejZgKjfZEMR91cSpuk1J9jC5F+8WH+i4uJbfmLz/RQXcgyWnpL2X5eWCTzPe3CGoQzzP/7GWaQBOfcVm3hERURTY3cD9KyctdcCkO4EEL6p63T1ywBctEZpvb3sohzpvVjP0fL6E5LJczJlvRKR78d3Aoq4rg31Eqg2MPSypYoZRUVVjmcim3My9oAQ13I4mpswI8n2yRxA0TxVc1wHCj4iGvkMEElD8uGHqcA8adHH9AKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5571.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199015)(38070700005)(33656002)(86362001)(38100700002)(122000001)(66556008)(54906003)(66946007)(76116006)(8676002)(55016003)(110136005)(4326008)(316002)(66476007)(64756008)(2906002)(5660300002)(52536014)(8936002)(66574015)(83380400001)(478600001)(186003)(66446008)(53546011)(26005)(9686003)(7696005)(41300700001)(6506007)(71200400001)(142923001);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/wStPaPdtCgtz23sZ36qYxSvDFnJyor5XNcNAY+C8fP0qRwalJhMC8GZ87?=
 =?iso-8859-1?Q?fcX7J+W837tBJL9CdME93QqQP2PML5CkI5NgLna+OIu/wAMtasStdw8N/a?=
 =?iso-8859-1?Q?y/+uw+f4YGOlyLVYw45+aaIlOb5YgOEiFA5mAr6GbJ4UiNlcmVazi3Rars?=
 =?iso-8859-1?Q?i8ifD7I8OD2HAejUi/7U+KlFfVhvAYI9Wio/waL+onIFCiVdsEc3UmHCz7?=
 =?iso-8859-1?Q?bndwXe/FRQE7czTr6ac4xFn5XLKtxfa7py+YG5tA1S+tOBZDzLSB31qr3y?=
 =?iso-8859-1?Q?Yug6UJ635OJxfuA+Dg8jZIn5R8zYj8PEwuLqIc4noV3Bd1hnchCX6de1kL?=
 =?iso-8859-1?Q?bE3rUYEePud5sAHk9S54RVmkFl9qKn9b9B+qkbA4oy0rih+bZZ7bKdAWJh?=
 =?iso-8859-1?Q?wLV+SqITYEgZqDMTewmcAVSjbr4W5wuYJrpQhNdYNzrbBqxxpu5BEAh23F?=
 =?iso-8859-1?Q?JYtTYUHTABKHmwFmq7ABoc8/vh8HRPsOYUnJt1MwEzK1j6mAUY67pWPmtb?=
 =?iso-8859-1?Q?pXH2wrQEg+2cY/vg6HATIsQdx5GmqRutX/dqLQlfubrJdWB6yy+xeZn1E9?=
 =?iso-8859-1?Q?BGOPNhqpC/tRaM0BA8zCNy+swAJbpA3POayT9zGGGw/rTIKEJXjUxOrQmS?=
 =?iso-8859-1?Q?7NbMOgG5ozRJu51i7+gFNRaF1eJUnYDi2sxEGZ7OgZPf1OphaOFBTfQGvs?=
 =?iso-8859-1?Q?0nbebfDJ1tG0yzDrd5U37IdVctkDs/V49bjSMhTGRk2EnG9xv0KexujtAP?=
 =?iso-8859-1?Q?SlHBf0LxvCtfiDY1qaAnOqQU1JfiNL9qVIgqbQ6CsnrDyJy2Sps43sBful?=
 =?iso-8859-1?Q?kaUfE8l+55z218tU2oTGTo0bBkoKgy4soZU6Ar56CragMjOSBg+j4bz6Oy?=
 =?iso-8859-1?Q?Rw2Iaq+cTbMQnWQHa20A66jbr45atECprneVNOuF1CehWmZxqbwKHF5Ujw?=
 =?iso-8859-1?Q?u6+SxRi39xf3Fk+Y4oU/7/fvmvmNHvuH9/64rU6N1ITypx3T1vL8MmwXA3?=
 =?iso-8859-1?Q?BBKLQqwgeeFaDvoTurZB39wZ3vlWj61bCGjRf/vY7/5K9cDEvXzVOf2jmQ?=
 =?iso-8859-1?Q?7KkuSxBI4LLxaw7LjRwz7y+4TO/U82VPEjCZp12+GaFjqiiHZwEuQlv3ne?=
 =?iso-8859-1?Q?LM00RrjwozYgdQGUOm9qfRCKWYZwZURVvV6yAXxRSgyKlFFVfNtZcbQfUF?=
 =?iso-8859-1?Q?zXtWrB/6j21LBfs4sKMC2rI/84kk97+od6xkhGjdKBHYjUX/TlVRV26lp6?=
 =?iso-8859-1?Q?wlTAkJss1z2eOz/q49aFjaX2hOkqBXzqspMhe92DzYb4gQTD7Ljq2t0b/a?=
 =?iso-8859-1?Q?Bw1AUqoJYS20mZ5vCeymsflFo2Y2XN2VbKdqQ8p3Ctxp55mZtv56TK2vtR?=
 =?iso-8859-1?Q?l9Mvdxqnf+MNXSDNCG/CsRCORRspynlThkNsbrUWg83cVa2FKvoEPY4lVA?=
 =?iso-8859-1?Q?Qc0TDTH7H32EI+4orRTVtdIf4Cudo1F929CkbrYrvTlQcYSmUzZbYQFil9?=
 =?iso-8859-1?Q?5jcU7oanhiK83mjVvZOO23vmKMxkjMxm0d3iyXSn6XbdMBWYBkDIgHNilI?=
 =?iso-8859-1?Q?iI3Qfy2AVCo4LEWLGPv8RvHIXsBXnomn7zP/jHdV05RSV61axauHQghzou?=
 =?iso-8859-1?Q?uKzs8QKglD209Uj1XRbkFhaFnDKAuoUMiN?=
MIME-Version: 1.0
X-OriginatorOrg: mathworks.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8020
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mathworks.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> -----Original Message-----
> From: Junio C Hamano <gitster@pobox.com>
> Sent: Monday, September 19, 2022 1:49 PM
> To: Jeff Hostetler <git@jeffhostetler.com>
> Cc: Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>;
> git@vger.kernel.org; Eric Sunshine <sunshine@sunshineco.com>; Torsten
> B=F6gershausen <tboegi@web.de>; =C6var Arnfj=F6r=F0 Bjarmason
> <avarab@gmail.com>; Ramsay Jones <ramsay@ramsayjones.plus.com>;
> Johannes Schindelin <Johannes.Schindelin@gmx.de>; Eric DeCosta
> <edecosta@mathworks.com>
> Subject: Re: [PATCH v7 2/6] fsmonitor: relocate socket file if .git direc=
tory is
> remote
>=20
> Jeff Hostetler <git@jeffhostetler.com> writes:
>=20
> > Aren't we in the middle of a transition from always using the global
> > "the_repository" to a passed "r" variable?
> > We're getting closer to being able to hide the the global symbol, but
> > we're not there yet, right?
>=20
> We may still have code that works ONLY on the_repository, but letting a
> function take "r" and lettin it ignore is worse than leaving it explicitl=
y limited
> to the_repository only, no?
>=20
> > I'm thinking that at as long as the global exists, we are not safe to
> > have multiple "struct repository" instances, right?
>=20
> By itself, Not at all.  It is the code like I am criticizing that makes i=
t unsafe.
>=20
> I do not mind adding
>=20
> =09if (!r)
> =09=09BUG(...);
>=20
> at the place you have the "sweep it under the rug" band-aid, though.

Appreciate all the insights and comments. Where are we landing with this? V=
ery close to the finish line and I'd like to be able to push these changes =
over that line.

-Eric

