Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1FEC64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 07:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 981A72087C
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 07:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aDb7N0Lu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgLAHja (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 02:39:30 -0500
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:51734 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727837AbgLAHj3 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 Dec 2020 02:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1606808300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=H3/OTtLNKk43viA09Dj1uXrriUPfgq2oxrhavhRo5MU=;
        b=aDb7N0LuKxaeKPHSQAx7nF0mm0WHvx7DPGLKxxBdMlpd+U/vt+1T5gu5bVyBr3cSdFeNZM
        o1dy9v30ITFEaKswttKgsbexWCUESLvfsKoTWPA8+MmR9Qt9vGfd72aCT9neVrkwZYJbrR
        XWliVh3MOJT8iYEsRGdW8daq8v4km8o=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-15-Ej8dIpg2PlW6t869VFblaw-1; Tue, 01 Dec 2020 08:38:19 +0100
X-MC-Unique: Ej8dIpg2PlW6t869VFblaw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xat+qoBpHf1vUk/D6wqa0D7Q0yNLbjozZBAvqBK94OF0clJ8uye59hZYcQa+aUuBzZlwDs9h2R/Fq3h3ZqloUdKvhj5XMNiCbOZv26bcQgZHXoEGZKey4SbiYVkHLQc+IPrDdJlXQHcB7KrQkat+9SDIh2D8qroz/P0lirAbW7quJQj0UB5PYP3YQaBmPV0t53HeJ9Uxn8uX28eLhaHH9N/ZJdfugOynWL82KKt3RGmYuTYpQd9JZ2y9kMxHkIjNPz/lHYKWClnzikSn/pebKhtEvOMPaVUpl0xrp5SuTftHaXZmbrhi1wfRzXyZTMKHtjGnj5KaUthDqMjAY6d1PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3/OTtLNKk43viA09Dj1uXrriUPfgq2oxrhavhRo5MU=;
 b=To8PjHCW5VFFj8xh1edMCYBp7KvshwXivVNEURkYvr4xt99vGUcHLeAiLDxKc9atxVNhBJrK2ZoBeBvoHmToZKrmGZdGvR/JIyk5UJrEc7YHpis2yGm9aY7nELRa18wCdghH7BENAYqPzxUbg+HoaV8vPcahiJWJpZ7/RiQ8C7NbrmQWpqLi6B1F5SOUJqHOf6XSMzCn+6+yZ6SvPmmaSWSgl91kBOp7dOormRsxLG8G1Kwc1ZJ+XTjcjJ/t7MSZ7XjGL8ecJW7KOMPFOA1YywiX1g+dMdez56rCfZarMeld+AmLevQtrYBxij8YV+ffUfKltpFZu//LDQTcSeYD8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com (2603:10a6:10:121::16)
 by DB8PR04MB7193.eurprd04.prod.outlook.com (2603:10a6:10:121::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Tue, 1 Dec
 2020 07:38:19 +0000
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::2dbc:de81:6c7a:ac41]) by DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::2dbc:de81:6c7a:ac41%7]) with mapi id 15.20.3611.020; Tue, 1 Dec 2020
 07:38:19 +0000
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: [PATCHv3] imap-send: parse default git config
To:     git@vger.kernel.org
Message-ID: <51989467-7bac-5e90-5b42-6503c8370988@suse.com>
Date:   Tue, 1 Dec 2020 08:38:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.220.115.126]
X-ClientProxiedBy: PR0P264CA0073.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::13) To DB8PR04MB7193.eurprd04.prod.outlook.com
 (2603:10a6:10:121::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.127] (86.220.115.126) by PR0P264CA0073.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:18::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Tue, 1 Dec 2020 07:38:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9a30558-fa5a-40f4-cf1f-08d895cc127b
