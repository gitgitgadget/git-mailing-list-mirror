Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10E918E361
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731923668; cv=none; b=b8gxdfYGWTPVdh2tVjiTdyo96RdC3r6hO9kxxwbM6JQZO6fMT1R1g4Vof54AYBf2gacSFvLMCNjcAduvxYOQHgd3AohueNJ6H8BmtyileLuC9wXQuCRWZohj46ZWxPjok5aP44ZKgbeeoi3a8awdFiDevPA2630jYAP2kYwW4Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731923668; c=relaxed/simple;
	bh=UGtlmvHoy8NC3ltIkN45ayxL6/cHUUpJC6Z9da2ZnzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqLwLBu7Cs0/sL0XgnI+ECCWrJFZC9J7fgQL9nCfIu75Rqxd4mDil5y+yCd0ITlvST89xafyPnHwh6cE9Hp0qGdpZU4ynnvWiL3MPv4FXSplCfRauBSEu514fFqfdBlBLN0XddNyu9B0zKpHZtKLB+q7SQzXhr9jndFCvNK1m6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ktz9kwu9; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ktz9kwu9"
Received: (qmail 22378 invoked by uid 109); 18 Nov 2024 09:54:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=UGtlmvHoy8NC3ltIkN45ayxL6/cHUUpJC6Z9da2ZnzE=; b=Ktz9kwu9ddmowwQjMC8w7821b7L+/+mS3qsnZKjaVB2RPcPSM5ZBr7BEwxqLIz0WtGboYt+YzxgSbxDDotzsjT9x1zLDgWXb2wS/hEDO+EYknI0Odwz4oqr9T2FF3pv4s1a3zAAh53gxjsi5Lzh7TlPU79pCWOE9f1+c9XamTV9qWKqRz38aYcH50dFHtBvq0F7Uxh0FmF90b+Mpa5JBF9raX0l5e/vOzi3l4TqMehmgX7vQ78EYJCxrUJxyjuVNcFVSgx9xAYJecV3vZK2Mz9o9AvsWGEKkLNTe395xSovRi1fHU0wrxV84i/nW7JScLH2Cx2/fueTsNBSySbdDqA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Nov 2024 09:54:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18248 invoked by uid 111); 18 Nov 2024 09:54:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Nov 2024 04:54:29 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 18 Nov 2024 04:54:23 -0500
From: Jeff King <peff@peff.net>
To: Sam James <sam@gentoo.org>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Subject: [PATCH 0/6] -Wunterminated-string-initialization warning + cleanups
Message-ID: <20241118095423.GA3990835@coredump.intra.peff.net>
References: <87wmh2o9og.fsf@gentoo.org>
 <20241117090329.GA2341486@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241117090329.GA2341486@coredump.intra.peff.net>

> Here are some patches. The first one should fix the warning (but I don't
> have gcc-15 handy to test!). Please let me know if it works for you (and
> thank you for reporting).

And here's a minor re-roll from comments on the list. I was able to
reproduce and test myself this time; the patch indeed fixes the problem.

Changes from v1:

  - add more standards explanation to the first commit (thanks for
    pointers from Chris Torek off-list)

  - fixes small whitespace issues in patches 1 and 6

  - new patch (5) to add "const" as appropriate

  [1/6]: object-file: prefer array-of-bytes initializer for hash literals
  [2/6]: object-file: drop confusing oid initializer of empty_tree struct
  [3/6]: object-file: move empty_tree struct into find_cached_object()
  [4/6]: object-file: drop oid field from find_cached_object() return value
  [5/6]: object-file: treat cached_object values as const
  [6/6]: object-file: inline empty tree and blob literals

 object-file.c | 81 ++++++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 43 deletions(-)

