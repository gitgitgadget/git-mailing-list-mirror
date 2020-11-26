Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BEEC63777
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 08:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BAB620B80
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 08:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SdoD777E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgKZIiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:38:07 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:41062 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726479AbgKZIiG (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 26 Nov 2020 03:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1606379883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=h1DIhwgQLDvwpy5VBhZZAdYlMumaPsVmhdSaeFaucv8=;
        b=SdoD777EFqjtVkzcclQhomgM4QzMzm4fDBDkvo6a403eVpdPtsc1LEmNgMNtqmg49lm5Zs
        OaUTTq7V9jhxyYMBahPWCZPMQOcnY2Z8nkZ/sjS14KGvfLcTRSFudpPZdIEsSGUihQgez5
        R9R4IIDrtyOCID25rGr5jjxW9QUNtbo=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-14-uzZT4LU4NoKK2vjEM3P98Q-1; Thu, 26 Nov 2020 09:38:02 +0100
X-MC-Unique: uzZT4LU4NoKK2vjEM3P98Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTajcE0NGOPpQxRbaJZ4NTkPaK9/KhZlbsKpn/J7+n24Jmz37NAlQdrVSmpbSLJzE31fEs63FqxrXOPiRgntV9NCt0Lr1IrJT3qULqzpU9LVamduEaqQypE2lFOuudASWeqmJZLBpNz+2MN8taUjckJlf8zv50i/HiTJOF+Eevv+SZos9+8MpkYvSyhuEWAUm5em3ckc/v/jA3J5bcB1xqXWQc0gn73/pBoEgruOJR9u0j4Ub4pK1rYmPLA3TGbTw1xS8i2vf5mURAwLxwI8XLwnwfmTEMNwnOXzDkKlQtQ9yESZAZfUUgYXZ6rpc+2pMYVFEe93oT2XP+DtVJrQlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1DIhwgQLDvwpy5VBhZZAdYlMumaPsVmhdSaeFaucv8=;
 b=kXawvzCRQrJ99sz9fne05gosfOiDeGAytIDp1tNaJyRjzOWMUF2yJqMI0q65Atph5sw+4/ymbSu7JWOm2uEqqVBgA+exvQ/yKjySC4tszotiBiFgK6B4u+3/1+Q8SU90AGkSDTvEDcHrSSvaB1SGCEqYq/KlZDhut3LI1NGQCTDPIQVLcAmU94MQx7anXgechKXNd6OqPJAP1K/6+0/mGwC1SsLISukgDhU5GcFrwJMFdaXAWmiRLc8Ikh3sPtynoCRK2T4gJhcfVWaZ/CqZcRv/uRWJpmVinl1pvHzpvG6GLzjKt/byPJbPlEc1ePDS9styHpx7YV/Zxm9Xg+b36A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com (2603:10a6:10:121::16)
 by DB6PR04MB3173.eurprd04.prod.outlook.com (2603:10a6:6:f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.21; Thu, 26 Nov 2020 08:37:59 +0000
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::2dbc:de81:6c7a:ac41]) by DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::2dbc:de81:6c7a:ac41%7]) with mapi id 15.20.3611.020; Thu, 26 Nov 2020
 08:37:59 +0000
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: [PATCHv2] imap-send: parse default git config
To:     git@vger.kernel.org, levraiphilippeblain@gmail.com
Message-ID: <1c3954a4-a8c7-d134-1a4a-aee8c3b4ef24@suse.com>
Date:   Thu, 26 Nov 2020 09:37:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.200.199.24]
X-ClientProxiedBy: PR0P264CA0180.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::24) To DB8PR04MB7193.eurprd04.prod.outlook.com
 (2603:10a6:10:121::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.127] (86.200.199.24) by PR0P264CA0180.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Thu, 26 Nov 2020 08:37:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 246ec356-a723-4309-bb65-08d891e694a8
