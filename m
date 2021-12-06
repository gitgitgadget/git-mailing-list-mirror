Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D741C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 07:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238515AbhLFHqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 02:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238503AbhLFHqh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 02:46:37 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F844C0613F8
        for <git@vger.kernel.org>; Sun,  5 Dec 2021 23:43:09 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id r5so9636468pgi.6
        for <git@vger.kernel.org>; Sun, 05 Dec 2021 23:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=T5CyuMnrgdIt/GrUPfS74ue7lz84p1FSRoCu8ia2pd4=;
        b=Medbeai+6z3cFKgmXqcCGYoF2dun4welnbvJH+snzOWROKFbU/TpmgxVtqSaTUsept
         SNlUt+lDTMNl61RY6MncjjlUKj9YP7ZRHD/gNJxxVRLJJms1t6by/p6VxWiFbVnLUq1N
         wzsQGjOyl9Pp04yjCoZURvMndwwWU6cTFezLeikfEOlhUIptbAkk85S2wxnuWzghzHNa
         AXNv80XR5/0qxcExID9Ne07/u5tnCWvS3MIYO6os/vBsUTYb6ddIIgp2o0RYmUd9DQlg
         CYlV9E0ZGlsV+oaJek2ntORMKBVESBKULS5iatnlekSpkNMt8Xlj49wa9btG+KMifik3
         N7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=T5CyuMnrgdIt/GrUPfS74ue7lz84p1FSRoCu8ia2pd4=;
        b=1mFoz46puJqacmNEoWVxy4ojzsx+FLxkrZeXJq0+1mT2VrW7BUwiO92h+B/bPpJWMR
         rx2zm8r3ynk2PWopv2h0t1ElrVPnuCcgNJ6Zr0i9Z1j2h4/S93Z07+f4RuTP0Vtrc87r
         ZyDM2DXpMp9VX6rbHzCKqp4a7o2wvE5tsOuKx7KSgDmm9JZ+EqS6l0MK1Ju9UAe67DbS
         5PyITwNEeDSz6g8Y63YGVyVxTo65Vr84JjL8T1w4mTHA7R0XYuY1Lj1FFYVUJnDhrKFD
         gtK2Zm5bc6e8RnzTNbMY2kzay6OA+IjX2H99UpZVPm0CP+FuNEBWkmIb9OgBsjIPFggC
         H+Bg==
X-Gm-Message-State: AOAM532WyZXV2Xknj+7DzeTg9aTVX4uOQS2c368iqOkDq43KFcAKgQhZ
        cPHYnUuLVmFaE9lv9kbDeh4=
X-Google-Smtp-Source: ABdhPJyZ0E9qV2MA0RmeoK4s51U3eca2ifJTkXHpYO9NPLYj5qMeo0OAXkEAWs/ed1PLSw8sevyUuw==
X-Received: by 2002:a62:84d4:0:b0:4a7:e068:2521 with SMTP id k203-20020a6284d4000000b004a7e0682521mr35939296pfd.79.1638776588955;
        Sun, 05 Dec 2021 23:43:08 -0800 (PST)
Received: from localhost ([2620:15c:289:200:9206:9546:da97:4e9c])
        by smtp.gmail.com with ESMTPSA id n7sm2666362pgt.6.2021.12.05.23.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 23:43:08 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Neeraj Singh <nksingh85@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 1/2] tmp-objdir: new API for creating temporary
 writable databases
References: <pull.1091.git.1638585658.gitgitgadget@gmail.com>
        <pull.1091.v2.git.1638750965.gitgitgadget@gmail.com>
        <36c00613d9a6ad4fc768e15b9ec23f9af520338a.1638750965.git.gitgitgadget@gmail.com>
