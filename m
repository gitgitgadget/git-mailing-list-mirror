Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6D1C433F5
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 15:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237574AbhKTPH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 10:07:29 -0500
Received: from mail-am6eur05hn2201.outbound.protection.outlook.com ([52.100.174.201]:55837
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231660AbhKTPHW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 10:07:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdj7insMPcj7BNq+up1ZzZm+fqGK7mTX9JmLCK3zwfhlZ1mxVDeK1zwVJqFWBG40cgjzEAvEvrZjy03PSbUFcSnjw4ghea0smxzuYeq+7Y17eklpF5Bfm6dMkFLCCBqW9gdSFXpJIgwwN4b+LuEFuOdScpHhD45KFXtucqnODdrXues7gWL+GBFYE5PMioV2p3ZHBRQvdVgwhHXp2cGstWOzF3aIzNAvo3I7v/cB74JJfg631bYXhOt1Zj7w6+RLiSLex+R+SZww3H94pLaT4mWZv9m/30/KJZ97wTiEvbNEON11TXUwl6RLDzyBLqObgToumRLjE3bsThs/OSDVWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTQZyVr/Mt4izHFXJqibmSEaAVZQTx/lcFbp4gqVu3Q=;
 b=hMMP3dugLk5jUZRnDTR6xpnuZ6XpUdFQcZP+ve0Ad5NP/OA2OO3IGEF5Dyrn7V8yIwuhbbkiLR58rVDw00CwUgwiF0ogjM6vEvVcBePOZ5hyDNrehyZeVqmsdqXAwp2A195izyfWTEHkh3Rc0azQ6plftXV96mByry7GfFxIvy/RhQ1brVqdsfe7hjpJKbYlq1K4Gfff3htTucOGdYetqGLz6YDq8AyQIlsrGiahYVjQ4evz+nd8OnZYqS5JP9+UbcmT8KLkZmKjFw8PFzmhQi0YNLIfIN7M/+omaTQQPDGUUUW8x9P+6iZ5deopLsyzfU7VhTiDULbtTl2Z0rH/TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTQZyVr/Mt4izHFXJqibmSEaAVZQTx/lcFbp4gqVu3Q=;
 b=AftIcbSW7+I37hgLarWNV/Pb1jVsVRg/IenwsmjEBT7nKJw4MREisr5G9jXNuXXVTy4MqmyX9Kr47JkhJlkDJ3a6Q+O6DIi6HF/qwiKW7LSTfNd+sXkpZ3alxgMxKHrcYOkBRpZAmFxTvoKEdFOR4ujHqvlF/EDXi6mH5MYVUus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4799.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:156::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Sat, 20 Nov
 2021 15:04:14 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.024; Sat, 20 Nov 2021
 15:04:14 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v3 2/3] test-lib: introduce required prereq for test runs
Date:   Sat, 20 Nov 2021 16:04:00 +0100
Message-Id: <20211120150401.254408-3-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211120150401.254408-1-fs@gigacodes.de>
References: <20211117090410.8013-3-fs@gigacodes.de>
 <20211120150401.254408-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P192CA0036.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:83::49) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by AM6P192CA0036.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:83::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Sat, 20 Nov 2021 15:04:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54006847-9a95-498d-20c0-08d9ac3703f5
