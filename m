Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B19C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 11:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiLLLIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 06:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiLLLHW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 06:07:22 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B03211A3F
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 02:56:08 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id x22so26898879ejs.11
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 02:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SkX/djvfRnHwibylPVHqmjBm/B8SWKXGkkpdpWLEDV8=;
        b=kv5LcFhUa5sS50vIBf6rkysaU2gInAGQu6Rna8/wghJ30gGjq9t8HPtRSddPrdQbBJ
         p7uMVE5xFubVIe3f0K6SrtzVtB6i5rzbzGSwjpI9bMs2WdZvBYakJl4LbvQXJ//ejr+q
         SsGJQcwY5JGIf/af5YPmfHXnG+0eFsY4tZJJjW8hL5QzUkgikKPruw4VW45Qfz/4TwiV
         AHgE7RGOItAEUcjTadmNN8+u67K6+WZoZnjIYr6Rp93C1QXju+Rh6kBXPbYXkZRAZaN3
         Cy5l0S0wqm3zWp3ZcPm87QbvwQv0Zz59qazxU9m5l5xBTf1rQ8JFr8M2iMQSqX2l8AOG
         yTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkX/djvfRnHwibylPVHqmjBm/B8SWKXGkkpdpWLEDV8=;
        b=yV5DjMIGRlw6Xa9mFZOxXiR7ovLweWBcYs9TePupkWc1s6jVdnUr5FImQXqMNf3iFL
         pP/4/X72pFrQfW7CwX373ek9VUgHssdeJm5cmKK22UR5eZN1HMPTb/HbZWPLLaSRO3oX
         wxEEu3f3crszkL5Gyo7+ZmwjmOYv6gs5hQM1E9lBV3eumxZ8shk96tcG+7BOAz/K/E7c
         XlEt0EwhzvqZsvx6K749J6KZNNopuJMbtKS55K5g45ZJ7RSMg3xxs51Hwmbuyn0mh8Mm
         3n/pv0ds5aQd5gZ1xgUqc2rT/oca9n5xuRHo3U8uNIe4vwDpOX2L1E+Y8E2IhqHp+Ir9
         DToQ==
X-Gm-Message-State: ANoB5pnuSXcfsSs14REEnk+MjV5Mv7GbaquZZMuu3II53zNi2XRMf+fu
        Lrbwn65esUGF3WDmPiTBIlc=
X-Google-Smtp-Source: AA0mqf53gmUN0SPAm565fDV3ZPTsRNHYF50AYXSaYVvFV784xeD7cCfrbFAKOxUpxsW1D11wfaaBxA==
X-Received: by 2002:a17:907:988f:b0:7c0:fd1a:79ee with SMTP id ja15-20020a170907988f00b007c0fd1a79eemr15951257ejc.63.1670842566393;
        Mon, 12 Dec 2022 02:56:06 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id kr12-20020a1709079a0c00b007ae10525550sm3107467ejc.47.2022.12.12.02.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 02:56:05 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p4gTd-005IDt-0u;
        Mon, 12 Dec 2022 11:56:05 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v4 3/6] fsmonitor: implement filesystem change listener
 for Linux
Date:   Mon, 12 Dec 2022 11:42:26 +0100
References: <pull.1352.v3.git.git.1668641019.gitgitgadget@gmail.com>
 <pull.1352.v4.git.git.1669230044.gitgitgadget@gmail.com>
 <80282efef5779728022a317388da6790e5db44e2.1669230044.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <80282efef5779728022a317388da6790e5db44e2.1669230044.git.gitgitgadget@gmail.com>
Message-ID: <221212.86h6y06gca.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 23 2022, Eric DeCosta via GitGitGadget wrote:

