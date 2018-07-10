Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A8881F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 18:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732486AbeGJSUd (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 14:20:33 -0400
Received: from mail-by2nam03on0128.outbound.protection.outlook.com ([104.47.42.128]:28016
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732568AbeGJSUc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 14:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X428xlhGGXLNNmoK2NOf1M71UVnrsQ5B1nl97X3mKWU=;
 b=AURDYS2fIOFTVps8EHtexBPYDJtqilHxeoNg65sOSrSCGYN2VGQBDKFi0Q+Ka5yLxPj1VjT7Qeg8ubRPNu/ALrkGv0gRjnvjScC4wdwhAYimMNWYlVigKhqXY4zGff3sZAVlmJAUh9NZuEOkflVZczkLpZnSjmAaGGTifrZZGXQ=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Tue, 10 Jul 2018 18:20:22 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::a178:277b:6231:5c4b]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::a178:277b:6231:5c4b%7]) with mapi id 15.20.0952.017; Tue, 10 Jul 2018
 18:20:22 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "peff@peff.net" <peff@peff.net>,
        "stolee@gmail.com" <stolee@gmail.com>
CC:     Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v1] convert log_ref_write_fd() to use strbuf
Thread-Topic: [PATCH v1] convert log_ref_write_fd() to use strbuf
Thread-Index: AQHUGHqqR4G9DlYVk0SUMDxlk74FRw==
Date:   Tue, 10 Jul 2018 18:20:22 +0000
Message-ID: <20180710182000.21404-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.gvfs.1.123.g449c066
x-clientproxiedby: BN7PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:408:20::14) To DM5PR2101MB1016.namprd21.prod.outlook.com
 (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:CijN4t7/vteUENa38RVEqI/DiqxLSmkYB/lG1S5jOQjeRvuZbirFITtUwQBY8vVzKu5J9+vFrdWwaC9YirqgYpqRzXTDZD1602UE6H0/YE2T4tALONn0dB63JSFqc0JswuEtivn9w79eEp64GXJ09LEQbYij/P5mRcucT1xxhBsatVM40V1ZPuUZsGrZcpgjZhgY5LryQfJ4hzJ/ZEoOHBnHV4vG/GAcIBOJmrojKy/PTVw0+35vjn0PF0omWL+g
x-ms-office365-filtering-correlation-id: 7de0a20d-38f7-4ad6-690d-08d5e691cc6f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB1032609CF73726317534554CF45B0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0729050452
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(376002)(396003)(346002)(199004)(189003)(26005)(14454004)(5660300001)(3846002)(6116002)(86612001)(1076002)(53936002)(102836004)(107886003)(2906002)(81166006)(8936002)(68736007)(10090500001)(81156014)(39060400002)(8676002)(256004)(14444005)(54906003)(478600001)(2616005)(22452003)(97736004)(575784001)(476003)(6506007)(110136005)(186003)(99286004)(10290500003)(72206003)(486006)(966005)(5250100002)(2201001)(2501003)(52116002)(386003)(316002)(305945005)(106356001)(6306002)(6512007)(25786009)(6486002)(36756003)(50226002)(66066001)(7736002)(4326008)(2900100001)(6436002)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Y8X047Dzkv0+fUIyktZ0NXYwt40XpajgxPIg8hPwqm1EOVi2JYoBcqq4OVIjIPE4oDDSMxtGjmnqdHYxVvlK89rdfoNkOTOibHcdAGd4wnqDLlvUw6zAOVYfYON7N5sDwuprOgIG2xgWgsKghI6mw/v+EUg4zv7WJwHald5gwOxu/v0P8ZPknk2mwL/s3ukAdSuixbam9IJFcNKX0GnVtn+yOd0IXg1Im+yFTwMT7uaXuT7zxlW9qdh9VDXWOtiG2wQPv9dOMQqcZdspEVT+0AT4a2vW9TMNsBybKHptoC11d2Ug7MgCEQpOz4i8CHgtIVGJBimAdoFuE6EzYgdcuaPRjy317AzPOVIjZPLKMuo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de0a20d-38f7-4ad6-690d-08d5e691cc6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2018 18:20:22.1806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

log_ref_write_fd() was written long before strbuf was fleshed out. Remove
the old manual buffer management code and replace it with strbuf(). Also
update copy_reflog_msg() which is called only by log_ref_write_fd() to use
strbuf as it keeps things consistent.

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---

Notes:
    Base Ref: master
    Web-Diff: https://github.com/benpeart/git/commit/c8d9c48adc
    Checkout: git fetch https://github.com/benpeart/git refs-strbuf-v1 && g=
it checkout c8d9c48adc

 refs.c               | 12 ++++--------
 refs/files-backend.c | 25 +++++++++----------------
 refs/refs-internal.h |  7 +++----
 3 files changed, 16 insertions(+), 28 deletions(-)

diff --git a/refs.c b/refs.c
index 0eb379f931..50fe5c5d2c 100644
--- a/refs.c
+++ b/refs.c
@@ -786,25 +786,21 @@ int delete_ref(const char *msg, const char *refname,
 			       old_oid, flags);
 }
