Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E87DA1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 18:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbeHTVlj (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 17:41:39 -0400
Received: from mail-cys01nam02on0132.outbound.protection.outlook.com ([104.47.37.132]:10688
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726228AbeHTVlj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 17:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqK1pqVMUnHfUXsfvnYTiBGMucR4nWIv6bkoM058ATQ=;
 b=cikrhstGCg+aa6JyL5gIhtQFfrYzdNTh89sXgkZ+C2QdNARPkxcGWizxnboA5OYpxOTC5hVRSPN2YKzRwyFcJnjkMBxLVZZfqANvqZfS4ayw3rEq/XI6lCHRB13xfDzzXZKqcejypwRPMnhhbyfIGOvOWKsxXu475MHJf0owzT0=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0995.namprd21.prod.outlook.com (52.132.23.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1101.1; Mon, 20 Aug 2018 18:24:19 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49%2]) with mapi id 15.20.1101.000; Mon, 20 Aug 2018
 18:24:19 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 2/8] refs.c: upgrade for_each_replace_ref to be a
 each_repo_ref_fn callback
Thread-Topic: [PATCH v2 2/8] refs.c: upgrade for_each_replace_ref to be a
 each_repo_ref_fn callback
Thread-Index: AQHUOLMCHOoJYuORgk6QVGdoYjFKOg==
Date:   Mon, 20 Aug 2018 18:24:19 +0000
Message-ID: <20180820182359.165929-3-dstolee@microsoft.com>
References: <pull.11.git.gitgitgadget@gmail.com>
 <20180820182359.165929-1-dstolee@microsoft.com>
In-Reply-To: <20180820182359.165929-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1201CA0002.namprd12.prod.outlook.com
 (2603:10b6:301:4a::12) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:e008:1:8b51:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0995;6:VpVoezla9NrrNHvPaM23m5+FSlk3MLOwMbaN5/7xuSlIgLlLgXiYa2tvvEs34kQuoJeiohTBJzlMraQ1FlO74SYlea6jF8XyEHITwwxDIDl2vDrUr+v+feCioAMNqskH43xOpVLJ9zAG2CIXGq4hhVZ1L4hTk6v8ZKV9Tjg1A51n9m0sS6GXd6JeHZOV+Ue9hFVwTuVMahQSAWRJTxG8EaIYl+A/uyI0dwizff+d+C6w8c2fMr9EET1xXhdOm9K4iPkrPmOKfRTD6qZFI+ANnwwYFRUZ3uh6UdIitvgC37Su8+RE6H8R1KiHhn4l1vyOU0HJHAK6Wd0sg1QUjQlHP1CTjiEmkVLROxSM4tdyM84dZ5CDHlFzWnoJ7hR0YICzo1BhUsjQ394TCvASl6xTH8+8Nr7/2yQxsgt1J74aKOeCVaAzJqq7nCI7ZFwbkH3x05LccUjVvaGOX0hxHv/lsQ==;5:2mV8Sr+7C8QphhvFS6ze3GbdG7B7UmjNFByWLnnuaJssZpYFpsdeL8z2d1KLHJNeW6+aK8V5A1JeEQxNlKJqxIpTSIGSwL7sEPFBJN6UEW/XXX8hbUD0s5WIw0oyU/tsVWadMGEAkJsslgUk056j4cvfnh+z/1DLi2FE0BTXXyI=;7:e0HhNe/WDSSgzmN7fCOsC+cphQz3+eLhEkF6061Tywmtj61egirMOMnU7F/qIl5rHxEEOgFk/Wexucsu0v39jPWOlUx3RLFdMqW8f09wCcF9vp9uzCA4+a2YDRlYb6Udj+gCtbMPtU5Z4d+3Q6UHErNRh2Ey4d3uz/47CqdGBS2S/agf2W7LJGakUfk7QLyrDw6CUsM5R5XxXzOQ32iKm6NxNNj7piTI21NdMmXUJFcWj89bBscJpYj3X7DX+yoc