> From: Eric DeCosta <edecosta@mathworks.com>
> [...]
> +}
> +
> +/*
> + * Remove the inotify watch, the watch descriptor to path mapping
> + * and the reverse mapping.
> + */
> +static void remove_watch(struct watch_entry *w,
> +	struct fsm_listen_data *data)
> +{
> +	struct watch_entry k1, k2, *w1, *w2;
> +
> +	/* remove watch, ignore error if kernel already did it */
> +	if (inotify_rm_watch(data->fd_inotify, w->wd) && errno != EINVAL)
> +		error_errno("inotify_rm_watch() failed");

If we error_errno(), shouldn't this function have a return value?

> +
> +	hashmap_entry_init(&k1.ent, memhash(&w->wd, sizeof(int)));
> +	w1 = hashmap_remove_entry(&data->watches, &k1, ent, NULL);
> +	if (!w1)
> +		BUG("Double remove of watch for '%s'", w->dir);
> +
> +	if (w1->cookie)
> +		BUG("Removing watch for '%s' which has a pending rename", w1->dir);
> +
> +	hashmap_entry_init(&k2.ent, memhash(w->dir, strlen(w->dir)));
> +	w2 = hashmap_remove_entry(&data->revwatches, &k2, ent, NULL);
> +	if (!w2)
> +		BUG("Double remove of reverse watch for '%s'", w->dir);

For the BUG() additions: Start with lower-case in messages, see
CodingGuidelines. I.e. "double remove of ..." etc. Ditto below..

> [...]
> +/*
> + * Handle directory renames
> + *
> + * Once a IN_MOVED_TO event is received, lookup the rename tracking information
> + * via the event cookie and use this information to update the watch.
> + */
> +static void rename_dir(uint32_t cookie, const char *path,
> +	struct fsm_listen_data *data)
> +{
> +	struct rename_entry rek, *re;
> +	struct watch_entry k, *w;
> +
> +	/* lookup a pending rename to match */
> +	rek.cookie = cookie;
> +	hashmap_entry_init(&rek.ent, memhash(&rek.cookie, sizeof(uint32_t)));
> +	re = hashmap_get_entry(&data->renames, &rek, ent, NULL);
> +	if (re) {
> +		k.dir = re->dir;
> +		hashmap_entry_init(&k.ent, memhash(k.dir, strlen(k.dir)));
> +		w = hashmap_get_entry(&data->revwatches, &k, ent, NULL);
> +		if (w) {
> +			w->cookie = 0; /* rename handled */
> +			remove_watch(w, data);
> +			add_watch(path, data);

Elsewhere you check the add_watch() return value, but not here?

> +		} else {
> +			BUG("No matching watch");
> +		}
> +	} else {
> +		BUG("No matching cookie");
> +	}
> +}
> +
> +/*
> + * Recursively add watches to every directory under path
> + */
> +static int register_inotify(const char *path,
> +	struct fsmonitor_daemon_state *state,
> +	struct fsmonitor_batch *batch)
> +{
> +	DIR *dir;
> +	const char *rel;
> +	struct strbuf current = STRBUF_INIT;
> +	struct dirent *de;
> +	struct stat fs;
> +	int ret = -1;
> +
> +	dir = opendir(path);
> +	if (!dir)
> +		return error_errno("opendir('%s') failed", path);
> +
> +	while ((de = readdir_skip_dot_and_dotdot(dir)) != NULL) {

ditto drop the "!= NULL"

> +	struct strbuf msg = STRBUF_INIT;
> +
> +	if (mask & IN_ACCESS)
> +		strbuf_addstr(&msg, "IN_ACCESS|");
> +	if (mask & IN_MODIFY)
> +		strbuf_addstr(&msg, "IN_MODIFY|");
> +	if (mask & IN_ATTRIB)
> +		strbuf_addstr(&msg, "IN_ATTRIB|");
> +	if (mask & IN_CLOSE_WRITE)
> +		strbuf_addstr(&msg, "IN_CLOSE_WRITE|");
> +	if (mask & IN_CLOSE_NOWRITE)
> +		strbuf_addstr(&msg, "IN_CLOSE_NOWRITE|");
> +	if (mask & IN_OPEN)
> +		strbuf_addstr(&msg, "IN_OPEN|");
> +	if (mask & IN_MOVED_FROM)
> +		strbuf_addstr(&msg, "IN_MOVED_FROM|");
> +	if (mask & IN_MOVED_TO)
> +		strbuf_addstr(&msg, "IN_MOVED_TO|");
> +	if (mask & IN_CREATE)
> +		strbuf_addstr(&msg, "IN_CREATE|");
> +	if (mask & IN_DELETE)
> +		strbuf_addstr(&msg, "IN_DELETE|");
> +	if (mask & IN_DELETE_SELF)
> +		strbuf_addstr(&msg, "IN_DELETE_SELF|");
> +	if (mask & IN_MOVE_SELF)
> +		strbuf_addstr(&msg, "IN_MOVE_SELF|");
> +	if (mask & IN_UNMOUNT)
> +		strbuf_addstr(&msg, "IN_UNMOUNT|");
> +	if (mask & IN_Q_OVERFLOW)
> +		strbuf_addstr(&msg, "IN_Q_OVERFLOW|");
> +	if (mask & IN_IGNORED)
> +		strbuf_addstr(&msg, "IN_IGNORED|");
> +	if (mask & IN_ISDIR)
> +		strbuf_addstr(&msg, "IN_ISDIR|");

Shouldn't the very last addition to mask omit the "|"?

I think it would be worth just making this a NULL-delimited "int, const char *" array like:

	{
		{ IN_ACCESS, "IN_ACCESS" },
		...
		NULL,
	};

Then looping over it, or maybe not...

> +	trace_printf_key(&trace_fsmonitor, "inotify_event: '%s', mask=%#8.8x %s",
> +				path, mask, msg.buf);
> +
> +	strbuf_release(&msg);
> +}
> +
> +int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
> +{
> +	int fd;
> +	int ret = 0;
> +	struct fsm_listen_data *data;
> +
> +	CALLOC_ARRAY(data, 1);
> +	state->listen_data = data;
> +	state->listen_error_code = -1;
> +	data->shutdown = SHUTDOWN_ERROR;
> +
> +	fd = inotify_init1(O_NONBLOCK);
> +	if (fd < 0)
> +		return error_errno("inotify_init1() failed");

Here you leak the "data" you just allocated on error.

> +
> +	data->fd_inotify = fd;
> +
> +	hashmap_init(&data->watches, watch_entry_cmp, NULL, 0);
> +	hashmap_init(&data->renames, rename_entry_cmp, NULL, 0);
> +	hashmap_init(&data->revwatches, revwatches_entry_cmp, NULL, 0);
> +
> +	if (add_watch(state->path_worktree_watch.buf, data))

I.e. we should only avoid free()-ing it if we can successfully hand it
over to add_watch(), shouldn't we?n

> +		ret = -1;
> +	else if (register_inotify(state->path_worktree_watch.buf, state, NULL))
> +		ret = -1;

We add {}'s to all if/else if branches if one needs it, see CodingGuidelines.
> +	else if (state->nr_paths_watching > 1) {
> +		if (add_watch(state->path_gitdir_watch.buf, data))
> +			ret = -1;
> +		else if (register_inotify(state->path_gitdir_watch.buf, state, NULL))
> +			ret = -1;

Can't this be:

	else if (state->nr_paths_watching > 1 &&
		 (add_watch(...) || register_inotify(...)))
		ret = -1;

> +	switch (fsmonitor_classify_path_absolute(state, path)) {
> +		case IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX:

Don't indent the "case" label here more than the "switch", see
CodingGuidelines.


> +static void handle_events(struct fsmonitor_daemon_state *state)
> +{
> +	 /* See https://man7.org/linux/man-pages/man7/inotify.7.html */

Extra " " here after the "\t".

> +	char buf[4096]
> +		__attribute__ ((aligned(__alignof__(struct inotify_event))));
> +
> +	struct hashmap watches = state->listen_data->watches;
> +	struct fsmonitor_batch *batch = NULL;
> +	struct string_list cookie_list = STRING_LIST_INIT_DUP;
> +	struct watch_entry k, *w;
> +	struct strbuf path;
> +	const struct inotify_event *event;
> +	int fd = state->listen_data->fd_inotify;
> +	ssize_t len;
> +	char *ptr, *p;
> +
> +	strbuf_init(&path, PATH_MAX);

Just use "struct strbuf path = STRBUF_INIT" instead? I.e...
> +
> +	for(;;) {
> +		len = read(fd, buf, sizeof(buf));
> +		if (len == -1 && errno != EAGAIN) {
> +			error_errno(_("reading inotify message stream failed"));
> +			state->listen_data->shutdown = SHUTDOWN_ERROR;
> +			goto done;
> +		}
> +
> +		/* nothing to read */
> +		if (len <= 0)
> +			goto done;
> +
> +		/* Loop over all events in the buffer. */
> +		for (ptr = buf; ptr < buf + len;
> +			 ptr += sizeof(struct inotify_event) + event->len) {
> +
> +			event = (const struct inotify_event *) ptr;
> +
> +			if (em_ignore(event->mask))
> +				continue;
> +
> +			/* File system was unmounted or event queue overflowed */
> +			if (em_force_shutdown(event->mask)) {
> +				if (trace_pass_fl(&trace_fsmonitor))
> +					log_mask_set("Forcing shutdown", event->mask);
> +				state->listen_data->shutdown = SHUTDOWN_FORCE;
> +				goto done;
> +			}
> +
> +			hashmap_entry_init(&k.ent, memhash(&event->wd, sizeof(int)));
> +			k.wd = event->wd;
> +
> +			w = hashmap_get_entry(&watches, &k, ent, NULL);
> +			if (!w) /* should never happen */
> +				BUG("No watch for '%s'", event->name);
> +
> +			/* directory watch was removed */
> +			if (em_remove_watch(event->mask)) {
> +				remove_watch(w, state->listen_data);
> +				continue;
> +			}
> +
> +			strbuf_reset(&path);
> +			strbuf_add(&path, w->dir, strlen(w->dir));
> +			strbuf_addch(&path, '/');
> +			strbuf_addstr(&path, event->name);

... we may not even get to this, so we may pointlessly pre-grow it, if
we're considering the micro-optimization.

But if we do need it it'll quickly get up to size in the loop, which is
probably smaller than PATH_MAX, and paths can exceed PATH_MAX....

> +	for(;;) {
> +		switch (state->listen_data->shutdown) {
> +			case SHUTDOWN_CONTINUE:
> +				poll_num = poll(fds, 1, 1);
> +				if (poll_num == -1) {
> +					if (errno == EINTR)
> +						continue;
> +					error_errno(_("polling inotify message stream failed"));
> +					state->listen_data->shutdown = SHUTDOWN_ERROR;
> +					continue;
> +				}
> +
> +				if ((time(NULL) - checked) >= interval) {
> +					checked = time(NULL);

As this is linux-specific code, shouldn't we use the linux-specific API
to get the guaranteed atomically growing time here, arther than time()?

Maybe not, but I wonder if this has funny side-effects with ntpd
adjusting the time concurrently...
