Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5006C427F94
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502572; cv=none; b=R5k/60A0PS1Pl24RAjFlRndkZEyUma6RGsvZKNqsEe1lTDIuUW2bZwThFONUVT0tO5G2e4N6IowKtyz+k6AHMGOybYbPrCOpfJ8j+cc1M6mG3/H9GZV4z7+96++5rc9ezWvlqD5SpbprYchZBh5DgHhK2CaEWopXczpDdL3tAYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502572; c=relaxed/simple;
	bh=PWvoGeJ/6Qsj1rJ20j2QdVrrXWRp0u3mp2xaLAw6j9Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lI0XMYcZoQ3i/aIz2o8gC3ROEEubCozRz9xVZ5KcZ++ITISd9eo62peRLpYqCQOr98nRD/V+zh/nJJpNCoBv+AO9EoYLtS02qdGy3vSjZ5UgdgvglNwsz4L8CKCpUZ+6Z0aixM5NOquBHZyileLQoYt8TyjeMcUXyjXALL3UhjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q21Li76s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d6LTkqVG; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q21Li76s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d6LTkqVG"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7274C1400140;
	Fri, 31 Jul 2026 08:56:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 31 Jul 2026 08:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785502570; x=
	1785588970; bh=McgNPIrj5ATxmHnTu3mXyIVXVsx/ulOh+aBujI4mPko=; b=Q
	21Li76sXBFbN8HLAhb091e2degkEJYbCuHzmJSVMEt/ZiSFwd0Wwu4M0sp+MyE8E
	6gG07eVxQzGZrKMe064OuzUTGgdCX9hnMDbpviDezCLD1geYMBCSyTsWyC2nX7TG
	bI0LYBvjzDAL57XXgZ7AKxbN1UdqB5pBl1HJNKXBmvZipxEM/04DxKhuElvjEd2k
	tVU9sAcqrfpnZe33xbkkks7n3o0pF5ttBQIKmoIHb5Bu4V5A6Wn43e9dmoDlqRum
	Mme4ofHzjWbMg8o/TK6If6uTe46bVicNm2foRT9Hq0GTSyAC3+qI+Dn9moa1eqbX
	OCJRIdQvrt7MFg3/8Jxsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1785502570; x=1785588970; bh=McgNPIrj5ATxmHnTu3mXyIVXVsx/
	ulOh+aBujI4mPko=; b=d6LTkqVGLrF3Tq6nS9SqKAEGN5YiJDaNZ2gsC5r3MHBS
	0UA0oMqJP0D/dcWukI5+r4xFSC9zmX/BlJFwXlssxoD0dcfGpKiE+Xl7lPC2xWtB
	CJZL9HRMD+sU/xhwZC0qPCZ584gRffxyyo8yytofz8YQtNsq/VS1IeH9kTN6N388
	sYsu7MPzYZk8NeDt0iy0JyOf9YEo5U5mg8NfzIeZUejm5m8QlrgphIJb/zryVGW9
	pMUhzkvgT4vbODN39FZLGNu7oRnGKXWWE1TaBow8SB0PE+uSD7bg/JsCfni4cC66
	moRT8cVczjkr7guHFNx+3iqkdfK8muGhFMh8FwbyZg==
X-ME-Sender: <xms:aptsasvq4eLDSW3NuW6iJ_cN6O-F8jYONEQqJ7qFLIqyFBmxlBf5Jg>
    <xme:aptsavf52ujG-17COLYbT4vsMiMuHliCCjRhA7Zf-ulkUCTEs3ehcL2N30aaJ3sF8
    1kse0gHMA8ljNreRio0lzzYdZ7mJnPWfZuk9uy7MxVPG9MHQ1Xqqxs>
X-ME-Received: <xmr:aptsalZOzbd0QsssVgAdPWoZzXL8eH5sbwV28qVyoXfuBscIun0whVrsFA6yf1gf30eP-e_ysxNNlhmXPdLYkKQQzf7pUSq1tA>
X-ME-Proxy-Cause: dmFkZTFvtb4z8LKpL/dDmRpyDAZ+sKRopVmXj+fK+N+tDcReyC4QfjUzed/2Yq9KPOWsmJ
    BfW4FDTVWh72NRk/WsGt/c2XNfqRyqBYn6u3CW2dsbABPUR3QlweGEUitYNQ2uZctSXuPN
    GGhPzzpvGt2YDvkIAn2JVa7q3sxFaQ6CAFtlslLJGcME8nKVR52AfaH1WQopaE4ZFMEDWb
    fbPN21+CnaxJKlUKEnVY3agkqfmhgm8ElREzHI382QqkmvYTyXLAFQgWAWzg49ocOy2Tgr
    5qT4zktJixUUwne4KXg6P/ZlG3djDFp8xyJvTBwhinQFg2z1DuGhBFx0+E5hvdN0R1+ohF
    UBYRTz6Osn87mwnZoHYJDJBPGIyQyD4ncTMDbqDjG9gQ0X6jKbV0Mw5HXzdKxfsyJj2+/P
    ULkUZl3Ld6MAA8ph0SEBdsLe5mqq1Fv1jitVW4/SvI2tbUT5dTgsANRzmrmfcro6Mgw3ji
    CDxfQzixsxZ/BOjNbuOXg4ya35ivBXKwT1Kzf9gGed32zuzWmkw3WH+iTEEHDl0LaUY6I+
    6HUZ/ItnZB2vtPVQNlvHMMdZT9AXjvxlNKWb1Q7j/zdDJGfAw7hL3q6mHCbQExbxhd+3IC
    W/4C6YwOuqHIIWK69lAMxDYJLS2b+OPXvY3RfZ1jmWU5TQ3SgmomD9tg7RxQ
