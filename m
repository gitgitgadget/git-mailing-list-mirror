Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CAACCA47C
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 08:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbiGNIB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 04:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiGNIBA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 04:01:00 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2011.outbound.protection.outlook.com [40.92.47.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530D922522
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 01:00:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIRXqYziMNwtLqCaXMt9wh1lYK60gpATEhXl1kzGAWXP77lKJor5APuPGeSkh9DuIDJsbb9fgZCvAJrRRCSOFzmyPO7kSo+tkflb/UoEJ2y1evWE4f/kOWr2YpD5c+vsOx01ym/AAt+tRg7sFeN3R4uHcQsA5ljMuOHA1yItMeBSKyIrvqx55bTETmEhBfgxuI6vmWBE63bW3EISYj2Y2DARWD4V70D8LAzfedFYB96GNayAVJXAfXX9TB36yDyfu6aETiO4gTG6gs11TDlGjllEcZTrwV38kit59wzITh0ev6rplTgyYwHx+CODy7Zw0M1ul9L2YrQWxr0xYfeuXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YB976dVqPzncN205j9csl6wmaRPhSQLHNrYbq72rjUU=;
 b=etbaDF1Aqym58zNvj92QtkNfixhS0IDYo3niKjOoyuMCyvO/D/oiIGTOW3R8ODqihGkPCDHTuopQAiujnWJzVKsyHjHZC9bqg8dz8KCtyX9NrwNzOjAfhJMhPYbL0J9nYDmG+OpGana72XrMoTDfb54j+8y0fqlhXB0RedRpOq/Q4rs4j11cLuEdnZ8Dy1/a2ewNhd3DUe0i7m3vsOu2PzjhieuilaJu8ySNpSvaXbTBQeUc8h1WtI51HRO/hJn7w18RA+7+2+mYoBGxVF4HL4PTRG8MA7A5iJtmd17KPQY6jXCiNRIHFFRh6AM/XG1PxzWJQ/rP1BpdSP4OW3gh6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YB976dVqPzncN205j9csl6wmaRPhSQLHNrYbq72rjUU=;
 b=FtKum++51+w8/2qgBuTf9KkkrqoHg7V8PmkussXv7h/nAPTtpPNJjifPJyJf47bJy92vSPtamees5loLV2AdG0oX7WAswfsZXQlNfQOK6WeOk//QqFc0p665QRNwwcaLuW+iapRkoAJP8gQtCBifdPwbfe06Eop0RfuKDqu0hH3FtCB0wWVM6+MTLDhDkuAC+yAwbRP9VZAS55L/Q9q1BXZ21nREbuQVUWSa8ayFIFr4/J0iYFAqnIpZf/xs6WRntqIJ6ZHE939JuREbqK/SIUiDCKNmt/3vRCHxRZG6J+u0nLaImWqhXTlWonmbxy7c7AR6qHqtgOhAihrQaqhfiw==
Received: from BL0PR13MB4275.namprd13.prod.outlook.com (2603:10b6:208:8b::19)
 by BY5PR13MB3345.namprd13.prod.outlook.com (2603:10b6:a03:1ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 08:00:57 +0000
Received: from BL0PR13MB4275.namprd13.prod.outlook.com
 ([fe80::c4ba:901e:67e5:fffa]) by BL0PR13MB4275.namprd13.prod.outlook.com
 ([fe80::c4ba:901e:67e5:fffa%5]) with mapi id 15.20.5438.011; Thu, 14 Jul 2022
 08:00:57 +0000
From:   fawaz ahmed0 <fawazahmed0@hotmail.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: "reject arguments in cone-mode that look like patterns" doesn't work
 in macos-12
Thread-Topic: "reject arguments in cone-mode that look like patterns" doesn't
 work in macos-12
Thread-Index: AQHYl1asm/9hwI5XDUaHZeKUJukpba19gMgw
Date:   Thu, 14 Jul 2022 08:00:57 +0000
Message-ID: <BL0PR13MB427533B25CCFE6A37F7619E8F1889@BL0PR13MB4275.namprd13.prod.outlook.com>
References: <BL0PR13MB42750BC5C4837B7B0BD1885EF1889@BL0PR13MB4275.namprd13.prod.outlook.com>
In-Reply-To: <BL0PR13MB42750BC5C4837B7B0BD1885EF1889@BL0PR13MB4275.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [yDMOEy8ygZXj0dAkpPRzwGCVMb9OrtPQ]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0dddf48-79c2-41c4-445a-08da656efc0f
x-ms-traffictypediagnostic: BY5PR13MB3345:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pf8mcL+OocpzW/DfbOho6orcSIi2J9nxhgqpZNVj7wtdFaXTVE0PdjnEmBjZ0Ir1y4IXrczfgXEcijVe9i35nfzr3rXjDIy566D1ELU7Dxd8e7opX6B+dC+1JsZy5MH+WgKEW9LQEnXDufXyQy6ho0Sxvftv4pjvsL/VLM/qgYHgzoMFa/Jp1mqXz/yDVHrMi/nvm6HheFL1/+i40FFTKBFe+GUQBlKdE40YSCMczW3wzFrOP8oVCyAHnAvDn1IJVyhVUQmzyy6Hjb5lu/D5gYjcebLwGCasaXm8wNIrcsl9zvQSws5bm4QYpxd9v122RgV1sbt2+yc9LHchOeTKFytn6/gM7uRjKJqHFnOhxxOEFGBoPsbgcEyKv0kOpjBGlwDlvNhSgUbH2W3POR4lAo7r/ktwqkEF/dLMX2vNHQ/NBMHz0E8mKjRmmU4FLvT+C8yUH32AD7vB1j7YZW+rB6hAfMVeEs6jlngYw2icXK2B6cngs/PN6pEGOXYuqtGGgqHyR2f0KrWQW/atcCdagUg9ioOZPzPqJJsI2zELNkaYKyqOeL06JJiHG9Fv36aLRJg09RGqx0Kzg7nb/Y4KSWrQtXFNEu7YugxpOpwm+GzI/qPsVtZEGZuyYMSFkvmF05FuPurZBSt7v8IIOMrtMvzCuQpUxzC0aHq5MQ4fgIm9WduU26p7mJbHN7HoyaGZhBJ3CY8WO/50xHBLG+8851B3Vyz8BGw7nEyVi5Hq7O0=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/TGeoNh+anT/Uch5I4S9dBgLdDsfnLYqHou+yFG1tTr1pStq9l/Lm1KAdn?=
 =?iso-8859-1?Q?UARdRNnkIYjDTbII4YwFTMJxYMELDdV+RF3/N+59pEEdFbYklz4ncndbMi?=
 =?iso-8859-1?Q?MwrnGjxzZ/93KrKwFmvF2Tijh3ZynkNE47oKaQhV+4RBBAkpZST/jyAUcT?=
 =?iso-8859-1?Q?knvA4MrbM4Cxn7ymWpYa87ccepNZidHDSM9LYfCKdoQ6DDqBacEU5ycXMF?=
 =?iso-8859-1?Q?y4VXyYcktz/3NcKeHK5FZvhRgGB0tnlFhjQDaLGZPXCC17MGFMdiJM7FLo?=
 =?iso-8859-1?Q?wPURzjSyB8Dy97w7h5uIaFZ+SlIj8iZyA1Sp7eZ+AjhrrmlVPdddng4S/h?=
 =?iso-8859-1?Q?N9yQzVLLsWHW+UkHwLPvkQXaxa/LCWKlDcSS4NgI7yP4l4BvU2Tpqp4eTO?=
 =?iso-8859-1?Q?Yg6eGzLP6sxY46ftcfLSBGIaxaagnJekQV/PvEF89/E13UCjWXceVq7tTO?=
 =?iso-8859-1?Q?LzANhaLAvqKVIUrlppHAWp0R42WoOx+KO5PULyFYDOIfsDqqGB02vJR4+x?=
 =?iso-8859-1?Q?mYh/QiGFfoNUTqwHlwmLQ5Og3Cd2tMVnHMZ954T2zSvWXfQB35TlVM0iSi?=
 =?iso-8859-1?Q?tko6f96H27CSM1VZIiYF2OUpU+UuTwZaEn/puiu7lEgBRJM0ULQ1ISFdZG?=
 =?iso-8859-1?Q?257G/P33FGg4+5eeoQk2M8Z2qWxyaYYpvOT+JnaeULyF4SzDGI89mQFK/g?=
 =?iso-8859-1?Q?Y8inwxwVs7WDbU8UAQKtyeHcGnoBUaEsRqUimSHpol1Jm9v7rcy2AYgG1z?=
 =?iso-8859-1?Q?Mw3CSd0CLzVALB3Dw4rgUQh42Om2yzHnMM3qaGXsBjG/VrZ/tbRNTL4+93?=
 =?iso-8859-1?Q?Ef8eCuhjmfPK1Bf92eVMhO6P1MSMHWyYcCQ85wPiYt/uHFmPNjKgOT9o8u?=
 =?iso-8859-1?Q?SS7WcuuFDHXZLZVbrROfDKEaHmsWKoHxfNSVfViv/trgtnhGucgWCaBYmv?=
 =?iso-8859-1?Q?ygfDm5JwyNPYzQaZuub+odOkeZeP9aYpUyDosh3faMJRR3rNNaxnTyJfag?=
 =?iso-8859-1?Q?MqikhYRCNTXf78QBldknoGEe5rvT43+QY58urHIoIpnKIooK47cRHcy330?=
 =?iso-8859-1?Q?FsXAB1oAnPtSAwwXtqiYTlZAYLzkxQzfo6DDnSIfiIeI8QcsXnclUR/7j2?=
 =?iso-8859-1?Q?CRznnMMh4O+ggeoUK6mlP3U2waw3SOjIsBIq8nuBzOY70Prdya5luzHQsy?=
 =?iso-8859-1?Q?B9RkWd8z+RK4qoiwADCI/hBfGJeFiirkSIMtu9RPnS5/1Lo+fDzmaIv7ry?=
 =?iso-8859-1?Q?L0fCQo6lNaEXd1643CqdlbRd5TRdxkbCQ/jVF8hNyJDJrk4V797ZaiD2H8?=
 =?iso-8859-1?Q?EUHCsaXVUWB2rJjPMZ++80ZEXg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4778-2-msonline-outlook-da780.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4275.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d0dddf48-79c2-41c4-445a-08da656efc0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 08:00:57.5857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3345
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please refer: https://github.com/git/git/commit/8dd7c4739bded62175bea1f7518=
d993b39b51f90#commitcomment-78433458=0A=
=0A=
=0A=
Using patterns in cone mode should fail, but it doesn't seem to fail on mac=
OS-12(github actions)=0A=
=0A=
Step to reproduce(try in macOS-12):=0A=
=0A=
git clone --filter=3Dblob:none --no-checkout --depth 1 --sparse https://git=
hub.com/fawazahmed0/currency-api.git . =0A=
git sparse-checkout add 'latest/*'=0A=
=0A=
Thanks=0A=
Fawaz Ahmed=
