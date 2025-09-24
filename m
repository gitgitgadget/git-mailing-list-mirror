Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CDA28D8ED
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 20:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758747457; cv=none; b=dw0ZIdOK/ZltNwn97AhGdAxAqs2Cjyl7B7UoWJgzwYshZO6R9BlJEnXrDgZkqOZzqRhk/BzgjktonDPDsFBa98XJA3+rZKPoSB1xd9V9rRrfOD7xTlGClB/Kd8GqGy1lAeGZ5XdO6WF63CiyGJuHl+oKNoHq41ItQagsvoFjSKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758747457; c=relaxed/simple;
	bh=GQce3HG/UFxFb7VD/3ZKF42+3S5ExlxzczqzZNMuNPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OK6qxEd6CpME4gVcxSP9O62q90LMo23xsDtmCD2BVEwe2D0jkVmz0lD/jFaMtdrFSQmhYtf1DIYeOPj1Mpx69AQNWlZSKN+CGGFUKyageD9R0Gi4I0wj+PMYi7hWohYpplXOjAKvoluEGICdIE+DIEJJOXKhOLxJI/3PFrK8keI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fk1ZkJs2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fk1ZkJs2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758747456; x=1790283456;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=GQce3HG/UFxFb7VD/3ZKF42+3S5ExlxzczqzZNMuNPo=;
  b=Fk1ZkJs2GjyxlalGpcB6teOBeKbcDl8SPRt/CxU7BL2BxqynpUJYl0bv
   nzzNqnbjzmnq1TWsFH8rki28/lRbH6jrGuXGMctZ8ncBmSMRrV/fZcEVr
   8u3SQzK9VnVdy0YBopTIt3KHV1o1dYs8ZSCzy5diG65J5/aNLKJJBrThh
   3fPUHdjE1xtVwd1rZFAjt5jjdzhHjg91xhusmloI57EDLicJBlpHYuvc7
   AsPBsi7jfDP++JNPwkCkn4pPGnN/7k67uw9A922FXajuAcSMBoKk/v5/f
   Jtge5sLPQEIk+yMXRnF5ARCQ3xrvxD72EIIbA3lwd9lQAFQobq6tAkMHZ
   A==;
X-CSE-ConnectionGUID: gsW+1LhJSkmbnaZLDoAEkA==
X-CSE-MsgGUID: 4o6J6ektSmWx1qObrn7PwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="64698314"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="64698314"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 13:57:35 -0700
X-CSE-ConnectionGUID: t1qWUUYtQ92YQT9vJUX6ew==
X-CSE-MsgGUID: vEIL4/fwTIObJy28sha34w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="177904156"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 13:57:34 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 24 Sep 2025 13:57:15 -0700
Subject: [PATCH] diff --no-index: fix logic for paths ending in '/'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-jk-fix-no-index-path-with-slash-v1-1-6b2028c0de92@intel.com>
X-B4-Tracking: v=1; b=H4sIACtb1GgC/x2NSwqEMBAFryK9ngYT/GS8yjCLqK1pR6KkBxXEu
 9u4KSgo3jtBKDEJNNkJiTYWXqKKeWXQBR9HQu7Vwea2zN+2wOmHAx8YF+TY04Gr/wfcWSGzl4C
 1c7UrWzJVZ0BX1kTaPw+f73XdH1CkfHEAAAA=
X-Change-ID: 20250924-jk-fix-no-index-path-with-slash-788785be16c1
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org, 
 Junio C Hamano <gitster@pobox.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.15-dev-cbe0e
X-Developer-Signature: v=1; a=openpgp-sha256; l=9372;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=GQce3HG/UFxFb7VD/3ZKF42+3S5ExlxzczqzZNMuNPo=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhowr0XabJwe+FC8/q39iZszyfsF3bOuKDMp3a1nKquwI0
 tx5S7u6o5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgIlYijMy/GFa1G+g96Hv0VQO
 Ld6j8aesT5QevNjVfEvozob98QVJSxn+179VFeArlg388YhxvZt5viFDiICrSPLZ6Tf572Zq/Ar
 kAQA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

