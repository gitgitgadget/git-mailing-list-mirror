Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421D1C4742C
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 22:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6C07206F1
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 22:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Q9QA0UGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbgKJWpq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 17:45:46 -0500
Received: from mail-eopbgr760135.outbound.protection.outlook.com ([40.107.76.135]:51527
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732257AbgKJWpp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 17:45:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lfit0vmWCTuEtT8zoHUhQi2NOilWbqB31drl9ozTTIloHcxL2tL0O8SMcr2JAoimAS2nD0/c2KQ12eo3XjUuuNZRfW83lLNinwLj4OkmFdL7yQtte9nRNZSk7GjMJnE06Y0Tp9oiP+zt1JXStQhg9fKah1cQ8vmdP/N6gPqW8xeqIfvjOpSaqQYSBKz69NM1qZ9/qo6VxgsnyUhB0iBR69LCyz2967VT6rhuhhx7pniCeNe8EcJCtIL3ELwnj+Kegx0If55CqM9i/akUlOqObJ1CmLv5a0oYftZkpid5wi/plXcJ5NBLi5cUJ4EHE6q/Wj4tlFtUcuwYfHlyisdt9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqXh20b1mqkrOUxKzE46kWdjF3WmifxKmb0lEuRAsmY=;
 b=PjMq17e6bss9iPrO28IuftpnDu8n6EZFCh9W1wKFGWbL9QOZeEvmZ39ADgz2mPg54h/H1CJyDzxatqTVz22sQvDcWJ6Hwjbi7CgB5LC/3CwV+mcybObAZ/X+lLEG/c7/ReWETOQ9AAD79bhtJGoyUZhB7wpa/4Ugu7+30wf9kDnqAemkKfnhFkyPrqrH1fxF3l+0ndumQ05Uw3o8XTYBWjOn40x27x1zHX75TGXkkgNZfFtdVoej5PtA6FdDKgb80mXaZXmyzu1SBdUkMDhSl1OVm/qS5Ug/L4Dk+x4rS+Rg0OIqgQG0GmswTFIJ++aL9787TsgJuVj/Firw7AWaSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqXh20b1mqkrOUxKzE46kWdjF3WmifxKmb0lEuRAsmY=;
 b=Q9QA0UGJzQO9AzH945y73GXAjVP6hHXSF3F5VNEQq20xtBWAzkChKk/XL3Iw4QRUHYG03kpeigiFKk5u/EaDCV8pjvU+THpzB28tdJ1ISxC1LVsUQAHln4edUS+Vg+yQx8kx7io53F8Ei3E+70+/yxVBEi4kvI1/O9biBx2Z1G8=
Received: from MWHPR21MB0143.namprd21.prod.outlook.com (2603:10b6:300:78::13)
 by MWHPR21MB0800.namprd21.prod.outlook.com (2603:10b6:300:128::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.9; Tue, 10 Nov
 2020 22:45:43 +0000
Received: from MWHPR21MB0143.namprd21.prod.outlook.com
 ([fe80::f95a:3a77:41da:50e1]) by MWHPR21MB0143.namprd21.prod.outlook.com
 ([fe80::f95a:3a77:41da:50e1%8]) with mapi id 15.20.3564.021; Tue, 10 Nov 2020
 22:45:43 +0000
From:   Ryan Wilkerson <Ryan.Wilkerson@microsoft.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: BUG: Windows Color scheme not preserved
Thread-Topic: [EXTERNAL] Re: BUG: Windows Color scheme not preserved
Thread-Index: AQHWt5yJLxpR1twp9USEoaM7N2kQZ6nB9mcAgAAAo8A=
Date:   Tue, 10 Nov 2020 22:45:43 +0000
Message-ID: <MWHPR21MB014370A8261F29A343B7290B97E90@MWHPR21MB0143.namprd21.prod.outlook.com>
References: <MWHPR21MB0143F3E8DA25D35AEB0DB92B97E90@MWHPR21MB0143.namprd21.prod.outlook.com>
 <MWHPR21MB01435E001D3B779017675B1297E90@MWHPR21MB0143.namprd21.prod.outlook.com>
 <nycvar.QRO.7.76.6.2011102341460.18437@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2011102341460.18437@tvgsbejvaqbjf.bet>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f2883a1a-c63b-4d92-8de0-e9af29556659;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-11-10T22:45:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [167.220.2.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f5a44c5a-eec2-484e-4ba6-08d885ca5b82
x-ms-traffictypediagnostic: MWHPR21MB0800:
x-microsoft-antispam-prvs: <MWHPR21MB08003237E8CBC8C39BC7D6BC97E90@MWHPR21MB0800.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h6iWbsS57E5qEkK3Y8+Rt+M00seljZDJFkmhD/+VJa224KdwqN52sr6KPkfjy3DXMov2IovefFpbAs0FpVn8UC4NcA1lPtQ43aWofNICJftn1jiyQwby0nlek8eMDcds8aIenUSX3fD8kSOvtQop4WC4c2X1lnSxtnB22k8jTSDVwCybdQGpICieHDa+1VkiobhC6iMz82eJtRd1EaaAZOV5joZopH+a8+aiz4d8SYn54tGUftkMFaC9dk+qXjccOXKOj99AsGIpQba2PRofGWsLrFuX3v+LIfj5Cpd6qKBhbyDXKI9dwr1J4vPC4bzPOe8PmQQG8PxDs7A958Rndg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB0143.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(76116006)(33656002)(82950400001)(26005)(52536014)(66476007)(64756008)(66556008)(66946007)(83380400001)(66446008)(5660300002)(6916009)(186003)(53546011)(71200400001)(7696005)(10290500003)(4326008)(9686003)(2906002)(8990500004)(4744005)(6506007)(86362001)(8676002)(8936002)(316002)(82960400001)(55016002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Qrs1yQ0IRJZfJLKF3dAphTvx1EILiW0zT0WDxXO5+1E/1wE30bsSs42Jdvp44hr8476jzvthrggIjUYU9itTK8OaO7sLGyVGnsCRNQW293qFXDnWVpoEGM6bg8IJLgKTpQo5ukf4CFvuQlf+fo6tZozOVL953P8xLvfnxaufhUAJt+N31nPFJzS3pLfiEzLcbSKIar39lYs2fM/Uc+caWVYrwsXNITUAQSCPtpn40YE00buw8oKkanGU+3tGKV6BSLxoSzHK12RvwsSMfSj4HR1GVxrz3tCOUlyTySdRp0TDwqaKL1D8YqCaik2x/VQzqm6Zr8/skKCCad+P1zfstZioOujDeY0efxi3Gt6+1dmphy540GxTPs0ZjQGxHNiS7MXc5EpoIn/gZ2/V3cNEIjxdUxKPZ+Evf/BgmmX+1ITujXLaDXLPtmGot2O5fndxCpzux5MQrMS4e+1yHv9ZIk7DoW0btIR/7R2QVggIFoIB7lS4XCNTkqp7/fpM/rvfeYWHE2O7WKOwdNpmEEzmVxngkxmFgB1dAsS5bISfGBY5wdkhRVaoZVoJ8LtIgCHcwXo+qhb0rluJp7i04TFnyM7iUlJIGZZKstSUfsyrpWRXvtulHRyOyTnrjxhVBQWNkerp51o6uEsCSLPJMUdub9bSKFP15b2ionooI4qxh0v3MVf/1rTd0ykBctvw2z1dktRVRCNyJI5lwS5qtcnmXrhDTFUQDrbkqhMMouaiiygP7xwJK0pATb0t67y0JzEDHoeNzdv7dWA/VYLkEc0EYSWlKUYP8x+n3YbZXIDpUyANRPLyS/i6GU0JOi/794Qj4zjJCNiFZdwp6eM7WdDxGNFvotuHLcAhSHn4vFOX/unrBgC888NQFUGiVU+ajLZ2j4njyj4qwXTgwDk7XmFCkg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB0143.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a44c5a-eec2-484e-4ba6-08d885ca5b82
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 22:45:43.6889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XHH4E2/sFkIlvDQy60ElM24cWPOxm9TI3YowfNVcS6WKskDpnYq1FguBEpSb1Hm00DH51HJHTU8612PcoFghkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0800
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a color cmd, for example: color 2e

-Ryan

-----Original Message-----
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>=20
Sent: Tuesday, November 10, 2020 2:43 PM
To: Ryan Wilkerson <Ryan.Wilkerson@microsoft.com>
Cc: git@vger.kernel.org
Subject: [EXTERNAL] Re: BUG: Windows Color scheme not preserved

Hi Ryan,

On Tue, 10 Nov 2020, Ryan Wilkerson wrote:

> What did you do before the bug happened? (Steps to reproduce your=20
> issue) I set the color in my Windows cmd-line window to something=20
> other than the default.

Could you describe in a bit of detail how you did that?

Ciao,
Johannes
