Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7F2C432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 20:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83415610C8
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 20:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242077AbhHYURj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 16:17:39 -0400
Received: from mout.web.de ([217.72.192.78]:46889 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240589AbhHYURj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 16:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1629922607;
        bh=+HoKqio3IFH7JHRy5zp3SqheS9QuS2w/saYuA1Bno7Y=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=ARpZtrUW4fwf0p45TAk2TFJMmuGLmV5l3t3bDL2tCwpj+eMUJUHv5+wteIbde38+B
         oJKCTMISB2HabeTYapMGpCUtLBk5QWzZbliQmSkKY4Zwx0XCSNsx5nwsR2084kMMqK
         MRT4tfQCOOAy/v/haO8Bpkt7mEy/TmIqJG/Fqc2o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.27.185]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MAvGa-1m939v29XI-009xDH; Wed, 25 Aug 2021 22:16:47 +0200
Subject: [PATCH 2/2] use xopen() to handle fatal open(2) failures
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <6a5c3e8e-0216-8b63-38fa-b7b19331d752@web.de>
Message-ID: <5f319f04-e4f3-678d-f35f-88eef2ce3e5f@web.de>
Date:   Wed, 25 Aug 2021 22:16:46 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <6a5c3e8e-0216-8b63-38fa-b7b19331d752@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Af1mmS3Z4DT6A5BCkpvkkENv2EQsG1C5p+UCR2mrg6whBbmm7d8
 BC3Sr0hPeTMqXEdo/sOnrGfXeVBPImN0emMMqqqsrqWEKTz0r8qdD9z0XojvBDLQTuYFg2H
 nGryo6CE2fTZGOtJ/VoDQeWB5bc/EJa/JsWaxVc2vRCaWXbkeTt8WZ6HeUmiU0puHdBRscv
 EaedEKYOf1nefFK2XKStg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kvJljrmmH5o=:HXZg/ChQXJjIjX6HSN4w4P
 +pqSmkVFFGmCT41H8n5yp0AUDo9RocR078s8SMKEyLmqFJmo/bmI5DGcPHrfIIMi4yuNml3WW
 d7RaGmYE05EXMSpsUvwoPnfp+6Aj7y7mesxx0n1ZkICbi/lfAkqSXMToQh70FeFV4HRw8RtT/
 UPciATSg0DRI03FEwfK0pGlbYkafiDkONXpx/sUWM1OTC2PXkD+yXAEgIk/a3SClMxBAPbkVu
 6lsy/s/V4d8CRoUGx3XNUWqS36pmF/w51uM5QeKtLmQDE3SktxLPqWiY1ajbgRckT+qpjOzTo
 rPUBEsxwVi85OiCIakNqbC78sJuWeUaD1kS5gTUfhqwj4CEsYZjcnU/EpjOn3a/dYJmMo3h9l
 PYlGF5VQAAObR/R71p7K0RBBXQf9Bw/eYzY8HCWiZZ+WMrvVUa6EAXFcPLQqhTnMnGwtWcZkK
 WYhtbjqLXtNpsjqACsfQGggEFM0wKzG0GZCM2IaWzhu7XnqIfj3V9bBcDXz4Z2LUHJ2eBXb4c
 jRuTW9LBqILxx8+O/8DTPgVKnC5TkTM7gtM5JnKw6hKpM1wxHznSQk/RiQ9NejnYhFhgdEfE9
 Ms5c9Jn/GAw5ofPvRopHCPeZSIIWcYq62qqvdV32PAIydvkwnnhTNxt5c8bDEGMPfxzlTsQEk
 Nos0QDXOOfjlpXbgBHy/g+is2SRkmE5r9L/ipUVvO7m5JqLYIuy+qJGP7y+JUyLPuvx1uUbTF
 ZhV8dIwQRHdo0CqsnS2f66H3PMcorHZ/565kL20fMykAWElQuTuByvq5E+DzrkUOAidrhu5y+
 AYkJMo7i6/njo2dIWbWQBOAUX4M8Wxb432r+NAj5EnArmcsv36eFZ5ZgC8ioUH0CgORVHsUwt
 D4tc8U7+gjDpJ7FfU2Kfr5BXQOLIDMqFd4oupwLHny35B2wjern8rVPlhMexUq5exPkxqrZyd
 EYLmFjdhFKrxUZtauOwMz1iRGN5dySEvxa29PdB83TPKy1jYkM+IsSQ/lxKiZqcP9n2ISkGgI
 IsRI75t6vptk96GA3DqdTjoODQwkmJqHE53lTqxjOm928+Z/Ei3HEpiLUFWNOIkqy++c5261l
 Sriq8xs5G3V5fcXc0yebqlgqpSk3DEVfotZ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add and apply a semantic patch for using xopen() instead of calling
