Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2875C433DF
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 12:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A351720825
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 12:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=man-es.com header.i=@man-es.com header.b="SmCYBXsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgFCMqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:46:32 -0400
Received: from mail-eopbgr00115.outbound.protection.outlook.com ([40.107.0.115]:26850
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbgFCMqa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jun 2020 08:46:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlS+cizS3CvgHiB0I2h7Y/4rkVkE4po1yVAD/B41WoT+Mx+rk7KDETDb26tjfxIk0uZDojP//tsBHgc9JFiv36wob/tNSwvO7km0SyEcjLv3keqrhFXgv5QqwSRhTn00g4OdhZ6+Owr2+sqfscujsg0IwzWfUfHpVB7SzDk6bEUlrIlbgayNq9m/m4FVlJuYoPUEwTjnyKBHuVPHc0VcEiQAuoSYddw+atiO75KJn6N43KyPay+EYPQV2KMFDHTCcwIvF9SKzB4DvW6VmgHAjm1QpRuk7OgN1NUVccqWoC28VQVweL+THN/ZVbYl8tg7GYX3/XCZfpDFGQ1Jc8632g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjye/YTQ3dpmFfMvXeaKf4CyFWKX56Z3gzDRVxBsXGE=;
 b=Ihkipcm7aW5lNiI+G04Mr0h0+prfp/b3qMBU1M3g+ORGU1v2ahysU9X5k8A63KXUVZQ9R2dZZt+7lzq1g0lmWSdl5f3KX2HN6r0P5aANr12LcKqeehPWTWfAlE3JC1KCh2TBB3rgbVwLmyRNLeckIo6kIo76AQyXByr9ZSrP7sqsAhg9JlGQR045IgQZ7otlEQ2F1hWSSBVCeD3B8Go4nucwPwpKelfFOiKGHfuPRNA13lGW/BDIZPuzBk1YR1ZQN5HdwMBwJE+61x1hF69F3Df6A+kmwG8Nv9oDur3W+Dpg0azzxLTOca0uNShCYkFFLaY2P2STActdk0y9bD308w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=man-es.com; dmarc=pass action=none header.from=man-es.com;
 dkim=pass header.d=man-es.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=man-es.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjye/YTQ3dpmFfMvXeaKf4CyFWKX56Z3gzDRVxBsXGE=;
 b=SmCYBXsGoNvC8c29qJxsUzxCQsco5qLcLhvz33EEaOmQjVAgu9MMuGRhhRhroyro3hvFm5c072/AFvaewHSkJ/BZjBHcOYlctzPrGICFyz8FGw4vmtqqcXc+Y212CCjGZTsKfGiWeqyB/PAeehKNDxhgBMK2LuRbT54r70Q3WZk=
Received: from AM0PR08MB5537.eurprd08.prod.outlook.com (2603:10a6:208:148::23)
 by AM0PR08MB3315.eurprd08.prod.outlook.com (2603:10a6:208:5c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Wed, 3 Jun
 2020 12:46:27 +0000
Received: from AM0PR08MB5537.eurprd08.prod.outlook.com
 ([fe80::f05d:e55a:aad9:8bc2]) by AM0PR08MB5537.eurprd08.prod.outlook.com
 ([fe80::f05d:e55a:aad9:8bc2%6]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 12:46:27 +0000
From:   Kalle Kromann <kalle.kromann@man-es.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: The commit-msg hook is not invoked by git-merge as specified in
 documentation
Thread-Topic: The commit-msg hook is not invoked by git-merge as specified in
 documentation
Thread-Index: AdY5pP6PAidBAzepRc2W87PwqBsBqA==
Date:   Wed, 3 Jun 2020 12:46:27 +0000
Message-ID: <AM0PR08MB55379DD182941E93F3BD3D37D7880@AM0PR08MB5537.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=man-es.com;
x-originating-ip: [185.46.212.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 248b5662-d499-4897-54cb-08d807bc21aa
x-ms-traffictypediagnostic: AM0PR08MB3315:
x-microsoft-antispam-prvs: <AM0PR08MB3315DAE71EC094E90B0C63F0D7880@AM0PR08MB3315.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w4t0Gx5PI5kZ7JeXU8rT7WYxw5mm2LNFLvLYFejLSgb0ozrIhu8rBI2BgMOfrenLixcZ/BH7rrb+dovaMMdmVFz2uxpQrH4aTQ7wtDRboKll7+KHSmbjGkfp+Bi4EuJ3wC9ij6nn3UgFywkmZwQgXp9eIw2izBKfVKezq+sINaDF23bW3MFTyYsg3Ah5Bc2VUSKD1HuBKlPW5s1+MV0E35Tz5teAAKY/ONBgsgEgokCmTVIF6k7Zko0TvOg6I3ayMjqc7byxU5hmYy+L4BeUWHx0JOYww2+ZQFznImW5uxq3Q2EZvod5FeODtARv2MWvBD/zx/GmSDW6yr0DOtezNlGwb7fqIkS/mNxYezK1py5Ck6a+OgT7C8Qvs7VparOpo+gxkDyRkzd/E+TpIZwh0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB5537.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(966005)(9686003)(71200400001)(55016002)(52536014)(83380400001)(86362001)(478600001)(44832011)(2906002)(186003)(6916009)(7696005)(76116006)(33656002)(6506007)(26005)(8676002)(64756008)(66476007)(66946007)(5660300002)(8936002)(316002)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: yGEWeqwDJYuR5avB11t0lETmCJ6LVKEBosiivdRQSm25y1nw/j95s3f/f1NlSIfV9zVOK6G03Y40oGipV5UQUJ1Pqz9hsT0jVFOVAebXx6VghSY4RpmkYB7kQxCs2jyrd6UAQdCRe6/gt2eLerB8mFfhHsHObJqESTcEHH1LE5ApFKVz3xlV7vCey4sgE8K4iLnWY6RID0tx4inhfZdy5k0azOZgSZlDWekQyY+y8MadVxofieoypBMrXC+jUyd3qAxm0h6mm+9doJIuN0keQpblvTxiKmPQwcKBcknqkNvZKJ86JU50r9qFOvXiFxXSzLfZzTUZUVc6g3AlF8n9llCJsT16eRY51qTJry7tKE3NzX2onMesHrkRcp8IsncGQS2ZdtWKCH/tNz3O+ip4Lio+kcI198RBWw7q2pD0jYotvH9zc8k4bsjBFD7jN88IatE+6YOLITZa30hAPI35W1jTi4VviSlE7vZ1NYXUHao=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: man-es.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 248b5662-d499-4897-54cb-08d807bc21aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 12:46:27.2362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d5f1616e-c93d-4966-a1a4-a5ccabbd76cb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQPxSYYi9rTMUyQg/w0Am2MKHFGsZvO1Q3piWZBi9z6XXlUmB2JKcSQt+spzBmQ0kSYigcoBTVrF0EKJo23bf0tDAfdJ0Kpi+yYdk4zJL0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3315
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

At least two places in the git docs it is specified that the hook "commit-m=
sg" is invoked by both git-commit and git-merge.

https://git-scm.com/docs/githooks#_commit_msg
https://git-scm.com/docs/git-merge#Documentation/git-merge.txt---no-verify

I'm experiencing a different behavior however. The hook seems to work fine =
on git-commit, but is not invoked by git-merge.
When I use git-merge my text editor opens with the default message, but whe=
n I close the editor the hook is not invoked as I would expect.

For reference, the prepare-commit-msg hook works with both commands as expe=
cted.

Is there something subtle I'm overlooking?
Of course a fast forward merge should not invoke the commit-msg hook, becau=
se no commit is made.
But in my tests with non FF-merges the hook is still not invoked.

Kind regards,
Kalle Kromann
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
