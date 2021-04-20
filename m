Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B186C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 16:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5EC2613D5
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 16:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhDTQeV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 12:34:21 -0400
Received: from mx0b-00211c01.pphosted.com ([148.163.152.111]:44442 "EHLO
        mx0a-00211c01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232929AbhDTQeU (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Apr 2021 12:34:20 -0400
Received: from pps.filterd (m0095028.ppops.net [127.0.0.1])
        by mx0b-00211c01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13KGBAUu030042
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 12:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amtrustgroup.com; h=from : to :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=20160701; bh=tT8YV//WdiYLymstWcuHYZFZYtVlFmIxYppSh32eD4M=;
 b=QZXMQm43reQSZX1BYMC5afUmHRguuCgjEVLwmsnDNLoCrd+DYxZ6TEW9otHkwaaL77Bc
 sFNwxJ3POeyv7iH5+1mn14VoXisUuQSwbGUJNz6GStLtzOE1DFtjgrW1/GZmuHnEcM9t
 X+m2Y/UHIHNDoYiDLDxBs/js+AF7ntvYd4A5G7R2Yl1tio9Q8X/K9tfkGxNeUwZ/IjSX
 SXu6AulnJhPGlF9pHd5OtuvSFcIWz9yYXWq2dNcbmCc9AihC4PPM0isT8dYv83/HgxMH
 adtXBCNcVfdSbbkcyVAPITDI2QCKaOTT17f9MrjZvjv9mQwcp5fvVV0lZk2hTCxy0TTh VA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0b-00211c01.pphosted.com with ESMTP id 3821aeg6a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 12:33:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJQhkIpYro7rTCaBSuY50JDNlhrh8q27jgb3JGH8d5aobYDrjqslmFUU96mNrKZ47Lmm9gzch0NkZtOcBdDnEXitxGqFGr7Ff8FkQ7dZcQMKKhBrrsDNUHABUk9EARFgPr9lNgeJIDjdzz1scA2E2casII6qi+CRayiptOmCDGyQ+WKeNFMji2T2acfqjAGJ1BF2av8bGGmwB3hwLZfeotO10zP5jmTK5nYuJK3sOB+qUj39FqrnQ1rhjNGi86X4Sdd5MwhapWUJ9+h/oTRBIl4tSP19n7EeSfQEiG488IW1STFsFIqebeNPfMxyRoehX+fWQB0XFg45kI7xuPGRqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tT8YV//WdiYLymstWcuHYZFZYtVlFmIxYppSh32eD4M=;
 b=Ljh+7RaV1W0VCpxmsMN0S4xm1j/qTA+5jmdwT5RhfhWNr+JWu5idI8IRMHC1LPGi8rTjNv6H2OgRZtYnJaV7ZiHex1UAapSvsNyrDhRsRNlO2RZ5tp8fjBEBVPlVHJ1XONVQKTsR3Jd9yFJR49sBFVgIbs2e+4kni3U2eLPFd02JM9WqNFW8GsJUvgTiRdKb3anJkNgruRz4ouim/cwrcbutQZYVdL+bzeNj9jOqCYdGbwGemf9GdHR2xoPLelsK3kcVGzPOyynJXT1tcxm4UEIuM9SgmPgL6iRJDnJEgX87n/s+/qMpLd77Vbdpa6IKk0Zz8YWIw4tjhm9qLoqPbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amtrustgroup.com; dmarc=pass action=none
 header.from=amtrustgroup.com; dkim=pass header.d=amtrustgroup.com; arc=none
Received: from DM6PR17MB2106.namprd17.prod.outlook.com (2603:10b6:5:aa::27) by
 DM6PR17MB2298.namprd17.prod.outlook.com (2603:10b6:5:ad::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.19; Tue, 20 Apr 2021 16:33:41 +0000
Received: from DM6PR17MB2106.namprd17.prod.outlook.com
 ([fe80::6c81:dccc:7532:b73b]) by DM6PR17MB2106.namprd17.prod.outlook.com
 ([fe80::6c81:dccc:7532:b73b%5]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 16:33:41 +0000
From:   Dennis Worthem <Dennis.Worthem@amtrustgroup.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Problems with CRLF line endings
Thread-Topic: Problems with CRLF line endings
Thread-Index: Adc2AutBhZwybG5TTNStuf2g4hDVMA==
Date:   Tue, 20 Apr 2021 16:33:40 +0000
Message-ID: <DM6PR17MB2106CEAA1CED29E738B81602F9489@DM6PR17MB2106.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=amtrustgroup.com;
x-originating-ip: [172.110.250.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f739b74-fbcb-4f71-44c6-08d9041a0e9e
x-ms-traffictypediagnostic: DM6PR17MB2298:
x-microsoft-antispam-prvs: <DM6PR17MB2298931807738A221DCD348AF9489@DM6PR17MB2298.namprd17.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UjjTqDzXTTEzZ0FFy9+KxKAW6PBghDFcLU7l9Ro5h9MKpa18B5ZrV/rHwhrwVS07AVqqBU1CV5Cz1n42I/iu7r1Mba66wXCBPOK/NfVAodp+A/N+WmSFkSeTuXZ6yjaPEFQx/PCFKM3+Wa5gLLuZ4peCf4S29QV0Uk+BPg9IzCRLPCFv0SB/WETpJNw40CkreawKijCzI3YD9afuHhcxDguASZp2wLltxPM2RulJPXwgJR+4ge0/2eKiW4HiZXSXpYACFxk+bn0SUJEfODDEwxrpz3IpSutkuj6wE5VxiQ9BGNJ6VjvH3x/jLwajuUU4hhuhkOxmnrxnLgrRg2RyLecCP4S+B3N2ELhK/o85cJseolRdhtlcIjXeHmupxabBY5//QLhHeFsMpAjaMwzTP47G1pNc+i1ZhgGtHuu55U1PcH6x/f2tw5KkRcZ05pVGx6EISxDdHO9qlkJ5whit2Bl1lr2UVeIWr7zwXo+i2cYOVppFYSIxtXiaUkCZunHl6zLRO99ysoNbmhINhIXAhwDOpxTa4MV4yfL1o6hkWBWadetmxJmWy+Cf0/1I9w8Mh4IFtFkgVTbOJxiJ8Oj+vw/aHFffH+XQvmfw6+Mco1U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR17MB2106.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(136003)(39840400004)(346002)(8936002)(8676002)(66946007)(52536014)(66476007)(64756008)(86362001)(55016002)(316002)(9686003)(66446008)(66556008)(33656002)(6916009)(478600001)(122000001)(76116006)(38100700002)(71200400001)(5660300002)(83380400001)(6506007)(186003)(2906002)(26005)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?um8k2JrDDaIkzbmIMrAVOb7PK0QBqrFUe0BYD//n7TRQaoRSk+BnqTkgUgJv?=
 =?us-ascii?Q?4dG0raGBMXzIDRlB3i44TGBUblln7XHUv20ECdIF1BOngHjaFr8lFm8n0mSO?=
 =?us-ascii?Q?T9f7vLnbdhF4h0SdhXJFYefav1QG442GNDDfwhNCRtyGDJTFHSf7FT21t2WF?=
 =?us-ascii?Q?i4tUT1CdiRzqzOiYMDTVffzg5IhCWRHc7vnrq2EjyDDWITAygiO4A7PjJ1vd?=
 =?us-ascii?Q?2lAwnWQzVLiFM0YpEihLjFNk9yn6sO5MnKchXlwtZMKXrqBKMNfYZy7lDUjs?=
 =?us-ascii?Q?APx861/BR2coMSAWmmEV8pb4oThiZ1xGYzkpQ2JUNRdQ4hdtuOQlrAu86KhC?=
 =?us-ascii?Q?l/bAsvb1n5kqfv8K4eV7NKkGb970vXcfpku/KYtJS8ohpC9QeiJxmNHvAoy4?=
 =?us-ascii?Q?tQCqadNkCGu51Xnz2wtxknXYDJxUwgkOA9UCrXAMG1xaYoNpNSNppqQYcoie?=
 =?us-ascii?Q?p28jfv3eM9pIYoSTsxfcjBbiC3xH2pCL2xASRLGJX3YTVwUkMPXfRg3beCql?=
 =?us-ascii?Q?MIv2ewH9zbAjBNil8MYd35Gmqzu91tcQ9wlZSqR+3q08lm55v9M2tz6hhEcI?=
 =?us-ascii?Q?p9pk0ZXePXUFswpsLu7V1H42MkEWzx761sDCtRMA7/tDq0b3hr0PnO+zIiHV?=
 =?us-ascii?Q?mP4LeLKIrrF8HHTRcbvBW86v/DXpMcIQdSfHZMl0eZ/FlntJ+YbuIbGjN1Au?=
 =?us-ascii?Q?RNx+mzSrzFRt6B+LkTJzyTPeaNgNyIjFB2hqaEnuApm6sm10L5k5izx1A9Cq?=
 =?us-ascii?Q?Tg7TCx8yeVztfsW0cW2A2g4f2HmeHZICKSqKdNF+3zb/bnz7T/W1fOfBS7Fc?=
 =?us-ascii?Q?DchuI0V6MzDtQVhm1G112bh8Xg5nj9xf5EQfSa5TxCEBmWkY4Zmawd+ttepd?=
 =?us-ascii?Q?QDOs1cVdxTPVhvGBimUCfPyp4oIWw+rrVuC4MoKrmXWvq2m8mmKt7ao+blCw?=
 =?us-ascii?Q?xzxKvsmLox1cFhE8THrxY3NshCz+UZWZ9pSMpcc8ynopEs66R2Aoi1vL9P+N?=
 =?us-ascii?Q?S4TpRjYsGm9Jbsn5mp3ggz4PZaQzzAYcieS6ixQIChzmImQOQo/pzZ0+yCmU?=
 =?us-ascii?Q?gqaX1ruix7AYCvZr9DkbSOpwCcZzvYrA91xrxYgfD6p6X+mTeLKhdGtQIn39?=
 =?us-ascii?Q?n/diyF0p1FMNx4XMYB6N+k4FpoqreU6iGM1LVSxFpqWt/xozVuA+QyRiXvf1?=
 =?us-ascii?Q?GXJOzc1aLYr9pXnzW7wT+I3NnToM2STyOoT+h1/Pvb148QLhh8kPCik4NczJ?=
 =?us-ascii?Q?vRjxdcZI+VVQ9wuxIYHALBH90AgGUk8JtrdMlw+lPKK+wA6egFcigkHZdCl7?=
 =?us-ascii?Q?E03ILkcPKZEhDI0pIhjin7+o?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Amtrustgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR17MB2106.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f739b74-fbcb-4f71-44c6-08d9041a0e9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 16:33:40.8611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 550df8cd-4f86-4dd6-bd6b-21108872a266
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OdfGsWc6UxNHMRV1hclTpnX+9QVfhO7QYAuvEmH8tVMEYrp4YCuPG2SXMJ6GUm+J9mUiJiiddr6F/iTL61x3bookxhTcgYSf3NRA9W7weP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR17MB2298
X-Proofpoint-GUID: PmoJadyOXYjOc20S3ov8tQ3ZWbqxUAPY
X-Proofpoint-ORIG-GUID: PmoJadyOXYjOc20S3ov8tQ3ZWbqxUAPY
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_07:2021-04-20,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200116
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We as a multi-developer team are using git version 2.31.0.windows.1 on the =
developer side which we use through Git Bash on Windows 10. On the server s=
ide we use Azure Dev Ops.
Approximate 20 developers are working from one repository.  We want all fil=
es to use CRLF line endings with working with the files. All the developers=
 have a .bashrc file with contents of "git config --global core.autocrlf tr=
ue".
Additionally, the repository with a .gitattributes file with contents:
*.raml text eol=3Dcrlf
*.json text eol=3Dcrlf
*.vb text eol=3Dcrlf
*.cs text eol=3Dcrlf
*.vbproj text eol=3Dcrlf
*.csproj text eol=3Dcrlf
The problem we are having is that when pulling branches from the repository=
 we still have recurring  files with phantom changes.
We have told developer who experience this to either reset the indices cach=
e and do a hard reset or renormalize and check in and push as indicated in =
a number of web sites. But it still seems to be happening.
Our repository has a release branch and a develop branch and the problems s=
eems to be happening with mainly develop which has more developer traffic.

It seems inconsistent on changes, The file will download with all CRLF endi=
ngs but the file is marked as modified and it is not clear what has changed=
.

Does anyone have recommendations on how we can get this to work (always CRL=
F) without the phantom changes occurring in an apparently non-deterministic=
 manner? Have I configured this completely?

The problem may be that one or more developers have not updated their local=
 indices. Also would it help to have everyone do a one-time reclone the rep=
ository?

One file marked as modified has
$ git ls-files --eol | grep WCAPI.Core/WCAPI.Core.csproj
i/crlf  w/crlf  attr/text eol=3Dcrlf      WCAPI.Core/WCAPI.Core.csproj

and a similar one not marked as modified has

$ git ls-files --eol | grep WCAPI/WCAPI.csproj
i/lf    w/crlf  attr/text eol=3Dcrlf      WCAPI/WCAPI.csproj

Why does the modified one have 'i/crlf' and the unmodified ones have 'i/lf'

Any help would be appreciated.


