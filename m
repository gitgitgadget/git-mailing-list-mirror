Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B828C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 09:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAFAC207FC
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 09:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="wSs02dqf";
	dkim=pass (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="k+HC6lhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbgFSJRz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:17:55 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:8500 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725935AbgFSJRw (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 05:17:52 -0400
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05J97YwE016531;
        Fri, 19 Jun 2020 05:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=rVR5TzRfj91EFgklDsqwMu1LMnYmZ1msNHCMHqVc2EU=;
 b=wSs02dqfdGcwoXZSWuwUFd74d3n0MHEbHDxQ17l5LJbdVy15qgQ9iLSWOcUoLjqn2QMw
 j0DRYEQkkgaizpdV0XiRjhsrWfdQutYMmQlYjb0Bm4nvGPfaw6xVIIa5EessDHfRrS8+
 kVA2dj/mvNJladQLWhjj5CkpCdlMVbqVZ0elJHAIm+fh4ylMu9ArAdeAIe6oyt4CNcHW
 gaanvZ0cyYMRQTQfqpS+h2EZZZFFoYXSdF1Zkus2ZquvBqYPVkKfsv4O8kige49CPdD9
 QpEvYi5Y0aX9sO3r8wP9YNiX6ysSX/vDyO50loNbUJZ6WsJ18S7pD6j3YWiDwhNJNm0J cA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 31q65rj7sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 05:17:41 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05J9FKAo173530;
        Fri, 19 Jun 2020 05:17:40 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0a-00154901.pphosted.com with ESMTP id 31rh3axbwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jun 2020 05:17:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgH8dbiY6ukT+tYoMc+TmJiP3IeatwGBNGFqD1h+2676PJPj1GtivMMWogYA974CZwEt+ZKX30UphasmKkX6DtA32RFN3HgTPM4c8qoseOy6rDHhFmoT9IepzshVoVzukOCqqHjnuxRmD+4WFnK+3tkG1g1m8fqniyS4eFK5/kduTUsfsIJfwaKnHnX+BZrGDIK7vNuIrCtzYbx2pGowB+qg1zhHDxnxBDPXVXdWEkTTpcTgP8fhHHvcwLbBvjoLOGPemxFcEylLjeIClyv5J0tGvqA0O5nnzcEUa44tKh80fvWfMFcI/gaDk0vUh3707Ca7DoDMAXA4WvH/DmVBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVR5TzRfj91EFgklDsqwMu1LMnYmZ1msNHCMHqVc2EU=;
 b=mdQ2HlpTAjtQtg+yfbzdLslDK3AB9h/zRe/QqBPvz7JlW3kSlnRaV1yKZAqj8T06ZbOxnhCNe+uIhlaYlQc67ZsI+k5bUGKxZ1eo6o7NOS8H0dQwAcuSs1t98nshOfYNnzRKOtWkZJyqdV69IOX3aR0IQND8HrGUpl61UAfDPqGsLAuDFRaUVTTpUvxxKtphymbL/9GqGRX5C0eTHwNCs6wAQLgMQpr+gw/+pkGI/ZC7CcIBVBUrLDaoBcywy0x9JUX5WkMQVeopp+jADsXzZP9hiXT0v42qt/IulKSWY253ly2UeFoDgkaa/l48xzNNlDJmrUjn1aJqi5ZWT+HIIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVR5TzRfj91EFgklDsqwMu1LMnYmZ1msNHCMHqVc2EU=;
 b=k+HC6lhrRLbplMLx5mwPzuIFdEK5sLYExpT01KYcrYHfv50GA8HGQQEpnmPBdlyiNCA+Vy1jU5gYu1dlz5K07XYDSLEkH5ntYfuGOCyFxJy+KutMTX9oMz4Kx9Vr1SZe4hq/S1rsQClRCvt/JgSRZLUtFb7bF9F4mNNiA0SWEkE=
Received: from BY5PR19MB3400.namprd19.prod.outlook.com (2603:10b6:a03:181::26)
 by BY5PR19MB4035.namprd19.prod.outlook.com (2603:10b6:a03:229::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 09:17:38 +0000
Received: from BY5PR19MB3400.namprd19.prod.outlook.com
 ([fe80::2008:3bcd:b8ea:126b]) by BY5PR19MB3400.namprd19.prod.outlook.com
 ([fe80::2008:3bcd:b8ea:126b%5]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 09:17:38 +0000
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
Thread-Index: AQHWQMCn0onLmOAyQEGi/GXRui4z8qjWdTOAgAAG3/+AAE1tgIAAJXiKgAEnG4CAAVRHkIAEpDkAgAAFwVaAAA7mb4AADcuAgAGCAsA=
Date:   Fri, 19 Jun 2020 09:17:38 +0000
Message-ID: <BY5PR19MB34000FB239B2B7BD996A17C790980@BY5PR19MB3400.namprd19.prod.outlook.com>
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
 <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD0aoNQNcNJytJBazoKj0jvWwykntHHgnYoCBXr6OmGOnQ@mail.gmail.com>
 <xmqqa716zs7w.fsf@gitster.c.googlers.com> <30661592138737@mail.yandex.ru>
 <BY5PR19MB34007DEED68D13003C614F5F909C0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CANgJU+WfW4mKotMwFS+2Kaq1pDysgJutJ2NhUvyvGgowk8JXsg@mail.gmail.com>
 <BY5PR19MB3400CD5482C8837E41DFEAF2909B0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <BY5PR19MB34004D9F72F6B66376F8E986909B0@BY5PR19MB3400.namprd19.prod.outlook.com>,<CANgJU+V7MUC85n-=_yQG05w6MOmSG_ZvmQBJVTk2qRyk=7giZQ@mail.gmail.com>
In-Reply-To: <CANgJU+V7MUC85n-=_yQG05w6MOmSG_ZvmQBJVTk2qRyk=7giZQ@mail.gmail.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=dell.com;
x-originating-ip: [78.17.145.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fad4824-873f-4da0-5cad-08d814319cb4
x-ms-traffictypediagnostic: BY5PR19MB4035:
x-ld-processed: 945c199a-83a2-4e80-9f8c-5a91be5752dd,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR19MB4035569B9ED8E13EFAAEE3CB90980@BY5PR19MB4035.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0439571D1D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s3BGdd724yGU9ZeK0jYgXtcE4rn2AVzcR4wa7+PlSPBISFvkHPjJABtNG5DCTY7H2DtkPATYdLUcHkJlwnezVxCfHBLXzcf6NBZW5vOfSXCi1bOC/hJzaPFxotxCxCxkubdPzZL+vlYZXm/E/Zu6X6czU2dl6uDdYpvsKw+am2maW1DR0tWbEEHgs/P+LhCO/aqghOB3775PlZ8qj92IITismm232RF/a/HrU1qMvg52/Inb0ujmny+WilnW6GbWUCqjdYj3SeUUMYYj8FIDWohBCkThEPpqrrW/HlagmCdq5YaQh7/+uen+sXxj8toXhTRiXf+EEVkSSpK0f+WsYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR19MB3400.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(346002)(376002)(366004)(39860400002)(8676002)(71200400001)(4326008)(186003)(107886003)(66556008)(64756008)(76116006)(66946007)(54906003)(91956017)(786003)(316002)(55016002)(66446008)(66476007)(5660300002)(9686003)(6506007)(6916009)(33656002)(86362001)(26005)(478600001)(52536014)(8936002)(7696005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 3XcW1zN+DmsZPWqBCfW4/F7+1N6fN1/3bwxmPvTYQLR8COYFsCPK62f397HhFCbzSoZH6Aw15Ghw3wDGfknpwm2VxbFqGle/kXIeYAvEmiEggPGD8VuSGeQnwY1GYUPnziuGVni7AtIv1nB3zJlVzYmH91naYQlx5csOYp2DQeQswOLHHDhMxtabmblQha7QZSmuGi5fhRxKvQVbnU+ecoSud8MeAPfmFi891phXls1m+TKYJClnFbRPTfGc3cfedowvRszxenJmtKKqW3GGjG1OmnNuQr3jqgBfjjHmmsdoADfi8QLmev8VypLkI0LvnHJVyhDk1Ga0INPZpwZojq+EGWdrKwyda7cDagiXrZ5WgV+pW/1A3Ut87VSegdiy3FkTDlCcgozYKv35mdV8VMZ5v0+cYRNpgvq/Y3Ss0TdOAz6ePJ4pG0X2sQc1KWihwMmjEROf6aP/NxZBkyeNqIfFp41EafbpeY/52p76u0M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fad4824-873f-4da0-5cad-08d814319cb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2020 09:17:38.5285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wK3ZzKavLhyv79tDZjrmUSwKPImbSQG4HvJs5O4RVHLcb1HFtCKhSeUto7VUWZ71MBV4TVIEz1A/2Y88rVRjlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB4035
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_05:2020-06-18,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=1 clxscore=1015 spamscore=0 mlxscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006190069
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190068
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Anyway, sorry my reply wasn't helpful. Good luck.=0A=
=0A=
Not at all, I do appreciate all the suggestions, I learned a lot from this=
=0A=
thread in general. I think everybody in this thread has been very helpful.=
=0A=
=0A=
This thread has gone a little cold. I did have a think about the sequential=
=0A=
vs concurrent resolutions and even had a conversation with one of my collea=
gues=0A=
about it.=0A=
=0A=
Would it be reasonable if anyone could push a partial resolution but the bo=
ok=0A=
stops there (once a user hits a conflict of a conflict is must be solved=0A=
locally)? I agree it doesn't make sense in most cases to support pushing=0A=
recursive conflict resolutions (even though the other part of me says if th=
e=0A=
users wants to go down that path why stop them? You could even have a confi=
g=0A=
setting to allow N levels of conflicts to be pushed, the default setting be=
ing=0A=
exactly the way things are, none or 0!).=0A=
=0A=
I know in my project we already "fake" this functionality like pointed out =
in=0A=
the first email, it's just unclean the way we do it, leaves broken commits=
=0A=
in the repo, you can no longer use difftools, etc.=0A=
=0A=
Should I even consider this as a research idea for my thesis? Or another wa=
y=0A=
of wording this is, if someone sent the code to the git maintainers Junio, =
etc.=0A=
would it be merged into git?=0A=
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
