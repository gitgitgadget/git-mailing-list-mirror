Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80E9C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 10:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiBXKHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 05:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiBXKHH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 05:07:07 -0500
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00064.outbound.protection.outlook.com [40.107.0.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31B99FD4
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 02:06:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWOcBBOhOjloUhazrkKbT2QcnqyHuQyUQpHWG8W20R8GBMyQ3x+K1tEaeH8JuNTy9TIKuJfVwsnpIR0kaN6sh+24cJOms5sYsITdSlw8lHjbSiYSO14euk+jKQ12aIk8+9589jKBGxyEjge9L/ic3x/YYR86LBo5xoDwvW1E9/0rsjkrvrlPPJetBm2Lu6VelXpVrMg7LByqCfwNZ/22Amf41ykX9fD41t+0XqKhnVJmH7gYktEneTcp4NYjKgpiFGa/byj9VwDShHvZyc+ma2oAhHp+II4nZzGlgV4jHGBvfTFcqwsHamyZQ7LQvJD45mlSGos4weSOo8qV1VF3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dbjYIUSUiqVyL3Lcz9VDfZyMKEuUxGhxOkyXLF6cmw=;
 b=OVwEDQOAEM4mByGKotOl2mI9ms2wZIF11pcK2K6ZFUrkDSD4yV8i6F7qgMr7wubg/bbPVp1ooslIb4AUoh1i9Sk/unGaV9WGL/qhL/UoivlQyueD0lEliAD4dtjrd6FnkiPd1Ju/1WAkdMhR06s3QsHnTajKcb5Mb0u/yT99SU8zgaFDdttQb1/HYY0/Y6o8+BhkZ92xvm22OqbEZv8Fmv3I6QQZxxsjWdwPKdHU8Qzs94G0jHao6PtpXbQsxiwGsI5ww7lj9T7rwlDnVBBuZ7W3+nqww/UvUSwBRPcyPWXNnzlFoCQ4hhegTvmdzk6DaISV+JUL0DOtPu/HBlvZNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dbjYIUSUiqVyL3Lcz9VDfZyMKEuUxGhxOkyXLF6cmw=;
 b=RMsnN50HjeBYQt38mGBS9+wEnmTs36AEg2wXo9ixWgJBPI456DfOlTkJH9tI0CIk5aoNQ6WTbBVEWTdFIdtsjklm3IeLZt3VVdW7wpE3V9oaVhWFA0UfakisiR1tqETs3W4PDUWawh3dH5qhjWOK83wS+IAQJHKAR33djJ9+AlM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:42::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 10:06:34 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::116e:6242:98da:22ba]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::116e:6242:98da:22ba%7]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 10:06:34 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Todd Zullinger <tmz@pobox.com>,
        Henning Schild <henning.schild@siemens.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] t/lib-gpg: kill all gpg components, not just gpg-agent
