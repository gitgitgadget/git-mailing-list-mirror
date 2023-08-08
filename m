Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4248FC001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 16:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjHHQTQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjHHQR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 12:17:57 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D5B6A6A
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 08:48:35 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a412653352so4081518b6e.0
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 08:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691509714; x=1692114514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B9gbon6ObDCQhWLxbaMCbYgypS8qfQ4dDeY+0amCUj4=;
        b=yVZUwF4z/0/28k71fznRgujKcQ3rjLOF7lFLvTZTXmnMOx/19n82G68XQZLxZ9K/zf
         4icSUmd8rt1O6geIynjRbdpzgCcET9tC2dS7hpLV9WzrJn0YxMrAh+F2VR+Z9BbBUpNJ
         tm6Ilqokq5YkFkuIH+JCE4vksoMMN7NdS012XBPgZwiEf6qlkGWAD8PWvuF7xihpXWuh
         bph3Dlx/MizLjAHmWKShP7VO9E+fjCbjaMVxSX3PPtzu6rOG16aQeju0lPgOOn6J04wj
         Mipq4UuVsGZ6/sfVEwHtI+Tg/8WPqbO2B+klU0tx5IvMoDHXaD9wwoNtgRK07Z7arwah
         9/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509714; x=1692114514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9gbon6ObDCQhWLxbaMCbYgypS8qfQ4dDeY+0amCUj4=;
        b=IqubHbtu6VOdW2XEkCEvQk9EmHAts9mZfC4IGZwqHVUimpIxkmkX02XRfFGDB/Jn6+
         484HAIO09MMTRLc7g2S01OthkBwPMm1AVF2wT9R1lkx2mAHzR0MIppxNGErVXq6NE4RR
         o+wuptICK72fRLR2ki7w6CcVJjITnUIK82RGFE+zuNPBf83XeYlaW7Ar0UW4OzKHtuhb
         FmpMoqO0tdLhKXyilZjGO9femBGmSrUB7wNwbBDrBmK88VrKSPkRVe7AOFUsfYOp7oBP
         QtwRe9PCok11HEDMfsvubNAttCExbDqhYxb/CbqTh2RTkgm6iW0W7P2nZ43kQOYal5Gq
         XPPQ==
X-Gm-Message-State: AOJu0YyVRjSCXVUHTvF9WP+IC7mpiuRQ2/rIifRVwmhhpDCXXLx/D1Ix
        2cEYj0Vk+g+4i9w54PZC3F/ciZFxRIo7JI4G9fLCPw==
X-Google-Smtp-Source: AGHT+IG7kebjNks89JZxDBTtYh725MBD9mmAz1uUQ69JSouinXpuS7E0GOVcGeAzEyrUj+oqTYLVDQ==
X-Received: by 2002:a05:6358:5282:b0:134:c4dc:2c43 with SMTP id g2-20020a056358528200b00134c4dc2c43mr9324860rwa.28.1691506122605;
        Tue, 08 Aug 2023 07:48:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v67-20020a818546000000b00579df9098e3sm3380161ywf.38.2023.08.08.07.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 07:48:42 -0700 (PDT)
Date:   Tue, 8 Aug 2023 10:48:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        lenaic@lhuard.fr, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/6] maintenance: add get_random_minute()
Message-ID: <ZNJVycLBUIXqZ0Xb@nand.local>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
 <fefdaa9457948ee5302e7cbfaae250e0b589d752.1691434300.git.gitgitgadget@gmail.com>
 <ZNFgIyuhlNd8I9Y2@nand.local>
 <xmqq4jlabea3.fsf@gitster.g>
 <xmqqzg329ycm.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzg329ycm.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 07, 2023 at 05:22:49PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> >> I was wondering where else we call srand() within Git, and it looks like
> >> the only other spot is in `lock_file_timeout()`.
> >
> > lock_file_timeout() should be updated to match git_mkstemps_mode(),
> > which was taught to use the csprng_bytes() function with 47efda96
> > (wrapper: use a CSPRNG to generate random file names, 2022-01-17),
> > and this new caller may want to do so as well, perhaps?  I dunno,
> > but the caller then does not have to worry about "initializing it
> > just once".
>
> Of course, the obvious downside is that crypto-secure one may be,
> unlike for its use in mkstemps(), way overkill for lockfiles and
> cron dispersion purposes, as these codepaths are not on the target
> surface.

I think that's an acceptable price to pay here, since we can drop the
code to remember whether or not srand() has been called or not. Here's a
patch that we could take in that direction:

--- 8< ---
Subject: [PATCH] lockfile.c: use a CSPRNG to generate backoff milliseconds

Upon failing to acquire the lockfile, `lock_file_timeout()` will try
again with an exponential backoff. This backoff includes some noise as a
multiplier over the default backoff behavior ranging from [0.75, 1.25].

It generates this noise via rand(3). Using a non-cryptographic source of
randomness here is OK, since a more trivial attack vector (holding the
file open via an external process for longer than the value of
`timeout_ms`) is easier to exploit.

That all said, `lock_file_timeout()` initializes the PRNG with
`srand()`. This has a couple of downsides:

  - lock_file_timeout() needs to remember whether or not the PRNG has
    or hasn't been seeded.

  - If a different function also calls `srand()`, the PRNG may start
    generating repeated values (if that caller also initialized the PRNG
    with `getpid()`).

Let's avoid both of these by using `csprng_bytes()`, in a similar spirit
as 47efda967c (wrapper: use a CSPRNG to generate random file names,
2022-01-17).

Using a CSPRNG is definitely overkill for noising a backoff window, but
it avoids the concerns about calling `srand()`, so let's use it here,
too.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 lockfile.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 1d5ed01682..6587d407f4 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -107,22 +107,17 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
 	int n = 1;
 	int multiplier = 1;
 	long remaining_ms = 0;
-	static int random_initialized = 0;

 	if (timeout_ms == 0)
 		return lock_file(lk, path, flags, mode);

-	if (!random_initialized) {
-		srand((unsigned int)getpid());
-		random_initialized = 1;
-	}
-
 	if (timeout_ms > 0)
 		remaining_ms = timeout_ms;

 	while (1) {
 		long backoff_ms, wait_ms;
 		int fd;
+		uint64_t rand;

 		fd = lock_file(lk, path, flags, mode);

@@ -135,7 +130,10 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,

 		backoff_ms = multiplier * INITIAL_BACKOFF_MS;
 		/* back off for between 0.75*backoff_ms and 1.25*backoff_ms */
-		wait_ms = (750 + rand() % 500) * backoff_ms / 1000;
+		if (csprng_bytes(&rand, sizeof(uint64_t)) < 0)
+			return error_errno(_("unable to get random bytes for"
+					     "lockfile backoff"));
+		wait_ms = (750 + rand % 500) * backoff_ms / 1000;
 		sleep_millisec(wait_ms);
 		remaining_ms -= wait_ms;

--
2.42.0.rc0.26.g802d811bac.dirty

--- >8 ---

Thanks,
Taylor