1:  da69342eba ! 1:  ec76b9eebb object-file: prefer array-of-bytes initializer for hash literals
    @@ Commit message
         and then use it to initialize the hash field of an object_id struct.
         That hash field is exactly 32 bytes long (the size we need for sha256).
         But the string literal above is actually 33 bytes long due to the NUL
    -    terminator. It's legal in C to initialize from a longer string literal;
    -    the extra bytes are just ignored.
    +    terminator. This is legal in C, and the NUL is ignored.
     
    -    However, the upcoming gcc 15 will start warning about this:
    +      Side note on legality: in general excess initializer elements are
    +      forbidden, and gcc will warn on both of these:
    +
    +        char foo[3] = { 'h', 'u', 'g', 'e' };
    +        char bar[3] = "VeryLongString";
    +
    +      I couldn't find specific language in the standard allowing
    +      initialization from a string literal where _just_ the NUL is ignored,
    +      but C99 section 6.7.8 (Initialization), paragraph 32 shows this exact
    +      case as "example 8".
    +
    +    However, the upcoming gcc 15 will start warning for this case (when
    +    compiled with -Wextra via DEVELOPER=1):
     
               CC object-file.o
           object-file.c:52:9: warning: initializer-string for array of ‘unsigned char’ is too long [-Wunterminated-string-initialization]
    @@ object-file.c
     -	"\x6f\xe1\x41\xf7\x74\x91\x20\xa3\x03\x72" \
     -	"\x18\x13"
     +#define EMPTY_TREE_SHA1_BIN_LITERAL { \
    -+	 0x4b, 0x82, 0x5d, 0xc6, 0x42, 0xcb, 0x6e, 0xb9, 0xa0, 0x60,  \
    -+	 0xe5, 0x4b, 0xf8, 0xd6, 0x92, 0x88, 0xfb, 0xee, 0x49, 0x04  \
    ++	0x4b, 0x82, 0x5d, 0xc6, 0x42, 0xcb, 0x6e, 0xb9, 0xa0, 0x60, \
    ++	0xe5, 0x4b, 0xf8, 0xd6, 0x92, 0x88, 0xfb, 0xee, 0x49, 0x04  \
     +}
     +#define EMPTY_TREE_SHA256_BIN_LITERAL { \
    -+	0x6e, 0xf1, 0x9b, 0x41, 0x22, 0x5c, 0x53, 0x69, 0xf1, 0xc1,  \
    -+	0x04, 0xd4, 0x5d, 0x8d, 0x85, 0xef, 0xa9, 0xb0, 0x57, 0xb5,  \
    -+	0x3b, 0x14, 0xb4, 0xb9, 0xb9, 0x39, 0xdd, 0x74, 0xde, 0xcc,  \
    ++	0x6e, 0xf1, 0x9b, 0x41, 0x22, 0x5c, 0x53, 0x69, 0xf1, 0xc1, \
    ++	0x04, 0xd4, 0x5d, 0x8d, 0x85, 0xef, 0xa9, 0xb0, 0x57, 0xb5, \
    ++	0x3b, 0x14, 0xb4, 0xb9, 0xb9, 0x39, 0xdd, 0x74, 0xde, 0xcc, \
     +	0x53, 0x21 \
     +}
     +
     +#define EMPTY_BLOB_SHA1_BIN_LITERAL { \
    -+	0xe6, 0x9d, 0xe2, 0x9b, 0xb2, 0xd1, 0xd6, 0x43, 0x4b, 0x8b,  \
    ++	0xe6, 0x9d, 0xe2, 0x9b, 0xb2, 0xd1, 0xd6, 0x43, 0x4b, 0x8b, \
     +	0x29, 0xae, 0x77, 0x5a, 0xd8, 0xc2, 0xe4, 0x8c, 0x53, 0x91  \
     +}
     +#define EMPTY_BLOB_SHA256_BIN_LITERAL { \
    -+	0x47, 0x3a, 0x0f, 0x4c, 0x3b, 0xe8, 0xa9, 0x36, 0x81, 0xa2,  \
    -+	0x67, 0xe3, 0xb1, 0xe9, 0xa7, 0xdc, 0xda, 0x11, 0x85, 0x43,  \
    -+	0x6f, 0xe1, 0x41, 0xf7, 0x74, 0x91, 0x20, 0xa3, 0x03, 0x72,  \
    ++	0x47, 0x3a, 0x0f, 0x4c, 0x3b, 0xe8, 0xa9, 0x36, 0x81, 0xa2, \
    ++	0x67, 0xe3, 0xb1, 0xe9, 0xa7, 0xdc, 0xda, 0x11, 0x85, 0x43, \
    ++	0x6f, 0xe1, 0x41, 0xf7, 0x74, 0x91, 0x20, 0xa3, 0x03, 0x72, \
     +	0x18, 0x13 \
     +}
      
