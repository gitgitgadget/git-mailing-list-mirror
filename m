Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233C2C433E3
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 15:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8ABF20771
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 15:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=strongestfamiliesinternal.onmicrosoft.com header.i=@strongestfamiliesinternal.onmicrosoft.com header.b="MaQt+HyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgGWPUy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:20:54 -0400
Received: from mail-eopbgr670132.outbound.protection.outlook.com ([40.107.67.132]:39822
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbgGWPUx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 11:20:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=by2Xk1yXFVUNFwabYPAtex6PacYIw63TbYTdKx3Z5bdCdkDnt26usb/5yG0nWhC1xbjhnJnJNl9Im0jex0sce5mmQ8YWhOa4F7XPqagIVL4glqDRU/9e14X4rvNZgKJcrJsm2C9JJrnIQRgDsG3HP8mT79BxrzUl0JFKhWD+qDK0qN/o0CiRy7/ST6ahpNTRWoFmq9PJ6sByNb5zj8IniDxul+3/HrhkwC40gHBYXvWOYbrt3r+7j2eLjzPEm7uhQF9n/1FGAfiYGjL1QHQazihrKZSN+8CMdZ5nTjA6ik7d1nLPvuyx+rLSgA2Iq0UbGDa9Dr4TRYfCfqYbpC8qVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7/+kKpxnLw6a+LziNd/k3wxBySg4TfLM9OmATp6rcM=;
 b=IfE4CUhqkdLPUdrTy97BkXHm3sP43Xy6W/Bev99lw1EHr8W9dTpnyLUNTvZXpcrl7nGprlN/+DhX0FlBc504TclhguGMdrx61vP+8n+I+DRIitZOAAOc6iHLivDE5XwjJLQtHENAOb+VbY0slBxUsj6FlwSbUE4s05+OPpGnaV1DovXUrT00hV+89fN+YRaHtbg4nVG2arx5gi2ywXrryOowo1Evd5cAy9oXJ0cWL/k3oC/MNwsXhoz6w8HlbFAKAym8R5jjjxbUnBGMjLLLggH6TbVxRmibzj2yUp39VzZz5Svxl3fdpMxsHLOKcW0+pn9w51p5R/yklPufN6Zzxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=strongestfamilies.com; dmarc=pass action=none
 header.from=strongestfamilies.com; dkim=pass header.d=strongestfamilies.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=strongestfamiliesinternal.onmicrosoft.com;
 s=selector2-strongestfamiliesinternal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7/+kKpxnLw6a+LziNd/k3wxBySg4TfLM9OmATp6rcM=;
 b=MaQt+HyUJHmVXgl7DbCRKOcSaucivElWTm4JKvYoTBcbLSNcEvgw9abf9ZsIRSLgG+ZZX8QOB1ODBwkhRCmawI87Vo0zAdAYywtww5hMYNontahebk6pUvDF2/P/pZbJAA9o28cbU26l4wdvWPAAEhY1gJME3deF5wF/3J69u6g=
Received: from QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:35::31)
 by YQXPR01MB2536.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Thu, 23 Jul
 2020 15:20:51 +0000
Received: from QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::25ac:cf38:6d5f:b42e]) by QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::25ac:cf38:6d5f:b42e%4]) with mapi id 15.20.3216.024; Thu, 23 Jul 2020
 15:20:51 +0000