X-MS-TrafficTypeDiagnostic: PAXPR10MB4799:
X-Microsoft-Antispam-PRVS: <PAXPR10MB47992CAD066A640FE56A7104B69D9@PAXPR10MB4799.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rYQnHEW9AO62UG9EEJrc7A/5LPPG+p9qmGbBBZuTRTI80kkI0uK/0w+6Koqn?=
 =?us-ascii?Q?1vRB8IAl2cgUPNUvrVlxrG4evjqRFztlAq6VoEoIScx2b9ByyosXao7I429/?=
 =?us-ascii?Q?5mHJuXMWSgI9Mv8u2GHk8/upGVUtgMhfSUmc3HwWEo/0PrqSdhmM0GFxGQCQ?=
 =?us-ascii?Q?1og4oS7r2OsP6OUQOtdQ/wsoRou4frP11UeYEZL2gyb4kIlWN0Z3p0UyFErX?=
 =?us-ascii?Q?8WWpHogYhi59SSgk2dy/Iwd9NHCFWJ6rwd5uBHo002PT4eYHJ8aLkVXBKcGC?=
 =?us-ascii?Q?2sLmFx760u6k/5TWw8DZQwC7NJBKtjgJmwOIthiKt/GGkXw/CVvyzqbrqWlB?=
 =?us-ascii?Q?KeJr+V7GhNR6WAkZI5NqStb+3ts8RTZwRIdBjpZpM+n81RjsMNEQWlp155Lz?=
 =?us-ascii?Q?guu/IzUifMGWiZEhGo+SIEGTQ/fGePzSrdYDjLelCHnXEGmVdMBTW0ImHkkc?=
 =?us-ascii?Q?xcLXjYOzJ0RGhwkXmPm1KFXJAD8MEhBT9m3y2Jewt5RQccfr4pYIuZcq206R?=
 =?us-ascii?Q?KCETNHSy7uuCK6jZ4lgef/xicF8ehssMaJKHNCRwGTEDeh5nLZRuK/9e8BwG?=
 =?us-ascii?Q?Nyklg3W2/PxDernRPoyDw3NjJPQ4/YGtaqz1eidKMTA92N5sHofsZvVloQ27?=
 =?us-ascii?Q?626AoGqdSn97hWWjBACiB1ey1MQV2Tt7zEdpDEXAEv9a3V/j6dNAwYomq/nu?=
 =?us-ascii?Q?WycLjPMrd06fcgkV7SVK/MX/c53deNH8qtppQ4spdeTCR9px3s9EAQrBHUWH?=
 =?us-ascii?Q?KL+tas9o+OD8ewz7Fl3WMLlMl7gYKzuQeqKobsGvEbTX0u9iQ02Oy0oWEDjS?=
 =?us-ascii?Q?rI8c0g3OMgePX6GVYNhPRuXXwlOD/N7bypsHDVuORjuKkJto8JSOtv8vMhTq?=
 =?us-ascii?Q?0SyA9NvtPJrwrCoNM1u+G2UC8l4vIEbBayQhPkHrukyGbPynM7r4HQZNl/rZ?=
 =?us-ascii?Q?wcuyYeYEZwar8PyMSUrF3CDDtoWD0pwwUahjU/ArwVbRxZvfQQmpmnMq87tR?=
 =?us-ascii?Q?/2cK9UpA76lAJniDfgbLHA6GoQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39830400003)(6666004)(107886003)(2906002)(66476007)(316002)(6486002)(2616005)(83380400001)(66946007)(66556008)(186003)(5660300002)(38100700002)(36756003)(8676002)(54906003)(4326008)(6496006)(86362001)(8936002)(508600001)(1076003)(6916009)(52116002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KbGAdaJAMnMJoqtsOaWFvItmsvhHn85wZQB3tn8/32hxlCDfrI1TAn4HTxI9?=
 =?us-ascii?Q?1h42WHjs0QtIMa9t/R53CjJUV9xXklk0yWe82/w7w3OplOdb48xAxlajG5SC?=
 =?us-ascii?Q?bSz12OpIj9jebDazcILYnauKBRpKUuO3DEftf5wN4hGCXXpzJjDvu4IRrITS?=
 =?us-ascii?Q?IRDFWDr9cdI68sXJ6nfv3eaqqm9hLkVQ5i0lrSbHzEpVSKhGc2knhjl0PTmS?=
 =?us-ascii?Q?PY5Q98unyiP6LNgA/2jABqBCkAEeL8sK49cvMJIbRKFkToS5ZHRTlD/P/PrQ?=
 =?us-ascii?Q?BdOavxgAPzehpbDJmSs6Kf99fB99bKjIf1AiOyG/bs8ThrwnNb8QA9i9GOfs?=
 =?us-ascii?Q?NN7YKjKpxlhZAPUi7CXSdkkgz2eOL/U7VGq3Y3skgakPoi/k3Nb3++9QMkOl?=
 =?us-ascii?Q?gKEn32tTbAq26ozrzYDOcayC87fj9HDM1pnjbXKo4tjvFKLBO9Dz/bHmM1lg?=
 =?us-ascii?Q?0gyJXO84wCi2N+zuRKqDsn3xUbmTUpFoBdn/KtfVHAfXloN05VlyXt2ITxrC?=
 =?us-ascii?Q?d9MIaNjBy8KVrSyDYn3GN5uuUeUHnBpnzaycpHUMUdnCARbkzGCKQzR15fa8?=
 =?us-ascii?Q?Gz+TIisQY/K/DmvNQvU977aJdlvkhPAuvOlUMy4KModTw4Z2GsoeFTL9Huw3?=
 =?us-ascii?Q?NNCMVvlkiB50Tv5NI5nLGEOcViJrbmoBufYalRaRxQokfStDDRCfOU4T15Kr?=
 =?us-ascii?Q?6lzWE7mEp8I/P1pPvIJHbxLneJMsz5mH083Cdj5Dqncl/wAnA9nC2GEkxOt0?=
 =?us-ascii?Q?iOxVnnLDpWYEUx+fgIZUhsVHGjf2My0aYQ9yRvdGQM4ya63ag6/aD1tAvRFW?=
 =?us-ascii?Q?/L7tR/kwhLYb4gfa6BbdzjcuG9O8vGCP+v5DYSS7bAkgMZ/eK7v8VvC/fhOh?=
 =?us-ascii?Q?gxN6M1br22Q9yy4xm2ELl4sNYcR6xEjpGIExnfIPsKsHk//5jjaR/356/3SG?=
 =?us-ascii?Q?ATXNvsOMBP+GanFWKM+p00BF8pyAsdHvLR40xxSsdQdz/aObfCdwBQ2ntvCE?=
 =?us-ascii?Q?hKzllHyaF8AqbCRu8Eg5EturL9pMCHpKZqx2I7P/dPWqJFZlqlPl4ymb/Kcs?=
 =?us-ascii?Q?TBwNIPv0EiIUTgZedtpOM9TRf/T6kXJ+Js8e0CTdCFByOLPLg8hFfeP5S/ox?=
 =?us-ascii?Q?dQ1sq90vgsz69Xm1zPw1EAUYtLP9krLd1/5VGUMLqzm4mw3MDzgeWJXr5xp/?=
 =?us-ascii?Q?wLmMBtT9gn9DkQoxAhs03mwIViUsSCmHRLU2N88IhgnWHALkotr4XWF4AptE?=
 =?us-ascii?Q?Xe8u2Rck0OyVwX8IXUmFfbu6Od1O0e6SO/dzi7PKKD/Kr37aF4x32tE7SrKo?=
 =?us-ascii?Q?2kEHGz36C+/peKfOMRCjoLJbRRMsb/lKiLSSMy0dRPxTLJLXtWO3o1AbOk9c?=
 =?us-ascii?Q?tOiJCSxNc9lRwEIr63i0jIsRzznLX7Q5MZUlX8to778l14eX5eZEJUCOlsx9?=
 =?us-ascii?Q?681O0N1nFpPCDNo5CSvZ0+2Q07QB94gDNu33vPr4d22jg5Y9X7q70lU/kLoC?=
 =?us-ascii?Q?T/sFYsbElWmSLnSio02kggmEmp/ZNogIAAiOnDrdOvY4A53zKrljK1Mv2OOg?=
 =?us-ascii?Q?v/cvWog4ScI5Q11Fb7lv6dmI53YWYwjI+IwzvM6ea6891grxQ5dX+EfjHFl6?=
 =?us-ascii?Q?jfw9x6sK+oEEu5VMuK7SxTk0r1DSE5XS004HDWS7An9yrdLdWx7tB0DsarNa?=
 =?us-ascii?Q?Riwd4fGwZ5aPE8INvKzCCdjWysh9CetmqZXnzBk3mgygjSKiUh7AJ3iRD/G2?=
 =?us-ascii?Q?3bx6O+itHw=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 54006847-9a95-498d-20c0-08d9ac3703f5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2021 15:04:14.0097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DqwcKyZgB/Q5XcWRV2tbnjXSQggxIuuUId0qW4XzVHKb+e2K0w+R9ObcUHOTCEL/2odyK8/5LDtYa18KdbhgyMKxdohHVzE7ovFy4yJakWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4799
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In certain environments or for specific test scenarios we might expect a
specific prerequisite check to succeed. Therefore we would like to abort
running our tests if this is not the case.

To remedy this we add the environment variable GIT_TEST_REQUIRE_PREREQ
which can be set to a space separated list of prereqs. If one of these
prereq tests fail then the whole test run will abort.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/README                |  6 ++++++
 t/test-lib-functions.sh | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/t/README b/t/README
index 29f72354bf..2353a4c5e1 100644
--- a/t/README
+++ b/t/README
@@ -466,6 +466,12 @@ explicitly providing repositories when accessing submodule objects is
 complete or needs to be abandoned for whatever reason (in which case the
 migrated codepaths still retain their performance benefits).
 
+GIT_TEST_REQUIRE_PREREQ=<list> allows specifying a space speparated list of
+prereqs that are required to succeed. If a prereq in this list is triggered by
+a test and then fails then the whole test run will abort. This can help to make
+sure the expected tests are executed and not silently skipped when their
+dependency breaks or is simply not present in a new environment.
+
 Naming Tests
 ------------
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index eef2262a36..389153e591 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -680,6 +680,17 @@ test_have_prereq () {
 			# Keep a list of missing prerequisites; restore
 			# the negative marker if necessary.
 			prerequisite=${negative_prereq:+!}$prerequisite
+
+			# Abort if this prereq was marked as required
+			if test -n "$GIT_TEST_REQUIRE_PREREQ"
+			then
+				case " $GIT_TEST_REQUIRE_PREREQ " in
+				*" $prerequisite "*)
+					BAIL_OUT "required prereq $prerequisite failed"
+					;;
+				esac
+			fi
+
 			if test -z "$missing_prereq"
 			then
 				missing_prereq=$prerequisite
-- 
2.31.1