2:  b8416b33d2 = 2:  0beaf2d65e object-file: drop confusing oid initializer of empty_tree struct
3:  8f5a9f5e30 = 3:  d0c28cb1c9 object-file: move empty_tree struct into find_cached_object()
4:  e2d0c9b56d = 4:  551e5938d5 object-file: drop oid field from find_cached_object() return value
-:  ---------- > 5:  d5641358a2 object-file: treat cached_object values as const
5:  7ebc8d2d2c ! 6:  82c43bfc78 object-file: inline empty tree and blob literals
    @@ object-file.c
      
     -
     -#define EMPTY_TREE_SHA1_BIN_LITERAL { \
    --	 0x4b, 0x82, 0x5d, 0xc6, 0x42, 0xcb, 0x6e, 0xb9, 0xa0, 0x60,  \
    --	 0xe5, 0x4b, 0xf8, 0xd6, 0x92, 0x88, 0xfb, 0xee, 0x49, 0x04  \
    +-	0x4b, 0x82, 0x5d, 0xc6, 0x42, 0xcb, 0x6e, 0xb9, 0xa0, 0x60, \
    +-	0xe5, 0x4b, 0xf8, 0xd6, 0x92, 0x88, 0xfb, 0xee, 0x49, 0x04  \
     -}
     -#define EMPTY_TREE_SHA256_BIN_LITERAL { \
    --	0x6e, 0xf1, 0x9b, 0x41, 0x22, 0x5c, 0x53, 0x69, 0xf1, 0xc1,  \
    --	0x04, 0xd4, 0x5d, 0x8d, 0x85, 0xef, 0xa9, 0xb0, 0x57, 0xb5,  \
    --	0x3b, 0x14, 0xb4, 0xb9, 0xb9, 0x39, 0xdd, 0x74, 0xde, 0xcc,  \
    +-	0x6e, 0xf1, 0x9b, 0x41, 0x22, 0x5c, 0x53, 0x69, 0xf1, 0xc1, \
    +-	0x04, 0xd4, 0x5d, 0x8d, 0x85, 0xef, 0xa9, 0xb0, 0x57, 0xb5, \
    +-	0x3b, 0x14, 0xb4, 0xb9, 0xb9, 0x39, 0xdd, 0x74, 0xde, 0xcc, \
     -	0x53, 0x21 \
     -}
     -
     -#define EMPTY_BLOB_SHA1_BIN_LITERAL { \
    --	0xe6, 0x9d, 0xe2, 0x9b, 0xb2, 0xd1, 0xd6, 0x43, 0x4b, 0x8b,  \
    +-	0xe6, 0x9d, 0xe2, 0x9b, 0xb2, 0xd1, 0xd6, 0x43, 0x4b, 0x8b, \
     -	0x29, 0xae, 0x77, 0x5a, 0xd8, 0xc2, 0xe4, 0x8c, 0x53, 0x91  \
     -}
     -#define EMPTY_BLOB_SHA256_BIN_LITERAL { \
    --	0x47, 0x3a, 0x0f, 0x4c, 0x3b, 0xe8, 0xa9, 0x36, 0x81, 0xa2,  \
    --	0x67, 0xe3, 0xb1, 0xe9, 0xa7, 0xdc, 0xda, 0x11, 0x85, 0x43,  \
    --	0x6f, 0xe1, 0x41, 0xf7, 0x74, 0x91, 0x20, 0xa3, 0x03, 0x72,  \
    +-	0x47, 0x3a, 0x0f, 0x4c, 0x3b, 0xe8, 0xa9, 0x36, 0x81, 0xa2, \
    +-	0x67, 0xe3, 0xb1, 0xe9, 0xa7, 0xdc, 0xda, 0x11, 0x85, 0x43, \
    +-	0x6f, 0xe1, 0x41, 0xf7, 0x74, 0x91, 0x20, 0xa3, 0x03, 0x72, \
     -	0x18, 0x13 \
     -}
     -
      static const struct object_id empty_tree_oid = {
     -	.hash = EMPTY_TREE_SHA1_BIN_LITERAL,
    -+	.hash ={
    ++	.hash = {
     +		0x4b, 0x82, 0x5d, 0xc6, 0x42, 0xcb, 0x6e, 0xb9, 0xa0, 0x60,
     +		0xe5, 0x4b, 0xf8, 0xd6, 0x92, 0x88, 0xfb, 0xee, 0x49, 0x04
     +	},
