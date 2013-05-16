From: Andrey Borzenkov <arvidjaar@gmail.com>
Subject: Re: Cannot push anything via export transport helper after push
 fails.
Date: Thu, 16 May 2013 21:38:56 +0400
Message-ID: <20130516213856.2deba50d@opensuse.site>
References: <20130511162936.0354e5d7@opensuse.site>
	<CAMP44s1YhQR0o-0CLc2PG-EJTZdN4tha-4BVEUy-K_Av81D=GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 19:39:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud28w-0005aj-CC
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 19:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931Ab3EPRjB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 May 2013 13:39:01 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:49838 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520Ab3EPRi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 13:38:59 -0400
Received: by mail-lb0-f171.google.com with SMTP id v20so3399781lbc.2
        for <git@vger.kernel.org>; Thu, 16 May 2013 10:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:in-reply-to
         :references:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=A7G+aSON9yqDJsKGKic75U3SvnC8eGzYhu6GZXu82XM=;
        b=LDJIos/hxTbhhVsAqrL4WvEH+oOZpT71tg2A9woifknC85ZRPsbSi/4u620ak7l1Iu
         +nCncPdrF7A7uiIsx1sJqqEljnuSm4oeilAQj3Ja6/BCOCi9jzJrqrW6nLs6O8VjfyJ2
         HQyzCdENbxMZvOcdm8uDFVdKCyi/bj2+kiVZTk0sCwNaNtYjsrCGLDiByBSjvn8oQ4Cx
         B8MI8e3s0yorGRt0eZIEHqM3W8M7BZ7002Z0ycJMd3Inmb0Gn0j8MQTFjk4YmK+e0krj
         TCtpMMMocGDLETKu501Rw6OLKJevTJ2IGFqfkpX34TSNwlWbANx4+Q3FVj0e8rm/nUhd
         H7bQ==
X-Received: by 10.152.5.37 with SMTP id p5mr21059640lap.13.1368725938124;
        Thu, 16 May 2013 10:38:58 -0700 (PDT)
Received: from opensuse.site (ppp79-139-160-84.pppoe.spdop.ru. [79.139.160.84])
        by mx.google.com with ESMTPSA id n7sm1362506lbd.12.2013.05.16.10.38.57
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 10:38:57 -0700 (PDT)
In-Reply-To: <CAMP44s1YhQR0o-0CLc2PG-EJTZdN4tha-4BVEUy-K_Av81D=GQ@mail.gmail.com>
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.14; x86_64-suse-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224603>

=F7 Sat, 11 May 2013 08:57:14 -0500
=46elipe Contreras <felipe.contreras@gmail.com> =D0=C9=DB=C5=D4:

