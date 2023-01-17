Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E843C54EBE
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 01:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbjAQBkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 20:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbjAQBjo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 20:39:44 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C6D25E36
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 17:39:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kf0lpCe0pwg8XQ9zYVbjTYxg8Fqqy0v71sWIAHESNRPz/MOaf3SyxDU3vS7juL3OdqZenmBRmDA7hOCDLaBE6uebrjhizaOI1JLu74hD7gzFzLq1n5mAoQprfnJkxzq9S5LYVlhCOMJM+h5nohdumLsf8y1FCF57O6qF4Mdivmv7n4r3PY2A0O/WF3LgzBTcOtoiR+mnEqalWQuVpggiVmJe4zxaxaYa5ez1HXnc9v+zCAcsRzJ0RkI1AUGQt7cCkAGPx5RRWMxb0QQyUF9eBshFqOqQ2KEKYRVtWfLgBfo/2HEBO08XfIxv/4M2Cd/8IPlskSJ9CrS96tcNcHcVqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yA3Th6jV3Ue1o5ErL+un7nZdmd586aPROTdkhTf24E8=;
 b=oWpubKIBWdV7eDvBq7VgGSx1MmiKmbDePdsayrD+OCGOE2n+jUY6j6hFXzhNTOtikubfLzoHpwlwAAAFk8DAyA7JvIK6RwRZCofFIhBpCWegeWtR4PNdutXiKTu8i1JmQeMnkftL32iaUYQ5+fnm321q4965RmtFyMoywPUBiT03+JUc67IImnphhl8fwJNhmn7E8FRuswATe9UdWDD1sDVCds3quzz4TZqAfuQxxc8rrB78q1FCM9ldVhkhZ5WI48Y+hS1gkK+u6q34+naNJYG7JM7WLZ8a8JqWHicIvJcz+KC6Zp6OhU+xRzGGVUpoPp3zHTqCuCeP0ctrTTrV/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yA3Th6jV3Ue1o5ErL+un7nZdmd586aPROTdkhTf24E8=;
 b=3n37Ojxyq1Ew9xGXN+5rWg+JqD7JNhWnRHD9TiaNkrPBPkI4zjnLKyVq3KHVFIAfJlhf4Zmw16OA3ETQdcDYBHo+LPcb90j+Gkey/Cqccy0Ra/b8Az+juHBaPg4y20+5Kv5MiyOcJsHpcom2f8/x5IWJV+gsv0IxOCHetvxkjVY=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 DM6PR12MB5518.namprd12.prod.outlook.com (2603:10b6:5:1b9::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13; Tue, 17 Jan 2023 01:39:40 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77%3]) with mapi id 15.20.5986.019; Tue, 17 Jan 2023
 01:39:40 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
