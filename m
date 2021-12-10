Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEB6C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 19:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbhLJTQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 14:16:35 -0500
Received: from mx0a-00128103.pphosted.com ([205.220.160.181]:13806 "EHLO
        mx0a-00128103.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231135AbhLJTQe (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Dec 2021 14:16:34 -0500
X-Greylist: delayed 1123 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Dec 2021 14:16:34 EST
Received: from pps.filterd (m0207973.ppops.net [127.0.0.1])
        by mx0b-00128103.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAIHB0n030412
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 10:54:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=firstam.com; h=from : to : subject
 : date : message-id : content-transfer-encoding : mime-version :
 content-type; s=facorp; bh=ewmwCYWTwOfZfoTcZadTbb/Yn7By9lfakuvl8U1+tfc=;
 b=lnqqLNsEVxXkgwecnBX7bQ6G3pl6a/BOPdYssxP1atBT22FUh/zd9LZL/1r4vfyOswoy
 jUy0gcmruN1BZNel4PRQTpuWy/TpsVVYmsTheDtnUlTPEBTxPg0mTbGFPTGfMHoatl7O
 Arli1MEJdY0Hx3SMqYgKRBYZxt3c+8Nk0dsyn6RLBUU904Vx1kP2EX+xHaxTUjLwtwne
 Xn/EFtF2AZ05dDX0A7/x1NfnwgklHNXGCtWilSKM9TMJgtvBJbGLwoX/q1Hk9f+onVMh
 bwnHcibcfx0dIdVHeyz7TaaW0Mn2KZ0zr4LXsnqgaRGsjK6AfyT7Jim4P/PiS72OdM6A lA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0b-00128103.pphosted.com with ESMTP id 3cvbem0skk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 10:54:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoMveb1gRy0cxim4jnaEtZWciVVS2fghApvdQVtuOXweypzDXIUD5b/5tsdQ4T1cioul9SU9ZWjPLLm5WNOl9XITuEGzRnigjgZuSFXmBCsodMvhsI20pcNztMwaQVi6Vyorm+9rDaHVR9brj7+nN91OupmrrrsgZ8czD0FrPOoZw0QeClgsYj150YAeLKLKTGw72PhS09mYqYPHqmeBI51mj0YI1aMdQR9Ju1BLGu+/yJnDBDxILNfHDLYLDPjhT6NrEazMTJCnlWkJ50cptmrr7ikND6SGlMNf1CVu/JbWiikESF6HhqVNLtgGuTuxqkaH1DXHcBn/AhckYlol+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3R7NcUPR6c3NAdlfuX2M3OiR9nOeDSdIqbWcSqCHixU=;
 b=OsqBs9mNeWrFdaRxcjFETsEGRpsPP1dTYoZWkhmd62sn0mg/ko+W1h9GLyjA4uioX9X5XRKtmvTZtJ8+5E0eFD5991XFEASj+2GrP3ictE2FCsgD7GgBKDNeIr+SMsR6kZIrNMU5yjNJoQMxJVCARr3gaaij/BgSXRFpmInXZsQYc0PFkOg+4t+l4cIVNHYwqSDjYDC0vJV8YOzBtXMmwotUlq6ThvE4p5tMN/UZmKm/c/7GjqgBrrzh8dbWg+BgR288PN1NCjsc01jc10SOQ5zojfUleBnryF3i0BwPOaiEFVLtP6PjeTrA8RIhQM9DOIj+rpM1oX/yJ1RaRTaFdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=firstam.com; dmarc=pass action=none header.from=firstam.com;
 dkim=pass header.d=firstam.com; arc=none
Received: from BN7PR08MB4993.namprd08.prod.outlook.com (2603:10b6:408:27::22)
 by BN7PR08MB5092.namprd08.prod.outlook.com (2603:10b6:408:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Fri, 10 Dec
 2021 18:54:14 +0000
Received: from BN7PR08MB4993.namprd08.prod.outlook.com
 ([fe80::18a7:4224:8325:6300]) by BN7PR08MB4993.namprd08.prod.outlook.com
 ([fe80::18a7:4224:8325:6300%7]) with mapi id 15.20.4778.015; Fri, 10 Dec 2021
 18:54:14 +0000
From:   Robert Weyrauch <rweyrauch@firstam.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Question: Git and ActiveTcl
Thread-Topic: Question: Git and ActiveTcl
Thread-Index: Adft90W0O3L81lRGRK+gEUx2pgCRPA==
Date:   Fri, 10 Dec 2021 18:54:14 +0000
Message-ID: <BN7PR08MB4993D6DAF501472017175C65B7719@BN7PR08MB4993.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c05f8a31-cd69-41ca-7334-08d9bc0e7624
x-ms-traffictypediagnostic: BN7PR08MB5092:EE_
x-microsoft-antispam-prvs: <BN7PR08MB50927D55B9B0388D62E094F5B7719@BN7PR08MB5092.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EzOq1e9KWMxW9E9VnKQS2LsdG769xJIsUyQCweSR/uPMPQPpsCaPfifkGEnhW5XLJj4zBL8h7e+SGEcjbDx9K9bBx8ox3EJsPXpLlGzOm0L515KIcZeqGsVRbosU1iG9bSHeakjUb2X1CuVzsnPAk3s26Ooo5YbugF1ggRDMZFhB6dHi8Cbk3TQ+KKxHEceEFuJxFcZo3lhatosRwubQKo/piljrs+ZZ3Zx8a9dXUC1sV9E0+9M202gPI3znNZ7VFUo8ilGhQGaP0OaNN7sGd9spl7fZVaYOl0xRblSuSfrau/SfNIhQhTx4Z8dL17vxhkbpBRHnw+7n5nsa1mxIeKtpNLvHpMnTdFSuGg02K8UdSeHEAkdtQgN8PlQubH1zKhfxe6kQb12bD8imQ+k/NaSt1+jDBSU2gXo/AeCfSpbDJewoem6JBtGiMtmvp/NpzXq1LP6hc+1teczVNffj1xk43NhZzVW25Afr8q4gP3r4986VdDYpqHdk7EtNxKgC7bfSanA+sPGk1HLCXRDk1Qrk4grITxlDinpyZheONSQqcquz76qDB5uDhLwYS34qebkxMx40Zdp4W3shbYm4K+vMWU8o93r8cmtieBOo5EpGS7usmF07xVhOKzhYOKoqdVNccZyrqEWU+rOix058JBirqJQE0IBwb7924RXHQKK2LcOojScqlN0xceVWgIRLEOxgTrkA6Il72HJO442oBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR08MB4993.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(9686003)(38070700005)(2906002)(8936002)(6506007)(7696005)(33656002)(38100700002)(55016003)(66476007)(66556008)(76116006)(64756008)(66946007)(71200400001)(316002)(83380400001)(66446008)(186003)(4744005)(52536014)(8676002)(86362001)(6916009)(508600001)(26005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?e781j0xUL51v+gWh3XS1WR1Fs/vV4KWu/rnE0xNS6GxF6/eL3rWC6ILJnS?=
 =?iso-8859-1?Q?d0Ra0DsjlhJDc4BtEY/gZk0JF4WfFc9qY3Qz7Xc3UWw92A86ddIgU4IYNj?=
 =?iso-8859-1?Q?zCs0AscKHkgZTDrfoWc3FKEnBIL6lHZ69dpHxk8wwkOrtMkevmZGiC2OGf?=
 =?iso-8859-1?Q?x0f9pggyHf94jSQiHhIwP4ne9HrPra406VWh+BLpsK4vtVcMVncgoznE4R?=
 =?iso-8859-1?Q?nFIieurZoZm8czkvpea+NIezsE7NJC7klutjjT0N8xs866GkzMgdfWD2h7?=
 =?iso-8859-1?Q?jHfg0CEqcsFcPisGEnDDyxmuBGzs+UodTbaMy8z+kQMnPwPD0SyuV9Md44?=
 =?iso-8859-1?Q?3VWAATv+WNWq7qBkOaLTR2UD6IoeJ6fgUhW1fcTwdqznn36aY3iNs2B0Q6?=
 =?iso-8859-1?Q?xFiLwbXMORmV/ESweMzsExYR31k+VkglyVeB7VJbg7gMKqnmtz+2duzGmW?=
 =?iso-8859-1?Q?mmkm7m3RpWTCdzNrxO0yPeuoNHk3p+Xp+RjVAWr24owW7s9RvuXYpcnXDV?=
 =?iso-8859-1?Q?v9j7i/eLs6HKiNUO9DUZuGHTbSSJgKliNnY8TICpJfAB0V4SgQ+mhn9XTj?=
 =?iso-8859-1?Q?utJqZOvJhc0NsBRo93sMVgETStCG4sEaZiNaLoEFfg0Piv/0BE14cMaE9b?=
 =?iso-8859-1?Q?RHLyBRp1YSJ0Ab2GOFaEKAuZQ4hOr+KR0b0hi8lZV5E0cmoHlMvxfjZD14?=
 =?iso-8859-1?Q?ISoiMBFnU1RYcl3MHYdijakW518WK7kJnfdpmWwADnDWFz1V55ZO3mEi4u?=
 =?iso-8859-1?Q?xbQAzhwm4OhHU8TD2w7/oxY3gaVhMXuM05rbo3DTmb9RqZsZ2h0Xmf4APW?=
 =?iso-8859-1?Q?1p50NuF6KczD8I6VyRR33igE83lfmYMGvKmCNm/uqAeisIPjkK3LQ2DSgV?=
 =?iso-8859-1?Q?+NCYkv/8nGAKZtqG9lAC2TVUJz2XYhSNp/9EdhWwUV/DKTsa6Xe/xW2NiK?=
 =?iso-8859-1?Q?ZzVmOIx1aM9YoP3AQ1HNWR7G/88fnad42stn6BWZAEkpIqaxxNQ+Qy131f?=
 =?iso-8859-1?Q?8STpqHr5nbqVi7m41OPYp8Ph2vyZoLzk8QLWTQXX0Ns7FywOtI06dFqgoX?=
 =?iso-8859-1?Q?eJz+UwRsBWedAV2seHFc1IWZNfPzrbJVC8TmnJG+HhCMOpu2QheDqP1Gba?=
 =?iso-8859-1?Q?2KA6V00tNLmaFKXYBMIhR5d7EPiTuRphn/PDIXhAJAj8Ozq4Rl1QuOht9l?=
 =?iso-8859-1?Q?Wrdkbruo+jDtNHLshxxiWYjiguR5AqAZz78zHl+pq9gSY7IOlP+0Nmc3sL?=
 =?iso-8859-1?Q?StwVqiu4V/qfaVqQIebVdJSvWSXinecHiuQa378f+rK8ay1TBwgtBqVNc6?=
 =?iso-8859-1?Q?HgE+ly9YQMDZKcOkLrAcqBxvq8LPRN1itCArbHivMdOlIXpM1+JqQO2G6p?=
 =?iso-8859-1?Q?3zSn3WVXj9qEgVNrDn2C2vEMMmNv9oVt+n85rdQmP80VPuuilhzBV88o6R?=
 =?iso-8859-1?Q?bwDGWDPhc3wq5uWrevCQuCJYVfdU9OXykhr/R82oNFVWxoqIiyqMwUUK6o?=
 =?iso-8859-1?Q?hGkoB4T5fJQ66LYobCacez8IIIkahdUCbJ8nAKmzRKtOdgyuqpYyra0oqx?=
 =?iso-8859-1?Q?9qBIAMQZvnr7fHUNmU44Wa6lkIyPb7OkGm8iDtmNUjm1MKBQimL3+s/abU?=
 =?iso-8859-1?Q?ZiJ+fFfMbABcZgX7Mvs2gSJSvrdYH5wN4YU+FWkgHtWKy/8OqsKLAfaKyK?=
 =?iso-8859-1?Q?ih/Kri7ek6AnTwnBix0=3D?=
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: firstam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR08MB4993.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05f8a31-cd69-41ca-7334-08d9bc0e7624
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 18:54:14.6210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4cc65fd6-9c76-4871-a542-eb12a5a7800c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ahnj5RxOnMDaTrDVX1yFj2SX296NTzWwJC62YElbCXOZXrcoVEh3lqFTxe/08YSWFaV0WkFaIsmhDKs0U08JqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB5092
X-Proofpoint-ORIG-GUID: 0ttCcq1bRfcuiHAt-s2Ek7XcZTzwmjFr
X-Proofpoint-GUID: 0ttCcq1bRfcuiHAt-s2Ek7XcZTzwmjFr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_07,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=527 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100104
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

In June 2021 ActiveState, a provider of curated Tcl/Tk, Perl and Python dis=
tributions, changed their licensing for their community editions to require=
 payment. I would like to ensure I am complying with these changes.=A0=20

I am reaching out to see if the Tcl libraries used by Git are those provide=
d by ActiveState (ActiveTcl), or if you use the vanilla tcl/tk.

Thank you so much for your help.

Rob

***************************************************************************=
***************
This message may contain confidential or proprietary information intended o=
nly for the use of the addressee(s) named above or may contain information =
that is legally privileged.=20
If you are not the intended addressee, or the person responsible for delive=
ring it to the intended addressee, you are hereby notified that reading, di=
sseminating, distributing or copying this message is strictly prohibited.=20
If you have received this message by mistake, please immediately notify us =
by replying to the message and delete the original message and any copies i=
mmediately thereafter.

If you received this email as a commercial message and would like to opt ou=
t of future commercial messages, please let us know and we will remove you =
from our distribution list.

Thank you.
***************************************************************************=
***************
FAFLD
