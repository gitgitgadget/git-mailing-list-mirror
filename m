Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E338F1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 21:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbeIGBlT (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 21:41:19 -0400
Received: from mail-dm3nam03on0128.outbound.protection.outlook.com ([104.47.41.128]:53953
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729281AbeIGBlT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 21:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nvbkqUE3RJi9S6pa/kupI7IKHm2CsaAp14pcmyMUmQ=;
 b=XSrWs2Xoo6KoEZ+ATKLTo8bZhAAH5TypQzSpLXmckrdSLlTo3Ze/mTxsfvp90XTu/1kZXMiFzmjwmmHI6/8LOzm43pnHF28A+hGDU62y6antgOL14GDa89tlk7/Fp0R0ybEqII9kFPoFb9ILHp0Qq0AXT4Xv/6KJv/D3ODxHDiA=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1033.namprd21.prod.outlook.com (52.132.146.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Thu, 6 Sep 2018 21:03:56 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::d41c:2bea:5b2d:a858]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::d41c:2bea:5b2d:a858%4]) with mapi id 15.20.1143.008; Thu, 6 Sep 2018
 21:03:56 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v3 2/4] eoie: add End of Index Entry (EOIE) extension
Thread-Topic: [PATCH v3 2/4] eoie: add End of Index Entry (EOIE) extension
Thread-Index: AQHURiUfSAERUoxwPEmZafo5UijAfA==
Date:   Thu, 6 Sep 2018 21:03:56 +0000
Message-ID: <20180906210227.54368-3-benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180906210227.54368-1-benpeart@microsoft.com>
In-Reply-To: <20180906210227.54368-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: DM5PR1101CA0021.namprd11.prod.outlook.com
 (2603:10b6:4:4c::31) To MW2PR2101MB0970.namprd21.prod.outlook.com
 (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1033;6:SWf25odEc4BiNSSF2s9bO3RyY88LSxRkleVy2h2cdv3mIStTaA67/c1FsWsCjcidy25mLX6ErdP14in2sE6xhgmw7le/MIHcIPwQJ0yiDO8TFI0BLeEqPOFQDuuQxf9W971ZxWV/Ha2qdyvCncBS6dPoZf40fuoJa+LGXfoXp4+M8gt5G3mKmwToe1LqRrU9c+6nxXoQzzQpyHGqoAdDZSiVI1VpWb50GFz478Ldtz69Pz0d0GGqAqHNKB/KshDf9GAYhy2gfG7oMiVhHDpFojXvpTIE+pdSVQmX1Ircb53XqsrSbjieIPfd5qrxxlTVS27qs8ZAAELsSFyZUJueLIXbaRirbMmlukOVVE3wVFHGxYnUsbQ0du1OrrLBnS8o2Wjc6ka/eKUJE6BV7cE+rOhGD9HTPJFqteoZvSCeFFEob+jZRSaMcMrd38TjOrSylXJxZUxAT6ALsYbh9GHZ2Q==;5:Kabm2rsRlGJMayGs7O7/obko/kXHFAq/fasAz7EeuMuHJZ/JZubpCg1tMsi2V4Cd3rkVB8S0H4UH/Lm3/l1QIza43UryT3kRdxLBsLo6ChCzb6nZlBYlAVoGfLConU7IPYUGNhI0QzKcNQ1g6qgGPqs6Y4KHlhoxO0xjPeVGlL8=;7:OyiVJqfO+VrykHtnXMQS+sqZZ0ewSFSHWETW4fkGI73Kq7WPfRQDcX16ZtXJKukQBmmd7oZRVVhuGdI7BHwUFHq27RyPaxE360MuY0TPRet/6HpKyR6GI84ya/YF9n2d7+PaA5EOYsdiDWZbAq+tmBf7S3FOVEKCW9vC27/BqrO5EUohDvdwSmUqngUWYMw/ynynrYfxBxax7QgegKomV85MYHV7NSj1vyVkwvCDJ0FLzQ2LFE4fx73YUBhvvqEl
x-ms-office365-filtering-correlation-id: 689b7757-97e8-4ae2-a720-08d6143c421d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1033;
x-ms-traffictypediagnostic: MW2PR2101MB1033:
x-microsoft-antispam-prvs: <MW2PR2101MB10337C96708A92283C5CB447F4010@MW2PR2101MB1033.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(163750095850);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:MW2PR2101MB1033;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1033;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(39860400002)(396003)(199004)(189003)(476003)(2616005)(446003)(22452003)(102836004)(486006)(68736007)(39060400002)(2501003)(5250100002)(2351001)(1076002)(3846002)(53936002)(6116002)(50226002)(36756003)(186003)(6346003)(26005)(52116002)(76176011)(107886003)(14444005)(575784001)(25786009)(386003)(316002)(6506007)(54906003)(8936002)(99286004)(11346002)(4326008)(72206003)(86612001)(6916009)(10090500001)(7736002)(5660300001)(14454004)(10290500003)(478600001)(2906002)(256004)(105586002)(305945005)(8676002)(81156014)(81166006)(1730700003)(66066001)(2900100001)(106356001)(6436002)(97736004)(6486002)(6512007)(5640700003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1033;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: LlFFlgblwR3WWFei4e3OJ4FN0086sRJZFowsVtTUsXTJPIOVtptueAGFsJbcTiSNOJt0uOEaW0QGjugwSEhH8X3ORqYrpMTcD+N0muiETjVA44n/zGI5sULM6eVLAr+1iF8/66o+bca8j98r5d+fhHfA8s8gyRIndjYRaADWMmpCnAJmLhhHIJbeMNOtiZ91m6Ri4K5sr4oJAfJx5u6M+RPRoBwWVj9Si4ju4gwi/vHAbrEOF9qRfvuIQ0sLzfpG+bfBMUvQIkKI3z9VSHYEz4Z+po7mUtcdsfwkH1xb/TwBTYkW1Yly2THz2T72fPkYk4sBpYLlb1aQVJ7IBdSrocyZgYfv9CECeUfairuXB6w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 689b7757-97e8-4ae2-a720-08d6143c421d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 21:03:56.5743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1033
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The End of Index Entry (EOIE) is used to locate the end of the variable
length index entries and the beginning of the extensions. Code can take
advantage of this to quickly locate the index extensions without having
to parse through all of the index entries.

Because it must be able to be loaded before the variable length cache
entries and other index extensions, this extension must be written last.
The signature for this extension is { 'E', 'O', 'I', 'E' }.

The extension consists of:

- 32-bit offset to the end of the index entries

- 160-bit SHA-1 over the extension types and their sizes (but not
their contents).  E.g. if we have "TREE" extension that is N-bytes
long, "REUC" extension that is M-bytes long, followed by "EOIE",
then the hash would be:

SHA-1("TREE" + <binary representation of N> +
	"REUC" + <binary representation of M>)

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---
 Documentation/technical/index-format.txt |  23 ++++
 read-cache.c                             | 149 +++++++++++++++++++++--
 t/README                                 |   5 +
 t/t1700-split-index.sh                   |   1 +
 4 files changed, 170 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/techn=
ical/index-format.txt
index db3572626b..6bc2d90f7f 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -314,3 +314,26 @@ The remaining data of each directory block is grouped =
by type:
=20
   - An ewah bitmap, the n-th bit indicates whether the n-th index entry
     is not CE_FSMONITOR_VALID.
+
+=3D=3D End of Index Entry
+
+  The End of Index Entry (EOIE) is used to locate the end of the variable
+  length index entries and the begining of the extensions. Code can take
+  advantage of this to quickly locate the index extensions without having
+  to parse through all of the index entries.
+
+  Because it must be able to be loaded before the variable length cache
+  entries and other index extensions, this extension must be written last.
+  The signature for this extension is { 'E', 'O', 'I', 'E' }.
+
+  The extension consists of:
+
+  - 32-bit offset to the end of the index entries
+
+  - 160-bit SHA-1 over the extension types and their sizes (but not
+	their contents).  E.g. if we have "TREE" extension that is N-bytes
+	long, "REUC" extension that is M-bytes long, followed by "EOIE",
+	then the hash would be:
+
+	SHA-1("TREE" + <binary representation of N> +
+		"REUC" + <binary representation of M>)
diff --git a/read-cache.c b/read-cache.c
index 382cc16bdc..d0d2793780 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -43,6 +43,7 @@
 #define CACHE_EXT_LINK 0x6c696e6b	  /* "link" */
 #define CACHE_EXT_UNTRACKED 0x554E5452	  /* "UNTR" */
 #define CACHE_EXT_FSMONITOR 0x46534D4E	  /* "FSMN" */
+#define CACHE_EXT_ENDOFINDEXENTRIES 0x454F4945	/* "EOIE" */
=20
 /* changes that can be kept in $GIT_DIR/index (basically all extensions) *=
/
 #define EXTMASK (RESOLVE_UNDO_CHANGED | CACHE_TREE_CHANGED | \
@@ -1693,6 +1694,9 @@ static int read_index_extension(struct index_state *i=
state,
 	case CACHE_EXT_FSMONITOR:
 		read_fsmonitor_extension(istate, data, sz);
 		break;
+	case CACHE_EXT_ENDOFINDEXENTRIES:
+		/* already handled in do_read_index() */
+		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
 			return error("index uses %.4s extension, which we do not understand",
@@ -1888,6 +1892,11 @@ static size_t estimate_cache_size(size_t ondisk_size=
, unsigned int entries)
 	return ondisk_size + entries * per_entry;
 }
=20
+#ifndef NO_PTHREADS
+static unsigned long read_eoie_extension(void *mmap, size_t mmap_size);
+#endif
+static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_con=
text, unsigned long offset);
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int must_e=
xist)
 {
@@ -2197,11 +2206,15 @@ static int ce_write(git_hash_ctx *context, int fd, =
void *data, unsigned int len)
 	return 0;
 }
