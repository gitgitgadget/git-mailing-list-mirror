Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF904D135
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="HpatuzkD"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-67f8d9fe99fso29455666d6.2
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 09:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704909332; x=1705514132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6iUMd0d/pviYe4gTvkVDLCNxjOk5mMN6jQaheKj99ic=;
        b=HpatuzkDg+d1g9awyc780B5vo3LrBJ5H8hc+e4q5pEWmdd3b6j20hfwNmPF02iVUze
         JzysyYUTXEZLNrfHFe+61qY/EwxYu+JBR69BimGe4bmIc+lnGxPIXEgtRPtmukI/wTMH
         PiVGRjEkKIK6dICVjufJC1vQidj25DW5fcQ6HnIxaO/lMCzqUS1D1tKpNihSz7jiXFHu
         tGJtr51dcAjhIWwgBQOfsWYST20UknyTpU2TLN9DBtnLK/iExGl7crc7qVWp3xTnJL9j
         XfAEtuL2OzdjNY9xSXqIVpd6JZUsHWgebk8U+G0kpH5POQXDJv52MKPK6IEC1/tfWvAS
         nrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704909332; x=1705514132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iUMd0d/pviYe4gTvkVDLCNxjOk5mMN6jQaheKj99ic=;
        b=JU5kb6DJsF2yEqkXjCavEJzm6FJOz2s6gdYJa54CIXfFJDfzmSueG5orXIBZJBByKW
         R44EXHFg9+nF+o3dzgVTn5/JZLYSH9g2vm1j3+s5OR2fXa31/x34Juz49GeoGepSJoe6
         +bUlVPxh1mMAczMkQhLUXKZOnqBw44g7L6zJNvUyiwIiHKmNbQTbsYsazm3wLYon917H
         nTCYuQpv/P1mZ2WM7lUgUM0XX1hui3SZRshgjDLhxJewi9n3BdoVBCqCe/CPv+QdnL5x
         mZJNigYKcgvMOOGc7koIWwwMTPx5o5pbFB9Vn1qg76zYVadlyRPLidhhuXI9lwZFQ9Jn
         7KSw==
X-Gm-Message-State: AOJu0YwOHsgb/Jx5c/zFIaD72wdBtxY8F/yqvLHDIcbd/NfLeci7jbql
	Q05+MzsHpOHr0VW8XZtlZLM4znkKFMOWwuljRsGS20Xd+6ndrg==
X-Google-Smtp-Source: AGHT+IFbGnldD4zDChCKISOGy2Cq27nR7FAVOoGukA6SRDC0j+5EmxLVAa+e8w6xURUmWUCiZbLOGA==
X-Received: by 2002:a05:6214:1c05:b0:681:1ada:a418 with SMTP id u5-20020a0562141c0500b006811adaa418mr1686656qvc.104.1704909332136;
        Wed, 10 Jan 2024 09:55:32 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id kj1-20020a056214528100b0067f4e2ad746sm1870317qvb.44.2024.01.10.09.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 09:55:31 -0800 (PST)
Date: Wed, 10 Jan 2024 12:55:30 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] t5309: run expected-to-fail `index-pack`s with
 `--threads=1`
Message-ID: <588de2e4f16ab090ff477088084e0b81d9615ec5.1704909216.git.me@ttaylorr.com>
References: <ZZ7VEVXSg1T8ZkIK@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZZ7VEVXSg1T8ZkIK@nand.local>

The t5309 script triggers a racy false positive with SANITIZE=leak on a
multi-core system. Running with "--stress --run=6" usually fails within
10 seconds or so for me, complaining with something like:

    + git index-pack --fix-thin --stdin
    fatal: REF_DELTA at offset 46 already resolved (duplicate base 01d7713666f4de822776c7622c10f1b07de280dc?)

    =================================================================
    ==3904583==ERROR: LeakSanitizer: detected memory leaks

    Direct leak of 32 byte(s) in 1 object(s) allocated from:
        #0 0x7fa790d01986 in __interceptor_realloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:98
        #1 0x7fa790add769 in __pthread_getattr_np nptl/pthread_getattr_np.c:180
        #2 0x7fa790d117c5 in __sanitizer::GetThreadStackTopAndBottom(bool, unsigned long*, unsigned long*) ../../../../src/libsanitizer/sanitizer_common/sanitizer_linux_libcdep.cpp:150
        #3 0x7fa790d11957 in __sanitizer::GetThreadStackAndTls(bool, unsigned long*, unsigned long*, unsigned long*, unsigned long*) ../../../../src/libsanitizer/sanitizer_common/sanitizer_linux_libcdep.cpp:598
        #4 0x7fa790d03fe8 in __lsan::ThreadStart(unsigned int, unsigned long long, __sanitizer::ThreadType) ../../../../src/libsanitizer/lsan/lsan_posix.cpp:51
        #5 0x7fa790d013fd in __lsan_thread_start_func ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:440
        #6 0x7fa790adc3eb in start_thread nptl/pthread_create.c:444
        #7 0x7fa790b5ca5b in clone3 ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

    SUMMARY: LeakSanitizer: 32 byte(s) leaked in 1 allocation(s).
    Aborted