X-ME-Proxy: <xmx:aptsaqXn7amlFE5YzIVGY2RKq9FHIDngtVyA0rOPO6jDpx8OnUNVhg>
    <xmx:aptsavhcTKSHuXbF0-dFU84uoURp0kagPb5JABBMzg9os1Tj-QPLrg>
    <xmx:aptsagVRQvIjP4j5dBd3AD33VVEPyUzRfKUcNVvc40lUFx1jGqikIg>
    <xmx:aptsauOvN50lLdCPCeQgMUEjaFjpaSoeWg4_vMdMkF88SiZnvZ61gA>
    <xmx:aptsaoE6cywvxNT1D_f_1K23NtlQLczaL4YcpNQUQyIe2zV6hh3nrySv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 08:56:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 2/4] merge-ll: consolidate conflict marker scanning logic
Date: Fri, 31 Jul 2026 05:56:03 -0700
Message-ID: <20260731125605.3638938-3-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-599-g5cacd2ad51
In-Reply-To: <20260731125605.3638938-1-gitster@pobox.com>
References: <20260728215219.753678-1-gitster@pobox.com>
 <20260731125605.3638938-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The diff.c:is_conflict_marker() and rerere.c:is_cmarker() functions
implement duplicate logic for identifying conflict marker lines
(lines that begin with a run of '<', '=', '>', and '|' characters).

diff.c's original version from 049540435f (diff --check: detect
leftover conflict markers, 2008-06-26) accepts any whitespace (such
as a newline) immediately following '<<<<<<<' and '>>>>>>>', whereas
rerere.c's version from 191f241717 (rerere: prepare for customizable
conflict marker length, 2010-01-16) strictly requires a space
character (' ') after them.

Implement is_conflict_marker_line() in merge-ll.c to serve as a
replacement for both, and update diff.c and rerere.c to use the new
helper.  The unified helper intentionally adopts rerere's stricter
rule, as the conflicts generated by Git always show the "ours" and
"theirs" labels after these markers separated by a space.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c     | 25 +------------------------
 merge-ll.c | 31 +++++++++++++++++++++++++++++++
 merge-ll.h |  1 +
 rerere.c   | 38 ++++++--------------------------------
 4 files changed, 39 insertions(+), 56 deletions(-)

diff --git a/diff.c b/diff.c
index 589c1969e4..cfe515af4e 100644
--- a/diff.c
+++ b/diff.c
@@ -3519,29 +3519,6 @@ struct checkdiff_t {
 	int last_line_kind;
 };
 
