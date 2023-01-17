Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBA6C54EBE
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 01:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbjAQBib (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 20:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbjAQBiF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 20:38:05 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25802B605
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 17:37:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mc04w6ImqCkIY+ohOshKxCj2CrR+txI6WlwP8lX1QURctxpwDdKpaD6kSpT5OXi6FfTFcLiVlZ/qpPbt90oEEwRiCjwXmPb3WZeBVoqIRk3ODvcyeKpdFyLac56nSucO+uV0d/dZHZ2iQFyfpkAt0V4HDpkFMkzMq+VIPfMa7U0DHdg0Ho5ybuydOX0YnCKgU3YrNqWzE+Gr4GI4lsPP+MqlbMR2WVrIWVpZWxi7nCgOx/quk/dS/Rc77+C7eAw0BswL+HHT9AAPtX1PoEovVwnXb6HpunFvHY+fiF7R5YHsle3hmtzGV7973s44UPLx9R3lW9uoZdQJnwPLSFHkjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yA3Th6jV3Ue1o5ErL+un7nZdmd586aPROTdkhTf24E8=;
 b=IMA/aFuAj7ULs/XkfmAUgRWyh/ioFWeESw8JPf9rUOyXl6n1HgXo8StYX1EMkfqDnuoHT4ge09uGofdp7XUQPnUJMpoz1EAF2tOm+jOAZ1Q60ONTn8EbAGeZfEVQa11uxqqnthQezjgepuCpmA5jXvXovQtegiO+4jvdhVwzoZZJHQCY5KxJdVBa48fueSvZG8BRdR9r2EFmCNizhCK9UoHLDr/HmHaLaMGi5q3VcdX5SFOpm7G6ND2iH/0icweS6LxiBtBcsy/j2UDyjWEdzd4CgK+8njCkixmXFhiYy3WbUpAIKnBn6hTI9KM4OX7pc648BjKrsvLFRgYkuL7vhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yA3Th6jV3Ue1o5ErL+un7nZdmd586aPROTdkhTf24E8=;
 b=NsK4yU8ASOjPeDNtUo7byxtM6C4xVuIC0HbVaLntkAMB4+Gr2kaqziC5ZsBI/Ck8kPtf4PLc/dPNUa9Ifujf508fTzHc7SQJJaFN3Qo8XRrzSXyUIoPkNe3YEtKIYQU285TvO47pT6klt3Ot7FDU8zwyIiKLQqe9RJMdePMz80Q=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Tue, 17 Jan 2023 01:37:44 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77%3]) with mapi id 15.20.5986.019; Tue, 17 Jan 2023
 01:37:44 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
