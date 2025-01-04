Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87595C2FD
	for <git@vger.kernel.org>; Sat,  4 Jan 2025 03:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735961536; cv=none; b=Bo8ZNvGI12TZiAGKukptcloj3EpO630KnSLAa2dXrE6llxIl9W1OX1waASIpd+u2FImfKtQhqg4mpQrpgTAr8UO6wtRlQgU+WiazbFqS/Z4bQC7G75wCMuV1tnpNCiydwbAqeWS7gdeGojjwlRdoUg1i5qlSeNsD5085e3bHp9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735961536; c=relaxed/simple;
	bh=7HHK7igmqgOHGrm1cBXeOl1HiOGt4KEu6uK8ZB19Phg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPV2JrGRSl0avDnQA8CKSapllmwu8sE0Sn4zT0bCDrGT8OG1uJ02Jjoynh/tVyHNfFl/JVwHL5lz19ZAkVbc9xma2FqMPS8NPmAqewj+XiBg6bqNK8RZ4B0Btievtt+T/f4Vw0LQWOgRs1rXcuNO/jp4IWueqGtPFTdGs7RP4fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XC5ZhVHP; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XC5ZhVHP"
Received: (qmail 22088 invoked by uid 109); 4 Jan 2025 03:32:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=7HHK7igmqgOHGrm1cBXeOl1HiOGt4KEu6uK8ZB19Phg=; b=XC5ZhVHPTpWXQeBlOKY9HLrhnyWgxpseLyFY5kEIJZY/cvqG0AJLps1LuM+mAdRvq9sFSKD3Ncbr52ai1Mt7JRK+wS6woDjaxul8IPU7596jXAKmOvNwrKb6ZVs9rHL5SMgEatNrrn1Y+iPU9mxHrWzK2b/XjP01uvhccsur5iIvtiXpYeaR5cnDSPOkjfJHY8DBU9zMnSBWwb3VHIJvQmBLv2u38a4x8jQVdcrXTmf5EZe00BlTbEcQdl6DvwNT+qlx9L1pJlIxZcCCxXtWXNNDlQlvbi4CURta6t2IAuCF5eBcXdRry0VETz/FfrpHo3vRRm/NULTQhHFpwNZbaQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Jan 2025 03:32:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9387 invoked by uid 111); 4 Jan 2025 03:32:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Jan 2025 22:32:11 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 3 Jan 2025 22:32:10 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Wink Saville <wink@saville.com>, Git List <git@vger.kernel.org>
Subject: Re: [BUGREPORT] git diff-tree --cc SEGFAUTs
Message-ID: <20250104033210.GA892381@coredump.intra.peff.net>
References: <CAKk8isqpAXLoiXxOP3uAc00M+OM0FaU3Uhnt5R1FnFMD=xGARg@mail.gmail.com>
 <20250103204624.GE3212696@coredump.intra.peff.net>
 <CAKk8isrz1NQ=3=2aZ3tANymo0eSsCy=r6W5yKgn6gxmOom54CA@mail.gmail.com>
 <20250104003154.GB3244554@coredump.intra.peff.net>
 <xmqq4j2fnv8p.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4j2fnv8p.fsf@gitster.g>

On Fri, Jan 03, 2025 at 06:55:18PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... OTOH it is not really
> > solving the more fundamental problem, which is that p->parent[i].path is
> > only sometimes useful (we do not fill it in if it would just be the same
> > as p->path, so the patch only changes it from uninitialized memory into
> > an empty strbuf).
> >
> > And that is probably not something we want to change, as allocating
> > duplicates of each path may be expensive.
> 
> Nicely said.  I reached the same conclusion after looking at the
> existing code, even though I have to admit that I am not a huge fan
> of the more recent part of combine-diff.c and its data structures.

I poked at this a little bit more, so here are a few tidbits:

  - the patch I showed earlier is not sufficient! There are lots of
    other spots that create combine_diff_path structs but don't bother
    to put anything in the parent paths at all. It works now because
    they also don't set a status that triggers filename_changed(). But
    what I showed earlier was wrong, because it was assuming in the
    cleanup functions that the strbufs were always initialized.

  - there's really no need for a strbuf at all here. It is always
    uninitialized/empty, or contains a direct copy of a path string. So
    a raw pointer with xstrdup() is plenty. And then we can use NULL to
    mean "it was not set".

    Which would Just Work for all those other spots if they bothered to
    zero the memory they allocated, but they don't. So we have to update
    them to set it to NULL anyway. That patch is below.

  - it is not at all clear to me that we need to be allocating at all.
    We always copy a string from the diff_queue. Do our
    combine_diff_path structs persist beyond then? I'm not sure. It is
    probably asking for trouble to just point to them directly without
    copying, as it creates a dependency (that even if it is not needed
    now, is a trap for somebody later). But it would drop some
    allocation/cleanup code, and we could just have p->parent[i].path
    fall back to p->path naturally.

