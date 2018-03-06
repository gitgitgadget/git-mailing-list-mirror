Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 731DD1F404
	for <e@80x24.org>; Tue,  6 Mar 2018 19:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752997AbeCFTTp (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 14:19:45 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39216 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbeCFTTo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 14:19:44 -0500
Received: by mail-wm0-f66.google.com with SMTP id i3so279421wmi.4
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 11:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tbyjErj+dxc66+UffWXAP9mCI00ZnUyyB7Gueidia7Y=;
        b=B9vggH7f8wtUrhatt9kyubHUYRrsXH7uIC3vQA0aAesYiSscsfzJz+ctiesDULJTy4
         GHiX7CVhmCz5mNbwImgHYopd3zAaC610OlhDY2IcHL2i+B6WZnJ8r3BzX8Hecf/xcHfM
         KdK3e+mUX511NFnrkfNxAsaZYn50foDWCWvFmEPAkvBuh/aNFFIjCxSm8xlG7suCvY6x
         DeKsD2vDqD52PKwXRhpU3KzAtsfbN3Xr2FCIaxP7VqvxUnXF8BEOiRoeDpDxt16mk4AC
         yvj5SsjScJCh6lYDKgykxDYLzGLX+SDXhe7awkkVO37bCS2Yd5yWcEHupIgV1txuObzS
         d+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tbyjErj+dxc66+UffWXAP9mCI00ZnUyyB7Gueidia7Y=;
        b=L0s/z+Y9Szq4x/+I72LBzfj37ZK2V7SeVFPcvUm4BLQggJZXbW1qqmwDkaOEsSDGN3
         5mb8qUoUr+LehfEOsF3tHs49aiLJLFc4tfZ6OMpi/B4YCSf0hHGmjK7PxYibcjWV1cQ5
         1Pegmqw2uPaVbct01iOwFBWd6AGfofT3G16Lur9ODYelocgWbi7oFvQdDXesBGjCjFKI
         yHMdIpBVb847CCp+7T6YEeJWcmsPEWeqqb9hzCvEYq7JaElaN6XjrmF7WzLjkYiztoAv
         gEW9miI4Su2kpPrqwtOPR/ntLD86uDIqUcanG1VF1wKXjY36Z47l9Z8IDauRCRc33rf+
         S+Fw==
X-Gm-Message-State: AElRT7GMRDwhYutCFL0VSqYNhIiDd7JV13EyPPRvDxT70VUt3DiIEWxS
        Xvq0Jgo3jFizDTCyBk8TQYWuNh6v
X-Google-Smtp-Source: AG47ELt2EZEY9rPeT5o9pvThv7tQ/zHPlVPt5iObU1UkI0abys1ZkFrgVor08ESFMKAPkoV6kuTzRg==
X-Received: by 10.28.69.93 with SMTP id s90mr12197150wma.29.1520363982156;
        Tue, 06 Mar 2018 11:19:42 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d8sm9531706wmd.20.2018.03.06.11.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Mar 2018 11:19:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     e@80x24.org, git@vger.kernel.org, peff@peff.net,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 3/5] gc --auto: exclude base pack if not enough mem to "repack -ad"
References: <20180301092046.2769-1-pclouds@gmail.com>
        <20180306104158.6541-1-pclouds@gmail.com>
        <20180306104158.6541-4-pclouds@gmail.com>
Date:   Tue, 06 Mar 2018 11:19:40 -0800
In-Reply-To: <20180306104158.6541-4-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Tue, 6 Mar 2018 17:41:56 +0700")
Message-ID: <xmqqfu5d3tbn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> On linux-2.6.git, valgrind massif reports 1.6GB heap in "pack all"
> case, and 535MB [1] in "pack all except the base pack" case. We save
> roughly 1GB memory by excluding the base pack.

;-)

> gc --auto decides to do this based on an estimation of pack-objects
> memory usage, which is quite accurate at least for the heap part, and
> whether that fits in half of system memory (the assumption here is for
> desktop environment where there are many other applications running).

I was still confused by "decides to do this..." after reading the
above three times.  If this is describing the state _with_ this
patch applied, then "Teach 'gc --auto' to do this automatically..."
would make it clear that is what is going on.

> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> index 571b5a7e3c..35ad420d5c 100644
> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> @@ -59,6 +59,11 @@ then existing packs (except those marked with a `.keep` file)
>  are consolidated into a single pack by using the `-A` option of
>  'git repack'. Setting `gc.autoPackLimit` to 0 disables
>  automatic consolidation of packs.
> ++
> +If the physical amount of memory is considered not enough for `git
> +repack` to run smoothly, `--keep-base-pack` is enabled. This could be
> +overridden by setting `gc.bigBasePackThreshold` which only enables
> +`--keep-base-pack` when the base pack is larger the specified limit.

