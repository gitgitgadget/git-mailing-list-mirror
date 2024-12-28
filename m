Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074172744D
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735413790; cv=none; b=nyO15OUqrPCgNdHuwPWxPEA18wAGpZooZt8IToGZj57VruYNGH7rItEM/zOztvXbjzTfXanOTzWKytXn27KYWzQApsxFKHK+bHpcbX01Q/122+A7KeGVgkpjrDfmYCTfhFxfkLFfM79PNtbPScDUCfl6gpYTIKHA70KYIv+653I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735413790; c=relaxed/simple;
	bh=O5iaeRoKM8R5gn3vfegIwNUPLTyFCKSM4lc3u+bhpis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhGkzQz7ciCLNVK5VL72rUaZ7gXCws3WT5pXE2dcCRMAqM2AMrRqeICEc64jMnDsaEeEtIl864/Hsg9i6x7FS5IhEx2lh3DY83z2pTze4cXAiEbUvLVYzV/ybPXLZstgNIsoXas03/3BMW3MKpFzSQxqIRWHWxMMJZF7Ss38mP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eWXZy09x; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eWXZy09x"
Received: (qmail 24658 invoked by uid 109); 28 Dec 2024 19:23:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=O5iaeRoKM8R5gn3vfegIwNUPLTyFCKSM4lc3u+bhpis=; b=eWXZy09xodv42GfbApyNBI/wlZO3aF9iWBIf2vL6gFJLF66YnlB9nUKKXvzGFwyxRb+LwTTd+bSvlEcjpYIFesga7y/qNdcYpjOyLvFWR3RVwYYM/uQP/2cuZuz8Q2eYubqdtg4Y2nf/vbh7e4YQFMgVDp1zdH35qLlMkY9mcgujUBBXNBk/V6HIlIrWnNaPKMmOnHmC+JL5zCzSOFzqwQHtCG2Aj88Y9FPYv/IaQFiGJqZSGsuSpB+1Uy0CbpzKNgf/kx+2dYwqQea3RjIAMHraqZHCxDoD7ZY3qpwCkUiCdifVunYjqHwPhhIylQO+ivt1FrriGZf6lZJeX76+ww==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 28 Dec 2024 19:23:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30077 invoked by uid 111); 28 Dec 2024 19:23:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 28 Dec 2024 14:23:07 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 28 Dec 2024 14:23:07 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: racy leak sanitizer builds, was Re: [PATCH 0/9] commit-reach:
 -Wsign-compare follow-ups
Message-ID: <20241228192307.GC815586@coredump.intra.peff.net>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
 <xmqqbjwwucvy.fsf@gitster.g>
 <xmqq7c7kubx8.fsf@gitster.g>
 <xmqqbjww65i1.fsf@gitster.g>
 <Z2-2dbYVuuLxpNmK@pks.im>
 <20241228190541.GA815586@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241228190541.GA815586@coredump.intra.peff.net>

On Sat, Dec 28, 2024 at 02:05:41PM -0500, Jeff King wrote:

> So I suspect the race is actually trickier, and that the "weird state"
> is not something that happens just while pthread_create() is being
> called, but is actually running _in the thread itself_. So even though
> pthread_create() has returned for each thread, they are still setting
> themselves up before running.
> [...]
> So a full fix would actually require synchronization where we spawn each
> thread, then wait for all of them to hit the barrier to declare
> themselves ready, and then let them all start running. There is a
> pthread_barrier type that would help with this, but we've never used it
> before (so we'd probably need to at least provide a Windows compat
> layer).

So here's a fix that seems to work, but doesn't address the portability
issues. One tweak is that the exit() call is actually not in a
sub-thread, but in the main thread itself. I don't think that really
changes the analysis too much, but it does mean we need to include the
main thread in the barrier wait.

diff --git a/builtin/grep.c b/builtin/grep.c
index d00ee76f24..933b4503b8 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -101,6 +101,9 @@ static pthread_cond_t cond_write;
 /* Signalled when we are finished with everything. */
 static pthread_cond_t cond_result;
 
+/* Synchronize the start of all threads */
+static pthread_barrier_t start_barrier;
+
 static int skip_first_line;
 
 static void add_work(struct grep_opt *opt, struct grep_source *gs)
@@ -198,6 +201,8 @@ static void *run(void *arg)
 	int hit = 0;
 	struct grep_opt *opt = arg;
 
+	pthread_barrier_wait(&start_barrier);
+
 	while (1) {
 		struct work_item *w = get_work();
 		if (!w)
@@ -229,6 +234,7 @@ static void start_threads(struct grep_opt *opt)
 	pthread_cond_init(&cond_add, NULL);
 	pthread_cond_init(&cond_write, NULL);
 	pthread_cond_init(&cond_result, NULL);
+	pthread_barrier_init(&start_barrier, NULL, num_threads + 1);
 	grep_use_locks = 1;
 	enable_obj_read_lock();
 
@@ -248,6 +254,7 @@ static void start_threads(struct grep_opt *opt)
 			die(_("grep: failed to create thread: %s"),
 			    strerror(err));
 	}
+	pthread_barrier_wait(&start_barrier);
 }
 
 static int wait_all(void)
@@ -284,6 +291,7 @@ static int wait_all(void)
 	pthread_cond_destroy(&cond_add);
 	pthread_cond_destroy(&cond_write);
 	pthread_cond_destroy(&cond_result);
+	pthread_barrier_destroy(&start_barrier);
 	grep_use_locks = 0;
 	disable_obj_read_lock();
 

It would probably be pretty easy to do something similar for index-pack,
though really this is something I guess we'd need to do manually
anywhere we spawn worker threads.

-Peff
