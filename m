Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9152C07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 13:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiI0Nus (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 09:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiI0Nur (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 09:50:47 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54162126F
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 06:50:45 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r20so5989938qtn.12
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 06:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+tLzsz/usuzb+sYFr9WVwGuEhnTixLHuXrrZiixCpp4=;
        b=CtdQT6Fzgf3NtlJwXRZfBIDAgi4Z4lgYCVNbcNgtSXh5qVGZLBCOKIB+Jwe5lVgYo7
         VmOBMXw+yasF8IdAb7FxHE3zO12YdgpIHw6YAaP6URIijQZm9+BKlGNrOkPfDU8d4F4v
         blGoEd8uDzzXyiJe/h0jYZ7tXrD8uJSD9KMn1+Xxo7/xT3CYEpuQXxC0aCBubixTPDMm
         e0P7KnWj3mci1oY9XpBRIh8JMWyPIBWm3/HUp2tpXh17mZyqEoa/BqWIoe1cXFCKsmoq
         NwZv7e+ftzD3APQHVRDYzABl/hhqSl8fnINLgFCj3vZsjyKrtenZknPit3Yj41SxurHr
         JMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+tLzsz/usuzb+sYFr9WVwGuEhnTixLHuXrrZiixCpp4=;
        b=pDokFpVTAWFYcyl1MbG1NR+zmJCS2u2hLLHWcuHQHjezyr8g9Hj1FjoVIXPoSuD3DH
         B9oGQ4sxfhhy++yE9nA1olVr9rUvQeXGOK0OON2owTwREUfw6RwH+HW/9nZh5HAccGKS
         mmCufK1sZqAxtolACQzI1iSgHE52LQgtqDFRo9UtQfxPorb1x9JuXfUy8RfYlabCcLKv
         aQ7+dJPuQ8tMfUJhCPl32UkVktS6rzmlck1vbCjv9Zn9CCNc3NLlUFElhGJOlX6vyIMh
         hQimWRAeDjVuzNJ8RIwC2GzFySq4YXRlK3WAVrSwLYoR8y+8M4vQTRLlOi3lrnSlO3Uh
         yrlQ==
X-Gm-Message-State: ACrzQf3XXFpRu/dU1vC+Je0/29ZOWKkmbpwYrIOGz5uUe2GncUgxmn3K
        CVJ01lI6BwDpm1H0sPLWzHM=
X-Google-Smtp-Source: AMsMyM5/Sf/7Vrx9CpMu1W200zz6XGhJ//XP3523pY0L/XMP7exnaNW8YW3be6HW681elj3vQcy+rA==
X-Received: by 2002:a05:622a:4d4:b0:35d:19e0:a44e with SMTP id q20-20020a05622a04d400b0035d19e0a44emr20793724qtx.543.1664286644822;
        Tue, 27 Sep 2022 06:50:44 -0700 (PDT)
Received: from [10.37.129.2] (pool-71-187-159-144.nwrknj.fios.verizon.net. [71.187.159.144])
        by smtp.gmail.com with ESMTPSA id cb20-20020a05622a1f9400b0035a7070e909sm872200qtb.38.2022.09.27.06.50.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2022 06:50:44 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tmp-objdir: do not opendir() when handling a signal
Date:   Tue, 27 Sep 2022 09:50:43 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <1B4D6262-532A-401E-B1A2-709BEECA4B67@gmail.com>
In-Reply-To: <YzLiI1HZeBszsIJq@coredump.intra.peff.net>
References: <pull.1348.git.git.1664236383785.gitgitgadget@gmail.com>
 <YzLiI1HZeBszsIJq@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Peff,

On 27 Sep 2022, at 7:44, Jeff King wrote:

> On Mon, Sep 26, 2022 at 11:53:03PM +0000, John Cai via GitGitGadget wro=
te:
>
>> One place we call tmp_objdir_create() is in git-receive-pack, where
>> we create a temporary quarantine directory "incoming". Incoming
>> objects will be written to this directory before they get moved to
>> the object directory.
>>
>> We have observed this code leading to a deadlock:
>>
>> 	Thread 1 (Thread 0x7f621ba0b200 (LWP 326305)):
>> 	#0  __lll_lock_wait_private (futex=3Dfutex@entry=3D0x7f621bbf8b80
>> 		<main_arena>) at ./lowlevellock.c:35
>> 	#1  0x00007f621baa635b in __GI___libc_malloc
>> 		(bytes=3Dbytes@entry=3D32816) at malloc.c:3064
>> 	#2  0x00007f621bae9f49 in __alloc_dir (statp=3D0x7fff2ea7ed60,
>> 		flags=3D0, close_fd=3Dtrue, fd=3D5)
>> 		at ../sysdeps/posix/opendir.c:118
>> 	#3  opendir_tail (fd=3D5) at ../sysdeps/posix/opendir.c:69
>> 	#4  __opendir (name=3D<optimized out>)
>> 		at ../sysdeps/posix/opendir.c:92
>> 	#5  0x0000557c19c77de1 in remove_dir_recurse ()
>> 	#6  0x0000557c19d81a4f in remove_tmp_objdir_on_signal ()
>> 	#7  <signal handler called>
>
> Yuck. Your analysis looks right, and certainly opendir() can't really
> work without allocating memory for the pointer-to-DIR.
>
>> To prevent this, add a flag REMOVE_DIR_SIGNAL that allows
>> remove_dir_recurse() to know that a signal is being handled and avoid
>> calling opendir(3). One implication of this change is that when
>> signal handling, the temporary directory may not get cleaned up
>> properly.
>
> It's not really "may not" here, is it? It will never get cleaned up on =
a
> signal now. I don't think remove_dir_recursively() will try to rmdir()
> in this case. But even if it did, we'll always have a "pack"
> subdirectory (minus the small race before we've created it).
>
> That's unfortunate, but I don't think we really have a portable
> alternative. We can't keep an exact list of files to be deleted, becaus=
e
> some of them will be created by sub-processes. We could perhaps exec a
> helper that does the deletion, but that seems like a race and
> portability nightmare. On Linux, we could probably use open() and
> getdents64() to traverse, but obviously that won't work everywhere. It
> _might_ be worth having some kind of compat/ wrapper here, to let
> supported systems do as good a job as they can. But it's not like there=

> aren't already cases where we might leave the tmp-objdir directory
> around (say, SIGKILL), so this is really just extending the existing
> problem to more signals.
>
> I was going to suggest we should do a better job of cleaning up these
> directories via git-gc. But it looks like b3cecf49ea (tmp-objdir: new
> API for creating temporary writable databases, 2021-12-06) changed the
> default name such that a regular git-gc should do so. So I think we're
> covered there.

I was wondering about this as well. Thanks for checking on this--that's
reassuring.
>
> The main case we care about is normal exit when index-pack or a hook
> sees an error, in which case we should still be cleaning up via the
> atexit() handler.
>
> So I think your patch is going in the right direction, but...
>
>>  static int remove_dir_recurse(struct strbuf *path, int flag, int *kep=
t_up)
>>  {
>> -	DIR *dir;
>> +	DIR *dir =3D NULL;
>>  	struct dirent *e;
>>  	int ret =3D 0, original_len =3D path->len, len, kept_down =3D 0;
>>  	int only_empty =3D (flag & REMOVE_DIR_EMPTY_ONLY);
>> @@ -3261,7 +3261,10 @@ static int remove_dir_recurse(struct strbuf *pa=
th, int flag, int *kept_up)
>>  	}
>>
>>  	flag &=3D ~REMOVE_DIR_KEEP_TOPLEVEL;
>> -	dir =3D opendir(path->buf);
>> +
>> +	if ((flag & REMOVE_DIR_SIGNAL) =3D=3D 0)
>> +		dir =3D opendir(path->buf);
>> +
>>  	if (!dir) {
>>  		if (errno =3D=3D ENOENT)
>>  			return keep_toplevel ? -1 : 0;
>
> We skip calling opendir() entirely, so "dir" will still be NULL. But we=

> immediately start looking at errno, which will have some undefined valu=
e
> (based on some previous syscall).
>
> If we set "errno" to "EACCES" in this case, then we'd at least hit the
> rmdir() below:
>
>          if (!dir) {
>                   if (errno =3D=3D ENOENT)
>                           return keep_toplevel ? -1 : 0;
>                   else if (errno =3D=3D EACCES && !keep_toplevel)
>                           /*
>                            * An empty dir could be removable even if it=

>                            * is unreadable:
>                            */
>                           return rmdir(path->buf);
>                   else
>                           return -1;
>           }
>
> but we know it won't really do anything for our proposed caller, since
> it will have files inside the directory that need to be removed before
> rmdir() can work.

yeah, I suppose the only case it would help is if the directory is alread=
y
empty.

>
> Moreover, if you were to combine REMOVE_DIR_SIGNAL with
> REMOVE_DIR_KEEP_NESTED_GIT, I suspect that the call to
> resolve_gitlink_ref() would end up with similar deadlocks. Obviously
> nobody is proposing to do that, but it is a pitfall in the API.
>
> So all of that makes me think we should not add a new flag here, but
> instead just avoid calling the function entirely from
> tmp_objdir_destroy_1().
>
> But then we can observe that tmp_objdir_destroy_1() is basically doing
> nothing if on_signal is set. So there is really no point in setting up
> the signal handler at all. We should just set up the atexit() handler.
> I.e., something like:
>
> diff --git a/tmp-objdir.c b/tmp-objdir.c
> index a8be92bca1..10549e95db 100644
> --- a/tmp-objdir.c
> +++ b/tmp-objdir.c
> @@ -169,7 +169,6 @@ struct tmp_objdir *tmp_objdir_create(const char *pr=
efix)
>  	the_tmp_objdir =3D t;
>  	if (!installed_handlers) {
>  		atexit(remove_tmp_objdir);
> -		sigchain_push_common(remove_tmp_objdir_on_signal);
>  		installed_handlers++;
>  	}

This makes sense and is a clean solution. I guess the only case where we =
would
benefit in calling into remove_tmp_objdir_on_signal() is if the temp dir =
exists
but is empty. I'm not sure how often this would happen to make it worth i=
t?
Probably not...

>
>
> with the commit message explaining that we can't do the cleanup in a
> portable and signal-safe way, so we just punt on the whole concept.
>
> There's also some minor cleanup we could do elsewhere to drop the
> "on_signal" argument (which can come as part of the same patch, or on
> top).
>
> -Peff
