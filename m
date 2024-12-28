Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99B62111
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735414314; cv=none; b=q8Uav6z5UVahCpq+72XWQiBrQKwxYe/p0iPL6j6LHjtCuUKbz9qg9dZPWHVF4dafs4DfTpHJ9iB3ApheVpmLxdxnimQbmkx1L8UeFZjt78OS4S1Hu5uLLLoWZMY6ZFvWdlfLipyyzCLbj6hPUFwfsKam63zU9jln2ynH+6IR0KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735414314; c=relaxed/simple;
	bh=sDUI/zlcBbDUNUCv3TLPSFmv3fElDmbUWi3Kn7y7c7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thS+La3j5i+BnEmWrAW7pB9aeDfXq/3qlb0gHXi7VkR0y5himEuEkGBkz2FjbV9ALGTRkbSIljGENXzXW3CIhWXbi/EszPA18ZaaeHHSubrBMtRIPhRCiEIEVbj4ZrzI5/9fanl1/MczEm4zHQgLReEqdjRt8t1TQ1xf8CC08Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RgacTaOS; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RgacTaOS"
Received: (qmail 24689 invoked by uid 109); 28 Dec 2024 19:31:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=sDUI/zlcBbDUNUCv3TLPSFmv3fElDmbUWi3Kn7y7c7k=; b=RgacTaOS97VBvmF3ITzDvi57gS1oNCT53Sw+jnT5RbOK4OkPpdT8wbby9dqQxCC+vHVmmmwI9IeKDN4Y1xGeZmeF765qG7Dny3OZlNyifG1N7bGkPexqwIp0dmPsUPiloVt8B8LWTjSao9ROUc0YPAQ85B8axi+oboppjfhPwoJuZqFiUetUvhY5Y2apUee79Y4tDyVCbLuLfvgxcTOnzbn3T/kFKsVOx9Yc4z3u/jWNYbJ2qDaFlmBjQL0GbhCxgOKPcyz7ughHez9zKpw0FbOzrl5FgfL5InZJ6f06/gP3CeS2nNCsy4Zq+Z6I2Q6WsvV1PBZMa9O1OIQdZPr1zA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 28 Dec 2024 19:31:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30182 invoked by uid 111); 28 Dec 2024 19:31:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 28 Dec 2024 14:31:51 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 28 Dec 2024 14:31:51 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: racy leak sanitizer builds, was Re: [PATCH 0/9] commit-reach:
 -Wsign-compare follow-ups
Message-ID: <20241228193151.GA1515174@coredump.intra.peff.net>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
 <xmqqbjwwucvy.fsf@gitster.g>
 <xmqq7c7kubx8.fsf@gitster.g>
 <xmqqbjww65i1.fsf@gitster.g>
 <Z2-2dbYVuuLxpNmK@pks.im>
 <20241228190541.GA815586@coredump.intra.peff.net>
 <20241228192307.GC815586@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241228192307.GC815586@coredump.intra.peff.net>

On Sat, Dec 28, 2024 at 02:23:07PM -0500, Jeff King wrote:

> It would probably be pretty easy to do something similar for index-pack,
> though really this is something I guess we'd need to do manually
> anywhere we spawn worker threads.

Here's what that would look like. Confirmed that this fixes the issue
running t5309 with --stress. Dropping the extra locks in
resolve_deltas() is just backing out that earlier insufficient attempt
to synchronize things.

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index d773809c4c..de1f5d8628 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -185,6 +185,8 @@ static pthread_mutex_t deepest_delta_mutex;
 
 static pthread_key_t key;
 
+static pthread_barrier_t start_barrier;
+
 static inline void lock_mutex(pthread_mutex_t *mutex)
 {
 	if (threads_active)
@@ -209,6 +211,7 @@ static void init_thread(void)
 	if (show_stat)
 		pthread_mutex_init(&deepest_delta_mutex, NULL);
 	pthread_key_create(&key, NULL);
+	pthread_barrier_init(&start_barrier, NULL, nr_threads);
 	CALLOC_ARRAY(thread_data, nr_threads);
 	for (i = 0; i < nr_threads; i++) {
 		thread_data[i].pack_fd = xopen(curr_pack, O_RDONLY);
@@ -231,6 +234,7 @@ static void cleanup_thread(void)
 	for (i = 0; i < nr_threads; i++)
 		close(thread_data[i].pack_fd);
 	pthread_key_delete(key);
+	pthread_barrier_destroy(&start_barrier);
 	free(thread_data);
 }
 
@@ -1100,6 +1104,8 @@ static int compare_ref_delta_entry(const void *a, const void *b)
 
 static void *threaded_second_pass(void *data)
 {
+	if (threads_active)
+		pthread_barrier_wait(&start_barrier);
 	if (data)
 		set_thread_data(data);
 	for (;;) {
@@ -1336,15 +1342,13 @@ static void resolve_deltas(struct pack_idx_option *opts)
 	base_cache_limit = opts->delta_base_cache_limit * nr_threads;
 	if (nr_threads > 1 || getenv("GIT_FORCE_THREADS")) {
 		init_thread();
-		work_lock();
 		for (i = 0; i < nr_threads; i++) {
 			int ret = pthread_create(&thread_data[i].thread, NULL,
 						 threaded_second_pass, thread_data + i);
 			if (ret)
 				die(_("unable to create thread: %s"),
 				    strerror(ret));
 		}
-		work_unlock();
 		for (i = 0; i < nr_threads; i++)
 			pthread_join(thread_data[i].thread, NULL);
 		cleanup_thread();
