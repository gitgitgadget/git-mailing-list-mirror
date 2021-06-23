Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71442C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 09:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DA116113B
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 09:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhFWJjN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 05:39:13 -0400
Received: from mx0b-00279001.pphosted.com ([148.163.159.148]:51408 "EHLO
        mx0b-00279001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230004AbhFWJjN (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 23 Jun 2021 05:39:13 -0400
Received: from pps.filterd (m0112514.ppops.net [127.0.0.1])
        by mx0b-00279001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 15N3jAYZ004817
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 04:36:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lifesize.com; h=from : to : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=dkim1;
 bh=kJgH+U431urGtMo62swXalrZk8ed/IZorNWDxhPhiaE=;
 b=n5ur7t+5Z9rWPB8Xgp3UWYeMOc8SxUJWes6oix7fisZSqlnp3tGcfP9iD1Wy9oYhVlSq
 Nsn7N20OfQyUPhjE02r6O098WZS58gUI/TPTKQQnV/YXOGSEbPtjNfaN+VqQ6fkJcRUO
 Njl6LR7SHLkdLmPjyAYLfr3kSwdzdAKQR47iovwLsvhx4HpTMM61hWeXNLQKIZvTJRDP
 9dsQb98/Y84ZPbdImm5fix2fd5W2EEL3Amimfved9Na3vMRCS14euhx4WcqxmtpD9H5d
 b1T0/KaaE4BQ8LLUyOgdhS0Ycka4CqlORY4y+k6bsalMTx/XWpIKabs9LObNhraQam7e Ag== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by mx0b-00279001.pphosted.com with ESMTP id 39bqwr9n29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 04:36:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiAa41WtlUO0Rfi4efYttaszGJP+1aJbj88n681Dj8iDyZVRG0SEW7b1IwIUKBGr+goS4iRz4FnLs0ABWnQG2uM5tB6Bge0rZ6y1A8Q39ZkHOfqhz8F06/O65Azw5D5LiOPZz0sqKCsyDOaXyFDc4AiOd/vglsdAXkpqct8VfH8QQLuB9d77QVHA3izZzItm94Ax9Dks3sxzsYWMvuwMeMqEglmfyKot32KUQW6MJXoAW8dJhSy/0qOPNeD+u2PbNIqmJWcEqJYvPADH+/25eXx5O8BKsfJ1el7E4CYpTn+j3wLYrGbdVde97tWRFxbsI7kH+LWMYxDuGSbU+/ZQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJgH+U431urGtMo62swXalrZk8ed/IZorNWDxhPhiaE=;
 b=ZPh5MXTozJlTEgm4GDEeMzj2ILg/YBSQcA/v/tvVD3ceoIuejP+TtmlgGwjdXwrBRasv0k4rHEjKGDUn3EBmdFPeoV73JyGdSd/LLNE/hcLHHUQh/vMsvbT8zh8eurdcfOI2zmASg888WMe70wu+I+6q/yzeXXipCzh4UZkwheZYPX4JlYixJgso+27IqJSzYOtHt6niGZbHsXgtNeKFhv/rzMEstbnveKi8oJvBkrq6yvVlw9kRVdqKUegwDHRql8CBlz6GkIknjRQSyoEXeSsE7Daxm+kUbVwFKmJTQL96CdeHCg9ntw/i5/d6JNoRUoJgTJPgH8Z7dbOvyiPguw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lifesize.com; dmarc=pass action=none header.from=lifesize.com;
 dkim=pass header.d=lifesize.com; arc=none
Received: from DM6PR15MB3594.namprd15.prod.outlook.com (2603:10b6:5:1f9::32)
 by DM5PR15MB1451.namprd15.prod.outlook.com (2603:10b6:3:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 09:36:54 +0000
Received: from DM6PR15MB3594.namprd15.prod.outlook.com
 ([fe80::b4fd:d7d9:a0ca:d15c]) by DM6PR15MB3594.namprd15.prod.outlook.com
 ([fe80::b4fd:d7d9:a0ca:d15c%3]) with mapi id 15.20.4242.023; Wed, 23 Jun 2021
 09:36:53 +0000
From:   Mike Moreton <mmoreton@lifesize.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug: git-fetch man page does not document --filter
Thread-Topic: git-fetch man page does not document --filter
Thread-Index: AQHXaBNNCs014b/AvUu3MteoJgUTuw==
Date:   Wed, 23 Jun 2021 09:36:53 +0000
Message-ID: <DM6PR15MB35943E5232F67765D4FAFFD1BB089@DM6PR15MB3594.namprd15.prod.outlook.com>
References: <DM6PR15MB359467B7277CDA31029A6630BB089@DM6PR15MB3594.namprd15.prod.outlook.com>
In-Reply-To: <DM6PR15MB359467B7277CDA31029A6630BB089@DM6PR15MB3594.namprd15.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=lifesize.com;
x-originating-ip: [51.9.72.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61f45e5f-c243-46b3-44b4-08d9362a6fab
x-ms-traffictypediagnostic: DM5PR15MB1451:
x-microsoft-antispam-prvs: <DM5PR15MB1451FD4839689C6FE61BD754BB089@DM5PR15MB1451.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CCzNyNwvzDYgJIASa/KtJkpYqYyCSbKvwMtlROYUr+v8cb/4R9M4gde5VdEDyGTVl28deLnmZLvQdpKmROfMEiwoS0TfbM01NnVDBvRaA0OmHCvA4vd6KMxZCWiCwyqbOn1EjuhYJ+f6mgXYfwJ4AJ2zlVqKCuYsTZnV+yG71vmyHgVaUEKcplw96Djz9jiBWKDBBQP2BLy8k6t4yIKkAKO6+9BhLkLjE9Oop0VGLUviYrb+jTXnw3Sr+NxBRRI2wQwFwUEpBA6J3HTQ/k5qz0pqfAxx3TKbvviJHGeGjVq3Brnw0ttQ881WpwsW2O6mny3xeXD8d+VBXY01laIMhbhrqhENi2yQXSd92R4aeY0byFdeMflmYOmn/tPfxEUeiCDQCCSLfySgTbbSxWVtEivo/HDqE3BrIV3BOL9zZ94TA/I2fcwa95TYqM2xQtgFdyXc81GJ7jynNuT9h638MweHe8wb6DvjyZ3CjxHtiL6doid0jPgXofZkk+nGCuFXktZPexv92X+aU19GtjVfUJN5H8TZoRye4ZDMvkPaQpIOF8FIIqXkxlVQBD9/6SxjR1w+Vo5zXuN8F5Q9KP41PtMHdae+cxIZn9DrXa8cKFdiTQP1mzOqXVpVzm2ANDnrx7LbtyvzRnRGWrbW0mgUKwYut4hOBUhZUvUsgCcmXsPw6+lYDYt0ZUmkLZUfvWMJdrzrrNqK2d7qmqsLKvEbdXDd8Zcwk03TUci4Ibo2rA4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB3594.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(136003)(346002)(39840400004)(2940100002)(316002)(478600001)(33656002)(2906002)(6916009)(5660300002)(55016002)(558084003)(966005)(9686003)(52536014)(6506007)(7696005)(4270600006)(66446008)(66556008)(64756008)(8676002)(186003)(66476007)(122000001)(76116006)(38100700002)(66946007)(26005)(8936002)(71200400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?E+JlxwCW5f2dLMjkHrsOIuEQPZYqQLqG5b6nEQwASmwCAO2b4w5IY9UXrd?=
 =?iso-8859-1?Q?7bjaTx16S/r99zaeHOlMhPpdl9IKhQNn6L4v/73yIcJXKwuc3F98MR7Hui?=
 =?iso-8859-1?Q?qcQbpvgT3zCtVqx5+kcYwrxUruOLeFkkd79l8gGV1IVpIQK/hQfcdy1BO/?=
 =?iso-8859-1?Q?uZ+kZUIeHzQ8py6TYMasESDrjQ5wm+T9A0BAjFhOFkbgP3GS5sqSCABiJf?=
 =?iso-8859-1?Q?e/mF1RTYsVueelMKXXteShTCmbeUGkWwJnQpaq2Ez56W3iCLWoNyavD0ga?=
 =?iso-8859-1?Q?4o9fInuD4Wne7ZCY3pMImQnngQ+i3cr9k3AUKflxzx+swamhayBDYFal/o?=
 =?iso-8859-1?Q?hvlkIMnTTlIsBFBZ+FzW75W0kM5wsbd812udBJ0UkbjjMWyoiVGXR4OnZ3?=
 =?iso-8859-1?Q?2egMM4lB47XwxTXzxa+syA9nFycQBWUxll8hPk5JkxW0KVRtMCjerCcGag?=
 =?iso-8859-1?Q?+4ByLK4mAAoLUdLCv3og0LIfEveYwK662AYZ8CecY7XB/4yxI8FVLlSPwr?=
 =?iso-8859-1?Q?++ZWGLAFNWMA77Wo8Pu0W7hj1sCHwlG8Q+mq8bOUGGdNbBEY6AQ7cbioKq?=
 =?iso-8859-1?Q?rpAU9x+pLENfH+jQaVOmFk6NI6p5Gg3bDGeI6Vy1jAPM2h3L/HUh0Q+HGF?=
 =?iso-8859-1?Q?V6k1n6nFBoXw4qiZutfV23zi5gkUudHaIGWmAMnBZwOX+a+vY/16BR607O?=
 =?iso-8859-1?Q?bL+MecA+F+TcFcsom5SF+32lnZTlAxNslMKB71UCcVqqmOSomAZLLCGGbN?=
 =?iso-8859-1?Q?k0va+khkVb2XCsHft872Y7UigVz7QBScTVkXtr87stVTcaDc9G/tTT6wxR?=
 =?iso-8859-1?Q?Kkwh6i+lhjhH36XfUJYQ6h/uHshmw9Wfuqz8ZJMEDOChYxcYfRIN9vMlld?=
 =?iso-8859-1?Q?1szWFLAMxD3/xT8lEzDn2j0jxuMHAqVBSlP8alNp0y/FyisvemTG21Ckjl?=
 =?iso-8859-1?Q?dquxt788rl82CfXHBPFNf3UOcr5OB8M7oje4QetifNYwhykFO/shP2cH8X?=
 =?iso-8859-1?Q?Vop6xreUY8ZTnGhz9MDeD64gdBHOrhJPnMBuh6Xcac4P0VXUYJufBQANIj?=
 =?iso-8859-1?Q?Qp0OK0s9TgfjKG8Mzsy+pyjBuyndzgZXyhrc7FG/3yI9BusgeddLPGKo1E?=
 =?iso-8859-1?Q?NiuNM4DJX0lLAsvUdkeg9XyFLn/+44imALK5Vr6i9K88EqN5b7qgQXuvcQ?=
 =?iso-8859-1?Q?syNuITN7ebYvzDUSGv9vr2slYXyppRPOOPVWWCd0qqI8TocTShPVDtb+SO?=
 =?iso-8859-1?Q?l+u1ct4duQb3vLKwZFMVPq2aJ2Xvap7Ym1YiDAlfThc5g+mJXjfQkdCDIy?=
 =?iso-8859-1?Q?PAeZFYx5hUPMyjJv506+s1Mwta2Z677cMp2eBm7Ea7T+lQM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: lifesize.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB3594.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f45e5f-c243-46b3-44b4-08d9362a6fab
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 09:36:53.8198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1d8e6215-577d-492c-9fe9-b3c9e7d65fdd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W6GABxnaxYkfCdNPqqdscXRGfcLBivar/ittUaSfeJt5TFuK5lBJQI1i2YyskAY/sgsPdHWUyDWUsKxW+E6K3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1451
X-Proofpoint-GUID: BRjdNVdGciyLhJaA42YahtrmswaygxlO
X-Proofpoint-ORIG-GUID: BRjdNVdGciyLhJaA42YahtrmswaygxlO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-06-23_03,2021-06-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 mlxlogscore=445 spamscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106230056
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See subject.=A0 Looking at https://git-scm.com/docs/git-fetch
