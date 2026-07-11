Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF6C381E9A
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 07:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783756695; cv=none; b=S9vHkOCPCK7ef5wIIxTkjn2t9mf4NfrX7c5QFngNwKuM+6djSG58ywcUcFb8yZfXynzIJY9BEsJWNQh89X1HPBfigJrVg+yKhzWFgtG/39A4zh/xu67Lcp3uXA8VjEgJSnJ2z3JNvvpKTke1eTSW5EX9HiQqGjeEzlBrJp3asGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783756695; c=relaxed/simple;
	bh=3LmC/+B4FIAVvUpO9tQQrNDWs6yqVMflSTlWLwWzdRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9sdKTQskAE9FHOHt6R6mOVZtt2snnaDdwer9fuAyWUxBjqA/vJhZYhOMFsdDDM2Fsj/bPimbnFAenbmiKYImONmMl14KyGFfMLO0viv1c4OHmbKh0WpbbQBGHWScLIchlOgeFqkQC043S6MIflgQ8I69SIgwWtr04oHv1Gv19I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Wc+akj9Z; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Wc+akj9Z"
Received: (qmail 55778 invoked by uid 106); 11 Jul 2026 07:58:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3LmC/+B4FIAVvUpO9tQQrNDWs6yqVMflSTlWLwWzdRA=; b=Wc+akj9Z3hcm/w8iGx6AJxFGrzojthEy9RcPyg15nMRMAv4pUY26jxOdiOyFrPiJMk6liZMcM74Ykg4evpS1rzwOBS1S40jQYHHXotf6STqlcrKYiVXVBkS4n1siOtZqwzO/9KjCQ6qJ7tsJRXixHL8GeZjA/c1HVOEUDsh3E8VIR+i6XWjIrQVTtoHWrWvSp6DSZw0h7mZCgqeXVPzH/hiMlBWIuhFihH1s2RmeQfiC+Sgez1JTz/pdpJo83HtrWe+bPJymbLUYZ7/dR1XuTb83wd/gBUzve3uYuIU+k9ADgWhE/pCsVkyCA9J/oUliG8pcYdV72dIxHxNHu3kF0Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Jul 2026 07:58:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 95474 invoked by uid 111); 11 Jul 2026 07:58:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 11 Jul 2026 03:58:11 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 11 Jul 2026 03:58:11 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 9/8?] pack-objects: drop unused return value from
 add_object_entry()
Message-ID: <20260711075811.GC1457061@coredump.intra.peff.net>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
 <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>

On Fri, Jul 10, 2026 at 10:48:52AM +0200, Patrick Steinhardt wrote:

> The series is built on top of f85a7e6620 (Start Git 2.56 cycle,
> 2026-07-06) with ps/odb-drop-whence at 8a7ad23e11 (odb: document object
> info fields, 2026-07-02) merged into it.

Here's a patch doing the cleanup I proposed upthread.

-- >8 --
Subject: pack-objects: drop unused return value from add_object_entry()

This function returns 0/1 to its caller to tell them whether we actually
added a new entry (or if we considered it redundant). But nobody has
relied on that behavior since 5379a5c5ee (Thin pack generation:
optimization., 2006-04-05).

The extra return does not hurt much, but it recently became a bit more
confusing. We have a sister function, add_object_entry_from_bitmap(),
which had the same return value semantics. That function recently
changed to always return 0 (not void, because it must conform to a
callback function interface). So now we have two related functions which
both return an "int" but with different semantics.

Let's drop the unused "int" return from add_object_entry() entirely,
which makes it more clear that the two functions have diverged.

Signed-off-by: Jeff King <peff@peff.net>
---
I couldn't reference the commit by its id, since Junio has not yet
picked up the v2 sent a few hours ago. ;)

 builtin/pack-objects.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8ff92c5272..3673b14b89 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1867,16 +1867,16 @@ static const char no_closure_warning[] = N_(
 "disabling bitmap writing, as some objects are not being packed"
 );
 
-static int add_object_entry(const struct object_id *oid, enum object_type type,
-			    const char *name, int exclude)
+static void add_object_entry(const struct object_id *oid, enum object_type type,
+			     const char *name, int exclude)
 {
 	struct packed_git *found_pack = NULL;
 	off_t found_offset = 0;
 
 	display_progress(progress_state, ++nr_seen);
 
 	if (have_duplicate_entry(oid, exclude))
-		return 0;
+		return;
 
 	if (!want_object_in_pack(oid, exclude, &found_pack, &found_offset)) {
 		/* The pack is missing an object, so it will not have closure */
@@ -1885,13 +1885,12 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 				warning(_(no_closure_warning));
 			write_bitmap_index = 0;
 		}
-		return 0;
+		return;
 	}
 
 	create_object_entry(oid, type, pack_name_hash_fn(name),
 			    exclude, name && no_try_delta(name),
 			    found_pack, found_offset);
-	return 1;
 }
 
 static int add_object_entry_from_bitmap(const struct object_id *oid,
-- 
2.55.0.580.gbbcb530e9e

