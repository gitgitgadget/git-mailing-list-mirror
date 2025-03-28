Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894B617C77
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 04:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743134870; cv=none; b=Ebp6T91scUmK7N//y2+XqLkNZIk25tOVlOSlxXiH7aZzvp66p9pjfUMyUnVZR4UTv7vkVr1v4XOpPDT0p+udVCKNf7wf784hj1pf5gUq2itZZ4FGpSwHNVkF/Y60fjNbaF0tmlOjWIa76Qc+iNpLJ/e4dQKCnXbea4Kt1yhBOqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743134870; c=relaxed/simple;
	bh=C6sFhKU5C8TKj4147wUxORD2XVhL6ZIlpmR00Vu7X8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgayLGTnyIFUR1XlsgDLNrRS4rXfBIQ+8VLhiK5S9Cd47tbPCXOH/IVCzntFfY/lWtQqOgkoAaeKfUYn0OlIa7R0w8qmmBuA18MSA/rqmiU5jLwSRedPH4p2TGU0Bg0TdoFDj7ctoTZz0xrEXrgC9FHFk/kCPXREZu2nNDpwPg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KGzR4p21; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KGzR4p21"
Received: (qmail 30271 invoked by uid 109); 28 Mar 2025 04:07:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=C6sFhKU5C8TKj4147wUxORD2XVhL6ZIlpmR00Vu7X8k=; b=KGzR4p21USYNkRLYmTLxxK+HrJMYRbWLR4IfApejhtfEmo4lkO3yGytFdAYqkPSnbBwCyhZrs0NvBPGiqXo0o0q+UN8cQrcufo2H4sktD1YGmIzN432wyDTfm2bQJzv3Jis9hFyjOt7zaq3OXkR8q3ltEnSlL6x4sUpY97tANefsEx5bc+oK4mEXt8JUQVdB4dPTxEU7Ejjw5hf6G6d3BU/Un5pKa2ZLgIt0LFHyF/kslNN7WTWPr3Fi0kg+dUogBeNQknxIZt9awcdA3ddH4h5wtA52Dqc3hB9ApOgZtyAPDB9tlnV9Q2ttxa23swc11ZMxgLFPw7nd2AaYjGZDmQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 28 Mar 2025 04:07:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11330 invoked by uid 111); 28 Mar 2025 04:07:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 28 Mar 2025 00:07:46 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 28 Mar 2025 00:07:45 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/4] fsck: avoid using an uninitialized variable
Message-ID: <20250328040745.GB3067273@coredump.intra.peff.net>
References: <pull.1888.git.1743079429.gitgitgadget@gmail.com>
 <575b4b2c2b8a5e800bb65b99f1fcdd6aaae63f94.1743079429.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <575b4b2c2b8a5e800bb65b99f1fcdd6aaae63f94.1743079429.git.gitgitgadget@gmail.com>

On Thu, Mar 27, 2025 at 12:43:47PM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In `fsck_commit()`, after counting the authors of a commit, we set the
> `err` variable either when there was no author, or when there were more
> than two authors recorded. Then we access the `err` variable to figure
> out whether we should return early. But if there was exactly one author,
> that variable is still uninitialized.
> 
> Let's just initialize the variable.
> 
> This issue was pointed out by CodeQL.

Hmm, I'd think we would hit this case all the time, since commits
generally have one author. But I think it's another false positive.

The code in question is this:

          author_count = 0;
          while (buffer < buffer_end && skip_prefix(buffer, "author ", &buffer)) {
                  author_count++;
                  err = fsck_ident(&buffer, oid, OBJ_COMMIT, options);
                  if (err)
                          return err;
          }
          if (author_count < 1)
                  err = report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_AUTHOR, "invalid format - expected 'author' line");
          else if (author_count > 1)
                  err = report(options, oid, OBJ_COMMIT, FSCK_MSG_MULTIPLE_AUTHORS, "invalid format - multiple 'author' lines");
          if (err)
                  return err;

