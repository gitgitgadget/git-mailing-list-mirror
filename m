Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCA2C433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 01:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348593AbiFNBkP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 21:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiFNBkO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 21:40:14 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04245192B5
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 18:40:13 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id q104so5542838qvq.8
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 18:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QGcwZ0v7qf8uO3yYvmLtIwX3H/f5eVSsAU608gYN120=;
        b=3JjYXWr+TaD70rMSOuO01whuO+zRtIE7n7Vhe5hvJm1boKH1Ylo7lJ9SuEm23lBFP1
         vV7RmBGiTJk3qjfY8S7PfEEvl+q0Vpo+tjQSaMLVBoD3nBcK5qIy3cMtCS6uqpqgqiwp
         Pg7cwGEvz/HxrzD6/Hyz5UhYeGfwB1uqqjDSv/CgmgJ2AvUSYqvNSUqd/JCWpgBibb0H
         HnJLdJQy571GjdlLiSObZqTCt6ibTqFAh1IQmpqNr0oEo/o4AZBfns4jT1pg3Iqcd9jn
         HtbBxWvUbEpHRhw2SaXZGR9jIoE3sZokl0VO2ferX3Ht/jBqxlY1QSN+9QvXtfS0tGSw
         bUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QGcwZ0v7qf8uO3yYvmLtIwX3H/f5eVSsAU608gYN120=;
        b=Nq6mxfsH5qEyInDrV/1Ayw/cBgCNJYaHpEDnyCwMHrAHrAA91u4st9S24mP9jCwOpc
         zJNBnBXq1S8DCiJrhVABZ7uuf2IViqRwzCu43Wqk9nt+YfJHzJQEkAomfg3J6naKBq0D
         W1j1p+fxTz/88A8N+5Yve0wLZ90OURUceiMYSMRXBeLn6XAM5mqjjus2HFjjbQyJSaTG
         QS5WDW85HJnFWWPMUGNfXJXgJUf15kh+u7jORZTs9m3QQ32KGEFKzBfuXfPoWbfpdikc
         THjFgY8AuCAN+owP94VTMxlQQVZCSvaxvux5vdbfeCduKs41WanW0C5T663u+bkSd9cG
         q0hg==
X-Gm-Message-State: AJIora9LOs4ZEQxGZ4l5hOTzpSNAAfIQxWne62nVw6TKlpim23eO7ykU
        is5rehPQwxVzx3caVP21A8K3iw==
X-Google-Smtp-Source: AGRyM1uLP1i4J87XQkWvfbFb3QVzzts1U32JiEsw4iKVS/vFNeCRk9hrt+9WjQ0dMXcRijq1kn/NGA==
X-Received: by 2002:a05:6214:242e:b0:467:d5e7:aa79 with SMTP id gy14-20020a056214242e00b00467d5e7aa79mr1889166qvb.131.1655170812033;
        Mon, 13 Jun 2022 18:40:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w13-20020a05620a444d00b006a6cadd89efsm8840459qkp.82.2022.06.13.18.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 18:40:11 -0700 (PDT)
Date:   Mon, 13 Jun 2022 21:40:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 5/5] bitmap: add trace2 outputs during open "bitmap"
 file
Message-ID: <Yqfm+rsP5DWyj95L@nand.local>
References: <cover.1655018322.git.dyroneteng@gmail.com>
 <e118758d1dada378d65d58579cc1372fa547d720.1655018322.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e118758d1dada378d65d58579cc1372fa547d720.1655018322.git.dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 12, 2022 at 03:44:20PM +0800, Teng Long wrote:
> It's supported for a repo to use bitmap in both "NORMAL" bitmap way

I'm nitpicking, but I usually say "single-pack bitmap" or "multi-pack
(MIDX) bitmap" when distinguishing between the two.

> or a MIDX (multi-pack-index) bitmap. Either of two bitmap kinds can
> exist in the repository, or both can be stored but let the config
> controls which kind of bitmap is used (like "core.multipackIndex",
> etc.). Because of this, sometimes the bitmap debug path is not
> obvious enough, for example, when executing:
>
>  $git rev-list  --test-bitmap  HEAD
>  fatal: failed to load bitmap indexes

