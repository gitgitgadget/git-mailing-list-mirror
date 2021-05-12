Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E355C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3DC261927
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhELAIG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 20:08:06 -0400
Received: from mail-bn8nam11olkn2075.outbound.protection.outlook.com ([40.92.20.75]:29793
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229637AbhELAIF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 20:08:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkCh7LhZNGit0qUuo3/s6LYdwclRDkH62mbTh6+Lx+zNff7LUyWJrPU+SordxoHKRIuVxKMvblrhsD3HaMb76o0EEFh/ZWJeXa1fZIw6ckeY6E02iLNI7X6pNlle3PV1+P1FtU+I0YEkDmwZ4x3El4/Ss8HJ4EGZ1R5y/Vc3Pc2vkIMgwPS304He6uKRHTB/m7ORKHJK8Rbip1EBYQF/q/UOwGnhWAGD1yX5TaZm+94Z8sNGWiJICmqPCiQe+Ecy4H57E/NOa8qOCOJMFaQDW/XigiyHqBhGsyhd2HDGeblfqQVi5rTK838ZINP73QVs6COYvf05UN1S2G6x0DoDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdijdczMmN6FYYPlNkCoRsE2KVlcogH/m4q3DLsaRfo=;
 b=GRt0CSoNqKscZWsaB85bdBcNMTqSICkUTE7aNx0bdiZFK1zWQu9pxNbv1n/PtxDdaZKqPqa5RV68dq/Yd3ozrywnPL2hXIBQjw6+0WqrD4K3p539ajJAoGQwv14T7dHyAQfE+x3XsUOyuzwuUmt/dux9hYFt5Qzn5yJyPka/2cUAvfU+jviVxVSlOPOOy0BdOUkO0P72WXeNQwhAVNm630x7L8hhoi+FZtAMYcQDk9AfwTsIQK3y1HzEta38kwTLVQxGYlsiAZfSG+lcVawkPXJOQXaHJDM7Ja6/2o9WtsLj/HXeZcT7TdJmOuotHzrcS6HX9zub8kyVPF3a0DDp4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdijdczMmN6FYYPlNkCoRsE2KVlcogH/m4q3DLsaRfo=;
 b=K1jgGHYqaYEH+zMpTIumN/5ydnK00bVx2SyVT9I0DndgLNOdUhDiazXw9PsRlz7WvymNum5z7oVU8H6QhPn/b9SOBx6GBE7beuR63JRahmNnvRFMDLLYWUshi52DjSAaWP+GLXfsBXCULdRx7G5dcZhEKB78k+L4kMf8wHIoS+2atqPHRniV19B/EKofEKHUxj7p6inWzch0/I4o8Vg9ZKFWs+N2ikYHqLTn5rAupCpd/xrO5HPBU0F1/FqNoiI8rk9DAoVABt+4FPBaP4pcwlezS8cckf/LF0BRFIhonqCJil8CRPhdZNw9JHbN3+jvTsM4vWqVdmjjbt/H43vRUg==
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4b::52) by
 BN8NAM11HT189.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4b::161)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 00:06:57 +0000
Received: from MN2PR07MB5952.namprd07.prod.outlook.com
 (2a01:111:e400:fc4b::4f) by BN8NAM11FT021.mail.protection.outlook.com
 (2a01:111:e400:fc4b::370) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend
 Transport; Wed, 12 May 2021 00:06:57 +0000
Received: from MN2PR07MB5952.namprd07.prod.outlook.com
 ([fe80::8d50:8237:7e5d:f59]) by MN2PR07MB5952.namprd07.prod.outlook.com
 ([fe80::8d50:8237:7e5d:f59%5]) with mapi id 15.20.4108.032; Wed, 12 May 2021
 00:06:57 +0000