Date:   Thu, 24 Feb 2022 11:06:28 +0100
Message-Id: <20220224100628.612789-3-fs@gigacodes.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220203123724.47529-1-fs@gigacodes.de>
References: <20220203123724.47529-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P192CA0060.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::37) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33deb776-8103-4dcf-f88e-08d9f77d5666
X-MS-TrafficTypeDiagnostic: PR3PR10MB3898:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB389860E1C63BB4F2EBE0D004B63D9@PR3PR10MB3898.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQYwNBG9MJCiJ6c40qE8aoWakdh0NgvlvJG25QwOl6N2oxVwHA7sMAD+yBGRasqN8vtB3aWkJnxO2xGqzv+9aFGmaRWv58cdcsL74VAAh9c1QBFtThOH+9l+6Wz3FOntAabASGSKgXgwnsLD4iK0q642Wz5Na+mdnQxGvzNES3geNTuHyOkV0r/uS/vtElVarcNO0rphBWz+6GfH3MO+Wfyha6sCsBiwDewxWn/hIx1/oFEdYACEheIcFkpBv4NdqE+VQ/N+jqd3pCIydz2woAISymHJGkglsZanxLtUl5lE9ZhsuXIqn+/Tq1/GStu6z48H+XJlW2dfVpFPa8K3oHGbn0F5ANVOkg++NdAG6IpDLMHoRpKOtzAmiqHTxh99b0Scm1Q3+zmQ3SWakeJtyfY/kyutK3w8mUPLUFmlhTk/SQee51xU060azM1M/i6y47FWhHaqcZAFkBLX8ZGpuRnLdKtqK0EnObLM+EvZ1EBdJtADuRkDgtOmGAKGRnVWWVJjlXnAB4pN0RxxIn6XyBmsD25vARzQhRas9ndDA/GXAFJA7qgQeeAoL/v1R+Dy5XCDSJ1U7jX6/MXb2nM8DVcVO0g9OMXrel0R2wr3IzRqS1tOXio/UMXA88kX0c0h1Jdsvu7SFDyElXKPP+MDuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(346002)(396003)(39840400004)(376002)(136003)(6506007)(6512007)(6666004)(86362001)(83380400001)(6486002)(1076003)(508600001)(2616005)(186003)(26005)(8676002)(6916009)(316002)(36756003)(38100700002)(54906003)(5660300002)(2906002)(8936002)(66556008)(66946007)(4326008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ac181Wk4OAl1gTiCsCYqsA/eTWaAYRQbdbPmw1hTiMRxyWUhTHMm2A/4Wcp2?=
 =?us-ascii?Q?KkT0AIHz8Zs5mzmC1+dNMfl1jRk3izR3u9DXfmmsZRzNK4yF+p7tRSrLf6He?=
 =?us-ascii?Q?+LWdtTcybqgxrwfoA+IGOIW7RjMXrEdtgjY2rXHpPVDU7byIsGyiEbRfGbAL?=
 =?us-ascii?Q?SamtcFSb9EEPQdHXgB6DvRPMddZkaiocSAZ2NUSy1ahKUOWjWmK9+Y2YZedG?=
 =?us-ascii?Q?K+M8fJWpkYprJAvkGtN8n0XDFSex3CZe9i0yaQWeI8rgzp+KT0f8VknFEVB7?=
 =?us-ascii?Q?BdcxTy/LpIx1JF2PPzgkjRSDZ/MPDOpeDLNIUs2EeESqUSN/m7/GBtApsryt?=
 =?us-ascii?Q?K68KHdQo9dEw7u8m+Mh9oF81bnJjxVOiKvw0vZBKnO+JR4uFEuID6ySHWGrX?=
 =?us-ascii?Q?t2RrOuZ/w+a7F+CKHWkCqq0VdA7cTvOBway1I5+q95Cp7+rPBLs+4dqGiNFM?=
 =?us-ascii?Q?MrEZauD0igVYGqURu4CCZGYwTJdO0bX+i5E5ILxVKzae3m8m2p7svXcRGVf8?=
 =?us-ascii?Q?b3YysUl1Ajqzfjb45EBW9NIxeplR3L/yc39toR/8ZXXph8VdvzossM8/XspW?=
 =?us-ascii?Q?RhFTdpaGkQsMZWHIjTQW+gDRFSPtmyzaBmc1JsDxIiPxCw3lkM2mK3l3Gh7z?=
 =?us-ascii?Q?H8U745gLbBTftCEw1kQj/VnGjYMF9w5Q/ycoxRMsqats3Bvir9s5t8EYwOq1?=
 =?us-ascii?Q?fqePKbJMplVIOfNSIrjd7bHrS+ufzmFXTjBUwXcj6jdbP8ZvU1UhoK2vuk4Y?=
 =?us-ascii?Q?NLTCU2T+O1oyQdcBJ1F5MP+AETk5Yh8guXEv5ot3hDzSpTbkX1hJ4Zv4zupm?=
 =?us-ascii?Q?GwOaxye/OXkmnCj0V+zGWJl/0QTHFYPwqScF23QCNuvASgEB5Eglc0jaQG5i?=
 =?us-ascii?Q?45D9r8B+UexDTqLcK/3nDWth+Y0Cxd2yU+nBd6LEVzo0m5F2PuOw0IQGiHQb?=
 =?us-ascii?Q?Sq+SgGwieGvJ0fVhKRervVXnkHTfkuhcy/vtBL0sfc9JSsb3liB/JHwsCOQ/?=
 =?us-ascii?Q?UE1nWHwVALbxMTcCvbSLb9ErxUaXKjvMnHNqUCnJdweR1pPCMHfCt+3Qj+JM?=
 =?us-ascii?Q?ZmBVBB/tOEdsSuOSvsdNwhRQZBejwmWI81eTxLzLubPUhxIGHpQrvaDsyg7c?=
 =?us-ascii?Q?8tCf+jNhdRvaVnRIQ5IQX9hUUN2nwgv5O7D4ht7MQXWGIevNtmFPYgljOu3O?=
 =?us-ascii?Q?vLJmjgD0LvvzvPRP7atijLHYOINnD/PIXtSFzKig0Q0wseNA7lKrH9SbqytZ?=
 =?us-ascii?Q?RkkRhdynnQMMfGXT98bWCeW1x5cvrDVZPL3vrC6tivXcbZ4HDZDY4xl+UPsp?=
 =?us-ascii?Q?bVIWbbspWf0WOCEzp/EYRAJjoitkX83P9Wdbk+VmI3+nOv7tx1x/nmpbgfUA?=
 =?us-ascii?Q?Rpv9lwvhc6EF0ntjQbCTEgTfmnJ28ArOzLfeiJwYUo9amzQdbNZvOVfz4gkw?=
 =?us-ascii?Q?33bk87RdBHWOH1OgkKwe+w3i50zyvy8PgqqWchC3onsbgmUfynXdvYGvjw23?=
 =?us-ascii?Q?brMknUzzQgDuqheJWrUJRO5QE/M6dL2HKv+2eSCF2sihINp6nNn6VaQZIdWO?=
 =?us-ascii?Q?n1uQq9hn/U1VWDAm1xNxN1ZWS4rbj+ozei1rs2cbZiHzipdzlQDJ3aeV4Rnh?=
 =?us-ascii?Q?mJUuct7UMgjd4HLSOF+S3Z9qJVGVU35ikrCHv/K+JpJA2DmghQYFCKn+4u8V?=
 =?us-ascii?Q?u7AOM0DdIVgM0GtKrJEHT1iu+rM=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 33deb776-8103-4dcf-f88e-08d9f77d5666
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 10:06:34.3447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMQoathAdjiq4n2jrYEWyZQLZyYbpjY89T+n8Rg9E7zq9c4fPY75T7YQ0o7US3jtM6eEBOfB6Zt7QTeBWnzAbTKsrrcqgJUE3KfTyCaw0Co=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3898
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Todd Zullinger <tmz@pobox.com>

The gpg-agent is one of several processes that newer releases of GnuPG
start automatically.  Issue a kill to each of them to ensure they do not
affect separate tests.  (Yes, the separate GNUPGHOME should do that
already. If we find that is case, we could drop the --kill entirely.)

In terms of compatibility, the 'all' keyword was added to the --kill &
--reload options in GnuPG 2.1.18.  Debian and RHEL are often used as
indicators of how a change might affect older systems we often try to
support.

    - Debian Strech (old old stable), which has limited security support
      until June 2022, has GnuPG 2.1.18 (or 2.2.x in backports).

    - CentOS/RHEL 7, which is supported until June 2024, has GnuPG
      2.0.22, which lacks the --kill option, so the change won't have
      any impact.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 t/lib-gpg.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 2bad35e61a..8b9fb6e932 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -40,7 +40,7 @@ test_lazy_prereq GPG '
 		#		> lib-gpg/ownertrust
 		mkdir "$GNUPGHOME" &&
 		chmod 0700 "$GNUPGHOME" &&
-		(gpgconf --kill gpg-agent || : ) &&
+		(gpgconf --kill all || : ) &&
 		gpg --homedir "${GNUPGHOME}" --import \
 			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
 		gpg --homedir "${GNUPGHOME}" --import-ownertrust \
-- 
2.35.1

