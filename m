Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EE3C54EED
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 09:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbjA3J7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 04:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbjA3J67 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 04:58:59 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146235FCE
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 01:58:29 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id v13so10353075eda.11
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 01:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RHUXeln7zKUnSq48YgCY8B0cKOKLueGY+E7RBdjSZMA=;
        b=dE2nn+88sjuIGRhiZFv5k6QRgQPWj7p3i4x4cMmPLhqfCyMw8wy7aEMP1q+yM9LXIB
         x+OEMQuEyfbOBNF/r9G3fAQopCVYP7DepGwtUzz7TaM1f+iAha62J6yk5GIgO0wwfmTE
         Bj6ytPRz25G6InxL5KB6xcFEEPFtY+nFowH30bRA6pHDgyYHb/ipd5CfzPdnyEK08e6S
         kLp3DrTztbq/SKk1PcNhBT7HWXFSOy73DRcnYcx939414P1me+WcE4oi6ThG3DAEfQcQ
         LW5kigjKp2YwJqKsiNA5hrNQlPGWoRpZzyGprdDVDqSj+5X6lXaRmfr6TJYXxsi+FDt+
         hElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHUXeln7zKUnSq48YgCY8B0cKOKLueGY+E7RBdjSZMA=;
        b=u0EpDVnNNy5M/fF0mMgWmGu+U0Z5D2Txr/Xe8b+JRqg+hceY3kpgXgZPOY2zKObxlu
         3x0kePRHEB+EHIhgF+roJrGYfKOPRpQf/56CxQDmgndcWrxSNz9bMts5Y5JIRrb5aSed
         BOHyJG/b/KAp3eW+X6BStHWp3+jbmuwryooiBgRNJOVNvqVKdlJ7gcOsIl1ADXaqmFd/
         8G14BVGvG9usjsPao6U7Q0bO24Im62L1l2ueONPal9hxzy2Tdb/06H054VXpdnLrrEiZ
         Ew7DP49SC+lkCDQ2//lMFDYF1EVt8BaWs2r4BUwV+/h3/BwPmH6RxEhAhDInvgK3OhWp
         QWUg==
X-Gm-Message-State: AO0yUKVlUU/uygzabG5ap20NCXEzU9byCksLeLP2rOj4xIDdHgkOIX0J
        d5WMaG4rrlOq029auMlKlbo=
X-Google-Smtp-Source: AK7set8fkOep9nsckRBCb1dl3AkGurj7cynFPyLTO/HyY6QWsBb5hFIwZuQ+NfduQTdit6M6DhzxYA==
X-Received: by 2002:a05:6402:1010:b0:4a0:b64e:3db9 with SMTP id c16-20020a056402101000b004a0b64e3db9mr17353854edu.16.1675072700536;
        Mon, 30 Jan 2023 01:58:20 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id eo14-20020a056402530e00b0049e08f781e3sm6552124edb.3.2023.01.30.01.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 01:58:19 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pMQva-001hbJ-24;
        Mon, 30 Jan 2023 10:58:18 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v15 1/6] fsmonitor: refactor filesystem checks to common
 interface
Date:   Mon, 30 Jan 2023 10:37:58 +0100
References: <pull.1326.v14.git.1664395931.gitgitgadget@gmail.com>
 <pull.1326.v15.git.1664904751.gitgitgadget@gmail.com>
 <ec49a74086dee4545a3bb7b24c8da22e77aef579.1664904751.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <ec49a74086dee4545a3bb7b24c8da22e77aef579.1664904751.git.gitgitgadget@gmail.com>
Message-ID: <230130.86sffss5s5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 04 2022, Eric DeCosta via GitGitGadget wrote:

