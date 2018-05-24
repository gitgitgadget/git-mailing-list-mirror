Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DECFD1F42D
	for <e@80x24.org>; Thu, 24 May 2018 14:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965746AbeEXOsB (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 10:48:01 -0400
Received: from mail-sn1nam01on0122.outbound.protection.outlook.com ([104.47.32.122]:12656
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965555AbeEXOsA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 10:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM6cJ/PBSOhEHmeZlst1hilN44NtgTIbu18blARBuUo=;
 b=gNgfDQdLk0+lqskAvRmT1oKYhqgX2EMrdtGwa5KKaId8KTArWOXYDX5amg4u/hiZVXmNmsSUV1Ga4TyNSbvOBEJ3+BWSJhoaAnmLFs+j30E50T8h7asrw3rTlJkGQFLxBBdSLdsCr41WxLWMS0CYuOT5/2zvwfZVuVYycGTRA7A=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Thu, 24 May 2018 14:47:58 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0%4]) with mapi id 15.20.0820.001; Thu, 24 May 2018
 14:47:58 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "peartben@gmail.com" <peartben@gmail.com>
Subject: RE: [PATCH v3 2/7] block alloc: add lifecycle APIs for cache_entry
 structs
Thread-Topic: [PATCH v3 2/7] block alloc: add lifecycle APIs for cache_entry
 structs
Thread-Index: AQHT8qT9PRnIcoTlWkinmsK/HB7XhqQ+UL2OgACVQdA=
Date:   Thu, 24 May 2018 14:47:58 +0000
Message-ID: <BL0PR2101MB11060377AB5095E79EA9EA06CE6A0@BL0PR2101MB1106.namprd21.prod.outlook.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
        <20180523144637.153551-1-jamill@microsoft.com>
        <20180523144637.153551-3-jamill@microsoft.com>
 <xmqqefi1sliw.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqefi1sliw.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=jamill@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-24T14:47:57.2594185Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:8010:1:b15b:d177:caa9:26d9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1011;7:3c43BEoMf4w/F7AA8qyf1Ya0m/HqsJhJBUCW0T8yH2Jx3678e+z45/VE45ahgXVfMKJzwGO5kdboxklaATUEFC5EIJTSnIsI6vKkas5TghbGgw3/1tuzBBUM6SfOyNlxgboOn+oZ8W3G4uP2GZmQ8fk4lrMsHKb6HdAOcR2YhPKptPPagr35v4XhTiIkKeX3c/h98IfxKA4Qd9P8cSL6c3/bTBctjOUkkiaF3a7lTjAn+oxk5Ssufq+A8YM1GWIc;20:NlEdowhMq4LWIFZA++Xj8cj3VOZ5O87Lo/vlsLjy+0HLBR7PrctwBcCPr96bzPTzIWeK4eGuBrq1QHtp8AluHbGJbmoZ1SULNYHGlA3kh1Lg+hm+/ZLN7kfdaylTODTd2y+mKAz4g9hAhc4DdKX0ZOyYRMILOx8eQh/KaryfxOw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1011;
