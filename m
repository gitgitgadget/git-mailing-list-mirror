Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B5C3195FB
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764774412; cv=none; b=pDnrOL5XTSRjmxMr2WYVl+jRF85K5PvXYunShYCFTknR6AW1aCY2XUwynS6WKL1W61c+90XSvVmIcVer621FAQUeUGULDRkQndDlJsW+NzTtG6Gthh7x6ThHI0SbbpyheD2Vs3z7izV/W3s7wmWvX9ozGzqCGMYL6cQ2J9Za8T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764774412; c=relaxed/simple;
	bh=JDiETMZj2STH3jFHRvzkWbl/lEe/k4PMsBSYrsJi91Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=b3EAK3yvgR//+U97Zi5aA2/2FraCz4gtfSktdg9b9HQe+xzpRgnbbzt7AIUyGMuTS+lPLa3G+KbtFgc8MkKo84swTaq5lcUcr56pVDbtJcLbA50icSA1suygKokAjnn/noPJ5/oGiw3HFFemWmCVsfn6MYV7vpuMqW4+XPM0NKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=qJrSH47y; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="qJrSH47y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764774407; x=1765379207; i=l.s.r@web.de;
	bh=sxDbrSs9ZU7JPsPkkhatgpj/98h+AQz9Cv5Ugqm8b10=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qJrSH47yY1uQUN9HdlnDHriufFPO7oYfTv+rPoOqYStpatHg/Dw7Pl6Rlo7MaDK4
	 s+j22Nc4kLBZ7C/sI5nhNquSGfV4oRuZnDHltezRZQ0fjnMa2cWMXaSxRiiY12Dtm
	 30gOivPxgXzDLwOCFMBNMluynErBC7eVL6niDLBOFy+Ua44oQ4/5nfopO7gYTTQC/
	 J+2uNUKRkprML59cU5HGA7BfyGy9TSQr4gpoS7YlKKsOqg/Kcoakv+DMZmQ44lxP5
	 YRmK/6F+HzrteEPMMCb0QqCnOcrWCz8lZJ91CpD/HBl2tunNVODJ9iwQrqlex1pIT
	 mvUVBTMWP5nVZ7ek1Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.29.250]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjPQ6-1vu8ir1WTi-00hxM8; Wed, 03
 Dec 2025 16:06:47 +0100
Message-ID: <5581a8d8-afe3-4097-8a27-7e52c7e915ce@web.de>
Date: Wed, 3 Dec 2025 16:06:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] diff-index: don't queue unchanged filepairs with
 diff_change()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <aa28974b-ec73-4562-bfc8-4745ad58b55a@web.de>
 <xmqq5xarcsb8.fsf@gitster.g> <9a253514-376f-49fd-99fe-f076ecb180b6@web.de>
Content-Language: en-US
In-Reply-To: <9a253514-376f-49fd-99fe-f076ecb180b6@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8qYsHzFORgFubldXtJXf9k8tbVnF8hD5c7J0cwfVPNsd21nkOtx
 dE3olneBP003x4v7X+Mn/rNlQ+b3LAqes9rTHtodHxL4O5O8r0V7DNiBknGvwz5BPcXEU//
 uZL/8SATLphTcrft5E1r27oN34U11pjnwTYewgxJB98PYxBRYy5A3U2c7QIWPwPbZpOIYpx
 0W3NspyYRtiLcLbg+O27Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CAoTEB9zDqY=;4l5+w/zrPCMICanffbEu7MXkJ7p
 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
 Z6OGfb4eLYetsma+xQlDeG5NyGxOZ

On 12/2/25 11:07 PM, Ren=C3=83=C2=A9 Scharfe wrote:
> On 11/30/25 7:02 PM, Junio C Hamano wrote:
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>> Add a new streamlined function for queuing unchanged filepairs and
>>> use it in show_modified(), which is called by diff_cache() via
>>> oneway_diff() and do_oneway_diff().  It allocates only a single filesp=
ec
>>> for each filepair and uses it twice with reference counting.  This has=
 a