open(2) and die() or die_errno() explicitly.  This makes the error
messages more consistent and shortens the code.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/add.c                  |  4 +---
 builtin/archive.c              |  4 +---
 builtin/bugreport.c            |  5 +----
 builtin/commit-tree.c          |  4 +---
 builtin/hash-object.c          |  4 +---
 builtin/index-pack.c           |  8 ++------
 builtin/mailsplit.c            |  4 +---
 builtin/merge.c                |  4 +---
 builtin/notes.c                |  4 +---
 builtin/tag.c                  |  4 +---
 builtin/update-index.c         |  4 +---
 contrib/coccinelle/xopen.cocci | 16 ++++++++++++++++
 csum-file.c                    |  8 ++------
 pack-write.c                   |  8 ++------
 run-command.c                  |  4 +---
 15 files changed, 33 insertions(+), 52 deletions(-)
 create mode 100644 contrib/coccinelle/xopen.cocci

diff --git a/builtin/add.c b/builtin/add.c
index 17528e8f92..8ec5ad9f26 100644
=2D-- a/builtin/add.c
+++ b/builtin/add.c
@@ -319,9 +319,7 @@ static int edit_patch(int argc, const char **argv, con=
st char *prefix)
 	rev.diffopt.output_format =3D DIFF_FORMAT_PATCH;
 	rev.diffopt.use_color =3D 0;
 	rev.diffopt.flags.ignore_dirty_submodules =3D 1;
