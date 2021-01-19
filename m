Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533A4C433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 06:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E46D23101
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 06:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbhASGX7 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 19 Jan 2021 01:23:59 -0500
Received: from mail-oln040092068073.outbound.protection.outlook.com ([40.92.68.73]:19494
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729475AbhASGSL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 01:18:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZizvUWGlNcdSD49yqJZr1owZbE8X57ohQKhkhFXiLE1VbW3OXGWdcSI4TXmi8tSY5mTgIGNaCH+otQVal+sZUirNsWwbik00Yuv5IfblPmKL4FMwY2sPodXo2WLdxQ21qwO5FBk8Ne+WjljKejxn4Q6ovIb/m/HSAaJijLUMEGzROke/ka2oP7+kqTM9SGumdYDlwfmZL9pmWcKmqEn9HYuyaO0+/cPO33rwirFg0u/XSMNSwnQ6F6bN85pyHAx585iX1Mq/4WLOzgkbuo/trBWtmvSXgCWpmBVi3GwLcr2ck6GbuLjT54a8yOuw5jkSXhKmvJ8jjmH/E6OmNmCUfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGnheAdUGUJIuRPEPwdy3DJ+L0ffyW63vrOb7mayAV4=;
 b=jUYEL8yp3tKL47dSXmXEkkyXzTu1pEu8vDLTamaHvOUXUNAe1hT60JkRuynAbvQcsx/FZUwQhBQloWhQxc1d8W9eLxeth1LL1niS6DXzMnGAqXZNV1KqM5VmgIsAht4970jlqkX3UjQnr9xEx44k8fh/d5SleSKQAIjoZeNUKU73O3cdz5/7oPOwTLPsnXOmbg2T1Oe77Uek7vIrOeQi0IlViNmenPfB4AbZERpWZOuS4yHhvnC1/Hmo2wUEt+m5jh6ZNA72xVBI1zEAZcPqFzKH0cG8rSZlmxx6dZYeKVEpEb0tg5Lpg1hdnlnlCGyNFaTffufYKN5ptaDZm6ILtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VE1EUR02FT055.eop-EUR02.prod.protection.outlook.com
 (2a01:111:e400:7e1e::44) by
 VE1EUR02HT065.eop-EUR02.prod.protection.outlook.com (2a01:111:e400:7e1e::275)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Tue, 19 Jan
 2021 06:17:21 +0000
Received: from DB8P189MB1046.EURP189.PROD.OUTLOOK.COM (2a01:111:e400:7e1e::43)
 by VE1EUR02FT055.mail.protection.outlook.com (2a01:111:e400:7e1e::290) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.12 via Frontend
 Transport; Tue, 19 Jan 2021 06:17:21 +0000
Received: from DB8P189MB1046.EURP189.PROD.OUTLOOK.COM
 ([fe80::90c3:9e51:1c92:5464]) by DB8P189MB1046.EURP189.PROD.OUTLOOK.COM
 ([fe80::90c3:9e51:1c92:5464%7]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 06:17:21 +0000
From:   Harley Paterson <harley.paterson@hotmail.co.nz>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: False negative authentication with multiple accounts on a SSH-GIT
 server
Thread-Topic: False negative authentication with multiple accounts on a
 SSH-GIT server
Thread-Index: AQHW7iZGAHFuVSSO1Uqz0Q5kDb1cxg==
Date:   Tue, 19 Jan 2021 06:17:21 +0000
Message-ID: <DB8P189MB10460B9A3CA31ADF5C05A39FF9A30@DB8P189MB1046.EURP189.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:2E9F423369C5F6EC83BD09C5C909D4702CD91E8C657F03EC4054855B3347ACA1;UpperCasedChecksum:D9BFCC7BA75DC82C63DA9308D5C401C982583384E2508D13004852803DC59458;SizeAsReceived:6733;Count:42
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [zr/w/8dj4QrcRP+oxLdRceKWyLtdygIx]
x-ms-publictraffictype: Email
x-incomingheadercount: 42
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 156a23a5-5073-4aa8-7772-08d8bc41e15f
x-ms-traffictypediagnostic: VE1EUR02HT065:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SWp9gUIRiOdACyNitoMv9Iwg9IBNCR756UVTG6u+QpAzBZlGtR65GPzzMRj7/V3PGG6Kh4s4DaHvzwOXYi/ppCbH0PdeWmu898LegONxJdvEEPA+NGN5fJRq7mbEqHg2jun7Z1L1ggRPyhVj6S/LCz/QSMkwWmxx4mjRkmLE0iplgEhIKmE5DGEkCsy4WPUe3+uPHxEJg+oS31k9V00YbUQm2MtTwJ2wS36Z1/+VFZCF4pggFz9vJPL8ScbU1n1i3+KdoMjqEVJzoO+DA9wO5zPMQhZE7wbLbRTXGtWBtesaHA8bsnDQAgWNw8LCzesmUomJr/7fUcUe+uF9UAdnmJJgkTTNbny2YS/36Deq6LSWD9cE6V5K1qzAoMFPe+JGFuL7d57cv6SCt7yCMlKPrw==
x-ms-exchange-antispam-messagedata: RYhq4rk52cO8S7aCQQKCJJ3J/YFBknAtFQkAh+hY6fsAkYG2l1Cv7bd5SiGBkBKBvSt1i0hEyU7d4BnhLzZ15YaVf3kpqGV0w9YKsba+SBG4HYkidLVt+XjU3DGy0yMNfppc9ktExwN8FwNDAw42yA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT055.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 156a23a5-5073-4aa8-7772-08d8bc41e15f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 06:17:21.2573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR02HT065
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I've noticed an edge case in Git when a user has two Git accounts on a single server - as might be common for a personal account and a work account on a Git forge (Github, GitLab, Bitbucket...)

When attempting SSH login, `ssh` and Git will eagerly connect with the first matching key. This may or may not be the key right key for the repository the user needs. As a result, Git clones, pulls, and pushes will fail with the `Repository not found` if the wrong key is tried first.

For example, the user `alice` has two accounts on the host `git-server.com`. `alice`'s accounts are `alice-work`, and `alice-personal`. `alice-work` has access to the `foo` repository, and `alice-personal` has access to the `bar` repository.

`alice` attempts to clone `foo` with both her `alice-work` and `alice-personal` keys in her SSH Agent. SSH Agent does not define which key it will attempt first, so SSH may connect successfully to `git-server.com` with her `alice-personal` keys, which do not have access to the `foo` repository.

I'd be interested in your opinions for fixes to this. I am willing to make a patch, although my knowledge of the Git codebase isn't perfect.

- Should Git servers provide distinctly different error messages for `access denied`, and `repository does not exist`? Currently the server immediately closes the connection in this case, so `transport.c:handshake()` with fail when attempting to `discover_version()` because the reader hits the EOF. Perhaps the server could send a hypothetical access denied packet here, and a more appropriate error generated? 

Can anyone point me to where in the Git codebase the daemon receives and responds to these requests? I haven't found it yet, if I wanted to patch this.

- Should Git provide a `-i` option to allow the user to choose an SSH key, which could be added to the SSH subprocess's command line?

- Should Git attempt to iterate over all keys in the SSH Agent when the connection is setup, testing the connection to check if each connected key has access to the target repository, before giving up and reporting an error? This may be difficult looking at the current behavior of `ssh` and `ssh-agent`. `ssh-add -l` no longer lists paths to files (which could be plugged into `ssh -i`), just the key signature. Does anyone know of any SSH/SSH-Agent tricks which might help with this?

All the best,



H Paterson.
