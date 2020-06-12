Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7013C433E0
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 14:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 954DA20801
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 14:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="O9/g8lhn";
	dkim=pass (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="IT4L8MJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgFLOIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:08:10 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:42638 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726085AbgFLOIK (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 12 Jun 2020 10:08:10 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05CE3pSC005574
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 10:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=doBRxOjXqu9rJabH0Mr7mRcej8e1FMHaCsGepcWl55U=;
 b=O9/g8lhnzkggUWQrsfynLQL/dOsZ74jzywZOtt/IpdR2GcirbY4fKnCX8bzqYk6SJpK5
 WMKhP6tIir8bDMssc/BkzV4lGzuqPWmKJ1TzoomtikK5EeyOWI2e04mml6CCGWEStH8j
 6oLB2v07KWgVXOakWIGO/Rw69srOfC9F8NeyR/t7Q24fGuUo8RXI4uwfin4azJLYOR3v
 0SVmKjhfDGr6KE3gwieSabdn4PtfRmeaGHCGrg7KA8JxgkmCM+AQUukmOGcRYTSA5kxn
 yFSNCWX/mMbQA/f5ZMmQWxosaZJiyJofrv7MBI/PqEbF7QUWBHZOyO1feE9AP6Lb8K/h jw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 31kmfqm937-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 10:08:08 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05CE4wh1059260
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 10:08:07 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2051.outbound.protection.outlook.com [104.47.46.51])
        by mx0a-00154901.pphosted.com with ESMTP id 31kxuw9fcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 10:08:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMEUDbPX147tIDw2b9/tXn+sZpENQ1l6QAomrSRbz6LSiQhwJDra7kloRuK9ORrs0CNE9kB6dTWTMZJzvZ4AfOyCDxgXf/KO/uyd+HQQWI8sErT8gStxOPtj/uC40cVguobQAgB99bNMbu6O4gqhtD8Znv6gpXYacdwBMj7HjvM55WGyp/e4eB02U2IQ4WcxgWHQ7AymrI5HXIw6LbbzZrOKSTLV5maRmxVufci/+OVEwC43NHTa7u/ml6GX3VboikopT24LGTR2rG14JRpXnCN4aklw0lX4yutWk3++eIVQusgGz522eNF+aOnMRpIVDyQl4nFU9urAAwRL7ALHUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doBRxOjXqu9rJabH0Mr7mRcej8e1FMHaCsGepcWl55U=;
 b=g+8OcNaw+OG1bxvLNkptsa7uj1pEeordh/5nP7X8isSOf6JXsJ1mwFoCB3VIQ1+tepi59sM45RU5ocEKJt/BJuIsF8ijFU3WU47O9czbXU7jIFs8V4tH3536BLChbmggPt/QYfLRjT3Vu9v9fs95SFiktWI3zo3BgZbJqhATXB/X6HzQAtYmHLVUbCChq62+rZZeyDLkzky6zTLbi19uq51viKhXwvlI196R/ByKXtWbAdrExQqix2kO1hkmAoigFDryP3QlvMI2UJ5GSO2ZmeJd2jDJFD5rfett17UH0TfSafnoeQfSVJaggI8dQsZt5UTbLk1K7LU9swISeHtQHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doBRxOjXqu9rJabH0Mr7mRcej8e1FMHaCsGepcWl55U=;
 b=IT4L8MJ/DBAQR3sIDVDCCPFWs9G0h1yZPlPWu4nyheYoja4rArYOvjcuXVaxubUCHy54PRuvxmlgLLB6A3FYKbRbs7m04v6X93QSsfRTyg5VVk0MSKfZ8g+hiGivC6UEHJwtFcf2SsRk/6+dqxG1Rqibv0FPANoM9hs5J27PXHQ=