From:   Casey Meijer <cmeijer@strongestfamilies.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: BUG FOLLOWUP: Case insensitivity in worktrees
Thread-Topic: BUG FOLLOWUP: Case insensitivity in worktrees
Thread-Index: AQHWYQRMte1QWK0kaEKnR3jjpovCbKkVFV4A
Date:   Thu, 23 Jul 2020 15:20:50 +0000
Message-ID: <8BABB6F0-517F-4AA0-9FF9-92AF8C33CD0E@strongestfamilies.com>
References: <EEA65ED1-2BE0-41AD-84CC-780A9F4D9215@strongestfamilies.com>
In-Reply-To: <EEA65ED1-2BE0-41AD-84CC-780A9F4D9215@strongestfamilies.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=strongestfamilies.com;
x-originating-ip: [216.208.243.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2bd53da-5e94-479f-02ad-08d82f1bfbef
x-ms-traffictypediagnostic: YQXPR01MB2536:
x-microsoft-antispam-prvs: <YQXPR01MB2536E2B0D8156222954FB758AB760@YQXPR01MB2536.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xcA6Lzkb0ImSbOSYtXGMQA8lkBSLvkT2w7HqWAWzpo3pKDaPjvr8LnuQTZzW6QiEecC1Ae+dX4H6zFu52oqAEPE0xPSxvZ9pqycrxUVNIbsY405o3dbFnzriGRDbi+BenVI0aDAi2RfZPhwGeu+gSCypuFRNoH5PFNaCXfdiTdV+oO92NY6gHZk0kc6WYtragMemUX6V/O1z3arVvh+/aeprkjs6HQ4jx2WdzzWhDX9G0vg5FsDCVyYO2tND9oupE9VLPQh121iGYdq/SnghVe/zl/hMXoWQoRA2ziYxxtBcCa1y2MdFsPCIchHz/TU4XeSY3qDZIc9ToNZzqgtp3HoSdW7VSuoFYDOXQyVyJoqRW1lHmGgYYFUPVMxdZo6xvdMPcOJ+28jR0W1rCSWzHF9rR2NtVyK8RkhBBFOEkzgMf5ef0gh7Oz/tAQt9x011BSe2DXv0FfWOMc08RDFZjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39830400003)(8936002)(66946007)(76116006)(36756003)(33656002)(4744005)(66446008)(64756008)(66556008)(8676002)(5660300002)(2906002)(66476007)(316002)(508600001)(26005)(966005)(71200400001)(86362001)(6506007)(6486002)(6916009)(6512007)(186003)(2616005)(6606295002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: mEZYnXldE2dCIXb+RNw944QGqcJp5J9Eq9mrir0MlvnOaxT91yA4mgQmHG/aaPwfxVhdsVGXX7pHD47DK/yttn0WWcR4jwSfc6JtBA53/Vt4b3oQIoxrqpXM7v6WKNUjpf8t2gGmi79TfM1qiHa5spYOAEmsYwGqsDhy1E8hnARsJLIwPb3GcJTzzi/nHvfpNzdmjFHiJwYEo0gF6e+uYr6ZEJ1KazBxKUHNBTNo6Jj+/S9vDcHaLJwxhkGg3j8vY0TxmgkUT9gZ9zhRMixwgLL2IlEuvP8mpFkb9lfjZ2l3rmwOxbX0GPodtoKOTk+Cv1Z7vZV4nkKWaCV2eA1iCCO6OUJ14+X42GTnaOYBXt27geaZE3VTQrRLyLclI4BGOVt+LWQJbeD9u4eS07Ua2bNEdTKtHWbRJUp9i5uSq3wRddgUi/fd8s9Nzb8MTqPFu/tNecQlhl2BjdWPLd02yK9pg5nHYtyuMJ8Xl/ELF7UgypBpRx3IZ6mZWOJvoewo
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1061A841E034F84F93B3577AA0DF04D6@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: strongestfamilies.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d2bd53da-5e94-479f-02ad-08d82f1bfbef
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 15:20:50.9503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 88c0a794-6b77-42fa-a51d-2e160c167dfa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AsFEtg486g+eve0qJv2ALUmdlNmyvvzXYjJbCkI/wLKXPL7KDckEd6Xnjq+jntaaH7JxCACtaYXul/AriX0a5u4n6NG2AHZpQuj1PutrHbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB2536
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhpcyBqdXN0IGJpdCBtZTsgaXQgc2VlbXMgcXVpdGUgb2xkLCBhbmQgSSB3YW50ZWQgdG8gcHJv
cG9zZSBhbiBhbHRlcm5hdGl2ZSBzb2x1dGlvbiAobWF5YmUgaXQgZG9lc27igJl0IHdvcmsgZm9y
IHNvbWUgcmVhc29uIEnigJltIHVuYXdhcmUgb2YpOg0KaHR0cHM6Ly9tYXJjLmluZm8vP2w9Z2l0
Jm09MTU0NDczNTI1NDAxNjc3Jnc9Mg0KwqANCldoeSBub3QganVzdCBwcmVzZXJ2ZSB0aGUgZXhp
c3Rpbmcgc2VtYW50aWNzIG9mIHRoZSBtYWluIHdvcmt0cmVlIGJ5IGNoZWNraW5nIHRoZSB3b3Jr
dHJlZSByZWZzIGZpcnN0IHVuY29uZGl0aW9uYWxseSBhbmQgb25seSBmYWxsIGJhY2sgdG8gdGhl
IG1haW4gcmVmcyB3aGVuIHRoZSByZWYgZG9lc27igJl0IGV4aXN0IGxvY2FsbHkgaW4gdGhlIHdv
cmt0cmVlPw0KwqANClRoaXMgd291bGQgaGF2ZSB0aGUgYWRkZWQgYmVuZWZpdCBvZiBhbGxvd2lu
ZyBwb3dlciB1c2VycyB0byBvdmVycmlkZSByZWZzIGluIHRoZWlyIHdvcmt0cmVlcyBhbmQgd291
bGQsIGlmIEnigJltIG5vdCBtaXN0YWtlbiwgcHJlc2VydmUgdGhlIHNlbWFudGljcyBvZiB0aGUg
bWFpbiB3b3JrdHJlZSBpbiBjYXNlLWluc2Vuc2l0aXZlIGFuZCBjYXNlLXNlbnNpdGl2ZSBmaWxl
c3lzdGVtcy4gDQrCoA0KQW55d2hvLCBqdXN0IGEgdGhvdWdodC7CoCBJIGNvdWxkIHdvcmsgb24g
YSBwYXRjaCBpZiB0aGlzIGFwcHJvYWNoIG1ha2VzIHNlbnNlIGF0IGxlYXN0IGFzIGFuIGludGVy
bWVkaWFyeSB1bnRpbCB0aGVyZeKAmXMgYSBwbHVnZ2FibGUgc3RvcmFnZSBiYWNrZW5kIGZvciBu
b24tRlMgc3RvcmVzIPCfmIkgICAoSSdkIGFsc28gYmUgc29tZXdoYXQgaW50ZXJlc3RlZCBpbiBp
bXBsZW1lbnRpbmcgYSBwb3N0Z3Jlcy9zcWwgc3RvcmFnZSBiYWNrZW5kIGlmIHRoaXMgcHJvamVj
dCBpcyBtb3ZpbmcgZm9yd2FyZHMgX18gKS4NCsKgDQrCoA0KQmVzdCwNCsKgDQpDYXNleSBNZWlq
ZXINCg0K
