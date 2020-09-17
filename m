Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12CCC433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 10:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B16E208DB
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 10:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atos.net header.i=@atos.net header.b="fpNjvn3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgIQKLn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 06:11:43 -0400
Received: from smtppost.atos.net ([193.56.114.176]:10681 "EHLO
        smarthost1.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726360AbgIQKLb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 06:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1600337490; x=1631873490;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=HW+2JSyZtXwy/GmyoSunMppgrQR3jZZQo9QQxPY2cW0=;
  b=fpNjvn3uQTcBFATVFiUNRTl1jVtMhTcvcyItD1PlmQSvVK8EifKj6N8w
   zmo1ucIqRP7/9l2ZCUhMZi3JN4g0CMXwfl/1w49P4DPNUzxPPJGvxfHrg
   BPMJNQccDLOF6uI3xLNwcOa71hd02HsvyktNF9BKp1P2dHGoyWlR9ChF1
   g=;
IronPort-SDR: kCvGDWdCyanorpmH2t+WkkUvapc6iNG+unQIY0peG7OdOvV5OVFnxj7Noo3tkSH8ewIzUZ5Q3G
 Am+0QshGk1/mF145ti/XGPFMTfWnq+1fnPJtq4jjgQIowkO1AHFxyX3faXvOTPEGVFByWS3LQO
 0tG7myB4SEdTgX91ScxnanxYIaCEgsICfifGhTrohlfFEsV5fMWnsqLnmoTMbJMCDH4EX5BtNt
 d1pvTKyp6K9d+8kydso+bwkrFFG9Wk5IAEq6UpvE5BVUPwKC+hbGlhg1oi3o574acdS5rm7RWv
 72GMz7bjycZYPCWb/L9MM4ZB
X-IronPort-AV: E=Sophos;i="5.76,436,1592863200"; 
   d="scan'208";a="114911330"
X-MGA-submission: =?us-ascii?q?MDF9zSV2yTlYrrknwUHKQ/yJ8Qe8cEJyb+dLdd?=
 =?us-ascii?q?JL6721O9Ex1HoURfZhrxJoacqSsaQfGYxB/ZqEPj6LAcKZNajEeepSM4?=
 =?us-ascii?q?CyaASg7dYtzcj1dp4nBZhDsrlJdRbuY64+PdfItZ4v3n5T+rEeHtGBYl?=
 =?us-ascii?q?rD?=
Received: from unknown (HELO GITEXCPRDMB24.ww931.my-it-solutions.net) ([10.89.29.134])
  by smarthost1.atos.net with ESMTP/TLS/AES256-GCM-SHA384; 17 Sep 2020 12:11:18 +0200
Received: from GITEXCPRDMB24.ww931.my-it-solutions.net (10.89.29.134) by
 GITEXCPRDMB24.ww931.my-it-solutions.net (10.89.29.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 17 Sep 2020 12:11:18 +0200
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (172.16.214.170)
 by GITEXCPRDMB24.ww931.my-it-solutions.net (10.89.29.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3 via Frontend Transport; Thu, 17 Sep 2020 12:11:18 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UX1sHpFlUTx99W0R1uK2HHabg6Fl8GWATFSFgYn5H9qQI3O4NBQllRgNcma0IxcIOhmRxg4uLGHj9cUfjRwzSjHiWgbrx6J+hxK2dFbEkU3NhTNpOp6n6FXtyi9RTdIAcwqtf7I6VUBa9SSxHfmoBFTIt3zl2LIdAqlrvy1r1apdRGkin+OfzeNFx/Cu4+YJIqDpSuT6M0bYbeApuwg/UN2nmoJmroywjUOTcNZ24ezdcELu5xtIiV4fbQhMNml+qGxRCMfHABeX8w6XFNmkjps+BCyp875UqsbIxj+H7GZGoHhjWG2YDYweBtWV5Ly+IgHWU63ffvkGpXJkuBjmiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HW+2JSyZtXwy/GmyoSunMppgrQR3jZZQo9QQxPY2cW0=;
 b=TLJ6MdQCRD3IS/rMDar7zqxNSZzQtRsYzmjmvY4aKN3KgSY504KjFScxK5/2qB7QA84YQ/CPpSyYESPUQtOSJP3x8EVsndoRyKvjtMrIffqqf6Q2WdPoZWApC1fCHShxKbvrVDCDTtpVMAiQ/DY1OLvU9VOASjKtJCwBoaPDL6WnG9ewR3nzwoy04013zqm/Fx03ZwVT26HOjZYCil+V8p52F8Ya5bgyC5YVYdDnUeL72uxLmOYim/jtaFOQycEJIlTjq0/Wyb8EeYd+u98qceOnXmwhrNyo6Q+gUrZE6SMGxklYrGUqnv1Z2yZEPKcQrMW3nEvUGcMIR46wcKciHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AM0PR02MB4081.eurprd02.prod.outlook.com (2603:10a6:208:df::14)
 by AM0PR02MB4292.eurprd02.prod.outlook.com (2603:10a6:208:e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 10:11:18 +0000
Received: from AM0PR02MB4081.eurprd02.prod.outlook.com
 ([fe80::115e:fd7b:4f9c:6b51]) by AM0PR02MB4081.eurprd02.prod.outlook.com
 ([fe80::115e:fd7b:4f9c:6b51%7]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 10:11:18 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Has there been a change in Git Mailing List settings?  From list as
 sender to originator as sender?
Thread-Topic: Has there been a change in Git Mailing List settings?  From list
 as sender to originator as sender?
Thread-Index: AdaM2sus1K7J5wJcQwu+SuxuGJE34g==
Date:   Thu, 17 Sep 2020 10:11:17 +0000
Message-ID: <AM0PR02MB408170D1A71FB8C0E82A14789C3E0@AM0PR02MB4081.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Enabled=True;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Owner=richard.kerry@atos.net;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_SetDate=2020-09-17T10:11:16.7422993Z;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Name=Atos For Internal Use;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_ActionId=d0063be8-9dea-4629-b57d-bc6acbea5f66;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Extended_MSFT_Method=Automatic;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=True;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Owner=richard.kerry@atos.net;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2020-09-17T10:11:16.7422993Z;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=Atos For Internal Use -
 All Employees;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=d0063be8-9dea-4629-b57d-bc6acbea5f66;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Parent=112e00b9-34e2-4b26-a577-af1fd0f9f7ee;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Extended_MSFT_Method=Automatic
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=atos.net;
x-originating-ip: [212.56.108.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9530d278-7793-4b48-7a61-08d85af204be
x-ms-traffictypediagnostic: AM0PR02MB4292:
x-microsoft-antispam-prvs: <AM0PR02MB4292073DD9009962373BDD1A9C3E0@AM0PR02MB4292.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K3rW7V1KZlauTlxa+jjJ5tRRpx2BwY5aKjPEp1KT5+XbV+rg8xe5XQsOOm5M1FRcAJ/7cyTsKRPO+7+WEM94dmhJ78AjZrqIS23lKF/9LNFFkkBp/iDxGEDuE99r7EAqsTZ71qcb8Ql07dNnO9ZPdS+fX/WTEZ80wIl5UH1mt68wF8X9trrrlC6EPckNwxi3EDK8kCxqeeJXWHvdhssceQcpczErwuCC7oBXiKkUbjZRkLGAgxSvS+nXCZWOaV4Tl4X5kYAabghC+HQpWZvzh7ljZsmBgFmKOSv9LAcUOH6Qfa3gFWQamXzghDkEgS1BZiW+sYH/lLvNvrCK67Uosla9zdRvYfb9VwS+fWbbKzAgbpbAV6VDWQmii+zgSMOgOq9zXrIbmwh/7eQyxlWKk5Re7mxqpj43IKxUWAFCDdo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4081.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(478600001)(8936002)(55016002)(8676002)(83380400001)(7696005)(86362001)(9686003)(66476007)(6916009)(66556008)(64756008)(66446008)(33656002)(6506007)(76116006)(5660300002)(66946007)(71200400001)(26005)(186003)(2906002)(4744005)(52536014)(316002)(130980200001)(223123001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: RBbm6LJyWbgp2qlCxpDUczXB7XcjgNv04cLYpW/ynR6PiqEWHr3CcWhd1cBmAEPc/snKvwup3nfWKqoufZdXdy2LDm7oHkDkbjaqfKgGR797D61lFsrwc6lBcaEf0UsGWQh8Ph24NQeordU5OPbt8kkhQtcd97QlQr8Tjcgv9gTCKcT7NJknPR2B0KSk+tipmqqXEx013V6Cda+kcDBG2JVAWm8p/74BA9TtnUoUr9KfGPU1/yvKFvTQEMOp5yDaVPTzdqDUlZQeg55Z++spGzV3pdCeBqnc0mpregHplx+40+RX/WSMqlasIWJSiMiu0QxL9ArJU9pEvING1m8vvr5jGuuEjlCMLR9Ig4GfKSNzOW3+4lpLfEnMI6RdB7skPCJsxxMY+m4V/UBj4gczePWoWez9DcaXaLbp23G6Wnr3E+fg7070oDWPST+eBBOKcTeTQvY05/W/r9CoIAwFpMVkcpvGjCWc736R2c7FmgC+5JPwpi3PqlhaW82OL+vF4i1GOF5WhLcD9vjWBqiW6Xsx2nXtbdTPufoG7wVVB7foI9fCOzEEv2D+MhufWTcYcAoE3LdaHbTs2OuXG1Tuh9KPyfeqXhwmWc6ElXN4BXtapOtUk0Coqmumx8ByMkw9of2bXRWCdf58PpQRcVlq1Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4081.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9530d278-7793-4b48-7a61-08d85af204be
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 10:11:17.9353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ICRhKozgVkAuiN1UXT1yzD5i7znO/8KIoI7bZz+9w05b8UW7E224h9Az2Kgy30LGdEL84nyEd3IKmmIJ9ghQDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4292
X-OriginatorOrg: atos.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Has there been a change in Git Mailing List settings?
Up until sometime late yesterday, messages from the list came from git-owne=
r@vger.kernel.org, on behalf of the originator.=A0 Now messages are coming =
directly from the originator.=A0 This means my Inbox rules have stopped wor=
king.

Is this a deliberate change?=A0 Unexpected change in mailing list software?=
=A0 Will it be changed back?=A0=20

Regards,
Richard.