Odd spacing, and there should be a single space character separating "$"
from "git" (like "$ git").

While I'm thinking about it: is the error message here up-to-date with
the changes made by the previous patch?

> If we see the output like this, It's not sure for us to know
> what's happened concretely, because the cause should be :
>
>   1. Neither normal nor MIDX bitmap exists.
>   2. Only MIDX bitmap exists but core.multipackIndex="false".
>   3. Config core.multipackIndex set to "true" but MIDX  bitmap is
>      corrupted.
>   4. Config core.multipackIndex set to "true" and no MIDX bitmap
>      exists but normal bitmap file is corrupted.
>   ....
>
> These are some of the scenarios I briefly tested, but maybe there are
> others (some scenarios is produced manually like "corrupted bitmap file",
> but it's not represent it's an existed bug.).

This could probably be trimmed down for brevity, but I don't feel
strongly about it. If you wanted to make your commit message a tad
shorter, perhaps something like:

  When a user sees output like this, it's unclear which kind(s) of
  .bitmap exist, and which were read. For example, it's possible a MIDX
  bitmap exists, but was not read (e.g., because
  core.multiPackIndex=false), among many other scenarios.

would suffice.

> Therefore, we added some TRACE2 code so that when we read the bitmap

s/TRACE2/trace2

> we can be more clear about the decision path, such as whether it is
> working on MIDX or NORMAL bitmap at present, or the related config is

s/NORMAL/pack

> enabled or not. This may help with logging, user troubleshooting, and
> development debugging.
>
> Here are some brief output examples on different scenarios when
> executing:
>
>   $GIT_TRACE2_PERF=1 git rev-list --test-bitmap HEAD

s/$GIT/$ GIT

> Scenario 1: core.multipackIndex [false], midx bitmap exists [Y],
> normal bitmap exists [N]

The output here is quite wide, and I wonder if this whole section could
be shortened. For example, scenario 2 is arguably more interesting than
scenario 1 (I think readers would reasonably infer what happens in
scenario 1 by reading what happens in scenario 2).

>        19:21:56.580349 repo-settings.c:11           | d0 | main                     | data         | r1  |  0.000827 |  0.000827 | config       | core.multipackindex:false
>        19:21:56.580356 repo-settings.c:11           | d0 | main                     | data         | r1  |  0.000834 |  0.000834 | config       | index.sparse:false
>        19:21:56.580706 pack-bitmap.c:525            | d0 | main                     | region_enter | r1  |  0.001183 |           | pack-bitmap  | label:open_bitmap
>        19:21:56.580719 pack-bitmap.c:386            | d0 | main                     | data         | r1  |  0.001196 |  0.000013 | bitmap       | ..path:.git/objects/pack/pack-e9eb18e6a423057f4424a762069e13804a75d01e.bitmap
>        19:21:56.580729 pack-bitmap.c:530            | d0 | main                     | region_leave | r1  |  0.001207 |  0.000024 | pack-bitmap  | label:open_bitmap
>        19:21:56.580737 usage.c:60                   | d0 | main                     | error        |     |           |           |              | failed to load bitmap indexes
>        fatal: failed to load bitmap indexes
>        19:21:56.580746 usage.c:74                   | d0 | main                     | exit         |     |  0.001224 |           |              | code:128
>        19:21:56.580754 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001232 |           |              | code:128
>
> Scenario 2: core.multipackIndex [false], midx bitmap exists [Y],
> normal bitmap exists [Y]
>
> 	19:23:44.692384 repo-settings.c:11           | d0 | main                     | data         | r0  |  0.000765 |  0.000765 | config       | core.multipackindex:false
> 	19:23:44.692755 pack-bitmap.c:525            | d0 | main                     | region_enter | r0  |  0.001135 |           | pack-bitmap  | label:open_bitmap
> 	19:23:44.692768 pack-bitmap.c:386            | d0 | main                     | data         | r0  |  0.001149 |  0.000014 | bitmap       | ..path:/home/tenglong.tl/test/dyrone_bitmap/.git/objects/pack/pack-e9eb18e6a423057f4424a762069e13804a75d01e.bitmap
> 	19:23:44.692790 pack-bitmap.c:530            | d0 | main                     | region_leave | r0  |  0.001171 |  0.000036 | pack-bitmap  | label:open_bitmap
> 	Bitmap v1 test (1 entries loaded)
> 	Found bitmap for d864fefa87415d6cd289c72aa9ffd45b4a8ffd84. 64 bits / 11030517 checksum
> 	19:23:44.693119 progress.c:268               | d0 | main                     | region_enter | r0  |  0.001500 |           | progress     | label:Verifying bitmap entries
> 	Verifying bitmap entries: 100% (3/3), done.
> 	19:23:44.693208 progress.c:339               | d0 | main                     | data         | r0  |  0.001589 |  0.000089 | progress     | ..total_objects:3
> 	19:23:44.693216 progress.c:346               | d0 | main                     | region_leave | r0  |  0.001597 |  0.000097 | progress     | label:Verifying bitmap entries
> 	OK!
> 	19:23:44.693234 git.c:718                    | d0 | main                     | exit         |     |  0.001615 |           |              | code:0
> 	19:23:44.693244 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.001625 |           |              | code:0

