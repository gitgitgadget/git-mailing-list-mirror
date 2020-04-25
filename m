Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A350C55186
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 09:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 443762071C
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 09:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgDYJne (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 05:43:34 -0400
Received: from mail-oln040092074061.outbound.protection.outlook.com ([40.92.74.61]:9537
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbgDYJne (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 05:43:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKIBgq+ftV2BVzS5Ht1VtwKX6vGyStz62tBHshQbEIRkejXCx6zr9DwqYHZr42LEodgLeRLNv0Bh2IRAAf5AYBQ63g8zp06kdvfND7FVmr/fMJLTO63k1lxqkLbnM8BJsL3+S/LAMtyFmTbD+Pc1nEKUbxtjInOVric0qX6yB+sYoOa+p3Kn47aMDPRf0i1gXBf7LN6ZGX/2onSBfMa4w7kOlfWHOlRtyj0qMP94lQyDfIFD4NS1oRqB4pxPqcKct76pb53MQbevxfa8dMzqD6TTjeGCTBKGNiqZe8hb81wFiodxqSqCDbfHe9ScXzcl2MSqR7xQJVpx5cYYZge2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gHm6eTe8o6F7OwApYzrUc2DYqWX7jJ1Z0xmkjwiKRU=;
 b=TW27iWmo9WEFbH38wF96Mwy2bX8xA4O7bVi+wZRUgP11wQEWljQwq7ppGrjYnEWL7vtEsFcxsBZaK3QAFPTe+M8vO2SXEEWc1lgcHJdo4rZ2hiIR/4S4baXtd8f9JV9oE8kxVXjc+8iYcXMw2jDykXzmoPC70OaQNEU+a8WoER9hj75TrjIawRH40L/3kNZ7vtSCALTDep5GRA40UdLTT1lPoZDluvVt9lc9Rt8+6C+YWnYG7z0tBJKIAeS1RFVJNlSbvXaJJ+FyOPQdlDEwm0p+lvNe0FUM9UtiiczuYNTj4JadWlHZa9c6x3YXkpEs3sODFtZ5ioJU0kQnS1bmww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.de; dmarc=pass action=none header.from=live.de; dkim=pass
 header.d=live.de; arc=none
Received: from VI1EUR04FT048.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0e::4d) by
 VI1EUR04HT150.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0e::352)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15; Sat, 25 Apr
 2020 09:43:31 +0000
Received: from AM0PR04MB4771.eurprd04.prod.outlook.com
 (2a01:111:e400:7e0e::4e) by VI1EUR04FT048.mail.protection.outlook.com
 (2a01:111:e400:7e0e::259) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15 via Frontend
 Transport; Sat, 25 Apr 2020 09:43:31 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:9F61CC991FCF9AD1E90E23F51EDB459ED75006E477E1F25816A31B753BFD5D6E;UpperCasedChecksum:A5E6D913683287066D7A7BE2FA01F9B13FB5D3E45CB4EEA7B9B36A7020913B62;SizeAsReceived:8866;Count:47
Received: from AM0PR04MB4771.eurprd04.prod.outlook.com
 ([fe80::58d1:c985:ce97:ee84]) by AM0PR04MB4771.eurprd04.prod.outlook.com
 ([fe80::58d1:c985:ce97:ee84%6]) with mapi id 15.20.2937.020; Sat, 25 Apr 2020
 09:43:30 +0000
Subject: [PATCH] connect.c: clarify BUG() messages in push_ssh_options
From:   =?UTF-8?Q?Matthias_A=c3=9fhauer?= <mha1993@live.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Raymond E. Pasco" <ray@ameretat.dev>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
References: <20200423064110.77258-1-ray@ameretat.dev>
 <20200423112110.45405-1-ray@ameretat.dev>
 <AM0PR04MB47715A57B110E14D6631EACDA5D30@AM0PR04MB4771.eurprd04.prod.outlook.com>
 <xmqqeesegfgy.fsf@gitster.c.googlers.com>
 <AM0PR04MB4771FB8BCD1EEB7E60EF54C7A5D00@AM0PR04MB4771.eurprd04.prod.outlook.com>
Message-ID: <AM0PR04MB4771946E0134D9D875AB1A8AA5D10@AM0PR04MB4771.eurprd04.prod.outlook.com>
Date:   Sat, 25 Apr 2020 11:43:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <AM0PR04MB4771FB8BCD1EEB7E60EF54C7A5D00@AM0PR04MB4771.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [yj63Qgc8Y8X4gjYwVGu7V4H8k2kBG+y4SkKlR6UEqlsPEfFG4gmIjUWAOODL4E7Z]
X-ClientProxiedBy: FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::20) To AM0PR04MB4771.eurprd04.prod.outlook.com
 (2603:10a6:208:c4::28)
