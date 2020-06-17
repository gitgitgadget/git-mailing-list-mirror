Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3C9C433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 18:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A37B2088E
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 18:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="HgE+PJjb";
	dkim=pass (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="kv/DYU8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgFQSc5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:32:57 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:37022 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726913AbgFQSc4 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 Jun 2020 14:32:56 -0400
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HIRY3h019931;
        Wed, 17 Jun 2020 14:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=QZ0kwsDQXwShJfWjcd+RL56pomSKfBdYoqIDSh1VPJ4=;
 b=HgE+PJjbcR3jMpNvcptrmh1hDS+bNLYaY5+Xsa0TfW1dWiEsYs9r9qExMbRNIlynGcc5
 htLb/dOdXqfBmMAvCM0qSV4pwOtqaoGIwsFd4R09apvsBhbZ38FS+PdxbPVC70FMeZVt
 YiKg95lAorY42ObkfNIG5GUYg5z0r/6y5SCxkqYdC1Uup3xr9TvHc7ZFKhkw58X57V/9
 3DzsVKA/O7P3sbe6J9I6CldIQoc1343L542XgIA0N3Oz2KmLjmEGaxVVDDh8k3Pqs7Bj
 XFJKQYeA2MC7hvxEIKPJ5dQ88A1fb9O1Y4xmKGnc4fGeNdzaDBwB4HntOW0p0nnTc2d6 CA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 31q65w3num-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Jun 2020 14:32:43 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HISa3v084182;
        Wed, 17 Jun 2020 14:32:42 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0b-00154901.pphosted.com with ESMTP id 31q66d7392-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jun 2020 14:32:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQ3smyS0LITk8fA/JfSqZF1b3VTs54qQz3c0SNXyVWJWpTuGKggxoonGfHtyiE4BhnLGpgwZNj09vGkV7CQuGD7FJ2Zf7n6fPAyIdWBoeDv9Q3GetCxdVaPGfhw1YWBL4YmAVF0rk6TDxuNQR2UlsDLhQYkFXuVkcy8eKka6DCZ3CaBTG6ITO+L+lNp9GwiC3UHQ33/G2bIjJ6p4P4DZLQeCAZ1Ee+TE0pTyyvCAQRyxIDF+HK8ksUv/l7iWNVoptvsBzOUzTvrCyjMpwKnE1xY9Y7ucJ6OXmQHr8Komy+izWnriTM1JVoT0GJg7khnR11hEZEAyt70Vj/oXBG4BbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZ0kwsDQXwShJfWjcd+RL56pomSKfBdYoqIDSh1VPJ4=;
 b=Bj+sNnibIFcnNMl+YoERX3pAacglnY9mS6nGMiJWJbaJ1aSxwQOMuwnwysnARflg0ysZkgQZotL6rAnoLhR32O15juuL4/s7HxWr0WZEQumfRBILui36KcNAsBJREtYCfodf7er164Uupg/Ei7GYiCgaxtDib9XadgiYrl6/H0nQJj3bgOMrXVFEvIKIAOUL4karHRYz24viMb21zn7E6Z3SDR3uy61icVCQ1X5daWMdzSnAIKS4QT96kbgKvy1mSxvAD4phmwC/NSQ/rJNgfnK/gINBHMZbhSpWFX68NvSbU7YIfY06EN7OLYtHIXN94d7+rzLubZoQvWiG+4J8Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZ0kwsDQXwShJfWjcd+RL56pomSKfBdYoqIDSh1VPJ4=;
 b=kv/DYU8fOZdIK+v18YpTPwJ94Pa9vSP3o318zWtWoA5e+SYbbLiIvOpdrMVZbr0yTIaqTdy7kaqsUxLpxMPjcUvdGGoyFzkSRHvusVbN79g5krrobteq/QUXWakCw4LLGD0BDrNSr7un/1qA9EYAOa1Oty7bArqP4jmSwteCYcc=
Received: from BY5PR19MB3400.namprd19.prod.outlook.com (2603:10b6:a03:181::26)
 by BYAPR19MB3013.namprd19.prod.outlook.com (2603:10b6:a03:b3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Wed, 17 Jun
 2020 18:32:40 +0000
Received: from BY5PR19MB3400.namprd19.prod.outlook.com
 ([fe80::2008:3bcd:b8ea:126b]) by BY5PR19MB3400.namprd19.prod.outlook.com
 ([fe80::2008:3bcd:b8ea:126b%5]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 18:32:40 +0000
From:   "Curtin, Eric" <Eric.Curtin@dell.com>
To:     Stefan Moch <stefanmoch@mail.de>,
        Philip Oakley <philipoakley@iee.email>
CC:     Sergey Organov <sorganov@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Geary, Niall" <Niall.Geary@dell.com>,
        "rowlands, scott" <Scott.Rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Collaborative conflict resolution feature request
Thread-Topic: Collaborative conflict resolution feature request
Thread-Index: AQHWQMCn0onLmOAyQEGi/GXRui4z8qjWdTOAgAAG3/+AAAuTAIAC7BoPgAAUTYCAAfpnAIABo5Xh
Date:   Wed, 17 Jun 2020 18:32:39 +0000
Message-ID: <BY5PR19MB34004535CCF180CE5C63B731909A0@BY5PR19MB3400.namprd19.prod.outlook.com>
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
 <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <432b9e0b-eedf-6d39-ebc0-0416f8574afc@iee.email> <87zh943bda.fsf@osv.gnss.ru>
 <39c45b18-194c-0ff1-4a6d-1db8dee788c7@iee.email>,<fe2cd745-29a7-3341-d321-4199b184bc96@mail.de>
In-Reply-To: <fe2cd745-29a7-3341-d321-4199b184bc96@mail.de>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mail.de; dkim=none (message not signed)
 header.d=none;mail.de; dmarc=none action=none header.from=dell.com;
x-originating-ip: [137.69.117.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5615138e-6164-439f-c616-08d812ecd0fc
x-ms-traffictypediagnostic: BYAPR19MB3013:
x-ld-processed: 945c199a-83a2-4e80-9f8c-5a91be5752dd,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR19MB301388DCD1E29459D31AC672909A0@BYAPR19MB3013.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fJlNKQCgkwn/dyD3U2VPeAHdnruSeRqLm9R715U4/lG9F3AH8xOu69KVm8m6R3+UFkq0pJNYmead7NfzrpigGQwGpMXQFBzr1xRKX4SRWuxtmvba6qcMt+7IA1ywRhb9c0XfwpKH/uaBmXguJc88UMbMqiYf2N4tKlHyoWCZIa74PnmtMGvVA+fMMYz9Yg5jKUpLa1gPoPr48JbbqVJTsUxmlh5az5g2LRSKt9V4KRK423zFZSUqg1sRDPEvADlemsE7v7FC2TKIMdxjYEbHLmMWVkGT1hGhpf4Oa2d999SQxG/TiY6SUtwBtYLZiyynuh4VIuZGobgOaGrKVZLxIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR19MB3400.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(346002)(396003)(136003)(376002)(7696005)(8936002)(54906003)(786003)(110136005)(8676002)(33656002)(478600001)(9686003)(316002)(71200400001)(2906002)(55016002)(186003)(76116006)(52536014)(83380400001)(4326008)(66946007)(6506007)(66476007)(26005)(86362001)(64756008)(66556008)(5660300002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: lCnBAaE/k2GK6wmQ0xe9r2VG3S3HKWipYYyx6wzD3bhNu1vm9dQQng2PnIUDhB5XVysi76YCPEyvT4thvmbwWU63MjFX6UzQrXH7nj1YAgJt21oBe7oYu1ERSc5sMMEHBF19dn2wgRdmSf6RDa64SBZ6ajLrpldsRH5Qof2xsS4qxVpcM38sTrHaaTv3Ou5iH8615y/FvtlLsOdkeFw7Tc9OV2nlw600VYMi8Xd7A2XfkgHkXsIp88f0UpvLclN9nCXXKT1H5vRPT/NqMMxLuVivm6vU4y0MT2IVgpLpkddcjxJ2DX/lXq/auNl6l/PonZTrQ4QNUf9wpaYN78pWnpem1g54HMlwXn4pLdfx4n+sps+gRtOp5VlgpJv1bLCcqHTFq+EiX8Qa4jQMvqnlUEMkjr1k0PPthALp1/C6SMGHeGzNqKpJsCgBg6SQ7U65Pi8nsRE2xkxcBD/TUJxOtuu2gZ8sbMVVTCkH+DKg1+rGUSL4mnAzkxtj6KCw3NhC
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5615138e-6164-439f-c616-08d812ecd0fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 18:32:39.9284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uiPUppWcWurYi36QrC7Wv5Enj6QDnmyyahkgeHRgbJif7NYSfk22K+RGu9JV2oZ5SYc77FALLR6ADFDpoy44ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR19MB3013
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_10:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 priorityscore=1501 cotscore=-2147483648 phishscore=0 mlxlogscore=688
 suspectscore=1 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006170143
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=771 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006170143
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Guys,=0A=
=0A=
Yes I think you all understand the conundrum well. Conflict resolution=0A=
by definition is a collaborative effort, but git doesn't support it as a,=
=0A=
collaborative effort, only one user can resolve it in git. It will be hard =
to=0A=
change my whole orgs thinking around avoiding conflicts or making=0A=
them easier conflicts to solve. There will always be some conflicts.=0A=
=0A=
>  * developers do test merges on temporary branches between their=0A=
>    feature branch and the main development =96 or other feature=0A=
>    branches if necessary (maybe create test merges on a regular=0A=
>    basis to minimize the new conflicts)=0A=
>  * these temporary branches get pushed, but not merged to other=0A=
>    branches=0A=
>  * the branch manager fetches these branches and uses=0A=
>    `rerere-train.sh` to fill the local rerere database with=0A=
>    conflict resolutions from the test merges=0A=
>  * the temporary branches get deleted=0A=
>  * the recorded resolutions get reused when needed (keep in mind=0A=
>    rerere's gc config, see gc.rerereResolved and gc.rerereUnresolved)=0A=
=0A=
I certainly want to play around with rere and see if it helps things. I=0A=
suspect if I shared a technique like this with the 100 or so developers=0A=
on the project this will be deemed too complex though.=0A=
=0A=
A per file solution isn't great either as some files can be large.=0A=
Per-conflict (between <<<< >>>> in a plain old text editor) is=0A=
reasonable.=0A=
=0A=
What would be most ideal is a:=0A=
=0A=
git merge=0A=
fix some conflicts, not others=0A=
git push=0A=
=0A=
so someone else can work on it kind of solution....=0A=
=0A=
We don't do plaintext email patches, we do typically merge=0A=
things via git cli/protocol or via GitHub Pull Request.=0A=
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
Dell EMC=
