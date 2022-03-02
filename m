Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142DFC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 09:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240355AbiCBJEC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 04:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240319AbiCBJDt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 04:03:49 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50069.outbound.protection.outlook.com [40.107.5.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26461C138
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 01:03:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZisF6NQtIc2binSQ7DZv1Sb925EAJF6LQDGLTMuazbWq8c9sRL4HzgDVnjTi4PqyvWhrZmsK/RxZYW9O0+bFOd9QhCzONQa0bw8c/Qkwga/uE0Y4fXpI6WrIMpjHqXYpzLfQ56wtUEA64UJ5U1sm3ljotHm5OuDYcLIy8W7XxuLKdXKq/tXhXKAz3SYLdtvtLVh1icjMQKntFqy8C7SE/srIDJvjcyHDgNudClMgXTTHKCjvY8rrx1l0ZfUEb/AB5COnNZDTbmUic5Dm9VQ2n5qC8EFpR6UamFhco/mhqQ28A4cWxnSFfGphuRQXEpaeksScUuuT9yh8dxl+YwgDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVSdiDXFIjMdIFa7p7N/jLr0vnjb76Jgq9wuTkoF8yI=;
 b=KvxP18Y9u8bgrPGzyh2N2zQspX4CzyOcBMFBRYzky5zN7Sfx+nsUCMGqzxd4zCQ2LFjLdwJpJXpo6Q426JGNfHaoY7J1Olp0ATs9H9r+KyH3uv6tzwb8kqZUO8fCxLS2Lx/cUAyAQfFvvyWk+Ey5ExjUiroWVR7wS8neqF8fYFAQbQR1YvKdd8oEuRj98lc/DXxPK8FioLLXdohywVTyjrwfSrydjJXlpu70mPQZ5sncgOckfmPmFH4pYF48cVe9crrLErV0lNMPXHC1KkPHlpJgOlpV8fQGDe2a7k+Pe01MH7rJ6l6Cc22DAYlxLoZB/B5HD7tyavj7OcjwiUMX2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVSdiDXFIjMdIFa7p7N/jLr0vnjb76Jgq9wuTkoF8yI=;
 b=M5SAF2DOVwF4wQVC5RJU8/2lI3dCtM4aGonrT5pDcG4MCcRB5dDf8RT9r/V6MONt/zGifVzx7i7UDwty0dFLJ9cjAABPpQ+Z/BjpvrfelXcx/Tr3y8/pV/hfTwhJ8MDz1dUIwHHAt5NsaP9IC/HIpU7+4CiW6n2elsCjOj3my/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by VI1PR10MB2015.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:38::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 09:02:55 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::116e:6242:98da:22ba]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::116e:6242:98da:22ba%8]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 09:02:55 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Todd Zullinger <tmz@pobox.com>,
        Henning Schild <henning.schild@siemens.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/3] t/lib-gpg: kill all gpg components, not just gpg-agent
Date:   Wed,  2 Mar 2022 10:02:50 +0100
Message-Id: <20220302090250.590450-3-fs@gigacodes.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224100628.612789-1-fs@gigacodes.de>
References: <20220224100628.612789-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM7PR03CA0021.eurprd03.prod.outlook.com
 (2603:10a6:20b:130::31) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ba8b1e2-bbde-4ef1-17da-08d9fc2b70ca