> On Sat, May 11, 2013 at 7:29 AM, Andrey Borzenkov <arvidjaar@gmail.co=
m> wrote:
> > I noticed that using git-remote-bzr, but as far as I can tell this =
is
> > generic for all transport helpers using fast-export.
> >
> >
> >
> > What happened was "git push" failed due to merge conflict. So far s=
o
> > good - but from now on git assumes everything is up to date.
> >
> > bor@opensuse:/tmp/test/git> git push origin master
> > To bzr::bzr+ssh://bor@localhost/tmp/test/bzr
> >  ! [rejected]        master -> master (non-fast-forward)
> > error: failed to push some refs to 'bzr::bzr+ssh://bor@localhost/tm=
p/test/bzr'
> > hint: Updates were rejected because the tip of your current branch =
is behind
> > hint: its remote counterpart. Merge the remote changes (e.g. 'git p=
ull')
> > hint: before pushing again.
> > hint: See the 'Note about fast-forwards' in 'git push --help' for d=
etails.
> > bor@opensuse:/tmp/test/git> git push origin master
> > Everything up-to-date
> > bor@opensuse:/tmp/test/git>
> >
> > The problem seems to be that git fast-export updates marks
> > unconditionally, whether export actually applied or not. So next ti=
me
> > it assumes everything is already exported and does nothing.
> >
> > Is it expected behavior?
>=20
> Indeed, this is the way it currently works, and it's not easy to fix.
> We would need some way to make fast-export wait until we know the exi=
t
> status of the remote helper, and then tell it when it failed, so the
> marks are not updated.
>=20

Hmm ... actually as far as I understand transport-helper keeps track of
which revisions to push in "remote helper ref" (for the lack of better
word). This makes use of marks as tracking means rather redundant.

What about the idea below? This relies on transport helper to provide
correct revisions and uses marks exclusively as cross-reference between
GIT and remote SCM. It is on top of next branch.


---
 builtin/fast-export.c                 | 15 ++++++++++-----
 contrib/remote-helpers/git-remote-bzr | 11 ++++++++---
 transport-helper.c                    |  7 ++++++-
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d60d675..5bc4b3c 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -29,6 +29,7 @@ static enum { ERROR, DROP, REWRITE } tag_of_filtered_=
mode =3D ERROR;
 static int fake_missing_tagger;
 static int use_done_feature;
 static int no_data;
+static int do_not_skip_marked_commits;
 static int full_tree;
=20
 static int parse_opt_signed_tag_mode(const struct option *opt,
@@ -95,7 +96,8 @@ static inline void mark_object(struct object *object,=
 uint32_t mark)
=20
 static inline void mark_next_object(struct object *object)
 {
-	mark_object(object, ++last_idnum);
+	if (!(do_not_skip_marked_commits && lookup_decoration(&idnums, object=
)))
+		mark_object(object, ++last_idnum);
 }
=20
 static int get_object_mark(struct object *object)
@@ -144,7 +146,7 @@ static void export_blob(const unsigned char *sha1)
=20
 	mark_next_object(object);
=20
-	printf("blob\nmark :%"PRIu32"\ndata %lu\n", last_idnum, size);
+	printf("blob\nmark :%"PRIu32"\ndata %lu\n", get_object_mark(object), =
size);
 	if (size && fwrite(buf, size, 1, stdout) !=3D 1)
 		die_errno ("Could not write blob '%s'", sha1_to_hex(sha1));
 	printf("\n");
@@ -326,7 +328,7 @@ static void handle_commit(struct commit *commit, st=
ruct rev_info *rev)
 	if (!commit->parents)
 		printf("reset %s\n", (const char*)commit->util);
 	printf("commit %s\nmark :%"PRIu32"\n%.*s\n%.*s\ndata %u\n%s",
-	       (const char *)commit->util, last_idnum,
+	       (const char *)commit->util, get_object_mark(&commit->object),
 	       (int)(author_end - author), author,
 	       (int)(committer_end - committer), committer,
 	       (unsigned)(reencoded
@@ -631,7 +633,7 @@ static void import_marks(char *input_file)
 		if (!object)
 			continue;
=20
-		if (object->flags & SHOWN)
+		if (get_object_mark(object))
 			error("Object %s already has a mark", sha1_to_hex(sha1));
=20
 		if (object->type !=3D OBJ_COMMIT)
@@ -640,7 +642,8 @@ static void import_marks(char *input_file)
=20
 		mark_object(object, mark);
=20
-		object->flags |=3D SHOWN;
+		if (!do_not_skip_marked_commits)
+			object->flags |=3D SHOWN;
 	}
 	fclose(f);
 }
@@ -673,6 +676,8 @@ int cmd_fast_export(int argc, const char **argv, co=
nst char *prefix)
 		OPT_BOOLEAN(0, "use-done-feature", &use_done_feature,
 			     N_("Use the done feature to terminate the stream")),
 		OPT_BOOL(0, "no-data", &no_data, N_("Skip output of blob data")),
+		OPT_BOOL(0, "do-not-skip-marked-commits", &do_not_skip_marked_commit=
s,
+			     N_("Do not skip marked commits")),
 		OPT_END()
 	};
=20
diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-hel=
pers/git-remote-bzr
index 3e452af..24a9a99 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -629,7 +629,12 @@ def parse_commit(parser):
=20
     committer, date, tz =3D committer
     parents =3D [mark_to_rev(p) for p in parents]
-    revid =3D bzrlib.generate_ids.gen_revision_id(committer, date)
+    try:
+        revid =3D mark_to_rev(commit_mark)
+    except KeyError:
+        revid =3D bzrlib.generate_ids.gen_revision_id(committer, date)
+        marks.new_mark(revid, commit_mark)
+
     props =3D {}
     props['branch-nick'] =3D branch.nick
=20
@@ -650,7 +655,6 @@ def parse_commit(parser):
         branch.unlock()
=20
     parsed_refs[ref] =3D revid
-    marks.new_mark(revid, commit_mark)
=20
 def parse_reset(parser):
     global parsed_refs
@@ -692,12 +696,12 @@ def do_export(parser):
         if ref.startswith('refs/heads/'):
             name =3D ref[len('refs/heads/'):]
             branch =3D bzrlib.branch.Branch.open(branches[name])
-            branch.generate_revision_history(revid, marks.get_tip(name=
))
=20
             if name in peers:
                 peer =3D bzrlib.branch.Branch.open(peers[name])
                 try:
                     peer.bzrdir.push_branch(branch, revision_id=3Drevi=
d)
+                    branch.generate_revision_history(revid, marks.get_=
tip(name))
                 except bzrlib.errors.DivergedBranches:
                     print "error %s non-fast forward" % ref
                     continue
@@ -732,6 +736,7 @@ def do_capabilities(parser):
     if os.path.exists(path):
         print "*import-marks %s" % path
     print "*export-marks %s" % path
+    print "*full-marks"
=20
     print
=20
diff --git a/transport-helper.c b/transport-helper.c
index 2f5ac3f..3f1f2d7 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -27,6 +27,7 @@ struct helper_data {
 		push : 1,
 		connect : 1,
 		signed_tags : 1,
+		full_marks : 1,
 		no_disconnect_req : 1;
 	char *export_marks;
 	char *import_marks;
@@ -195,6 +196,8 @@ static struct child_process *get_helper(struct tran=
sport *transport)
 			data->connect =3D 1;
 		} else if (!strcmp(capname, "signed-tags")) {
 			data->signed_tags =3D 1;
+		} else if (!strcmp(capname, "full-marks")) {
+			data->full_marks =3D 1;
 		} else if (!prefixcmp(capname, "export-marks ")) {
 			struct strbuf arg =3D STRBUF_INIT;
 			strbuf_addstr(&arg, "--export-marks=3D");
@@ -415,11 +418,13 @@ static int get_exporter(struct transport *transpo=
rt,
 	/* we need to duplicate helper->in because we want to use it after
 	 * fastexport is done with it. */
 	fastexport->out =3D dup(helper->in);
-	fastexport->argv =3D xcalloc(6 + revlist_args->nr, sizeof(*fastexport=
->argv));
+	fastexport->argv =3D xcalloc(7 + revlist_args->nr, sizeof(*fastexport=
->argv));
 	fastexport->argv[argc++] =3D "fast-export";
 	fastexport->argv[argc++] =3D "--use-done-feature";
 	fastexport->argv[argc++] =3D data->signed_tags ?
 		"--signed-tags=3Dverbatim" : "--signed-tags=3Dwarn-strip";
+	if (data->full_marks)
+		fastexport->argv[argc++] =3D "--do-not-skip-marked-commits";
 	if (data->export_marks)
 		fastexport->argv[argc++] =3D data->export_marks;
 	if (data->import_marks)
--=20
tg: (2a9af4b..) t/marks-shown (depends on: next)
