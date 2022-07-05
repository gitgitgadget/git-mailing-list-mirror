Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73332C43334
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 06:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiGEGK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 02:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGEGK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 02:10:56 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2160.outbound.protection.outlook.com [40.92.63.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18560CC
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 23:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/a/Shyy35KBVOOrke9ULhYn1V1D/KVHvJKX+BOa2aqTXkCBpgu47xQuCo1QzAYGU2DZ0Z28Tij5I6xzfy04rHHM4aOopJ4NvoBExhkx6GOoFZ7e/+5xWrC8jWw6tMP9Ilv9z35J4JCe9s+lrGEwAzq0yT9JhoZADjcwo0DgL6niGB0U+++nDZAo+W9QhmK2NKjyxbpfw+rXYiHcImiIPKv0XktfdUUkw1OUQ13FTyzKnYAb1H0uOTblJay0wAYBbJqXFJVqGMXPGk7l1X39EQ6kfehZ93cYHtpWZc2b/hFurvM6ptyzYm2qyxNRcBVamI+9v+yJYdbL7D5OSfpfTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6r1zFcpsgwoCDyHPZU8qJfYRfsrYBiGA9/i/7alfkA=;
 b=GIZQlOR0GpqZGKyvdFJBf0+6+TLKerdx2vvApP6cp3ctnNHb+j7JQz+1nUA3IJqkMgipppyM0ODq9rvSdMfB69HEp3/oSHa7U/GcWMwK8aC33P53smIYcFEmlqgVg0fxeubNgkoZV9dk/kllPQ56gVrmdgjB28hOZyfQzhLZIJzo1sugzxq8QqtPmmXDmAQqn+hzRFcfRbkICSNZiDGCNjnyY+QvKRp6Xb1YqLJLFde/2BOoGtT/DkQUITm99YNoflTu9CXQSNYXsnTWCcErfkss9zsIA8+GBTNuuoYj1mn1wVcO1rOnSqzRPltbyrus5Z96oVkW6QRUCUdflzDqkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6r1zFcpsgwoCDyHPZU8qJfYRfsrYBiGA9/i/7alfkA=;
 b=qCxem73Whi62bRqY230E4y5KOnsPuD3F0+4ECiJmkywxhhF5clq1/yZRJKTL0UOaW7HRR39twW5r00iJ/y0Ld13PDlM5gwPX0yqQAC3mSH1f0eDBHTjFDNPdqAjAIbt3dFnEFkTllL1Ns2+Qg488puI7e19sK4D0dIFjvWHOWQsA+Wl7zQLi9p38MPy9XtuFjxFEHCuR2qtm8ob8wDVFtNvKFwEUyyLvT0vSJ1b4gp8XRy60DyQgNzmRKHPneaF05PhZlDUf89g8FtM/Q8zQtjxhc1LoQz7WL7QMf1dVp19iZR1KJqO+1y94vCIVJvMumOu3juDPcU70IGq9mCA/Vg==
Received: from MEYP282MB3564.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:178::14)
 by SY4P282MB0922.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 5 Jul
 2022 06:10:52 +0000
