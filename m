Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD71C433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 13:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AF5E207D8
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 13:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b="chNYsGWZ";
	dkim=pass (2048-bit key) header.d=paychex.com header.i=@paychex.com header.b="FxqITfCC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbgFRNYJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:24:09 -0400
Received: from s1-ba64.socketlabs.email-od.com ([142.0.186.100]:55171 "EHLO
        s1-ba64.socketlabs.email-od.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729107AbgFRNYG (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Jun 2020 09:24:06 -0400
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jun 2020 09:24:03 EDT
DKIM-Signature: v=1; a=rsa-sha256; d=email-od.com;i=@email-od.com;s=dkim;
        c=relaxed/relaxed; q=dns/txt; t=1592486644; x=1595078644;
        h=x-ms-exchange-crosstenant-fromentityheader:x-ms-exchange-crosstenant-network-message-id:mime-version:content-transfer-encoding:content-type:x-ms-exchange-senderadcheck:x-ms-tnef-correlator:content-language:accept-language:message-id:date:thread-topic:subject:to:from:x-thread-info;
        bh=Ed180AWcCeW/FNVGCOCUPu3c6QcgGs8krgiaaTbkQHM=;
        b=chNYsGWZhJcAIC4byFQ1YGfA2v+aYqjLHWL0TQkRFbrGOsIicaNSLAwkWCuzaThf7UEqhizxCIXsYXvQjcGynjAlhQMOhEmEE/qN97yYuyYRqhsH1W/9WM5BG2SuwxKnBhdNDM3nNaDuHTNMq88T08LSUQuxUrcfR9K4oZT+UN8=
X-Thread-Info: MzgzMy45Mi4yMjJlMzAwMDEwYzVhYzIuZ2l0PXZnZXIua2VybmVsLm9yZw==
Received: from r1.us-east-2.aws.in.socketlabs.com (r1.us-east-2.aws.in.socketlabs.com [142.0.189.1]) by mxrs3.email-od.com
        with ESMTP(version=Tls12 cipher=Aes256 bits=256); Thu, 18 Jun 2020 09:14:01 -0400
Received: from paychex.com (mx0b-0018d001.pphosted.com [148.163.159.161]) by r1.us-east-2.aws.in.socketlabs.com
        with ESMTP(version=Tls12 cipher=Aes256 bits=256); Thu, 18 Jun 2020 09:14:01 -0400
Received: from m0093316.ppops.net (m0093316.ppops.net [127.0.0.1])
        by pps.redirect (8.16.0.36/8.16.0.36) with SMTP id 05IDCqmF008909
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 09:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paychex.com; h=from : to : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp012218; bh=Ed180AWcCeW/FNVGCOCUPu3c6QcgGs8krgiaaTbkQHM=;
 b=FxqITfCCmPZ/bV++6PWfTPnqvsVn0Z2BzT+f2PVEg2uQv4DKdLlY7cQfdMDkKqmSPtDr
 1c8UdW8iuAQsRTG52vb7rHPwidoktZPE8J/LJ8E81YItltK+GRMaG0MYQ4rXtY6j1eln
 W8rL9gvPqipgFDArd3ymmnAal3IbcGewZJhMw8zKKMFBPI20xtG7nRbwX4YOq2wNs6C4
 aGXrwbSL8aTOQGgxAYEWBpQ3K79hvayjgbUEOVfoBz6Dm8VBlaes2NS57zDyKtPlvFKm
 NYmGkWjBSxDa2E589IksPxAC6t6SCA2+25C1RLwMLqj5Kvd55z6+FCxTqynBHO9okma5 1A== 
Received: from mailin14.paychex.com (mailoutoma.paychex.com [141.123.64.135])
        by mx0b-0018d001.pphosted.com with ESMTP id 31q65xmnbc-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 09:14:00 -0400
X-AuditID: 0a2c1235-241ff700000069bd-dd-5eeb6897bdb7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/wqKcCnUKU43Wo6LQ0DUj2UxzE1bTdLwuox3jOJieQYezI+d3RYS8zI4IYU7TQFs5ahOwKB4tCeR2UhTfZ8VAfdoyov2tSGW7Ca/2d8+DEzTTQDMWLSwVRZyGJpA0A3h5jbyryZMaja400DDzFQ7MIG9ckGk34CcFN17GhxzJ52Le1BpW+xBbRzqHQhUEgG790y/1n6vO65GBpzOX5l0yN7P/8cXmjgx2rngOXXFCFZFR4WmmhZwngEev38WJg/NLLQ+xh8Qmhzd2NTQUNPdIS9qX1Ek2sSmHKWXA9MNWoPWh0CaDUjV5GSt/5ajV8j7on7jM3LrMD4rlE62Z1mhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35qOeOC0cOdMRZMzb8U/9CJVEmqZ2BW4vQSmuehY/4k=;
 b=HZmy1au6PJRpFCuGNOqbSYx6jpAuOeN/Hkb63gGdk/nRb7nXzUEA5nT+TCPOK+CfWx/He9822qPJMf7rzY4rsYcRsV7UJtSwkhlKYqMSA9NWnlLZZXCGtkMh+8mii6By5Qxn0hlNyR/qyPLi4scpa3YkVrgBVDt5NfWLRwMRtyepfq0Lj9ToXBYQXfjlyUtBQKVR9KAc/Vc9VrG0yOZOx3wKDPP1/qxud/y3wg5hB+OyYtXA6weDfqRQr4bs1crULD7vdy0qnoy2KKEmDgXT/uldHwdUqm8P7D6PO08yzZN2+WF8srfCtBvgqV6xpjbO7DlWsC16vx48iKx7QQ+2aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=paychex.com; dmarc=pass action=none header.from=paychex.com;
 dkim=pass header.d=paychex.com; arc=none
From:   "Riddell, Matthew A" <mriddell@paychex.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git config command ignores explicitly set file permissions
Thread-Topic: Git config command ignores explicitly set file permissions
Thread-Index: AdZFclKHAfiqC2yfRMecUkQo1I7KfA==
Date:   Thu, 18 Jun 2020 13:13:57 +0000
Message-ID: <MN2PR02MB66232254F5F4BE27F21C441CD89B0@MN2PR02MB6623.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=paychex.com;
x-originating-ip: [165.225.39.75]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1ba6909-a02e-460d-1e0c-08d8138975b7
x-ms-traffictypediagnostic: BL0PR02MB4307:
x-microsoft-antispam-prvs: <BL0PR02MB430782E0F82BDAEFE29AFE6ED89B0@BL0PR02MB4307.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cO68wt8Ii0XbDOuqwHjtlTsqV+s51n+Id17jDaBVxvKpmQp1PfZbOmT8DONdMNCRe3Q1qxp1khVBXpOpOcxW1WbwMZUAGOws+9NM50kFins3OaHziRMsQrlg2ib1PXeqwLqWqAhqmRS/fDTjRT+b4fR9AbyvZsnjV/WltAr67NdP+X+G9pgVCnYoe+1WVxjZHOLi1J+J+kWi/L2KmNOzwLE4XAcr4+9q6b3Q04Ccsq3hNgWMw5OPvUPvjZ3aUpJDfnLWuxLmyf8nP9Um94bdtCgsrHjxKdzFEs+xZZXMEo2e7v4eE5t7PElTspxz/ZKlPeGEgvJkwN3mMK+dbY2k2CsrJo99dP2b1ithqnhxZ61Ep6cEhJESRovhpKxmgYPhMCE6eXJVnbedwczXY53ULQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR02MB6623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(376002)(346002)(136003)(366004)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(7696005)(26005)(186003)(33656002)(83380400001)(316002)(55236004)(86362001)(6506007)(8936002)(52536014)(4744005)(8676002)(5660300002)(2906002)(55016002)(9686003)(6916009)(966005)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: elXsAkUCdAuFzzzLPOp9eL1b038KHd5thiO7Mmt4KuH+Zebjy3f8viK0k6G67PCayp0r28nliPCcN3aPs6C9K7OS5P4d7SKIiejrWL+fLHPA48Hr833As7V98eWnvh2FMZBgFRM2LNRKet9VLnHL3afBy9lvL8TqU8Sn21PeN0WI+7/73UoKF0LtdUq3jprIMhtE8yiz1U/HLeG5KZFHJOl9szzsY3QVSqjhu6acSt+qxZPulT/HlWfMT7QQYam5gMBbmI/svgdJrfSPL5hDo9JJL7VF2IYZhLOPojiynck2tjfvL39HWAlzkGhEDNjrQaZNswLlo6tu1nnjrNnZZE/0jnVHIPKbQmv78mS8kLLKGF6bVnvixZfa9LMKLyDsv3ifecGX0+f35ZYxYUCsUKpPx/G1M6VRvieucsbhp1JxrvHRcgZl38xUV3vnoYecZSB7M85IXhsqERt9/asCPPmxZIYds4AK1R+QiKfVqbg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ba6909-a02e-460d-1e0c-08d8138975b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 13:13:57.8162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bcc529c5-dfce-4f97-b44f-debd50891d83
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjscoyCQ4qqYndhMveJx3OCMN7FPjWafhW5CmVfPj7UUiFxpwGsMXEz7dtO0RLXk3fEBeQdFE3btrxZgqWWL/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4307
Received-SPF: Pass (exetpnv01.dmz.payx: domain of mriddell@paychex.com
 designates 104.47.70.100 as permitted sender) receiver=exetpnv01.dmz.payx;
 client-ip=104.47.70.100; helo=NAM10-BN7-obe.outbound.protection.outlook.com;
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsXCpcvCrjs943WcwddGY4uuK91MDowenzfJ
        BTBGcdmkpOZklqUW6dslcGW8m3mavaCJo+Lkjb3MDYzr2LoYOTkkBEwkLsx9B2RzcTAKLGOW
        mPZzCSuEc4pFYvGGHYwQzlZGiTVPfoG1sAkYSlxbuJuli5GDQ0RAX6LvgihIWFjAWeLw7gYW
        EFtEwEOirXsZK4StJ3F2yU5mEJtFQFXi8YxT7CA2r0CMxMnJzWA2o4CYxPdTa5hAbGYBcYlb
        T+YzQVwnILFkz3lmCFtU4uXjf6wQ9bMYJf58gfpAUeLE4z4oW1bi0vxuRgjbV2Lqi5ssELaW
        xLJpX5hBTpYQyJb4NIcbIqwmceNNB9R4GYlvK5ayQthyEqt6H7LAxB/c2A4OIAmB3cwSv7bN
        ZIJwXjFL3Hx6gBnCmcAi0b/5JwvEBhWJf4cqIZ7RkViw+xMbhK0tsWzha2aI5wUlTs58wjKB
        UXMWkp9nIWmZhaRlFpKWBYwsqxhFchMzczLzDE30ChIrkzNSK/SS83M3MYJSg46Q6Q7GtdtV
        DzEKcDAq8fA6hL+OE2JNLCuuzD3EKMHBrCTC6/z7RZwQb0piZVVqUX58UWlOavEhRmkOFiVx
        3r/xZ2OFBNITS1KzU1MLUotgskwcnFINjK2bVOSKHzI8YTE4vEXoc5Tnn73H6lhNS2c39k7j
        iVyg/syKYXLwxanyp6WT/XNKj2ncPRay0WHJsmXtzo++8XtN0Y8+8HjVFK9G8ZhlOdNnCd48
        ZVIttPN79fk6m9r9q0MTnDaztopuPn4t+S2LnuQqj6KGNcsyX7ycpnKhwJs/YMUbbpv5tkos
        xRmJhlrMRcWJAHJqTjIJAwAA
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_12:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details-Out: rule=paychex_corp_outbound_policy_notspam
 policy=paychex_corp_outbound_policy score=0 mlxlogscore=847
 lowpriorityscore=0 adultscore=0 mlxscore=0 cotscore=-2147483648
 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180101
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I noticed while working with Git that the file permissions on the gitconfig=
 file is ignored and the parent folder permissions are used instead to upda=
te the file.=20
An example is as follows:

Before running git config ensure the user running the command is not able t=
o edit the file but has read access to the file. Ensure the User has full a=
ccess to the parent folder.=20
After running any git config command the user previously without edit permi=
ssions on a file can now edit the config file.

I documented the issue in more details in this ticket https://github.com/gi=
t-for-windows/git/issues/2686

I originally found the issue  while working in the windows version of git b=
ut @dscho noted that it is also an issue in the WSL version of git and beli=
eves it is caused by creating the .lock file which replaces the original fi=
le.
@dscho also suggested I send out an email to this mailing list.

Let me know if I can provide any more information

Thanks,

Matthew Riddell

----------------------------------------------------------------------
The information contained in this message may be privileged, confidential a=
nd protected from disclosure. If the reader of this message is not the inte=
nded recipient, or an employee or agent responsible for delivering this mes=
sage to the intended recipient, you are hereby notified that any disseminat=
ion, distribution or copying of this communication is strictly prohibited. =
If you have received this communication in error, please notify your repres=
entative immediately and delete this message from your computer. Thank you.