So we set "err" as soon as we find _any_ author (when we check whether
it is properly formatted via fsck_ident). And author_count will not be
incremented if we did not find one. So either we must have assigned
the result of fsck_ident(), or we will hit the "author_count < 1" case
and assign there.

It's certainly confusing, though, since "err" gets used in so many
spots. I think the whole thing would be easier to understand if we had
tighter-scoped single use variables like this:

diff --git a/fsck.c b/fsck.c
index 9fc4c25ffd..ea72b3247d 100644
--- a/fsck.c
+++ b/fsck.c
@@ -925,7 +925,6 @@ static int fsck_commit(const struct object_id *oid,
 {
 	struct object_id tree_oid, parent_oid;
 	unsigned author_count;
-	int err;
 	const char *buffer_begin = buffer;
 	const char *buffer_end = buffer + size;
 	const char *p;
@@ -941,39 +940,44 @@ static int fsck_commit(const struct object_id *oid,
 	if (buffer >= buffer_end || !skip_prefix(buffer, "tree ", &buffer))
 		return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_TREE, "invalid format - expected 'tree' line");
 	if (parse_oid_hex(buffer, &tree_oid, &p) || *p != '\n') {
-		err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1");
+		int err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1");
 		if (err)
 			return err;
 	}
 	buffer = p + 1;
 	while (buffer < buffer_end && skip_prefix(buffer, "parent ", &buffer)) {
 		if (parse_oid_hex(buffer, &parent_oid, &p) || *p != '\n') {
-			err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_PARENT_SHA1, "invalid 'parent' line format - bad sha1");
+			int err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_PARENT_SHA1, "invalid 'parent' line format - bad sha1");
 			if (err)
 				return err;
 		}
 		buffer = p + 1;
 	}
 	author_count = 0;
 	while (buffer < buffer_end && skip_prefix(buffer, "author ", &buffer)) {
+		int err = fsck_ident(&buffer, oid, OBJ_COMMIT, options);
+		if (err)
+			return err;
 		author_count++;
-		err = fsck_ident(&buffer, oid, OBJ_COMMIT, options);
+	}
+	if (author_count < 1) {
+		int err = report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_AUTHOR, "invalid format - expected 'author' line");
+		if (err)
+			return err;
+	} else if (author_count > 1) {
+		int err = report(options, oid, OBJ_COMMIT, FSCK_MSG_MULTIPLE_AUTHORS, "invalid format - multiple 'author' lines");
 		if (err)
 			return err;
 	}
-	if (author_count < 1)
-		err = report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_AUTHOR, "invalid format - expected 'author' line");
-	else if (author_count > 1)
-		err = report(options, oid, OBJ_COMMIT, FSCK_MSG_MULTIPLE_AUTHORS, "invalid format - multiple 'author' lines");
-	if (err)
-		return err;
 	if (buffer >= buffer_end || !skip_prefix(buffer, "committer ", &buffer))
 		return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_COMMITTER, "invalid format - expected 'committer' line");