Subject: [PATCH v6 0/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Thread-Topic: [PATCH v6 0/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Thread-Index: AQHZKhRLDEz1KXXcoEmmvaWM9U3SpQ==
Date:   Tue, 17 Jan 2023 01:37:44 +0000
Message-ID: <20230117013709.47054-4-michael.strawbridge@amd.com>
References: <20230117013709.47054-1-michael.strawbridge@amd.com>
In-Reply-To: <20230117013709.47054-1-michael.strawbridge@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|MN0PR12MB5764:EE_
x-ms-office365-filtering-correlation-id: b2859285-46f3-45cc-446b-08daf82b6e83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tNRK5CDlaLr/VWc6+UhwvuQyp/TQZsRdqNd4oWig6XE1AxmlkIX6vDiKB3EIIcWz5AU2OB/0NEOcMAYc2HsEZQIZMdmFrLnOQTmUgVOfK6iUk1M+Rqq9gGWp9P9Tbcfh65uuAn4T+velgZKze0vYYWqElC2rk467HJGsizHQW+XtP13ueN2OmKmypVxpiiTKbxC9BdWNQWF/kg6koPT10SifS0HYqGKFzAFiK5ltbRVO3glwznQF0+pVbsB/0WA1VWG/KHEkhMsY5NIRwinKsEbZGuj05m04DlfhZQptCJI10bfgHccHiNMXK/hbw1JM8q7Jc5xjG1NpBUJS2H5cKzaas/N5UNsszzLO/8p1UKZ4yRa71Jo/ns0lEB3tAVK/lYmeYBMSaFlWJw75UHPAJwN+c+wbFjFZ7fclFT1KawiIHtkw0EFNTqFhNrgLEjUWN4noJsAr3iXg4rDciJUOY6XlBeNzoVpHEGlRUi5OhO73mxQOICjzmLq4Le9rLKu/wgIWJYs1ejYTfZbjW9k1eCEPzKhw4r+UERV8e61dSYp6T8ZqZonV95InWCnuT8zBEPBMk1ATqLWmjrCUbcftaIRd7p6NnMbNe8jh2+OTCnL7BjolXf56qd4S9Huncnm4AOHFVWjJNDpW8O3yeTb7YeRyw0zi58/rK4aAR2Wnr1DYpPUi6u491l+XZlOQBvnouJGJsvqmDE0sp3TQXR5tzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199015)(71200400001)(316002)(478600001)(122000001)(6486002)(5660300002)(1076003)(36756003)(6916009)(38100700002)(4326008)(15650500001)(8676002)(6512007)(38070700005)(2906002)(8936002)(4744005)(83380400001)(2616005)(41300700001)(186003)(26005)(64756008)(86362001)(66556008)(76116006)(66446008)(66476007)(66946007)(91956017)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0qIN5v2SfbTJuxCYji0vp7jGEE2xg5vftXOl+1tC34TDWUPsbrt/On2hd3?=
 =?iso-8859-1?Q?Ex0UxggQrvjrI8jS6ynfJTm1O6zfjIkJR0qAA2wxMO80SRVNwta/lgSZoS?=
 =?iso-8859-1?Q?JsZpZJm44Jl4TAzCt3O5XV0Yji6gBIA0wz/4zVWL2qHdzLSA2hQuivI2Id?=
 =?iso-8859-1?Q?rMWipTdwk4vFB2uTcN1JNbXZEdV/iBwVJNHOdv31AbzYrFx7zI9LsWoNi9?=
 =?iso-8859-1?Q?xBp+9h+kQ9zC2U1qzC4JO+Mc57I705C4Qxk1J3BYOvi23vopS7Vbb2V+6P?=
 =?iso-8859-1?Q?RlxKLGh+/EssD+LMcqxize31mj5Lp0U4glbGHmLLKSbi4mYnGvC6QiD0tp?=
 =?iso-8859-1?Q?DnceNQJxiUMOy/V0rECl/jyk+4szN9L6eITy5VvEmrWkbc6Xo+aywPGYMR?=
 =?iso-8859-1?Q?4TOe+HRwS0zG66c8AlRVXcuQBB8UtYp1n/joEzZN+mrMOTOmXg/U0RdBtH?=
 =?iso-8859-1?Q?6y1qvdUa6Yj17IyeS0zpHpT0D0ZTYzxqtsKJsxfctMHjN9SOSa0aUk1BN1?=
 =?iso-8859-1?Q?0NWiOn9LCXzcAKKfFUHxTGxTOgQXVj+NFIJULoWt1WMBdLdZnffpkeoa9Q?=
 =?iso-8859-1?Q?gIbzBV9evzW6KZwv70+Nb5SQaGJdGnVZevY93F8tJy3UnHnzC25CdTL4wQ?=
 =?iso-8859-1?Q?y7yxHSfkL6jQgN+lwJezqVZAERn8ftThldgol0sjFZNnA1pvLr3LK9AdpI?=
 =?iso-8859-1?Q?FHJ1WqFrTE+4HaK7RD7upLbH7/HjTmrGtcR8tQLQtDywqatBq3CY9L6HJj?=
 =?iso-8859-1?Q?v//Tb06wBT1xd8LvWh0cOm5C+k3zbH7hY9MD4p76zuhvmSWJiQOl5NqQU1?=
 =?iso-8859-1?Q?ZEQrEs06g79/mLjq2nYylOVAhwfP2Vr7EWN2glvpIoo/RBqiciny9y9HLn?=
 =?iso-8859-1?Q?FWRpFQX2s8reBkTWb3e9GcCuwnxP5t7y+dj2WitQDfwkZc4uiHkQ2rA6r5?=
 =?iso-8859-1?Q?D31jx+WdLYdEWgIHMdr285QXaWqW/6PKk+aWYcGy/+7anhok6Gci1aVgV5?=
 =?iso-8859-1?Q?eBZEHOVV6QRBpyG8HCux2J7qUTgRW2x0Cqh2Ngq9uC4ZAQBVAboZM7prln?=
 =?iso-8859-1?Q?x7/ZDkcrcDy7BErrBdyPVtaLkETl2vSuu2Nn744iLcTco8j3wSjdaeBy3G?=
 =?iso-8859-1?Q?IpQatLc+gdL2UExY+UcmbzFtcQp0HOE5K8YD2afzFsTlBDSJIMjCkzzBpH?=
 =?iso-8859-1?Q?xJvNEErAG56hnxl6BBtWTweyvP4Pzv2x6g+7Hhfw0S6PO/s1XM1m8YMmX6?=
 =?iso-8859-1?Q?TRBOEuFGc5v6MWHRNlv2dOAncI/pkLhY8u7aF+/n6uqnudwH62g0U9J62w?=
 =?iso-8859-1?Q?6JvHzHhx9hePm3nUw8GAATBDaK+o9cw+skUVOBJDj1tP0JagWQHPuc0uJ5?=
 =?iso-8859-1?Q?JlVRqkUIwooSGn/wdESY+IOcDyyNA7dWgpGwVXnLtHSWppxjh9dfg13INo?=
 =?iso-8859-1?Q?Yk4yInkSkPfI3CHt7OVbh+FCa8eTZnNw9p1fYoDJaDCfUcFMcp3xWq2MM2?=
 =?iso-8859-1?Q?us2ybUqXVxVNnu/kThWAHKpgqom8so0yh3N60ryd6CFOcvC6awpS67ob/+?=
 =?iso-8859-1?Q?HFcQKexRkTeX0PzTfl+4ZVep0s/BT0ZkkKYIsw1TCGOZ72RRxrZOo3lU0B?=
 =?iso-8859-1?Q?2UuBulj/B9h35NBjbBefzMNbytOeJ0qig2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2859285-46f3-45cc-446b-08daf82b6e83
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 01:37:44.7412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qEiy1cax/ERAFSybxP26VRpTsDaefO6foCNeLuKofGCPv/5WZK+e/FjUOduX5k6+XVR6qhSoKmMHAQrh7rb8zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
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
