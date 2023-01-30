Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71B2C54EAA
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 10:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbjA3K0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 05:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236435AbjA3K0f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 05:26:35 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D832ED6E
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 02:26:31 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ml19so6743846ejb.0
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 02:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RuNL86yvqv/SGvrQCy4SPhgp+vSXWLOGlrMmWITA/Hk=;
        b=KALF1mxJwaxrmeVHvUzcBgbmOlYO+rTXnCzvdRkZkdmrpEodEhWi9YXyuWIBBeh7/S
         01JgPxDyDnwET5ZrQtcwCbfd8DF6DAkn7MXL3V0NdEednZfe5wYeZVbp1y4feOgeBeV9
         IwXqhbpy4hNkaa9L+CVZI55p/KBTvtj8+fBPdI/wUTf2MAw7GTeU5zhgJFX4c7jhF5dJ
         yf+gdGxk1lNIKCpQYn6/HJLGXZM8/kfNOVu9bCjGMq6tSZmT6kepVxSFXj+TWqaPv4tu
         JRsTsMRNtfkH5ttR1AQ3/CMXicsCBhZnWbnmHUasnDVR101O2XjLo7I1yI05PTe5a9FP
         n1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuNL86yvqv/SGvrQCy4SPhgp+vSXWLOGlrMmWITA/Hk=;
        b=IFKtUwt0QFlWuUvHWkX3/py1YY2/9WVwQ0bFvH5P8AIGGQLpdNsCG4MpuhunF7JSV2
         Vdr92GQWIirhTIwxly87camN/nHbmvK99aWOd1cScpLZa/g/bnwu43pJi+DLiW/yrCZD
         ppIRTtl0IDdIht1/mqHTWouY+sBCOq5W2hcItYB0ZS6msc1pn0EosTpXfnevDSFbNuJS
         fOKsUhBW9szXRzWjG6KBM49o8vKbFr5Z+A/GXH+mGNknFK6U3+FuBYr01DWWAwt/Ga7l
         yL6uIjqxuO9FuaMDJ5twETo24GKZRhwoy0RD+zxG6CqiYIf4ni4NhoOYTo+MYnsoxT8y
         8wnQ==
X-Gm-Message-State: AFqh2kpC8mCB8PXDuCFLIK6Ycu7KY+E/W9jEu7Rl4HQ5JT6ihS5T439c
        8KL+e3p4pHFzmxQp+7yZyAg=
X-Google-Smtp-Source: AMrXdXtu3UHznhmxkTXG0k5FUyrAPQ9tDsZVky1ON7Bx5y0taBoSlHyvPWiGO0HsjAi+MJlk31Ngdw==
X-Received: by 2002:a17:907:874f:b0:870:7769:a907 with SMTP id qo15-20020a170907874f00b008707769a907mr57658544ejc.9.1675074389530;
        Mon, 30 Jan 2023 02:26:29 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id p23-20020a17090653d700b007ad69e9d34dsm6668342ejo.54.2023.01.30.02.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 02:26:28 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pMRMp-001iZo-1B;
        Mon, 30 Jan 2023 11:26:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v15 4/6] fsmonitor: deal with synthetic firmlinks on macOS
Date:   Mon, 30 Jan 2023 11:08:06 +0100
References: <pull.1326.v14.git.1664395931.gitgitgadget@gmail.com>
 <pull.1326.v15.git.1664904751.gitgitgadget@gmail.com>
 <863063aefeeecfd23bb50eb111fcfbf5879a8ee3.1664904752.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <863063aefeeecfd23bb50eb111fcfbf5879a8ee3.1664904752.git.gitgitgadget@gmail.com>
Message-ID: <230130.86fsbss4h8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 04 2022, Eric DeCosta via GitGitGadget wrote:

> From: Eric DeCosta <edecosta@mathworks.com>

> +	struct strbuf alias;

Rather than init-ing here...
> +	struct strbuf points_to = STRBUF_INIT;
> +
> +	dir = opendir(root);
> +	if (!dir)
> +		return error_errno(_("opendir('%s') failed"), root);
> +
> +	strbuf_init(&alias, 256);

...we pre-grow here...