diff --git a/combine-diff.c b/combine-diff.c
index 641bc92dbd..0d9d344c4e 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -66,13 +66,9 @@ static struct combine_diff_path *intersect_paths(
 			oidcpy(&p->parent[n].oid, &q->queue[i]->one->oid);
 			p->parent[n].mode = q->queue[i]->one->mode;
 			p->parent[n].status = q->queue[i]->status;
-
-			if (combined_all_paths &&
-			    filename_changed(p->parent[n].status)) {
-				strbuf_init(&p->parent[n].path, 0);
-				strbuf_addstr(&p->parent[n].path,
-					      q->queue[i]->one->path);
-			}
+			p->parent[n].path = combined_all_paths &&
+					    filename_changed(p->parent[n].status) ?
+					    xstrdup(q->queue[i]->one->path) : NULL;
 			*tail = p;
 			tail = &p->next;
 		}
@@ -92,9 +88,7 @@ static struct combine_diff_path *intersect_paths(
 			/* p->path not in q->queue[]; drop it */
 			*tail = p->next;
 			for (j = 0; j < num_parent; j++)
-				if (combined_all_paths &&
-				    filename_changed(p->parent[j].status))
-					strbuf_release(&p->parent[j].path);
+				free(p->parent[j].path);
 			free(p);
 			continue;
 		}
@@ -108,10 +102,9 @@ static struct combine_diff_path *intersect_paths(
 		oidcpy(&p->parent[n].oid, &q->queue[i]->one->oid);
 		p->parent[n].mode = q->queue[i]->one->mode;
 		p->parent[n].status = q->queue[i]->status;
-		if (combined_all_paths &&
-		    filename_changed(p->parent[n].status))
-			strbuf_addstr(&p->parent[n].path,
-				      q->queue[i]->one->path);
+		p->parent[n].path = combined_all_paths &&
+				    filename_changed(p->parent[n].status) ?
+				    xstrdup(q->queue[i]->one->path) : NULL;
 
 		tail = &p->next;
 		i++;
@@ -996,8 +989,9 @@ static void show_combined_header(struct combine_diff_path *elem,
 
 	if (rev->combined_all_paths) {
 		for (i = 0; i < num_parent; i++) {
-			char *path = filename_changed(elem->parent[i].status)
-				? elem->parent[i].path.buf : elem->path;
+			const char *path = elem->parent[i].path ?
+					   elem->parent[i].path :
+					   elem->path;
 			if (elem->parent[i].status == DIFF_STATUS_ADDED)
 				dump_quoted_path("--- ", "", "/dev/null",
 						 line_prefix, c_meta, c_reset);
@@ -1278,12 +1272,10 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
 
 	for (i = 0; i < num_parent; i++)
 		if (rev->combined_all_paths) {
-			if (filename_changed(p->parent[i].status))
-				write_name_quoted(p->parent[i].path.buf, stdout,
-						  inter_name_termination);
-			else
-				write_name_quoted(p->path, stdout,
-						  inter_name_termination);
+			const char *path = p->parent[i].path ?
+					   p->parent[i].path :
+					   p->path;
+			write_name_quoted(path, stdout, inter_name_termination);
 		}
 	write_name_quoted(p->path, stdout, line_termination);
 }
@@ -1645,9 +1637,7 @@ void diff_tree_combined(const struct object_id *oid,
 		struct combine_diff_path *tmp = paths;
 		paths = paths->next;
 		for (i = 0; i < num_parent; i++)
-			if (rev->combined_all_paths &&
-			    filename_changed(tmp->parent[i].status))
-				strbuf_release(&tmp->parent[i].path);
+			free(tmp->parent[i].path);
 		free(tmp);
 	}
 
diff --git a/diff-lib.c b/diff-lib.c
index c6d3bc4d37..88a5aed736 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -417,9 +417,11 @@ static int show_modified(struct rev_info *revs,
 		memset(p->parent, 0, 2 * sizeof(struct combine_diff_parent));
 		p->parent[0].status = DIFF_STATUS_MODIFIED;
 		p->parent[0].mode = new_entry->ce_mode;
+		p->parent[0].path = NULL;
 		oidcpy(&p->parent[0].oid, &new_entry->oid);
 		p->parent[1].status = DIFF_STATUS_MODIFIED;
 		p->parent[1].mode = old_entry->ce_mode;
+		p->parent[1].path = NULL;
 		oidcpy(&p->parent[1].oid, &old_entry->oid);
 		show_combined_diff(p, 2, revs);
 		free(p);
diff --git a/diff.h b/diff.h
index 6e6007c17b..3157faeabb 100644
--- a/diff.h
+++ b/diff.h
@@ -480,7 +480,7 @@ struct combine_diff_path {
 		char status;
 		unsigned int mode;
 		struct object_id oid;
-		struct strbuf path;
+		char *path;
 	} parent[FLEX_ARRAY];
 };
 #define combine_diff_path_size(n, l) \
diff --git a/tree-diff.c b/tree-diff.c
index d9237ffd9b..57af377c2b 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -272,6 +272,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 			}
 
 			p->parent[i].mode = mode_i;
+			p->parent[i].path = NULL;
 			oidcpy(&p->parent[i].oid, oid_i);
 		}
 
