Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DBDC32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 20:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiHWU3U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 16:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiHWU3D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 16:29:03 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-oln040092064103.outbound.protection.outlook.com [40.92.64.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998ED7A742
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 13:03:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQrpBKIPFNHqKyvRkx1Ok26Mc/bKEHm7s2XEUK2s+AEomaB4oViQSW9K8fvXivim+8S+I538KYa6wQeVph4mcrEYnV+MWFDcwHHyFT5O4d80u2Qz857AI4tN8GplCLIO/DDZgW+kVOAxd5XwULb+IGTBi4xzVJ8zPMHmkjrCyk8ieVxtm+YYW3tTuRyoHbO417yhOr+r9b8KGNj/BSu4kJzyUJfPi1HufsEpsqvCu7Hrqnla0Eu5/uUKwOLnxyjFc3Mguz0P4d26KjW/9phpWf5O1Gf0EVFkXovudI86pIWNH+qq0wNXHJv7uCVRweqsj+Z3SXDfSUtAdnZntybBWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m65g/C3CAx8GC2E+CDUjvKhhnoroW+HrY2ztE8R7RsY=;
 b=n80ikL+qzqkOWOWkfYtLnjnrO4eXQya+1sNZTO3+cWFkxrwUH/nZtuQpeZI52I3BB6bCdJgVz/Fewm+/jj78/6uLcs3kI8rp0UZ6VZyRD9Y6nRWPW6LCTlrDswFyhc4WOLSVX4ohNFtYrJ5h5VQpNwymJGXFiVsJYnTglNzCq5h+08T7A00ihUzQ8TZ0yKHd+eo4cg6qXVCWs20qDVjUCVs3SiMrjogKi6hkR/8lhENT0MR+nobIyct6mGGoIMbaeV/qTgLG0A43UlGDe55Er4JBBrGwlrMqHK+0Ky+PIa1KojEqIPvW+PMLcIBgRsODv1QukxzXBPYNUpYMjX1EaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m65g/C3CAx8GC2E+CDUjvKhhnoroW+HrY2ztE8R7RsY=;
 b=nKHYJ1dyocgEYns5cNgTRe2Esp/WfWF/85YgSlyD5ev1GNl2PY2LmC8+C5QCiXdKIxiVfK9otNRs8JEr5Lw6ev56wYLOJvuHbUWxH00mkJzNkGRAZKaUjoxKih4FqU2mzpGc2AL6Zm03Z1FIFiIHXSLpDyaUBAa0iy8FAVmBmMKtz4RE1R8iJRzLecKANVeqHNVp1DmakDVdrt2QgZSHIVVTDHeNl993u5CCXljnW9TWCwdfKQyoDT6mho8C3dBqJ3uAQDaUKcgyMUvvbZV/nfSIVEouWjafmYxQTO1XUdPevt3ziea3EwqZLZbrlLuQJ6oXTJBfCmZdPsD5wDRlHg==
Received: from DU0P195MB1649.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3a6::14)
 by GVXP195MB1805.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Tue, 23 Aug
 2022 20:03:42 +0000
Received: from DU0P195MB1649.EURP195.PROD.OUTLOOK.COM
 ([fe80::1ef:e678:90c4:4c99]) by DU0P195MB1649.EURP195.PROD.OUTLOOK.COM
 ([fe80::1ef:e678:90c4:4c99%9]) with mapi id 15.20.5546.024; Tue, 23 Aug 2022
 20:03:42 +0000
From:   Mohamed Akram <mohd.akram@outlook.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git diff prints long usage help if not run in git repo
Thread-Topic: git diff prints long usage help if not run in git repo
Thread-Index: AQHYtlQfqVVTOIN0YESrilTsNXp0y627UmNigAGX1oA=
Date:   Tue, 23 Aug 2022 20:03:42 +0000
Message-ID: <A01F00AA-B96E-40EF-9017-9005A8AC1E14@outlook.com>
References: <A2326287-9808-4479-95C5-E54979E21F95@outlook.com>
 <xmqq5yikcbd1.fsf@gitster.g>