-	err = fsck_ident(&buffer, oid, OBJ_COMMIT, options);
-	if (err)
-		return err;
+	else {
+		int err = fsck_ident(&buffer, oid, OBJ_COMMIT, options);
+		if (err)
+			return err;
+	}
 	if (memchr(buffer_begin, '\0', size)) {
-		err = report(options, oid, OBJ_COMMIT, FSCK_MSG_NUL_IN_COMMIT,
+		int err = report(options, oid, OBJ_COMMIT, FSCK_MSG_NUL_IN_COMMIT,
 			     "NUL byte in the commit object body");
 		if (err)
 			return err;

And then it is obvious that the general pattern is to propagate "err"
from individual calls (and the ones that do not stick out like sore
thumbs; are those bugs where we should keep going if the user set those
message types to warn/ignore?).

You could even wrap the pattern in a macro, though perhaps that is
getting too magical. The resulting logic is easier to follow, though, if
you can look past the macro:

diff --git a/fsck.c b/fsck.c
index ea72b3247d..8c7ac3c448 100644
--- a/fsck.c
+++ b/fsck.c
@@ -919,6 +919,12 @@ static int fsck_ident(const char **ident,
 	return 0;
 }
 
+#define MAYBE_RETURN(x) do { \
+	int err = (x); \
+	if (err) \
+		return err; \
+} while (0)
+
 static int fsck_commit(const struct object_id *oid,
 		       const char *buffer, unsigned long size,
 		       struct fsck_options *options)
@@ -939,49 +945,30 @@ static int fsck_commit(const struct object_id *oid,
 
 	if (buffer >= buffer_end || !skip_prefix(buffer, "tree ", &buffer))
 		return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_TREE, "invalid format - expected 'tree' line");
-	if (parse_oid_hex(buffer, &tree_oid, &p) || *p != '\n') {
-		int err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1");
-		if (err)
-			return err;
-	}
+	if (parse_oid_hex(buffer, &tree_oid, &p) || *p != '\n')
+		MAYBE_RETURN(report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1"));
 	buffer = p + 1;
 	while (buffer < buffer_end && skip_prefix(buffer, "parent ", &buffer)) {
-		if (parse_oid_hex(buffer, &parent_oid, &p) || *p != '\n') {
-			int err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_PARENT_SHA1, "invalid 'parent' line format - bad sha1");
-			if (err)
-				return err;
-		}
+		if (parse_oid_hex(buffer, &parent_oid, &p) || *p != '\n')
+			MAYBE_RETURN(report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_PARENT_SHA1, "invalid 'parent' line format - bad sha1"));
 		buffer = p + 1;
 	}
 	author_count = 0;
 	while (buffer < buffer_end && skip_prefix(buffer, "author ", &buffer)) {
-		int err = fsck_ident(&buffer, oid, OBJ_COMMIT, options);
-		if (err)
-			return err;
+		MAYBE_RETURN(fsck_ident(&buffer, oid, OBJ_COMMIT, options));
 		author_count++;
 	}
-	if (author_count < 1) {
-		int err = report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_AUTHOR, "invalid format - expected 'author' line");
-		if (err)
-			return err;
-	} else if (author_count > 1) {
-		int err = report(options, oid, OBJ_COMMIT, FSCK_MSG_MULTIPLE_AUTHORS, "invalid format - multiple 'author' lines");
-		if (err)
-			return err;
-	}
+	if (author_count < 1)
+		MAYBE_RETURN(report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_AUTHOR, "invalid format - expected 'author' line"));
+	else if (author_count > 1)
+		MAYBE_RETURN(report(options, oid, OBJ_COMMIT, FSCK_MSG_MULTIPLE_AUTHORS, "invalid format - multiple 'author' lines"));
 	if (buffer >= buffer_end || !skip_prefix(buffer, "committer ", &buffer))
 		return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_COMMITTER, "invalid format - expected 'committer' line");
-	else {
-		int err = fsck_ident(&buffer, oid, OBJ_COMMIT, options);
-		if (err)
-			return err;
-	}
-	if (memchr(buffer_begin, '\0', size)) {
-		int err = report(options, oid, OBJ_COMMIT, FSCK_MSG_NUL_IN_COMMIT,
-			     "NUL byte in the commit object body");
-		if (err)
-			return err;
-	}
+	else
+		MAYBE_RETURN(fsck_ident(&buffer, oid, OBJ_COMMIT, options));
+
+	if (memchr(buffer_begin, '\0', size))
+		MAYBE_RETURN(report(options, oid, OBJ_COMMIT, FSCK_MSG_NUL_IN_COMMIT, "NUL byte in the commit object body"));
 	return 0;
 }
 

I'd suspect that just the first patch above would fix the CodeQL issue.
It's certainly a larger diff, but IMHO the result is less confusing for
humans, too.

-Peff