x-ms-office365-filtering-correlation-id: cccd731b-b422-471b-7b3f-08d606ca2496
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0995;
x-ms-traffictypediagnostic: BL0PR2101MB0995:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0995FCCC0433EF1CAD983787A1320@BL0PR2101MB0995.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089)(211936372134217)(153496737603132);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231336)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:BL0PR2101MB0995;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0995;
x-forefront-prvs: 0770F75EA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(39860400002)(346002)(189003)(199004)(1076002)(4326008)(8936002)(2616005)(105586002)(86362001)(575784001)(6486002)(5640700003)(6436002)(106356001)(5660300001)(10090500001)(8676002)(11346002)(446003)(486006)(14454004)(39060400002)(305945005)(81166006)(86612001)(81156014)(10290500003)(7736002)(6916009)(1730700003)(478600001)(6116002)(107886003)(102836004)(25786009)(476003)(2906002)(46003)(68736007)(53936002)(6512007)(2900100001)(5250100002)(2501003)(97736004)(2351001)(99286004)(22452003)(52116002)(36756003)(256004)(76176011)(316002)(386003)(186003)(54906003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0995;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ak8sT38oN5+aPsu2JRXD69vm4T31zl+AkvHcs2xYb4Nnqo3sDGTWqXZKamxHE0QzCnBbl/61r+MwhPK3FLbFHtrdwAv9NSV1JbX9k8kyy+FZHH0rok0sn6P91WtILNNVH43zx+XHeujC10yxg8s2m0icSf2nWnZhJmpZyz0urfzNY9KQmmTGxHINGWO9Ef8xwY9Jwu91ZwzLMRHfMRPKIdJUsyv9tTI/33fq7ka7iCQNhui4eXCEVkjst0GbsFeNMxVnRrJxF/7py64eEQdMfLgyl6Ane84PaYaaBHhPVn9eLbfwiZRfvxCCJu9cPvJUvctUo+J0cpu3EtXgbb7xf8QBRfwlsGf1/Wm2IuVN9K0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cccd731b-b422-471b-7b3f-08d606ca2496
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 18:24:19.1689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/replace.c | 8 ++++----
 refs.c            | 9 ++++-----
 refs.h            | 2 +-
 replace-object.c  | 5 +++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index e997a562f0..b5861a0ee9 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -39,7 +39,8 @@ struct show_data {
 	enum replace_format format;
 };
=20
-static int show_reference(const char *refname, const struct object_id *oid=
,
+static int show_reference(struct repository *r, const char *refname,
+			  const struct object_id *oid,
 			  int flag, void *cb_data)
 {
 	struct show_data *data =3D cb_data;
@@ -56,9 +57,8 @@ static int show_reference(const char *refname, const stru=
ct object_id *oid,
 			if (get_oid(refname, &object))
 				return error("Failed to resolve '%s' as a valid ref.", refname);
=20
-			obj_type =3D oid_object_info(the_repository, &object,
-						   NULL);
-			repl_type =3D oid_object_info(the_repository, oid, NULL);
+			obj_type =3D oid_object_info(r, &object, NULL);
+			repl_type =3D oid_object_info(r, oid, NULL);
=20
 			printf("%s (%s) -> %s (%s)\n", refname, type_name(obj_type),
 			       oid_to_hex(oid), type_name(repl_type));
diff --git a/refs.c b/refs.c
index 7cd76f72d2..c5a5f727e8 100644
--- a/refs.c
+++ b/refs.c
@@ -1474,12 +1474,11 @@ int refs_for_each_fullref_in(struct ref_store *refs=
, const char *prefix,
 	return do_for_each_ref(refs, prefix, fn, 0, flag, cb_data);
 }
=20
-int for_each_replace_ref(struct repository *r, each_ref_fn fn, void *cb_da=
ta)
+int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *=
cb_data)
 {
-	return do_for_each_ref(get_main_ref_store(r),
-			       git_replace_ref_base, fn,
-			       strlen(git_replace_ref_base),
-			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
+	return do_for_each_repo_ref(r, git_replace_ref_base, fn,
+				    strlen(git_replace_ref_base),
+				    DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
=20
 int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
diff --git a/refs.h b/refs.h
index 80eec8bbc6..a0a18223a1 100644
--- a/refs.h
+++ b/refs.h
@@ -317,7 +317,7 @@ int for_each_fullref_in(const char *prefix, each_ref_fn=
 fn, void *cb_data,
 int for_each_tag_ref(each_ref_fn fn, void *cb_data);
 int for_each_branch_ref(each_ref_fn fn, void *cb_data);
 int for_each_remote_ref(each_ref_fn fn, void *cb_data);
-int for_each_replace_ref(struct repository *r, each_ref_fn fn, void *cb_da=
ta);
+int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *=
cb_data);
 int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
 int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 			 const char *prefix, void *cb_data);
diff --git a/replace-object.c b/replace-object.c
index 4162df6324..3c17864eb7 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -6,7 +6,8 @@
 #include "repository.h"
 #include "commit.h"
=20
-static int register_replace_ref(const char *refname,
+static int register_replace_ref(struct repository *r,
+				const char *refname,
 				const struct object_id *oid,
 				int flag, void *cb_data)
 {
@@ -25,7 +26,7 @@ static int register_replace_ref(const char *refname,
 	oidcpy(&repl_obj->replacement, oid);
=20
 	/* Register new object */
-	if (oidmap_put(the_repository->objects->replace_map, repl_obj))
+	if (oidmap_put(r->objects->replace_map, repl_obj))
 		die("duplicate replace ref: %s", refname);
=20
 	return 0;
--=20
2.18.0.118.gd4f65b8d14