>>> measurable effect if there are a lot of them, like in the Linux repo:
>>>
>>> Benchmark 1: ./git_v2.52.0 -C ../linux diff --cached --find-copies-har=
der
>>>   Time (mean =C2=B1 =CF=83):      31.8 ms =C2=B1   0.2 ms    [User: 24=
.2 ms, System: 6.3 ms]
>>>   Range (min =E2=80=A6 max):    31.5 ms =E2=80=A6  32.3 ms    85 runs
>>>
>>> Benchmark 2: ./git -C ../linux diff --cached --find-copies-harder
>>>   Time (mean =C2=B1 =CF=83):      23.9 ms =C2=B1   0.2 ms    [User: 18=
.1 ms, System: 4.6 ms]
>>>   Range (min =E2=80=A6 max):    23.5 ms =E2=80=A6  24.4 ms    111 runs
>>>
>>> Summary
>>>   ./git -C ../linux diff --cached --find-copies-harder ran
>>>     1.33 =C2=B1 0.01 times faster than ./git_v2.52.0 -C ../linux diff =
=2D-cached --find-copies-harder
>>
>> Nice.  Is this technique only applicable to diff-index among the
>> three diff plumbing siblings?
>=20
>> [...] it would apply to diff-tree, wouldn't it?
> Yes, but its diff_change() call is behind two layers of callbacks, which
> complicates things.
>=20
> And I don't know how to avoid adding an object ID comparison.  Do we
> perhaps have that bit somewhere in tree-diff.c already and can pass it
> along the pathchange call?

Yes, new patch below.  Not sure if it's better, though.

> Benchmark 1: ./git_v2.52.0 diff-tree --find-copies-harder -r v2.51.0 v2.=
51.1
>   Time (mean =C2=B1 =CF=83):      78.3 ms =C2=B1   0.2 ms    [User: 57.4=
 ms, System: 19.8 ms]
>   Range (min =E2=80=A6 max):    77.9 ms =E2=80=A6  78.7 ms    36 runs
>=20
> Benchmark 2: ./git diff-tree --find-copies-harder -r v2.51.0 v2.51.1
>   Time (mean =C2=B1 =CF=83):      78.8 ms =C2=B1   0.2 ms    [User: 57.9=
 ms, System: 19.8 ms]
>   Range (min =E2=80=A6 max):    78.4 ms =E2=80=A6  79.2 ms    36 runs
>=20
> Summary
>   ./git_v2.52.0 diff-tree --find-copies-harder -r v2.51.0 v2.51.1 ran
>     1.01 =C2=B1 0.00 times faster than ./git diff-tree --find-copies-har=
der -r v2.51.0 v2.51.1
Benchmark 1: ./git_v2.52.0 diff-tree --find-copies-harder -r v2.51.0 v2.51=
.1
  Time (mean =C2=B1 =CF=83):      75.6 ms =C2=B1   0.6 ms    [User: 57.4 m=
s, System: 17.2 ms]
  Range (min =E2=80=A6 max):    75.0 ms =E2=80=A6  78.0 ms    37 runs

Benchmark 2: ./git diff-tree --find-copies-harder -r v2.51.0 v2.51.1
  Time (mean =C2=B1 =CF=83):      76.0 ms =C2=B1   0.2 ms    [User: 57.9 m=
s, System: 17.1 ms]
  Range (min =E2=80=A6 max):    75.6 ms =E2=80=A6  76.4 ms    37 runs

Summary
  ./git_v2.52.0 diff-tree --find-copies-harder -r v2.51.0 v2.51.1 ran
    1.00 =C2=B1 0.01 times faster than ./git diff-tree --find-copies-harde=
r -r v2.51.0 v2.51.1

Hmm, I probably ran some background task when I measured yesterday and got
worse results for the git_v2.52.0 baseline than today.

Ren=C3=A9

=2D--
 builtin/reset.c |  1 +
 diff.c          |  1 +
 diff.h          |  9 +++++++--
 diffcore.h      |  4 ++--
 tree-diff.c     | 48 +++++++++++++++++++++++++++---------------------
 5 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index ed35802af1..ec674694dd 100644
