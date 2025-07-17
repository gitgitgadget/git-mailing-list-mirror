Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43551EF092
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 22:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752790174; cv=none; b=MduwmDnclMwVdgJ/dQ47wJvgowdmB3+oL3OW0AyAwW/cb5bqaMESY+2J/fLL6rnsCnA2aJ8fEvh//CuspFXnGaJGjHqt2dIu1lsMJd8ZCNDhnPFM4kWGEF6Vzs9WsNYKXc/GZS7QnibNcrxgfBhUnDv2s0n+GSIAUtT67D7sBbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752790174; c=relaxed/simple;
	bh=pw6Ruu3bbbdwCsbkFSSib4BNFuvP1Ee370nG6a9ZGfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emBzN5CnPuVGKmd6B2BGjnwlfGqOrKD6iSJaQQi1BXh9u601+4FF2qnXMcBdtSEZrqZt6ik41IBhaA6SaYAxhZx4KHjZq1Ak2WaEXKFJj9oeApBp1D6Md3DuAyxZ2qJNTktL8XRQ+nLH0zvFNb8gDtPMRzuvhSjgPImkWssKLL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=J4c4fCRh; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="J4c4fCRh"
Received: (qmail 15050 invoked by uid 109); 17 Jul 2025 22:09:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pw6Ruu3bbbdwCsbkFSSib4BNFuvP1Ee370nG6a9ZGfY=; b=J4c4fCRhxrn3NEv7W5SZEHb86l/RZXYt1qT0NHkuGQJibKep0KS8HEac+0TIYnpk3AqVFnMqcfRYbUBThR+zMRybyR2CiJriMzbE2X3skcgiIziT7AEafQ63fCdeTzdy8Nq2mjmhezTEv4Aq8Qdo9DVMumD59UMjT7HtEaE342z6DDqCUcvEZU+NEK7OdFcABMTewi2HEVAc7XpYZCjVpW7115Q/FrNeWVKKxIJ0TXBxvFJpFoI+hAwYGQSjDk8GZMUkU9LjN4i0dpg+rvFhjWtN6abGCpmz78u7kEtmktIspmDhU72BEAN4rjKYDZHO+Et5CgI3C1DcOJYFdubm7g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Jul 2025 22:09:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11909 invoked by uid 111); 17 Jul 2025 22:09:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Jul 2025 18:09:32 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 17 Jul 2025 18:09:29 -0400
From: Jeff King <peff@peff.net>
To: Kyle Lippincott <spectral@google.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	schwab@linux-m68k.org, phillip.wood123@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 0/5] for-each-ref: introduce seeking functionality via
 '--start-after'
Message-ID: <20250717220929.GB2244266@coredump.intra.peff.net>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
 <xmqqple1gtyg.fsf@gitster.g>
 <CAO_smVg9TDakUnubepjPGmLyOzW6n8Z=MDbnZKvkwN2=kN2RRw@mail.gmail.com>
 <20250717015402.GA2127425@coredump.intra.peff.net>
 <CAO_smVgdaOxiD_494qA+VxkmxNd6c=XqJDcCE2weCTknWfmkkA@mail.gmail.com>
 <CAOLa=ZQPOP0DkK9L5XLmA_uzH7jWwX-ti8AgaEcAF2Mon=w0BA@mail.gmail.com>
 <CAO_smVj4e0XOQyQr5sDyMZ8WPvqcBe2Y33DFHrED7C=VJnm4eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO_smVj4e0XOQyQr5sDyMZ8WPvqcBe2Y33DFHrED7C=VJnm4eg@mail.gmail.com>

On Thu, Jul 17, 2025 at 12:35:58PM -0700, Kyle Lippincott wrote:

> > ==3275333==WARNING: MemorySanitizer: use-of-uninitialized-value
> >     #0 0x557bd886f4bb in git_mkstemps_mode ../wrapper.c:487:27
> >     #1 0x557bd886fb55 in git_mkstemp_mode ../wrapper.c:509:9
> >     #2 0x557bd8100d1a in create_tmpfile ../object-file.c:736:7
> >     #3 0x557bd80f1630 in start_loose_object_common ../object-file.c:781:7
> >     #4 0x557bd80f5203 in write_loose_object ../object-file.c:881:7
> >     #5 0x557bd80f4875 in write_object_file_flags ../object-file.c:1086:6
> >     #6 0x557bd80f9f65 in write_object_file ../object-file.h:181:9
> >     #7 0x557bd8101eb8 in index_mem ../object-file.c:1177:9
> >     #8 0x557bd80f8bd5 in index_core ../object-file.c:1247:10
> >     #9 0x557bd80f731d in index_fd ../object-file.c:1274:9
> >     #10 0x557bd80f95e4 in index_path ../object-file.c:1295:7
> >     #11 0x557bd831132d in add_to_index ../read-cache.c:771:7
> >     #12 0x557bd8313cb1 in add_file_to_index ../read-cache.c:804:9
> >     #13 0x557bd73f892c in add_files ../builtin/add.c:355:7
> >     #14 0x557bd73f4752 in cmd_add ../builtin/add.c:578:18
> >     #15 0x557bd7a38b6f in run_builtin ../git.c:480:11
> >     #16 0x557bd7a31d54 in handle_builtin ../git.c:746:9
> >     #17 0x557bd7a36644 in run_argv ../git.c:813:4
> >     #18 0x557bd7a30e09 in cmd_main ../git.c:953:19
> >     #19 0x557bd7a3ca01 in main ../common-main.c:9:11
> >     #20 0x7f7e3f02a4d7 in __libc_start_call_main
> > (/nix/store/g2jzxk3s7cnkhh8yq55l4fbvf639zy37-glibc-2.40-66/lib/libc.so.6+0x2a4d7)
> > (BuildId: f117ee0f586dfa828cbdd08e37393c8f04f6480a)
> >     #21 0x7f7e3f02a59a in __libc_start_main@GLIBC_2.2.5
> > (/nix/store/g2jzxk3s7cnkhh8yq55l4fbvf639zy37-glibc-2.40-66/lib/libc.so.6+0x2a59a)
> > (BuildId: f117ee0f586dfa828cbdd08e37393c8f04f6480a)
> >     #22 0x557bd7352b34 in _start (git+0x5db34)
> >
> > Possibly something we need to look into cleaning up.
> 
> I also saw those msan issues when trying `make
> CFLAGS=-fsanitize=memory CC=clang`, but not with Google's internal
> msan build. I don't know which variable in wrapper.c:487 it's
> complaining about - you'd think it'd be `letters`, but if it's `v`,
> then that potentially comes from OpenSSL or some other library, and
> that library would also need to be built with msan (which is why it's
> such a pain to get msan builds working - EVERY library needs to be
> built with memory sanitizer).

Yeah, presumably it is "v" from csprng_bytes(). If there are only a few
such spots, we can manually "unpoison" memory coming from libraries. On
my system, I didn't hit the case shown above but do have trouble with
bytes coming back from zlib.

Applying this ancient patch:

  https://lore.kernel.org/git/20171004101932.pai6wzcv2eohsicr@sigill.intra.peff.net/

and building with "make SANITIZE=memory CC=clang" let me run t6302 to
completion, modulo the bug that started this thread (and which I
confirmed goes away both with MSan and valgrind with the fix Karthik
posted).

Probably:

diff --git a/wrapper.c b/wrapper.c
index 2f00d2ac87..6a4c1c1c29 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -482,6 +482,8 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 		if (csprng_bytes(&v, sizeof(v), 0) < 0)
 			return error_errno("unable to get random bytes for temporary file");
 
+		msan_unpoison(&v, sizeof(v));
+
 		/* Fill in the random bits. */
 		for (i = 0; i < num_x; i++) {
 			filename_template[i] = letters[v % num_letters];


on top of that would fix the problem you guys are seeing. I don't know
if that path leads to insanity, though. Using MSan-enabled libraries is
probably a better direction (should increase accuracy, and we don't have
to carry these manual annotations around).

-Peff