-	out =3D open(file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
-	if (out < 0)
-		die(_("Could not open '%s' for writing."), file);
+	out =3D xopen(file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
 	rev.diffopt.file =3D xfdopen(out, "w");
 	rev.diffopt.close_file =3D 1;
 	if (run_diff_files(&rev, 0))
diff --git a/builtin/archive.c b/builtin/archive.c
index 45d11669aa..7176b041b6 100644
=2D-- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -12,9 +12,7 @@

 static void create_output_file(const char *output_file)
 {
-	int output_fd =3D open(output_file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
-	if (output_fd < 0)
-		die_errno(_("could not create archive file '%s'"), output_file);
+	int output_fd =3D xopen(output_file, O_CREAT | O_WRONLY | O_TRUNC, 0666)=
;
 	if (output_fd !=3D 1) {
 		if (dup2(output_fd, 1) < 0)
 			die_errno(_("could not redirect output"));
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 9915a5841d..06ed10dc92 100644
=2D-- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -171,10 +171,7 @@ int cmd_bugreport(int argc, const char **argv, const =
char *prefix)
 	get_populated_hooks(&buffer, !startup_info->have_repository);

 	/* fopen doesn't offer us an O_EXCL alternative, except with glibc. */
-	report =3D open(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);
-
-	if (report < 0)
-		die(_("couldn't create a new file at '%s'"), report_path.buf);
+	report =3D xopen(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);

 	if (write_in_full(report, buffer.buf, buffer.len) < 0)
 		die_errno(_("unable to write to %s"), report_path.buf);
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 1031b9a491..63ea322933 100644
=2D-- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -88,9 +88,7 @@ static int parse_file_arg_callback(const struct option *=
opt,
 	if (!strcmp(arg, "-"))
 		fd =3D 0;
 	else {
-		fd =3D open(arg, O_RDONLY);
-		if (fd < 0)
-			die_errno(_("git commit-tree: failed to open '%s'"), arg);
+		fd =3D xopen(arg, O_RDONLY);
 	}
 	if (strbuf_read(buf, fd, 0) < 0)
 		die_errno(_("git commit-tree: failed to read '%s'"), arg);
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 640ef4ded5..2e6e2ddd0c 100644
=2D-- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -53,9 +53,7 @@ static void hash_object(const char *path, const char *ty=
pe, const char *vpath,
 			unsigned flags, int literally)
 {
 	int fd;
-	fd =3D open(path, O_RDONLY);
-	if (fd < 0)
-		die_errno("Cannot open '%s'", path);
+	fd =3D xopen(path, O_RDONLY);
 	hash_fd(fd, type, vpath, flags, literally);
 }

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8336466865..6cc4890217 100644
=2D-- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -338,15 +338,11 @@ static const char *open_pack_file(const char *pack_n=
ame)
 						"pack/tmp_pack_XXXXXX");
 			pack_name =3D strbuf_detach(&tmp_file, NULL);
 		} else {
-			output_fd =3D open(pack_name, O_CREAT|O_EXCL|O_RDWR, 0600);
-			if (output_fd < 0)
-				die_errno(_("unable to create '%s'"), pack_name);
+			output_fd =3D xopen(pack_name, O_CREAT|O_EXCL|O_RDWR, 0600);
 		}
 		nothread_data.pack_fd =3D output_fd;
 	} else {
-		input_fd =3D open(pack_name, O_RDONLY);
-		if (input_fd < 0)
-			die_errno(_("cannot open packfile '%s'"), pack_name);
+		input_fd =3D xopen(pack_name, O_RDONLY);
 		output_fd =3D -1;
 		nothread_data.pack_fd =3D input_fd;
 	}
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 664400b816..7baef30569 100644
=2D-- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -75,9 +75,7 @@ static int split_one(FILE *mbox, const char *name, int a=
llow_bare)
 		fprintf(stderr, "corrupt mailbox\n");
 		exit(1);
 	}
-	fd =3D open(name, O_WRONLY | O_CREAT | O_EXCL, 0666);
-	if (fd < 0)
-		die_errno("cannot open output file '%s'", name);
+	fd =3D xopen(name, O_WRONLY | O_CREAT | O_EXCL, 0666);
 	output =3D xfdopen(fd, "w");

 	/* Copy it out, while searching for a line that begins with
diff --git a/builtin/merge.c b/builtin/merge.c
index 22f23990b3..47614d8070 100644
=2D-- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1136,9 +1136,7 @@ static void handle_fetch_head(struct commit_list **r=
emotes, struct strbuf *merge
 		merge_names =3D &fetch_head_file;

 	filename =3D git_path_fetch_head(the_repository);
-	fd =3D open(filename, O_RDONLY);
-	if (fd < 0)
-		die_errno(_("could not open '%s' for reading"), filename);
+	fd =3D xopen(filename, O_RDONLY);

 	if (strbuf_read(merge_names, fd, 0) < 0)
 		die_errno(_("could not read '%s'"), filename);
diff --git a/builtin/notes.c b/builtin/notes.c
index 74bba39ca8..71c59583a1 100644
=2D-- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -172,9 +172,7 @@ static void prepare_note_data(const struct object_id *=
object, struct note_data *

 		/* write the template message before editing: */
 		d->edit_path =3D git_pathdup("NOTES_EDITMSG");
-		fd =3D open(d->edit_path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
-		if (fd < 0)
-			die_errno(_("could not create file '%s'"), d->edit_path);
+		fd =3D xopen(d->edit_path, O_CREAT | O_TRUNC | O_WRONLY, 0600);

 		if (d->given)
 			write_or_die(fd, d->buf.buf, d->buf.len);
diff --git a/builtin/tag.c b/builtin/tag.c
index 452558ec95..065b6bf093 100644
=2D-- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -293,9 +293,7 @@ static void create_tag(const struct object_id *object,=
 const char *object_ref,

 		/* write the template message before editing: */
 		path =3D git_pathdup("TAG_EDITMSG");
-		fd =3D open(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
-		if (fd < 0)
-			die_errno(_("could not create file '%s'"), path);
+		fd =3D xopen(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);

 		if (opt->message_given) {
 			write_or_die(fd, buf->buf, buf->len);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index f1f16f2de5..187203e8bb 100644
=2D-- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -95,9 +95,7 @@ static int create_file(const char *path)
 {
 	int fd;
 	path =3D get_mtime_path(path);
-	fd =3D open(path, O_CREAT | O_RDWR, 0644);
-	if (fd < 0)
-		die_errno(_("failed to create file %s"), path);
+	fd =3D xopen(path, O_CREAT | O_RDWR, 0644);
 	return fd;
 }

diff --git a/contrib/coccinelle/xopen.cocci b/contrib/coccinelle/xopen.coc=
ci
new file mode 100644
index 0000000000..814d7b8a1a
=2D-- /dev/null
+++ b/contrib/coccinelle/xopen.cocci
@@ -0,0 +1,16 @@
+@@
+identifier fd;
+identifier die_fn =3D~ "^(die|die_errno)$";
+@@
+(
+  fd =3D
+- open
++ xopen
+  (...);
+|
+  int fd =3D
+- open
++ xopen
+  (...);
+)
+- if ( \( fd < 0 \| fd =3D=3D -1 \) ) { die_fn(...); }
diff --git a/csum-file.c b/csum-file.c
index c951cf8277..26e8a6df44 100644
=2D-- a/csum-file.c
+++ b/csum-file.c
@@ -131,12 +131,8 @@ struct hashfile *hashfd_check(const char *name)
 	int sink, check;
 	struct hashfile *f;

-	sink =3D open("/dev/null", O_WRONLY);
-	if (sink < 0)
-		die_errno("unable to open /dev/null");
-	check =3D open(name, O_RDONLY);
-	if (check < 0)
-		die_errno("unable to open '%s'", name);
+	sink =3D xopen("/dev/null", O_WRONLY);
+	check =3D xopen(name, O_RDONLY);
 	f =3D hashfd(sink, name);
 	f->check_fd =3D check;
 	f->check_buffer =3D xmalloc(f->buffer_len);
diff --git a/pack-write.c b/pack-write.c
index f1fc3ecafa..2767b78619 100644
=2D-- a/pack-write.c
+++ b/pack-write.c
@@ -75,9 +75,7 @@ const char *write_idx_file(const char *index_name, struc=
t pack_idx_entry **objec
 			index_name =3D strbuf_detach(&tmp_file, NULL);
 		} else {
 			unlink(index_name);
-			fd =3D open(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
-			if (fd < 0)
-				die_errno("unable to create '%s'", index_name);
+			fd =3D xopen(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
 		}
 		f =3D hashfd(fd, index_name);
 	}
@@ -256,9 +254,7 @@ const char *write_rev_file_order(const char *rev_name,
 			rev_name =3D strbuf_detach(&tmp_file, NULL);
 		} else {
 			unlink(rev_name);
-			fd =3D open(rev_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
-			if (fd < 0)
-				die_errno("unable to create '%s'", rev_name);
+			fd =3D xopen(rev_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
 		}
 		f =3D hashfd(fd, rev_name);
 	} else if (flags & WRITE_REV_VERIFY) {
diff --git a/run-command.c b/run-command.c
index f72e72cce7..2961f7e55e 100644
=2D-- a/run-command.c
+++ b/run-command.c
@@ -761,9 +761,7 @@ int start_command(struct child_process *cmd)
 		notify_pipe[0] =3D notify_pipe[1] =3D -1;

 	if (cmd->no_stdin || cmd->no_stdout || cmd->no_stderr) {
-		null_fd =3D open("/dev/null", O_RDWR | O_CLOEXEC);
-		if (null_fd < 0)
-			die_errno(_("open /dev/null failed"));
+		null_fd =3D xopen("/dev/null", O_RDWR | O_CLOEXEC);
 		set_cloexec(null_fd);
 	}

=2D-
2.33.0