=2D-- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -210,6 +210,7 @@ static int read_from_tree(const struct pathspec *paths=
pec,
 	opt.repo =3D the_repository;
 	opt.change =3D diff_change;
 	opt.add_remove =3D diff_addremove;
+	opt.keep =3D diff_same;
=20
 	if (pathspec->nr && pathspec_needs_expanded_index(the_repository->index,=
 pathspec))
 		ensure_full_index(the_repository->index);
diff --git a/diff.c b/diff.c
index 436da250eb..9671524d2b 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -4847,6 +4847,7 @@ void repo_diff_setup(struct repository *r, struct di=
ff_options *options)
 	/* pathchange left =3DNULL by default */
 	options->change =3D diff_change;
 	options->add_remove =3D diff_addremove;
+	options->keep =3D diff_same;
 	options->use_color =3D diff_use_color_default;
 	options->detect_rename =3D diff_detect_rename_default;
 	options->xdl_opts |=3D diff_algorithm;
diff --git a/diff.h b/diff.h
index 7eb84aadf4..2e3a5ac04a 100644
=2D-- a/diff.h
+++ b/diff.h
@@ -43,7 +43,8 @@ struct oidset;
  * set_default in diff_options can be used to tweak this more.
  *
  * - As you find different pairs of files, call `diff_change()` to feed
- * modified files, `diff_addremove()` to feed created or deleted files, o=
r
+ * modified files, `diff_addremove()` to feed created or deleted files,
+ * `diff_same()` to feed unmodified files if needed for copy detection, o=
r
  * `diff_unmerge()` to feed a file whose state is 'unmerged' to the API.
  * These are thin wrappers to a lower-level `diff_queue()` function that =
is
  * flexible enough to record any of these kinds of changes.
@@ -76,7 +77,7 @@ struct rev_info;
 struct userdiff_driver;
=20
 typedef int (*pathchange_fn_t)(struct diff_options *options,
-		 struct combine_diff_path *path);
+		 struct combine_diff_path *path, bool is_change);
=20
 typedef void (*change_fn_t)(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
@@ -92,6 +93,9 @@ typedef void (*add_remove_fn_t)(struct diff_options *opt=
ions,
 		    int oid_valid,
 		    const char *fullpath, unsigned dirty_submodule);
=20
+typedef void (*keep_fn_t)(struct diff_options *options, unsigned mode,
+			  const struct object_id *oid, const char *fullpath);
+
 typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 		struct diff_options *options, void *data);
