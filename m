Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BC1C54EBE
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 21:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjAJVQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 16:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjAJVQX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 16:16:23 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3749315722
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 13:16:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFmp2uLDMU89ld0oZSjQX0k6PwWZGO46Y7hY47p2wnv0RDclMMREohIUBBra51/vQU+T0Uav2wZfLc+VgI5C1caVmUPg2Gl5TjABT117CkgjXrsKKMjOV5oT/ReVoI2jrSfk28cnxFP22CzlFJuO4pX/7dSdL2ffDPCRICsYuUF0nQIzWKAFAdv5U5J1wzj5UnTt3cPEoCH5jZ8f0d4M8v6n8bBohW2VXZadTGiVYtz/1UFy4FJDGeaPhcCDH922SgHoPCumvJlMmVJAfJHbNsMfMtFx/3Or4dh4BMHYOg9pzYtSryRXim/RwKClGpM5R7B8X6MYIotjOeDO7lEtKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6g1BJMO7qnNN8grhdPS69fmOHGC7BWB5kalDZ2wHMP0=;
 b=Kb18n7bQhl+7q5PcQ0iPpvy/1r7PUsLJjaQEMfKsCVQLd0D2NZtaSCVsGgUJyFcfjnLYoENifCk1sHxlQw5rnt3CBNIjAkaGEwep/TJWdlCzMIy12Nz9n8TYiH1n9N3KQSR0wZvC4AKtAwDJKjHl4bSbftMARZ1sdcNgF77xe8C4Tjoi5bq+hMb0TACE3ccptFt+nIqb0Ph4HaHzJ8MpFDgpGQMOxLyDwILweD/3eL5AH6G5JAKzIzQ+S0bWQY4tBMsH9dq9eUXw6JSdYsjAe8Z30eyQxGrflnImOcxhK8LocKZhFkTiJmhUM9/KtdygRa21GbfOBmgtxXokpBbueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6g1BJMO7qnNN8grhdPS69fmOHGC7BWB5kalDZ2wHMP0=;
 b=29IQtLEOCHIrDqp/hjamGreFWW+LfubKu6qKnwI5LY6e1yPod2tYy5HK75ckyRFU3IIXQ1m6OZ3GDK6K8oCVxkh5oEyeHc8GEfsknvtVRL198fmnL/O0gthIspK2gUKIee/Ieox8stNUf6cqGbpEEiHyk+gy19MJVL0gP/CuFGk=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Tue, 10 Jan 2023 21:16:19 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::b282:6c4:7660:583f]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::b282:6c4:7660:583f%8]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 21:16:19 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