X-MS-TrafficTypeDiagnostic: DB6PR04MB3173:
X-Microsoft-Antispam-PRVS: <DB6PR04MB3173E71B7F7327B2B90E9FE5BFF90@DB6PR04MB3173.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 10NC5sUjehDEH54JV/R4btsiUMhN/w400cPmdDEeD6shzVO/kEpE4ggsQ80iltijCPc153a7qHxO4Va0auTpDzha9bV3wqTtEtzx+iyMZ0kZhT+zJUl2hn5DW3EzxseJsfB3WL6LPu6kYe9Q/l7GcLJhxff5MXlf2JpdfMtS1BR4XfiSlZkkE2S/BIMyOzDN8WPaII06SeVGSf+U2kEJbJLBk5OVAP3SOKCZYi0Ug7oncYMGwQiKMhWlUt2CJAKef2SQY5livg7VpH+A4r/UNirX40vE0WMKqfOHyC1uNmRcWcLbSt1eZP/mbD+OvUF1jTBJxmyZr9C7tCP7AdG+jRN/E+aD0yZsBdWLNRnpF/Skf/C1OkhVuDYezkN9O6ed
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7193.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(396003)(136003)(366004)(6486002)(31696002)(86362001)(316002)(8676002)(2906002)(5660300002)(956004)(83380400001)(16576012)(16526019)(66946007)(26005)(66556008)(66476007)(478600001)(31686004)(186003)(36756003)(2616005)(8936002)(52116002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?Xcr7+WWGEFskN54Mi/bBJykgkRQfnHLlUOYnijwB0s+qL/5WAXXM/oo7?=
 =?Windows-1252?Q?4Pb4KkD0Y5daVmeTCyQYT/SSPzZ1LnYee1axZ9qODJvrIn31b/pIhqPb?=
 =?Windows-1252?Q?y1QsbNqca6fQ+tHkNOkPZynjo94iMjOMyS23EKvUbpQWVU84yUDRRuGN?=
 =?Windows-1252?Q?ntcub3m1Ob1BciyrCSkZF+oqrFpJJCie2VX1mhfxwDtmdXj/pGjsK6hR?=
 =?Windows-1252?Q?/vkYM5mqJOtShj1F8dlnpgJuCCuVu/amHmwFIRjdZdCM+wM7y6AOjlzX?=
 =?Windows-1252?Q?r1TQ3J4tQrwJ8YvVrwP0FIu9BatKptpyjl/Yg+92CvnqeOzX4aTn7anq?=
 =?Windows-1252?Q?roSRap4gdWK4pXaNE+1GG5qAHkEQZCVVwYZ1wMRXzI6q2tA+UySWanyv?=
 =?Windows-1252?Q?1JJan6qtXMRkRc4Cf+qrz3eDMfuHbKNDOST5wJ1ImEHJMMUsLTV0qLsK?=
 =?Windows-1252?Q?FKjvQwshpgO2b9WO1uY8w9TGWwTy0RhZqof02sZltWGPbTFEBQkFmPuP?=
 =?Windows-1252?Q?TAxpH6w5eDD1e+7i/8+tBWWV+Dfjn6HTB22qqR6aTyYtCXbxHLbypTdx?=
 =?Windows-1252?Q?CxsdXBP+TbEU7D1v4iLXstdMLue32F9pPdmylG2eNBd8K8Wk3pnap5DP?=
 =?Windows-1252?Q?FGNE7njDcC7f9IMD9ZTP0diiDMONjocem/DJeUBHYs+Q8tCUWKbm1QCa?=
 =?Windows-1252?Q?SGFjGwqoTK5KR1HH751bLCAcsbIMxJTv9YVdW8qGNjoqGPoBUJqjHd1p?=
 =?Windows-1252?Q?K1S+6sgeznuO+nbITjdSAI+eGqX1d6umRGbxNOyBtrEFaXDSpmkhYRRs?=
 =?Windows-1252?Q?3aEsu0FAzNOYJVNSH5dRp0FIIN4t0XljtQz39iWW0ii6zJnfSS7ocF6r?=
 =?Windows-1252?Q?XdYgk1vZzIjReCszQYgErHQiwFvHbjjwW3JbhKlF6c6aIVoivEyy/dJO?=
 =?Windows-1252?Q?iqWYUit4GeBTc6b93uJ1btvcfmdclXRxZpUwvNaRnycY6S4JM7qzVwq5?=
 =?Windows-1252?Q?1vKaFkyUtIblPvsvWmvPF3h5IOfnMDzc2AqdhrjO71P2fv++7CtDRjcm?=
 =?Windows-1252?Q?zyYti50ml+QtWL15?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 246ec356-a723-4309-bb65-08d891e694a8
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7193.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 08:37:59.7468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ty4CwW159LW2vbpxd54RcCimPEyfoyWW3Q+C+8BRlaz26Dbwv1q44AP4QmnDjzUYWZTZZU8hWBO3IqX1h+3aUvlCbJtfik8s3UVepLAAEHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3173
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git imap-send does not parse the default git config settings and thus ignore
core.askpass value.
Rewrite config parsing to support core settings.

Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
---
  imap-send.c | 52 ++++++++++++++++++++++++++++++----------------------
  1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 5764dd812ca7..fa1921734671 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -84,17 +84,17 @@ static int nfvasprintf(char **strp, const char *fmt, va_list ap)
  }
  
  struct imap_server_conf {
-	char *name;
-	char *tunnel;
-	char *host;
+	const char *name;
+	const char *tunnel;
+	const char *host;
  	int port;
-	char *folder;
-	char *user;
-	char *pass;
+	const char *folder;
+	const char *user;
+	const char *pass;
  	int use_ssl;
  	int ssl_verify;
  	int use_html;
-	char *auth_method;
+	const char *auth_method;
  };
  
  static struct imap_server_conf server = {
@@ -955,7 +955,7 @@ static void server_fill_credential(struct imap_server_conf *srvc, struct credent
  		srvc->pass = xstrdup(cred->password);
  }
  
-static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *folder)
+static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const char *folder)
  {
  	struct credential cred = CREDENTIAL_INIT;
  	struct imap_store *ctx;
@@ -1338,15 +1338,26 @@ static int split_msg(struct strbuf *all_msgs, struct strbuf *msg, int *ofs)
  	return 1;
  }
  