x-ms-traffictypediagnostic: BL0PR2101MB1011:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1011466DA1E8C379BD731AB1CE6A0@BL0PR2101MB1011.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(211936372134217);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1011;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1011;
x-forefront-prvs: 0682FC00E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(346002)(39860400002)(39380400002)(189003)(13464003)(199004)(93886005)(54906003)(10090500001)(86612001)(305945005)(55016002)(8936002)(68736007)(9686003)(7696005)(186003)(575784001)(8990500004)(446003)(86362001)(3280700002)(14454004)(345774005)(6916009)(3660700001)(22452003)(316002)(4326008)(5660300001)(6436002)(2906002)(6116002)(478600001)(39060400002)(10290500003)(486006)(102836004)(8676002)(97736004)(81156014)(6246003)(81166006)(33656002)(476003)(2900100001)(46003)(53936002)(5250100002)(74316002)(25786009)(106356001)(229853002)(105586002)(8656006)(76176011)(11346002)(7736002)(6506007)(53546011)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1011;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1foSpE4CouRNs0Z36v/IIwgrEx4IVJFm7zNAPY5gr+wGpZYlvyg9wBItsUmnf2H/hde9cC1EtZOg1J1zDPwXCK4/DKDh8jZO2D78AZnhBczvpPQOrp8EdlX4TiOxg9Fgj+kxNBMMggM2EW0CRNFx953dBFpu8FxtDpOc6E1curwnjKKDwslXNTmRPXx82V1W
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e31e66a9-d3b5-4919-2227-08d5c1855788
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e31e66a9-d3b5-4919-2227-08d5c1855788
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2018 14:47:58.5053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1011
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> -----Original Message-----
> From: Junio C Hamano <jch2355@gmail.com> On Behalf Of Junio C Hamano
> Sent: Thursday, May 24, 2018 12:52 AM
> To: Jameson Miller <jamill@microsoft.com>
> Cc: git@vger.kernel.org; pclouds@gmail.com; jonathantanmy@google.com;
> sbeller@google.com; peartben@gmail.com
> Subject: Re: [PATCH v3 2/7] block alloc: add lifecycle APIs for cache_ent=
ry
> structs
>=20
> Jameson Miller <jamill@microsoft.com> writes:
>=20
> > Add an API around managing the lifetime of cache_entry structs.
> > Abstracting memory management details behind an API will allow for
> > alternative memory management strategies without affecting all the
> > call sites.  This commit does not change how memory is allocated /
> > freed. A later commit in this series will allocate cache entries from
> > memory pools as appropriate.
> >
> > Motivation:
> > It has been observed that the time spent loading an index with a large
> > number of entries is partly dominated by malloc() calls. This change
> > is in preparation for using memory pools to reduce the number of
> > malloc() calls made when loading an index.
> >
> > This API makes a distinction between cache entries that are intended
> > for use with a particular index and cache entries that are not. This
> > enables us to use the knowledge about how a cache entry will be used
> > to make informed decisions about how to handle the corresponding
> > memory.
>=20
> Yuck.  make_index_cache_entry()?
>=20
> Generally we use "cache" when working on the_index without passing istate=
,
> and otherwise "index", which means that readers can assume that
> distim_cache_entry(...)" is a shorter and more limited way to say
> "distim_index_entry(&the_index, ...)".  Having both index and cache in th=
e same
> name smells crazy.
>=20
> If most of the alocations are for permanent kind, give it a shorter name =
call it
> make_cache_entry(&the_index, ...), and call the other non-permanent one w=
ith
> a longer and more cumbersome name, perhaps
> make_transient_cache_entry(...).  Avoid saying "index" in the former name=
, as
> the design decision this series is making to allocate memory for a cache-=
entry
> from a pool associated to an index_state is already seen by what its firs=
t
> parameter is.

I like this suggestion - I will make this change in the next version of thi=
s series.

>=20
> > diff --git a/cache.h b/cache.h
> > index f0a407602c..204f788438 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -339,6 +339,29 @@ extern void remove_name_hash(struct index_state
> > *istate, struct cache_entry *ce)  extern void free_name_hash(struct
> > index_state *istate);
> >
> >
> > +/* Cache entry creation and freeing */
> > +
> > +/*
> > + * Create cache_entry intended for use in the specified index. Caller
> > + * is responsible for discarding the cache_entry with
> > + * `discard_cache_entry`.
> > + */
> > +extern struct cache_entry *make_index_cache_entry(struct index_state
> > +*istate, unsigned int mode, const unsigned char *sha1, const char
> > +*path, int stage, unsigned int refresh_options); extern struct
> > +cache_entry *make_empty_index_cache_entry(struct index_state *istate,
> > +size_t name_len);
> > +
> > +/*
> > + * Create a cache_entry that is not intended to be added to an index.
> > + * Caller is responsible for discarding the cache_entry
> > + * with `discard_cache_entry`.
> > + */
> > +extern struct cache_entry *make_transient_cache_entry(unsigned int
> > +mode, const unsigned char *sha1, const char *path, int stage); extern
> > +struct cache_entry *make_empty_transient_cache_entry(size_t
> > +name_len);
> > +
> > +/*
> > + * Discard cache entry.
> > + */
> > +void discard_cache_entry(struct cache_entry *ce);
>=20
> I am not yet convinced that it is a good idea to require each istate to h=
old a
> separate pool.  Anything that uses unpack_trees() can do "starting from t=
his
> src_index, perform various mergy operations and deposit the result in
> dst_index".  Sometimes the two logical indices point at the same istate,
> sometimes different.  When src and dst are different istates, the code th=
at used
> to simply add another pointer to the same ce to the dst index now needs t=
o
> duplicate it out of the pool associated with dst?

I did not see any instances in unpack_trees() where it copied
just the cache_entry pointer from src to dst, but I will check
again.

You are correct, all the cache_entries need to be duplicated
before being added to the destination index, which is what I
think the code already does.  We tried to make this more
explicity by converting the inline xcalloc/memcpy instances to an
actual function.

In the existing code (before this patch series), the index
implicitly "owns" its cache_entry instances. This can be seen in
the discard_index function, where the index will discard any
cache entries that it has a reference to (that are not contained
in the split index). If there is code that just copies the
pointer to an unrelated index, then this cache entry would be
freed when the source index is freed (unless the cache entry is
removed from the src index).

With memory pools, the same pattern is followed, but this
relationship is a bit more explicit.

>=20
> In any case, perhaps it will become clearer why it is a good idea as we r=
ead on,
> so let's do so.

Thank you for your review so far. I look forward to your thoughts on
the overall change and if it is a change you are interested in.
