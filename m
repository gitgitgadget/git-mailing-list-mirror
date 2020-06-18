Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BEBC433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 08:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9004F20B1F
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 08:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="qT6zZd1t";
	dkim=pass (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="MUsuJVv1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgFRIye (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:54:34 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:20410 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728823AbgFRIyA (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Jun 2020 04:54:00 -0400
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05I8plW8006302;
        Thu, 18 Jun 2020 04:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=ovdigHnPZKYg177HwToxla16RsxKo2tgtYj//mABeJA=;
 b=qT6zZd1toZ4MbbO0n1QEhoLIduUUfUd193Duh8XyurDa6TOL9+BK9o+q3zKVqYYKz34S
 oulkiuuyKr+SQxSyhWVUTqcNWpTYJ62Z0IT79jOr263oB9swdyWQ6mV8wOenYxAM0gUu
 jY5f/9D9tUzXPMm+R3fAdZ6YdPIt3ooIU3KcR1L+b0ldF1OPh7V32vpRN7tl0bCYim2I
 vCaZkXXMvcvDJfhrlYkhY0eOh003EanaNaBY1K3jLHBxoRnHFEhOlQFTfWK6aEiQO61d
 dtcW4jfCIWAt/2dqKwzgXgnN53IGVVsmnlatfnRq0HNkihtmZnSmJiswo7qxs8Q9eiU5 jQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 31q67xwuu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 04:53:55 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05I8mOG4139559;
        Thu, 18 Jun 2020 04:53:54 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0b-00154901.pphosted.com with ESMTP id 31q66dg18g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jun 2020 04:53:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4Y42Pn55SWrll1vGR8Eoqh0qdULG7ddHG7S6Gc0pbhIRs3+xW+OO8GW4Pns20I9S9Odp/gl103OiWvgVD27Ljy7eXzEGjlxluAXhA8MQYidnDbE3iwcdsgkDrjUCVlsTDaxGN926uLIHYixfxqb9YvjUvuu53udHCwYd3HmYtKyEqWMG9bBnQjZpxigf9Kl5moy8ywpF+7g2ovIj+HMyy/XqK1rmOOcZZXRDxTzvi8ysFM/QV/9iN4W40SMqfdfu/TB2cvH3BzHo/hbKvb7s3mEvXu/liwmQacFydjOQKJHO6FguvroqbNkGUWgbb7Fe5DHtsukZ0aS7x23VqriFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovdigHnPZKYg177HwToxla16RsxKo2tgtYj//mABeJA=;
 b=FiZUtvlVwWGNQ7i6fkBpazUVZp3tqi38NyS8rRu2mO7jD5TjL58YXMQE3z1nYFjWARgjVijDEjuUWlDSdGj5DkXmmcJ/4ORwgImOdPteg3GzMVqNlUcuF4y4GubocUiF8Q8hLsNBqzVm7uzWsASNCgfuvRlcW+KBXpQ1J6qrD4XhUsh03QwQ0jM0ow7NjpIWjAzTmukN2pXXQftJWYZKiDA+n0uV2voH7WLPSzU1FiFts4ELMdVqxv6AreA6A+T8f/6LPQI/mUEMwgPEFEXN5JNjWmRUPfOtmMkU1vZ3ptoSNLuO7m/N1/rP0bNTo17oYZb98gN49KaQXoLFqUztoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovdigHnPZKYg177HwToxla16RsxKo2tgtYj//mABeJA=;
 b=MUsuJVv1RNhE/eDmRfABRFN6CrOX/4sgwumjm3NoWTJbdKBQ7bFdaLrt9hsHuLHyzajW0byTONVlUTEldXy+0WDOEar8ID5Iz8V+sbHpY2odqm1a+wVHCv6tTB2PYqWaBKxFISYSDcsnpvVIL4D/FGojGfc2yP1zJMLdRxXinr8=
Received: from BY5PR19MB3400.namprd19.prod.outlook.com (2603:10b6:a03:181::26)
 by BY5PR19MB3490.namprd19.prod.outlook.com (2603:10b6:a03:1c2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.25; Thu, 18 Jun
 2020 08:53:52 +0000
Received: from BY5PR19MB3400.namprd19.prod.outlook.com
 ([fe80::2008:3bcd:b8ea:126b]) by BY5PR19MB3400.namprd19.prod.outlook.com
 ([fe80::2008:3bcd:b8ea:126b%5]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 08:53:52 +0000
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
Thread-Index: AQHWQMCn0onLmOAyQEGi/GXRui4z8qjWdTOAgAAG3/+AAE1tgIAAJXiKgAEnG4CAAVRHkIAEpDkAgAAFwVY=
Date:   Thu, 18 Jun 2020 08:53:52 +0000
Message-ID: <BY5PR19MB3400CD5482C8837E41DFEAF2909B0@BY5PR19MB3400.namprd19.prod.outlook.com>
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
 <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD0aoNQNcNJytJBazoKj0jvWwykntHHgnYoCBXr6OmGOnQ@mail.gmail.com>
 <xmqqa716zs7w.fsf@gitster.c.googlers.com> <30661592138737@mail.yandex.ru>
 <BY5PR19MB34007DEED68D13003C614F5F909C0@BY5PR19MB3400.namprd19.prod.outlook.com>,<CANgJU+WfW4mKotMwFS+2Kaq1pDysgJutJ2NhUvyvGgowk8JXsg@mail.gmail.com>
In-Reply-To: <CANgJU+WfW4mKotMwFS+2Kaq1pDysgJutJ2NhUvyvGgowk8JXsg@mail.gmail.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=dell.com;
x-originating-ip: [78.17.145.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c953906-2343-4663-540b-08d81365201b
x-ms-traffictypediagnostic: BY5PR19MB3490:
x-ld-processed: 945c199a-83a2-4e80-9f8c-5a91be5752dd,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR19MB3490A8240C78E9D7880ADFD1909B0@BY5PR19MB3490.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hf8ULrQnq2LFKiP7KXFXUWRs/I2LZ3qVMlFavifUca7t4aAeIE2+Q1o1DvdT2/hUOyYFhQwiXKMyAt+si/wojHmftKFe+UlQUzIYeT/2nh2M0h4QwOnusW0ei1ROpCcbEWR5B2jO0J3QGrS6Krt4a3pgGPO1hf4es/K7HFoU9NJqcvtUX/5RuNAZGfJFRAfLEzzxNjnMSJ5m+dJoc1wD15GF+xIv/7KX/N8Wqv3VX7ySNhrs4YH69LpyjUt5BCKO56Jf7XkYsi0YSGAQBj+IUtV/w85NnwvH1Fd/zVpeNk+WzCqTEvRmzsF5ucn4+XqyUjWMlD5It5OSF9nIukePyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR19MB3400.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(366004)(136003)(346002)(39860400002)(2906002)(6916009)(7696005)(6506007)(66946007)(8676002)(64756008)(66476007)(76116006)(91956017)(26005)(66556008)(478600001)(66446008)(83380400001)(8936002)(33656002)(186003)(71200400001)(4326008)(5660300002)(54906003)(9686003)(52536014)(786003)(55016002)(316002)(86362001)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /9NK1DeFhAMk1on/rLDhvRxkSPW2lSFS+/B02m2OlXpIOo8ZJcMQtLy/+k8Z0mmb4LG/XStDN6vRO4sekCEctlie6v1AWiE6PqNHBEwT6D7tX6Fe/WNG8v/sFB98M4GT0D6t4zyt7BRYPtVZaeNdWzkYyUF3GKKl1aTJoAHSTLZcYOuYbgasYo7T2IKEpVS4ebVWIVcD9LxaERGgvdgYAJerCdeFUPBDiwByCOY3n8JjmrRIjsZIK/hyCMwou2A6mZcRyz0VFlfWcb7czMD4rKiCMm4g6qmqKGNpEITvty3PdPjL+8GcquFWLsc889OQQsb8gK5HsmaMfkjCC6xkNPnTUNNvx6k0PFDRGjPyj3+RNBJiUfEE/bqKQRhVp+CGHBfEih8hrt7LyWv7lJh7SPW7ITw1aQcT7dAuo8SWZoxF5aCrn3KPcrLenXIXFDKeY5vXr8sEZ0AaU9UFfso4eto9G/bi48Mwgxj7bMfB4pc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c953906-2343-4663-540b-08d81365201b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 08:53:52.2612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sPsymBy7xj7AG7ngcSKFD5aR/J93E42KevAEGlXi+wBvd3xuIuppsq7knYseZcB0hIIotiSQ2hQp47vGcl1rYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3490
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_04:2020-06-17,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 priorityscore=1501 cotscore=-2147483648 phishscore=0 mlxlogscore=999
 suspectscore=1 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006180067
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=1 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180068
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> And after that you change your workflows so the rule is that whomever=0A=
> pushes first to the "trunk branch" wins, and the other guy has to do=0A=
> the conflict resolution. People will start merging earlier and more=0A=
> often so they can keep the conflicts to a minimum. :-) In other words=0A=
> I second what Philip Oakley said about bad workflows. Merge early,=0A=
> merge often, rollout early, rollout often, vote early, vote often. :-)=0A=
=0A=
I understand what you guys are saying, I agree merge early, merge often=0A=
does work best and it's what I've most often used. Our branching strategy=
=0A=
is split by subsystem (and sometimes specific features). So contributors ar=
e=0A=
not merging to the same long-term branches. So merge early, merge often,=0A=
doesn't help with conflicts.=0A=
=0A=
Why? We don't have so much automated tests, etc. And that's not an=0A=
easy problem to solve although we are trying to improve in this area. For u=
s=0A=
to make worthwhile tests, we would have to emulate a lot of hardware=0A=
from external vendors. Out test hardware is often shared among many.=0A=
So branching ensures that if we hit problems, it most likely came from=0A=
within our group, in the area of the code we are most knowledgeable=0A=
about.=0A=
=0A=
And when your branching strategy is like this, it ends up being the=0A=
branch managers merging and having to fix conflicts, not the individual=0A=
contributors. In our git repo you will see broken commits with these=0A=
delimiters in (<<<< =3D=3D=3D=3D >>>>) in order to "fake" this kind of=0A=
collaborative conflict resolution feature as described in the initial email=
.=0A=
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
