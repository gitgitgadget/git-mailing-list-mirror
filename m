Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E23EC32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 16:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiIZQqv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 12:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiIZQq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 12:46:28 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84928C450
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 08:36:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r18so14885761eja.11
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 08:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=+ZlgfyoqswvycScZCHtrG8KSZkvF0i6B2urR67fDaMA=;
        b=V8l/VOtw1n4pUIJD1Fn5be1TYwFf7+dPu0JXIUv7Y7rbTNSmcx681DsQWNZnPqNSko
         /zlgBVrOTrs3yx1Rhc9TjnbOTuzKFrEwgMIOko8gY8m+pAxvcZWjjUCCSBL9TaIp1tjJ
         98vAilWPELT0IEA8d1EI9Rd6LNMmAA3yFNyghMfmvw4IBWlHVOeU6UNm1InBsdxfbG72
         XMPdTkcHRozTTWMkcgT7FVG1UuSAjTj0a1Oip5xZ7zpGmWXX8skLtDq+XUQCyt6G5i/Y
         2Ec8cldzi1Scs4/tzweos3+0s9MKRnzPs9IVRJRTR4uFlcaLmGU6jVud/3VMUtoTK7np
         5kkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=+ZlgfyoqswvycScZCHtrG8KSZkvF0i6B2urR67fDaMA=;
        b=1vwitwXyz5dNy3qgvrgzvcCsYj9pCWhgR5rSXTSEaCDMbatOPfq9YS7znQs7Ahn1V9
         2w0JShIqw+VOX+Fn2ZIfS0LjJtqET9YFIWVCykvVALck7ZIODI8HMgiQUTmZjpu026WX
         GwUkZmiPurK8SEy9Q9TDWm1PXHtKALHN3Q35nYbmOQZzNNd+ISbPFEx2ucATI0JfJuCT
         xNdE52my20H87HPxUdcm3EDJ/iqS/PZFni2F0LXQmgS+0dtEg0gfvERww9rFzrg9etQ0
         E5GWsSrtWFviVro9KmsWoKNyT2uzPCjaBWOQDFQhmnzNj8/J1VA9pTu+aO+wwwyJwd4K
         unsg==
X-Gm-Message-State: ACrzQf3x07clJ/ZDo488/vUKhY5r9hKrR1QrWZ588OmDZ84E4FhwYZV/
        b3X9lWU7VgLPpDR6pruSFPs=
X-Google-Smtp-Source: AMsMyM4Yto3i03FQ5RTQiacE5H8SXvPVnIvl1jyl0CYtE7xJ215Q063HXwH+yAaOetRNU2CIR32mIw==
X-Received: by 2002:a17:907:1688:b0:782:5fc0:6477 with SMTP id hc8-20020a170907168800b007825fc06477mr17787641ejc.306.1664206588222;
        Mon, 26 Sep 2022 08:36:28 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709061c8600b00779a605c777sm8448237ejh.192.2022.09.26.08.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 08:36:27 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ocq9i-000Aj6-1Y;
        Mon, 26 Sep 2022 17:36:26 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v12 4/6] fsmonitor: deal with synthetic firmlinks on macOS
Date:   Mon, 26 Sep 2022 17:27:16 +0200
References: <pull.1326.v11.git.1663798722.gitgitgadget@gmail.com>
 <pull.1326.v12.git.1664048782.gitgitgadget@gmail.com>
 <6efdc6ed74ec9224d93a1b88ff8be85d533cb30f.1664048782.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <6efdc6ed74ec9224d93a1b88ff8be85d533cb30f.1664048782.git.gitgitgadget@gmail.com>
Message-ID: <220926.86r0zyywp1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 24 2022, Eric DeCosta via GitGitGadget wrote:

> From: Eric DeCosta <edecosta@mathworks.com>

..one aspect I missed...

> +	state.alias.alias = NULL;
> +	state.alias.points_to = NULL;
> +	if (fsmonitor__get_alias(state.path_worktree_watch.buf, &state.alias)) {
> +		err = error(_("could not get worktree alias"));
> +		goto done;

Okey, it errored and we call error() to say it didn't work, good so far,
but...

> +int fsmonitor__get_alias(const char *path, struct alias_info *info)
> +{
> +	DIR * dir;
> +	int read;
> +	int retval;

...we could just...

> +	struct dirent *de;
> +	struct strbuf alias;
> +	struct strbuf points_to;
> +
> +	retval = 0;

...have initialized that above if we do it unconditionally, but more on
this below...

> +	dir = opendir("/");
> +	if (!dir)
> +		return -1;

Here in the actual implementation, which looking at the end-state we
*only* end up calling from that one caller we could have called
error_errno() to get a better message, but didn't.

I think much better would be to skip that above entirely, or keep it you
want two errors, but then just have the more meaningful error_errno()
here, where we're closer to the error, and can report a better one.

Of course we might sometimes have a good error, and sometimes a bad one,
but...(continued below)

> +
> +	strbuf_init(&alias, 256);
> +	strbuf_init(&points_to, MAXPATHLEN);
> +
> +	while ((de = readdir(dir)) != NULL) {
> +		strbuf_reset(&alias);
> +		strbuf_addch(&alias, '/');
> +		strbuf_add(&alias, de->d_name, strlen(de->d_name));
> +
> +		read = readlink(alias.buf, points_to.buf, MAXPATHLEN);

I think a:

	if (!read)
		BUG("got 0 from readlink?");

Or something would be a good paranoia addition, as you're technically
relying on...

> +		if (read > 0) {
> +			strbuf_setlen(&points_to, read);
> +			if ((strncmp(points_to.buf, path, points_to.len) == 0)
> +				&& path[points_to.len] == '/') {
> +				info->alias = strbuf_detach(&alias, NULL);
> +				info->points_to = strbuf_detach(&points_to, NULL);
> +				trace_printf_key(&trace_fsmonitor,
> +					"Found alias for '%s' : '%s' -> '%s'",
> +					path, info->alias, info->points_to);
> +				retval = 0;
> +				goto done;
> +			}
> +		} else if (errno != EINVAL) { /* Something other than not a link */

...the possibility that we return 0 but a stale errno happens to be set,
I don't think it'll happen in practice and that it always returned -1 if
we get here, but being strict with calling syscalls is generally good.

> +			trace_printf_key(&trace_fsmonitor, "Error %s", strerror(errno));

(continued from above)..here we see the only codepath that sets retval
!= 0,

> +			retval = -1;

Here we could have just called error_errno() instead.

> + * The caller owns the storage that the returned string occupies and
> + * is responsible for releasing it with `free(3)` when done.

nit: we could just put a full stop after "it" and skip the
rest. I.e. trust that the reader knows that allocated memory is freed
with free().

> + */
> +char *fsmonitor__resolve_alias(const char *path,
> +	const struct alias_info *info);
> +
> +

nit: extra whitespace at end of file.
>  #endif

