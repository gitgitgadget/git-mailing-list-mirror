Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE3BC433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 12:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A7F620724
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 12:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ny90dK8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgHUMPH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:15:07 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:50690 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726257AbgHUMPB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 21 Aug 2020 08:15:01 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07LCC8CH030620
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:14:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=N2tZeCA5dfCH2d2SK9XIZdrZUqalMFaOTOEqA6cOu94=;
 b=ny90dK8bshYCjCAlmhe1CiBD7NgH76eSDaJmvWVa9meixtYGNH602hwW8L0OBFL00c47
 a5RsnJ+38FfX07rv0bLYUs4tG3gchRQ+waPrSL1DgrjeNog2fdID4i8MSn2GtSrbraRR
 lsyvPBCf4VywoYCqicN/6X59QmkpVDRx9RX6997U9c8TtldP/6T7qh9jpzkIxQsd9q/b
 7WVuveImEKOeVDqsFs6HW/il8lt8Lrqo5ihWdi9Nduz1Umwsn2RRpYBi3/vbLeo2P39p
 MGqiWokN60Etia1bMrULoZt79kdvikk91LDlByWhFMlG8tYZiWH2reBcZffTwUyCjeDs 9Q== 
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2108.outbound.protection.outlook.com [104.47.18.108])
        by mx07-00178001.pphosted.com with ESMTP id 330jg7ps0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:14:59 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIkjFSYpxw5V1hMQtHmzGk6N/FBDNSTlQndWFLcMafU0wevkYSiYu+Et1gUAN8XpFZY9Ndl75uBniuIesEe2H6PArygQL+gr+6/uO+DWSLguFTxzhMPxDnCCQMNacYB/sal0Ps2pzRY53rxGfgfE4QtiGd2ekwDmjnYTfMo2rq+5aAEc8kquYtGwhBDQ7GlQe+DHpCkE8QS8cdgdR1XMGTpe8ZpOCXRdp2PiJKG27bDX1neaomE38euXXZMRIpza03DU+6rCf9t0YPEQ32ZnshH77zH988XiAh3bualoNviaZl4IyBs2kifJ12DQTtCuWoV9j6bpZ3m4B+bRb8YDYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2tZeCA5dfCH2d2SK9XIZdrZUqalMFaOTOEqA6cOu94=;
 b=UQt3F8tNttDG3SfWv9gBNvhIBNeVtjgU1PIl4yi/3gZ8j7BSfpw0Q5sc+3QhpM2Nr5F5tk1cKVyqh/Cfn7+xXTk0jlDq+Wt3A3cdjHG5gADvMc9WiS55DnjJO5aUkpz5bYsR936M0ewl2MzicroNXk3RaP29MEIYbJRdhxEG4FuLapn7op8/KxStBrWofv9DsjaxlmGF/HrN1VCumL1Q5wAIABydxIMTQrvkCZTlWpcIYhu4Zcnv+AWxF2weX5Jm0mjb0sIyDjL70eMo9RseQlAV88Y2TQmyY3S1G3t9OVvhVAD7G3BWRgi/30NLFtPgMpXKcOaGsn4WAJeRd/h7Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from VE1PR10MB3374.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:10d::31)
 by VI1PR10MB3581.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:141::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Fri, 21 Aug
 2020 12:14:58 +0000
Received: from VE1PR10MB3374.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a863:76e6:5c47:1a0f]) by VE1PR10MB3374.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a863:76e6:5c47:1a0f%6]) with mapi id 15.20.3305.024; Fri, 21 Aug 2020
 12:14:58 +0000
