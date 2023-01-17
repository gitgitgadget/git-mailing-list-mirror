Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7A8C54EBE
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 01:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbjAQBti (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 20:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbjAQBtf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 20:49:35 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B97C21944
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 17:49:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Py9njwzKnOhTRWLAohjiPd/QiVmTXisznClZE477n8W9HweQ/17zkcg7aWxAYMmal6U6EU5LgXkVCYXH8Sii3w3H+DtkwuvoL+ZHSP/+qWHmPu7iZ/XbuGJ6v3ZkrnUH/XG0umscIDYIMdlb4kWwtqlQMJS/BTtiTHmNZ8vGw1qiqn0St6PV4CeC1WivwtMx7Hm/QC3UbIQ1B4755MoosoS75og5fcGqfAJgxlIzG20U9sjZyC0MLoXTpbpilPKTT1S8LVtH/4iqTLzs8UyYlJz5kMpAdE+9mNA2KM9j5tYMAsXJbKDijW+LgUU1Zjfggw/YZOGxnzRdyzauHGdG7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIZ+H60cVFI6FPEXHsWOGUdtpO+DeK3phEOqD8o7+W4=;
 b=UYHwrUmG41cvGus+1XIcUN1D0SYjc+hCkD4ar9j93B76zu/kMprzwYwxvnDUgXX0/RQUIIBC89cqDHjeTCkCesfMPnJo9an2sjQGJ2LfBoxgDIOHhkpSpFOd1jDIRwFf5pTHm9U71cdfxqa1d0Xg1J/kqTOc/9xxu62+okuQu+ccN+50EdCv1T0lA37l+r0RpNEm28xWAoBI4R8uwuZFq42jXeErj+WUlhs02hcjIREyF++GzzgggxJ+Pvi9M5pdO0IgyZejlAOx40sSBDLF3M1iRPb95bozb/FukVAE98oJcNpJ8aMk5+Lg38TYJegwNti0Yn3dAnMPcSMVSgTEPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIZ+H60cVFI6FPEXHsWOGUdtpO+DeK3phEOqD8o7+W4=;
 b=Hhx2gt1OL85mT7GwxQW+0ZtiVrQ1vmjF+/AzW1jf+NXyOqig9NYW20yKUw1Wx0HjcfeOVeedJpYUuqF9o11H77W2XiC5OK+nTdOk2Svhg1mCY6ZjWhEgehTBdP60XDnc1EIrpEuo1IOmOKVqKvx526igCCS/LzwZDULhP/eO/q4=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 CH3PR12MB8581.namprd12.prod.outlook.com (2603:10b6:610:15d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13; Tue, 17 Jan 2023 01:49:31 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77%3]) with mapi id 15.20.5986.019; Tue, 17 Jan 2023
 01:49:31 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