Subject: [PATCH v6 0/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Thread-Topic: [PATCH v6 0/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Thread-Index: AQHZKhSQO1C48D+dOUWD5C6sz+HTAA==
Date:   Tue, 17 Jan 2023 01:39:39 +0000
Message-ID: <20230117013932.47570-1-michael.strawbridge@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|DM6PR12MB5518:EE_
x-ms-office365-filtering-correlation-id: 087246ee-df48-4477-d827-08daf82bb328
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cM3CjYvQmawye7v2lckBgN/vymMpuldG9dhYFxQZVoVprJbRfce5rnkPIWHcNApkH6QUz5ibfWUW28P2SUwC3yzVCk47VUb3/DxAtm86bamT4pBR4NrYpnM4y8TNERSbWGype/O3vd4raA08oAJ9EGqKleE5sM1Ue5OO+sq0h2TYJgArAzPEdv6yL6yljeeaGc4vv6SdetcrSdIRgiLtHsOuCUN2p7EX74+fFN4e6RnzANGgXkIEJSf9bPBkDNJlEfjjUu1nyigKwS7/XimpBW7BU3RSHYMviiUf2DjtfcAiH4wavU+eKWggiTWLZYPvI5j0W9GJrj6qpcHketH9+HHCXIRCjDWMXpe3id5xzE+pE5ny2w5H+LPfLlJEGcNJAtfa82NsyRJNgdGAoGsIILp/MxzHfqyfWLoiQ7ippLmN506adjFbXLnrmdJNKWO5tXaFukg4NUQHkvriZLVRP2Bp5249140p4c4qzCXtTmH7Fk4AZW4EFGhDrt2pRXvzyzSdzHnbw7vAqUjBXYnUi9RIRwdajNkUDtRUso1VONK+5/mrLmpDxEuVxa+cSJb+8OjfDnx4reoxRSslX3Mm8AKtaWopgY2PbMKJmyuIj6SnqykItn+DPe8LhYcGah2AF2bxQv35T2SBu9zuiLr7/VMb01H9IYKBsEAVpBaqI0/kO3SEIa9A3rWJEGL2/QFEetXcaokTOsA0qlWdI4TC9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199015)(36756003)(478600001)(71200400001)(6486002)(6512007)(26005)(6506007)(15650500001)(2906002)(41300700001)(4744005)(8936002)(5660300002)(316002)(6916009)(4326008)(8676002)(91956017)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(122000001)(186003)(38070700005)(38100700002)(2616005)(1076003)(86362001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?D0+z+sVB0yAt7ajSdWDiqGqkK2pUy9XdCWFoSotv4f5xK2CUEbdlPWnnz4?=
 =?iso-8859-1?Q?b7JGz+842sBn+lAXAxgBUdZ66N3Lm3tHPdeBMdFA3COyk9zHLKqSNgen8w?=
 =?iso-8859-1?Q?m6A5au1HOOH45Bhs0MoTfNk289h7u/DLaL6VIEmaEMqEFitzcTRcyh2yej?=
 =?iso-8859-1?Q?xiUaxmi4QnCNGO8jDobKF1V/T3+LUED4Llo1ukzjYP6AgxrRWFpTf3bRVl?=
 =?iso-8859-1?Q?VujGzwrf1gT/RoMowM+745YX0uAnFhP7Joz8aDXY1S59aRWf/BAM//+2Xl?=
 =?iso-8859-1?Q?lswLob5uawXjtHDiaWok8vz6FuKHmSYUUM+yDhI7cZcTy9JYX3MZWNo9Oz?=
 =?iso-8859-1?Q?Zu5GiLaVtQxvvCSehv4+131SfNMhT0950zZlzz97wOQSeBgWrq/NtpBVhm?=
 =?iso-8859-1?Q?mLRpwyb5qVmY6HlKl4r4w1pGmc7lSDF79khr4rhR9HRCQBFd/ezDW1gt9T?=
 =?iso-8859-1?Q?qAVN/6fctwOMB+41ZYmXJzxLh+uUmOZR4GLZpU4tuZ2lOuyPkcCy0RI0K0?=
 =?iso-8859-1?Q?vUSqWzBzt48/PnmmAsvPJxNxepEgjs5lh1ZxK2N+y+eLuqte+eHCYQoYrA?=
 =?iso-8859-1?Q?DFlvcRkrrnatykZ+VFnDF/Xud3GfFHQoA+nT3aFPlnPQzV30TsAn8yARJe?=
 =?iso-8859-1?Q?rKpXoMIVuIn838Gx68c7XkwRYxYIhb0xjzqAZDfBA3lvFuzaKrBKr/VOUO?=
 =?iso-8859-1?Q?LcRKpo/BkeMEabeAdCg9sKVrMYbWTChioJctgEw1dpUEgoVS/e5Pfmpidu?=
 =?iso-8859-1?Q?RFmcGDO/O2TcsUUhBvVc7XDI4ayeJJUnIBYr1l+prK6tTouBYIadRWasak?=
 =?iso-8859-1?Q?3GbuWEtBcdmS/Vcxji7koH3iBbBIRVRCyEfBgxgCIq9OOBDhniwMMogcqp?=
 =?iso-8859-1?Q?81F+SgXZVs3SB8jJAwL1pYQUh8aCEdgTUtgC54JcEgy3b57jrQCLrIcBph?=
 =?iso-8859-1?Q?VNRaWJJ60ZGQ+DTwfAVfm8JNhSvU53tTZDIwopOa6aP1RWtWl2Th319sVt?=
 =?iso-8859-1?Q?NkG/lbRypEyh2C2yaGxcBIWmxWBqPXkpjigvkYo3mCljq/X2H9XarxUCR0?=
 =?iso-8859-1?Q?w2IZDIWllSIkhW64abB/w3IYXXJMi8P8zzC5mlfszaeV/tcl6SwGaz741+?=
 =?iso-8859-1?Q?m3gcyRmFtSgC5klo21PYAFUW56ld9iRQxRV8DjUOST7lY6ioSOlo74JwNt?=
 =?iso-8859-1?Q?P4zhB9UsrrkC9P5OyuE7MNiwLlRxfkz0C3CypKO+j2k8nXDLEZ8b8LoEqr?=
 =?iso-8859-1?Q?tnoV3tS2pNe5Mp0AWOdRsAYSHaQwRo0yVkkWZ0LVkmGgo0MZR7aIS9rJZU?=
 =?iso-8859-1?Q?uVGdsrcfauE9WbMqwqjdydBpIAivFJdgo190C19L40EieC5slAO1UAPChm?=
 =?iso-8859-1?Q?BhoWqNwmcgENvhLbxRKvYPhFtkckgaZTuUtoBvBxarts67fk6WFZSDKBhc?=
 =?iso-8859-1?Q?IXC7nuTElf8FWYHOkJEve0EJsLzpJwbJSu4ukjwr6pQc3xuRrhArtrarga?=
 =?iso-8859-1?Q?LAl3ISGKNsgJQegFPUzefIh5k3nynJnDG5OzHYlcrk7yW7cBsLdbejJ7kH?=
 =?iso-8859-1?Q?3OexJnkgnJnPnFQxkVoLcl3h77g2KJ0Ot+kQAaB0ciPC2rAjcXWWintyUA?=
 =?iso-8859-1?Q?RrbaNHaa39ut8f+g9kZektD3rJwt2LN8T7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087246ee-df48-4477-d827-08daf82bb328
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 01:39:39.9114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NNXKKAjPOFjt9rX9mAOTvVNuKdqOuD/wY7l5ZVrYn0ok9SyEUXTjp4LyuVV9GvQqsWbtf0WDzjAFB70n46MgFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5518
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for all the great feedback!  At your suggestion I improved the
test for the header argument and the documentation.

Michael Strawbridge (2):
  send-email: refactor header generation functions
  send-email: expose header information to git-send-email's
    sendemail-validate hook

 Documentation/githooks.txt | 29 ++++++++++++--
 git-send-email.perl        | 80 +++++++++++++++++++++++++-------------
 t/t9001-send-email.sh      | 47 +++++++++++++++++++++-
 3 files changed, 122 insertions(+), 34 deletions(-)

--=20
2.34.1