-static void git_imap_config(void)
+static int git_imap_config(const char *var, const char *val, void *cb)
  {
-	const char *val = NULL;
  
-	git_config_get_bool("imap.sslverify", &server.ssl_verify);
-	git_config_get_bool("imap.preformattedhtml", &server.use_html);
-	git_config_get_string("imap.folder", &server.folder);
-
-	if (!git_config_get_value("imap.host", &val)) {
+	if(!strcmp("imap.sslverify", var))
+		server.ssl_verify = git_config_bool(var, val);
+	else if(!strcmp("imap.preformattedhtml", var))
+		server.use_html = git_config_bool(var, val);
+	else if(!strcmp("imap.folder", var))
+		return git_config_string(&server.folder, var, val);
+	else if(!strcmp("imap.user", var))
+		return git_config_string(&server.user, var, val);
+	else if(!strcmp("imap.pass", var))
+		return git_config_string(&server.pass, var, val);
+	else if(!strcmp("imap.tunnel", var))
+		return git_config_string(&server.tunnel, var, val);
+	else if(!strcmp("imap.authmethod", var))
+		return git_config_string(&server.auth_method, var, val);
+	else if(!strcmp("imap.port", var))
+		server.port = git_config_int(var, val);
+	else if(!strcmp("imap.host", var)) {
  		if (!val) {
  			git_die_config("imap.host", "Missing value for 'imap.host'");
  		} else {
@@ -1360,13 +1371,10 @@ static void git_imap_config(void)
  				val += 2;
  			server.host = xstrdup(val);
  		}
-	}
+	} else
+		return git_default_config(var, val, cb);
  
-	git_config_get_string("imap.user", &server.user);
-	git_config_get_string("imap.pass", &server.pass);
-	git_config_get_int("imap.port", &server.port);
-	git_config_get_string("imap.tunnel", &server.tunnel);
-	git_config_get_string("imap.authmethod", &server.auth_method);
+	return 0;
  }
  
  static int append_msgs_to_imap(struct imap_server_conf *server,
@@ -1539,7 +1547,7 @@ int cmd_main(int argc, const char **argv)
  	int nongit_ok;
  
  	setup_git_directory_gently(&nongit_ok);
-	git_imap_config();
+	git_config(git_imap_config, NULL);
  
  	argc = parse_options(argc, (const char **)argv, "", imap_send_options, imap_send_usage, 0);
  
-- 
2.29.2.405.gfdfcad78fd04