Received: from BY5PR19MB3400.namprd19.prod.outlook.com (2603:10b6:a03:181::26)
 by BYAPR19MB2565.namprd19.prod.outlook.com (2603:10b6:a03:12e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.25; Fri, 12 Jun
 2020 14:08:05 +0000
Received: from BY5PR19MB3400.namprd19.prod.outlook.com
 ([fe80::2008:3bcd:b8ea:126b]) by BY5PR19MB3400.namprd19.prod.outlook.com
 ([fe80::2008:3bcd:b8ea:126b%5]) with mapi id 15.20.3088.019; Fri, 12 Jun 2020
 14:08:05 +0000
From:   "Curtin, Eric" <Eric.Curtin@dell.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Geary, Niall" <Niall.Geary@dell.com>,
        "rowlands, scott" <Scott.Rowlands@dell.com>
Subject: Collaborative conflict resolution feature request
Thread-Topic: Collaborative conflict resolution feature request
Thread-Index: AQHWQMCn0onLmOAyQEGi/GXRui4z8g==
Date:   Fri, 12 Jun 2020 14:08:05 +0000
Message-ID: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=dell.com;
x-originating-ip: [78.17.145.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18c03936-b904-4977-50a3-08d80eda06d3
x-ms-traffictypediagnostic: BYAPR19MB2565:
x-ld-processed: 945c199a-83a2-4e80-9f8c-5a91be5752dd,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR19MB25650A10FC00A9B509D29A8D90810@BYAPR19MB2565.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0432A04947
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GQsv99Blv360OQnTXnXcEhJDmN56XVgBp5sI0hRpiOqzqmui7nNKzjMKrVbz1Tfx4o9bVddS8lC/cr8pILQJk0r9TB0dkPx23d0CAtpi0a/3LBiwQDFgRwDxpcmgMb6SP2zRkqtPRhs5zakgFbgwau1Ua+3EhJwCrCCjn+T/yUCTt0BMBO06VxKLUUExbRzEA3pCULDxKzjojPpinVELLaqMuEcRLFePXhPEsF3bCWZ4focKAAU+sbbUBvQO2HXrY+TFU9dsZvaO4Pk8GaDiDqSIc6nM0ZI4+WgX7pEDfqhyy1o65IyxTQCerCpxyV6tPzDtRTV+7q66YRcepjHKrCWWNz3oZ8pSChxnQ/ZKhWBXQEvNe8Aqgqgi3fH9M6Nq1LX2B9xCL3zsvGtPEXOILw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR19MB3400.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(136003)(39860400002)(346002)(376002)(316002)(9686003)(786003)(5660300002)(55016002)(4326008)(52536014)(107886003)(33656002)(8676002)(6916009)(966005)(71200400001)(186003)(26005)(2906002)(6506007)(7696005)(86362001)(54906003)(8936002)(66476007)(64756008)(66946007)(478600001)(83380400001)(66556008)(66446008)(91956017)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: wO4BvOjAZ/+rBm+Gol16kZMvPI3Sip8+CnQBAeYJsXikWoig5K4Gt/5TboFEhC5d/nfnCtK3yTvCP3CkKRVgLDjTzCxoJU+66tIk9dd/4PEP5/Cd+P1GW/ncUmFkdigDBcubDqLkDl7fFL/VdJemYt8aqTrbJmTAl1RdDE+laRoji/vbIt04Oau33QFlQf2f+v99s3BkqBWE2mC/lPbiUXjY7fsWW/FR/KRTqgx19I99kKLdpD3OdNWmmYyobQQLAxrkCBMxnWBgbNeu06lNihM2Urj9oi3+ZJMEBoQIw0ExykZpRsfib07/nIROgWFT12Z8Mvl2ZSo/qadtaKw1iO+yu1v/vMvpnDHoRcxbgSwc6feE+jVGj1E99iy6+1L7K4GFDxq8GCkd4jjQpErFabKnlpzfT7OFeinTV/1iQRjkK3UF4AKV6+KmA03dBgwekN5OJFvlCGo0SAaqSTwk9bLC6bC69vA0swZ/zfMaHPA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c03936-b904-4977-50a3-08d80eda06d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2020 14:08:05.1437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bECKZUg3LSBQ+bDSruZPkHge/KbBpzSifpM/Nt+mEpu9UG6jYZ4GsG8e5M4xRmx173iSMmxmMK/o7SYe19Hg6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR19MB2565
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-12_10:2020-06-12,2020-06-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=883 suspectscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120105
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=977 spamscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120105
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Guys,=0A=
=0A=
Sometimes in our private git instance in the company I work for we merge br=
anches that have been forked for months and there can be several or more pe=
ople involved in the conflict resolution.=0A=
=0A=
At the moment we have two options:=0A=
=0A=
- One person, a branch manager, solves them by ringing people, holding meet=
ings, using best judgement, etc.=0A=
- Somebody solves the conflicts they are involved with, marks everything as=
 resolved and pushes (leaving <<< =3D=3D=3D=3D >>>> delimiters in for unsol=
ved conflicts) for the next person to continue. This sort of works although=
 you falsely mark everything as resolved, leaving merge tools useless and m=
any broken, unbuildable commits around in the branch.=0A=
=0A=
Note: rebase and squashing commits is banned in our org, basically anything=
 that would rewrite history on a remote branch.=0A=
=0A=
Is there any existing or upcoming feature in git that could help make confl=
ict resolution a more distributed, collaborative kind of task?=0A=
=0A=
I also opened this as an issue in github as I feel it could be solved by ei=
ther tool potentiall:=0A=
=0A=
https://github.com/isaacs/github/issues/1816=0A=
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
