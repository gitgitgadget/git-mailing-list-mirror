Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C0CC2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF8B2082E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhGhyslt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgA3Pzy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:55:54 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42965 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgA3Pzy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 10:55:54 -0500
Received: by mail-yw1-f66.google.com with SMTP id b81so2190484ywe.9
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 07:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mtReyBi9WUUgBMjc31sGmzUYDxKi4/ETBWw03WsAvqE=;
        b=VhGhysltMzaix+K+rCc2idZzM/DBWRys4WVC0BUap/P4fn3+UPGsL894/HxtHBiLyn
         51QFZIbW/sQfq5MaPRlzPcCf8Rmr7lH97Zz7iBsxPS9brmt/C2T8jh2fDEEdSPQXLBcR
         t/JArPMWqTZYTe2H8wMz4ALexL6gOkv2FtkO8Wm3DuTz/HRvj9yjfLPPccvWiURZ9FOB
         FU41IpU32orbH4hffvS1BiFIpluzEf9DoQS0/BBWmEQNKMiXb+F4gWdOGXI8yi9A0KJu
         pOzT+25Ac5B9vJzT5RjE4nEgQi5CE5/ZHj+toJVHiLewMg6VauiiBfzH+uVxccRkakDE
         ZD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mtReyBi9WUUgBMjc31sGmzUYDxKi4/ETBWw03WsAvqE=;
        b=kvwReenGnCq8Iw4Zn2nskF0LFTY9zvtJW1dEq4SNqmnlvclZjUCE9JRop3oILPz5Nv
         3Nmec4ez1hmKUpmNqTXSivrWHzC5Oml8qtdAZMlpvG+tFfyha5bRrQubOewPn5QLBEjL
         HteqobQDxWofDmPzMUA0QWnnauo57Abfx/00r5xrJTJvtianPe7HKgnslWrAIvJAF2fR
         DG4PBgEwZPDdvmSnpY1dUnEt9l4mcDc0No4TfE6hdJ9ak3ods0oFZ4yUE+tsS7Q+EsVx
         sTqPpdffibyH96s98bRzb5U3HgegF/zyZpFz6V+qiY/t5qR5uXpwJYbTfpTJJ1Qnn0C1
         riUg==
X-Gm-Message-State: APjAAAXCl6zPnCOEFcANL6MdUe763Z86O16Pn4BEHwojqcghTd501YiH
        wgrHQ4L6pL+h17dcAqcaTk1vkqrzk4LfUg==
X-Google-Smtp-Source: APXvYqyKOG6tC3Jdf+Ubkgo2+bdkKjILjyqFmFYlsStfZzfROOSgJKKIWsJ4EH/Pd7vmbZuAeggJ4g==
X-Received: by 2002:a81:2781:: with SMTP id n123mr4265939ywn.70.1580399752694;
        Thu, 30 Jan 2020 07:55:52 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id g190sm2636419ywf.41.2020.01.30.07.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 07:55:51 -0800 (PST)
Subject: Re: [PATCH 5/6] dir: replace exponential algorithm with a linear one
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Kevin.Willford@microsoft.com
References: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
 <40b378e7adbbff5ecfd95fd888465fd0f99791c8.1580335424.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <59b5b766-29e2-a709-b407-56bf6ea60b47@gmail.com>
Date:   Thu, 30 Jan 2020 10:55:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <40b378e7adbbff5ecfd95fd888465fd0f99791c8.1580335424.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am very enticed by the subject!

