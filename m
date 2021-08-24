Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4847C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 14:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDBAC6103E
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 14:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbhHXOIE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:08:04 -0400
Received: from mx0a-00209e01.pphosted.com ([148.163.148.55]:40430 "EHLO
        mx0a-00209e01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234695AbhHXOID (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Aug 2021 10:08:03 -0400
X-Greylist: delayed 3452 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Aug 2021 10:08:03 EDT
Received: from pps.filterd (m0131213.ppops.net [127.0.0.1])
        by mx0b-00209e01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17OD8FUl023302
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ncr.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pod1119; bh=HLbwAyrQfbRtHbcpqw4dZ25lJMqtHpRmXgoOC2SPdIc=;
 b=qKILrhoR1UXBaDnkRwsFj1jX43g3rcwKPQ0C21v6NjOWPcQ71BEOrDDTH1+snHzGAFFz
 2tHZSR2Tvpnt+Lg9efy0PVwQ1yLfV8jfqBnYgdd4gWIPd0GvaOXAtAa+hNy/0GGOPmPw
 xj5d+0UVwc7JFfXWqtAHIhZ9zDP7uh4mKp8NS0LHheGFhsHEKc4Vf1JU+d9NYh87B9Tq
 IBgfm8yOlEAT+hl8aJ/ZpEMwIzzvBMI+UUVZ7uRENp0Eh5t5yMtDkPd8JK7A1+Ddpghd
 E6KPAxOlQU91w4t74k+p1T3HG5ObIxEVJ35T6jfoz0x990Flk94IHCbWnNOZesEgBsaQ Rw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by mx0b-00209e01.pphosted.com with ESMTP id 3ambkpey5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:09:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZU3AgLYKJGM8EOWr6rvDyOHRhv+UV2OxMk3u3pI+LkzsymzwEadZKAZnCQQ11DEZHFqUGm5Oj1nNKaGF8pSt+sJj5FqqAAg583+QEQqA0VKBsJlZXiKFUHdxonASEQvg9oIi4RYXKo/ZLDLXf7u8gqL2UBIAfTOUD3OzMY3D2gwYVvoAHM7hz7FgH8qJ8ITi6c/LwImA9Vp6ZKEE+LH5FR5XDbyAUNkGcJMK9Rp1qIbP5KPo2aoMhdPVKqS7W4+u+G1iyAw/LAqOQJZOh9idIhvPGz20ArO5PsDPlPBN+NuGFM+hPxqbv2mEHfKbByR+QYFQx9BP+8fAD0Vt6zK5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLbwAyrQfbRtHbcpqw4dZ25lJMqtHpRmXgoOC2SPdIc=;
 b=nLCx1FhS8o+5lYTiG2ZLcgr6DC/to1NmZGdu80sxdUl24bLFdMSgOS3uMeZsK5XRJ4WWhRFSbJRbCpLw7m4pGLhlA3iI8Tj1olHV1PPTKnYQ6h+IDu6xq4kqnn2wxMIroTKmbsn7z26luU1u2sGC1uMw9PNw5+C9iVvRF0HTZnEKiv5Zmi7uDg4xGk0xPh6M8R0tlDEmsOOdGfeHRFSmqodsOKozPTLZBew6nD28mY5K7VDSA9Joo7B2aTipYTu1WIkakNZy2//cAx6S2XuccYDw/PZq/WRyiPqi12tWdFZ7qOzyCs8+vrMXYaIhfxQupDq8dKAvB03Iwgh2rf0qPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncr.com; dmarc=pass action=none header.from=ncr.com; dkim=pass
 header.d=ncr.com; arc=none
Received: from BN6PR15MB1426.namprd15.prod.outlook.com (2603:10b6:404:c4::18)
 by BN8PR15MB3123.namprd15.prod.outlook.com (2603:10b6:408:91::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Tue, 24 Aug
 2021 13:09:46 +0000
Received: from BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::21ab:b879:3cff:87c3]) by BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::21ab:b879:3cff:87c3%6]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 13:09:46 +0000
From:   "Russell, Scott" <Scott.Russell2@ncr.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Need pull to delete files.  
Thread-Topic: Need pull to delete files.  
Thread-Index: AdeY6H8ipR6+xSVMSMWKMlGGseJenQ==
Date:   Tue, 24 Aug 2021 13:09:45 +0000
Message-ID: <BN6PR15MB1426E3B4145523DB98774C56CBC59@BN6PR15MB1426.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Enabled=true;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SetDate=2021-08-24T13:04:08Z;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Method=Privileged;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Name=dc233488-06c6-4c2b-96ac-e256c4376f84;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SiteId=ae4df1f7-611e-444f-897e-f964e1205171;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ActionId=147c5417-26d6-4a1e-b51f-a8b439b6d957;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ContentBits=0
dlp-product: dlpe-windows
dlp-version: 11.3.0.17
dlp-reaction: no-action
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=ncr.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 219296e0-7cba-46fc-7131-08d96700721b
x-ms-traffictypediagnostic: BN8PR15MB3123:
x-microsoft-antispam-prvs: <BN8PR15MB31234574845A84566DE37529CBC59@BN8PR15MB3123.namprd15.prod.outlook.com>
x-from-ncr-tenant: Processed
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gs2Piuif+6SR9OKSO3HfXIB+dlJrIzgN94ZsZMxGPjlLQcYIeITFTTaX+xNy9g4ctxre4WBbHTXIzGdqzPF8V8wradtXhg9dALh9zmPdU2XRaFS7GhWHeQIUAXoi/f5wk+RoKDxnp6XOkelGKpKyhCiO5SnzfQaBMWV6HN29vPg5xMJ4L7pxqNUwma4M6lrz6/5dYuQ/fdgpAeRCny8qZ0bLx13cXxR8I9Wu/Xg83cgASIZCAtSptXS3Hrz1V8CEayIXUXkgDjxp7lDdFr0IPblHoYoHyCFLyDZDznsQqpXI1Z3hTq2iLws4RqJtfJIRqIKuiWJvHgHhwZQPS6Kdqvp201QIxkvbw8cIufK4tEiQrbDUM1QVVXwR4jDVZF8zfm3zFJoN81N7YEEZy1z/h4v0LMVz4XmFFJYFa+Yq60zcXY0KsoXuul7SyJ0D7q9Rik8APPt9y1wREuH5ppsFbe3Ywn2yGG5ztjEE7Gq9F4HZXcbQ/0G8KxrXayzpwObV/tzgqymE5yJFcBm7XlSvRuPqHTtLTlogoEc7LA47glaGYhUf2SsHun3v0VtA5qVxgRNMqwYaibjXKYE8VgKb2gB3yzkZWrEziNJI3T355ZZYAQofoDLS9GHP4xhiafz2T3wLRmAyqLwi5AJ4jixv1pIO9ov/BxuPagaV3gLohgo0oxsKTPvNk6khDBwQjyoPWtn8xLc+xWuCwXTjVPX9pQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR15MB1426.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(55016002)(4744005)(6506007)(122000001)(5660300002)(83380400001)(52536014)(38070700005)(186003)(26005)(86362001)(316002)(71200400001)(66476007)(76116006)(66556008)(6916009)(66946007)(478600001)(7696005)(38100700002)(8936002)(2906002)(9686003)(64756008)(66446008)(8676002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eaczhv6znJRvq2qXzBojzLK0VEOMf72tYDJzTtG9jWN3Mvt9nBqok+tDtR?=
 =?iso-8859-1?Q?cT5efh4SV4t5R7E44qpEayLWQAjUdyhBlBpvLbW9eSo4wiY7ATaFLe+nb7?=
 =?iso-8859-1?Q?Ng6oCKpeGT55mnl3H1qPqq18+Zc2MLJB2hokn5+nnMa4bTHE6WBipc10Zf?=
 =?iso-8859-1?Q?pOwrPrnfqK7UTMprvLXjwmOX4wJglQ1qeT756unYJH2gyz/WgKT3XLs9fM?=
 =?iso-8859-1?Q?syY68hXmqPFAPDfx5uIF5HKhZOfmWgmCB4OywuBOUytH2Sw7KR2GX+N2h6?=
 =?iso-8859-1?Q?H1rwPyuU8FCemezvdHWwQGWgJ5nZ+uNDHFZstPGauItyFqlO/Ni/OK2kEL?=
 =?iso-8859-1?Q?hh5PgJDV2ZNawbaUk2MSwArJ7Fu3GV6FjgYK43zTMslDz13E0mn1He3Mog?=
 =?iso-8859-1?Q?F+B+C+1ZInXuxlx9OVM5/J2sm6TLlb1VjcS28D+5WRUUo4w/bTb++wBGuY?=
 =?iso-8859-1?Q?RWJJdgXO8fcwLnTq/0xQnEDUBoTKNiVtXMHQyzseo48/zVt61leWy5FBB6?=
 =?iso-8859-1?Q?z9FDMewArZCZAjGX+Hyw/tx3dH8j6V5iIlViYDvsYis5PqP5FSfPx1PhGH?=
 =?iso-8859-1?Q?qV1B/3BL7MGpri9XhIYqClOSjHnj9xTNWAXUEK7D1Dtzwrx3mzqoEqX26V?=
 =?iso-8859-1?Q?sShYLc+yg9Pae+kqLrg5xobqNMVDRZMrkecJXAFxQsPAsC0L3X7MyRTGBC?=
 =?iso-8859-1?Q?UAkgx2DlwDtZnCAHOP+HBoJzJrHYIk2QWoECSKecZCA6Z9NZ1OYuvRE6lT?=
 =?iso-8859-1?Q?Bc7nMZLlEqLlL4/1RtkWcLwLr15SnIpRlJN47fVUeylv3Zc0mO2Qhvp5KA?=
 =?iso-8859-1?Q?ARmAO0Xw1em6YkNHDrNsrYVz3CskfMO8TK3y00vny3dvzCk5/OL2Tl7Bjs?=
 =?iso-8859-1?Q?S9OUsjM277rzF3VMi0wS3OUludf7QuVrzQJXC7t+ath7LIt+ozIBzKfdkh?=
 =?iso-8859-1?Q?L2VYWx1qyn2+H+WtiWsKrzh0zk71dKkj6ansyLrgEE2+VLTcViernX4Tfc?=
 =?iso-8859-1?Q?eRjQniRXRFi9c68Sf8p6slLbczYOP2FGaR2OcJHqXMU+ap73VGV5alm9t8?=
 =?iso-8859-1?Q?d4pqEdZlnS2NGa6jrjUbaO+x31vR49wNR0qguP+fh3/SWQosDzrFwLoZPX?=
 =?iso-8859-1?Q?A7rm/kvQek9POc4/FO7AMMCWp4mtLKXFBKEjc+tZnvdgHbSHm5TIx+dV4n?=
 =?iso-8859-1?Q?30i4X8vXjgxhQvW8t02XoNG4jDu1pL8XarSbSx5RSGzrUmDisN3C6sS5An?=
 =?iso-8859-1?Q?CT6ca+/JYtJ7X3BQBhZHbS9PpJApx9yE+/tnzEITbf4sJ6Qx/Dg7UbIOWc?=
 =?iso-8859-1?Q?uU8kNW4nIRJjBZcM+xTtiIdRDNmAFl6VdTJHWKGsHJnC/0cAlb3Z18fAAC?=
 =?iso-8859-1?Q?Z+FqMNQq95?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ncr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR15MB1426.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 219296e0-7cba-46fc-7131-08d96700721b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 13:09:45.9918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ae4df1f7-611e-444f-897e-f964e1205171
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t5OS5lQtAZ4AN8p8yodM3qzcz6U4DYepIaBpL1SaAi/o4/74dX5xO4Og1soKhS1l1wbOLFFBaoD2mOY08JHn9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3123
X-Proofpoint-ORIG-GUID: doNOCAUSW_XA6IgFwYnnFMl5dbrpzIkU
X-Proofpoint-GUID: doNOCAUSW_XA6IgFwYnnFMl5dbrpzIkU
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-24_02:2021-08-24,2021-08-24 signatures=0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yesterday, when running get pull, I got the message. =20

Stopping, untracked file in the working tree would be overwritten by the me=
rge.   Please delete fileX before continuing merge.=20

As part of our regular process, we are continually deleting files.  =20
We will have:
File1=20
File2. =20

Then we will add=20
File3=20
And delete File1. =20

We do not want to get a message saying untracked file ...   If the file is =
untracked, then why is git checking it?=20

During pull ( for build ) we need the pull to delete the deleted file.   Us=
ing -ff did not work. =20
On our build machine, the remote ( github ) is the master.   Local working =
tree is expendable.   We want to always pull and merge the remote regardles=
s. =20


Thanks,=20

Scott Russell
Staff SW Engineer=A0
NCR Corporation=A0
Phone: +17706237512
Scott.Russell2@ncr.com  |  ncr.com
      =20

