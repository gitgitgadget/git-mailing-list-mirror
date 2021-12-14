Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85397C433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 20:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhLNUpK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 15:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhLNUpI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 15:45:08 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AEFC061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 12:45:07 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b7so8076885edd.6
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 12:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=nvcFiIfK7eFq3ayhKxt3+0SDgLbkislDyMJ12p685Lk=;
        b=N4gQ1i2yL11N9O5zi5kjpdbwq0jY9DHIqXJNI5iHMSYjEJnYWVHBKKi1Ft/mW2F1DP
         k0+FgWyQRIIJ4wBM3fyjECuAheVp7ujSIQKLgKFOBnLPsQcuzpAdmwO0UxKsjorL2tHM
         t58walj78FJTe04YOJBjLGCnkOh6pRaPh6V5R0bI/IpjbWBRtDM6Kc7O7E4nUl1e22eb
         XRTsVhoTvsZOLuRQQmWMVvnFDmNWTgILBDysgtWeHcO/gGIjB9yJielMUYRqN3goJ1mB
         ZEIsa/8zf0yrEX5WmI4sWBAViyY4QGGT7WtRcSCz59LFd6aEqyByI8B/K38dPf+V8M+F
         lgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=nvcFiIfK7eFq3ayhKxt3+0SDgLbkislDyMJ12p685Lk=;
        b=2bmcqD30jMQ0eJY2FySVP58mFiA3XhpaDqGRp79bTnHF6eRBhRF28uRjO7SSn7Oxwp
         a9ZiaqjQiU+BKPUE03wfaGnAbJmj9fwDvGSMOc23fWJYaIgSgmN1G4pQZV9wjT+nDA1Z
         uJ19idXuZ6O6riOeFhxXlFfnwYsE/w8aHzZ35NQw/Rymqj41Tl+nsC+cpatnHjc5fMxh
         zl18Ce/7Efkl8vOpAYg95cmdBEdYlyZ76Cu2+8mvn/y8UwVL7+gwDHQLXqC6aFM4fXz7
         ZijzsbTYcMIKwOVjprhsAeh5eIQC0OCvCfkkXKTjIYd+07XRN1P+a8qN/jkyc1maH7dl
         gD6Q==
X-Gm-Message-State: AOAM530Rl086mkfORI3cp3Y/9akRoVwBoegCy5pCJtikhYHk2LpWJnfG
        J+3r5ERXOLUqBO/2s8tS5IY=
X-Google-Smtp-Source: ABdhPJxx1tXaSjhKf5rDm/a4aMkHwan1iVGmjbOKSNtON5UdQ4pHHYHG6MMqZ+0wiW2cwz55B+yiXw==
X-Received: by 2002:a17:906:d553:: with SMTP id cr19mr8440000ejc.140.1639514706120;
        Tue, 14 Dec 2021 12:45:06 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cs15sm257494ejc.31.2021.12.14.12.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 12:45:05 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mxEfZ-000BDG-7P;
        Tue, 14 Dec 2021 21:45:05 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 1/1] upload-pack.c: increase output buffer size
Date:   Tue, 14 Dec 2021 21:41:27 +0100
References: <YbizfdGq+RSu9BGe@coredump.intra.peff.net>
 <20211214194626.33814-1-jacob@gitlab.com>
 <20211214194626.33814-2-jacob@gitlab.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20211214194626.33814-2-jacob@gitlab.com>
Message-ID: <211214.86h7bac3vy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 14 2021, Jacob Vosmaer wrote:

> When serving a fetch, git upload-pack copies data from a git
> pack-objects stdout pipe to its stdout. This commit increases the size
> of the buffer used for that copying from 8192 to 65515, the maximum
> sideband-64k packet size.
>
> Previously, this buffer was allocated on the stack. Because the new
> buffer size is nearly 64KB, we switch this to a heap allocation.
>
> On GitLab.com we use GitLab's pack-objects cache which does writes of
> 65515 bytes. Because of the default 8KB buffer size, propagating these
> cache writes requires 8 pipe reads and 8 pipe writes from
> git-upload-pack, and 8 pipe reads from Gitaly (our Git RPC service).
> If we increase the size of the buffer to the maximum Git packet size,
> we need only 1 pipe read and 1 pipe write in git-upload-pack, and 1
> pipe read in Gitaly to transfer the same amount of data. In benchmarks
> with a pure fetch and 100% cache hit rate workload we are seeing CPU
> utilization reductions of over 30%.
>
> Signed-off-by: Jacob Vosmaer <jacob@gitlab.com>
> ---
>  upload-pack.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index c78d55bc67..3b90fb69e6 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -194,7 +194,13 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
>  }
>  
>  struct output_state {
> -	char buffer[8193];
> +	/*
> +	 * We do writes no bigger than LARGE_PACKET_DATA_MAX - 1, because with
> +	 * sideband-64k the band designator takes up 1 byte of space. Because
> +	 * relay_pack_data keeps the last byte to itself, we make the buffer 1
> +	 * byte bigger than the intended maximum write size.
> +	 */
> +	char buffer[(LARGE_PACKET_DATA_MAX - 1) + 1];

Since X-1+1 = X shouldn't we just say X ? :)

Maybe this fixup is better, maybe not:
	
	diff --git a/upload-pack.c b/upload-pack.c
	index 3b90fb69e6d..10849110229 100644
	--- a/upload-pack.c
	+++ b/upload-pack.c
	@@ -195,12 +195,12 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
	 
	 struct output_state {
	 	/*
	-	 * We do writes no bigger than LARGE_PACKET_DATA_MAX - 1, because with
	-	 * sideband-64k the band designator takes up 1 byte of space. Because
	-	 * relay_pack_data keeps the last byte to itself, we make the buffer 1
	-	 * byte bigger than the intended maximum write size.
	+	 * We do writes no bigger than LARGE_PACKET_DATA_MAX - 1,
	+	 * because with * sideband-64k the band designator takes up 1
	+	 * byte of space (see relay_pack_data() below). So
	+	 * LARGE_PACKET_DATA_MAX ends up being the right size.
	 	 */
	-	char buffer[(LARGE_PACKET_DATA_MAX - 1) + 1];
	+	char buffer[LARGE_PACKET_DATA_MAX];
	 	int used;
	 	unsigned packfile_uris_started : 1;
	 	unsigned packfile_started : 1;

>  	int used;
>  	unsigned packfile_uris_started : 1;
>  	unsigned packfile_started : 1;
> @@ -269,7 +275,7 @@ static void create_pack_file(struct upload_pack_data *pack_data,
>  			     const struct string_list *uri_protocols)
>  {
>  	struct child_process pack_objects = CHILD_PROCESS_INIT;
> -	struct output_state output_state = { { 0 } };
> +	struct output_state *output_state = xcalloc(1, sizeof(struct output_state));

I don't know when/if we need to worry about 8k v.s. ~65k on the stack,
especially as recv_sideband() has:

	char buf[LARGE_PACKET_MAX + 1];

But maybe our stack is already quite big here, I don't know...

>  	char progress[128];
>  	char abort_msg[] = "aborting due to possible repository "
>  		"corruption on the remote side.";
> @@ -404,7 +410,7 @@ static void create_pack_file(struct upload_pack_data *pack_data,
>  		}
>  		if (0 <= pu && (pfd[pu].revents & (POLLIN|POLLHUP))) {
>  			int result = relay_pack_data(pack_objects.out,
> -						     &output_state,
> +						     output_state,
>  						     pack_data->use_sideband,
>  						     !!uri_protocols);
>  
> @@ -438,11 +444,12 @@ static void create_pack_file(struct upload_pack_data *pack_data,
>  	}
>  
>  	/* flush the data */
> -	if (output_state.used > 0) {
> -		send_client_data(1, output_state.buffer, output_state.used,
> +	if (output_state->used > 0) {
> +		send_client_data(1, output_state->buffer, output_state->used,
>  				 pack_data->use_sideband);
>  		fprintf(stderr, "flushed.\n");
>  	}
> +	free(output_state);
>  	if (pack_data->use_sideband)
>  		packet_flush(1);
>  	return;

But this looks fine either way. And yes, in reply to the question in the
cover letter it's fine to ignore the memory leaks we have when we call
die().
