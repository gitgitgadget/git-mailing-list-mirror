Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D9DC433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 06:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357982AbiD0GIZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 02:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350057AbiD0GIX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 02:08:23 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60117.outbound.protection.outlook.com [40.107.6.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAD6633A
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 23:05:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbBBeli973ycNqyQMg7mjebPgKOODL93fBAdiAKoNvp0P9trY9ong2QeX8JLgdj1pLSWsQB/cp8XbKkyis7yVqc0OvPzUfMSBdYqnVAKSbrUW3ixjcF4QjQCugaUSeQODWGJBKCNCKUdmjvI3H4y2lBBB2K8xTQgD7GNIWA1GK+3xyTWdLwGUXhI6YC0Z6eJ9YBd6imPX8r4gJz2lzDfTy+01dsFLytwoaDQSXhdT4SmxuIxn6MS0RTJitKAfDFRzIGL0zKVc5HXNC6cANnDpEVp4Mi3TL+A/Zv7YCMALg2kOVvNSspxOEclcOZSiUvC5ixyVValgHJncCCGvn2lgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1ZXyIJ/hM1fhxsKqcD6vZChWgSBFlcI34FSPoLUa8o=;
 b=fhUqX1BSe5RSk8ixxSA/lVpuz9bBTJHgCjoDpQH9MVEEUPj07N5NAkaeBI9mYR9xGCpq4vwdhZm9DNYvbp5N9o2RDQD8KYU/JQvIDqiXaqrletthkyecjeHr1O6uMhLd4SjaXRdVoz/WtBeh1VHZbROERxz/r2zZB0tugZNCICjbRTJDcZi+0G0Lq/IEvjAoGdUEvJAiQ8YbW51DcJynOPDdC2Idte98V6vAJkxOviCuetYKaZ74c+9OZEXhb1wuFFQTawZm6PDlPn8lM+yMdH2kjnONV/aTvhYvVsKBcUUV1nanvCRDCxpGQICfT9msHOm9UBmg81VQIh7dW50TRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gerhardt.de; dmarc=pass action=none header.from=gerhardt.de;
 dkim=pass header.d=gerhardt.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=carlgerhardt.onmicrosoft.com; s=selector2-carlgerhardt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1ZXyIJ/hM1fhxsKqcD6vZChWgSBFlcI34FSPoLUa8o=;
 b=cUPP0iKqXaDL32haddpJ7j45EGgKW9AYoX6n3IITtF8bkleYlxjVly6pRSXPUX/guAeVGyheLGqhfTejGbHTFc/XJY/soKU9dbM7KBSTJvb0LuMWMbKKNT25zWaXzhkS349RUMGoHZx24LqNuJAIwLWvkUzQBHiJc3+wLLMCPoA=
Received: from VI1PR05MB6495.eurprd05.prod.outlook.com (2603:10a6:803:f2::18)
 by HE1PR0501MB2444.eurprd05.prod.outlook.com (2603:10a6:3:6e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 27 Apr
 2022 06:05:10 +0000
Received: from VI1PR05MB6495.eurprd05.prod.outlook.com
 ([fe80::7591:d7a8:f06d:c1d6]) by VI1PR05MB6495.eurprd05.prod.outlook.com
 ([fe80::7591:d7a8:f06d:c1d6%3]) with mapi id 15.20.5206.013; Wed, 27 Apr 2022
 06:05:09 +0000
From:   "Elektronik (C.Gerhardt GmbH & Co. KG)" <elektronik@gerhardt.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?Q2FybG8gTWFyY2VsbyBBcmVuYXMgQmVsw7Nu?= 
        <carenas@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "CRM (C.Gerhardt GmbH & Co. KG)" <crm@gerhardt.de>
Subject: AW: Error after update from 2.31.1 -> 2.36: Unable to negotiate with
 IP port X: no matching host key type found.
Thread-Topic: Error after update from 2.31.1 -> 2.36: Unable to negotiate with
 IP port X: no matching host key type found.
Thread-Index: AdhZZNr5llfjS8asSEWIrpXAwpcyhwAF/D4AAA3MeAAAEhAMgA==
Date:   Wed, 27 Apr 2022 06:05:09 +0000
Message-ID: <VI1PR05MB6495B06E933B4D793B0EFD5FCCFA9@VI1PR05MB6495.eurprd05.prod.outlook.com>
References: <VI1PR05MB6495349A4C42AA568A665D7BCCFB9@VI1PR05MB6495.eurprd05.prod.outlook.com>
 <20220426144914.nyaohjqqqlotxnnm@carlos-mbp.lan>
 <YmhjBBlJ5mcI31uN@camp.crustytoothpaste.net>
In-Reply-To: <YmhjBBlJ5mcI31uN@camp.crustytoothpaste.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gerhardt.de;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7cddc725-02b9-44c9-b874-08da2813e298
x-ms-traffictypediagnostic: HE1PR0501MB2444:EE_
x-microsoft-antispam-prvs: <HE1PR0501MB2444BA9787C4B0CC6B6139CFCCFA9@HE1PR0501MB2444.eurprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6yRn+iW6E3TzPphnWniBqi0mObSfPse+77dcUyFpArALD61po99DLmblJTEG9A4IS726rD56+Byw7vjk8no9fsaaIpyAaDIyz00VcvupJF5vEkJcroiUJpr18UYkiJJmju06IPngWsFtA+TwQWXXCnKrd5lywtrAK6RSrueOvMu8bf8BN+cRMxhUwITp6REgOjtADn0Cop+p2/xFGFmoqlfum+7qHhLZAIE69qWmlL+lANRkdM7Taj5X5obQVyRYUwqkxBxqxqbQileVJmmAvm3qZaou/tMZrxkjaqfoRB6cc9PsXxtVbLjHC+iLEbavGVC8NMVtMz5sJuTHvA0nhBkS9aJIfCX5/4+cpi3QcJBGgICIfNGRbFQxcLjY1C8URcobhTqS5DC/h23rNJRS0r1aDri1+gFMZ+6QXRiTC9ylSlLrI5CdAg0ijIGBW0et1ZN7ZFc7g/8/awt1zMU5SMVTWPdbJIFnXZT99Ht4e5x+QSmJ8S2UUl3j+CkIaKrgDcZpEgD4L7U0wRqn3u9fbnBibtVEOeZT3yyIiUVF9XzuzwGQuExPacICHy4sPz7fSsrHwvtEA+z2bQQvJ1Sh59Ot/eOmLrSW8WMg4f8Zdz05mTkvIXz79Z9hZ7X0JiSDEp8LtDZics8ZMuCDT0+wbvXUzFD8ZUIOzRtzTzzblGjHKZW0K7SPcJqivLkUaSERyX7rOIZFSqfzXxTJzbcZtTOkXrPLDnhCI3RRjtsHwQaTqGb5CUWmt1sXv9ooxAE8O6HCwXIg9f3aRQOJ1BK0vdkv7iAdw7IyNdygLuc8tbg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB6495.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(376002)(396003)(136003)(39830400003)(366004)(86362001)(66574015)(8676002)(52536014)(15650500001)(508600001)(5660300002)(2906002)(8936002)(38070700005)(316002)(76116006)(66946007)(66446008)(66556008)(66476007)(54906003)(110136005)(33656002)(38100700002)(55016003)(15974865002)(122000001)(64756008)(83380400001)(4326008)(53546011)(107886003)(186003)(26005)(7696005)(71200400001)(6506007)(966005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXpLaGppeDEva1c1R2srYWdZN3JiSWJ5ZTdNTytwRUJnSFRWNVdvUXhEVlhZ?=
 =?utf-8?B?VkhRMHl4YnVoUVNML2l2RC9ta3ovMWxCZFB2aXNsM21NZVpBRS9CUHg2SVBC?=
 =?utf-8?B?eVFLYVFLcDlQQTNxSmhydyszYnlnTjdXM3VFdUMrWW5pRTh5N29PRTE5eUVj?=
 =?utf-8?B?K24wM0hpaUY4UHdNU1JvbS9LSklBbDRMTENsa1dDZ1ZpNnZOS0REeVY2aXBX?=
 =?utf-8?B?VHpEQkNXSkt1WWl0eXRmMVV5MlRqcCtpaVUxbWxNUXoyZXNqbXRydUdrUFJh?=
 =?utf-8?B?cG5yd0lIeGpuZVBFaHNJMWgzb2pScXpiTW5mZ0swT1NtbzVjMHdjTFYrNHJM?=
 =?utf-8?B?T1VRejNPL0JyUGVQdzk4MTN2cUZVa3p2T2NXYXROcW9uczQ1ckxwQ0htNnZi?=
 =?utf-8?B?SGhWYWYzTWxpNmVYQkJxU0FMTFN6aklHcDNZODhnU1JKVU5Ya2I2WnRGVGUv?=
 =?utf-8?B?NGZ6TWwrWmlkdHV6dGM0TXFqTXFoajQ4dFlZYVhFU3h2NUxza3E0QkU4UklE?=
 =?utf-8?B?amhjQ2ZNeFJtMDlRUHZqbkhBcTUwa0NCQ1hLMUFHd2NCNmtLTWlLMUFsZkdx?=
 =?utf-8?B?MVBGUTJhS1F4QUdPUkdraXNGMFhTYzdudnc3bHgwc3JPcFhFa1B0bkRVTFRS?=
 =?utf-8?B?VnViZkxBSm54cTV6WHk1MnVmblVCWEZ5MjFncWUxcWFZbXlEMkg5UEVHdS9Y?=
 =?utf-8?B?dktORkFOcmswNXVPSS9NeldYWjRuM3BQaHVqdXI0ZHlYa1UyWk1qaEFNOTRo?=
 =?utf-8?B?V2lOYnVUY013U2g4eDJOV2F2NHdTV3M2MUs5UU5PMFBnR1Arb3ZNNmVjaEZx?=
 =?utf-8?B?ekl4clVPcnhWLy9IaTdZZm9qTjB3K05YdXZTVUhpWXMwTnpHc3V5SjJnVUtk?=
 =?utf-8?B?T29ENUFjTXhJUEYvTDRMVTM3TEp2Z0VkUkxtQmNLTm53RThBOFZ1emc0TC9C?=
 =?utf-8?B?TkhJdldUSCt6dWlFaEJKTURkc1FycytGTTFQclQ1NkpLdGtVakxoMi9XZ1Fr?=
 =?utf-8?B?cHFSMEJuUzA0bmxyL3ovS20wOTlOREpGQ1FSUTZNUnlaUHNtcTU0bDh4QWlG?=
 =?utf-8?B?WktJcVQ0RS9ZVis4RW4zSXROWWgySGhWNmVYQVp1S2hjYmx6TlRnT2hnSDhB?=
 =?utf-8?B?bWdkOVkzUXpGYXBpTmhjUGpYaGZPVXV5TlcvOVR1dlBtanlxS3Fpakt6eDho?=
 =?utf-8?B?RVl6TUdnMlR2SU50K0IvTjRsd1RNTHNWR3hneFNxdFV1bSt3SkNFbFljUTc2?=
 =?utf-8?B?VEZjaHBmTHdtSTJFUEpQZlFRUXlwOUF1UmtVdGxjS2phdG9xcmZINDN1cnky?=
 =?utf-8?B?Vm1tNVo3YVR4d3NiOGVlMXFvSnU3eW0raFkzbzhGWTUrTlovS1JiYUkvTUg5?=
 =?utf-8?B?bkluem5TeFpQQ0R5eTRXL2p6NWV3eEJ2b1NrdWFyOUtLWW1iUkpBekVmakNu?=
 =?utf-8?B?bXFBTTE0bjZJQjRURlZQOGQ1aVJVYUR4KzI3UjlVd054K2NPaTRvdzl6aGtv?=
 =?utf-8?B?LzZZcHFRWWJyZUJ5VFVob1puV0Uwa09DSVR1WG04WDlKTk9Zd1FHNDRLZWxR?=
 =?utf-8?B?UnZqQ25yMmN5UnE1MmpWMW9lcHZFTDhGNzV6WUgzNHpkSW9SbGlHQm9PN1lv?=
 =?utf-8?B?U1d3akZiS0VlVCtQMnJjdFc1cnBQeWd5bW9kNmY0bjNGRkFiQzVpSXlFZmI4?=
 =?utf-8?B?eWNnaTViK1cyVDd4RUZ5eEM5cDF5UlNpYXdENSszSlhXanE1YXp6OFl1WHRO?=
 =?utf-8?B?ODdSTHBCMUdWb25VMmcrdnI2ZkhNdmxFcGszcWczWXV3Wnc5TGxjWEVIM0sr?=
 =?utf-8?B?bEN6SDdLL0w2L2lxb1VtOXBOQ0VXMnNiZmF1aUVwUjJlZy9oeFZvL09DSlo1?=
 =?utf-8?B?NVovUnlDSTdweUFUbGFsNXBQUGdwTHZiTUJXNjBIVzVudnkxSmppSEhaZTR1?=
 =?utf-8?B?Nk9MY1ZuZnl0SEhpMEtST0VjQ0pmOUJSNVIwZEU2UHFhT2U4VUFRVVNvQlN0?=
 =?utf-8?B?c1kzVllCZHBRTnd6ZUlqd0QzWE9SVkJ3dVdVZDZBam1uNHhBUTBPbXpQTVhz?=
 =?utf-8?B?M3hkY29BUEhpNGFmNkVaWFRDcVpKTExvdDlLQjQ1NnFDRTNWTzBOT3duNjU2?=
 =?utf-8?B?ZnVzUkgraDJ2dCtBczU5MVB4QW5vbk9HQ1FCOGNmWi9uc0JGLys0T1BFQnlv?=
 =?utf-8?B?cUp1QWY3SHJySlorbWJET1ErM1dyc1lZaitVcCtNclNDUzJhUklCaUQrdXhL?=
 =?utf-8?B?UG40bGl1bC9YcmVQRkZKWlc0c3R0bnkvTmFhZDFxcnl6T2NDeVlJK0dqNmVQ?=
 =?utf-8?B?TGlKMWljbnloZTU1ejBjcklBcnk5d3FiZVFwRHZobG9ObGdBRDB4dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: gerhardt.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR05MB6495.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cddc725-02b9-44c9-b874-08da2813e298
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 06:05:09.7183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 29fe33a3-8fb6-4fcd-983a-533675a91271
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EfS3MoK55vGWOWPyFBiDpVS31FtPY93NlhkLA0BmbGilTr7SqlEflN/jvpBxcXr56BBip+CRfUoXg9Yrus0/iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0501MB2444
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzIGZvciB0aGUgcmVzcG9uc2VzIGFuZCBleHBsYW5hdGlvbnMuIEkgaGF2ZSB1bmRlcnN0
b29kIHRoYXQgdGhlIG9sZCBzc2gtcnNhIGlzIGRlcHJlY2F0ZWQgYW5kIHdpbGwgdXBkYXRlIHRv
IHRoZSBuZXcgY2VydGlmaWNhdGVzIGFuZCBjdXJyZW50IGdpdCByZWxlYXNlIGJ5IG5leHQgd2Vl
ay4gVW50aWwgdGhlbiB3ZSdsbCBrZWVwIHRoZSBvbGRlciAyLjMxIHZlcnNpb24gc28gdGhhdCBJ
IGNhbiB3b3JrIGZvciBub3cuIEFzIHRoZSBzZXJ2ZXIgaXMgbG9jYXRlZCBpbiBvdXIgbG9jYWwg
bmV0d29yayB0aGF0IGlzIG5vIGJpZyBzZWN1cml0eSBpc3N1ZS4NCg0KQmVzdCByZWdhcmRzLCAN
Cg0KaS5BLiBTdGVmYW4gTWF5cmhvZmVyIA0KQy4gR2VyaGFyZHQgR21iSCAmIENvLiBLRyANCkPD
pHNhcml1c3N0cmHDn2UgOTcgDQpELTUzNjM5IEvDtm5pZ3N3aW50ZXIgDQoNClRlbC46ICs0OSAy
MjIzIDI5OTkgNTEzIA0KRmF4OiArNDkgMjIyMyAyOTk5IDk5IA0KTWFpbDogZWxla3Ryb25pa0Bn
ZXJoYXJkdC5kZSANCldlYjogd3d3LmdlcmhhcmR0LmRlIA0KLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0gDQpQZXJzw7ZubGljaCBoYWZ0ZW5kZSBHZXNlbGxzY2hhZnRlcmluOiBEci4gTWFja2Ug
R21iSCwgS8O2bmlnc3dpbnRlciAtIFZlcnRyZXR1bmdzYmVyZWNodGlndGUgR2VzY2jDpGZ0c2bD
vGhyZXI6IEphbiBNYWNrZSwgVG9tIE1hY2tlIA0KUmVnaXN0ZXJnZXJpY2h0OiBBbXRzZ2VyaWNo
dCBTaWVnYnVyZyAtIFJlZ2lzdGVybnVtbWVyOiBIUkE0Mjc1IC0gV0VFRTogUmVnLi1Oci4gREUg
NTQ5NDAxMDEgDQoNCkF1cyBSZWNodHMtIHVuZCBTaWNoZXJoZWl0c2dydWVuZGVuIGlzdCBkaWUg
aW4gZGllc2VyIEUtTWFpbCBnZWdlYmVuZSBJbmZvcm1hdGlvbiBuaWNodCByZWNodHN2ZXJiaW5k
bGljaC4gRWluZSByZWNodHN2ZXJiaW5kbGljaGUgQmVzdGFldGlndW5nIHJlaWNoZW4gd2lyIElo
bmVuIGdlcm5lIGF1ZiBBbmZvcmRlcnVuZyBpbiBzY2hyaWZ0bGljaGVyIEZvcm0gbmFjaC5CZWFj
aHRlbiBTaWUgYml0dGUsIGRhc3MgamVkZSBGb3JtIGRlciB1bmF1dG9yaXNpZXJ0ZW4gTnV0enVu
ZywgVmVyb2VmZmVudGxpY2h1bmcsIFZlcnZpZWxmYWVsdGlndW5nIG9kZXIgV2VpdGVyZ2FiZSBk
ZXMgSW5oYWx0cyBkaWVzZXIgRS1NYWlsIG5pY2h0IGdlc3RhdHRldCBpc3QuIERpZXNlIE5hY2hy
aWNodCBpc3QgYXVzc2NobGllc3NsaWNoIGZ1ZXIgZGVuIGJlemVpY2huZXRlbiBBZHJlc3NhdGVu
IG9kZXIgZGVzc2VuIFZlcnRyZXRlciBiZXN0aW1tdC4gU29sbHRlbiBTaWUgbmljaHQgZGVyIHZv
cmdlc2VoZW5lIEFkcmVzc2F0IGRpZXNlciBFLU1haWwgb2RlciBkZXNzZW4gVmVydHJldGVyIHNl
aW4sIHNvIGJpdHRlbiB3aXIgU2llLCBzaWNoIG1pdCBkZW0gQWJzZW5kZXIgZGVyIEUtTWFpbCBp
biBWZXJiaW5kdW5nIHp1IHNldHplbi4gDQpGb3IgbGVnYWwgYW5kIHNlY3VyaXR5IHJlYXNvbnMg
dGhlIGluZm9ybWF0aW9uIHByb3ZpZGVkIGluIHRoaXMgZS1tYWlsIGlzIG5vdCBsZWdhbGx5IGJp
bmRpbmcuIFVwb24gcmVxdWVzdCB3ZSB3b3VsZCBiZSBwbGVhc2VkIHRvIHByb3ZpZGUgeW91IHdp
dGggYSBsZWdhbGx5IGJpbmRpbmcgY29uZmlybWF0aW9uIGluIHdyaXR0ZW4gZm9ybS4gQW55IGZv
cm0gb2YgdW5hdXRob3Jpc2VkIHVzZSwgcHVibGljYXRpb24sIHJlcHJvZHVjdGlvbiwgY29weWlu
ZyBvciBkaXNjbG9zdXJlIG9mIHRoZSBjb250ZW50IG9mIHRoaXMgZW1haWwgaXMgbm90IHBlcm1p
dHRlZC4gVGhpcyBtZXNzYWdlIGlzIGV4Y2x1c2l2ZWx5IGZvciB0aGUgcGVyc29uIGFkZHJlc3Nl
ZCBvciB0aGVpciByZXByZXNlbnRhdGl2ZS4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJl
Y2lwaWVudCBvZiB0aGlzIG1lc3NhZ2UgYW5kIGl0cyBjb250ZW50cywgcGxlYXNlIG5vdGlmeSB0
aGUgc2VuZGVyIGltbWVkaWF0ZWx5LiANCi0tLS0tVXJzcHLDvG5nbGljaGUgTmFjaHJpY2h0LS0t
LS0NClZvbjogYnJpYW4gbS4gY2FybHNvbiA8c2FuZGFsc0BjcnVzdHl0b290aHBhc3RlLm5ldD4g
DQpHZXNlbmRldDogRGllbnN0YWcsIDI2LiBBcHJpbCAyMDIyIDIzOjI0DQpBbjogQ2FybG8gTWFy
Y2VsbyBBcmVuYXMgQmVsw7NuIDxjYXJlbmFzQGdtYWlsLmNvbT4NCkNjOiBFbGVrdHJvbmlrIChD
LkdlcmhhcmR0IEdtYkggJiBDby4gS0cpIDxlbGVrdHJvbmlrQGdlcmhhcmR0LmRlPjsgZ2l0QHZn
ZXIua2VybmVsLm9yZzsgQ1JNIChDLkdlcmhhcmR0IEdtYkggJiBDby4gS0cpIDxjcm1AZ2VyaGFy
ZHQuZGU+DQpCZXRyZWZmOiBSZTogRXJyb3IgYWZ0ZXIgdXBkYXRlIGZyb20gMi4zMS4xIC0+IDIu
MzY6IFVuYWJsZSB0byBuZWdvdGlhdGUgd2l0aCBJUCBwb3J0IFg6IG5vIG1hdGNoaW5nIGhvc3Qg
a2V5IHR5cGUgZm91bmQuDQoNCk9uIDIwMjItMDQtMjYgYXQgMTQ6NDk6MTQsIENhcmxvIE1hcmNl
bG8gQXJlbmFzIEJlbMOzbiB3cm90ZToNCj4gT24gVHVlLCBBcHIgMjYsIDIwMjIgYXQgMDI6MDU6
MTRQTSArMDAwMCwgRWxla3Ryb25payAoQy5HZXJoYXJkdCBHbWJIICYgQ28uIEtHKSB3cm90ZToN
Cj4gPiDCoA0KPiA+IEkgZm91bmQgdGhhdCBhZnRlciBhbiB1cGRhdGUgZnJvbSBnaXQgMi4zMS4x
LiB0byAyLjM2IHRoZSBhdXRoZW50aWNhdGlvbiB0byBvdXIgZ2l0IHNlcnZlciAocnVubmluZyBn
aXRlYSAxLjEzLjEpIGZhaWxzLiBXZSBhcmUgZ2V0dGluZyB0aGUgZm9sbG93aW5nIGVycm9yOiAN
Cj4gDQo+IEkgYW0gZ3Vlc3NpbmcgdGhlIGlzc3VlIG1pZ2h0IGJlIHRoZSBvbmUgZG9jdW1lbnRl
ZCBpbiB0aGUgZm9sbG93aW5nIGdpdCBmb3INCj4gd2luZG93cyBpc3N1ZToNCj4gDQo+ICAgaHR0
cHM6Ly9naXRodWIuY29tL2dpdC1mb3Itd2luZG93cy9naXQvaXNzdWVzLzM0NjgNCj4gDQo+IFRo
ZSBwcm9ibGVtIGlzIG5vdCB3aXRoIGdpdCAobmVpdGhlciBhIGdpdCBmb3Igd2luZG93cykgc3Bl
Y2lmaWMgaXNzdWUsIGJ1dA0KPiB3aXRoIHRoZSB1bmRlcmx5aW5nIHZlcnNpb24gb2Ygb3BlbnNz
aCB0aGF0IGlzIHVzZWQgaW4geW91ciBzZXJ2ZXIgYW5kIHRoZQ0KPiBiZXN0IGNvdXJzZSBvZiBv
cHRpb24gaXMgdG8gdXBncmFkZSB0aGF0IGFuZCBnZW5lcmF0ZSBhIG5ldyBob3N0IGtleSwgYnV0
DQo+IHRoZXJlIGFyZSBvdGhlciBvcHRpb25zIHNob3duIGluIHRoYXQgdGlja2V0IHRoYXQgbWln
aHQgaGVscCBpbiB0aGUgbWVhbndoaWxlLg0KDQpZZXMsIHRoZSBlcnJvciBtZXNzYWdlIHlvdSdy
ZSBzZWVpbmcgaW5kaWNhdGVzIHRoYXQgeW91ciB2ZXJzaW9uIG9mDQpPcGVuU1NILCB3aGljaCBp
cyB1c2VkIGJ5IEdpdCBmb3IgV2luZG93cywgaGFzIGRpc2FibGVkIHRoZSBpbnNlY3VyZQ0Kc3No
LXJzYSBzaWduYXR1cmUgYWxnb3JpdGhtLiAgS2V5cyB1c2luZyB0aGUgc3NoLXJzYSBrZXkgdHlw
ZSwgd2hpY2ggY2FuDQp1c2Ugc3NoLXJzYSBhcyB0aGUgc2lnbmF0dXJlIGFsZ29yaXRobSBvciB0
aGUgc2VjdXJlIHJzYS1zaGEyLTI1NiBhbmQNCnJzYS1zaGEyLTUxMiwgY2FuIGNvbnRpbnVlIHRv
IGJlIHVzZWQgaWYgeW91IHN1cHBvcnQgdGhlIG5ldyBzaWduYXR1cmUNCnR5cGVzLg0KDQpUaGUg
cHJvYmxlbSBpcyB0aGF0IEdpdGVhIHVzZXMgdGhlIEdvIFNTSCBsaWJyYXJ5LCB3aGljaCBpbmhl
cml0cyB0aGlzDQpwcm9ibGVtLiAgR2l0ZWEgaXMgdHJhY2tpbmcgdGhpcyBhcyBbMF0uICBUaGUg
ZWFzaWVzdCB3YXkgdG8gc29sdmUgdGhpcw0Kd291bGQgYmUgdG8gYWRkIGEgaG9zdCBrZXkgdGhh
dCBpcyBFZDI1NTE5LCB3aGljaCB3b24ndCBoYXZlIHRoZSBzYW1lDQpwcm9ibGVtLg0KDQpUaGUg
aXNzdWUgSSBtZW50aW9uZWQgYWJvdmUgYWxzbyBoYXMgYSB3b3JrYXJvdW5kIHRvIHJlLWVuYWJs
ZSB0aGUNCnNzaC1yc2Egc2lnbmF0dXJlIHR5cGUgaWYgeW91IGNhbid0IGRvIHRoYXQsIGJ1dCBv
ZiBjb3Vyc2UgdGhhdCdzDQppbnNlY3VyZS4NCg0KWzBdIGh0dHBzOi8vZ2l0aHViLmNvbS9nby1n
aXRlYS9naXRlYS9pc3N1ZXMvMTc3OTgNCi0tIA0KYnJpYW4gbS4gY2FybHNvbiAoaGUvaGltIG9y
IHRoZXkvdGhlbSkNClRvcm9udG8sIE9udGFyaW8sIENBDQo=