I somehow find the flow of logic in these two sentences harder to
follow than necessary.  Perhaps swapping the order may make it
easier to grok?  That is:

 - When gc.bigBasePackThreshold is set, packs larger than that will
   automatically be kept (i.e. not considered for repacking);

 - When it is not set, we try to guess how memory constrained we are,
   and behave as if the threshold were set to the size of the
   largest packfile we have (i.e. that single pack is kept).

I think another and bigger reason why I found the original hard to
read is because it is described for those who already understand
what "--keep-base-pack" option does.  Rewriting it not to require
the pre-existing knowledge of that option would make it a lot easier
to grok, I would think (you may not realize it because you wrote the
feature and are very familiar with it, though).

> +--keep-base-pack::
> +	All packs except the base pack are consolidated into a single
> +	pack. The largest pack is considered the base pack.

This makes it sound as if packs with .keep are also repacked unless
they meet the threshold for "base pack".  Is that what you actually
implemented?

In order to do so, [2/5] needs to allow the "--keep-pack" option
override the on-disk .keep files.  In an earlier message, I wondered
if such an arrangement is useful in some use cases; I think it is,
and because those who do want to see the on-disk .keep files honored
can collect and include them in the set of packs to be kept via
"--keep-pack" (after all this is an option for low-level scripting
anyway).

> +Set environment variable `GIT_TRACE` in order to see the memory usage
> +estimation in `git gc --auto` that determines whether the base pack is
> +kept.

This is somewhat a puzzling use of trace.  It sounds more like a way
to find out "how" memory usage estimation is done and arriving at a
wrong value for those who want to debug the feature.

> +static unsigned long big_base_pack_threshold;
> +static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;

A new symbol, which is a good addition.

> +static struct packed_git *find_the_base_pack(void)
> +{
> +	struct packed_git *p, *base = NULL;
> +
> +	prepare_packed_git();
> +
> +	for (p = packed_git; p; p = p->next) {
> +		if (p->pack_local &&
> +		    (!base || base->pack_size < p->pack_size))
> +			base = p;
> +	}
> +
> +	return base;
> +}

This is finding the largest pack.

> @@ -187,7 +211,101 @@ static int too_many_packs(void)
>  	return gc_auto_pack_limit < cnt;
>  }
>  
> -static void add_repack_all_option(void)
> +static inline unsigned long total_ram(void)

"inline"?  We'd rather have compiler figure it out, no?

> +{
> +	unsigned long default_ram = 4;

4 what?  4 bytes?  Name it perhaps "default_ram_gb" or something?

> +#ifdef HAVE_SYSINFO
> +	struct sysinfo si;
> +
> +	if (!sysinfo(&si))
> +		return si.totalram;
> +#elif defined(HAVE_BSD_SYSCTL) && defined(HW_MEMSIZE)
> +	int64_t physical_memory;
> +	int mib[2];
> +	size_t length;
> +
> +	mib[0] = CTL_HW;
> +	mib[1] = HW_MEMSIZE;
> +	length = sizeof(int64_t);
> +	if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0))
> +		return physical_memory;
> +#elif defined(GIT_WINDOWS_NATIVE)
> +	MEMORYSTATUSEX memInfo;
> +
> +	memInfo.dwLength = sizeof(MEMORYSTATUSEX);
> +	if (GlobalMemoryStatusEx(&memInfo))
> +		return memInfo;ullTotalPhys;

Is this legal C in Microsoft land?

> +#else
> +	fprintf(stderr, _("unrecognized platform, assuming %lu GB RAM\n"),
> +		default_ram);
> +#endif
> +	return default_ram * 1024 * 1024 * 1024;
> +}

I wonder if the above should go somewhere under compat/ without
ifdef but split into separate files for individual archs (I do not
know the answer to this question).

> +static void add_repack_all_option(struct packed_git *keep_pack)
>  {
>  	if (prune_expire && !strcmp(prune_expire, "now"))
>  		argv_array_push(&repack, "-a");
> @@ -196,6 +314,10 @@ static void add_repack_all_option(void)
>  		if (prune_expire)
>  			argv_array_pushf(&repack, "--unpack-unreachable=%s", prune_expire);
>  	}
> +
> +	if (keep_pack)
> +		argv_array_pushf(&repack, "--keep-pack=%s",
> +				 basename(keep_pack->pack_name));
>  }
>  
>  static void add_repack_incremental_option(void)
> @@ -218,9 +340,14 @@ static int need_to_gc(void)
>  	 * we run "repack -A -d -l".  Otherwise we tell the caller
>  	 * there is no need.
>  	 */
> -	if (too_many_packs())
> -		add_repack_all_option();
> -	else if (too_many_loose_objects())
> +	if (too_many_packs()) {
> +		struct packed_git *exclude = find_the_base_pack();
> +
> +		if (!pack_objects_uses_too_much_memory(exclude))
> +			exclude = NULL;
> +
> +		add_repack_all_option(exclude);

OK, so we possibly exclude the largest one or nothing (i.e. at most
one --keep-pack is given) here.

> @@ -353,6 +480,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  	const char *name;
>  	pid_t pid;
>  	int daemonized = 0;
> +	int keep_base_pack = -1;
>  
>  	struct option builtin_gc_options[] = {
>  		OPT__QUIET(&quiet, N_("suppress progress reporting")),
> @@ -362,6 +490,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "aggressive", &aggressive, N_("be more thorough (increased runtime)")),
>  		OPT_BOOL(0, "auto", &auto_gc, N_("enable auto-gc mode")),
>  		OPT_BOOL(0, "force", &force, N_("force running gc even if there may be another gc running")),
> +		OPT_BOOL(0, "keep-base-pack", &keep_base_pack,
> +			 N_("repack all other packs except the base pack")),
>  		OPT_END()
>  	};
>  
> @@ -427,8 +557,19 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  			 */
>  			daemonized = !daemonize();
>  		}
> -	} else
> -		add_repack_all_option();
> +	} else {
> +		struct packed_git *base_pack = find_the_base_pack();
> +		struct packed_git *exclude = NULL;
> +
> +		if (keep_base_pack != -1) {
> +			if (keep_base_pack)
> +				exclude = base_pack;

OK, --keep-base-pack option always wins if given...

> +		} else if (base_pack && big_base_pack_threshold &&
> +			   base_pack->pack_size >= big_base_pack_threshold)
> +			exclude = base_pack;

...and then if the largest one is larger than the threshold, it (and
it alone) is kept, but otherwise nothing is kept automatically.

But to those who say "packs larger than this value is too big" via
configuration, keeping only the largest of these above-threshold
packs would look counter-intuitive, wouldn't it, I wonder?

> +		add_repack_all_option(exclude);
> +	}

> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index 41b0be575d..863fdbb0fd 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -5,6 +5,13 @@ test_description='basic git gc tests
>  
>  . ./test-lib.sh
>  
> +test_expect_success 'setup' '
> +	# do not let the amount of physical memory affects gc
> +	# behavior, make sure the pack_objects_uses_too_much_memory()
> +	# always returns false
> +	git config gc.bigBasePackThreshold 2g

Hmph, that is because the configuration wins and we know the trash
repository will never have a pack that large.  OK.

I won't comment on the style issue in the remainder, as it shares
the same as another patch.

> @@ -116,6 +123,28 @@ test_expect_success 'background auto gc respects lock for all operations' '
>  	test_path_is_file .git/refs/heads/should-be-loose
>  '
>  
> +test_expect_success 'gc --keep-base-pack' '
> +	test_create_repo keep-pack &&
> +	(
> +		cd keep-pack &&
> +		for i in 10; do
> +			test_commit $i
> +		done &&
> +		git gc &&

This, because of the set-up step, is guaranteed to pack everything
into one.

> +		( cd .git/objects/pack && ls *.pack ) >pack-list &&
> +		test_line_count = 1 pack-list &&
> +		BASE_PACK=.git/objects/pack/pack-*.pack &&

And that is what these verify.

> +		for i in 10; do
> +			test_commit more-$i
> +		done &&
> +		git gc --keep-base-pack &&

And we allow --keep-base-pack option to pick the largest pack (there
is only one pack anyway) and keep it, which ...

> +		( cd .git/objects/pack && ls *.pack ) >pack-list &&
> +		test_line_count = 2 pack-list &&

... results in two packs in total.  And

> +		test_path_is_file $BASE_PACK &&

... we make sure the first pack is left intact (unlike the earlier
'new-count' test).  This sounds sensible.

> +		git fsck
> +	)
> +'
> +
>  # DO NOT leave a detached auto gc process running near the end of the
>  # test script: it can run long enough in the background to racily
>  # interfere with the cleanup in 'test_done'.