Received: from MEYP282MB3564.AUSP282.PROD.OUTLOOK.COM
 ([fe80::e5ef:6e8c:f1a4:515b]) by MEYP282MB3564.AUSP282.PROD.OUTLOOK.COM
 ([fe80::e5ef:6e8c:f1a4:515b%7]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 06:10:52 +0000
From:   Raghu Saxena <poiasdpoiasd@live.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Missing `push.autoSetupRemote` from v2.37.0 release notes
Thread-Topic: Missing `push.autoSetupRemote` from v2.37.0 release notes
Thread-Index: AQHYkDXmZeBsxZEPUE6uPgnl3CZNnw==
Date:   Tue, 5 Jul 2022 06:10:52 +0000
Message-ID: <MEYP282MB35646319926B07F89FBF577DA3819@MEYP282MB3564.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 7e84b60d-fa0e-c318-3d47-c0d49a3497c4
x-tmn:  [2/B6T3UJpVoa2kyn3Jzp0+CcF++/414x]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 871bd1ca-8342-421c-4f3a-08da5e4d1d45
x-ms-traffictypediagnostic: SY4P282MB0922:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c/GZ6MxgMn0gQq/gA+sQ+IpCaIUuI/N7JgIZBIiojRH5gntDx37wV06xEKrzW0f07kPtGe6+EsfTTONY7AAYdYKFXUsR2BtFqnsbbwHIiwxM50SXbIxRPC6/WUreoYNsW2j6/asZ+8ehCX0+4Q0TvDPMiuesetSOGOkYOOmLvEa/YOhcqvmKQDv6J8f4f3g2VZmiBo75BwP94q01ujJLW+TT5bQNzIgfzZsPjmkhlfm6tLZo2wEl+Y+o0n37wjS5QbuUosPziEec74rIYqCP2aaRUWp6zWz6xYRx5LBAEjmZ2AwCUNqU3jfjZPbYAGD46PcUH5EDTsTJUwANrdYL+9jOcC193EhJAPYzSvdbEEK0E8SB+ZhaNETTawT/nQPmSXFMiBhoh0rCdQbq63FLxWD8QvN0ZLia2JN/kECg69eIhAVs+HvUf/qWihBlCS+s7hsf7Tfpj8L/7HLmpQ0+y5UNnfjN4FjNwFlcxiGxcJWp3S6z7pFeNRq/dmTFyMOwUERJQCBGQdbhMGT20UJb7u8rlVzW8+UX3f5BuEM2Gzv3LhjYnb/FoSKLbP/O93zKaGn9Suabtj8kuSCysSuFVr7i8lRKooudwoYN28KZDitjCO6RVCAxE+0BmP8lSAcR9aKJt+xfnZjsTjm8Jqhic8TeN/BrMNW/JxfJIqQdqD0=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cwvl+HeRFrV4I7RuMR0wrVG+QXRB0w8q5rxd1arLqtk6yDVb7ZfqEMRa1O?=
 =?iso-8859-1?Q?f6Fq0E6ZPx1ThsJ5idfne2SFl/iLs53SGYFkOKKx9NB+hbrvNTbtW/JsOX?=
 =?iso-8859-1?Q?Fc8uMVJtMBVbhhuEat7F+LCMKiUklEanrG+cwY4SyLvUuYQ82aoMfW+xJu?=
 =?iso-8859-1?Q?3AghVtpx3jHT6EQdbvk4Zvsjan425yNYgAqw6neyr54vZI/CG61TO420l+?=
 =?iso-8859-1?Q?9yC2fbzmAprIUQDAksWGC7reD6qv7gu9g0jtLvpgJ21L7kT0EVSnAulvzL?=
 =?iso-8859-1?Q?dS61UBWBSLUB/V8GvNxIHBu9sj88hwzV+S+6HGpbGwqJV9PDgsmtpUlM5N?=
 =?iso-8859-1?Q?39wAkqxpAJNbyQSfBsGvJkdKBxOG4R48sikqVe6J9bfda8CdtMNn7pSK+d?=
 =?iso-8859-1?Q?oy4d+74JS4DM8BCO5HxvCk3RbP1FuZM7c0GyPGqj315L4LqQPphXFDbZ3G?=
 =?iso-8859-1?Q?KBrN7G3PKj9NN9dR1a2JwSt2tb0mlyqUGbS6E9YF8xPX8iAULhG/2vZ+zd?=
 =?iso-8859-1?Q?/JJEt+iUHyPW5kGLR4Jtcv9aLL+Wl0fzAKsbHhoSeKsZsONqYLmw28MrZ+?=
 =?iso-8859-1?Q?7MoAJY/Eh9knaXhr/Az+kyqAdf9yJq5gEArWA3sYikCtsmCSy38dVJ6xrr?=
 =?iso-8859-1?Q?g7QHGhnf9bb4BAWywglLIjFnD1Bm/LaU0oeBWpAEnqaZvDg2m0n11FMni/?=
 =?iso-8859-1?Q?m5BZsL5+MwJiRKPihv0f3P1mrJ+IgyXIWLlhPTe6jj7AN34tMz4GiOhNK+?=
 =?iso-8859-1?Q?/CH17am28NahD7lp6RXTA/UXwU05R0HXmMdh4JKQCFR649n4ayaxF++rUi?=
 =?iso-8859-1?Q?DrfM3FvThHK0eXoDkqwxKxS63KqiCghV9kitCZ3UziAs7fcTusEzY44309?=
 =?iso-8859-1?Q?NUkdiNG58A2C+b5OL9FmjRNUDFfkSRPAaXYgcLdu9mXMGHVSwOYHqh95St?=
 =?iso-8859-1?Q?seFlB91q0XZnVgLRbgCI/DscPOLFbBEgc6Kuw8l8w9QI1UONxQD7iNIL4q?=
 =?iso-8859-1?Q?fmKYazfPXT95LuEWRlgHhLgZ953AU1wdeC43XrNGLp4fvjS/RIOg4+DoEt?=
 =?iso-8859-1?Q?pGMy+xO1wbW6xXsxVlLgL8oCTFn7WNpnr+czWwxmuSelFknS7V5K/Sns7m?=
 =?iso-8859-1?Q?ZbGx7ou4jHhv7jYM2tMEkWQ0j2jSgoTX52NdPl1HcYiFcA07dvRT5Gx+3I?=
 =?iso-8859-1?Q?K9s6dMmsT9eYI16C5JbD8+uoUQgTNu3rBTMWpsE/Zvtas/L/kRDUySNZ8J?=
 =?iso-8859-1?Q?rvXAGh8+o1qwxPh5K/XMguVwbxGjnmCUsUAloAou0uROXO/O5kNFdG1bZ2?=
 =?iso-8859-1?Q?vHVGz1wppUG06xuobqExtW/R+Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB3564.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 871bd1ca-8342-421c-4f3a-08da5e4d1d45
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 06:10:52.2764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB0922
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi git team,=0A=
=0A=
As per the commit at https://github.com/git/git/commit/05d57750c66e4b582337=
87954c06b8f714bbee75 , seems the option was added and released in v2.37.0=
=0A=
=0A=
However the release notes have no mention of it: https://raw.githubusercont=
ent.com/git/git/master/Documentation/RelNotes/2.37.0.txt=0A=
=0A=
I think this is a very useful feature, and it should be mentioned in the re=
lease notes. =0A=
=0A=
Regards,=0A=
=0A=
Raghu=
