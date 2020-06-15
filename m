Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBA8C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 09:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48316206B7
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 09:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="eYX0EkZQ";
	dkim=pass (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="DTXivjwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgFOJ2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:28:31 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:62794 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728180AbgFOJ2a (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Jun 2020 05:28:30 -0400
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05F9HBHw019124;
        Mon, 15 Jun 2020 05:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=WEySf+gmglbNSHEwzRVLYrTXD2LGJGa+wAIU2kSNXck=;
 b=eYX0EkZQIPQ+DdtoKYEh4poeqVDv18bZfpNmOAOnF3MEz9Sov0mwwQ7UuOI1O/6CdGWN
 8l+qJLxyj7LUfjAPQ/jUBGsmm+Ij2CerkHKYZDgEVvfn/sYcsZFZ4kvMHhgujutR4+36
 a4vGhSPAOJm68jVAJUioZKqvKsvqTaONPHuILID7WKydAidV70DqmjkM5+I9lFJvHrLT
 Ub/XG1/IVlIfDsGWUzAnmw69lkbuBJzRRM41DHqDMdBPeA2WEd6Q3YW1qWUQV5w4+BMJ
 JwIB5vmNZfhvOweq6CwJ9G/qb25iDJNCuMbJ4Hv/+4UKvZiXEdn4dJXvG7YVZOgM9Ulm kA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 31mttkbujn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 05:28:26 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05F9FK7M103787;
        Mon, 15 Jun 2020 05:28:26 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2058.outbound.protection.outlook.com [104.47.37.58])
        by mx0a-00154901.pphosted.com with ESMTP id 31mu24uqhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jun 2020 05:28:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OooRhMpNqOrcp1qaRp1yaU53ohsWPGG9NayskXrd5qqcqsMcbus6Ey+p65ze0WElA8IP2eEdQkXFaxywmFJMJ9FTyXMlsi1oNDy6glVNyEhElYyFkqdZtX7KCUmTrzYxuTFJIbRPG9E78RTQ2dQGOrde4NxPpl5PjKrgD0i1xzcBUTMeZs2JvP1Zs+4bWRBsTvIQu5rJznyoCQDsJFt9UL3DWE7+nZeyZh+Id5zsVfESCbvfEnI4cfnoOdXNyDQo85dnOPeCsIjRBv/vh5HRWVv1rPgOfUaceMTfxF6UA7+g27JmFksibTvDzor3uMUN1Y73kv5x6b5XVDHUTUZe6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEySf+gmglbNSHEwzRVLYrTXD2LGJGa+wAIU2kSNXck=;
 b=WclVae5S7fDXmYLnhRlw9SsxQigYJ763OMBg5FZe4+QKXoyg70JWUYaTY3pOSGvCkIwyZSnLvvYmrFlALCFL8Yi0oQLCrxvem6nfO4scjc8/jZ5yL3YLDSUMo5aBY2LTgg+G+LazWL0EDeTk+t5CuDe3TB8pQPVaH5rmMIjIIqi+DLbQRTG7IyNGdJjRn08f8f0g5oojTBgvCHPIQW30KMNNL9RP42Pxsr6vjb8iK8PZREz2bzbLoV2m2MzDsy7ZDuP/KL/sv/lWXlpQxr28npsoqjV/pzcvVgLQrIkqPJMDz7d96LT5S4G1KpKHQOLVh1dvEiBlANhMiiNC1ZCYPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEySf+gmglbNSHEwzRVLYrTXD2LGJGa+wAIU2kSNXck=;
 b=DTXivjwZkbVlwegJxwQ/0QORjSYzZdEnGIEKx2GY6p/1fjCT/7tzhdp/CVUrfWBaYj+aYPR7QTE+mVtmape7/RY1iW2gV5esyIOWkqoruTyd8Vc+vbbtRfq1c2EiRttUOKT7rjwBRhJ6kA+Ze1TyTPofQGLrlPDqugiKRs8WE5A=