In-Reply-To: <xmqq5yikcbd1.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [3DQBvDO5ZY8s+4RxFATPCoyAIiRg5iwPaKNpnyDVnNzlb69iE/PR1x2ghQ+CY82z]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66febf4d-1ac8-4589-ce0d-08da85429420
x-ms-traffictypediagnostic: GVXP195MB1805:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ubD35TWHV+4RtR9RM+lrdb1qxGKvcb04cgnGLDn+fzoIieGQqL6fVAZ4b9ctUXSyhvATZZ6NR8HkWlHie/ZNQowk6x9q31TG1uISvgl1UFqQTSThUnt7nhI0dsJ8DiET1t5kFQn+7r+9Z+wbTBwZHkc5JbRnwUooQZg4EhqlSKb2Ty+CA48O4pb+n6BQW4WqZb6ZK3qB5ve5fCWCUBRJmvOLgKep1QcBI3CcHSt72Z24/lt5sX7zhirJMuz5kOWoPG/jU8BW9cEscUval9V6M4UQQ1eC1oLy1EL1/vZdnd2wj6d/Ka2ZuSOgufgqupLSyOD8O+HxqGhHM6GtlX60Oj0wizhv7x83vlmGqgj7VSiXwDSJ2PyNRJbi0H9v5bJ16LWMv99juP0VGd4FsxIjc43B/kKbK6P5tqRAwR2/ZDrLK6hylbScPFglDOKONoUlIs4PUjPxwskXIu9JBSRFkqu5zlTogQ0fqoB6Hm3L1gPTcm6q9YP4pNOXp7dBBEEDETJIEAyUfAmRENi6KZBUGyz5vDE3PXWhxqMnu0SVQct46Wp4bpGV1y0OUevwxTEueDJqgLQqY1CJ8liuc7o50BNiz723VRD/zv5lpZc5z5pPFDjv5wp5rjFh83HWq/dzqkxBEIIU0e4EX99/1DrZkUmjdSo8pVCSvvRc7NXv1tPjdmdTGs2P7elmtFJ7y3CX
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnU4ajZoT0ZoUmZMZk5yZXNWTkMvaFlTY3E4cnc4WENxN0FERWxwODQ5Q0VT?=
 =?utf-8?B?UlF5emtFdWpxN2RlMzE2dG1aRFp3UnJ0aTB0T1dQQWZwWDZtcnF2MGtuNHZL?=
 =?utf-8?B?WG5jalhiT055dTdHbGZmRHpCeTNjZFVoVnBVcWhRZ24rZFZORS9LNklTYkFz?=
 =?utf-8?B?Vnc5S0ZwVFBvRXZvc3ZpckVQZFA0T1djVXBONlV0dE8zQjBWcmkrN3ZzNVZt?=
 =?utf-8?B?K0xsMVM1b0k2eUZFTkJQM005ZDc4ZUxtTG5nclhGTGFkVFRuZE9xVThGUHhK?=
 =?utf-8?B?VVlyYmVvUGV0dUZiRDZCVkRBRDRRSmMwSmxudVppclpRUkxvOVI0cGtKcmF6?=
 =?utf-8?B?UmhkVkZuQ2hjNHZSTDhGWEdLTFBQMHJ6dXhmRFJoRGd5eXNzWkFtWnMvYzIr?=
 =?utf-8?B?UytJb2V5aGN3TmdXQ2dZdFNrNE1tUjBEc1g4aDd1ZVZac2lIdEpjbzJOZHB1?=
 =?utf-8?B?RlJMSzZwdHJMczBYdFNMKzdiYUlBSkJHK05KOUVvRlQyY0JyODI1ZEkwZE9S?=
 =?utf-8?B?MktZRmVCQWVOZkw0aUhYSVIranJ0bkhZSzZhdHpnYllBTm5oUVVTSkxwUUs4?=
 =?utf-8?B?aFNNMlRYM3BaMDVLNmJmRndYVEFXZzhZNGpScFZTWUN2THlVZ1pTcFBTNGpr?=
 =?utf-8?B?S2dnZzBFTXVsV2tabWxtVzE1TUh5V2VCQnhkcWEySG1PL01PZExGb0RRNHEz?=
 =?utf-8?B?aFl2R0VLT21BM0xmWndVanZ5aFQwL3pGcTVnT0ZmZ2VVYThkTlNDU1dqQTZm?=
 =?utf-8?B?Um9DckhvckoydUc1aW9ucEZyNEF0ZTFHZTMxZEF4b0l6ZFZYQWEwaHEwVUxW?=
 =?utf-8?B?eUlJZTVyYXhGK0tnSHl2bkZBRWdieThQQjhJbWNRTUpNYmhPYmVmN1NvZDdj?=
 =?utf-8?B?ZmdaczBweDVUbnVXakNzMXhrcFNMOTFRTmEzVjRFdHh3THFpenJRVkp6UlBh?=
 =?utf-8?B?TmhDR2xrNzlxemtLcnJMZnlrQU9MVjE1VU9vNVdyNGJTN1JvN2NIWUhQNnNx?=
 =?utf-8?B?M3A4clhZK0orMkFpcG9ZUUUxd3VIL3A2dEJrK0VEQmlGZnpReTkrT1dSVGhz?=
 =?utf-8?B?a01BQzdvMkRoYTZKTm4wWUM4QUlaenN6WVZMSk41Y1FWT1dJa3NJcDFlcmdz?=
 =?utf-8?B?aGl3ZWtVOVBlOGdxdUVieDg2eURYTmQ0WUYycWhUeWl5cDNWaHRoSHNBZ016?=
 =?utf-8?B?Rk1wOGd6NTRwZnkyOXBEVDl1RHFCN2hEYmd5ZmhrQXdycS9EUmJ6eDdmWHRh?=
 =?utf-8?B?UnlFMWIxd0trWHBTQ2MyemErV05zd0RZZGJKZW5YU29qb2oyVzhSc1ZvT3VM?=
 =?utf-8?B?NnhGZHdBZVdQNnNRc2RpYXFQV3U1N0dRRmo1Y3FyTVA0dFljdEsxdmhMaE45?=
 =?utf-8?B?U0podk1vTmdlYjUvaC9pOTJtYlJ5YWxCWThXTW1qc3dTOTIyUlh1V3ZrMk9n?=
 =?utf-8?B?SnRIcnc0QjJoL0tWN3ZnNUlYUTYrSXhYZ3RuRnAwc3g1amQ2cDgvSjlqUi9P?=
 =?utf-8?B?QTc5YnJvODE5WitIeDdZTFFjZU5xb0hOVVR5bnpVKzJ6U3J5QVd6cWJvRTZB?=
 =?utf-8?B?ODFHWXNua25POVBiZW1NazZwVkVnR3NsYzR5cXppWGY3T25HRHNXUFE1TnlC?=
 =?utf-8?B?VDZrUW1sL3NHZ1VBRWl2MFI5RVJTdUc4cTVWbFlodUJKL1ZqQThxSVMxTmpC?=
 =?utf-8?B?QjBqUDk1Z0hPSVdmYXNWR1drKzB4Y2VTVkw1bm1RdVZyN0VYTVp2MEJ1QXd4?=
 =?utf-8?B?TmlNdGRoTHMrQ1M2VDVXekVaZFVxbUFIY2gvMmVvenYvVjdYckpDQksrdzlr?=
 =?utf-8?B?cnpoMEhWRXBXT0xrN1E4Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EB1D7646243864AA3E522252BCBF366@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0P195MB1649.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 66febf4d-1ac8-4589-ce0d-08da85429420
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 20:03:42.5391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP195MB1805
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SSBoYXZlbuKAmXQgdHJpZWQgaXQgYnV0IHRoYXQgcGF0Y2ggc2VlbXMgdG8gbWFrZSBzZW5zZSB0
byBtZSwgYWx0aG91Z2ggSSBmb3VuZA0KYW5vdGhlciByZWxhdGVkIGlzc3VlIHNvIGl0IG1pZ2h0
IG5lZWQgdHdlYWtpbmcuIFdoZW4gcnVubmluZyBgZ2l0IGRpZmZgIGluIGENCnJlcG8gb3duZWQg
YnkgYW5vdGhlciB1c2VyLCB0aGUgd2FybmluZyBtZXNzYWdlIHNheXMgdGhhdCB0aGlzIGlzIG5v
dCBhIGdpdA0KcmVwb3NpdG9yeSwgaW5zdGVhZCBvZiB0aGUgd2FybmluZyBzaG93biBieSBvdGhl
ciBnaXQgY29tbWFuZHMgYWJvdXQNCiJkdWJpb3VzIG93bmVyc2hpcCIuIFRvIHJlcHJvZHVjZToN
Cg0Kc3VkbyBta2RpciByZXBvDQpjZCByZXBvDQpzdWRvIGdpdCBpbml0DQpnaXQgZGlmZg0KDQo=