=20
-static int write_index_ext_header(git_hash_ctx *context, int fd,
-				  unsigned int ext, unsigned int sz)
+static int write_index_ext_header(git_hash_ctx *context, git_hash_ctx *eoi=
e_context,
+				  int fd, unsigned int ext, unsigned int sz)
 {
 	ext =3D htonl(ext);
 	sz =3D htonl(sz);
+	if (eoie_context) {
+		the_hash_algo->update_fn(eoie_context, &ext, 4);
+		the_hash_algo->update_fn(eoie_context, &sz, 4);
+	}
 	return ((ce_write(context, fd, &ext, 4) < 0) ||
 		(ce_write(context, fd, &sz, 4) < 0)) ? -1 : 0;
 }
@@ -2444,7 +2457,7 @@ static int do_write_index(struct index_state *istate,=
 struct tempfile *tempfile,
 {
 	uint64_t start =3D getnanotime();
 	int newfd =3D tempfile->fd;
-	git_hash_ctx c;
+	git_hash_ctx c, eoie_c;
 	struct cache_header hdr;
 	int i, err =3D 0, removed, extended, hdr_version;
 	struct cache_entry **cache =3D istate->cache;
@@ -2453,6 +2466,7 @@ static int do_write_index(struct index_state *istate,=
 struct tempfile *tempfile,
 	struct ondisk_cache_entry_extended ondisk;
 	struct strbuf previous_name_buf =3D STRBUF_INIT, *previous_name;
 	int drop_cache_tree =3D istate->drop_cache_tree;
+	unsigned long offset;
=20
 	for (i =3D removed =3D extended =3D 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -2519,11 +2533,13 @@ static int do_write_index(struct index_state *istat=
e, struct tempfile *tempfile,
 		return err;
=20
 	/* Write extension data here */
+	offset =3D lseek(newfd, 0, SEEK_CUR) + write_buffer_len;
+	the_hash_algo->init_fn(&eoie_c);
 	if (!strip_extensions && istate->split_index) {
 		struct strbuf sb =3D STRBUF_INIT;
=20
 		err =3D write_link_extension(&sb, istate) < 0 ||
-			write_index_ext_header(&c, newfd, CACHE_EXT_LINK,
+			write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_LINK,
 					       sb.len) < 0 ||
 			ce_write(&c, newfd, sb.buf, sb.len) < 0;
 		strbuf_release(&sb);
@@ -2534,7 +2550,7 @@ static int do_write_index(struct index_state *istate,=
 struct tempfile *tempfile,
 		struct strbuf sb =3D STRBUF_INIT;
=20
 		cache_tree_write(&sb, istate->cache_tree);
-		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_TREE, sb.len) < 0
+		err =3D write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_TREE, sb.le=
n) < 0
 			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
 		strbuf_release(&sb);
 		if (err)
@@ -2544,7 +2560,7 @@ static int do_write_index(struct index_state *istate,=
 struct tempfile *tempfile,
 		struct strbuf sb =3D STRBUF_INIT;
=20
 		resolve_undo_write(&sb, istate->resolve_undo);
-		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_RESOLVE_UNDO,
+		err =3D write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_RESOLVE_UND=
O,
 					     sb.len) < 0
 			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
 		strbuf_release(&sb);
@@ -2555,7 +2571,7 @@ static int do_write_index(struct index_state *istate,=
 struct tempfile *tempfile,
 		struct strbuf sb =3D STRBUF_INIT;
=20
 		write_untracked_extension(&sb, istate->untracked);
-		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_UNTRACKED,
+		err =3D write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_UNTRACKED,
 					     sb.len) < 0 ||
 			ce_write(&c, newfd, sb.buf, sb.len) < 0;
 		strbuf_release(&sb);
@@ -2566,7 +2582,23 @@ static int do_write_index(struct index_state *istate=
, struct tempfile *tempfile,
 		struct strbuf sb =3D STRBUF_INIT;
=20
 		write_fsmonitor_extension(&sb, istate);
-		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_FSMONITOR, sb.len) <=
 0
+		err =3D write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_FSMONITOR, =
sb.len) < 0
+			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		strbuf_release(&sb);
+		if (err)
+			return -1;
+	}
+
+	/*
+	 * CACHE_EXT_ENDOFINDEXENTRIES must be written as the last entry before t=
he SHA1
+	 * so that it can be found and processed before all the index entries are
+	 * read.
+	 */
+	if (!strip_extensions && offset && !git_env_bool("GIT_TEST_DISABLE_EOIE",=
 0)) {
+		struct strbuf sb =3D STRBUF_INIT;
+
+		write_eoie_extension(&sb, &eoie_c, offset);
+		err =3D write_index_ext_header(&c, NULL, newfd, CACHE_EXT_ENDOFINDEXENTR=
IES, sb.len) < 0
 			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
 		strbuf_release(&sb);
 		if (err)
@@ -2977,3 +3009,104 @@ int should_validate_cache_entries(void)
=20
 	return validate_index_cache_entries;
 }
+
+#define EOIE_SIZE 24 /* <4-byte offset> + <20-byte hash> */
+#define EOIE_SIZE_WITH_HEADER (4 + 4 + EOIE_SIZE) /* <4-byte signature> + =
<4-byte length> + EOIE_SIZE */
+
+#ifndef NO_PTHREADS
+static unsigned long read_eoie_extension(void *mmap, size_t mmap_size)
+{
+	/*
+	 * The end of index entries (EOIE) extension is guaranteed to be last
+	 * so that it can be found by scanning backwards from the EOF.
+	 *
+	 * "EOIE"
+	 * <4-byte length>
+	 * <4-byte offset>
+	 * <20-byte hash>
+	 */
+	const char *index, *eoie =3D (const char *)mmap + mmap_size - GIT_SHA1_RA=
WSZ - EOIE_SIZE_WITH_HEADER;
+	uint32_t extsize;
+	unsigned long offset, src_offset;
+	unsigned char hash[GIT_MAX_RAWSZ];
+	git_hash_ctx c;
+
+	/* validate the extension signature */
+	index =3D eoie;
+	if (CACHE_EXT(index) !=3D CACHE_EXT_ENDOFINDEXENTRIES)
+		return 0;
+	index +=3D sizeof(uint32_t);
+
+	/* validate the extension size */
+	extsize =3D get_be32(index);
+	if (extsize !=3D EOIE_SIZE)
+		return 0;
+	index +=3D sizeof(uint32_t);
+
+	/*
+	 * Validate the offset we're going to look for the first extension
+	 * signature is after the index header and before the eoie extension.
+	 */
+	offset =3D get_be32(index);
+	if ((const char *)mmap + offset < (const char *)mmap + sizeof(struct cach=
e_header))
+		return 0;
+	if ((const char *)mmap + offset >=3D eoie)
+		return 0;
+	index +=3D sizeof(uint32_t);
+
+	/*
+	 * The hash is computed over extension types and their sizes (but not
+	 * their contents).  E.g. if we have "TREE" extension that is N-bytes
+	 * long, "REUC" extension that is M-bytes long, followed by "EOIE",
+	 * then the hash would be:
+	 *
+	 * SHA-1("TREE" + <binary representation of N> +
+	 *               "REUC" + <binary representation of M>)
+	 */
+	src_offset =3D offset;
+	the_hash_algo->init_fn(&c);
+	while (src_offset < mmap_size - the_hash_algo->rawsz - EOIE_SIZE_WITH_HEA=
DER) {
+		/* After an array of active_nr index entries,
+		 * there can be arbitrary number of extended
+		 * sections, each of which is prefixed with
+		 * extension name (4-byte) and section length
+		 * in 4-byte network byte order.
+		 */
+		uint32_t extsize;
+		memcpy(&extsize, (char *)mmap + src_offset + 4, 4);
+		extsize =3D ntohl(extsize);
+
+		/* verify the extension size isn't so large it will wrap around */
+		if (src_offset + 8 + extsize < src_offset)
+			return 0;
+
+		the_hash_algo->update_fn(&c, (const char *)mmap + src_offset, 8);
+
+		src_offset +=3D 8;
+		src_offset +=3D extsize;
+	}
+	the_hash_algo->final_fn(hash, &c);
+	if (hashcmp(hash, (unsigned char *)index))
+		return 0;
+
+	/* Validate that the extension offsets returned us back to the eoie exten=
sion. */
+	if (src_offset !=3D mmap_size - the_hash_algo->rawsz - EOIE_SIZE_WITH_HEA=
DER)
+		return 0;
+
+	return offset;
+}
+#endif
+
+static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_con=
text, unsigned long offset)
+{
+	uint32_t buffer;
+	unsigned char hash[GIT_MAX_RAWSZ];
+
+	/* offset */
+	put_be32(&buffer, offset);
+	strbuf_add(sb, &buffer, sizeof(uint32_t));
+
+	/* hash */
+	the_hash_algo->final_fn(hash, eoie_context);
+	strbuf_add(sb, hash, the_hash_algo->rawsz);
+}
diff --git a/t/README b/t/README
index 9028b47d92..d8754dd23a 100644
--- a/t/README
+++ b/t/README
@@ -319,6 +319,11 @@ GIT_TEST_OE_DELTA_SIZE=3D<n> exercises the uncomon pac=
k-objects code
 path where deltas larger than this limit require extra memory
 allocation for bookkeeping.
=20
+GIT_TEST_DISABLE_EOIE=3D<boolean> disables writing the EOIE extension.
+This is used to allow tests 1, 4-9 in t1700-split-index.sh to succeed
+as they currently hard code SHA values for the index which are no longer
+valid due to the addition of the EOIE extension.
+
 Naming Tests
 ------------
=20
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 39133bcbc8..f613dd72e3 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -7,6 +7,7 @@ test_description=3D'split index mode tests'
 # We need total control of index splitting here
 sane_unset GIT_TEST_SPLIT_INDEX
 sane_unset GIT_FSMONITOR_TEST
+export GIT_TEST_DISABLE_EOIE=3Dtrue
=20
 test_expect_success 'enable split index' '
 	git config splitIndex.maxPercentChange 100 &&
--=20
2.18.0.windows.1