X-Microsoft-Original-Message-ID: <32115dbd-dfc4-2b0b-0d8a-482b7e2fce92@live.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 061ad097-725b-4524-3b8c-08d7e8fd1caa
X-MS-TrafficTypeDiagnostic: VI1EUR04HT150:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OB5lY5OkqfdzJIh28wRyGG9e8xi54u4pg0Jrb7O1F08PRcHUaWA2E7FnwbjNZVlE4A2Y4kPpDolm1r54Vv+il8Y6JfGvh/y/zIqQR9MgunfoQ5I3jaglpYa5TaXNUmeCvzabV06c+9EQA89IXT1ttDzQyVhgUf6qXTahoqEyJ8fi7ISab9tb6ywJVynjFkwOL94A0YOcV9ytm2fjeDw1vA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4771.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: syeC1ugI0NtfmIv6tKBhh7dexyuM6i88gs/ExqwmrJdYuV5TadGs3tKP6RAZWwI6eVe8i5FNUJFhIFaGnKUi2xmU/8IzWfvEIUL08phW30tXHiWJokf9AHouW5k3QKAW25NQ7/0jK91qu0s1zIcmtdoyo9Yiesyk3f5Z1nVF1ggS3CT7DrKM1ks/hJXhO1w6WZ+yA9oSxTPkCsYOiTMBFw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061ad097-725b-4524-3b8c-08d7e8fd1caa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2020 09:43:30.5750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR04HT150
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current BUG() messages in push_ssh_options imply that calling push_ssh_options and passing VARIANT_AUTO is always a bug
and we should check for it once at the top of push_ssh_options instead of multiple times in various if statements. That is
not actually the case. When the caller passes CONNECT_IPV4, CONNECT_IPV6 or a custom port alongside VARIANT_AUTO we cannot
translate that to an option to the underlying SSH implementation without knowing the variant. As long as the caller does
not specify IPV4/IPV6 or a custom port, it is ok for the caller to leave the variant AUTO. Let's explicitly state that the
bug is in the combination of parameters.

Signed-off-by: Matthias Aßhauer <mha1993@live.de>
---
  connect.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/connect.c b/connect.c
index 23013c6344..c15e60b13a 100644
--- a/connect.c
+++ b/connect.c
@@ -1118,7 +1118,7 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
  	if (flags & CONNECT_IPV4) {
  		switch (variant) {
  		case VARIANT_AUTO:
-			BUG("VARIANT_AUTO passed to push_ssh_options");
+			BUG("VARIANT_AUTO and CONNECT_IPV4 passed to push_ssh_options");
  		case VARIANT_SIMPLE:
  			die(_("ssh variant 'simple' does not support -4"));
  		case VARIANT_SSH:
@@ -1130,7 +1130,7 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
  	} else if (flags & CONNECT_IPV6) {
  		switch (variant) {
  		case VARIANT_AUTO:
-			BUG("VARIANT_AUTO passed to push_ssh_options");
+			BUG("VARIANT_AUTO and CONNECT_IPV6 passed to push_ssh_options");
  		case VARIANT_SIMPLE:
  			die(_("ssh variant 'simple' does not support -6"));
  		case VARIANT_SSH:
@@ -1147,7 +1147,7 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
  	if (port) {
  		switch (variant) {
  		case VARIANT_AUTO:
-			BUG("VARIANT_AUTO passed to push_ssh_options");
+			BUG("VARIANT_AUTO and a custom port passed to push_ssh_options");
  		case VARIANT_SIMPLE:
  			die(_("ssh variant 'simple' does not support setting port"));
  		case VARIANT_SSH:
-- 
2.17.1