> From: Eric DeCosta <edecosta@mathworks.com>
>
> Provide a common interface for getting basic filesystem information
> including filesystem type and whether the filesystem is remote.
>
> Refactor existing code for getting basic filesystem info and detecting
> remote file systems to the new interface.
>
> Refactor filesystem checks to leverage new interface. For macOS,
> error-out if the Unix Domain socket (UDS) file is on a remote
> filesystem.
>
> Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
> ---
>  Makefile                                 |   1 +
>  compat/fsmonitor/fsm-path-utils-darwin.c |  43 ++++++
>  compat/fsmonitor/fsm-path-utils-win32.c  | 128 +++++++++++++++++
>  compat/fsmonitor/fsm-settings-darwin.c   |  69 +++------
>  compat/fsmonitor/fsm-settings-win32.c    | 172 +----------------------
>  contrib/buildsystems/CMakeLists.txt      |   2 +
>  fsmonitor-path-utils.h                   |  26 ++++
>  fsmonitor-settings.c                     |  50 +++++++
>  8 files changed, 272 insertions(+), 219 deletions(-)
>  create mode 100644 compat/fsmonitor/fsm-path-utils-darwin.c
>  create mode 100644 compat/fsmonitor/fsm-path-utils-win32.c
>  create mode 100644 fsmonitor-path-utils.h
>
> diff --git a/Makefile b/Makefile
> index cac3452edb9..ffab427ea5b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2044,6 +2044,7 @@ endif
>  ifdef FSMONITOR_OS_SETTINGS
>  	COMPAT_CFLAGS += -DHAVE_FSMONITOR_OS_SETTINGS
>  	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
> +	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
>  endif
>  
>  ifeq ($(TCLTK_PATH),)
> diff --git a/compat/fsmonitor/fsm-path-utils-darwin.c b/compat/fsmonitor/fsm-path-utils-darwin.c
> new file mode 100644
> index 00000000000..d46d7f13538
> --- /dev/null
> +++ b/compat/fsmonitor/fsm-path-utils-darwin.c
> @@ -0,0 +1,43 @@
> +#include "fsmonitor.h"
> +#include "fsmonitor-path-utils.h"
> +#include <sys/param.h>
> +#include <sys/mount.h>
> +
> +int fsmonitor__get_fs_info(const char *path, struct fs_info *fs_info)
> +{
> +	struct statfs fs;

Should have a \n here after variable decls.

> +	if (statfs(path, &fs) == -1) {
> +		int saved_errno = errno;
> +		trace_printf_key(&trace_fsmonitor, "statfs('%s') failed: %s",
> +				 path, strerror(saved_errno));
> +		errno = saved_errno;
> +		return -1;
> +	}
> +
> +	trace_printf_key(&trace_fsmonitor,
> +			 "statfs('%s') [type 0x%08x][flags 0x%08x] '%s'",
> +			 path, fs.f_type, fs.f_flags, fs.f_fstypename);
> +
> +	if (!(fs.f_flags & MNT_LOCAL))
> +		fs_info->is_remote = 1;
> +	else
> +		fs_info->is_remote = 0;

Instead:

	fs_info->is_remote = !(fs.f_flags & MNT_LOCAL)

?

> +int fsmonitor__is_fs_remote(const char *path)
> +{
> +	struct fs_info fs;

Same style issue as above.

> +	if (fsmonitor__get_fs_info(path, &fs))
> +		return -1;
> +
> +	free(fs.typename);

Can we get a "free_fs_info()" function or something instead, this is one
of N codepaths where we now peek into that struct. If we ever add
another field that needs malloc'ing altering all callers will be
painful.


> +	if (xutftowcs_path(wpath, path) < 0) {
> +		return -1;
> +	}

Maybe drop the braces here as this code is being modified-while-moved
anyway?

> +
> +	/*
> +	 * GetDriveTypeW() requires a final slash.  We assume that the
> +	 * worktree pathname points to an actual directory.
> +	 */
> +	wlen = wcslen(wpath);
> +	if (wpath[wlen - 1] != L'\\' && wpath[wlen - 1] != L'/') {
> +		wpath[wlen++] = L'\\';
> +		wpath[wlen] = 0;
> +	}
> +
> +	/*
> +	 * Normalize the path.  If nothing else, this converts forward
> +	 * slashes to backslashes.  This is essential to get GetDriveTypeW()
> +	 * correctly handle some UNC "\\server\share\..." paths.
> +	 */
> +	if (!GetFullPathNameW(wpath, MAX_PATH, wfullpath, NULL)) {
> +		return -1;
> +	}

Here you have added needless braces while moving this, let's not do
that.

> +
> +	driveType = GetDriveTypeW(wfullpath);
> +	trace_printf_key(&trace_fsmonitor,
> +			 "DriveType '%s' L'%ls' (%u)",
> +			 path, wfullpath, driveType);
> +
> +	if (driveType == DRIVE_REMOTE) {
> +		fs_info->is_remote = 1;
> +		if (check_remote_protocol(wfullpath) < 0)
> +			return -1;

Maybe this code should be more careful not to modify the passed-in
struct if we're returning an error?

I.e. do this "return -1" before assigning "is_remote = 1"?

> +	} else {
> +		fs_info->is_remote = 0;
> +	}

Maybe just at the start: "struct fs_info = { 0 }" and skip this "else" ?

> +
> +	trace_printf_key(&trace_fsmonitor,
> +				"'%s' is_remote: %d",
> +				path, fs_info->is_remote);
> +
> +	return 0;
> +}
> +
> +int fsmonitor__is_fs_remote(const char *path)
> +{
> +	struct fs_info fs;
> +	if (fsmonitor__get_fs_info(path, &fs))
> +		return -1;
> +	return fs.is_remote;

I find this and the resulting "switch/case" caller rather un-idiomatic,
i.e. you end up checking 1/0/default.

Why not in your check_remote() instead:

	int is_remote;

	if (fsmonitor__check_fs_remote(r->worktree, &is_remote))
		return FSMONITOR_REASON_ERROR;
	else if (!is_remote)
		return FSMONITOR_REASON_OK;
	...

Where the "..." is the "repo_config_get_bool()" etc. code I suggest
below.

I.e. having an "is" function return non-boolean is somewhat confusing,
better to write to a variable (which the config API you're using does).

> +#ifdef HAVE_FSMONITOR_OS_SETTINGS
> +static enum fsmonitor_reason check_remote(struct repository *r)
> +{
> +	int allow_remote = -1; /* -1 unset, 0 not allowed, 1 allowed */

Let's not init this to -1, and instead...

> +	int is_remote = fsmonitor__is_fs_remote(r->worktree);
> +
> +	switch (is_remote) {
> +		case 0:

The usual coding style is to not indent the "case" further than the
"switch".

> +			return FSMONITOR_REASON_OK;
> +		case 1:
> +			repo_config_get_bool(r, "fsmonitor.allowremote", &allow_remote);
> +			if (allow_remote < 1)

...continued from above: We can scope this variable to this case
statement, as "case 1: { int v; ... }", but furthermore you don't need
to init it to -1 and check this -1 case if you just check the return
value of repo_config_get_bool(), which IMO is also more obvious:

	int v;

	if (!repo...(..., &v))
		return v ? FSMONITOR_REASON_OK : FSMONITOR_REASON_REMOTE:
	else
		return FSMONITOR_REASON_REMOTE;

I.e. you clearly separate the cases where it's un-init'd by checking the
return value.

Maybe better (but would result in more churn later if you ever want to
change the default):

	int v;

	return !repo...(..., &v) && v ? FSMONITOR_REASON_OK :
		FSMONITOR_REASON_REMOTE:
