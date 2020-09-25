Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B820C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 05:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BDD720838
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 05:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="z9EMiSxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgIYFxL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 01:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgIYFxK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 01:53:10 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC3FC0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 22:53:10 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id w16so1786471qkj.7
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 22:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZQQoGRur6UtGFOhorNT+zM3CNJcfUlagvFSWRiRNeqI=;
        b=z9EMiSxRnrUFMPYKWEKMQl8HUx9u8STbPU3Pq8oSgMuQBfOWmgTGQeIgy/K6v7rDiR
         BYbPsrVJDCJEwJm5eJ/hmo6V1xd8pXfulYEtmHeLhH6qlPY0BFJ8V61Pwb0aqQ1+5s96
         RnxjVLeTjN8i+FbLIPULEh4sAd2GwIEG3QIFv+hNYqEF4PKfUIMkyCoWERQlmJmqMrb9
         9kEu1Z/lGz7VUGc1SvEKVaim+3/06FUCYlqv5F9JCksw0gug0JmjYsmtPsB/yv8L1liU
         G4yS8Fh74O6imLcD5D9jSgCz7L+Ns07T4mAKC0GK/buR82J8/9rMhBzGckKgIelM3ksB
         6H8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZQQoGRur6UtGFOhorNT+zM3CNJcfUlagvFSWRiRNeqI=;
        b=QeG/Hcyw5XnrMNPNQ88SI7eciSZPMmRdcXIc1wdhk0iTRK6RsvVVnOybsHDwpLsQsG
         QnXT8/5PItMY3icjvm1MsGvAbW8/11xMyf4cKKMJvHUFBxYPdr7+IKbPwNJIqWdc6JXX
         m1FGUkZ58D+IcYDdK+aBgDqvVyxrlPPD/LuBqo40yXousW+X/H9erPRApbnycgqoFiR9
         73XOJxGA7i3giClHzE719ejYScpv/rMtpKANGjjEdUb57S+1u4M8b3KgBfd5wpljgHzC
         Dcc+M2IQCtP5ValhEBImm4UOLyKRgDDxZqUySfuPgrcXW43SON7oL30BEutA4tpEtKE1
         +1GQ==
X-Gm-Message-State: AOAM533ygMYQnf+/WMAIaqHsW4/+BeRn3qZUYq/uHgTxWcFQwOWjHjlh
        dMHA+NsBNSY0iMwZq7ZJxTzdG40LcANhtw==
X-Google-Smtp-Source: ABdhPJzQtvpsiPLStBEBFYm5dWhffcb7FoTc+xPtYITQpYtC+UPPnF5j/Hp6InUBKY+cV07nSqNiWA==
X-Received: by 2002:a05:620a:13a5:: with SMTP id m5mr2687249qki.280.1601013189770;
        Thu, 24 Sep 2020 22:53:09 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.96.45])
        by smtp.gmail.com with ESMTPSA id j6sm1232351qtn.97.2020.09.24.22.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 22:53:08 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     phil.hord@gmail.com
Cc:     dstolee@microsoft.com, git@vger.kernel.org,
        jonathantanmy@google.com, stefanbeller@gmail.com
Subject: Re: RFC - concurrency causes segfault in git grep since 2.26.0
Date:   Fri, 25 Sep 2020 02:52:58 -0300
Message-Id: <20200925055258.79347-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <CABURp0r_VPNeU5ugbJDQo=hV_aOit7W-pf9nhDF9Og=vVJG8tw@mail.gmail.com>
References: <CABURp0r_VPNeU5ugbJDQo=hV_aOit7W-pf9nhDF9Og=vVJG8tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Phil

Thanks for the bug report and for the crash logs.

On Thu, Sep 24, 2020 at 11:36 PM Phil Hord <phil.hord@gmail.com> wrote:
>
> Hi list.  It's been a while.
>
> I can reliably reproduce a segfault in git grep when searching the
> object DB. It is caused by a race when threads > 2.
>
> I have a patch that fixes the problem, but I don't know exactly why.
> Can someone else explain it and/or offer a better solution?
>
> ====
>
> diff --git packfile.c packfile.c
> index e69012e7f2..52b7b54aeb 100644
> --- packfile.c
> +++ packfile.c
> @@ -1812,7 +1812,9 @@ void *unpack_entry(struct repository *r, struct
> packed_git *p, off_t obj_offset,
>                 if (!base)
>                         continue;
>
> +               obj_read_lock();
>                 delta_data = unpack_compressed_entry(p, &w_curs,
> curpos, delta_size);
> +               obj_read_unlock();
>
>                 if (!delta_data) {
>                         error("failed to unpack compressed delta "
>
> ====

Hmm, obj_read_mutex is a recursive lock, so by adding the
obj_read_lock() call here, we are incrementing the lock value to [at
least] 2 (because oid_object_info_extended() had already incremented
once). Therefore, when unpack_compressed_entry() calls obj_read_unlock()
before inflating the entry, the lock is not actually released, only
decremented. So the effect of this change is that the phase III of
unpack_entry() is performed entirely without releasing the lock.

Your crash log shows us that the segfault happened when trying to
memcpy() the string `base` (in unpack_entry()). I.e., the same string
that we had previously added to the delta base cache, right before
calling unpack_compressed_entry() and releasing the lock. The
problematic sequence is:
	add `base` to the cache -> release lock -> inflate ->
	acquire lock -> try to use `base`

Maybe, when a thread X releases the lock to perform decompression,
thread Y acquires the lock and tries to add another base to the cache.
The cache is full, so Y has to remove entries, and it ends up free()'ing
the base that was just inserted by X. Later, X tries to dereference
`base` in patch_entry(), which would cause a segfault. It would also
explain why your change solves the segfault.

I'm not sure, though, why this entry would be removed, since it was just
added... Maybe Y was adding a huge base to the cache, which required
removing all entries?

Anyways, you mentioned you can reproduce the failure quite reliably in your
repo with 20 threads, right? Could you please check with the following patch
applied? It adds a `base` copy to the cache instead of the original string,
allowing us to keep running decompression in parallel but without the risk of
having another thread free()'ing `base` in the mean time.

diff --git a/packfile.c b/packfile.c
index 9ef27508f2..79f83b6034 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1772,14 +1772,15 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 	while (delta_stack_nr) {
 		void *delta_data;
 		void *base = data;
-		void *external_base = NULL;
 		unsigned long delta_size, base_size = size;
 		int i;
 
 		data = NULL;
 
-		if (base)
-			add_delta_base_cache(p, obj_offset, base, base_size, type);
+		if (base) {
+			char *base_dup = memcpy(xmalloc(base_size), base, base_size);
+			add_delta_base_cache(p, obj_offset, base_dup, base_size, type);
+		}
 
 		if (!base) {
 			/*
@@ -1799,7 +1800,6 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 				      p->pack_name);
 				mark_bad_packed_object(p, base_oid.hash);
 				base = read_object(r, &base_oid, &type, &base_size);
-				external_base = base;
 			}
 		}
 
@@ -1818,7 +1818,7 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 			      "at offset %"PRIuMAX" from %s",
 			      (uintmax_t)curpos, p->pack_name);
 			data = NULL;
-			free(external_base);
+			free(base);
 			continue;
 		}
 
@@ -1838,7 +1838,7 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 			error("failed to apply delta");
 
 		free(delta_data);
-		free(external_base);
+		free(base);
 	}
 
 	if (final_type)
--
