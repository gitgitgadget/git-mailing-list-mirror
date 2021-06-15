Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85714C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 21:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C892610C8
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 21:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhFOV13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 17:27:29 -0400
Received: from outbound-ip2a.ess.barracuda.com ([209.222.82.169]:55406 "EHLO
        outbound-ip2a.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229689AbhFOV12 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 Jun 2021 17:27:28 -0400
X-Greylist: delayed 2034 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jun 2021 17:27:28 EDT
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2174.outbound.protection.outlook.com [104.47.73.174]) by mx-outbound10-242.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 15 Jun 2021 21:25:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2BlTUS6R/lY/izv1XxQ8PxcTsB8sgMgvedqWge5V02UHcYNzcl1lvPq/FZuDqu1auKAVIXGrgwpoG41DQ8b0Gi6BbgxiYyn64KKWp6ctMum2Mygv5XWSJLXol6e8P96xW26hyKvnXrXRPl7HgfEM9SJcYVfM/SQO6hz2Jhm22MNYBo27PM1dftICGZ5ObOG0wjdtwnXUoD/n0LyCGFFw9pY5msQTQ5qTlCxokPYWDP1KwPzpNQob+uzQl+ziKdxsGFz8qqI77fCZ23Y0QOKMrYRHJedzyGs0XOissmLymwpO2oW/Zcpk2wOQZ6lS6et+I+3VCht2RQDU70wIBpx+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dle2QM8nxOdoKmaoMhMJclAGM8jlmJH8b4VJcPJ/0jQ=;
 b=iE5Nvfia/M06jlVg0ARc1+bTsXxh8F1bIhd+ffLQpsdTdnb4D03FuNiKZpWw8k7VtaxPHTZ4KO16X/5fP8zmlZ02MCcwKf61/RUFLjYfTNZnkktsdYN0TvX4f4hDuCBOVnWkDZ9T7slRtvhAFczTMN0GZOAEU44KRQkNRVJLTps1Bcs5w0Nb/pjooadbU5QnRw81NgAuFuxP7EQbLSBvcy8gPC8pDkcZQgXjQW1lPePhhoOC9bDMYV2wcO+SeedNpyw9E2jHJ9HxXpsBBbJBK5yH9xEy95rkna1LDAAy8d7JueNtQcQKzHTS9jHQrNmUMaBG0Q0VNqjcCV/cqsgq/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=issaquah.wednet.edu; dmarc=pass action=none
 header.from=issaquah.wednet.edu; dkim=pass header.d=issaquah.wednet.edu;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=issaquahwednet.onmicrosoft.com; s=selector2-issaquahwednet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dle2QM8nxOdoKmaoMhMJclAGM8jlmJH8b4VJcPJ/0jQ=;
 b=ToTBHw4TnVEh/GY1kJcCoYBN2ky/R9Xsd8qwyZFxKAigO4BEJisNN4bRVVI97bnUmZ1VU64M7Cc2J7s2Qn/v3jnJyivFGdPBle7IA6zXsWxZocw5o/80qFR+r5d5YxVMcnkWaqwacUawpFxrJ4jjgGdcHMpHKuVKKV7c70i4zZI=