What happens is this:

  0. We construct a bogus pack with a duplicate object in it and trigger
     index-pack.

  1. We spawn a bunch of worker threads to resolve deltas (on my system
     it is 16 threads).

  2. One of the threads sees the duplicate object and bails by calling
     exit(), taking down all of the threads. This is expected and is the
     point of the test.

  3. At the time exit() is called, we may still be spawning threads from
     the main process via pthread_create(). LSan hooks thread creation
     to update its book-keeping; it has to know where each thread's
     stack is (so it can find entry points for reachable memory). So it
     calls pthread_getattr_np() to get information about the new thread.
     That may allocate memory that must be freed with a matching call to
     pthread_attr_destroy(). Probably LSan does that immediately, but
     if you're unlucky enough, the exit() will happen while it's between
     those two calls, and the allocated pthread_attr_t appears as a
     leak.

This isn't a real leak. It's not even in our code, but rather in the
LSan instrumentation code. So we could just ignore it. But the false
positive can cause people to waste time tracking it down.

It's possibly something that LSan could protect against (e.g., cover the
getattr/destroy pair with a mutex, and then in the final post-exit()
check for leaks try to take the same mutex). But I don't know enough
about LSan to say if that's a reasonable approach or not (or if my
analysis is even completely correct).

One approach to papering over this issue (short of LSan fixing it
upstream) is to make the creation of work threads "atomic", i.e. by
spawning all of them before letting any of them start to work.  This
shouldn't make any practical difference for non-LSan runs. The thread
spawning is quick, and could happen before any worker thread gets
scheduled anyway.

But that requires us to tweak production code (albeit at a negligible
cost) in order to appease LSan in this narrow circumstance. Another
approach is to simply run these expected-to-fail `index-pack`
invocations with `--threads=1` so that we bypass the above issue
entirely.

The downside of that approach is that the test doesn't match our
production code as well as it did before (where we might have run those
same `index-pack` invocations with >1 thread, depending on how many CPUs
the testing machine has). The risk there is that we might miss a
regression that would leave us in an inconsistent state. But that feels
rather unlikely in practice, and there are many other tests related to
`index-pack` in the suite.

Original-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5309-pack-delta-cycles.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5309-pack-delta-cycles.sh b/t/t5309-pack-delta-cycles.sh
index 4e910c5b9d..4100595c89 100755
--- a/t/t5309-pack-delta-cycles.sh
+++ b/t/t5309-pack-delta-cycles.sh
@@ -44,7 +44,7 @@ test_expect_success 'index-pack detects missing base objects' '
 		pack_obj $A $B
 	} >missing.pack &&
 	pack_trailer missing.pack &&
-	test_must_fail git index-pack --fix-thin --stdin <missing.pack
+	test_must_fail git index-pack --threads=1 --fix-thin --stdin <missing.pack
 '
 
 test_expect_success 'index-pack detects REF_DELTA cycles' '
@@ -55,13 +55,13 @@ test_expect_success 'index-pack detects REF_DELTA cycles' '
 		pack_obj $B $A
 	} >cycle.pack &&
 	pack_trailer cycle.pack &&
-	test_must_fail git index-pack --fix-thin --stdin <cycle.pack
+	test_must_fail git index-pack --threads=1 --fix-thin --stdin <cycle.pack
 '
 
 test_expect_success 'failover to an object in another pack' '
 	clear_packs &&
 	git index-pack --stdin <ab.pack &&
-	test_must_fail git index-pack --stdin --fix-thin <cycle.pack
+	test_must_fail git index-pack --threads=1 --stdin --fix-thin <cycle.pack
 '
 
 test_expect_success 'failover to a duplicate object in the same pack' '
@@ -73,7 +73,7 @@ test_expect_success 'failover to a duplicate object in the same pack' '
 		pack_obj $A
 	} >recoverable.pack &&
 	pack_trailer recoverable.pack &&
-	test_must_fail git index-pack --fix-thin --stdin <recoverable.pack
+	test_must_fail git index-pack --threads=1 --fix-thin --stdin <recoverable.pack
 '
 
 test_done
-- 
2.43.0.288.g906e6a084d

