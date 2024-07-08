Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBB41419B5
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456083; cv=none; b=HQxZpnJsuu8jdd54DkYeOtHSlWLeRI4npSI1F0jBhN+f3+Vi5+UC473RkBZEmon0mgiMSHsGGOBxEvCHej2zR25WpnRu46s9wW85HG+VBbT4t6wl99tLy53fjCDUj70PLHH7PHvQ/Y4nubovclH2F9FveCo1ZVZbBfeUUJvR9oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456083; c=relaxed/simple;
	bh=VSe2dWJ+eCBW2A6lkSqlxbFtIoC81UBhte8y1eQ7gXc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rXAIBQG9VTq9LMa21IYGpSFDJ2OhZNz4LofAom0oJJw5BFpi68mBIC59heVMhBpgMDRJSX7VhbqnUrQqRZtgt2JKhAm2ovKtKOYZF6Q1GqlomAA77rt1K3AIG8q6zHGtprEl+Xsk/uvhW/3sL6pIT3US+9CPlXmGdsFgzfuyWi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SVgFAM7H; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SVgFAM7H"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6423334C47;
	Mon,  8 Jul 2024 12:28:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VSe2dWJ+eCBW2A6lkSqlxbFtIoC81UBhte8y1e
	Q7gXc=; b=SVgFAM7HRnKokC7IoQBfU3xGBgoEGfdoR4U8ntGEB7ASIOGedZ+0VW
	Xs/2kuQQs97qvuoJ0fBNM3yHZVYo558tPBfBX5D8ZuLT7y+jVMuTO6HmcxoAH4ai
	XBrZ3T+iSAjWguvY5p27d/dlDZbWeJjr4v5qTpWL4MYwSmVKN9ryY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5CCA634C46;
	Mon,  8 Jul 2024 12:28:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D4FDD34C44;
	Mon,  8 Jul 2024 12:27:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  chriscool@tuxfamily.org
Subject: Re* [PATCH 1/8] clang-format: indent preprocessor directives after
 hash
In-Reply-To: <20240708092317.267915-2-karthik.188@gmail.com> (Karthik Nayak's
	message of "Mon, 8 Jul 2024 11:23:09 +0200")
References: <20240708092317.267915-1-karthik.188@gmail.com>
	<20240708092317.267915-2-karthik.188@gmail.com>
Date: Mon, 08 Jul 2024 09:27:56 -0700
Message-ID: <xmqqa5irkfw3.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 093F3418-3D47-11EF-B714-C38742FD603B-77302942!pb-smtp20.pobox.com

Subject: cpp: consistently write '#' for CPP directive at column 1

Besides it would get complaints from older compilers and look
strange to older eyes that were trained with such compilers, we will
be introducing a rule to be enforced to new code.  Update a few
existing violators before it happens.

The changes in git-compat-util.h and sha1dc/sha1.c are both about
indenting the body of conditional CPP directives, e.g.,

    (correct)           (incorrect)
    #if foo             #if foo
    # define bar         #define bar
    #endif              #endif

The #define/#undef in pkt-line.c were indented not because they were
inside a conditional compilation block inside #if/#endif but because
they were added inside a function.  As the function body is short,
we can move them out of the function and lose their indentation
without sacrificing the readability.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * So, if we decide to apply a preliminary clean-up to the codebase,
   it should look somethine like this.  I couldn't decide what we
   want to do with diff.h where the indentation is done for the same
   reason as how pkt-line.c temporarily defines hex(), but it is
   messier.

	diff --git i/diff.h w/diff.h
	index 9901c8ca8c..ecaa8ec49e 100644
	--- i/diff.h
	+++ w/diff.h
	@@ -386,12 +386,12 @@ struct diff_options {
	 		COLOR_MOVED_ZEBRA = 3,
	 		COLOR_MOVED_ZEBRA_DIM = 4,
	 	} color_moved;
	-	#define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
	-	#define COLOR_MOVED_MIN_ALNUM_COUNT 20
	+#define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
	+#define COLOR_MOVED_MIN_ALNUM_COUNT 20
	 
	 	/* XDF_WHITESPACE_FLAGS regarding block detection are set at 2, 3, 4 */
	-	#define COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE (1<<5)
	-	#define COLOR_MOVED_WS_ERROR (1<<0)
	+#define COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE (1<<5)
	+#define COLOR_MOVED_WS_ERROR (1<<0)
	 	unsigned color_moved_ws_handling;
	 
	 	struct repository *repo;

  I _think_ the right solution for the first half of this is
  actually to define the enum outside the structure and define
  _DEFAULT and _COUNT next to the enum, all at the top-level of the
  header file outside "struct diff_options" definition.

  But I am unsure how to clean up the latter and that is where I
  stopped.

 git-compat-util.h | 2 +-
 pkt-line.c        | 4 ++--
 sha1dc/sha1.c     | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git c/git-compat-util.h w/git-compat-util.h
index ca7678a379..2cbd7c92b8 100644
--- c/git-compat-util.h
+++ w/git-compat-util.h
@@ -41,7 +41,7 @@ struct strbuf;
 # define GIT_GNUC_PREREQ(maj, min) \
 	((__GNUC__ << 16) + __GNUC_MINOR__ >= ((maj) << 16) + (min))
 #else
- #define GIT_GNUC_PREREQ(maj, min) 0
+# define GIT_GNUC_PREREQ(maj, min) 0
 #endif
 
 
diff --git c/pkt-line.c w/pkt-line.c
index 24479eae4d..30044b2e76 100644
--- c/pkt-line.c
+++ w/pkt-line.c
@@ -132,17 +132,17 @@ void packet_buf_delim(struct strbuf *buf)
 	strbuf_add(buf, "0001", 4);
 }
 
+#define hex(a) (hexchar[(a) & 15])
 void set_packet_header(char *buf, int size)
 {
 	static char hexchar[] = "0123456789abcdef";
 
-	#define hex(a) (hexchar[(a) & 15])
 	buf[0] = hex(size >> 12);
 	buf[1] = hex(size >> 8);
 	buf[2] = hex(size >> 4);
 	buf[3] = hex(size);
-	#undef hex
 }
+#undef hex
 
 static void format_packet(struct strbuf *out, const char *prefix,
 			  const char *fmt, va_list args)
diff --git c/sha1dc/sha1.c w/sha1dc/sha1.c
index f993ef9c69..e82e05425e 100644
--- c/sha1dc/sha1.c
+++ w/sha1dc/sha1.c
@@ -139,9 +139,9 @@
 #define sha1_mix(W, t)  (rotate_left(W[t - 3] ^ W[t - 8] ^ W[t - 14] ^ W[t - 16], 1))
 
 #ifdef SHA1DC_BIGENDIAN
-	#define sha1_load(m, t, temp)  { temp = m[t]; }
+#	define sha1_load(m, t, temp)  { temp = m[t]; }
 #else
-	#define sha1_load(m, t, temp)  { temp = m[t]; sha1_bswap32(temp); }
+#	define sha1_load(m, t, temp)  { temp = m[t]; sha1_bswap32(temp); }
 #endif
 
 #define sha1_store(W, t, x)	*(volatile uint32_t *)&W[t] = x
