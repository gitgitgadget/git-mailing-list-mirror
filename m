Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7160AC433E0
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 15:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AA0F2076D
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 15:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUkgyOTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgGPPlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgGPPlw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 11:41:52 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926F9C061755
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 08:41:52 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c80so10733756wme.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 08:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T0N3HcZItRteVhYH6f+qJF84as+gM5tE4vVzOTLKDnc=;
        b=dUkgyOTHv4npoGvogw4cc4knjNQ+aSILdQ183IW+VaQN2KNRlhIJp4Y3bf93TZgnZJ
         n1j3jHamauqME1+bDUtSxCMlYTp2khfu8qHrez3ypMM4gbsuF6Dc3L8MU2KdatM6Bqey
         VniDgcwJEaZETwYH6JWYD39eM0SAeopNnILOg5GKOmjO28cqpmsSPSZfbrarwyOZ35r8
         46FN8T8pK2zliMhnAGvhgBd9PT+SqTSspxkcdL5/86JHIBpBSeracRlbPykHZiBvZ9ZE
         Ucf1dhHqhe/ln9BZXvbM9krcrxpIXPtkm9XqeKUTn1rsVXKEAO2iFImLD/LE+9YB8fvx
         2VRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T0N3HcZItRteVhYH6f+qJF84as+gM5tE4vVzOTLKDnc=;
        b=pQ3lgYOlg+rlxWKijsWln+ADvooHclTUO5qGpjJjhNH4jIhGG+1CG/WUHkkHTTSlpd
         LPfkjo7WjvJvT/xnGzWfSL/+d4nWykxsxSXsHsB858UQPGQciyG7qPvacJGfUm2QjGEt
         zguYfg1Hp0ZgyMzfFGSI+u9LoUPFjc0/If4lRuNTwaC/gQaOKSdb50LF5fW8UTeKyvfu
         97RVFs5hLYSQiPQa+jPC8jZ1sTYyP1YtzUyKVwalWOQUTyQr87hfSnpImVkifaep1udp
         vnWoi5diyREbAgXeGSixSuc8dP1wcQyYGwb1UHqGGchuy3BWimBD25xCsJ1rIGdpjA+Z
         GB3g==
X-Gm-Message-State: AOAM532lpCAtP/6+nBIgqM2rCwxezb6hKrGgykcGd1NuSICQ4PBRjEXw
        2G8Psk+y71BzU4CuwXw6jNSW6WucVT2xaKSWpRsTk375sjc=
X-Google-Smtp-Source: ABdhPJw+Uv+NVVML6lbYKMpC1nREl20uG7G3rDz6/4FK8RQbwxlmJOUSZ4Zv1VzEhYso4A4fEuEk9xe/tXAKCl84N2A=
X-Received: by 2002:a1c:80c8:: with SMTP id b191mr4637074wmd.37.1594914111217;
 Thu, 16 Jul 2020 08:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <d6bbe71e47dcfd7ef31213537eeb3f05@ltpcgo.com>
In-Reply-To: <d6bbe71e47dcfd7ef31213537eeb3f05@ltpcgo.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Thu, 16 Jul 2020 08:41:40 -0700
Message-ID: <CAPx1GvfKxu8gwbp0Gn2dBf9th874skKjD-echeAFr7_77o8FYw@mail.gmail.com>
Subject: Re: Issue with insufficient permission for adding an object to
 repository database .git/objects
To:     "LTPCGO | George" <george@ltpcgo.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 16, 2020 at 7:30 AM LTPCGO | George <george@ltpcgo.com> wrote:
> I have attached a fix below, but it would be much better to fix in the
> code.  I am curious first, before proposing a fix in the code (although
> I can't find the specific call in the source at
> https://github.com/git/git ), what the reasoning is for the current
> permissions check on the call rather than checking the contents of the
> opened tmp file.

This is not in fact a bug in Git (which assumes POSIX semantics).
Git is not doing its own permissions checking here.  Rather, it is
a problem with the way the NFS software you are using attempts,
but fails, to emulate the POSIX requirements.

What Git does is this:

 * form the name of a file that we expect not to exist
 * use an open() system call in this way:

     fd = open(path, O_CREAT | O_EXCL | O_RDWR, 0444)

Note that this is a single, atomic system call that asks
the OS to:

 1. make sure the path does not exist currently -- if it
    does, return an error;
 2. create that path and open the resulting file for
    reading and writing, but make sure that no one else
    may write to that path.

On a local file system, this really is a single atomic
operation: either the path does not exist *and* you are
allowed to create it *and* the creation succeeds *and*
you now have a writable file-handle for a read-only file;
or, any one of the "and"s above has failed (file already
existed, you aren't allowed to create here, etc).

The underlying file is, in effect, write-once: *one* user
may write to the file, once, then close it.

Some NFS implementations, however, simply don't support this
operation as a single atomic operation.  In a best-effort attempt
to provide it anyway, they will do:

 1. test to see if the file exists, perhaps by doing an
    open with O_CREAT|O_EXCL themselves, but in an internal
    way that fails to obtain the file *handle*;
 2. chmod the underlying file to the desired mode;
 3. open the file again, this time to get a file handle.

In this case, the second open fails *because* the file is
set up to be "write-once": you cannot get a writable file
handle after the chmod.  But *Git* did not do the chmod.

Git could perhaps open these temporary files with mode
0644 instead of mode 0444, relying on the O_EXCL part and
self-coordination, then follow up later with an fchmod()
to set the mode to 0444.  But this opens a small window
for badly-behaved programs to obtain a file handle that
could be used to write to the Git object.

(Note that O_EXCL does not work well in general on NFS:
some systems do support it, but you're somewhat at the
mercy of your implementation.  See also
https://stackoverflow.com/questions/3406712/open-o-creat-o-excl-on-nfs-in-linux
and other reports you'll find by searching for "NFS O_EXCL"
on google.)

Chris
