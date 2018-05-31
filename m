Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B2981F42D
	for <e@80x24.org>; Thu, 31 May 2018 17:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755860AbeEaRlX (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 13:41:23 -0400
Received: from mail-dm3nam03on0095.outbound.protection.outlook.com ([104.47.41.95]:11648
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755830AbeEaRlS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 13:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szcZx3VaooivwridWVNToCb1d7kYFisDYLJyLj4JxSk=;
 b=lW/mftMDnkkG4aBKplKm35l/1D+vEqdjoFby38KjzsXDkxJY2RlKp1paD6kfyiEbr4XGJ5VDKwZ+u5W6sy5Uh+11YmugDJ+urgfeOhqZwlNvlGWKK7yNPpCdMR9CePyIpiJdqNZbrFIRgwsHjP8Q4LqH7oBbeFMcUn2UZ5NL5yw=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0996.namprd21.prod.outlook.com (52.132.23.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.841.6; Thu, 31 May 2018 17:41:16 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::3d60:cf3a:fdeb:bbb1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::3d60:cf3a:fdeb:bbb1%5]) with mapi id 15.20.0841.006; Thu, 31 May 2018
 17:41:16 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 5/6] fetch: destroy commit graph on shallow parameters
Thread-Topic: [RFC PATCH 5/6] fetch: destroy commit graph on shallow
 parameters
Thread-Index: AQHT+QaTVBRuAb86X060G758ivcBCQ==
Date:   Thu, 31 May 2018 17:41:16 +0000
Message-ID: <20180531174024.124488-6-dstolee@microsoft.com>
References: <20180531174024.124488-1-dstolee@microsoft.com>
In-Reply-To: <20180531174024.124488-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0060.namprd02.prod.outlook.com
 (2603:10b6:207:3d::37) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0996;7:y2i3iXQ/a4n0nkpJvfI9qlDhxwK++GoniWGaUMFusBF3EYGan0wLrcHifZ4kaTxm+84FMXNUuA3kwY6/hI3QG6Ujr8N11y8McEjzXclTyHVodm8d30gg7JmOeqznCmxa+ed5xKOvScmn1EUfp5GE+pLnOap3Ckf8VjjFN7nf9F8chUhn00qG7w+Kdw4qkZf/K2mavS7W8ArskViomz5KM79D/k4wJOHPjHL7gfJWKssDSuvgK+DGC6CeKkow9raa;20:mzuZtHrDbQ093wFJEGD7APBi7Y9g8huZX9h2fZx/9q+v6KcOqFAEFGDrJmOgrrzh+90hHSQLjxvYzexT2xFkGmBq9ciDylgZuGzQoy5+/bDQ8C7Jkh8uc9HzuJznM9kujTNgPE5UIaOyKdzcKTkSXbU3gvHcotd+CsHzqjCPY5k=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0996;
x-ms-traffictypediagnostic: BL0PR2101MB0996:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09963DF287ABAE3BE607BAA2A1630@BL0PR2101MB0996.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0996;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0996;
x-forefront-prvs: 06891E23FB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(346002)(366004)(39860400002)(376002)(199004)(189003)(39060400002)(22452003)(6436002)(25786009)(316002)(10090500001)(4326008)(86362001)(107886003)(3660700001)(3280700002)(5640700003)(97736004)(8936002)(478600001)(53936002)(81166006)(1730700003)(81156014)(2906002)(46003)(6486002)(6916009)(10290500003)(54906003)(8676002)(68736007)(5660300001)(1076002)(2616005)(99286004)(476003)(6116002)(52116002)(6512007)(486006)(36756003)(186003)(2501003)(446003)(2900100001)(7736002)(76176011)(5250100002)(11346002)(14454004)(305945005)(102836004)(106356001)(59450400001)(2351001)(386003)(105586002)(86612001)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0996;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aP25j9tIKhg4eqoCdZwe2Khk7JmjhOPGeez7WNvnIy3eUYPBJ2hLyWZ3FCVyU9CcCMBSkcBWA+1BaiA8ZTnMdFzMaMA4g1qCg3PlNWm4flgvw0YBXxUaVEkR8Ix5A/byyZZT8HUqbqlr99r+hdEPG7vkpD0Y1LUUw7P16burlcH86KqfjSM8DwPK/CIkcYo1
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2dd95239-2b86-4e47-2649-08d5c71db5ca
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd95239-2b86-4e47-2649-08d5c71db5ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2018 17:41:16.7415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0996
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph feature is not compatible with history-rewriting
features such as shallow clones. When running a 'git fetch' with
any of the shallow/unshallow options, destroy the commit-graph
file and override core.commitGraph to be false.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/fetch.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index af896e4b74..2001dca881 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1452,6 +1452,12 @@ int cmd_fetch(int argc, const char **argv, const cha=
r *prefix)
 		}
 	}
=20
+	if (update_shallow || depth || deepen_since || deepen_not.nr ||
+	    deepen_relative || unshallow || update_shallow || is_repository_shall=
ow()) {
+		destroy_commit_graph(get_object_directory());
+		core_commit_graph =3D 0;
+	}
+
 	if (remote) {
 		if (filter_options.choice || repository_format_partial_clone)
 			fetch_one_setup_partial(remote);
--=20
2.16.2.338.gcfe06ae955