X-MS-TrafficTypeDiagnostic: VI1PR10MB2015:EE_
X-Microsoft-Antispam-PRVS: <VI1PR10MB20159E9CF99242814153CC50B6039@VI1PR10MB2015.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bn5D6e7YIRfNyhH+K16+HWG84JYyTUHa+RKov++OnUVvpu707RUB0+AXT4W3qGAZx6xQB0ne3Hdzs9BTZe1uPTzhwOJJrJjOxgmX/xNIMbb0DvhvwOHhud0I1GShQYDKBjIAD4/X7NJVxfL63xxTvMH3IPyGJBGEYNfkGsGlgIdYVSVF1dtDIwcWpbTbX6lSyI7rg6Pup6orPXVPjqwJA/nZmaYRF1BDgAdc6fJKsotdLDCG8GMqPlkcAOKXYnkK4VS+mW7UrRJ7PdEckWwG14lYt3WrrA0scmMAUCOTQlXPtYOx0XkPRoyQyVGY2ZdFDcCXVhl8Md61RuQiC0cL0i1z8A9WLy8QyEo22t1hkT+sApBUmt0e8PEhKf1RCxhS3Utx+dpjjPFCv8Kk5B9H5fARktYxPr4fkKD10kZqu7Ku5Uokq2kw6cb0XIKpgwQYHCjtPF6g9znu75Y+a6Xb3Wr6CVj3P7sEhUEz/fPlo+sIsIpKxM78+lGECJKFIIiABwgMAN81f99SpXOpbALS/hdRRAF2VwiIpfn6oN3qgKPG2hGLFcKoVFwGHbHfLEzcC/ktdBJvQqPKCoxyzA4e6017iVqfBVBx+zIz5C9rQxEkr4MxXCeF2B4Y4LhgpqhD7VimVxb7as0klV+s5sJWyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(136003)(39840400004)(396003)(376002)(346002)(36756003)(83380400001)(38100700002)(186003)(8936002)(5660300002)(1076003)(2616005)(4326008)(6916009)(8676002)(316002)(66556008)(66476007)(26005)(66946007)(86362001)(6666004)(6512007)(6506007)(54906003)(508600001)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xZbAEjWuj4aycjqL7tTU/mUHHeW1AD6t8/dPfZQZlUTt2XKiffL7ZJfiWVMh?=
 =?us-ascii?Q?xqAR0mavEErMTL8MKVaBBwpzI6x6kpXGJBGwp7kUcZSLt2qxL2IGgXKyj6rc?=
 =?us-ascii?Q?fiVdb7pUFFmPbtwpGJyvxvLckGH3yvMTZPS0J8ehqFCISbHWS4VP2oK6rgLq?=
 =?us-ascii?Q?Elm/RBbpPnnbYbImm+nxnuaCa3R0vtgUowxHhiMjHbXkYyskJguwryhjEPut?=
 =?us-ascii?Q?PnSYhC7HE6dYZbOiVe5G5uCTpDDmjyad+DIRTmz0ySq8Uzh67XDBIKZxvRHa?=
 =?us-ascii?Q?9ilCnhdbB+Z+7Gv4ljyCkKXIaO35SN2PAmVoDdNbR6VBkpVDHFVxRaDbHrLv?=
 =?us-ascii?Q?TveP4vB9gxBb88SGa+rtX8HtWPptxjz3M0hGzdzwfg7CwVsOI5nsN28l0O5r?=
 =?us-ascii?Q?53NIsvGi9HZ/ADiRk+lvBkTwtKguQQTvH5VNC9ErqR2juH92aoEW6Wq4Tj+o?=
 =?us-ascii?Q?LajllWK3vGFX2UZDTRs34a2nzB0JbhjmdVhr11R+aeQx/reImFa2gKEUqQsO?=
 =?us-ascii?Q?CXAjImw0ehWqkNDvot1eeGUfG01TO8W9LRtLd2VfJrURJ/kxqEIoYv5cGuZX?=
 =?us-ascii?Q?bu1WJwSTvoB/mQcPNumoHwCcdWvVq8HuF1w6sUnUBZuKc5jeeRBTjXUVnCkX?=
 =?us-ascii?Q?ppbv+23j+9CprgDO0MxFFz//zzLr0uRAay12O2SKjD+o4dBSDQ7SJPS90QpL?=
 =?us-ascii?Q?Awx56A4HojhVwTIyu0bJa8vxc2whDrrh1EnGiqKqJEzy4wk1jtxW7fP/Jtzr?=
 =?us-ascii?Q?dd5AdBTdnVqdzm/ntZ+NAkApC6BTcmjb1gbIs9dfdd9r98osoTC5DxES4yRi?=
 =?us-ascii?Q?US1OLaL/RBpkM9gPU0oUzprtE0y3KrtnakReyUOZ33DD0F2Jv2x2vceA0z7P?=
 =?us-ascii?Q?xLppCkVnDNiQMmsyFxagDq5W4CPQtGLKtdXxkwNkb0FsyYmf2My1oTSloW5w?=
 =?us-ascii?Q?w8Nz0H2S7Ayyin8C3WFvxv5h4p56TSxyBE9MI7Skv36MkG9RxZxsq2aZYx14?=
 =?us-ascii?Q?UCe/x70pAuDdzQZvODwRSg0eFIpEmlKgGwd9/miX92GYoeHpwBZodihqUUOB?=
 =?us-ascii?Q?C2zRn/xXjnqSnfVnRkVFFvcycgzH9PfsSB5u0xH8Dd3aWpzzDvfJf4HacdCM?=
 =?us-ascii?Q?LJWeCW1Hj655JqRneQEKwLIxDcrWnR4Ym/K3Cc/uAR+S/hLADajFBtXrW9hM?=
 =?us-ascii?Q?6r6MQdq8Lcp1IREJpFQQQHV/s8ieEe+nJ46d3kEJipj/tj/y5Oae+fqzmgyv?=
 =?us-ascii?Q?Ixttc5AaspOdj2n6YbcYTCpLKAVWrvXcX7wN8bVWQSwqTJH6dk3uaRl2CLdK?=
 =?us-ascii?Q?+Jg6itbMd4Ruqj+Gh5aJqv2QSalUU5vwXpLCrz0TzuQTfdT219/pGt7afDZm?=
 =?us-ascii?Q?a4ecpMuPDb61tRgT/UGH8WcJ9UaHTIgnlMA6QH2JQWZXFTNi/9cZkjWoQayS?=
 =?us-ascii?Q?GpyrdQGLdn/Q55KSgi/r/zbo3d6hW3mM6nPp3cOZxeUx7Fm01e8vrE8YtlD9?=
 =?us-ascii?Q?u0+Dg7VsFbyGv8N/PS8s5dlASyW2pM2N/Cfc9pvNJhC4xr5nA48NWPeb/Zrm?=
 =?us-ascii?Q?ewQefbl4zgDorHrHxNAqdQs1RaHbX0lGNkBJ0t/9GZMQP0BpXSmUM4dC6G8O?=
 =?us-ascii?Q?OMHCLfM4rUvMR3wp1Q9qquqxP0kfrqmPUO42jsPW90RXjbSe4NLdjFcEEl+a?=
 =?us-ascii?Q?l6B21QMebIvI+K5YT4zlswd7sYo=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba8b1e2-bbde-4ef1-17da-08d9fc2b70ca
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 09:02:55.6638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80o5u60ggPYG2VblmvfhtZQ+5PBKPyIbP4C4kcUJ8Ukrf399j14jrg1udhn8huupatWXKb0LRbUTlMns+J/KfSEm0TPPTGPlvgkIwMlBQ0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2015
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
index 38e2c0f4fb..114785586a 100644
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

