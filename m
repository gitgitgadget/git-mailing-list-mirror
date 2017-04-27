Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 954EB207EB
	for <e@80x24.org>; Thu, 27 Apr 2017 03:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934060AbdD0DWD (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 23:22:03 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35031 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbdD0DWB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 23:22:01 -0400
Received: by mail-pf0-f194.google.com with SMTP id a188so5239356pfa.2
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 20:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UfxfIkCkgxdFTA2qvsC7/RyZ27eWDzk4gQQetYXDLWc=;
        b=spx0pjKkGFgOBMwcRgaonDslYagYgKJOfzAuke10bNGQi6zFuM8ebijmiVvk/hwws/
         ZB4FZUNcgNtk0sLOVGN0biAhdyrMDSH6upg1GyVKUdejUECuG3uxccDHhmf9Z4tTeeWf
         22F1yKEWEfg9wQttbd2KdIafCeiFj8XQH8HpfJ5jqGinNX5TKspQbwGuop4g/R9eeKkA
         vhlTaYncaBDiSibf37fodRDvX4trCUhCf+FcpXPfjmcDjIi0QOGAhjf9T7mGfebQwdkX
         k/px4U0EbbD30I/ysBB3S8mUJGsFt8Cz8tgeIZMiipK5n++qlnM1YxuzcwWPOJ/qjCXs
         AEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UfxfIkCkgxdFTA2qvsC7/RyZ27eWDzk4gQQetYXDLWc=;
        b=YSrPn3dE6sFlVO94krnJwnv/SPWNKiiTy0jmG+dUZNYWmkMYqpADfBW7wfmc/JiiHO
         DmIy4ONVhO88c44Aitu7lGYy6028Ri6+du0wrSxuE78PfUhrVOZzupihut5EMnEt+lZp
         HkPj0LUpQi6/U9hcLCv5jBSunQ7pFpz+zGRXGKfaJtBvWxaPIhwJkNAKoZylQE+k9F5g
         5dkFCeQYJjJHoXaqG9gB6/rgHzOBAnHMzqhiiWZCnIVnajgJ/KvcbGTSZpViMNEVFxVS
         GRwwh2XR9CFnfSX4S8RVrnRCMQbiPPc0bVYjVKQVq2jbISDug/N/aq4bDeQjYP1zgnoF
         OXeQ==
X-Gm-Message-State: AN3rC/6d9z7TxL6kKlZiZttOFdrggjBoDQg3ZA001oWBmPpPxJw4EgUp
        Mi+N8nkEafpQUQ==
X-Received: by 10.98.212.68 with SMTP id u4mr3322750pfl.73.1493263320957;
        Wed, 26 Apr 2017 20:22:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d550:ca2:cfe6:6d97])
        by smtp.gmail.com with ESMTPSA id d187sm1090199pfd.47.2017.04.26.20.22.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 20:22:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] read-cache: close index.lock in do_write_index
References: <e1b4f9c377ceee296112fa07bd06492a1de1be67.1493237111.git.johannes.schindelin@gmx.de>
Date:   Wed, 26 Apr 2017 20:21:59 -0700
In-Reply-To: <e1b4f9c377ceee296112fa07bd06492a1de1be67.1493237111.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 26 Apr 2017 22:05:23 +0200
        (CEST)")
Message-ID: <xmqq1ssepmaw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Teach do_write_index() to close the index.lock file
> before getting the mtime and updating the istate.timestamp
> fields.
>
> On Windows, a file's mtime is not updated until the file is
> closed.  On Linux, the mtime is set after the last flush.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/git/releases/tag/do-write-index-mtime-v1
> Fetch-It-Via: git fetch https://github.com/dscho/git do-write-index-mtime-v1
>
>  read-cache.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 008b335844c..b0276fd5510 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2051,9 +2051,10 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
>  		rollback_lock_file(lockfile);
>  }
>  
> -static int do_write_index(struct index_state *istate, int newfd,
> +static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>  			  int strip_extensions)
>  {
> +	int newfd = tempfile->fd;
>  	git_SHA_CTX c;
>  	struct cache_header hdr;
>  	int i, err, removed, extended, hdr_version;
> @@ -2162,7 +2163,11 @@ static int do_write_index(struct index_state *istate, int newfd,
>  			return -1;
>  	}
>  
> -	if (ce_flush(&c, newfd, istate->sha1) || fstat(newfd, &st))
> +	if (ce_flush(&c, newfd, istate->sha1))
> +		return -1;
> +	if (close_tempfile(tempfile))
> +		return error(_("could not close '%s'"), tempfile->filename.buf);
> +	if (lstat(tempfile->filename.buf, &st))
>  		return -1;


stat/lstat with path may be slower than fstat on an open file
descriptor, and I think that is the reason why we do it this way,
but the performance difference would probably be unmeasurable and
does not matter in practice.

As we are not using the fact that we still have the file descriptor
open when we do the stat for any purpose (e.g. like locking other
processes out), this move to "close first and then stat" is a good
workaround for the problem.  I wonder if we have been seeing false
"racy git" problem more often due to this issue on Windows than
other platforms.

When code uses lstat, it gives a signal to the readers of the code
that the code is prepared to see a symlink and when it is a symlink
it wants to grab the property of the link itself, not the target of
the link.  I do not think the temporary index can be a symbolic
link, and even if that were the case, we do want the mtime of the
link target, so it is a wrong signal to give to the readers.  Hence,
it would be better to use stat() here from the readability's point
of view.  Of course, when the path is always a regular file, lstat()
vs stat() technically does not give any different result, so this
comment is purely about the maintainability, not about correctness.

Other than that, looks good to me.

>  	istate->timestamp.sec = (unsigned int)st.st_mtime;
>  	istate->timestamp.nsec = ST_MTIME_NSEC(st);
> @@ -2185,7 +2190,7 @@ static int commit_locked_index(struct lock_file *lk)
>  static int do_write_locked_index(struct index_state *istate, struct lock_file *lock,
>  				 unsigned flags)
>  {
> -	int ret = do_write_index(istate, get_lock_file_fd(lock), 0);
> +	int ret = do_write_index(istate, &lock->tempfile, 0);
>  	if (ret)
>  		return ret;
>  	assert((flags & (COMMIT_LOCK | CLOSE_LOCK)) !=
> @@ -2282,7 +2287,7 @@ static int write_shared_index(struct index_state *istate,
>  		return do_write_locked_index(istate, lock, flags);
>  	}
>  	move_cache_to_base_index(istate);
> -	ret = do_write_index(si->base, fd, 1);
> +	ret = do_write_index(si->base, &temporary_sharedindex, 1);
>  	if (ret) {
>  		delete_tempfile(&temporary_sharedindex);
>  		return ret;
>
> base-commit: e2cb6ab84c94f147f1259260961513b40c36108a
