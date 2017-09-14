Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70456209B8
	for <e@80x24.org>; Thu, 14 Sep 2017 14:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbdINO0Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 10:26:25 -0400
Received: from mail-cys01nam02on0114.outbound.protection.outlook.com ([104.47.37.114]:17040
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751131AbdINO0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 10:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=pvwnsxgnotF5DA0GVcMIAbYi1G+8FnAAmr/x1tpkILg=;
 b=XoVcUClKzMSHjzY7b8sm3KXC8rG8fju3QjhR7iQkKzAYsFOKZKA1vYCuwMlHKUzg6m7jeQubxmTA5qgfzvPWWi751TXFqj76zyjhj58aTiyoiYumcQVtzDrPKGzPNfiEYAmt/ogNUDR8EJpMiTWtSBi8dmC2qTx9kqXzyifIBBg=
Received: from SN1PR21MB0014.namprd21.prod.outlook.com (10.161.254.12) by
 SN1PR21MB0029.namprd21.prod.outlook.com (10.161.254.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.5; Thu, 14 Sep 2017 14:26:21 +0000
Received: from SN1PR21MB0014.namprd21.prod.outlook.com ([10.161.254.12]) by
 SN1PR21MB0014.namprd21.prod.outlook.com ([10.161.254.12]) with mapi id
 15.20.0077.005; Thu, 14 Sep 2017 14:26:21 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
CC:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Subject: RE: [PATCH 1/1] reset: fix reset when using the sparse-checkout
 feature.
Thread-Topic: [PATCH 1/1] reset: fix reset when using the sparse-checkout
 feature.
Thread-Index: AQHTKMyCASx4J5FrG0SFSfVy0yz4a6KrWy30gAAJb7CAAH5jR4AAB2mQgAMpW3CAAHk5AIABF7AQgACzS9CAAIOfgIAAA+EwgAAxKACAAVoC0IABB+Gw
Date:   Thu, 14 Sep 2017 14:26:21 +0000
Message-ID: <SN1PR21MB0014031012AEC69CED27FADFB76F0@SN1PR21MB0014.namprd21.prod.outlook.com>
References: <20170908180050.25188-1-kewillf@microsoft.com>
        <20170908180050.25188-2-kewillf@microsoft.com>
        <xmqqvaktxawk.fsf@gitster.mtv.corp.google.com>
        <SN1PR21MB0014638E5D9CBFD0D9D85F10B7950@SN1PR21MB0014.namprd21.prod.outlook.com>
        <xmqqr2vgy2yt.fsf@gitster.mtv.corp.google.com>
        <SN1PR21MB00140C84DC02F3491F4E8469B76A0@SN1PR21MB0014.namprd21.prod.outlook.com>
        <xmqqh8w951ek.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1709111259430.4132@virtualbox>
        <xmqq4ls836z3.fsf@gitster.mtv.corp.google.com>
        <SN1PR21MB0014435A97BCDA324FD55B46B7690@SN1PR21MB0014.namprd21.prod.outlook.com>
        <CA+P7+xqxmxexWS=MWNd9=EqG81uhKY-OdG+1mpyWhst6DvH5AA@mail.gmail.com>
        <SN1PR21MB001473733DAF15BC91C0E58AB7690@SN1PR21MB0014.namprd21.prod.outlook.com>
        <CA+P7+xqcAh4v4gDQOm-feYGc1EmFztAu0zMg2xnp8Gn4=BzkoQ@mail.gmail.com>
 <xmqqy3piz1j4.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqy3piz1j4.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Ref=https://api.informationprotection.azure.com/api/72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=kewillf@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2017-09-14T08:26:19.6706280-06:00;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [174.126.250.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR21MB0029;6:wl9YR+lu22sr39gaO2vXJS2srJvI3ZJmV8IvGy7wUaUpfo9XOleheiTMfsWmMSmq2XrkLqK+4c3T8Xpp5DItZaF3PW/RPNiYa8dDF8x/ABLlUaDg5lLMFJv/WHzH69ZU+068eU7UF4RReVhXsayvC6derjEypiHmdGnmstFDf+QGcBXq73TtF6C06dQAbN/CLpeKPMGmttfPYHq5cWaqCvOLEmu6J7cntzc3aW4K136nGPaBJl4C+bRKO43TpH8LJCX8tF2j5yhe17Dw/DRXY0DT+Un9xUHyUW2ihYAqTUGtpcaLiNxWj95lsHZL6I3zJzW5rtVcmkhI7crzgcjeZA==;5:TIgTegjAkCfxFPC6uhwgc/C3B/72nUcnFXYUb5IGAFvd8EtA2YQPhEEkRbpng7IzFieXjDVOkMzGqu4Vm+oR4yUq7D4uiGmBcwjjjGcpN+HOFtLQoMIwkSZIUZS0VGkELKQlOxMJ3IJUGIwDWI9H7w==;24:8UNXiQ/8ZMfCBrXO445KnVIkhbO7gGA24k/qohFvfJxV2zkzvuKirnMtmiXYHIoKKbgVV2B0frP8P4hwm3CJJSfrxGrHdeUoCzh268wHbQY=;7:i0IFF8dS3zcTXlCyyb1ZpgnZ2IjbXIr2JtNwW0j8xCdSgfXfEemGdL28P7MVDDvJX+gE3seMr+5ByiFOp+WQ19sFeVS5CAvKigDcaTt3e51iZ7r3HdIc4qBKSl0vVpLd3GIaUi/o1dbDA2tB6zlYIVBrpmq/0G0rNGtlUeZd7JMPSYdwDH37tCiIk40sxmY7C4d4RNCxPE74YHxWdAUi602KFgM3JjW8YN/OwiIWRn4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: dbc78d09-eeb8-4c90-3599-08d4fb7c9275
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:SN1PR21MB0029;
x-ms-traffictypediagnostic: SN1PR21MB0029:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
x-exchange-antispam-report-test: UriScan:(100324003535756);
x-microsoft-antispam-prvs: <SN1PR21MB00299D695D43554B407826DEB76F0@SN1PR21MB0029.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(100000703101)(100105400095)(6055026)(61426038)(61427038)(6041248)(20161123558100)(20161123562025)(20161123560025)(20161123555025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN1PR21MB0029;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN1PR21MB0029;
x-forefront-prvs: 0430FA5CB7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(346002)(376002)(39860400002)(47760400005)(377454003)(199003)(51914003)(189002)(8666007)(10290500003)(54356999)(105586002)(50986999)(76176999)(55016002)(106356001)(8676002)(66066001)(81166006)(81156014)(25786009)(8936002)(5660300001)(33656002)(39060400002)(4326008)(7696004)(478600001)(8990500004)(189998001)(6116002)(102836003)(3846002)(14454004)(9686003)(99286003)(54906002)(101416001)(10090500001)(53936002)(6246003)(68736007)(2900100001)(74316002)(229853002)(8656003)(2950100002)(316002)(97736004)(93886005)(22452003)(3660700001)(86362001)(3280700002)(6436002)(305945005)(7736002)(6506006)(77096006)(86612001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR21MB0029;H:SN1PR21MB0014.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2017 14:26:21.6660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR21MB0029
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Wednesday, September 13, 2017 4:18 PM
>=20
> Jacob Keller <jacob.keller@gmail.com> writes:
>=20
> > By definition if you do a sparse checkout, you're telling git "I only
> > care about the files in this sparse checkout, and do not concern me
> > with anything else"... So the proposed fix is "since git cleared the
> > skip-worktree flag, we should actually also copy the file out again."
> > but I think the real problem is that we're clearing skip worktree to
> > begin with?
>=20
> As this 100% agree with what I've been saying, I do not have
> anything to add to the discussion at the moment, so I'll stop
> speaking now but will continue to monitor the thread so that I may
> hear a new argument and datapoint that would make me change my mind.
>=20
> Thanks for a healthy discussion.

Hi Junio,

Thanks for the feedback.  I will give this implementation a try.  I still
have the following unanswered questions, if you wouldn't mind
answering.

1. Does this statement, "I only care about the files in this
sparse checkout, and do not concern me with anything else", mean
that git should not change files outside the sparse-checkout whether
that be in the working directory or in the index?  Or does that only
apply to the working directory and the index version of files can
change to whatever git the git command would do without using
sparse?  For example if I am doing a 'git reset HEAD~1'  should the
version in the index of files outside the sparse not be changed or
change to the HEAD~1 version with the skip-worktree bit on?
2. How will this work with other git commands like merge, rebase,
cherry-pick, etc.? =20
3. What about when there is a merge conflict with a file that is outside
the sparse checkout?  Should there not be a conflict because
git shouldn't be trying to merge the file since it is outside the sparse
checkout area?  Should the conflicted file get written outside the
sparse checkout so the user can resolve it?

Thanks,
Kevin

