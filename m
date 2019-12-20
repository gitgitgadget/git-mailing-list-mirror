Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213EDC43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 20:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A5F218AC
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 20:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=strongestfamiliesinternal.onmicrosoft.com header.i=@strongestfamiliesinternal.onmicrosoft.com header.b="DnVWsF+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfLTUEO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 15:04:14 -0500
Received: from mail-eopbgr750135.outbound.protection.outlook.com ([40.107.75.135]:6281
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727504AbfLTUEO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 15:04:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWK2P/C/ASniMRZPo4BlbbEB2PKCE2SDGcX+1zr5OljNxapiYM5MHjmgmLCIWhD0B2W3BiI+/4mD7oPABmhy/1Hqjb/xiEf64PQYs0cJJylOo0AyB9oU8V1zmlb74x4wQli80Eoc7vXivk2AIFugPxEvxOztdrUwhblV9HdWgrWrmxjW5k1wvJap3XT1TM8fPC6mJN+Ckt08OSTuOdzaRISvVPyYrrFAnouPxAAUowialqTlbm6svcQqHcMRmKaQOBCFnIPri5kUM88XzOeNhM3XwmV0ayvDFc/KkBbyFJdqGr+AP/Jp4y+H4pDQU37ZlpB4s0G9WHV8tRgI+HGPAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmcIIvQALxmFLg1YjjpGR/IUdwbogvM6wbigMSwFVE4=;
 b=FdtoiKqUbfNSjbQ3pZZwkFsKh9C9IcWVZ7GbAslHNNLW6Xb9z+CO1aHrrg8DUoj4xlc3BfM7xI09pwFAWMZVDCqDgEgsCQlIldisZ4ql4pwg69q2xk0C1c3jFUfEmIexKGvyzZJQbH5Wu8nkb7MogOVtLBBH5f3ufYgbjXm+YAh3jSoJJRy0a0P/W2ojdIDUBktoOXgpE6zq4WsUqIZmfGvk/KUrCzFlP/caP4i4iqGyA6fYJ9vdyNGVAzKv7Qh1idrRsbHtYsAjVg4e/DKBFBAGkPmseCP0eDDi/iKm2w9EH6rKDq6YZ9n8gX1ziks3Pr7+KoNHd31Z1EFlkjuq/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=strongestfamilies.com; dmarc=pass action=none
 header.from=strongestfamilies.com; dkim=pass header.d=strongestfamilies.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=strongestfamiliesinternal.onmicrosoft.com;
 s=selector2-strongestfamiliesinternal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmcIIvQALxmFLg1YjjpGR/IUdwbogvM6wbigMSwFVE4=;
 b=DnVWsF+KMjmDtxvZZYMOluM+yXq+9ObwPaw+4IC1eIUj8ehKytt17DrhYRzLJiXMzdySAKxn+E7JlXkslFHoIBqxYGS6fcpQ8LBiOHcM1/6dyevKSidk/zebL8RWCtMJ6c/cPXImtXv4WRFhuirwE+eCLy66nyQdiF5dDb4Eguc=
Received: from BN6PR22MB0258.namprd22.prod.outlook.com (10.173.200.23) by
 BN6PR22MB0836.namprd22.prod.outlook.com (10.171.180.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Fri, 20 Dec 2019 20:04:11 +0000
Received: from BN6PR22MB0258.namprd22.prod.outlook.com
 ([fe80::2cf3:adf8:561:7f2c]) by BN6PR22MB0258.namprd22.prod.outlook.com
 ([fe80::2cf3:adf8:561:7f2c%9]) with mapi id 15.20.2559.016; Fri, 20 Dec 2019
 20:04:11 +0000
From:   Casey Meijer <cmeijer@strongestfamilies.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [GIT BUG] show-ref doesn't work with Symbolic Refs other than HEAD
Thread-Topic: [GIT BUG] show-ref doesn't work with Symbolic Refs other than
 HEAD
Thread-Index: AQHVt2/AQ3JWu6T8oUCxgJEDa1BTGafDL1sA
Date:   Fri, 20 Dec 2019 20:04:10 +0000
Message-ID: <BF8A29F0-0572-49EA-9E3F-AC6964C6D8B0@strongestfamilies.com>
References: <46A996A1-4B9D-4613-A49B-A95E98119DFA@strongestfamilies.com>
In-Reply-To: <46A996A1-4B9D-4613-A49B-A95E98119DFA@strongestfamilies.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=cmeijer@strongestfamilies.com; 
x-originating-ip: [173.252.62.98]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b315261-ce4b-4754-fcaa-08d78587c787
x-ms-traffictypediagnostic: BN6PR22MB0836:
x-microsoft-antispam-prvs: <BN6PR22MB0836593DFCFDC2B6B10C1D8DAB2D0@BN6PR22MB0836.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(346002)(39840400004)(136003)(366004)(189003)(199004)(5660300002)(66476007)(33656002)(26005)(2906002)(36756003)(558084003)(81166006)(186003)(81156014)(86362001)(66446008)(8936002)(8676002)(508600001)(6506007)(2616005)(316002)(6486002)(66556008)(76116006)(6916009)(6512007)(66946007)(64756008)(91956017)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR22MB0836;H:BN6PR22MB0258.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: strongestfamilies.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LHupL9OLdOQmtfeQl80XQiaWYRpVSHpVHIdd/O8OMj5EXLggk723VUdJ3bTR3jabvetMW6BjUybOLgnMO6hKlVLi7ge38qzWlOu3Ya/iBcztGIcMtO642chyYe4T01gmhFtd8+UF1a7di6eaT60XIeA1OpDAJyMQ6Prey509B3fuArtV+eyNs2ifwnlgQExMQ7uZMrS+yl/ybmyEyhv7KrJdG12wuFJbPpAkNYAq4E5/RnW4RXYh0ELEEI1Mf4lGCLW6x8i/ztj73MgGef80rcUX6VHOnLm5RWAiOYNc7doSrylZcpdNaVmlT/c45t72cA0wyvC/wHm24jT9eUKktIXcdxUT3N8Jnc7DQk+upnOXYaARCKK7B7nOi0Wowln94oTkr24ZZasiamqK6YuJgPXclwChRqxIFCnwZ7YPylQLI3TYlUnFtroNdXKZ5mNy
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BABFC975D1BC174A9E8E29F6B217628E@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: strongestfamilies.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b315261-ce4b-4754-fcaa-08d78587c787
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 20:04:10.9242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 88c0a794-6b77-42fa-a51d-2e160c167dfa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sStH7PPDUe9gp5Z+rBn9PltInYVprftbJ6GbHMQ0yKDdoA6oMSVPTdoS0qq4Mf0h1Uiyb6QQxMY5x2UxGlLTTMEo/H1SObwtGeBNF9SXj0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR22MB0836
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

YGdpdCB2ZXJzaW9uIDIuMjEuMGANCsKgDQpFeGFtcGxlDQotLS0tLS0tLS0tLS0NCsKgDQpgZ2l0
IHN5bWJvbGljLXJlZiBERVYgcmVmcy9oZWFkcy9kZXZgDQpgZ2l0IHN5bWJvbGljLXJlZiBERVZg
DQpgPj4gcmVmcy9oZWFkcy9kZXYNCmBnaXQgc2hvdy1yZWYgREVWYA0KYD4+IFtOTyBPVVRQVVRd
YA0KwqANCkV4cGVjdGVkIG91dHB1dA0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQrCoA0KYEZVTExf
Q09NTUlUX0hBU0ggcmVmcy9oZWFkcy9kZXZgDQrCoA0KwqANCkJlc3QsDQrCoA0KQ2FzZXkgTWVp
amVyDQoNCg==
