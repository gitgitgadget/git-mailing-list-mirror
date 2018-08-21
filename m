Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE4E41F954
	for <e@80x24.org>; Tue, 21 Aug 2018 20:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeHVAP6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 20:15:58 -0400
Received: from mail-eopbgr730137.outbound.protection.outlook.com ([40.107.73.137]:51123
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726694AbeHVAP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 20:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dw/7mu14gQ0cCckQ8Do/GoO61+CsqUuLDQ8GW1JiprY=;
 b=L1CdoOxoecRKLFTNYNBf6Klj3cJa7PYUm7Mh8c3eGsFsctqnD0RTQkn8jf3ju6V29m5L19s0cKPn44Vs6jNT1llUIQrVaM8jEghI5btZ9FHehvAV7MBTszz775F2irQR4dGH4wp14Ji6i8b3mXycH6NEhmCR/ZIspbnt/c7E7W0=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0914.namprd21.prod.outlook.com (52.132.23.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.2; Tue, 21 Aug 2018 20:54:12 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49%2]) with mapi id 15.20.1101.005; Tue, 21 Aug 2018
 20:54:12 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] commit: use timestamp_t for author_date_slab
Thread-Topic: [PATCH] commit: use timestamp_t for author_date_slab
Thread-Index: AQHUOZEdzZ6tBZ/SukeezmzneFDy1w==
Date:   Tue, 21 Aug 2018 20:54:12 +0000
Message-ID: <20180821205359.29569-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR1401CA0003.namprd14.prod.outlook.com
 (2603:10b6:4:4a::13) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0914;6:p3Q1jvxUU4N8ZvOBw4ASAiib+Klf9i6oa/aIM0dczDXB+gGSgD9dl0nvBArtnF3GYfFN+VcFuFnpvhkRrVuLV5829N5scmci+KaMfxo7snhT28AmiguaKqohj9JCs9qcJ90sZA44hWgWac8Dz3GwGnqF0n7W8w5cdxyEDl5jQtQfYRyAwlQUR5mS9Fwz7pnYKv3UGidlW6BYtvbSYPgy5yLzj6EaBUCbDnSeYEJME5sKW8Do8KKGJi5oh3O6YBBmxTT/C+2gmI8iA2Uw3wEL/+iMOKavJfS+6UuuHqD/UoTX77NGIHmi8WxMCGuV+hrksEIs0lNgT1y1FnpKjQ9x+ulgva9o5Z+3HY9H6SHcCc8P9xKcrDSbAByy4BCJsmvze9N9WkN9sB9E8y8jqbXKLv1WEsbzuB4WORQIk42gUJpSVYEvgE2HKslShm0BqBZRNpL0A3T3UveG+MKNxtynnA==;5:JqhwPKXhwkDFsoys4hCS0OSn+SDtxkJSrDO2hhgVv1Nza8jXL1PpEtUxayjizGKKGipDnh2XUfULP2DXOZNXxIhOIuDDXHcs8dBoFaA3Oc1GZy7lx+G4yNenhueFfHcUZuSQn4IsuSfoQBN4SwN5HDsEnsCso/nxKjdRXMDRYu0=;7:md629zyLsTW4wOEIEmrfPzZrX5gWCQYi+ZcawJBT009OY6PqHS/rJHehIbXLeNyf1kzxdLtYYySMUQyfhmR0wE4lFzyBgpm0NgdaU5Nzu5l9xJ2RKd1nWCgK1fryQLXWeaz+to0Woq/KPHurn/IPE/zrjj6iICoy9WEo8smcRaOG5L7iDbcOix7atpMwLffRmDCizP4zJsgzzknnG1sP4FNU0HeXTwQjQ0K63aW+EzxO1UrIP+xLUFYbaepFtku0
x-ms-office365-filtering-correlation-id: 54eac7b4-ee29-4a0b-d78c-08d607a83f86
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0914;
x-ms-traffictypediagnostic: BL0PR2101MB0914:
x-microsoft-antispam-prvs: <BL0PR2101MB09147D2688D9D5E1EC131D49A1310@BL0PR2101MB0914.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231336)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699031)(76991015);SRVR:BL0PR2101MB0914;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0914;
x-forefront-prvs: 0771670921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(376002)(366004)(189003)(199004)(1857600001)(68736007)(14454004)(476003)(1076002)(8936002)(46003)(2616005)(486006)(54906003)(52116002)(478600001)(256004)(6506007)(14444005)(386003)(6116002)(99286004)(36756003)(6346003)(102836004)(10290500003)(2351001)(186003)(4326008)(10090500001)(5640700003)(86362001)(2501003)(6916009)(106356001)(6436002)(5250100002)(6512007)(81166006)(53936002)(1730700003)(81156014)(25786009)(8676002)(2900100001)(7736002)(305945005)(2906002)(22452003)(107886003)(316002)(86612001)(105586002)(6486002)(97736004)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0914;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: 4cAz2TBPlQ6WdF1buMm5KZY9KXTrfg4lAwB+6Cn/76Q8aD6ISYss95dKaj7i+wzn0TwMJ/LYL0yUNgIlJFV5Kguh9suAtHrl26tM93Gluc2zTV18UZRUEuxbgbc53Vl1njABsx8Xu1fLa0HWQlhRHf78OWGeqHyZiBQeeG8f5KQBzfVE/8LNXM5ahfDRKgNu12eT3tc9LutBjVOzHELDYgwzkoC5q3Tss25fe9t46KYH1ckMp5IbWB/SJ8svohOozJmj5IRb+EqgVuYY0/af+7S+3J+ih2pVC6+3XF7JuAlv+gyBrtNuXf4TBWjbv7KfeDI3oKztFOAySR3/upkIsJO/L7xvo1Xe2nzt7qeMCsM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54eac7b4-ee29-4a0b-d78c-08d607a83f86
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2018 20:54:12.6369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0914
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The author_date_slab is used to store the author date of a commit
when walking with the --author-date flag in rev-list or log. This
was added as an 'unsigned long' in

	81c6b38b "log: --author-date-order"

Since 'unsigned long' is ambiguous in its bit-ness across platforms
(64-bit in Linux, 32-bit in Windows, for example), most references
to the author dates in commit.c were converted to timestamp_t in

	dddbad72 "timestamp_t: a new data type for timestamps"

However, the slab definition was missed, leading to a mismatch in
the data types in Windows. This would not reveal itself as a bug
unless someone authors a commit after February 2106, but commits
can store anything as their author date.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---

I found this while reading up on the revision-walk machinery. This code
hasn't been touched in years, so could apply to 'maint'.

 commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 0030e79940..2ce5052b3e 100644
--- a/commit.c
+++ b/commit.c
@@ -609,7 +609,7 @@ struct commit *pop_commit(struct commit_list **stack)
 define_commit_slab(indegree_slab, int);
=20
 /* record author-date for each commit object */
-define_commit_slab(author_date_slab, unsigned long);
+define_commit_slab(author_date_slab, timestamp_t);
=20
 static void record_author_date(struct author_date_slab *author_date,
 			       struct commit *commit)
--=20
2.19.0.rc0

