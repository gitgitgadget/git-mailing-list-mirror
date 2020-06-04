Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2B6C433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 15:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CD70206DC
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 15:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=man-es.com header.i=@man-es.com header.b="uRUErhWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgFDPOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:14:50 -0400
Received: from mail-eopbgr80097.outbound.protection.outlook.com ([40.107.8.97]:61475
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729107AbgFDPOu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 11:14:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkbU5gW7WwTfn+ddhiVpAPllZCe4+kPivC5S7cRGaBAvknTPvRfVZ987+9Uqtu0qDUNQU5SMQZGQy41syTFuExheg0gmJOEIdfjps2prcJ4moR64xzH7jIugGHM12GcjI1tHyAaZZvTJZtAN0hS3N/KIS5YAjlRZnhfK+sHCdpzm53/x5/Py4XjtyE3bJt00YAEDMcA3YhcsDCErjII6XjZMyo1Wh8PES5131ugE5rDt4KMepL8Rs8NOEmKnIlT/bGoBXNPn7tvip2EC8ua3rrvWzYS/Vv/9JfSWWYMZNlxLQmoJ/DVOtFbaipZ3ghLt7ikgq7bW1URvEF/uGqvwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRpWRnEP3NR0qHLOsa2Vu9HWRd912PmMdF8TGvVWmyg=;
 b=JV78MxVTtN1M4vRZ7RySRLgGlqRpp3WtgFUAwbELQcNRlzM41JIc0WJXl9Nras9PtzJgg72lO+TwHAk4XdsPKEyNjf6pf00UDLvKsrbR7oR9f4cu6rLiBoI93WcxtdqEgzxx8tsyWWD5iYD5GCsfLcDDfCH+EARfo28Orye7tRyvNmoaGz8v64pXWpjK+OJvyLFBdihf3aKlgc0/7zRimlOsU7A9uhgr15RwuQrOu7OFJRbX9yuWcCE6mCfSyRCe5hzWSdorDdUwQRrNP90yxgSrmODCPPy2//8ngXZlrXeeomFBrHMrx2TRRZC9XML71w7IwlZcIQRMJgQW1Jh+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=man-es.com; dmarc=pass action=none header.from=man-es.com;
 dkim=pass header.d=man-es.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=man-es.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRpWRnEP3NR0qHLOsa2Vu9HWRd912PmMdF8TGvVWmyg=;
 b=uRUErhWV7Xn8Zbcd4gnzyLrchexhkVBY12KZ/WsNaK7r7OJvlkqKMM93hboBpQbi9V7eTp085xDCAlvWSjybGABCFB9kWPn16tCEOUovQ0pTOcTUSwyhmoQ43TjqTBbCJdM5PCq9RQU41cS86/i5YMlDBTV4A6UuzMIvLxnNR7Y=
Received: from AM0PR08MB5537.eurprd08.prod.outlook.com (2603:10a6:208:148::23)
 by AM0PR08MB3395.eurprd08.prod.outlook.com (2603:10a6:208:dc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.22; Thu, 4 Jun
 2020 15:14:47 +0000
Received: from AM0PR08MB5537.eurprd08.prod.outlook.com
 ([fe80::f05d:e55a:aad9:8bc2]) by AM0PR08MB5537.eurprd08.prod.outlook.com
 ([fe80::f05d:e55a:aad9:8bc2%6]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 15:14:47 +0000
From:   Kalle Kromann <kalle.kromann@man-es.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: The commit-msg hook is not invoked by git-merge as specified in
 documentation
Thread-Topic: The commit-msg hook is not invoked by git-merge as specified in
 documentation
Thread-Index: AdY5pP6PAidBAzepRc2W87PwqBsBqAAOCPWAABsFR5AADkxQkAAAFeZA
Date:   Thu, 4 Jun 2020 15:14:47 +0000
Message-ID: <AM0PR08MB55374383893333BEA293041ED7890@AM0PR08MB5537.eurprd08.prod.outlook.com>
References: <AM0PR08MB55379DD182941E93F3BD3D37D7880@AM0PR08MB5537.eurprd08.prod.outlook.com>
        <xmqq367crlti.fsf@gitster.c.googlers.com>
        <AM0PR08MB553711CE7CE5D39EC2CE8422D7890@AM0PR08MB5537.eurprd08.prod.outlook.com>
 <xmqq8sh2rhm5.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8sh2rhm5.fsf@gitster.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=man-es.com;
x-originating-ip: [165.225.194.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f1ca572-8603-4c59-34a4-08d8089a04fc
x-ms-traffictypediagnostic: AM0PR08MB3395:
x-microsoft-antispam-prvs: <AM0PR08MB3395F89586857B9BE9FD9409D7890@AM0PR08MB3395.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 04244E0DC5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lejovtAOWnNLmgN7W0/Yhu35H4o23Q5wlpMU52sjggGdsOE02F3cDU8/Y3a95S3lHKiPMi6TvJegZnXuvTAHc5pqwgMxjmXsTvthYFsmAwtw+LhAEAPQicgCIkvSaWckveUoKEwwtyaJ5/s/9o3iObeTn0//g3VHmeTLnW5smCfGnkiIE3fzKWkpCCrJtecxQEeMmZzRNQpuaO3LLPpW8mE/AE7PeiMJlsG0LOd+lOO5R+k6jzcK+r2ZMJDnp7Elot3XE4/18TOXkcYursFEYjcJG3nRSayQLK2IePHcjGFe6MJktiuvhyAc6zA1NK6gkaNApdP9X6ZwDlta0mxGzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB5537.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(4744005)(66446008)(186003)(44832011)(71200400001)(66946007)(64756008)(5660300002)(76116006)(66556008)(66476007)(7696005)(52536014)(6506007)(478600001)(8676002)(2906002)(26005)(83380400001)(33656002)(55236004)(6916009)(8936002)(55016002)(316002)(9686003)(4326008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: e6uBD1nE38SSZ5/p9+CrrcefVKYPnjMZk0eLlJE0aZnjrar/fAESUyiVXhItfr6kYrPzsWO9JSh6u0dHM6mFDDTJH7OwMm3Ldb4Gs8gEPgdCBam50ZEDvrhJuhjI0sqXW2kOKYgRpFl46u5myL8gIAOcWjWxEOUezOUH2km+zE1GxMPg1tBvSAiU1B+pmhChzex9DBZDyAS81Nb2qT/j0/tcgMgrRmWLJMLft/+Sm+E6Nbin2camQCQakP5aGVE2M9dVnp1gJbOWikcCd+WitNF9KQfwV5k8WOxm3/LLavhwKoiaWlx/wxU+Il2nOommSaligWl4+9HTXu0+UQ/PNmF5ZUs4udMtcruu4C4FN6muPl4cH0iYcVeEhbyF3bV7EQ1sRBI+xrPnrJyHW5K9e4YgQnMMk7P0SMi3+vFnXy+yLTyOR6AF+0NGcXSnuEd0whehuFiWkJHZ9Y2/apBq1fdrBXtLcMCFMe/PWe2raVOGL7EpqkJBlkjZcVR6KGxg
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: man-es.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1ca572-8603-4c59-34a4-08d8089a04fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2020 15:14:47.3758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d5f1616e-c93d-4966-a1a4-a5ccabbd76cb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nam/Xzt5k6v9XIvdv7uz8Q0bNm+U1JigykHCHdpRX0jypxn9eLV5rGLl5TYC0UcnRsAJRTR1FdV4/P3zYNR6+qKRHvO5gMcYbgY1WLXWvLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3395
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you so much for your help.

I'm still quite new to git, and this was definitely a rookie mistake.
This is an e-mail from MAN Energy Solutions, branch of MAN Energy Solutions=
 SE, Germany (CVR no. 31611792).
This e-mail (including any attachments) is confidential and may be privileg=
ed. If you have received this e-mail by mistake, please notify the sender b=
y e-mail and delete it from your system.
Any unauthorized use or dissemination of this e-mail or its contents in who=
le or in part is strictly prohibited. Please note that e-mails are suscepti=
ble to change.
MAN Energy Solutions SE (including its group companies) shall not be liable=
 for improper or incomplete transmission of the information contained in th=
is e-mail or for any delay in its receipt.
MAN Energy Solutions SE (or its group companies) does not guarantee that th=
is e-mail has not been compromised or that it is free of viruses, intercept=
ions or interference.
