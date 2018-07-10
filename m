Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBE041F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 21:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732282AbeGJVMX (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 17:12:23 -0400
Received: from mail-sn1nam02on0107.outbound.protection.outlook.com ([104.47.36.107]:14500
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732200AbeGJVMW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 17:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MhbpM1Hm+mKWxfvmLIrayp/V+2A3CJN362Ep0AtWI0=;
 b=Mwh1APZubKlvYxnFitojld8Zlpk3rF+8p06FoQRNdLQSZKfQ20yWVk4dzlRfLuvnvObMXs6lFLCPsQOTiYPYQjgSjw9nYmhsJw521W3A4VHV61HOjlDS1AGMnCoiYDS5nxh70RllP4qx8cg6S0jx2zbSN6u/RLwJ2r/g3ZfhhRE=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB0869.namprd21.prod.outlook.com (10.167.110.162) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Tue, 10 Jul 2018 21:08:22 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::a178:277b:6231:5c4b]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::a178:277b:6231:5c4b%7]) with mapi id 15.20.0952.017; Tue, 10 Jul 2018
 21:08:22 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "stolee@gmail.com" <stolee@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v2] convert log_ref_write_fd() to use strbuf
Thread-Topic: [PATCH v2] convert log_ref_write_fd() to use strbuf
Thread-Index: AQHUGJIikZmMTcxicEe7PXc7bU9LgQ==
Date:   Tue, 10 Jul 2018 21:08:22 +0000
Message-ID: <20180710210806.23384-1-benpeart@microsoft.com>
References: <20180710182000.21404-1-benpeart@microsoft.com>
In-Reply-To: <20180710182000.21404-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.gvfs.1.123.g449c066
x-clientproxiedby: MWHPR21CA0049.namprd21.prod.outlook.com
 (2603:10b6:300:db::11) To DM5PR2101MB1016.namprd21.prod.outlook.com
 (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0869;7:EDOJGHRo9wTEKEvPPKs0FWPZchIb3dk36rFkYyulS1L6Xg/HsThobeRfbdMIcZAjZXrl4IGI8BCnoyjLvdWyA2iWjZ434CC/xTnjVpbdMXDazyyuSYK0bst/W6j7POzKqZy/GmmdcCpXKkBB59Cg4LN0dVlVP3/Ph5oMlbXciveRHBSQRvSuiiJHCpA8Yea48kYMreU1MK4It9ApZWttrt4E85ma3RYnFolpBsmi0L1P1e+a1Ed63S1FwLuV/Kfi
x-ms-office365-filtering-correlation-id: fd6fece5-2499-4d04-6ed2-08d5e6a944b0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0869;
x-ms-traffictypediagnostic: DM5PR2101MB0869:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB08698CB4DE73C8D027796AC4F45B0@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM5PR2101MB0869;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0869;
x-forefront-prvs: 0729050452
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(39860400002)(396003)(366004)(199004)(189003)(8936002)(1511001)(81156014)(8676002)(66066001)(81166006)(966005)(10290500003)(6306002)(6512007)(6116002)(68736007)(3846002)(2616005)(14454004)(575784001)(72206003)(11346002)(5660300001)(478600001)(6486002)(446003)(6636002)(86612001)(2906002)(1076002)(50226002)(486006)(256004)(53936002)(36756003)(14444005)(476003)(25786009)(6862004)(99286004)(26005)(39060400002)(22452003)(4326008)(316002)(6506007)(107886003)(10090500001)(2900100001)(5250100002)(76176011)(52116002)(386003)(54906003)(6436002)(7736002)(305945005)(97736004)(37006003)(105586002)(106356001)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0869;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Brapz3sIb/U7sudPIehYTxkt9vBfplxxKN/Jsqw+phJejYZadFGz+uO7TjtP042OEsoiDfCtnDBYNHZjueALo+DuPpbPjY3BuizODEnLl5/DYGruSbiDm9EbdwDaIlY839TPKjY1nVI3+BaiUusnEz8r2nz5xO7B2RnJT4xsDLUUGEG6YASItXsbFOwNZAfNfSSUva6lXtl4m0IUpjdzjeSmHFxvIoJAgQj3BlksL49mstjpmvMz5gL7KEO/OW4ky4mTht9reBkEyNWd7dDZlhZ2f85MVoZeF5OWoKnurElTYq+79TP2UN/VlxSLCgaaVEz/RrqtOh2TkqwzVSZ8bwE38bOEIyhz0pwzOsS7kYw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6fece5-2499-4d04-6ed2-08d5e6a944b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2018 21:08:22.5062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0869
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we don't care about how many bytes were written, simplify the return
value logic.

log_ref_write_fd() was written long before strbuf was fleshed out. Remove
the old manual buffer management code and replace it with strbuf(). Also
update copy_reflog_msg() which is called only by log_ref_write_fd() to use
strbuf as it keeps things consistent.

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---

Notes:
    Base Ref: master
    Web-Diff: https://github.com/benpeart/git/commit/b72cd95643
    Checkout: git fetch https://github.com/benpeart/git refs-strbuf-v2 && g=
it checkout b72cd95643
   =20
    ### Interdiff (v1..v2):
   =20
    diff --git a/refs/files-backend.c b/refs/files-backend.c
    index c0e892d0c8..054306d779 100644
    --- a/refs/files-backend.c
    +++ b/refs/files-backend.c
    @@ -1582,19 +1582,17 @@ static int log_ref_write_fd(int fd, const struc=
t object_id *old_oid,
     			    const struct object_id *new_oid,
     			    const char *committer, const char *msg)
     {
    -	int written;
     	struct strbuf sb =3D STRBUF_INIT;
    +	int ret =3D 0;
   =20
     	strbuf_addf(&sb, "%s %s %s", oid_to_hex(old_oid), oid_to_hex(new_oid)=
, committer);
     	if (msg && *msg)
     		copy_reflog_msg(&sb, msg);
     	strbuf_addch(&sb, '\n');
    -	written =3D write_in_full(fd, sb.buf, sb.len);
    +	if (write_in_full(fd, sb.buf, sb.len) < 0)
    +		ret =3D -1;
     	strbuf_release(&sb);
    -	if (written < 0)
    -		return -1;
    -
    -	return 0;
    +	return ret;
     }
   =20
     static int files_log_ref_write(struct files_ref_store *refs,
   =20
    ### Patches

 refs.c               | 12 ++++--------
 refs/files-backend.c | 29 ++++++++++-------------------
 refs/refs-internal.h |  7 +++----
 3 files changed, 17 insertions(+), 31 deletions(-)

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
index a9a066dcfb..054306d779 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1582,26 +1582,17 @@ static int log_ref_write_fd(int fd, const struct ob=
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
-	if (written < 0)
-		return -1;
+	struct strbuf sb =3D STRBUF_INIT;
+	int ret =3D 0;
=20
-	return 0;
+	strbuf_addf(&sb, "%s %s %s", oid_to_hex(old_oid), oid_to_hex(new_oid), co=
mmitter);
+	if (msg && *msg)
+		copy_reflog_msg(&sb, msg);
+	strbuf_addch(&sb, '\n');
+	if (write_in_full(fd, sb.buf, sb.len) < 0)
+		ret =3D -1;
+	strbuf_release(&sb);
+	return ret;
 }
=20
 static int files_log_ref_write(struct files_ref_store *refs,
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

