Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE1C14B08A
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 05:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776317679; cv=none; b=ex1Dd1tPL47vZSTBNB3LCftqQl/bNSObqXn3VvKf+PMufTWeRoBJbdu4UAU98Dv5H45BHldxaJxgqpBSRT6+meeXcOM/47pJgKry33ZhiNS+JbetjkbS1+qS0LKdNN7D/9NLAU5KjVJaX5BkAvOweXCzsl9Lyebvji/AQCl+8oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776317679; c=relaxed/simple;
	bh=zVVX5ntRNAINm9aFkyn8YNJI58mMAT9VtpzQPN1kKfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzSAgTfikp3YVe4Pcj0ShzoLF29LlYEAG3L+vAXzMj3YwjoQZpYQMZHwnpDgjBldIisFb9b4rr6QrgVKBvHfWmrdqlb3aNgpsvrqz9qKl+hpQh4Sa08y2rW4vVuFuzktX0IgHxoF8BjrNKs00A/SQlnBeoyJz0K7x/QGF2FcKNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hD9e729o; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hD9e729o"
Received: (qmail 365767 invoked by uid 106); 16 Apr 2026 05:34:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zVVX5ntRNAINm9aFkyn8YNJI58mMAT9VtpzQPN1kKfw=; b=hD9e729osHCs7uAXU5klwgZ4tsTvslnIJr6/3IxSpCGn0TL+uZ9vvFv+CJIA2zm7pkeqI9uwNZfMlWvz5j2HW38DjcIHln6qtj75w+H6Q+O6mOBW5O/iAaONg4bRhjc/sMWjSblG93KWt7O5Fs/XpYiJ1Gu/sPbG7S4szJ7ctojuqryN7v0u6M2yn8UHkQfUGYYnPRf9XpjtEKq85VUHaDopBTwoOOg44td+NyIS4tYSikfFEk24CCETuPyc6N+Zd7QYu+I2g8B04yD4MCrsTehZZIH7FXihD9qGoWyIHsv+d9TGbtwBlYKVj0kJFD5vMf0HABGrjtAdNRdf03Ca2Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Apr 2026 05:34:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 610836 invoked by uid 111); 16 Apr 2026 05:34:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Apr 2026 01:34:35 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Apr 2026 01:34:35 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MIDX woes, was Re: [ANNOUNCE] Git v2.54.0-rc2
Message-ID: <20260416053435.GA646718@coredump.intra.peff.net>
References: <xmqqqzohd0sh.fsf@gitster.g>
 <8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de>
 <xmqq5x5s540j.fsf@gitster.g>
 <20260416051732.GA48541@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260416051732.GA48541@coredump.intra.peff.net>

On Thu, Apr 16, 2026 at 01:17:33AM -0400, Jeff King wrote:

> I think removing the .midx file (and optionally regenerating with the
> old version) would be the appropriate workaround, but I wonder how hard
> it would be to go back to generating v1 midx files by default. I know v2
> is a building block for more advanced features, but for those who are
> not using those features yet it is a strict regression.

I think doing so is just this one-liner:

diff --git a/midx-write.c b/midx-write.c
index 0ff2e45aa7..607de889f9 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1259,7 +1259,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	struct tempfile *incr;
 	struct write_midx_context ctx = {
 		.preferred_pack_idx = NO_PREFERRED_PACK,
-		.version = MIDX_VERSION_V2,
+		.version = MIDX_VERSION_V1,
 	 };
 	struct multi_pack_index *midx_to_free = NULL;
 	int bitmapped_packs_concat_len = 0;

and there is already a midx.version config option to override it. But we
also need to touch the tests a bit. Here we just tweak the expectation
for some low-level examination of the files:

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 58e0b685b1..ed1f993a74 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -19,9 +19,12 @@ midx_read_expect () {
 	NUM_CHUNKS=$3
 	OBJECT_DIR=$4
 	EXTRA_CHUNKS="$5"
+	# This reflects the default midx version we write; it should switch
+	# to 2 if we flip the default.
+	VERSION=1
 	{
 		cat <<-EOF &&
-		header: 4d494458 2 $HASH_LEN $NUM_CHUNKS $NUM_PACKS
+		header: 4d494458 $VERSION $HASH_LEN $NUM_CHUNKS $NUM_PACKS
 		chunks: pack-names oid-fanout oid-lookup object-offsets$EXTRA_CHUNKS
 		num_objects: $NUM_OBJECTS
 		packs:

and then here we need to use v2 for the new compaction feature:

diff --git a/t/t5335-compact-multi-pack-index.sh b/t/t5335-compact-multi-pack-index.sh
index 40f3844282..4ad007169a 100755
--- a/t/t5335-compact-multi-pack-index.sh
+++ b/t/t5335-compact-multi-pack-index.sh
@@ -57,6 +57,13 @@ test_midx_layer_object_uniqueness () {
 	done <$midx_chain
 }
 
+# MIDX compaction requires the v2 format, so make it the default
+# for the rest of this script. We check below that trying
+# compaction with v1 fails using "git -c", which will override this.
+test_expect_success 'set midx version config' '
+	git config --global midx.version 2
+'
+
 test_expect_success 'MIDX compaction with lex-ordered pack names' '
 	git init midx-compact-lex-order &&
 	(

So that would make things work as usual for anybody mixing and matching
multiple versions of Git, but does make life slightly worse for anybody
who wants to use the new feature (they have to set the config). We might
need a doc update, or possibly even to automatically default to v2 when
using the compact command. But that could come post-2.54.

At this point I'll stop poking and speculating and see what direction
Taylor suggests. ;)

-Peff