Date:   Sun, 05 Dec 2021 23:43:07 -0800
In-Reply-To: <36c00613d9a6ad4fc768e15b9ec23f9af520338a.1638750965.git.gitgitgadget@gmail.com>
        (Neeraj Singh via GitGitGadget's message of "Mon, 06 Dec 2021 00:36:04
        +0000")
Message-ID: <xmqq4k7mi3g4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/prune.c b/builtin/prune.c
> index 485c9a3c56f..c2bcdc07db4 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -26,10 +26,22 @@ static int prune_tmp_file(const char *fullpath)
>  		return error("Could not stat '%s'", fullpath);
>  	if (st.st_mtime > expire)
>  		return 0;
> -	if (show_only || verbose)
> -		printf("Removing stale temporary file %s\n", fullpath);
> -	if (!show_only)
> -		unlink_or_warn(fullpath);
> +	if (S_ISDIR(st.st_mode)) {

Because the updated tmp_objdir_create() always uses "tmp_objdir-" as
the common prefix (instead of "incoming-" that we used to use,
prune_cruft() will call this function not just for temporary files
for loose objects, but also for directories.  So a new code to do an
equivalent of "rm -fr" is added here.  OK.

> +		if (show_only || verbose)
> +			printf("Removing stale temporary directory %s\n", fullpath);
> +		if (!show_only) {
> +			struct strbuf remove_dir_buf = STRBUF_INIT;
> +
> +			strbuf_addstr(&remove_dir_buf, fullpath);
> +			remove_dir_recursively(&remove_dir_buf, 0);
> +			strbuf_release(&remove_dir_buf);
> +		}
> +	} else {
> +		if (show_only || verbose)
> +			printf("Removing stale temporary file %s\n", fullpath);
> +		if (!show_only)
> +			unlink_or_warn(fullpath);
> +	}
>  	return 0;
>  }
>  
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 49b846d9605..8815e24cde5 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -2213,7 +2213,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
>  		strvec_push(&child.args, alt_shallow_file);
>  	}
>  
> -	tmp_objdir = tmp_objdir_create();
> +	tmp_objdir = tmp_objdir_create("incoming");
>  	if (!tmp_objdir) {
>  		if (err_fd > 0)
>  			close(err_fd);
> diff --git a/environment.c b/environment.c
> index 9da7f3c1a19..342400fcaad 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -17,6 +17,7 @@
>  #include "commit.h"
>  #include "strvec.h"
>  #include "object-store.h"
> +#include "tmp-objdir.h"
>  #include "chdir-notify.h"
>  #include "shallow.h"
>  
> @@ -331,10 +332,14 @@ static void update_relative_gitdir(const char *name,
>  				   void *data)
>  {
>  	char *path = reparent_relative_path(old_cwd, new_cwd, get_git_dir());
> +	struct tmp_objdir *tmp_objdir = tmp_objdir_unapply_primary_odb();
>  	trace_printf_key(&trace_setup_key,
>  			 "setup: move $GIT_DIR to '%s'",
>  			 path);
> +
>  	set_git_dir_1(path);

If a blank line needs to be added, have it between the variable
declarations and the first statement (i.e. before the above call to
"trace_printf_key()").

> +	if (tmp_objdir)
> +		tmp_objdir_reapply_primary_odb(tmp_objdir, old_cwd, new_cwd);
>  	free(path);
>  }

This is called during set_git_dir(), which happens fairly early in
the set-up sequence.  I wonder if there is a real use case that
creates a tmp-objdir that early in the process to require this
unapply-reapply sequence.

> @@ -1809,8 +1846,11 @@ int hash_object_file(const struct git_hash_algo *algo, const void *buf,
>  /* Finalize a file on disk, and close it. */
>  static void close_loose_object(int fd)
>  {
> -	if (fsync_object_files)
> -		fsync_or_die(fd, "loose object file");
> +	if (!the_repository->objects->odb->will_destroy) {
> +		if (fsync_object_files)
> +			fsync_or_die(fd, "loose object file");

OK, so we omit fsync because these newly created loose objects may
not survive and instead get discarded.  Presumably when we migrate
them to the real object store, we'll make sure they hit the disk
platter in some other way?

	... goes and cheats by reading ahead ...

Ahh, ok, new objects created in a temporary object store that is
marked with the will_destroy bit is not allowed to migrate to the
real object store, so there is no point to fsync them.

set_temporary_primary_odb() and tmp_objdir_replace_primary_odb() can
mark the temporary one to be throw-away, but unfortunately there is
no caller in this step, so it is a bit hard to see when a throw-away
object store is useful.  I guess remerge-diff wants to do tentative
merges that create new objects in a throw-away object directory,
because it is logically a read-only operation.

> diff --git a/tmp-objdir.c b/tmp-objdir.c
> index b8d880e3626..3d38eeab66b 100644
> --- a/tmp-objdir.c
> +++ b/tmp-objdir.c
> @@ -1,5 +1,6 @@
>  #include "cache.h"
>  #include "tmp-objdir.h"
> +#include "chdir-notify.h"
>  #include "dir.h"
>  #include "sigchain.h"
>  #include "string-list.h"
> @@ -11,6 +12,8 @@
>  struct tmp_objdir {
>  	struct strbuf path;
>  	struct strvec env;
> +	struct object_directory *prev_odb;
> +	int will_destroy;

The other one was a one-bit unsigned bitfield, but this is a full
integer.  I somehow think that the other one can and should be a
full integer, too---it's not like there are tons of bits need to be
stored in the structure or we will have tons of instances of the
structure that storing many bits compactly matters.

Thanks.