=20
@@ -384,6 +388,7 @@ struct diff_options {
 	pathchange_fn_t pathchange;
 	change_fn_t change;
 	add_remove_fn_t add_remove;
+	keep_fn_t keep;
 	void *change_fn_data;
 	diff_format_fn_t format_callback;
 	void *format_callback_data;
diff --git a/diffcore.h b/diffcore.h
index 9c0a0e7aaf..64b419b33f 100644
=2D-- a/diffcore.h
+++ b/diffcore.h
@@ -35,8 +35,8 @@ struct userdiff_driver;
 /**
  * the internal representation for a single file (blob).  It records the =
blob
  * object name (if known -- for a work tree file it typically is a NUL SH=
A-1),
- * filemode and pathname.  This is what the `diff_addremove()`, `diff_cha=
nge()`
- * and `diff_unmerge()` synthesize and feed `diff_queue()` function with.
+ * filemode and pathname.  This is what `diff_addremove()`, `diff_change(=
)`,
+ * `diff_same()` and `diff_unmerge()` synthesize and feed `diff_queue()`.
  */
 struct diff_filespec {
 	struct object_id oid;
diff --git a/tree-diff.c b/tree-diff.c
index 5988148b60..e711456766 100644
=2D-- a/tree-diff.c
+++ b/tree-diff.c
@@ -163,12 +163,17 @@ static int tree_entry_pathcmp(struct tree_desc *t1, =
struct tree_desc *t2)
  * emits diff to first parent only, and tells diff tree-walker that we ar=
e done
  * with p and it can be freed.
  */
-static int emit_diff_first_parent_only(struct diff_options *opt, struct c=
ombine_diff_path *p)
+static int emit_diff_first_parent_only(struct diff_options *opt,
+				       struct combine_diff_path *p,
+				       bool is_change)
 {
 	struct combine_diff_parent *p0 =3D &p->parent[0];
 	if (p->mode && p0->mode) {
-		opt->change(opt, p0->mode, p->mode, &p0->oid, &p->oid,
-			1, 1, p->path, 0, 0);
+		if (is_change)
+			opt->change(opt, p0->mode, p->mode, &p0->oid, &p->oid,
+				    1, 1, p->path, 0, 0);
+		else if (opt->keep)
+			opt->keep(opt, p->mode, &p->oid, p->path);
 	}
 	else {
 		const struct object_id *oid;
@@ -205,7 +210,7 @@ static int emit_diff_first_parent_only(struct diff_opt=
ions *opt, struct combine_
 static void emit_path(struct combine_diff_path ***tail,
 		      struct strbuf *base, struct diff_options *opt,
 		      int nparent, struct tree_desc *t, struct tree_desc *tp,
-		      int imin, int depth)
+		      int imin, int depth, bool is_change)
 {
 	unsigned short mode;
 	const char *path;
@@ -288,7 +293,7 @@ static void emit_path(struct combine_diff_path ***tail=
,
=20
 		keep =3D 1;
 		if (opt->pathchange)
-			keep =3D opt->pathchange(opt, p);
+			keep =3D opt->pathchange(opt, p, is_change);
=20
 		if (keep) {
 			**tail =3D p;
@@ -518,26 +523,27 @@ static void ll_diff_tree_paths(
 		/* t =3D p[imin] */
 		if (cmp =3D=3D 0) {
 			/* are either pi > p[imin] or diff(t,pi) !=3D =C3=B8 ? */
-			if (!opt->flags.find_copies_harder) {
-				for (i =3D 0; i < nparent; ++i) {
-					/* p[i] > p[imin] */
-					if (tp[i].entry.mode & S_IFXMIN_NEQ)
-						continue;
+			bool is_change =3D true;
=20
-					/* diff(t,pi) !=3D =C3=B8 */
-					if (!oideq(&t.entry.oid, &tp[i].entry.oid) ||
-					    (t.entry.mode !=3D tp[i].entry.mode))
-						continue;
+			for (i =3D 0; i < nparent; ++i) {
+				/* p[i] > p[imin] */
+				if (tp[i].entry.mode & S_IFXMIN_NEQ)
+					continue;
=20
-					goto skip_emit_t_tp;
-				}
+				/* diff(t,pi) !=3D =C3=B8 */
+				if (!oideq(&t.entry.oid, &tp[i].entry.oid) ||
+				    (t.entry.mode !=3D tp[i].entry.mode))
+					continue;
+
+				is_change =3D false;
+				break;
 			}
=20
 			/* D +=3D {=CE=B4(t,pi) if pi=3Dp[imin];  "+a" if pi > p[imin]} */
-			emit_path(tail, base, opt, nparent,
-				  &t, tp, imin, depth);
+			if (is_change || opt->flags.find_copies_harder)
+				emit_path(tail, base, opt, nparent,
+					  &t, tp, imin, depth, is_change);
=20
-		skip_emit_t_tp:
 			/* t=E2=86=93,  =E2=88=80 pi=3Dp[imin]  pi=E2=86=93 */
 			update_tree_entry(&t);
 			update_tp_entries(tp, nparent);
@@ -547,7 +553,7 @@ static void ll_diff_tree_paths(
 		else if (cmp < 0) {
 			/* D +=3D "+t" */
 			emit_path(tail, base, opt, nparent,
-				  &t, /*tp=3D*/NULL, -1, depth);
+				  &t, /*tp=3D*/NULL, -1, depth, true);
=20
 			/* t=E2=86=93 */
 			update_tree_entry(&t);
@@ -563,7 +569,7 @@ static void ll_diff_tree_paths(
 			}
=20
 			emit_path(tail, base, opt, nparent,
-				  /*t=3D*/NULL, tp, imin, depth);
+				  /*t=3D*/NULL, tp, imin, depth, true);
=20
 		skip_emit_tp:
 			/* =E2=88=80 pi=3Dp[imin]  pi=E2=86=93 */
=2D-=20
2.52.0

