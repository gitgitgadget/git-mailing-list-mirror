Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED68C07E94
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 07:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 381436141A
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 07:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhFDHZv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 03:25:51 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:34008 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229826AbhFDHZu (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 4 Jun 2021 03:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1622791443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bD70xWbVDm6K53bgMrvkWP9WbP7TE+Wq9GRu/OMHHBU=;
        b=aShPOP+c9LLKMfB4xpmSZOmPDc5+V+TuucyWhuqKp04RAszAo9In8vdKfrSuZqL1mqIyx0
        9oBRZDUl8rRktyflx0yCYKPjaK2Hop9N0R69JzE+bmm5gMC+MESSEdLBXGBLCtiuPzplDd
        tJ3NE+/L5Fs1C5hfHHtlgNGK9alvCE8=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2106.outbound.protection.outlook.com [104.47.17.106])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-28-r9Q--RpNPaWCjljqfIxdjw-1; Fri, 04 Jun 2021 09:24:03 +0200
X-MC-Unique: r9Q--RpNPaWCjljqfIxdjw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnceLGcp/MhpTdPWssoUaec4W7Pzdf7xq30oX4jlJ1hPQevDCPGAV6VRuOkC3MxCz+rA2cUKG32yQWR3a4K5Sm+PdOBX0jumDQfislsImvXsm7Bj/COh5dJoj5mb8pZe93w4CQpdjPALbxS9PBLSzpGwWA+7JKQzi7u1DBcunA5+rJCcXRRxiDuRTMfg5BKJw/9+Kb4jZqClilEf973+HCcoPiWud5v0knDqE+WvS7s4+dV0k9weX1uXQR65YJpu0L8qWcMsBsfHrmjah+CvBCZwVXdgcuTxjdh8+esi0CiguxYnrSNQKU4NIv1F2pRFq/YcfDmacdXqwxVi1m28+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXbpaXTBKqJ1fjqyqDQthszZf7mQLk/iJ9+pjGbBnSs=;
 b=OCpxjJPIooJqtcyvdn3trBZ60RGXXhDEPU9Dhx0hIGmuwteGUnChLUsf/305M2ulGI+NjQJGL2sGcZ0zmsFVys+aZugQf2SqAwm44KRW1Hss1Zby0fgAWrMnnRTbzhvbLLk6HUASGRYhyYsYyV6B19INlJ4kvUvXuGgpYimkGZqztUZF9K37UlK2ZyhKEbIElMK/6flER8UeFFTt3EY5IxW5DJUbObWIJQjFJcXi6u1BaH90spgwKzu9HcpDBTVBCtwFZo8Ioni6ocs3Q166wQZBTpBbhf97UXLQZ/hxbYf1HhYI3UdAVaz8eqzRjmAhns7sU34k/Cx3b1fw3zR3aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com (2603:10a6:10:121::16)
 by DB7PR04MB5212.eurprd04.prod.outlook.com (2603:10a6:10:20::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.27; Fri, 4 Jun
 2021 07:24:01 +0000
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::59ff:d21c:875e:2a7]) by DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::59ff:d21c:875e:2a7%8]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 07:24:01 +0000
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
To:     git@vger.kernel.org
Subject: [RFC] imap-send: support oauth2
Message-ID: <ca1da892-f8ad-d878-a516-de5b08a99698@suse.com>
Date:   Fri, 4 Jun 2021 09:23:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [90.114.92.205]
X-ClientProxiedBy: PR0P264CA0065.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::29) To DB8PR04MB7193.eurprd04.prod.outlook.com
 (2603:10a6:10:121::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.127] (90.114.92.205) by PR0P264CA0065.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1d::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Fri, 4 Jun 2021 07:24:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e99610b3-ecd5-45d0-7e70-08d92729b99b
