Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11C9C433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 18:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243050AbiANScJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 13:32:09 -0500
Received: from mail-dm6nam10on2053.outbound.protection.outlook.com ([40.107.93.53]:64353
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242991AbiANScH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 13:32:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNjdElIxyhV9PtTJwqmk7lw235KkQx6Y+DMd6O0GQKkC2jAPpNWZWOoC+EiDXNDAUXRH9H2MZaQsmwFbI+NJ8uM4sRi9uHUDgKAtr4HPk7czsVgDq+CP5bFHCFZ2AenpDz+hYqr1XURujhN+yCZP+0FDnHsZ88LfKVYG/dkKwOamZs1F7GZrDjOQfTyWsys3xI6WHHKslqs9kx1IT/GMBvNFoCYuYgO+kGyThyuUjVZnk79x5dU2I6nyw8adprv9d76kSSlkN2M0A8Z1CzIWTZ5sdu+/vxemZxUmTt1RIxem8MFTZ/DOoiEDA2yD8l96sXHH85Aw84+/M0i29Ll7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eH2Guz4D7OWnsyBjWGFTIBD+SmTmWS8aWe4iptI1S4=;
 b=lXPtISOxDhdFJwx7pvI1KBpuvPZPo3iqyey+TeYr9nvBMQnyNLoupk/tpSkf8IZn4hWEwIh0RyNrDsMMfirPjH7d7Wko27Qdb754uPqMdbP7G4FLYsprCQzNL58I7P6S80vfO/CmxgHwLJRG0mqTUY5v4qOGHlTFgJCnPfKDVlAtWldGDeJAFD0I5BwZGELps4GiWOFVYelwUW5EgHmoyy7G3yQ+LT4kv9TcfACe5R8NCABDBvIQrW6RFi/Rz0AK/J9Fq4m7t646FshB5rA9XaOiEXyvyRm8zowqiDao/tc0kpo2otSd5gwKcYuJERwzu741uXsUwkMcHmOTCbE/bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eH2Guz4D7OWnsyBjWGFTIBD+SmTmWS8aWe4iptI1S4=;
 b=RwMWTUICoQgisa+/wSsI5bMkUtNchv7vt1fOorLhLLv8sIaSmSiF5bJDJc0OImKoiyw913b8JeWOoqBo7jej7sDiLDNpATU7/QBiQf4L25iO3yHCbpmiBbS2gGatQdMECbQ/L7WY7FLO5HhXefimREayStoimlrb0iXn/XULeN/QmtKHcotcST4Nt8/aQD5QaemnvkJEb6NrujvJRe/wR9EOhZL36zP/LNAWnG/UT73dNn4lgsaEs6Vdj6P/tItbi8q8GuuP5AKjIDqPXpPB3YQMDBpNiyuzkADkoXUJWCTX60UHMkfBEo/c5pOKcaQf/APhfgVad1Du5si41C0IQQ==
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by DM6PR12MB3099.namprd12.prod.outlook.com (2603:10b6:5:38::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Fri, 14 Jan
 2022 18:32:04 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 18:32:03 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: RE: [PATCH v2 00/21] git-p4: Various code tidy-ups
Thread-Topic: [PATCH v2 00/21] git-p4: Various code tidy-ups
Thread-Index: AQHYCIQtB5JjCs0DyEmVJUfxZtMUF6xhkq0CgAFF1aA=
Date:   Fri, 14 Jan 2022 18:32:03 +0000
Message-ID: <BL0PR12MB4849877420F075F0E434207CC8549@BL0PR12MB4849.namprd12.prod.outlook.com>
References: <20220113134728.23192-1-jholdsworth@nvidia.com>
 <xmqqwnj3fdb8.fsf@gitster.g>
In-Reply-To: <xmqqwnj3fdb8.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6224135-d725-44e1-82e8-08d9d78c2964
x-ms-traffictypediagnostic: DM6PR12MB3099:EE_
x-microsoft-antispam-prvs: <DM6PR12MB309987B586F38B206D2BAECBC8549@DM6PR12MB3099.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lLAGs2NaAfslUedWN0n/SzRErK5uTma8qc6EgjXsQNPRHs/B6kM+LofGyGclscLwXsEjMfJM2o6CijuVDioN3kz+FnaQsaot529zG/tOkTKyOPLXm4gNq6swOQ+2V7eV0FF2YAO90FwRG0OcAQhhVJ0NWsjuGZpT9jV+QLmyivoPlIA6Hg+hUkdJ5xv7a8izDBB2kiP7Bb+SnJOZUlu8MdwiImw132hBVKTPxK2qxQhoFOHftDMwiuNEYqEho2Mfd9PeKX1nsaIhevEGPtlp/tGn1Psz6I5lvCRmCdruWaMQvxucC8nGI6NbgJcju36iNtReARvb0rdThGlFbqWX4iQMJKacKuupLqEWVuJMg+QiOE76qaOT0DRCL1Q4+UXv5TREz2WuS6gsJWxKhw1MIj+7DwRToce8XAP1r4oNHzcKoIm0rpVsy0FZzoK2uApi+nQf/AXTEhQdg1Bh6RCCzZMnlOiBzW+zHtuBDs7X8UWFjj7VwQxTTBL14iuvy0Ak6zlbvWJXX/VCJAdB5wbVd7HZd8n72Di03lt+08hl10pcfDV2Hqnre1yib00YJdiSBH4o+9G2rDZusIW1Df9k/d+O0TrRLgnz4uJzFzhz0cWZDIOEsZ0spEwRWdV/cWAETtxbN2wVXtQVq5F075XDk2BXA0gwww7VCOnSd8HkAL7tMj7rCfGxzf1vJI0xcYtb55XRvOB6h4VDSu8/RAII7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(122000001)(66446008)(316002)(55236004)(64756008)(66556008)(7416002)(6506007)(54906003)(5660300002)(66476007)(2906002)(186003)(26005)(52536014)(86362001)(66946007)(6916009)(71200400001)(38100700002)(7696005)(4326008)(4744005)(8936002)(33656002)(508600001)(38070700005)(76116006)(8676002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6rEF/olVumkDdHamRRKKUAG62UibEEm2ntM8pWqhdX/rvQ9yTnxnB8NrmHKL?=
 =?us-ascii?Q?pa2Hyv4V6YZSEgpHwDEjyIsWXwjJ/rOG9khTjSM6B35hV9/5+p2uWecGThGI?=
 =?us-ascii?Q?d/9ontBuNSBhb33wupuIeBDt4D3Z4WDBx8IFSQeWHUD/VXAXGd/wySlUllke?=
 =?us-ascii?Q?h8q77AWGFj5TF2IvtYjFzMIuFeSxVe0IX6xZOmEGhCyDcbrWImFHpZlhrwCF?=
 =?us-ascii?Q?IoUjUCKt3tIJRHa0A/i6A/1larbSm5lWDCy8Vr7MKB7OaN6a2yi9D30ixpxn?=
 =?us-ascii?Q?71b3lHED3NfVjonyr/8aF5IfYleGTZoc7TU6l/YE/1zoCDqI5NS06m8uZKe5?=
 =?us-ascii?Q?wxQloIij9FhkH/rbudDrRgRwEqCChooJdHaTaINlOws/AVrGEWNtmhtA2ywn?=
 =?us-ascii?Q?DKFRgaISGzVKZk786oSCSTv8oEPtUwqIzXGEmkxAyTqge3+CJrIhrlCUTlTI?=
 =?us-ascii?Q?qoZhk/Iqnq6y3JOH3/gvXuLLM2uvsvD/aVBmZ5OoVs2s2qsAz6yafMsCjGIs?=
 =?us-ascii?Q?JAdZpsnIXPL63DPEwPWlcl6+hxNMTGqbyh2ESJHT6C1dj460vuFM51PIpPDI?=
 =?us-ascii?Q?au3ZEaTm9PX4BJnaQYPzEHF42X5IALs6GxOVbrtVMRBVUtxkLRTh7nCAgQ/q?=
 =?us-ascii?Q?GkbmXXCO3aaqyFsERPL1C1ImLup9ofX8RbSF7BtTlqLmiVn9F5oG638J/bom?=
 =?us-ascii?Q?fRN+Fp1HFV52w3ptGzNZVbVptSymNTmDwQnoYV88EGvwwCBV5pZOuOfI2CNJ?=
 =?us-ascii?Q?F+4UJ/k5kNYAQvgzH/nLPOYozcCdICiQJk4z/rJ8SNt+IxH0SR5VMqx5jTcL?=
 =?us-ascii?Q?TxrD8QGbXQTu3xh3zQGjw366HMXjevvENk6tG4aXHXCtC1NwHfmYvfEPSdOD?=
 =?us-ascii?Q?9ov8mZ2N36m0JIwP3jsVRVvWU/P+4XDp5qLb7qVON9/3CUtsWy0+F0pa5G+B?=
 =?us-ascii?Q?kyyC6tXRrsSUVvkJAGMVM6MZfTYgs+CLlyxPF/4gmjoE4FERifzs3thjIEmx?=
 =?us-ascii?Q?lfnz/pYUvC9MsiLzTIP+hB349KDbKEYzp6aUt2mHJLgFHw/4MsPs7N005K3g?=
 =?us-ascii?Q?JAyoQtAT/AE8SdT52oAysyKjbEs6UIw0+HuMvVCGulPQUc0Th+C3uZd9a7AL?=
 =?us-ascii?Q?unBuUDORNGDqrr7l+1ts0KY8BFM31W26OCSM++PGU6r/qkkzVm2oTb281Uvj?=
 =?us-ascii?Q?TC93YcwbYerd0cvdXd4mLRjQkUTvQMPTYRHyaTLRjtrxjG1CH1l9RkNNkUqy?=
 =?us-ascii?Q?u35MABKkkWqceM028F3SDoekRsjyQA60NCIuKXuWs12jp/xNqpA4/vd8rsJp?=
 =?us-ascii?Q?iyyxTtTU6FMPPyGPijW4Pcy6qvcRtLnyxPuZvCyLfPiwRUY1NqRHmfT4inuq?=
 =?us-ascii?Q?yCnyNM/PXZkCyfpZNi87z6wvfPEUDnZ2KuPsEn7KnXbDK/5M39McfWRdP3pO?=
 =?us-ascii?Q?wkvhWMsUbgXsebBDxYH7psJ6tq9/7jkzoKJKqailDwE9OZlDP6nqvlE0yBnD?=
 =?us-ascii?Q?aLHxLy51S3mBk6PfiGjQ2NM2Sidi5U6GA8hnSP7q68ayBtdMRBZPRGRuqUd0?=
 =?us-ascii?Q?2QiWdjUMVFz4Pv1pUmWn7OGdVyubQeOYyNDElE4uS5UAUohZzH8D2q1Jse5A?=
 =?us-ascii?Q?3g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6224135-d725-44e1-82e8-08d9d78c2964
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 18:32:03.8544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AuOPSoKu6Wkf7KCOfDsZ7TkQDh4G9u7aSKQguruAUeTZSpLntFoPRu+rADPGVqQ+N+gchUoOyETRIT7VI0S3KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3099
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> As new things in 'next' that are not in 'master' are not moving until the=
 final
> release of this cycle, perhaps this needs to wait until much later in the=
 month
> (see tinyurl.com/gitCal).

I was not sure where the patches ought to be based. I can rebase them on to=
p of 'next' if that would be helpful and/or if you need me to delay them to=
 the end of the month, that's no problem.

Joel