=20
-int copy_reflog_msg(char *buf, const char *msg)
+void copy_reflog_msg(struct strbuf *sb, const char *msg)
 {
-	char *cp =3D buf;
 	char c;
 	int wasspace =3D 1;
=20
-	*cp++ =3D '\t';
+	strbuf_addch(sb, '\t');
 	while ((c =3D *msg++)) {
 		if (wasspace && isspace(c))
 			continue;
 		wasspace =3D isspace(c);
 		if (wasspace)
 			c =3D ' ';
-		*cp++ =3D c;
+		strbuf_addch(sb, c);
 	}
-	while (buf < cp && isspace(cp[-1]))
-		cp--;
-	*cp++ =3D '\n';
-	return cp - buf;
+	strbuf_rtrim(sb);
 }
=20
 int should_autocreate_reflog(const char *refname)
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a9a066dcfb..c0e892d0c8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1582,22 +1582,15 @@ static int log_ref_write_fd(int fd, const struct ob=
ject_id *old_oid,
 			    const struct object_id *new_oid,
 			    const char *committer, const char *msg)
 {
-	int msglen, written;
-	unsigned maxlen, len;
-	char *logrec;
-
-	msglen =3D msg ? strlen(msg) : 0;
-	maxlen =3D strlen(committer) + msglen + 100;
-	logrec =3D xmalloc(maxlen);
-	len =3D xsnprintf(logrec, maxlen, "%s %s %s\n",
-			oid_to_hex(old_oid),
-			oid_to_hex(new_oid),
-			committer);
-	if (msglen)
-		len +=3D copy_reflog_msg(logrec + len - 1, msg) - 1;
-
-	written =3D len <=3D maxlen ? write_in_full(fd, logrec, len) : -1;
-	free(logrec);
+	int written;
+	struct strbuf sb =3D STRBUF_INIT;
+
+	strbuf_addf(&sb, "%s %s %s", oid_to_hex(old_oid), oid_to_hex(new_oid), co=
mmitter);
+	if (msg && *msg)
+		copy_reflog_msg(&sb, msg);
+	strbuf_addch(&sb, '\n');
+	written =3D write_in_full(fd, sb.buf, sb.len);
+	strbuf_release(&sb);
 	if (written < 0)
 		return -1;
=20
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index dd834314bd..17a526078f 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -91,11 +91,10 @@ enum peel_status {
 enum peel_status peel_object(const struct object_id *name, struct object_i=
d *oid);
=20
 /*
- * Copy the reflog message msg to buf, which has been allocated sufficient=
ly
- * large, while cleaning up the whitespaces.  Especially, convert LF to sp=
ace,
- * because reflog file is one line per entry.
+ * Copy the reflog message msg to sb while cleaning up the whitespaces.
+ * Especially, convert LF to space, because reflog file is one line per en=
try.
  */
-int copy_reflog_msg(char *buf, const char *msg);
+void copy_reflog_msg(struct strbuf *sb, const char *msg);
=20
 /**
  * Information needed for a single ref update. Set new_oid to the new

base-commit: e3331758f12da22f4103eec7efe1b5304a9be5e9
--=20
2.17.0.gvfs.1.123.g449c066