X-MS-TrafficTypeDiagnostic: DB7PR04MB5212:
X-Microsoft-Antispam-PRVS: <DB7PR04MB5212AC65E6744A52AAE82C96BF3B9@DB7PR04MB5212.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jkaikChj9W1p/gEgDdZlQM7aATPT2SzS28UPEAuWefDEet1oxcSHsKcq9Uum5pcN2x9XW7ThtauiQjPXcBqutdiyCU8RkB+bMhMzeZg5borbeooZ3nByuPgwN+0WYJ/8WqG3dKKICAPxdULp4BqomuKgSunbnKm0+QHnOkxUgHjJXzMr50Y0o4mPWNIkLVQBaymBeGVTBp37Rvxw+hrQipAMgNse6YNh2FYHVNw6/UqNiZnHqFJzsIkw7DmCQsSvRgJQ+ad8u2cubW4YeNUE3fO0xyGeGGJREsj7dONCMAGgZVZ5x29rOLCke+xvkXOUiCD4IEmLBjrfRvpht58Ix3CLN5ZZ6Khy9HgUJcKo5FfpMemqG178WIozXAGqWw1rhWmzxeAhfH/TKiW7wyHOascEi5HkSNtm1+A11El1YUHN8KmDbc18Imm3h0NS+vVG5HW60VXDrHqsQaZ7OssKkNi1Wc4cvwKeCOI1sJPJZnF4AELp7X/l/sMTpaU2owosyi11vvR57leWTFTgdGF3qFRyODqYkv7ImgYlMo1oGUPZutdDsuOeirxK89Dt+xptKd7iwf0WHE4wyaHNT7W8Wo0V+b0uarZ8dP6VbcgMj6YlPpt9zl8JuMIN/u0b9lQ6PfX0WMZx1oXtafGmSRIcThuM1WqkAPg2jOSBduuQbKJviuEP7Yhadxv1c/LHY669WoylU8KJ0Um7DmXEXr6fUnyQ/tkEOhXIbozJ9NDGNt52j5xTjvhqkPaAhaXgRIz8RjfQLMZZyiOddOjTS5aNr/T/UTg+hYFfEDm9QAdQ7JVRhC7cEnBkEdVKYkH+bekXeH73KgSfjzD1QbBzqSJkqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7193.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(136003)(396003)(366004)(376002)(346002)(2616005)(6486002)(8936002)(8676002)(956004)(66946007)(478600001)(36756003)(5660300002)(16576012)(83380400001)(86362001)(31696002)(66476007)(186003)(66556008)(16526019)(2906002)(26005)(38100700002)(31686004)(6916009)(966005)(316002)(52400400004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?42rabKAE3KhGUSaqwfbOBZCU4U1LOQS2ALle0VLJd3edWiXJ+C6TtAIsCnKT?=
 =?us-ascii?Q?hmGdxBlBXKkvyMQHhRn0RN7BIheMqmNkWzNeppD2hoHdxzaZ+Fvtuf5+nm6s?=
 =?us-ascii?Q?9zDLWrTWS6gM8RK7AQUdHySA9LiD5C5W9k0c5hYK/K4lyy5UAzR1lLuHPNfV?=
 =?us-ascii?Q?6AvAsWfQh5Dnzs+poYpnCSGh+2fckOamG4tlh4bn7tJ0lkRn+FJ4YrWI8iHF?=
 =?us-ascii?Q?5IptF2Aq4JjbzyoFQBhNVJBBz/Fpc7S+ZEMESJPuXwI49IhXb1iP2pwjylnJ?=
 =?us-ascii?Q?1Bop9PXeL5NaNytG5QfIuw/U9nAlApN+4SSFTWhDAR9OpJSmXL3smgvFHkso?=
 =?us-ascii?Q?YLKd9T/uZn/DgKC2YHvolRdS0At4X2gfRwT0qYx0jSnZW+o/hm0Yq5IMWiOb?=
 =?us-ascii?Q?f81nqg06+RWo9UU2gUY0DLql25Ee/DhFClSLeR0wfMNJKvD+zA9PWrYjwgDe?=
 =?us-ascii?Q?H6VQ6nu7aw4WHSk3MwsfpmO1YSFOEVtvkQPvjpG18kREZ6EUlnFImEV1rA2j?=
 =?us-ascii?Q?l0niokIJOiiL1YRXaLD3xbRCYQss9PgJjkPEWdQE4sb81ebWKqMPP/9q3uP3?=
 =?us-ascii?Q?VhliRuj0RjiudjEkpm2WVog0CKe56QUzYZW9+bUbSEOA3gCceOJeOMubrbwT?=
 =?us-ascii?Q?SetJnAIVFC9molTejgeLwbQ2OQ9rojM2bAdJL4HYfA48iwhlFAhA8os5QRr4?=
 =?us-ascii?Q?jxet1HlRVtrM0RXKg3V3JLwseRo7G5kJVbXUhSK8CbRVxHVcdD/lQZ7ok4ge?=
 =?us-ascii?Q?XIX8rDVuV5o5YQGYb3eWD3Jf0dwmiMht0DbG6cVSHywklMXYFVtspQkgitpq?=
 =?us-ascii?Q?kJpWwjJYbWvN66CQmapTIkcvYFLqP+jd9CZS7sDmD8Gr+bsF0sW0eXl2RhSO?=
 =?us-ascii?Q?g8EysnYROqFc3BrJEBCe1S1ktqH3O4YFqpfcNNxqlvw8E1dMUeMJK9/Wf6Rb?=
 =?us-ascii?Q?FL5n6+urbts90y+o+IluALnWr8B2nMV40qOney/2lmowmQ0kHBvgoUZSWRz9?=
 =?us-ascii?Q?0OD+H86xd8G6v8ksuOAPM8V4P5TrpLSn5EINzOaBVXTQDxtIAoCobLqqqd1C?=
 =?us-ascii?Q?t42oz1LxrvVqJ2CRzUS7KTxITjt6FClA263PUe8RQcp+XZJEjHTjGBtUzG1h?=
 =?us-ascii?Q?9NPFG/L5nGCcZEZRBLYBwCXnkvZ87ZaoOT6J+IC0Ktxjitjlqwzl8/+Ugo31?=
 =?us-ascii?Q?Sr52dwD2rzNPT2ZJCULuoO8IbC7urGmmdmWNIzVvSxkKSuuHeE8JxXPy0Wmb?=
 =?us-ascii?Q?+nD+RsuIL3XUbHkKWfNErmHoyvhhW8/AXBgT3mxETq6QerSnlSBm5GxErG14?=
 =?us-ascii?Q?HrkHo0DhcVtqN5qQYrz/oSxn?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e99610b3-ecd5-45d0-7e70-08d92729b99b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7193.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 07:24:01.1729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmgOjroqcecAkp3YYNUIRNyQCJ0MoJZVn6FSAqrhi/h8Aqi1cawwwYFFHslB95qCxv4SUiyWdiIcct1ooz6SM+8/QlLBWUsvz31rIp66Nj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5212
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2FA/OAuth2 becoming a more and more regular thing these days (and a lot of =
SUSE devs being recently impacted by it), I've thrown together a quick patc=
h
to allow imap-send to support it.
This uses https://github.com/jeffmahoney/oauth2-clientd. It can be used wit=
h Outlook365 or Gmail. It creates a file with a token to be used to authent=
icate.
As libcurl supports this type of authentication, it is quite easy from ther=
e.

With this patch you still get prompted for you password even though it is n=
ot used but it overall works.

Before going any further on this, I wanted some feedback on the approach it=
self.

---
 imap-send.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index bb085d66d105..951d6bca696a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -91,6 +91,7 @@ struct imap_server_conf {
 	const char *folder;
 	const char *user;
 	const char *pass;
+	const char *oauth;
 	int use_ssl;
 	int ssl_verify;
 	int use_html;
@@ -105,6 +106,7 @@ static struct imap_server_conf server =3D {
 	NULL,	/* folder */
 	NULL,	/* user */
 	NULL,	/* pass */
+	NULL,   /* oauth */
 	0,   	/* use_ssl */
 	1,   	/* ssl_verify */
 	0,   	/* use_html */
@@ -1355,6 +1357,8 @@ static int git_imap_config(const char *var, const cha=
r *val, void *cb)
 		return git_config_string(&server.tunnel, var, val);
 	else if (!strcmp("imap.authmethod", var))
 		return git_config_string(&server.auth_method, var, val);
+	else if (!strcmp("imap.oauth", var))
+		return git_config_string(&server.oauth, var, val);
 	else if (!strcmp("imap.port", var))
 		server.port =3D git_config_int(var, val);
 	else if (!strcmp("imap.host", var)) {
@@ -1432,7 +1436,23 @@ static CURL *setup_curl(struct imap_server_conf *srv=
c, struct credential *cred)
=20
 	server_fill_credential(&server, cred);
 	curl_easy_setopt(curl, CURLOPT_USERNAME, server.user);
-	curl_easy_setopt(curl, CURLOPT_PASSWORD, server.pass);
+
+	if (server.oauth) {
+		struct strbuf sb =3D STRBUF_INIT;
+		size_t sz;
+		char *token;
+
+		sz =3D strbuf_read_file(&sb, server.oauth, 0);
+		if (sz < 0)
+			die("failed to read oauth token file");
+
+		strbuf_trim_trailing_newline(&sb);
+		token =3D strbuf_detach(&sb, &sz);
+		curl_easy_setopt(curl, CURLOPT_XOAUTH2_BEARER, token);
+		free(token);
+	} else {
+		curl_easy_setopt(curl, CURLOPT_PASSWORD, server.pass);
+	}
=20
 	strbuf_addstr(&path, server.use_ssl ? "imaps://" : "imap://");
 	strbuf_addstr(&path, server.host);
--=20
2.31.1.5.g533053588dc3