Subject: [PATCH v5 0/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Thread-Topic: [PATCH v5 0/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Thread-Index: AQHZJTjIEvQf9C45R0Sm+0R83mOieq6h4V+A
Date:   Tue, 17 Jan 2023 01:49:31 +0000
Message-ID: <20230117014917.49378-1-michael.strawbridge@amd.com>
References: <20230110211452.2568535-1-michael.strawbridge@amd.com>
In-Reply-To: <20230110211452.2568535-1-michael.strawbridge@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|CH3PR12MB8581:EE_
x-ms-office365-filtering-correlation-id: 0918055d-016d-46ca-7546-08daf82d13b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hv1wwuI2vg2gHANHBAdAooHr4uq07wFBl1/JxGNiEdCLmivSoKDyaGaq/7voL6BQEotWTIP+dvOnCsVjN1FJHlcD2QZF5wdACcN9AKu7VKmkgSTgbfeTzU6866zKTTvUFQj5uoNNBDl2ZJ7u3uIgHve8gSog4h712CyOBWRk8u8l41k4EjyILT7mz2ZLWyQYpJwdju17S9x5fKlC7Q0bHa9PD3Tsys91jC3sWbMyYOaAzLkbZpob5IINAFqOOreZqoxhG6zU6g3m0qhY5kGDL3ZbHCYKWhsHzUN6IhMPd/3DGSZ1QltKWGN42FpphZxlzX1C0aFMYY9A5YDKAAXFA1V32fn/bPowMzJTAqBa7MWlObHXkpBUm8FbvN7zlyO7wRixonNHTp57i6eLbAGCEz2YthlPtEJlsPS8fmgJ87cMTE7i73GrTZEdT/8/YH8TqF92JEVIR8Il/loZhvfimOH+q4vLmw6Esu63YclQzGZZmyTL2PbgQY9iSvblFvAH5xt+Hg6UrdW/4SSeUPVG/OuKJeNIz6nyJsJmvhreGjI0BUiqMNvD69R1gXFQwMwVhqokETJVz3yQ90+mmm1FGraWjJ+AO71LcvOZYn3dV7uXUG4V+KmwrTYoCu77+EQp1acTvfAti6FrGrdKEfbjGiUc+9xK+PG8lF7gFa0WJlpVct+4eblpZZerEpq8aM3hniRjsHcmy+KH5daEdgaQhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199015)(36756003)(558084003)(478600001)(71200400001)(6486002)(6512007)(26005)(6506007)(2906002)(41300700001)(8936002)(5660300002)(316002)(6916009)(4326008)(8676002)(91956017)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(122000001)(186003)(38070700005)(38100700002)(2616005)(1076003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QKpaJ3ogW/lRJenkjcnO6j2xrYVLIogAk3AJ1eJJIVkiHS+nHdjpQ/0jsL?=
 =?iso-8859-1?Q?nhPrCezFt6GfGMcycG/rAxoFIM0MXc649ZUSkURGkQJIyYn25LdORI/juh?=
 =?iso-8859-1?Q?5V0wqdh3qDYPjDnnE2obmZM7kIW5Lq6btzHg0D2CC28hdn+A7v4Q61moq5?=
 =?iso-8859-1?Q?TXBuegQnplj6jF6l1wsQjsJxX8FgLmfIRtZRRj48nDSXsp0IWcS7eievWl?=
 =?iso-8859-1?Q?7xrUH0B3MGaiAO0h6Q6QxmqpnatJcL5BHXc0zQnwX4Zk7qe+iqnb0SUBpM?=
 =?iso-8859-1?Q?kwtiMarnfRkU54aCt9wWv/201knHnkeyFYlyC0YtSNSlIW0ULEED+G+R83?=
 =?iso-8859-1?Q?AWYmwkephCD/8sjFFPTBsNCjOug0C0ko1AjOPi/y5LCC6LOJRIXk6cv6OE?=
 =?iso-8859-1?Q?z7roL8GTvrmRLFI3Gvzn2dM+mLQlhgkYxWK7PXePS8dVuKjgu5Ob8ipSIY?=
 =?iso-8859-1?Q?hFFDPCAY3+cF1CgiAMdf/Wqri1NklpCfnVXptQ5pqHazx4CGz/GAMGofoT?=
 =?iso-8859-1?Q?aYLqdUyh050aLz53tpwE5WlAKooBskQVNrQqRrwCmOu9x0RWhtgJ6/IJ3u?=
 =?iso-8859-1?Q?t+Scr4Kz0/KPn0f3C8goLG8GM8uLInE5CWgcT6aGKX5jzDdGqCRz+uL9EK?=
 =?iso-8859-1?Q?zl9cxknM7pdjvlBWBxtIk6sQb/e13+v7Y092Khj/9q/PA9NIG6rmJpBt+0?=
 =?iso-8859-1?Q?7dgjvzVmTSRybB9lzUv1XpPIg3CH72XSAcRt+BNkpjDL2P/kL7ODiL+khS?=
 =?iso-8859-1?Q?0KjdoCGJvJcCdVwy9rocXQCp32jlYtMUTFj2AWxIZRs/WGWgPCBVNE60RJ?=
 =?iso-8859-1?Q?LNhaFLRYSMTJt4kOHKlDPCe4a+Jm9HVZQiaPReFSecVQbCIY14UkIlKVt5?=
 =?iso-8859-1?Q?dDdFWLqQDyJl2lQY3dZ6Ggdy1CiK11g2vQpnAZVBo9592uBTd5PPvPV03t?=
 =?iso-8859-1?Q?UNYFHp02a4yuWTWVlxFw4+iCFdrfCRvNnqV7kUGJ+E59Kw527P9Vy0hQx8?=
 =?iso-8859-1?Q?/GPpvVB++4Dq3zQ9+Yi7K8vOg1gn+NkbELYoRDqXyUFFY2KIxZKr/0+bT2?=
 =?iso-8859-1?Q?BF45WxORP33oftxl95Glm5sB2fvOX+q5yNPfmNt/0CHE5ZC7G6gv3Yc5Fc?=
 =?iso-8859-1?Q?D9KSYhNz9qlknu7KdOBXzZdIWPtzrKDa1KMkB4B+7XO0VBnAkK1h8XM/hw?=
 =?iso-8859-1?Q?X+Z4kVuY+uVZB0t0c1QPo81+kj9Q7Z+puIsYgSfuMaY/3lTfQJqfZuo+cQ?=
 =?iso-8859-1?Q?uyYjfmUmrBLobSDo0ncZ/fZSlV0M8c/l028wyJu4cv1QLOgBb5XRwMVPIE?=
 =?iso-8859-1?Q?P04XZtJblBv+05ZnL+uaxHm2OWoRStyiec3zcng4Rl0otokdW48sGWJaW7?=
 =?iso-8859-1?Q?wUmRWbp2brSwvp0wt5um2NCQZTBIsYbThaPp223+jDdHAa26d1vp6WKft0?=
 =?iso-8859-1?Q?iFLXEvsu+YwCK2wrs4SF+jpDX43oNabpO9TXn38SakDDvYThNE2nHc0CtB?=
 =?iso-8859-1?Q?zLr1fjoJM1YIIUZiIX/WsQDazrKkyHkqQAEEN6W4dQprLs+iQPJpZZgbkQ?=
 =?iso-8859-1?Q?4SfQPMMg/9tK0NJGL6wWnCby7uJKo+nJ5tpdAfZV1ja8LTycBt86ObMlOS?=
 =?iso-8859-1?Q?9HWKMsU0DSRxdi4fX4IdZ4Yqh4bMIhJM4/?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0918055d-016d-46ca-7546-08daf82d13b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 01:49:31.4000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i/WRcKakhBHaS7T8DRAyNDCcbmOlaYryXYCZvyQf6wlVqQs/h9DboQ+oEFZa6SBEAFfGwAWAIaCiIUakzbzHog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8581
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please ignore this thread.

Michael Strawbridge

--=20
2.34.1
