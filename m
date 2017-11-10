Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80A131F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 17:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753297AbdKJREn (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 12:04:43 -0500
Received: from mail-cys01nam02on0112.outbound.protection.outlook.com ([104.47.37.112]:30064
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753283AbdKJREm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 12:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9XnD8zPNavXDarCKFKMfyt0L7g6vLr+TtSe/qkkjQ3Y=;
 b=o1qmGC0aoShhSNc84JcQoRvw+6aN81yPf7vdgKnZnxeN6DpjnjXJDYSdk225ag8TQXvzIj60VvatO84TaB7jkV+eMjq74D0e/tG9rYblKZbP10RsG1ZOij8ylIQa1kFuGdN231WGi5WWEuIhQWCcegtP9jh2x2H2xThA7dPVMvU=
Received: from CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) by
 CY4PR21MB0694.namprd21.prod.outlook.com (10.175.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.239.0; Fri, 10 Nov 2017 17:04:40 +0000
Received: from CY4PR21MB0855.namprd21.prod.outlook.com ([10.173.192.144]) by
 CY4PR21MB0855.namprd21.prod.outlook.com ([10.173.192.144]) with mapi id
 15.20.0218.004; Fri, 10 Nov 2017 17:04:40 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     Peter Krefting <peter@softwolves.pp.se>,
        Derrick Stolee <stolee@gmail.com>
CC:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: RE: cherry-pick very slow on big repository
Thread-Topic: cherry-pick very slow on big repository
Thread-Index: AQHTWgioFYgrNrzOsUO3JkoI8kDBwaMNZuoAgAAmRwCAAAZZgIAAEjOAgAAobDA=
Date:   Fri, 10 Nov 2017 17:04:40 +0000
Message-ID: <CY4PR21MB0855CA8ABB6BE4F176902F36B7540@CY4PR21MB0855.namprd21.prod.outlook.com>
References: <alpine.DEB.2.00.1711100959300.2391@ds9.cixit.se>
 <20171110102011.yqtka6a3wmgcvkl6@sigill.intra.peff.net>
 <alpine.DEB.2.00.1711101333030.2391@ds9.cixit.se>
 <7e242038-50e5-2cfc-e810-401af78b8cdc@gmail.com>
 <alpine.DEB.2.00.1711101436270.2391@ds9.cixit.se>
In-Reply-To: <alpine.DEB.2.00.1711101436270.2391@ds9.cixit.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=kewillf@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2017-11-10T17:04:38.2566435Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [174.126.248.146]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0694;6:LWghuRyeO4n2xcffkgZk9cJnoyr7qB1Aw5xdmqO5Aq05Ie7RiZ2MXJsvn5mFQyMuOqCptbtksp2/1lENE8nRkR1Vh4tdMgKvriTP9Th2h/jfJFwTqigd9o35diS2t/UA8DJRrydjo7oFiqrQJTcxEWkDnKUBUUTUPLQzIlgxacCis/58x8zF0GHtUQbHUvosiuJvJidhIaDkSzvPa5I/SpIc3fCjIpfAF6msPDONeDks+SwybHp8TkDMmF9l0rVcogXDscrDSOLrsgP+tZ5fVYaCh9HwSKPh5O/O/zYR3/36/fcgNvSa8+G8lhU1JD/TrT2cNZEi/uRgib1cP5trJSrZtCziygQimzwmPjpn2yE=;5:FCCXh3aEmmfDtOMqfDg1kbn9w1C6EAI4iKuQ9kBWRxhqp4k7LHVWfJ6q+epFG20zzsdsGRZ4QTjRFl3p0yMINXeSMZWHmHINn6/B3OGugwzVDVh/rM5CX8yzhbXvPdudBqjKdsw0gDjfYT19pJbis1QUe7hn6rMXl6pWHorwk8w=;24:RgMH/7qRmvEjA9YzCnRJk3gik1bzVKQ0vamTJF36RdEaMgJAvB2DhWxOa8vQ6mbWtH+ZcL0h8g9iuTKaWRSLrf74Ts4IuhoIuO8r7Z7JCJ4=;7:EsZLOQ2sFG4SniOP+HIH82waYb5/NEBo9CbaNOssJDPyUL+q+jbaTLvT+bNr7QV0TrCNATRmzJ8JWxcgFgzhG006P5IAHiXWZT2l96SGWorhLYmgjgRBpHxtl8e//SYNBv9VvNXaIL0cjlv+Jb93eu+9bWu7KfO+CEsRHTTHJvfnJNsLFqWqbBX5FmPggMfr05l5s3/sTEQwKI8M5QaX8Co1AQtlnDlAGm62Nf2FDRJMAOp/QyBMSDEiMZNre9xW
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 7cdec0aa-7b43-4dac-8d8e-08d5285d2176
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(48565401081)(2017052603258);SRVR:CY4PR21MB0694;
x-ms-traffictypediagnostic: CY4PR21MB0694:
x-exchange-antispam-report-test: UriScan:(9452136761055)(189930954265078)(219752817060721)(17755550239193);
x-microsoft-antispam-prvs: <CY4PR21MB06943D7075D0726DDD0102F7B7540@CY4PR21MB0694.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(3002001)(100000703101)(100105400095)(93006095)(93001095)(3231021)(10201501046)(6055026)(61426038)(61427038)(6041248)(20161123555025)(20161123560025)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0694;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0694;
x-forefront-prvs: 0487C0DB7E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(13464003)(189002)(110136005)(316002)(189998001)(81166006)(55016002)(3660700001)(54906003)(53936002)(6436002)(99286004)(3280700002)(74316002)(50986999)(9686003)(2950100002)(54356999)(6306002)(7736002)(2900100001)(305945005)(76176999)(106356001)(8676002)(25786009)(105586002)(81156014)(8936002)(6506006)(39060400002)(77096006)(8990500004)(5660300001)(966005)(66066001)(7696004)(3846002)(6116002)(97736004)(14454004)(10090500001)(478600001)(229853002)(102836003)(6246003)(2906002)(22452003)(93886005)(33656002)(101416001)(68736007)(53546010)(86612001)(10290500003)(86362001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0694;H:CY4PR21MB0855.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cdec0aa-7b43-4dac-8d8e-08d5285d2176
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2017 17:04:40.0499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0694
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since this is happening during a merge, you might need to use merge.renameL=
imit
or the merge strategy option of -Xno-renames.  Although the code does fallb=
ack
to use the diff.renameLimit but there is still a lot that is done before ev=
en checking
the rename limit so I would first try getting renames turned off.

Thanks,
Kevin

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Beh=
alf
> Of Peter Krefting
> Sent: Friday, November 10, 2017 7:05 AM
> To: Derrick Stolee <stolee@gmail.com>
> Cc: Jeff King <peff@peff.net>; Git Mailing List <git@vger.kernel.org>
> Subject: Re: cherry-pick very slow on big repository
>=20
> Derrick Stolee:
>=20
> > Git is spending time detecting renames, which implies you probably
> > renamed a folder or added and deleted a large number of files. This
> > rename detection is quadratic (# adds times # deletes).
>=20
> Yes, a couple of directories with a lot of template files have been
> renamed (and some removed, some added) between the current development
> branch and this old maintenance branch. I get the "Performing inexact
> rename detection" a lot when merging changes in the other direction.
>=20
> However, none of them applies to these particular commits, which only
> touches files that are in the exact same location on both branches.
>=20
> > You can remove this rename detection by running your cherry-pick
> > with `git -c diff.renameLimit=3D1 cherry-pick ...`
>=20
> That didn't work, actually it failed to finish with this setting in
> effect, it hangs in such a way that I can't stop it with Ctrl+C
> (neither when running from the command line, nor when running inside
> gdb). It didn't finish in the 20 minutes I gave it.
>=20
> I also tried with diff.renames=3Dfalse, which also seemed to fail.
>=20
> --
> \\// Peter -
> https://na01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.sof=
tw
> olves.pp.se%2F&data=3D02%7C01%7Ckewillf%40microsoft.com%7C6b831a75739e4
> 0428d3808d52844106c%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636
> 459195209466999&sdata=3DkJtNLAs1LSoPy%2B%2BNADJkuEBPMZVcxkSkKzOEEeIG
> VpM%3D&reserved=3D0
