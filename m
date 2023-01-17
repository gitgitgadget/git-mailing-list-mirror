Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCBCC67871
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 01:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbjAQBhb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 20:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbjAQBh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 20:37:27 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB5C25E0E
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 17:37:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G54LfWsi+pVHDwycPxJ5/6/Kld7qsAuN6ckEHNW0WECDNRoFyjuJJUCn7cex3MaCuITdKNFFxYR8phDiIQV65QLq+rv6lV5bb473m4Ac+2ob6bEcbZPUx7nKIo1ZdIS26oR4tI9RY7h34wn4xcOZe6LFG9TMqEv8crIpbuMP/T6CqzSIHUARS+nUhVqYpK+Bglx7RnO13RFiwx3wjJnxdohkgn7YAL6iiMyY8rD/dgp0/bc5ScWSE6n4gXJbGp1K1CU3xi/svI4ET//AOM39W8kw+x8kk5wLcPrDfL+NUIZQdq6gq4WcTlz/wNSPEzaE+QQlj5MwtEEn5SXIlji2zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6g1BJMO7qnNN8grhdPS69fmOHGC7BWB5kalDZ2wHMP0=;
 b=mG5lVhSoSeEQPGkNKdUAoCd+bOvyKfbpNk/WtHa+hZ0aKBFmIXJKERt1BQe7m1WeVnu+tUdPHYzfdhr0vvrU8ZtEgR3koeuFPMTKKLUmx91eodQe27iEyVn4H+w2X5y0D/sW6fJu5JlfsgDWgxE7gcJNjIFL03rO9FOfYuz9ODfR4lGx6f6M9xWMIBM8m0gcuZOz4ml2TDjq7zKDOh+UH999THI+2V2s45lIEP3bF8RBm6fBO2NKcdxIgH6owyX0z5y2CZxjPzKphyFe6sTt3DF915NUnQTzNdp2sIo9wRSCFE2cCQMIKB0vFv2OdyJM3hmBDcsQMZ4vf/LPOafdaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6g1BJMO7qnNN8grhdPS69fmOHGC7BWB5kalDZ2wHMP0=;
 b=Vz1xKFIgAqMNnRJMm7Ed4laEuHNPwEsVDjig3wjye3rLnoC6qab61ZB3LTEJwckMUTl15yIp0xew2j8IffOH7nmURpxO7/6ZI1EocsH40+JPCPykNQGBGKiHse5hc6o/9Pazf31dgjE4kF3ZaHfnXuoZ43PeHhBKjqGEHHA3rJ0=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Tue, 17 Jan 2023 01:37:23 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77%3]) with mapi id 15.20.5986.019; Tue, 17 Jan 2023
 01:37:23 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