Subject: [PATCH v5 0/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Thread-Topic: [PATCH v5 0/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Thread-Index: AQHZJTjIEvQf9C45R0Sm+0R83mOieg==
Date:   Tue, 10 Jan 2023 21:16:19 +0000
Message-ID: <20230110211452.2568535-1-michael.strawbridge@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|DS7PR12MB6264:EE_
x-ms-office365-filtering-correlation-id: f4bea714-7431-423e-d02e-08daf34feacf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2M3Q6AsCBaHbpHMe0/DBteN67NDTguLCuEaElVVzrBVjWU/cXBvDXcBJlL7ks0wKbXorDO0EmM2Z46G5+ccgs9Cr3PblQLqtGpIpsgjpeX4euxr74da/CPwQIh/ecIw3JKHLuG7UUYb48pKVpg3V+LGlHfJLKMj+G+gYlMP+rbaB4bhdRVOCUV6f+SUFQ15xcM4A8ikxHA1402PBQJFtgmzLxdGdVYHL5sfLz3J+V95RXXwfzBFkQMuFIgMPGqBcdCdRaanzq577EnZM0L67Cib1thPHOfEF9mJCCFuElNLNuWUMzt0hmJjJ+t52xH2XBrk7i8btEjMQ1NcsYvzgC342ozzSZi0nyUcPoZJKD5ng6F46OL4y/Xc4ZwmiCTWwLGlbPWV4HLT2mQl34YYot/H5IiPUYd7nmsFL/0Kns5fD5l1FjtW/ywStciq9AKZTmiwdgCAeG1+KBJmL8wvkT5jOyj9miMoyQGQ39/4gSspXvlp4VPj5BRWn1GPmaN30YoWprmSEWam3Dw/cdMMdEOAMYReVgwg4G2vr6+p9xkgtbL+Uz6syDBLoXNOKA22JYyvRpubtnKLa9Nre0FM18PqXQr/3T30TC44kdW8IORdr8ql/EUF4rY6JHpjYgPXFYYL9PCTi11WgexJjJ3xna6nwF8qnh7xNcLVOVs4sAwocNPHbwM0IkB/9nuuxjcnwG91tRomrX3zSew1C//8TmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199015)(6506007)(478600001)(26005)(6486002)(1076003)(186003)(6916009)(6512007)(66476007)(76116006)(64756008)(8676002)(71200400001)(2616005)(41300700001)(66446008)(91956017)(66946007)(4326008)(316002)(83380400001)(86362001)(38070700005)(38100700002)(122000001)(66556008)(2906002)(8936002)(5660300002)(15650500001)(4744005)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZNSYu/lDwFEpIDlXbd5einkQToBRaiTlKK5IRS7EABERXKA6rd+WExtFjv?=
 =?iso-8859-1?Q?gygx4waE99holUgmPinnnjDNQy7RKejWWDoICi8vxsZ+gNxuWnlZgkGNvS?=
 =?iso-8859-1?Q?7wEGScq20wXGcyiM7Qq51lnT2B789LgmKPoIR/K/RouT8qG83cGQHh3pdO?=
 =?iso-8859-1?Q?BWZJGA/SCjg8Xa53JhXiq/VF6WnJOOj22XMy84OnRHwe3Z3CWH+FV2YDCb?=
 =?iso-8859-1?Q?JUWFgWVS+qift/0nX9QgC44vdU2+g51r6jBtqZMQfI9JIChIieUxebYHgm?=
 =?iso-8859-1?Q?fc/SzpyO9jj8FjbOK1zEMIGbXB6l8VEH4uF4LpVUS4Jcv4Q/gsIHl+c3Ft?=
 =?iso-8859-1?Q?fVpEyAldmZrIScYHVpjzwYFmScW9+sZ2psBxzjcxyBxPuCnle8WFco2LkN?=
 =?iso-8859-1?Q?TRd958CeHsLMaqBLQDavom92Z9hkiqF1LkP2x/mQkIY0CJ8CxlfaIsZTao?=
 =?iso-8859-1?Q?zhu8ZrP7QLjdQBYhXG6HZ7anfIA1PfwI+Nf/94X2H6gRBADiP6kqBmiqQ+?=
 =?iso-8859-1?Q?dBkGA2kg9niKh/qN3kFYgTfogjfLo4bk8yNMiQxUeNY4phT8W1WAg2Ha8J?=
 =?iso-8859-1?Q?73ojqz7G5hqntrdY2QlzWmvt6ZySPMmA/51NCNDM+MnSknD+nDmRALOWtn?=
 =?iso-8859-1?Q?hlqlrF5IyuDH3QYqdodw4y1XLypgRfI2DYFWzLSsWOGFtPLLFPVB+dVeY0?=
 =?iso-8859-1?Q?GCKUFaxK+SEmbDzzHiHIvDMn8ksx7YKTfPkRgtoVbVwZr9q7ct/BtiNqzh?=
 =?iso-8859-1?Q?RileECUUGjdEOi+a5ouO+7QvvEWM6gQNP8NiKWwug2zuD0aocPzLQG0CMU?=
 =?iso-8859-1?Q?KAVbLDDZZxwQgoWOH2dy1eLwbCV9NO+s6dia8EWDkwRWY50lbc6pS0kFXv?=
 =?iso-8859-1?Q?OYVg6A8DZZsysl6QFcUggzzYV3ZQkZH5UFCQbyZpVD7cVrs7AXUqALCdSU?=
 =?iso-8859-1?Q?fWKphXVkEDUu9UI0smxAxgcczwuq0pgO9ZM9KqzKtfegOhPehmjmgOubAn?=
 =?iso-8859-1?Q?hT2oTSqeYPyGspgErtWVFejomCuwpe8fsDA+zkuE07lfkTNV0Rp493vqDo?=
 =?iso-8859-1?Q?vNW2lQvdiNpI8WCe6SGL9+rxwOaA9wTUGA4g5Zt7Y+L7iEOv2ezI8JunRU?=
 =?iso-8859-1?Q?5FW3wXK67sCuOTsXR/rHzcRhIZ9H5DWvckZvtVM2X636tlITtXY+5sgB6r?=
 =?iso-8859-1?Q?o+/KIetN3RhDX7P0wohhZFm1cZYO4BqupakOZV2TxTYZrsonYQ0XbGktPA?=
 =?iso-8859-1?Q?y3WRDUbNZNscw2XeiFBpLk6jiau3PV2m7B9gF4SFyWA/rnTJvjvBq307hs?=
 =?iso-8859-1?Q?XcYyQX5WGREhtbBhoFrDpkjkCLQ711xGCmCP0sanTOgf3d+xcGIXF+r5cN?=
 =?iso-8859-1?Q?61KTKx7O8DxQeqD/EXxO5rRCMbBxF3vmdrFVNcAhQZoefVoZkQCB0rZMv7?=
 =?iso-8859-1?Q?OK71WS2q57+K2fZ8GhGAojDASzO0aBX6fmw28ppi4AnE8Zu1f0R+I6dj3K?=
 =?iso-8859-1?Q?4qwcLWGpNFPt5ufSCQSDkx2ZJTdQxA8mm1357BCOnpTqAyJXp/NBsF9GEN?=
 =?iso-8859-1?Q?UFH8rv2rUCN4xZ4S+cdH2pXbr/n5Etwvj3FxdL3OE2GLKWj7aQDWPMd0AR?=
 =?iso-8859-1?Q?Ra8t2TuRWn6qSKAXqId3MDxzH2EbZFdtaC?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bea714-7431-423e-d02e-08daf34feacf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 21:16:19.3487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KaHnkONT0wSHWbVVbGRx1P05WIL2xL2vKQ4jVzeZmXASIqka3EsZ/w28JNjWtqFM/HqrCeysTRScYzE+s1CTmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
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