> +	while ((de = readdir(dir)) != NULL) {

...but as shown here, we may not even use this at all, but even then is
this micro-optimization worth it? If it is a reader would be helped with
an explanation of what the 256 is, is this meant to be some OSX-specific
PATH_MAX, but hardcoded?

> +		strbuf_reset(&alias);
> +		strbuf_addf(&alias, "%s%s", root, de->d_name);
> +
> +		if (lstat(alias.buf, &st) < 0) {
> +			error_errno(_("lstat('%s') failed"), alias.buf);
> +			goto done;
> +		}
> +
> +		if (!S_ISLNK(st.st_mode))
> +			continue;
> +
> +		if (strbuf_readlink(&points_to, alias.buf, st.st_size) < 0) {
> +			error_errno(_("strbuf_readlink('%s') failed"), alias.buf);
> +			goto done;
> +		}
> +

Maybe this code would be simpler if you split it into a trivial static
function, so you could pass in the "alias" and "points_to", and just do
"return error...(...)" here and in the other places.

> +		if (!strncmp(points_to.buf, path, points_to.len) &&
> +			(path[points_to.len] == '/')) {
> +			strbuf_addbuf(&info->alias, &alias);
> +			strbuf_addbuf(&info->points_to, &points_to);

Earlier you use strbuf_addf() for a "append two strings", maybe we could
save ourselves a line and do the same here...

> +			trace_printf_key(&trace_fsmonitor,
> +				"Found alias for '%s' : '%s' -> '%s'",
> +				path, info->alias.buf, info->points_to.buf);

...except we're only doing this to emit this, and then we'll free() it?
Can't we just use %s%s here instead of %s, and e.g. pass
"info->alias.buf, alias" instead of the now-appende-to
"info->alias.buf"?

> +char *fsmonitor__resolve_alias(const char *path,
> +	const struct alias_info *info)

I commented on this in a few other places, and I'll stop noting these
now, but you're mis-indenting function decls consistently, also in a *.h
change later in this commit.

Please look through those for this series.

> +{
> +	if (!info->alias.len)
> +		return NULL;

Maybe "check if we have a zero-length string" should belong in the
caller, as "resolve it as an alias" for "\0" is nonsense?

> +
> +	if ((!strncmp(info->alias.buf, path, info->alias.len))
> +		&& path[info->alias.len] == '/') {
> +		struct strbuf tmp = STRBUF_INIT;
> +		const char *remainder = path + info->alias.len;
> +
> +		strbuf_addbuf(&tmp, &info->points_to);
> +		strbuf_add(&tmp, remainder, strlen(remainder));

There's no point in strbuf_add() if you have to dynamically use strlen()
over just using strbuf_addstr() (which inline resolves to the same),
let's just use that.

Or just a single strbuf_addf()...

> +		return strbuf_detach(&tmp, NULL);

...Or actually, these last 3 lines can be replaced by a mere:

	return xstrfmt("%s%s", info->points_to.buf, remainder);

Please just use that. It's not exactly the same due to the pre-sizing
with "addbuf", but again (I commented on a similar case in an earlier
commit), is such micro-optimization worth it here over brevity?

> +/*
> + * No-op for now.
> + */

Please just drop this comment, it doesn't add any information. It would
be useful to say why we're seemingly faking "no aliase on win32", or to
say that it does have them, but implementing them is a "TODO".

But we can see it's a "no-op for now" from the code....

> +int fsmonitor__get_alias(const char *path, struct alias_info *info)
> +{
> +	return 0;
> +}
> +
> +/*
> + * No-op for now.
> + */

...ditto.

> +/*
> + * Get the alias in given path, if any.
> + *
> + * Sets alias to the first alias that matches any part of the path.
> + *
> + * If an alias is found, info.alias and info.points_to are set to the
> + * found mapping.
> + *
> + * Returns -1 on error, 0 otherwise.
> + *
> + * The caller owns the storage that is occupied by info.alias and
> + * info.points_to and is responsible for releasing it.
> + */
> +int fsmonitor__get_alias(const char *path, struct alias_info *info);

I have not looked carefully at this interface, but instead of all of
this explanation & the caller needing to carefully reason about what
parts of this struct it can and can't peek into couldn't we just make it
take two "char **" arguments, one for "alias" and another for
"points_to".

It would then be obvious what the semantics are, and who owns the
memory.

But maybe retaining the strbuf-ness is important (but even then, we
could pass a "struct strbuf *" to populate.
> +
> +/*
> + * Resolve the path against the given alias.
> + *
> + * Returns the resolved path if there is one, NULL otherwise.
> + *
> + * The caller owns the storage that the returned string occupies and
> + * is responsible for releasing it.
> + */
> +char *fsmonitor__resolve_alias(const char *path,
> +	const struct alias_info *info);
> +

Here we don't say anything about the ownership & freeing of "info", does
the same apply? But the API design comment above also applies.