X-MS-TrafficTypeDiagnostic: DB8PR04MB7193:
X-Microsoft-Antispam-PRVS: <DB8PR04MB7193E498C48D1C3D1B9E82CCBFF40@DB8PR04MB7193.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RfcPSn6JLdIt0aCHr1EAynJvL1iq5g0iIFZaoKW7jXR2+5T3cDyF6omVhj/6/M0+mYsFXYg58K5CoyqyXhcEMatir4ENa3L8wlC0+i/YEbWW/WEV5alZI5BwHBtq21ZrjyO/vZQQhN+Uusy50GfE5Lx9+kr3J+Zvt+ORIoFZIdLVJoSbmoXyASArkgjWEPkVYbbr8tp2RFvyp0ESjY55Pqs74j1VgsfU9vs5si4iPF5yWuo1YrlGKCmg6sJkvHyksaKbrsqkfn3LoOIaxtbL9wNEDQHQsMZrbJFjz8ktVvo9FydktlPmFfIlzJiX6MLWaN95osI+UBEtwqZymHcw+RN0i/zoVkFJ4UekG+GsSbO2PO/tbhFgpRoZ9z9mkarP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7193.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(366004)(136003)(396003)(52116002)(6486002)(8936002)(2906002)(6916009)(16526019)(8676002)(26005)(36756003)(66946007)(186003)(66556008)(66476007)(316002)(956004)(16576012)(5660300002)(2616005)(31696002)(478600001)(86362001)(31686004)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?Hq+vTNpTLxJCj9cDO5KZ9iA8+oYp5lkXbS8WkkMnZujPHLjjqyBugfK6?=
 =?Windows-1252?Q?AbDPxJYgPRHqGplzPWCmwqrjBBQlZFFJCa762xI2IVQzyALBf6elCMIQ?=
 =?Windows-1252?Q?lQpvGSeMy1bzjteDh5L3Kr7SjlYPmMv8qYNeQPLOninyWo55YEZvOxrv?=
 =?Windows-1252?Q?UQkzZdTBSGSDTjcwAzAr4AI4+yDWIWsIhFTePawrt54vbc36dcMGwuHh?=
 =?Windows-1252?Q?LR69LNE63CScAlX8otiDnMCPv8h+RsJr8z20UpPrGSrfZfr283gb9Sbu?=
 =?Windows-1252?Q?kxhjBlOniLDULjv1OLGQtHJGqtvlZrt9iTdyP9r5HcIXX2XSyESeYUKA?=
 =?Windows-1252?Q?aV8vdzLH/rYslDvsIMHpzifdfGvR7jYmkHzPya9szMvNkDeK056pfsxu?=
 =?Windows-1252?Q?w84isGOaMRpicTdzBbkeog3SyJmP9SDbCiGaRUPaKK0FJ0LO02oGg3xw?=
 =?Windows-1252?Q?tqPlet5MS5+Tro1+yaKDfjxG7+eGd83DcGm/6HteoINCcTqDAeNcy4M7?=
 =?Windows-1252?Q?uLNWltu+La6rWya3ZDzQdpBnoi/ETXT3vG/pMlP6xmVbP6sWr+/G/XG2?=
 =?Windows-1252?Q?wCehKNcdC7DrdsaLqexfG+MGYvGNe0BeLDEqGeHas6tpwDVL4ajVtCDY?=
 =?Windows-1252?Q?WTuCu6Duxebi1+KvZeTAiuYaUCYMRU4gs47UQX8aUVjjB7CViZq9VU9W?=
 =?Windows-1252?Q?q2zu3eiVQrc4elfXvPQrmwe0XQoPmrZyzD5I5VC6giWLuL0cz+iP34fU?=
 =?Windows-1252?Q?f4g3vCbv97HHrlvlCbuz88e5SC/SUvG2FOKEcP4u8Wfyh4UwKL8UJgxK?=
 =?Windows-1252?Q?/jNRGpAjwGwHtsi8truTOgP5D1E3P1Quv8WcJpGZkrPsL1QhfZOSWSkM?=
 =?Windows-1252?Q?T8ZgyFKh1mhvdedLatoefYcY3Ec9lHDtPtfdQZWoRDnfFEMwVDZrs5Fk?=
 =?Windows-1252?Q?lt41Ig6tVUzzzhifMe1sGxnXQ9SJbxQYq1NRR2XeDutmQ2qu3dnrxN8e?=
 =?Windows-1252?Q?VEyBVnm8Nm8upTq7WBsO57vTR87TMUOJkJtjpDQxgU3HLOMzkco1QBZD?=
 =?Windows-1252?Q?z9r8NLUbvOcBQ2st?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a30558-fa5a-40f4-cf1f-08d895cc127b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7193.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2020 07:38:19.0060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A18jQ6ipP8NCDsv6DqcMVqxA5ciFqpRDBzKuWpPm9EapaPOff/i9LK7yPG3RWXNvmVWZNqYQmflm1janqRgRI/2ELhGQRVVU7K4wztbIoWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7193
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git imap-send does not parse the default git config settings and thus ignore
core.askpass value.
Rewrite config parsing to support core settings.

Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
---
Since v2:
- Hopefully fixed format-flowed issue in my mail client
- Fix style if issues

 imap-send.c | 52 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 5764dd812ca7..d0b94f911eeb 100644
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
+	if (!strcmp("imap.sslverify", var))
+		server.ssl_verify = git_config_bool(var, val);
+	else if (!strcmp("imap.preformattedhtml", var))
+		server.use_html = git_config_bool(var, val);
+	else if (!strcmp("imap.folder", var))
+		return git_config_string(&server.folder, var, val);
+	else if (!strcmp("imap.user", var))
+		return git_config_string(&server.user, var, val);
+	else if (!strcmp("imap.pass", var))
+		return git_config_string(&server.pass, var, val);
+	else if (!strcmp("imap.tunnel", var))
+		return git_config_string(&server.tunnel, var, val);
+	else if (!strcmp("imap.authmethod", var))
+		return git_config_string(&server.auth_method, var, val);
+	else if (!strcmp("imap.port", var))
+		server.port = git_config_int(var, val);
+	else if (!strcmp("imap.host", var)) {
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