If one of the two provided paths for git diff --no-index ends in a '/',
a failure similar to the following occurs:

  $ git diff --no-index -- /tmp/ /tmp/ ':!'
  fatal: `pos + len' is too far after the end of the buffer

This occurs because of an incorrect calculation of the skip lengths in
diff_no_index(). The code wants to calculate the length of the string,
but add one in case the string doesn't end with a slash.

The method it uses is incorrect, as it always checks the trailing NUL
character of the string. This will never be a '/', so we always add one.
In the event that we *do* have a trailing slash, this will create an
off-by-one length error later when using the skip value.

The most straightforward fix would be to correct the skip1 and skip2
lengths by using ends_with().

However, Johannes made a good point that the existing logic is wasting a
lot of computation. We generate the match string by copying the path in
and then skipping almost all of it immediately with a potentially
expensive memmove() from the strbuf_remove() call. We also re-initialize
the match stringbuf each time we call read_directory_contents.

The read_directory_contents really wants a path that is rooted at the
start of the directory scan. We're currently building this by taking the
full path and stripping out the start portion. Instead, replace this
logic by building up the portion of the match as we go.

Start by initializing two strbuf in diff_no_index containing the empty
string. Pass these into queue_diff, which in turn passes the appropriate
left or right side into read_directory_contents.

As before, we build up the matches by appending elements to the match
path and then clearing them using strbuf_setlen.

In the recursive portion of the queue_diff algorithm, we build up new
match paths the same way that we build up new buffer paths, by appending
the elements and then clearing them with strbuf_setlen after each
iteration. This is cheaper as it avoids repeated allocations, and is a
bit simpler to track what is going on.

Add a couple of test cases that pass in paths already ending in '/', to
ensure the tests cover this regression.

Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Closes: https://lore.kernel.org/git/c75ec5f9-407a-6555-d4fb-bb629d54ec61@gmx.de/
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
This fix might feel overly complex. We can drop this and just go with a
simple ends_with() fix, but that leaves the needless strbuf_remove() in the
read_directory_contents.

I tried some alternatives in that function, including trying to use
&path[skip], but this doesn't quite work since path might not end with a
slash, while the skip length does need to account for the possible slash,
since we don't want to end up accidentally using an absolute path.
---
 diff-no-index.c          | 61 ++++++++++++++++++++++++++----------------------
 t/t4053-diff-no-index.sh | 16 +++++++++++++
 2 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 88ae4cee56ba..c70f82b80559 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -21,30 +21,21 @@
 
 static int read_directory_contents(const char *path, struct string_list *list,
 				   const struct pathspec *pathspec,
-				   int skip)
+				   struct strbuf *match)
 {
-	struct strbuf match = STRBUF_INIT;
-	int len;
+	int len = match->len;
 	DIR *dir;
 	struct dirent *e;
 
 	if (!(dir = opendir(path)))
 		return error("Could not open directory %s", path);
 
-	if (pathspec) {
-		strbuf_addstr(&match, path);
-		strbuf_complete(&match, '/');
-		strbuf_remove(&match, 0, skip);
-
-		len = match.len;
-	}
-
 	while ((e = readdir_skip_dot_and_dotdot(dir))) {
 		if (pathspec) {
 			int is_dir = 0;
 
-			strbuf_setlen(&match, len);
-			strbuf_addstr(&match, e->d_name);
+			strbuf_setlen(match, len);
+			strbuf_addstr(match, e->d_name);
 			if (NOT_CONSTANT(DTYPE(e)) != DT_UNKNOWN) {
 				is_dir = (DTYPE(e) == DT_DIR);
 			} else {
@@ -57,7 +48,7 @@ static int read_directory_contents(const char *path, struct string_list *list,
 			}
 
 			if (!match_leading_pathspec(NULL, pathspec,
-						    match.buf, match.len,
+						    match->buf, match->len,
 						    0, NULL, is_dir))
 				continue;
 		}
@@ -65,7 +56,7 @@ static int read_directory_contents(const char *path, struct string_list *list,
 		string_list_insert(list, e->d_name);
 	}
 
-	strbuf_release(&match);
+	strbuf_setlen(match, len);
 	closedir(dir);
 	return 0;
 }
@@ -169,7 +160,8 @@ static struct diff_filespec *noindex_filespec(const struct git_hash_algo *algop,
 
 static int queue_diff(struct diff_options *o, const struct git_hash_algo *algop,
 		      const char *name1, const char *name2, int recursing,
-		      const struct pathspec *ps, int skip1, int skip2)
+		      const struct pathspec *ps,
+		      struct strbuf *ps_match1, struct strbuf *ps_match2)
 {
 	int mode1 = 0, mode2 = 0;
 	enum special special1 = SPECIAL_NONE, special2 = SPECIAL_NONE;
@@ -208,10 +200,12 @@ static int queue_diff(struct diff_options *o, const struct git_hash_algo *algop,
 		struct string_list p2 = STRING_LIST_INIT_DUP;
 		int i1, i2, ret = 0;
 		size_t len1 = 0, len2 = 0;
+		size_t match1_len = ps_match1->len;
+		size_t match2_len = ps_match2->len;
 
-		if (name1 && read_directory_contents(name1, &p1, ps, skip1))
+		if (name1 && read_directory_contents(name1, &p1, ps, ps_match1))
 			return -1;
-		if (name2 && read_directory_contents(name2, &p2, ps, skip2)) {
+		if (name2 && read_directory_contents(name2, &p2, ps, ps_match2)) {
 			string_list_clear(&p1, 0);
 			return -1;
 		}
@@ -235,6 +229,11 @@ static int queue_diff(struct diff_options *o, const struct git_hash_algo *algop,
 			strbuf_setlen(&buffer1, len1);
 			strbuf_setlen(&buffer2, len2);
 
+			if (ps) {
+				strbuf_setlen(ps_match1, match1_len);
+				strbuf_setlen(ps_match2, match2_len);
+			}
+
 			if (i1 == p1.nr)
 				comp = 1;
 			else if (i2 == p2.nr)
@@ -245,18 +244,28 @@ static int queue_diff(struct diff_options *o, const struct git_hash_algo *algop,
 			if (comp > 0)
 				n1 = NULL;
 			else {
-				strbuf_addstr(&buffer1, p1.items[i1++].string);
+				strbuf_addstr(&buffer1, p1.items[i1].string);
+				if (ps) {
+					strbuf_addstr(ps_match1, p1.items[i1].string);
+					strbuf_complete(ps_match1, '/');
+				}
 				n1 = buffer1.buf;
+				i1++;
 			}
 
 			if (comp < 0)
 				n2 = NULL;
 			else {
-				strbuf_addstr(&buffer2, p2.items[i2++].string);
+				strbuf_addstr(&buffer2, p2.items[i2].string);
+				if (ps) {
+					strbuf_addstr(ps_match2, p2.items[i2].string);
+					strbuf_complete(ps_match2, '/');
+				}
 				n2 = buffer2.buf;
+				i2++;
 			}
 
-			ret = queue_diff(o, algop, n1, n2, 1, ps, skip1, skip2);
+			ret = queue_diff(o, algop, n1, n2, 1, ps, ps_match1, ps_match2);
 		}
 		string_list_clear(&p1, 0);
 		string_list_clear(&p2, 0);
@@ -346,7 +355,8 @@ int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
 		  int implicit_no_index, int argc, const char **argv)
 {
 	struct pathspec pathspec, *ps = NULL;
-	int i, no_index, skip1 = 0, skip2 = 0;
+	struct strbuf ps_match1 = STRBUF_INIT, ps_match2 = STRBUF_INIT;
+	int i, no_index;
 	int ret = 1;
 	const char *paths[2];
 	char *to_free[ARRAY_SIZE(paths)] = { 0 };
@@ -387,11 +397,6 @@ int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
 			       NULL, &argv[2]);
 		if (pathspec.nr)
 			ps = &pathspec;
-
-		skip1 = strlen(paths[0]);
-		skip1 += paths[0][skip1] == '/' ? 0 : 1;
-		skip2 = strlen(paths[1]);
-		skip2 += paths[1][skip2] == '/' ? 0 : 1;
 	} else if (argc > 2) {
 		warning(_("Limiting comparison with pathspecs is only "
 			  "supported if both paths are directories."));
@@ -415,7 +420,7 @@ int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
 	revs->diffopt.flags.exit_with_status = 1;
 
 	if (queue_diff(&revs->diffopt, algop, paths[0], paths[1], 0, ps,
-		       skip1, skip2))
+		       &ps_match1, &ps_match2))
 		goto out;
 	diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
 	diffcore_std(&revs->diffopt);
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 01db9243abfe..e0ea437685b0 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -322,6 +322,22 @@ test_expect_success 'diff --no-index with pathspec' '
 	test_cmp expect actual
 '
 
+test_expect_success 'diff --no-index first path ending in slash with pathspec' '
+	test_expect_code 1 git diff --name-status --no-index a/ b 1 >actual &&
+	cat >expect <<-EOF &&
+	D	a/1
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'diff --no-index second path ending in slash with pathspec' '
+	test_expect_code 1 git diff --name-status --no-index a b/ 1 >actual &&
+	cat >expect <<-EOF &&
+	D	a/1
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'diff --no-index with pathspec no matches' '
 	test_expect_code 0 git diff --name-status --no-index a b missing
 '

---
base-commit: 8d2709d075d65ba386a4dac157129ef868c283e5
change-id: 20250924-jk-fix-no-index-path-with-slash-788785be16c1

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>

