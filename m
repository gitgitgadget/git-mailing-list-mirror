From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Wed, 13 Apr 2016 20:43:21 +0700
Message-ID: <CACsJy8DE40dMiiqkTb=Pz8uidPk-q1-kuX514s7mO55ChFLXhg@mail.gmail.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com> <1460507589-25525-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.co>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 15:44:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqL5N-0003Kt-Nf
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030852AbcDMNnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 09:43:53 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34037 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934296AbcDMNnw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:43:52 -0400
Received: by mail-lf0-f66.google.com with SMTP id e190so7369633lfe.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GKi3sp/go5BPB6g1qtQRAfL9jiMpOM6IhCNkfJL9PVE=;
        b=gi6xMlxmPVk3mnnqu8SvMZLQdkKvdxeI9Lc0vmCIKniiOVR0CAWP26mLNoE8Tv8FjP
         aoLaf8h2J6Vs4DO0zSQSiNC+u/qaYiy9rAiGcGCJDuEvo6PS1Zztyu8RAUgj7rl8ntT/
         S77b6YrMXAL/WcroHWHJWO0uSO809VxUqGg35nPzcKHZzwl7t9YDTvoLDc3fTQrD+jZ0
         qWLOQ4jpscQeVt++0Ku+fQifzhlHOpz1KK9P9B0hbTUNjXqZA2JQVX0cl4yFjSRRmJsE
         0WtOuHbypvW8ZsEOlJnNnNNNGQYpiIofheCKnBeZ3si56Sbj0/HuVTtv+rrAChRh3yRz
         AboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GKi3sp/go5BPB6g1qtQRAfL9jiMpOM6IhCNkfJL9PVE=;
        b=Clwc4Og4zUMb99N0D5KdPUW5uU4qgmkAd1jj+bqsifiw1PVt0Fe4jCAqSKvvfFjURz
         7yAWR7F0kqotrtfdwillh1q20VPXP9xS4rR0f7oj/og8Zh1Et+HDXuLi7fWt7tDVFUqJ
         JVO/61ez2+Rs5F40ioevuP/u0m0qndpb0seQP7dKZELoSu+BGMi7V5ugph6KZGFZMjWA
         zTUHI/UFcHFIxaRp31yslR9Ob4NQuCjMBD4Sbn1a/nKKpzLwQACwsfx5lhqQwtLfKqUk
         TXZr/cKG8iyGXNy5PuhbmOGdwVrhezTCB1yQfwMhG8IDDuHWD91zf4mCn+h/dSZmFIv3
         SRIw==
X-Gm-Message-State: AOPr4FUPARs+IbGPrJNY9TTvomrYOeF6PKg7MdF1tk+2Y5wW+ZFnprtUaS34Ko1O1yKVger1jilQK/2XrvlZZA==
X-Received: by 10.25.17.67 with SMTP id g64mr4357902lfi.112.1460555030933;
 Wed, 13 Apr 2016 06:43:50 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Wed, 13 Apr 2016 06:43:21 -0700 (PDT)
In-Reply-To: <1460507589-25525-4-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291451>

On Wed, Apr 13, 2016 at 7:32 AM, David Turner <dturner@twopensource.com> wrote:
> +NOTES
> +-----
> +
> +$GIT_DIR/index-helper.path is a symlink

In multiple worktree context, this file will be per-worktree. So we
have one daemon per worktree. I think that's fine.

> to a directory in $TMPDIR
> +containing a Unix domain socket called 's' that the daemon reads
> +commands from.

Oops. I stand corrected, now it's one daemon per repository...
Probably good to hide the socket path in $GIT_DIR though, people may
protect it with dir permission of one of ancestor directories.

> The directory will also contain files named
> +"git-index-<SHA1>".  These are used as backing stores for shared
> +memory.  Normally the daemon will clean up these files when it exits
> +or when they are no longer relevant.  But if it crashes, some objects
> +could remain there and they can be safely deleted with "rm"
> +command.

Alternatively, we could store all these in $GIT_DIR/helper or
something and clean up automatically when index-helper starts. But I
guess at least with TMPDIR we have a chance to put them on tmpfs.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index c07e0c1..8b878fe 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1045,4 +1046,21 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
>  #define getc_unlocked(fh) getc(fh)
>  #endif
>
> +#ifdef __linux__
> +#define UNIX_PATH_MAX 108
> +#elif defined(__APPLE__) || defined(BSD)
> +#define UNIX_PATH_MAX 104
> +#else
> +/*
> + * Quoth POSIX: The size of sun_path has intentionally been left
> + * undefined. This is because different implementations use different
> + * sizes. For example, 4.3 BSD uses a size of 108, and 4.4 BSD uses a
> + * size of 104. Since most implementations originate from BSD
> + * versions, the size is typically in the range 92 to 108.
> + *
> + * Thanks, POSIX!  Super-helpful!  Hope we don't overflow any buffers!
> + */
> +#define UNIX_PATH_MAX 92
> +#endif
> +

This looks like dead code (or at least not used in this patch).

> +static int poke_daemon(struct index_state *istate,
> +                      const struct stat *st, int refresh_cache)
> +{
> +       int fd;
> +       int ret = 0;
> +       const char *socket_path;
> +
> +       /* if this is from index-helper, do not poke itself (recursively) */
> +       if (istate->to_shm)
> +               return 0;
> +
> +       socket_path = index_helper_path("s");
> +       if (!socket_path)
> +               return -1;
> +
> +       fd = unix_stream_connect(socket_path);
> +       if (refresh_cache) {
> +               ret = write_in_full(fd, "refresh", 8) != 8;

Since we've moved to unix socket and had bidirectional communication,
it's probably a good idea to read an "ok" back, giving index-helper
time to prepare the cache. As I recall the last discussion with
Johannes, missing a cache here when the index is around 300MB could
hurt more than wait patiently once and have it ready next time.

> +       } else {
> +               ret = write_in_full(fd, "poke", 5) != 5;
> +       }
> +
> +       close(fd);
> +       return ret;
> +}
-- 
Duy