Subject: [PATCH v5 0/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Thread-Topic: [PATCH v5 0/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Thread-Index: AQHZKhQ+oLhqeiEshE2lUcnWXQsshg==
Date:   Tue, 17 Jan 2023 01:37:22 +0000
Message-ID: <20230117013709.47054-1-michael.strawbridge@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|MN0PR12MB5764:EE_
x-ms-office365-filtering-correlation-id: 082e6591-11b7-42c3-b689-08daf82b6195
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x9A2+uVD2538MOYZFFLIYIVw4N5D4wAiFIUnkkix5X2hsCYiQe+SIjNmnRVjRMlQenVttwQXtDuMZSYxXt0a+3xNIElUpEmA6QEDZvNi5LUmo6Klb4m3yJ/Yz4mS3mmKEq/8sHMSjpRJwuEm5kc5A07k9rzSIPX64lI1kQy6YQGdP2+/bstrODFJwWyrsQMs0mCGkUkvD+ieGNOxRRMq2rLGwByBc/jNy6ahgrAIR7Y+nF8M7XQ+k5O3aUGC1cANKPMTW5ie2Z1jOH4IevRFRgG7fL/5Di/Pibw+9YWOj8CQ698tJd8OmdElKosHSVCpZBmXBOeiAVb8f4gv3EZKcwCpMetsfHd6EBrPM9YQ81qEYKRawbKLYWAgxq5V9E253dSDEKs04fCJ0j5nIrOz9gdj7jr2ojtN1uoosNk/k0Cj3KWLU7b+kX9J4L3bsywth0TYoXqvmjGDswCT4fZLKY5QALkqd1LB6ympvOnBCP+aXdwJ8OQrl1upHX7KB/TQGldwyDS2D6GhWDfVQd2qxslogyLQlghsBSkrUINfkdkaLOG1j1IP73hZ/4RC9VIPh5mwhMK56XYT91kkmXAcOfAfajtSX/auLqPAnCTEA6SDYL78jbyThYyVQApZyn712scPr9c7v99+xv61x/m+a00o8vaasElNoJE3wHzj4oIXW6NjrYDY+jU802RyLVEVE+IGOVzv0n/qR80BOGheTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199015)(71200400001)(316002)(478600001)(122000001)(6486002)(5660300002)(1076003)(36756003)(6916009)(38100700002)(4326008)(15650500001)(8676002)(6512007)(38070700005)(2906002)(8936002)(4744005)(83380400001)(2616005)(41300700001)(186003)(26005)(64756008)(86362001)(66556008)(76116006)(66446008)(66476007)(66946007)(91956017)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ozKAhfenIa/bxPKN5SqpLkJS256QLQHRH3Zekj/XQv5k7ABQOGjDKmvmMt?=
 =?iso-8859-1?Q?qJqMd4jj6ewPx/sVzJoCe//J06B4L60bU0iTTBqwHtwFPiOigBKuksYCTV?=
 =?iso-8859-1?Q?871KTLyY/47oIE/n8wJDTlOJMiAQezRtEb2Bsi501AuiHXd0vhUuBpNOPX?=
 =?iso-8859-1?Q?Anp2iA9flNV5Y9tKAO9mdt0Sxo0/O1oWlkZ/csonefGs1wTv/iaFpOYUlF?=
 =?iso-8859-1?Q?bM3bnMY38g4ega6FWYiu9/n2lL5MT1wMFwBDZ/UV7jkRlF5T1hA95y+zgg?=
 =?iso-8859-1?Q?eVY8rMseJObxZHDEkM+nIzWAJf5ADLJA/xh/crSm/RnYqK2WkN0EY3EoME?=
 =?iso-8859-1?Q?kt/qFyzA1dERH/DF2Jcz66+c+SvlVTuKArCY8DfhpU86R7UQLLWzREnhx1?=
 =?iso-8859-1?Q?lE18R+K4MFIVeCvmGOxJKmuabnyInFH9BR8A73LCpz8M5o9mNnN1M73cJE?=
 =?iso-8859-1?Q?BvItqlFU+BQmhNx+u42aeR0vCTT2bqZFQYn4uzi42zQXgWBeOIej8RY/ER?=
 =?iso-8859-1?Q?oTHRS9yGoOhE939bJnv6uZHzUes/5fTICwLGDS1sqBO7MYqIusZS6e/b06?=
 =?iso-8859-1?Q?y9FAR55WO24OLW0oR0VE3SYCH2Q7UqUBwtFl5Tfj/gSCporIWAVImtvKRY?=
 =?iso-8859-1?Q?WsIfgoplYHagXKjAVdCoLHkBk6VzLZ6gsMbeoSpxBq5y5Z/S6J5f56q425?=
 =?iso-8859-1?Q?LMqc/vMNwfTCD8B09KnQCEyPuyxy8FetJajffRlw0qvU0KrJSG+u3QFNiX?=
 =?iso-8859-1?Q?IcveAtkmUMszfuVQB+liFrrcM1pCrXB2In38AHl8juqF0o35DhujEklhLX?=
 =?iso-8859-1?Q?Tt0QL2Wwg/XC6MFFhXteuDwS/DgX67JubazQksHZ3kKwVhTiFXYmc8begc?=
 =?iso-8859-1?Q?e+aYr8mrvQtEFz53UIQXnCssNvF5O3PxfD9vCqnXtET9raL82mKHOWHL8I?=
 =?iso-8859-1?Q?E+Hwy3+mARthvukRZ2mnHfjMtxNLIiSX0CZw0XlQ3aeWN9fvpJyl2lRPK+?=
 =?iso-8859-1?Q?+MD0y2Za5eqdxMf3qX9xIlYmL1m+1wSJGxMuiINsvmrD0/08hLi+M1JDsB?=
 =?iso-8859-1?Q?oI+wU/zr+oRgds44VlEFB0E/qz3W/3Gh9yaBde8RbNNhWBl9pLAJGRwMiY?=
 =?iso-8859-1?Q?c6G7+5u6E6XRJAGXtuyZJsUgrJNdioc6hJ8t4970wcUokDbae4ej8pc8ba?=
 =?iso-8859-1?Q?/w5BjluqLhKz1lzwt6Lr9LXdLLoNBkb/sDYVemU9dTyaYPDHQ8mb46T6M6?=
 =?iso-8859-1?Q?xRA3/C52ZJQOo3m9Q15vyc/jRhavhqxNNI65INR4BfpjaSUYJa4/MBYiyp?=
 =?iso-8859-1?Q?uOzc7x+xMvnEcHPRMuZHxTS+trJfMrz/6zJiz0l0pbzT2/dUqwP9HkyHsv?=
 =?iso-8859-1?Q?fxWgclZ25tpxfNTLsfhMDI7BtU4fQmrSNOXJxXTEf8/3xeFcQ+ClhkbQ8R?=
 =?iso-8859-1?Q?7CLklmoEFpJjveB51nCx9qTJVAZN4rVi8XM0cyNBNqiW1xT8Eunwn1aphQ?=
 =?iso-8859-1?Q?O3xR2TUottzKDtFGS9P8+Mdtg4/YJn0lxJw8VGLXGIYC7MoJAPxpvvkmEd?=
 =?iso-8859-1?Q?GhKZzxeOFhc4NSweVrRRXUbJKcav3B+/gsV3T8gjMpNeuH67313GPmm5Gw?=
 =?iso-8859-1?Q?xGQvjkCbEyNUDIHIPPD6nS9r0vqDul+hAh?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082e6591-11b7-42c3-b689-08daf82b6195
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 01:37:23.0361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: agaa8FNe+hFuo0BzBG9O7qIoSIiV3jw7p+7RtwBpS4s+BdGPxVIcRX4KpQhF1sUdAj0+UsSpR1OcSGN2+37P7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I very much appreciate the feedback and believe I have changed things to ma=
tch.

To answer your earlier question, the hook doesn't need to support multiple =
header capitalizations (ie. only Cc is passed). However, it does need to un=
derstand that lines beginning with whitespace belong to the previous header=
.  The header information follows the same format as the confirmation given=
 at the end of send-email.

Michael Strawbridge (2):
  send-email: refactor header generation functions
  send-email: expose header information to git-send-email's
    sendemail-validate hook

 Documentation/githooks.txt | 17 ++++++--
 git-send-email.perl        | 80 +++++++++++++++++++++++++-------------
 t/t9001-send-email.sh      | 29 +++++++++++++-
 3 files changed, 92 insertions(+), 34 deletions(-)

--=20
2.34.1