And scenario 2 could be cleaned up by just showing a few of the columns
from the trace2 output. Perhaps along the lines of:

> 	| data         | r0  |  0.000765 |  0.000765 | config       | core.multipackindex:false
> 	| region_enter | r0  |  0.001135 |           | pack-bitmap  | label:open_bitmap
> 	| data         | r0  |  0.001149 |  0.000014 | bitmap       | ..path:.git/objects/pack/pack-e9eb18e6a423057f4424a762069e13804a75d01e.bitmap
> 	| region_leave | r0  |  0.001171 |  0.000036 | pack-bitmap  | label:open_bitmap
> 	| region_enter | r0  |  0.001500 |           | progress     | label:Verifying bitmap entries

Reading the below scenarios, I think just showing this example is more
than sufficient for illustrating your point.

> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  pack-bitmap.c   | 27 +++++++++++++++++++++------
>  repo-settings.c |  1 +
>  2 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 5654eb7b8d..ced5993560 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -312,9 +312,11 @@ char *pack_bitmap_filename(struct packed_git *p)
>  static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>  			      struct multi_pack_index *midx)
>  {
> +	int fd;
>  	struct stat st;
>  	char *bitmap_name = midx_bitmap_filename(midx);
> -	int fd = git_open(bitmap_name);
> +	trace2_data_string("midx", the_repository, "path", bitmap_name);
> +	fd = git_open(bitmap_name);
>
>  	free(bitmap_name);
>
> @@ -343,12 +345,19 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>  				MAP_PRIVATE, fd, 0);
>  	close(fd);
>
> -	if (load_bitmap_header(bitmap_git) < 0)
> +	if (load_bitmap_header(bitmap_git) < 0) {
> +		trace2_data_string("midx", the_repository, "load bitmap header",
> +				   "failed");

I wonder, why don't we show these errors to the user? Should we
introduce a "ret" variable and set it to (for e.g.)

    ret = error(_("failed to load bitmap header"));

or something?

>  struct bitmap_index *prepare_bitmap_git(struct repository *r)
> diff --git a/repo-settings.c b/repo-settings.c
> index b4fbd16cdc..5bc7a97a6d 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -8,6 +8,7 @@ static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
>  {
>  	if (repo_config_get_bool(r, key, dest))
>  		*dest = def;
> +	trace2_data_string("config", r, key, *dest ? "true" : "false");

I'm not sure we want to dump the whole repository configuration into
trace2 output. Is there a more convenient place to log any important
value(s) _after_ they have been read?

Thanks,
Taylor