From:   Andrew Ottaviano <andrew_o1995@live.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Rebase Question
Thread-Topic: Rebase Question
Thread-Index: AQHXRsK2Rjz2QPzk+ES0lDupdBU8RQ==
Date:   Wed, 12 May 2021 00:06:57 +0000
Message-ID: <MN2PR07MB59526F40B255183931649AD19C529@MN2PR07MB5952.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:C666795F6008AB94D496B75E12F3339AF4C48C3AC48CBE508A652929A196BDA8;UpperCasedChecksum:103843B2BAF1635D2AE5DAD45A3134F47F2915BEBE373D17A165D3AECF191AEE;SizeAsReceived:6573;Count:41
x-tmn:  [dgU/C0I4R2E3uiF8pMI5WjVlY5QMnF7v]
x-ms-publictraffictype: Email
x-incomingheadercount: 41
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 9c313ac8-1ec5-4ecd-8326-08d914d9db87
x-ms-traffictypediagnostic: BN8NAM11HT189:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TtdheIso048g9UY5hFpeguNCBmd/fBfo62vE6+UmfAWSqpthvCe1OAnpL0iD2QGicyZ1f4wn4OlaqE0DCJBEVTmk18zjh8r0MifMVdCaxoSaDeNu844DCUioQnsG3967blpS610SjafgZu/Q6tAEBovYeTL9EhAnHJc+rHZd9eFt4ikJ51NbH6EFeu/skrfFzU0rLJdVwhSBVNqNyBf8Lo3escKfkAnCqiH1WJoMON7pkTSrJT9oixh/87uGU1jSEMQX4dxke2XVNmJ7N10ZsTrpqcFe/zdigYRRMGqeg1/C45N589gIyd8W6hktlCzdmbMdK5ZqrVdG7bOTSMFaqRg1gtXlTrOnwpLPXifsk/47TfwNXpghuSLk+VCTWOe2h/lDxnh6h2zMHxP3BEneVw==
x-ms-exchange-antispam-messagedata: 9gO+EaQ1AJYEN7a355wfACXm9Rn21QDh34z7t5TaiD5U0EGFnvksVy9VZhN3H5Bcqt7AanslE3FTwT7L9fQ7ldm2kLjOC9EDdirMcbEWcXY5IuFGPss2Wtpj+Zji0MP0nv03yViIbg2g6mes3XQQOQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c313ac8-1ec5-4ecd-8326-08d914d9db87
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 00:06:57.2706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM11HT189
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGVsbG8gYWxsIcKgCsKgCknigJl2ZSB1c2VkIGdpdCBmb3IgYSBmZXcgeWVhcnMgbm93IGFuZCBJ
CnRoaW5rIGl0IGlzIGFuIGFtYXppbmcgdG9vbCEgVGhhbmsgeW91IGZvciB5b3VyIGhhcmQgd29y
ayBpbgpkZXZlbG9waW5nL21haW50YWluaW5nIGl0ISBJIHJlYWxseSBhcHByZWNpYXRlIGl0IcKg
CsKgCkkgaGF2ZSBhIHF1ZXN0aW9uLiBMZXTigJlzIHNheSB0aGF0IG15CmNvbGxlYWd1ZSBhbmQg
SSBicmFuY2ggb2ZmIG9mIG1hc3RlciBhbmQgYXJlIHdvcmtpbmcuIExldOKAmXMgc2F5IEnigJlt
IDUgY29tbWl0cwphaGVhZCBvZiBtYXN0ZXIgYW5kIG15IGNvbGxlYWd1ZSBtZXJnZXMgaW4gYWhl
YWQgb2YgbWUuIFRoZSBsb2dpY2FsIHRoaW5nIGluIG15Cm1pbmQgaXMgdG8gcmViYXNlIG9mZiBv
ZiBtYXN0ZXIuIFRoZSBkaWZmaWN1bHR5IHdpdGggdGhpcyBpcyB0aGF0IGlmIEkgaGF2ZQptZXJn
ZSBjb25mbGljdHMgdGhhdCBzaG93IHVwIG9uIG15IGZpcnN0IGNvbW1pdCwgSSBoYXZlIHRvIHJl
c29sdmUgdGhhdCBzdHVwaWQKdGhpbmcgZm9yIGV2ZXJ5IHN1YnNlcXVlbnQgY29tbWl0LiBJIGNv
dWxkIHNxdWFzaCwgYnV0IHRoZW4gSSBsb29zZSBicmFuY2gKaGlzdG9yeSwgc28gSSBkb27igJl0
IHJlYWxseSB3YW50IHRvIGRvIHRoYXQuIEkgY291bGQgcmViYXNlIGluIGludGVyYWN0aXZlIG1v
ZGUsCmJ1dCBpZiBJIHJlY2FsbCwgSSBzdGlsbCBuZWVkIHRvIHJlc29sdmUgYWxsIHRoZSBjb25m
bGljdHMgb24gZXZlcnkgY29tbWl0CmJlZm9yZSBpdCBzcXVhc2hlcy7CoArCoApUaGUgc29sdXRp
b24gdGhhdCBJIHRob3VnaHQgb2YgaXMgaW5zdGVhZApvZiByZXNvbHZpbmcgY29uZmxpY3RzIGZy
b20gdGhlIGJvdHRvbSB1cCAoc3RhcnRpbmcgd2l0aCBlYXJsaWVzdCBoaXN0b3J5KSwKcmVzb2x2
aW5nIGZyb20gdGhlIHRvcCBkb3duIChsYXRlc3QgdG8gZWFybGllc3QpIGFuZCByZXNvbHZpbmcg
dGhlIGNvbmZsaWN0IGluCnRoZSBjb21taXQgaXQgb2NjdXJyZWQuIElmIHRoYXQgZG9lc27igJl0
IHdvcmsgKG9yIEkgZ3Vlc3MgaXQgbWlnaHQgYmUgdGhlIHNhbWUKYXMgYSBtZXJnZSBvZiBtYXN0
ZXIgaW50byBteSBicmFuY2gpLCB0aGVuIGNvdWxkbuKAmXQgZ2l0IGF0IGxlYXN0IHN0b3JlIHRo
ZQpjb25mbGljdCByZXNvbHV0aW9uP8KgCsKgCk1heWJlIEnigJltIHNpbGx5IGZvciBhc2tpbmcg
dGhpcyBxdWVzdGlvbiwKSSBqdXN0IHJlYWxseSBsaWtlIHJlYmFzZSBiZWNhdXNlIGl0IGlzIHNv
IGNsZWFuIGFuZCB0aGlzIGlzIG15IG9uZSBmcnVzdHJhdGlvbgp3aXRoIHRoaXMgbWV0aG9kLsKg
CgoKVGhhbmtzIGZvciBodW1vcmluZyBtZSDwn5iKwqAKQW5kcmV3IE90dGF2aWFub8KgCg==