From:   Ulrich HERRMANN <ulrich.herrmann@st.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: =?Windows-1252?Q?git_submodule_status_never_says_=93old_commits=94?=
Thread-Topic: =?Windows-1252?Q?git_submodule_status_never_says_=93old_commits=94?=
Thread-Index: AdZ3sabD0U6YTkSuQ/ag43rBt7mKxgAAt9yw
Date:   Fri, 21 Aug 2020 12:14:58 +0000
Message-ID: <VE1PR10MB3374796F04367FA5DE25F921945B0@VE1PR10MB3374.EURPRD10.PROD.OUTLOOK.COM>
References: <VE1PR10MB33746C60D550BB11162F5E24945B0@VE1PR10MB3374.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <VE1PR10MB33746C60D550BB11162F5E24945B0@VE1PR10MB3374.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=st.com;
x-originating-ip: [165.225.76.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf3392bf-fe94-4517-827e-08d845cbd2a2
x-ms-traffictypediagnostic: VI1PR10MB3581:
x-microsoft-antispam-prvs: <VI1PR10MB3581570B799491B348CA4E55945B0@VI1PR10MB3581.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xdNcuoJVxt2pczZhBhBKqXekoqwJGHGXIqM5DLSDi8O5bFobLpPL5ZPHgkOfYf8KPTgFmgFMgNe9x8SQEn3BpDuBiVM4ccFIjcs2Xl51jlgSKYTO8bpU4D2bw/047hilB/L8h2sXZ639Ha2dAHrZZK/E+7V7DaylwpAlvIYUCCUv49cIsjCpetN+nwYeo6/cG8zPYjg8mMWmNKhcV7p91gnwwpZ0HTgQKDqm9CvT12l/Xd9paOgdAb/rjmc+ZNuv6Y9Xh1YHIEiSJHhiS26cueV4Wf5x14yRVLdLBIOHRvXgK2Tt2ugvMzEnuvBxUgAownV6J3RQk34X5vuxmCjEeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR10MB3374.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(71200400001)(478600001)(86362001)(33656002)(2940100002)(55016002)(52536014)(316002)(66446008)(66946007)(4744005)(9686003)(26005)(66556008)(5660300002)(7696005)(2906002)(64756008)(76116006)(8936002)(186003)(6916009)(55236004)(66476007)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: VDtBbjhbyGzOJieE+FwctTE2GfegvtUSaYtS76vp5nnaeAAKI0aCnkZDNLWOy/wJxOyyo5R/c9qkusP5JhBI/5PSjAdvCXjY4ngg7CXJI83Eud0AHPgoEh5rykmvl/bc0R5Kpbt9qMgpYDSRHrwnpio6U+AbWnK7aJM5LikypLcinb49UNtLGjjlCaY+KZgjLij6sV5PL10fNWIR/TpgEO/X5682A7+sNuuQUotWvNpgDlmxQeXjRGu5CH9qivtQc5t09T1I9G3KThXJ82QtW+QVqYp8XNpnK6bmwWvthlF9qeYpZdWYDiOccYO/F2tWEw9QyGhLLmVb7LyB9dERi0/OM4p/BCD3h7EUNUoS8eTC+sXFuixJCDCPBGGuSvonp0YIVey3393CkhHQpUd9rR2dH9Um8jLVrxsBqnePdnzRHNMsc9pq9rQQzC7MkT6Zj3bRQ2XgoheiRIeLaokBz8EQwXr6w/XkZfNyRegRNZyw5g8LKc4kqJRUhfpSunTHSmPNWnjteG1xu2pWumsFHC85eV2Mmf270OmeUTZ0cChnkgrylRoz8cfG77DVGsZQ/bty4HlI1slUgLg7mMe8FtM3x3aEhmsb7sYA43z/yH5aMGEwGlpICaIEoyB0AGU536WD5lsYfZ49lRuPQsTwcQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR10MB3374.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3392bf-fe94-4517-827e-08d845cbd2a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2020 12:14:58.6159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hkJGhnnqSmNL/+xqyy1/FTHyA9D+OLWINkdkgvSVp/H+SKqEyuHTCXqC4Wrwm4xOUmRNqsGBKGJNBbWWKmUVGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3581
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_06:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=586
 spamscore=0 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210114
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I am now a user of git-submodules for quite some time. However I still have=
n=92t figured out how to get better status/diff information. When the submo=
dule is at a different version it always gives me "new commits" but never "=
old commits" even though I have checked out an older version inside the sub=
module. git diff gives me two different hashes which also don't give any di=
rectly readable information. =A0Git could check the ancestry graph to figur=
e the relation of the two commits: child/parent, parent/child, common ances=
tor, etc.
Or is there a feature / command line switch of git which I am missing?

Best Regards, Ulrich