On 1/29/2020 5:03 PM, Elijah Newren via GitGitGadget wrote:
> Unfortunately, commit df5bcdf83aeb ("dir: recurse into untracked dirs
> for ignored files", 2017-05-18), added exactly such a case to the code,

I was disappointed that the commit you mention did not add a test for
the new behavior, but then found a test change in the following commit
fb89888849 (dir: hide untracked contents of untracked dirs, 2017-05-18).
This makes me feel better that your changes are less likely to un-do
the intention of df5bcdf83aeb.

> meaning we'd have two calls to read_directory_recursive() for an
> untracked directory.  So, if we had a file named
>    one/two/three/four/five/somefile.txt
> and nothing in one/ was tracked, then 'git status --ignored' would
> call read_directory_recursive() twice on the directory 'one/', and
> each of those would call read_directory_recursive() twice on the
> directory 'one/two/', and so on until read_directory_recursive() was
> called 2^5 times for 'one/two/three/four/five/'.

Wow! Good find. "Accidentally exponential" is a lot worse than
"accidentally quadratic". At least the N here _usually_ does not
grow too quickly, but the constant here (lstat-ing directories and
files) is significant enough that 2^3 or 2^4 is enough to notice
the difference.

> Avoid calling read_directory_recursive() twice per level by moving a
> lot of the special logic into treat_directory().
> 
> Since dir.c is somewhat complex, extra cruft built up around this over
> time.  While trying to unravel it, I noticed several instances where the
> first call to read_directory_recursive() would return e.g.
> path_untracked for a some directory and a later one would return e.g.
> path_none, and the code relied on the side-effect of the first adding
> untracked entries to dir->entries in order to get the correct output
> despite the supposed override in return value by the later call.
>
> I am somewhat concerned that there are still bugs and maybe even
> testcases with the wrong expectation.  I have tried to carefully
> document treat_directory() since it becomes more complex after this
> change (though much of this complexity came from elsewhere that probably
> deserved better comments to begin with).  However, much of my work felt
> more like a game of whackamole while attempting to make the code match
> the existing regression tests than an attempt to create an
> implementation that matched some clear design.  That seems wrong to me,
> but the rules of existing behavior had so many special cases that I had
> a hard time coming up with some overarching rules about what correct
> behavior is for all cases, forcing me to hope that the regression tests
> are correct and sufficient.  (I'll note that this turmoil makes working
> with dir.c extremely unpleasant for me; I keep hoping it'll get better,
> but it never seems to.)

Keep fighting the good fight! It appears that some of our most-important
code has these complicated cases and side-effects because it has grown
so organically over time. It's unlikely that someone _could_ rewrite it
to avoid that pain, as dir.c contains a lot of accumulated knowledge from
the many special-cases Git handles. I suppose the only thing we can do
is try to write as many detailed tests as possible.

> However, on the positive side, it does make the code much faster.  For
> the following simple shell loop in an empty repository:
> 
>   for depth in $(seq 10 25)
>   do
>     dirs=$(for i in $(seq 1 $depth) ; do printf 'dir/' ; done)
>     rm -rf dir
>     mkdir -p $dirs
>     >$dirs/untracked-file
>     /usr/bin/time --format="$depth: %e" git status --ignored >/dev/null
>   done
> 
> I saw the following timings, in seconds (note that the numbers are a
> little noisy from run-to-run, but the trend is very clear with every
> run):
> 
>     10: 0.03
>     11: 0.05
>     12: 0.08
>     13: 0.19
>     14: 0.29
>     15: 0.50
>     16: 1.05
>     17: 2.11
>     18: 4.11
>     19: 8.60
>     20: 17.55
>     21: 33.87
>     22: 68.71
>     23: 140.05
>     24: 274.45
>     25: 551.15

Are these timings on Linux? I imagine that the timings will increase
much more quickly on Windows.

> After this fix, those drop to:
> 
>     10: 0.00
...
>     25: 0.00

Nice. I wonder if presenting these 0.00 values as a table is worth
the space? At least the effect is dramatic.

> In fact, it isn't until a depth of 190 nested directories that it
> sometimes starts reporting a time of 0.01 seconds and doesn't
> consistently report 0.01 seconds until there are 240 nested directories.
> The previous code would have taken
>   17.55 * 2^220 / (60*60*24*365) = 9.4 * 10^59 YEARS
> to have completed the 240 nested directories case.  It's not often
> that you get to speed something up by a factor of 3*10^69.

Awesome.

> WARNING: This change breaks t7063.  I don't know whether that is to be expected
> (I now intentionally visit untracked directories differently so naturally the
> untracked cache should change), or if I've broken something.  I'm hoping to get
> an untracked cache expert to chime in...

I suppose that when the untracked cache is enabled, your expectation that we
do not need to recurse into an untracked directory is incorrect: we actually
want to explore that directory. Is there a mode we can check to see if we
are REALLY REALLY collecting _all_ untracked paths? Perhaps we need to create
one?

I'm CC'ing Kevin Willford because he is more familiar with the Git index
than me, and perhaps the untracked cache in particular.

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  dir.c | 151 ++++++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 105 insertions(+), 46 deletions(-)
> 
> diff --git a/dir.c b/dir.c
> index ef3307718a..aaf038a9c4 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1659,7 +1659,13 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>  	const char *dirname, int len, int baselen, int excluded,
>  	const struct pathspec *pathspec)
>  {
> -	int nested_repo;
> +	/*
> +	 * WARNING: From this function, you can return path_recurse or you
> +	 *          can call read_directory_recursive() (or neither), but
> +	 *          you CAN'T DO BOTH.
> +	 */
> +	enum path_treatment state;
> +	int nested_repo, old_ignored_nr, stop_early;
>  
>  	/* The "len-1" is to strip the final '/' */
>  	switch (directory_exists_in_index(istate, dirname, len-1)) {
> @@ -1713,18 +1719,101 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>  
>  	/* This is the "show_other_directories" case */
>  
> -	if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
> +	/*
> +	 * We only need to recurse into untracked/ignored directories if
> +	 * either of the following bits is set:
> +	 *   - DIR_SHOW_IGNORED_TOO (because then we need to determine if
> +	 *                           there are ignored directories below)
> +	 *   - DIR_HIDE_EMPTY_DIRECTORIES (because we have to determine if
> +	 *                                 the directory is empty)

Perhaps here is where you could also have a DIR_LIST_ALL_UNTRACKED
flag to ensure the untracked cache loads all untracked paths?

> +	 */
> +	if (!(dir->flags & (DIR_SHOW_IGNORED_TOO | DIR_HIDE_EMPTY_DIRECTORIES)))
>  		return excluded ? path_excluded : path_untracked;
>  
> +	/*
> +	 * If we only want to determine if dirname is empty, then we can
> +	 * stop at the first file we find underneath that directory rather
> +	 * than continuing to recurse beyond it.  If DIR_SHOW_IGNORED_TOO
> +	 * is set, then we want MORE than just determining if dirname is
> +	 * empty.
> +	 */
> +	stop_early = ((dir->flags & DIR_HIDE_EMPTY_DIRECTORIES) &&
> +		      !(dir->flags & DIR_SHOW_IGNORED_TOO));
> +
> +	/*
> +	 * If /every/ file within an untracked directory is ignored, then
> +	 * we want to treat the directory as ignored (for e.g. status
> +	 * --porcelain), without listing the individual ignored files
> +	 * underneath.  To do so, we'll save the current ignored_nr, and
> +	 * pop all the ones added after it if it turns out the entire
> +	 * directory is ignored.

Here is a question for an untracked cache expert: Do we store ignored
paths in the untracked cache?

> +	 */
> +	old_ignored_nr = dir->ignored_nr;
> +
> +	/* Actually recurse into dirname now, we'll fixup the state later. */
>  	untracked = lookup_untracked(dir->untracked, untracked,
>  				     dirname + baselen, len - baselen);
> +	state = read_directory_recursive(dir, istate, dirname, len, untracked,
> +					 stop_early, stop_early, pathspec);
> +
> +	/* There are a variety of reasons we may need to fixup the state... */
> +	if (state == path_excluded) {
> +		int i;
> +
> +		/*
> +		 * When stop_early is set, read_directory_recursive() will
> +		 * never return path_untracked regardless of whether
> +		 * underlying paths were untracked or ignored (because
> +		 * returning early means it excluded some paths, or
> +		 * something like that -- see commit 5aaa7fd39aaf ("Improve
> +		 * performance of git status --ignored", 2017-09-18)).
> +		 * However, we're not really concerned with the status of
> +		 * files under the directory, we just wanted to know
> +		 * whether the directory was empty (state == path_none) or
> +		 * not (state == path_excluded), and if not, we'd return
> +		 * our original status based on whether the untracked
> +		 * directory matched an exclusion pattern.
> +		 */
> +		if (stop_early)
> +			state = excluded ? path_excluded : path_untracked;
> +
> +		else {
> +			/*
> +			 * When
> +			 *     !stop_early && state == path_excluded
> +			 * then all paths under dirname were ignored.  For
> +			 * this case, git status --porcelain wants to just
> +			 * list the directory itself as ignored and not
> +			 * list the individual paths underneath.  Remove
> +			 * the individual paths underneath.
> +			 */
> +			for (i = old_ignored_nr + 1; i<dir->ignored_nr; ++i)
> +				free(dir->ignored[i]);
> +			dir->ignored_nr = old_ignored_nr;
> +		}
> +	}
>  
>  	/*
> -	 * If this is an excluded directory, then we only need to check if
> -	 * the directory contains any files.
> +	 * If there is nothing under the current directory and we are not
> +	 * hiding empty directories, then we need to report on the
> +	 * untracked or ignored status of the directory itself.
>  	 */
> -	return read_directory_recursive(dir, istate, dirname, len,
> -					untracked, 1, excluded, pathspec);
> +	if (state == path_none && !(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
> +		state = excluded ? path_excluded : path_untracked;
> +
> +	/*
> +	 * We can recurse into untracked directories that don't match any
> +	 * of the given pathspecs when some file underneath the directory
> +	 * might match one of the pathspecs.  If so, we should make sure
> +	 * to note that the directory itself did not match.
> +	 */
> +	if (pathspec &&
> +	    !match_pathspec(istate, pathspec, dirname, len,
> +			    0 /* prefix */, NULL,
> +			    0 /* do NOT special case dirs */))
> +		state = path_none;
> +
> +	return state;
>  }

This is certainly a substantial change, and I'm not able to read it
carefully right now. I hope to return to it soon, but hopefully I've
pointed out some places that may lead you to resolve your untracked
cache issues.

Thanks,
-Stolee