Received: from SJ0PR11MB4830.namprd11.prod.outlook.com (2603:10b6:a03:2d7::8)
 by SJ0PR11MB4911.namprd11.prod.outlook.com (2603:10b6:a03:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Tue, 15 Jun
 2021 20:51:25 +0000
Received: from SJ0PR11MB4830.namprd11.prod.outlook.com
 ([fe80::5d8d:63a5:ce61:cc1d]) by SJ0PR11MB4830.namprd11.prod.outlook.com
 ([fe80::5d8d:63a5:ce61:cc1d%7]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 20:51:25 +0000
From:   "LeMieux, Janel" <LeMieuxJ@issaquah.wednet.edu>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Allowed list
Thread-Topic: Allowed list
Thread-Index: AddiJylognFra9dPRnaIC/nOpFJcCg==
Date:   Tue, 15 Jun 2021 20:51:25 +0000
Message-ID: <SJ0PR11MB48309669D8DE8A299D607F7A8D309@SJ0PR11MB4830.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=issaquah.wednet.edu;
x-originating-ip: [69.56.127.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40a7a2f4-417e-42c0-9285-08d9303f5719
x-ms-traffictypediagnostic: SJ0PR11MB4911:
x-microsoft-antispam-prvs: <SJ0PR11MB4911D336AC0D7EEAF465EB208D309@SJ0PR11MB4911.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zG+emq90AVTwHlLGH6y8yTBUrLcQW/Ct+FYl8xhOuHJdMW91U7hbULozseuIkmicauMyuJpoIUH8pWzwGfZXphP7oF6rcg7trk47b+nNbJXJ52RZrzsPDRkcVEO562eo6iyFXQ5dG6K3wZiJPQOrJb+andXY4UIBbqqC8b8PPbWNF6rg2TsfI9ZRZJ3h7DACddrDZjnfLY58XX73sYWk5bb3db8f3zRwFig1WzW3/TIYfN4jECvdWo9O14thIcmGBFiEr+gwYbQIh1xuhqyh61HOL54pvVXAXUyHdGj3psEcU4Gn6rAIgdRx+BfpG/QWgAMkSAlrKr0PIkj74ZbB46alB3CF7Du9gzWi5vp1ZK16TSdcneciI3OG4r9UPthNt89ryrrFBHBHVY6YTC/xumZKsTeaxl062t57tf1tlpp+9MF+UWtJqFEDFG2u0DtMBqlcJg8RunwpStDywc0gGPyb2+E10k+d3bJnPtuwAyQZPvC+kpYdYi/49perdDbmmyMmuZ+o0pLXN3rsBpE9u/RALITm+2HHVHZG0ItNDT+kzU2/j9TRENOuZYcM3uzsg+AB9RrS/0ByqbVgruPhf61T4OVgpX+arcVWc8gPi6f50uva+uYtCL7WUVRtkVUQzcjLT7VcI3nlJpcQUZZhbycZIbO4RMpyTSZXAnHGK6r1ufN6r7GdbciW/H6JboINyoRigf1NyxDFcczFiTt6uB2szX/zyNFQY5lfr5KUHUAqK5MFshi5xny8zbGw4BqI8lm0Gg6FPM/SyrQPkprS1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(396003)(376002)(39850400004)(38100700002)(3480700007)(122000001)(6506007)(86362001)(8936002)(15974865002)(186003)(7116003)(75432002)(4744005)(7696005)(66946007)(76116006)(66476007)(66446008)(6916009)(66556008)(64756008)(2906002)(26005)(9686003)(8676002)(33656002)(83380400001)(55016002)(52536014)(5660300002)(71200400001)(316002)(786003)(478600001)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LD1e5Hp6SktTiHbCT8OAYanK1TIDv6j4ZuI/9IZUwjJ+t6++mc0dIjfKRIt1?=
 =?us-ascii?Q?iiGijEHKdhpcuwLfdNakMtzI4r1VCwRrOM26YQlZIYBrgulWR62A3zoyCjxY?=
 =?us-ascii?Q?bAgosmsczh3jDVhyNGrotr0THErKc/I7sJnwDHeH3f37Caqqt2EXYyqsHCVl?=
 =?us-ascii?Q?x3lxV/FMlg+jc1N1lkmo9CMyWKkFtsscFxQlHDR1WGHw9hUyxDXAk0Z6J/FV?=
 =?us-ascii?Q?x/BRyMbesHzzH2TqvbunJemN0yDdTCnwfh6o//baBWhypmyYh9QceSjGpzlZ?=
 =?us-ascii?Q?WrHQMF7JOMltl3qZVs7r0ollMhj2QWELNpnWzCuhFyHk+cuL1yT3Bfw5KTOg?=
 =?us-ascii?Q?BX9vnvHzg3nQpVVYLjQVQvkaTkY9gbdNq+tOgmyfc5bNdrdVa1Q/V+a8D/9e?=
 =?us-ascii?Q?FSQYrNaTQW9amt0JB3vQTmwPjQ79pDM7VyGemAISGKoj6+/SSzeoWY8DfLvX?=
 =?us-ascii?Q?Gnk9Iug3a0g/hONXDP+FNDYrsXTMZfqDbEngBvoFzBhjQbJHQgv+20q4ovY9?=
 =?us-ascii?Q?hLGbi3uH01LmGERV0meLO3zyA/udbZ2O8j490Gi5oq168SFS7071EpYPCdY2?=
 =?us-ascii?Q?e1MBi+BEts4+C93q2MENHs/VyXADUwyXer5fPxYAvd/09OCWqWseCBJfe97g?=
 =?us-ascii?Q?eTxTRYdlQanBLTx3fN4YwM3Iux+aaalyOJKq/S3goaYlQmGvuQxsNpxXefcr?=
 =?us-ascii?Q?xJ6OR2vOFSPOhdL06AvCOh66ukqi3Qr/8FFoKwgEDDY0W8L1bze7jKLVM5Nb?=
 =?us-ascii?Q?atLsXTkdNbfWzUtFmxbN2ZdJWL5AhjzNZXCBD/QL+heebWvRID8Y0pHxaGxl?=
 =?us-ascii?Q?+TA7qI22XBG40sb4y5n9g6lqOxzSKEd0j75TywU1b6TA94YDkpqBP6I0Wo2w?=
 =?us-ascii?Q?fW+uM0S83RKS6q2RsSA49XXMFvQRELtoeFPsDDS+oFE6wD7njtjpTRCiadZC?=
 =?us-ascii?Q?Pxmkvu3mNFWIqlsKPOvNx2T9ZxgJ3dZHYpMtT9D3zPPLQLBAkp6JUIpp1qkj?=
 =?us-ascii?Q?FlBLedj8JvC9XkJj6W2qWDgFy5EYbSGsNcceYMhdnPH7LrYiMUiNLDN/Derl?=
 =?us-ascii?Q?3EbGc8kA4XEmwXx2yQ8zFpcal2mn9MO3jRHPHEeMXwUuEE8M3eeBKzy2ulcI?=
 =?us-ascii?Q?/92oKc6sytg/uN/J97AHunBMwEWc17Yk9pIa9ye+YxBIRgA93svMKnHwYK8s?=
 =?us-ascii?Q?OIGJHEwiJKeNey8dIyQ4xNXifa80Yh514hCBburRQjbwb8mE3S5ESfkRWVJL?=
 =?us-ascii?Q?T2mjzjQMNb65mI281kZdz5czb/GJhO7V4F+Lczh8WFz1mHF72hOb7Dil9v97?=
 =?us-ascii?Q?H5A8L7QUZ20Vquxn7c7Wt6Nj?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: issaquah.wednet.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a7a2f4-417e-42c0-9285-08d9303f5719
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 20:51:25.0976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 351870f2-4eec-4c75-805a-4db4f811aea1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wyk6KwffHt+abKpHz+ZObpD1wLTJrAW13j2d3HEbvA3CyVfVQ3EpJVFU26Zihe+nBzeR3OBXNu595bmwvmEdfI2DuyTXu9Ryzjh7PL5An9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4911
X-BESS-ID: 1623792321-102802-5270-58369-1
X-BESS-VER: 2019.1_20210614.2251
X-BESS-Apparent-Source-IP: 104.47.73.174
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.232951 [from 
        cloudscan13-5.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS100695 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello -=20

I work for a public school and our students all have school email addresses=
 but they only accept internal emails unless we add senders to our "safe se=
nder" list. Which service related email accounts should we add to our stude=
nt email server for students to be able to create and maintain a Git accoun=
t?

Thank you,

Janel LeMieux
CTE & STEM Specialist
(425) 837-7159
www.ISDSTEMandCTE.com