-static int is_conflict_marker(const char *line, int marker_size, unsigned long len)
-{
-	char firstchar;
-	int cnt;
-
-	if (len < marker_size + 1)
-		return 0;
-	firstchar = line[0];
-	switch (firstchar) {
-	case '=': case '>': case '<': case '|':
-		break;
-	default:
-		return 0;
-	}
-	for (cnt = 1; cnt < marker_size; cnt++)
-		if (line[cnt] != firstchar)
-			return 0;
-	/* line[1] through line[marker_size-1] are same as firstchar */
-	if (len < marker_size + 1 || !isspace(line[marker_size]))
-		return 0;
-	return 1;
-}
-
 static void checkdiff_consume_hunk(void *priv,
 				   long ob UNUSED, long on UNUSED,
 				   long nb, long nn UNUSED,
@@ -3571,7 +3548,7 @@ static int checkdiff_consume(void *priv, char *line, unsigned long len)
 	if (line[0] == '+') {
 		unsigned bad;
 		data->lineno++;
-		if (is_conflict_marker(line + 1, marker_size, len - 1)) {
+		if (is_conflict_marker_line(line + 1, len - 1, marker_size)) {
 			data->status |= 1;
 			fprintf(data->o->file,
 				"%s%s:%d: leftover conflict marker\n",
diff --git a/merge-ll.c b/merge-ll.c
index fafe2c9197..41c97fb90a 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -468,3 +468,34 @@ int ll_merge_marker_size(struct index_state *istate, const char *path)
 	}
 	return marker_size;
 }
+
+int is_conflict_marker_line(const char *line, unsigned long len, int marker_size)
+{
+	char firstchar;
+	int cnt;
+
+	if (len < marker_size + 1)
+		return 0;
+
+	firstchar = line[0];
+	switch (firstchar) {
+	case '=': case '>': case '<': case '|':
+		break;
+	default:
+		return 0;
+	}
+
+	for (cnt = 1; cnt < marker_size; cnt++) {
+		if (line[cnt] != firstchar)
+			return 0;
+	}
+
+	if (((firstchar == '<') || (firstchar == '>')) &&
+	    line[marker_size] != ' ')
+		return 0;
+
+	if (!isspace((unsigned char)line[marker_size]))
+		return 0;
+
+	return firstchar;
+}
diff --git a/merge-ll.h b/merge-ll.h
index d038ee0c1e..b348aee15d 100644
--- a/merge-ll.h
+++ b/merge-ll.h
@@ -109,6 +109,7 @@ enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
 	     const struct ll_merge_options *opts);
 
 int ll_merge_marker_size(struct index_state *istate, const char *path);
+int is_conflict_marker_line(const char *line, unsigned long len, int marker_size);
 void reset_merge_attributes(void);
 
 #endif
diff --git a/rerere.c b/rerere.c
index 216100925a..924a1f2e30 100644
--- a/rerere.c
+++ b/rerere.c
@@ -331,33 +331,6 @@ static int rerere_file_getline(struct strbuf *sb, struct rerere_io *io_)
 	return strbuf_getwholeline(sb, io->input, '\n');
 }
 
-/*
- * Require the exact number of conflict marker letters, no more, no
- * less, followed by SP or any whitespace
- * (including LF).
- */
-static int is_cmarker(char *buf, int marker_char, int marker_size)
-{
-	int want_sp;
-
-	/*
-	 * The beginning of our version and the end of their version
-	 * always are labeled like "<<<<< ours" or ">>>>> theirs",
-	 * hence we set want_sp for them.  Note that the version from
-	 * the common ancestor in diff3-style output is not always
-	 * labelled (e.g. "||||| common" is often seen but "|||||"
-	 * alone is also valid), so we do not set want_sp.
-	 */
-	want_sp = (marker_char == '<') || (marker_char == '>');
-
-	while (marker_size--)
-		if (*buf++ != marker_char)
-			return 0;
-	if (want_sp && *buf != ' ')
-		return 0;
-	return isspace(*buf);
-}
-
 static void rerere_strbuf_putconflict(struct strbuf *buf, int ch, size_t size)
 {
 	strbuf_addchars(buf, ch, size);
@@ -375,7 +348,8 @@ static int handle_conflict(struct strbuf *out, struct rerere_io *io,
 	int has_conflicts = -1;
 
 	while (!io->getline(&buf, io)) {
-		if (is_cmarker(buf.buf, '<', marker_size)) {
+		int marker = is_conflict_marker_line(buf.buf, buf.len, marker_size);
+		if (marker == '<') {
 			if (handle_conflict(&conflict, io, marker_size, NULL) < 0)
 				break;
 			if (hunk == RR_SIDE_1)
@@ -383,15 +357,15 @@ static int handle_conflict(struct strbuf *out, struct rerere_io *io,
 			else
 				strbuf_addbuf(&two, &conflict);
 			strbuf_release(&conflict);
-		} else if (is_cmarker(buf.buf, '|', marker_size)) {
+		} else if (marker == '|') {
 			if (hunk != RR_SIDE_1)
 				break;
 			hunk = RR_ORIGINAL;
-		} else if (is_cmarker(buf.buf, '=', marker_size)) {
+		} else if (marker == '=') {
 			if (hunk != RR_SIDE_1 && hunk != RR_ORIGINAL)
 				break;
 			hunk = RR_SIDE_2;
-		} else if (is_cmarker(buf.buf, '>', marker_size)) {
+		} else if (marker == '>') {
 			if (hunk != RR_SIDE_2)
 				break;
 			if (strbuf_cmp(&one, &two) > 0)
@@ -442,7 +416,7 @@ static int handle_path(unsigned char *hash, struct rerere_io *io, int marker_siz
 		git_hash_init(&ctx, the_hash_algo);
 
 	while (!io->getline(&buf, io)) {
-		if (is_cmarker(buf.buf, '<', marker_size)) {
+		if (is_conflict_marker_line(buf.buf, buf.len, marker_size) == '<') {
 			has_conflicts = handle_conflict(&out, io, marker_size,
 							hash ? &ctx : NULL);
 			if (has_conflicts < 0)
-- 
2.55.0-599-g5cacd2ad51