Received: from BY5PR19MB3400.namprd19.prod.outlook.com (2603:10b6:a03:181::26)
 by BY5PR19MB3780.namprd19.prod.outlook.com (2603:10b6:a03:22c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Mon, 15 Jun
 2020 09:28:24 +0000
Received: from BY5PR19MB3400.namprd19.prod.outlook.com
 ([fe80::2008:3bcd:b8ea:126b]) by BY5PR19MB3400.namprd19.prod.outlook.com
 ([fe80::2008:3bcd:b8ea:126b%5]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 09:28:23 +0000
From:   "Curtin, Eric" <Eric.Curtin@dell.com>
To:     Konstantin Tokarev <annulen@yandex.ru>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Geary, Niall" <Niall.Geary@dell.com>,
        "rowlands, scott" <Scott.Rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "Coveney, Stephen" <Stephen.Coveney@Dell.com>
Subject: Re: Collaborative conflict resolution feature request
Thread-Topic: Collaborative conflict resolution feature request
Thread-Index: AQHWQMCn0onLmOAyQEGi/GXRui4z8qjWdTOAgAAG3/+AAE1tgIAAJXiKgAEnG4CAAVRHkA==
Date:   Mon, 15 Jun 2020 09:28:23 +0000
Message-ID: <BY5PR19MB34007DEED68D13003C614F5F909C0@BY5PR19MB3400.namprd19.prod.outlook.com>
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
                <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
                <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
                <CAP8UFD0aoNQNcNJytJBazoKj0jvWwykntHHgnYoCBXr6OmGOnQ@mail.gmail.com>
 <xmqqa716zs7w.fsf@gitster.c.googlers.com>,<30661592138737@mail.yandex.ru>
In-Reply-To: <30661592138737@mail.yandex.ru>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: yandex.ru; dkim=none (message not signed)
 header.d=none;yandex.ru; dmarc=none action=none header.from=dell.com;
x-originating-ip: [78.17.145.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89398b7c-bba5-4184-6875-08d8110e7383
x-ms-traffictypediagnostic: BY5PR19MB3780:
x-ld-processed: 945c199a-83a2-4e80-9f8c-5a91be5752dd,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR19MB378083CD01904FF036A120B0909C0@BY5PR19MB3780.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jjD0dnsI2ZbEY89gMBUXwIKiBHWVAfYaULXwt9Y2cfQgM/2dANuAvgu0gqCo4j2b6kgtxYkeJf6LcEujQJv4Q10ddRwcAZ0Bi55dfA/2FMTC/tfAQOJ4zqeuT+9IaXAz+q0yjpT/WMafUR9UTLnJR9YEUQ4vDixON09fdQR42HM2AmFFnhuZgpPYdpcMIwbL9fvICeIEBsxOWaFPns15Lrm8du6E7wNtJ1rTmt4yRAyNiWZKKcK0RfRHtapo15l8NGenzgHlpEYA9CA+3VTmaLl4wMjH71WNo+ju8eZT3YyYx8kOrcLbUDT0E9lAIg8mOTlwhRzaGkMjebB0z9Dg5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR19MB3400.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(39860400002)(346002)(396003)(136003)(316002)(786003)(2906002)(6506007)(7696005)(186003)(33656002)(83380400001)(478600001)(4326008)(54906003)(110136005)(91956017)(66446008)(76116006)(64756008)(71200400001)(8676002)(26005)(66946007)(8936002)(66476007)(66556008)(86362001)(52536014)(107886003)(5660300002)(9686003)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 28UiISSDKQJrenmAgpcbHSNIFCeANYxppAl5pC1XyMUpZycrmUQeOvAo4gdfghXKWvB9KErbqiacrKp72CD2JiK0ONzowodN8zYbAKz/h30wgqHZdq6nnoF1AAyvVtcQ0U2qfUuE2ZORcBKkgVZ2Dwi9lnty03Fd2zq4F5p8Enl4p2/1Fv/fIBiFiFXbs8X+SXDyh1YQYRjjW32etxtUZTj0xZMvcbBGqoy6cpgDXblUdp8VPPIbTFwMKDHq1zsKa+v0azzZ6proTqfqjXBscs3nl+Dem2Wf5wbhP7o9VoP5MM21QbbsPtfMw83G2huVO+q6drU5aDQYHWk/VeocTIDvLeAZLsiLJzP0VOJSRdE6bGwzTOcY/q6OZcuAZBsv5DxsQCBIrUjUiTdVYMEESdooXKeRSwqJQqfMLQ4M4qlL9BLCP/CwFOdz6CsQAbtI/yh50YLfRjwDQQjZRhcRp1sbwkQdeHP1XcAGRLDUdaw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89398b7c-bba5-4184-6875-08d8110e7383
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 09:28:23.1215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RZk0G4kQvLj8WUnIW9Ysi7EvYPgJ8zyEu904Pn//ZQdET9SbRBqrMzq/FQZoo2u3I48MVkAgptt1leBNiNFDAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3780
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-15_01:2020-06-15,2020-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=1
 spamscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 bulkscore=0 malwarescore=0 cotscore=-2147483648
 phishscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006150077
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=1 mlxlogscore=999 malwarescore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006150077
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> An aside that probably would not directly help Eric, but I know the=0A=
> above workflow helps reasonably well.  The 'pu' branch is rebuilt=0A=
> not on top of 'next', but is rebuilt with all topics (including=0A=
> those already in 'next') in flight directly on top of 'master',=0A=
> which serves as a way to anticipate conflicts that will require=0A=
> resolution in the future before the topics can enter 'next' branch.=0A=
=0A=
Out of all the currently available options this solution helps. Thanks=0A=
Junio! I played with incremental merge techniques this weekend.=0A=
One problem with incrementally merging is that you start fixing=0A=
conflicts that are later invalidated by subsequent commits. So it=0A=
seems you end up doing more conflict resolution than necessary.=0A=
Unless I'm misusing the technique.=0A=
=0A=
I think in order to create collaborative distributed conflict resolution,=
=0A=
you'd probably need a new type of commit a "partial-merge" commit,=0A=
that is like a pseudo-commit that you can push and doesn't break=0A=
builds. It would be a neat feature, at least for my team!=0A=
=0A=
Regards,=0A=
=0A=
Eric Curtin=0A=
=0A=
Software Engineer=0A=
=0A=
Ovens Campus,=0A=
Cork,=0A=
Ireland=0A=
=0A=
Dell EMC=0A=
