Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDC7C433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 09:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 328BA21BE5
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 09:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="D94PBOnZ";
	dkim=pass (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="TOjA6Zgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgFRJ2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:28:43 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:25688 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729146AbgFRJ2m (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Jun 2020 05:28:42 -0400
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05I9LW2H007636;
        Thu, 18 Jun 2020 05:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=eRCTKsPzS/1+XZKujydJSHWrGSNJQo5ndgdF/ahUxGI=;
 b=D94PBOnZEeGIKiDFsD52h5qGsD8snSUn6Vbym1zRgPn8f0nwbf6I+RgOWqJhbjIVpKPd
 TZgGj0G7BUbmjoXz2hY/qAO1n7R2gYxYS0qoS6yKStP0WnHVSBPXNxuq4NYBRSnD+UFZ
 PxvdJDKzllsoo3Te24gWkQOVC4GaGk3d2LNdg+tP478Fcox4+7beqi1ui339ezQHHnoT
 ZaQ8HnvbWyF4DQZssFUAENxTqsbEzjmqGTvyZd07x5IC7RxGqh8tUgo6pgzFyzGxv8Ho
 ZOVMo/74T9RTuidEXCjkUygTb/50VqS7tkkKVmjIOAwFi9iCP3vTh5d+TFFe+mZLGZP2 Qg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 31q67t60sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 05:28:38 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05I9Oixr022443;
        Thu, 18 Jun 2020 05:28:37 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0a-00154901.pphosted.com with ESMTP id 31q64nh97a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jun 2020 05:28:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OedAbnyXN7XRfTJcLOVRLDbRKMe0utMPpPHCow3yqkNHCNewdwqeo7IAO1OcVBOQVSINXc5PIhQ3Ag7CeJfJQehSM73kchS78iX+gPx+ilsNlPzwWJsFTarqDisGqgvcQ11lRZw0NrEo0u+37Ibl2xAWF/KEudrj//lxjcTVMTGZyTn7UZIS0Dqj4OEo0Nx8FT2zIAj/c5zicjgBN34NkObrLILSrSQdaXM3Kxwp/vdYev1NT9ArB/m3ni2bQ0Tj6fxciiu5VswY0ps21WzNXSGd7qP17LokZ6keFX9IlAWux47LA3cELLwa3i8QE6YWhGeVZ7mGE+Md62R17ku3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRCTKsPzS/1+XZKujydJSHWrGSNJQo5ndgdF/ahUxGI=;
 b=KZimQ/NXuUNtv3WVvPQ9aDe5l57kutRkArPYbM/9o6O+WdLAkv3tv94nGBZxEkjvmZcd73yBG5Za6Td9GgTSpVNOKgr1J595lTbWmWozQriPtQO+5H6+0UM7LPAVA9G6DyKy6Y9jQeuoaq0x/pvMT+mezsCvviCm9+yxJ0xnEm8cH2fysDUKKA0WIv5gz/Jz5miyzg0Xh+ji1AMKmyuL9OPckrOcmXkWIekXbqQxR5sX+JPnV6H9zkQUOsyr86c67PRRYTTU4Z38aehJLEmtflzFoQWiG7b07ob7k0yonQXebXweouYHLUqEgNjn2SR/vbZI5kWoSZ3xROpftH7lKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRCTKsPzS/1+XZKujydJSHWrGSNJQo5ndgdF/ahUxGI=;
 b=TOjA6Zguj60Uxw0r7z6LYrWpKn8PnPHLumQPwW19S6xPtFg9VRLk3n4TCX4ZmWTdtQ+F8g6J/oXFR5Ml6VW/oj18q+UgcFAtiNdgu2RK58vL6BaU1ak2Z8IFutx8f2ChaJIfjDwptBTJdArkuU9BSWcNK0eaCJ0g1mC13Wr2jcU=
Received: from BY5PR19MB3400.namprd19.prod.outlook.com (2603:10b6:a03:181::26)
 by BY5PR19MB3908.namprd19.prod.outlook.com (2603:10b6:a03:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 09:28:35 +0000
Received: from BY5PR19MB3400.namprd19.prod.outlook.com
 ([fe80::2008:3bcd:b8ea:126b]) by BY5PR19MB3400.namprd19.prod.outlook.com
 ([fe80::2008:3bcd:b8ea:126b%5]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 09:28:35 +0000
From:   "Curtin, Eric" <Eric.Curtin@dell.com>
To:     demerphq <demerphq@gmail.com>
CC:     Konstantin Tokarev <annulen@yandex.ru>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Geary, Niall" <Niall.Geary@dell.com>,
        "rowlands, scott" <Scott.Rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "Coveney, Stephen" <Stephen.Coveney@Dell.com>
Subject: Re: Collaborative conflict resolution feature request
Thread-Topic: Collaborative conflict resolution feature request
Thread-Index: AQHWQMCn0onLmOAyQEGi/GXRui4z8qjWdTOAgAAG3/+AAE1tgIAAJXiKgAEnG4CAAVRHkIAEpDkAgAAFwVaAAA7mbw==
Date:   Thu, 18 Jun 2020 09:28:35 +0000
Message-ID: <BY5PR19MB34004D9F72F6B66376F8E986909B0@BY5PR19MB3400.namprd19.prod.outlook.com>
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
 <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD0aoNQNcNJytJBazoKj0jvWwykntHHgnYoCBXr6OmGOnQ@mail.gmail.com>
 <xmqqa716zs7w.fsf@gitster.c.googlers.com> <30661592138737@mail.yandex.ru>
 <BY5PR19MB34007DEED68D13003C614F5F909C0@BY5PR19MB3400.namprd19.prod.outlook.com>,<CANgJU+WfW4mKotMwFS+2Kaq1pDysgJutJ2NhUvyvGgowk8JXsg@mail.gmail.com>,<BY5PR19MB3400CD5482C8837E41DFEAF2909B0@BY5PR19MB3400.namprd19.prod.outlook.com>
In-Reply-To: <BY5PR19MB3400CD5482C8837E41DFEAF2909B0@BY5PR19MB3400.namprd19.prod.outlook.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=dell.com;
x-originating-ip: [78.17.145.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbdbf5f8-b4c0-4c5f-d252-08d81369f9a6
x-ms-traffictypediagnostic: BY5PR19MB3908:
x-ld-processed: 945c199a-83a2-4e80-9f8c-5a91be5752dd,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR19MB39089ABF7CCCB79FFA8DEAB7909B0@BY5PR19MB3908.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4MmF+B6Cg7abcXSWZzq1S2ubSy7C7HlPLy40B6rzkwScHNZbKpIF8RxTd8KqLm0yTy57SrcHjkQF35tUkNatgnJ9iTKZOuBc/LNFbdWeXRVDXUQGKAQ/zK0Zzz4HjWKW4AHFMlApmlgny05OiFfa3Ai/IE+ODis5ShUn4Prsj9B8csafGE+ctm6LKf+JTdgEg7J93rTAoBh8qpgjEBm9Gm/tUy+7BK4WiFfUUVZww/WcUohRiFI2ggWk7iUptWmUPmWN529H+XSBNzuidPE0fTvGyVsxnlD5TzqjE3arCSlRksGfQSGUGPm1tZLbMOR5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR19MB3400.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(83380400001)(66476007)(86362001)(6916009)(8936002)(33656002)(8676002)(52536014)(66556008)(66446008)(76116006)(5660300002)(66946007)(2906002)(64756008)(91956017)(7696005)(498600001)(2940100002)(107886003)(4326008)(54906003)(9686003)(186003)(26005)(71200400001)(55016002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: HAwvb1uSrtH8JRpOB36stb/NYkOmN5fcKbnVO/ssi9IPWTydXVtIG0fObLjot534UNt+c3Nc6un0zzMhERfIq17EF9ve3CwgomYzt3yX94eK+Eqnftg5BkYIyI8KCF6hYtooiXLABnJRtpQnAbayCvC2u63vZ2s5WQ1OkfY2PQaykUyokJs38o7k7sHgnoo+qx8ipuI458ySPjT+Qrb7UMFOB3HD1Vh0Dbm8XjFY4uTY171dvNjKJ1PdXMcQRlTqmu+wN+FT9+/PcjlR5I5lIicmWEIfs4KS48LZaksn3WIHO2R0xaBpuE+lGfPWvXgR64pxWi6BFpSE+6aizgLaZlfwVJllsy5WjpruNvmd5AYI/kPLei2hY3KOo2ap9jiGBbtImR7Cb/whiINjG1cCcuLOCPn54sakUiIHeP3DexYLgg4Gb7tQ0sbiYWh70U7OkApfadT2vAJMstoMvsp2sHCt034xFoAwPpKO6984HzXr64WVyXzfV0nccvy24/ad
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbdbf5f8-b4c0-4c5f-d252-08d81369f9a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 09:28:35.2109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3wKYjU96+nPw1HRiIkCOATMyab8KOaTC+WbFgHX5CYS9OZDiCA5/rYpq5tCJKKFi8SREl6AREPt3qevBd2T8FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3908
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_07:2020-06-17,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 suspectscore=1 adultscore=0 mlxlogscore=790 priorityscore=1501
 phishscore=0 clxscore=1015 impostorscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180073
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 mlxlogscore=873 phishscore=0 spamscore=0 suspectscore=1 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180072
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> What I'd like to stress though is that there is a pitfall here: is it=0A=
> feasible to try to support concurrent conflict resolution, or is it to=0A=
> be sequential (even if in multiple turns)? I incline to the latter.=0A=
=0A=
> Concurrent conflict resolution would lead to conflicts in conflict=0A=
> resolutions, that already sounds too complex to be useful for my taste,=
=0A=
> and we already are in recursion that must be stopped somewhere, so it's=
=0A=
> tempting to stop it one level up.=0A=
=0A=
I think concurrent doesn't make sense, only sequential.=0A=
=0A=
> I find that the solution in these cases is to first use interactive=0A=
> rebase to squash and reorganize the commits in the branches so you=0A=
> have a nice clean patch sequence. Once you have the branches cleaned=0A=
> up and squashed into a sequence of reasonable topic based chunks you=0A=
> then merge, sometimes it even means you dont get conflicts at all, git=0A=
> merge is pretty smart.=0A=
=0A=
Again, as said in the initial email, anything that rewrites history,=0A=
recreates SHA's (such as rebase, squash, etc.) on a remote=0A=
branch is not allowed in our repo. Of course with unpushed=0A=
commits you can do some of these things as the remote end=0A=
knows no different.=0A=
=0A=
Regards,=0A=
=0A=
Eric Curtin=0A=
=0A=
Software Engineer=0A=
Ovens Campus,=0A=
Cork,=0A=
Ireland=0A=
=0A=
Dell EMC=0A=
