Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21445C433DB
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 13:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF31164E85
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 13:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhB1NBt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 08:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhB1NBs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 08:01:48 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E52C06174A
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 05:01:07 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a22so23064320ejv.9
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 05:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=JfHSjL4KrhTXpq9S/odkz3tWc62+LjaBUJieTiqqiKU=;
        b=scgf7v6Q/8Jro52uI+t46ZJH5MKu0zpx3kVgXnHuX7vpITlOszO9NmZaknT/sPpoBu
         NmZLusUPXPHGAhdOpFMyLMGWRKd91jEmTzixUNj5OU6MfGpj5taNxHy0XVMQHVoaJewK
         Owfd+ZNatVVY9N29oAgTDB/rkV2fH2rpgnXhyuOWm4Ynh048FdnfubnXUXNPmUZ+wSyg
         tSyJJE07AkcvKZ8CSsnUbpfgp0Gke6qMusdZnmFmCBpzczSgfHT//5IirFmJNfVLE1qe
         gqQmphzS1bOajob2klwJ75Ux07gSxP+2I9jxWtKxk8NTmdmy1RMRCfSdyiT/00oJ+dsK
         zDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=JfHSjL4KrhTXpq9S/odkz3tWc62+LjaBUJieTiqqiKU=;
        b=av7NRLEwiSII+Xio04WwNzg07mJSEJVRZKJzSYa4AF/sHfXwoZSi3VB/CTVq0RqPKL
         ezLw7v6QWPeHdT36eOF5/mUzLRWgXyAsuYm8VNnurelBCzB2Ua/zuZfXjfXxVCOq2EBx
         7UDNm/TXU5CmmzIV6X3La0Fzcsv89VMfAJ1gCT4td7rnyV0y7OgeR+ocEdYgwyqE39gf
         h7A204IlTdK3wXZye+hQg0YmtdupsBQ2MvSl7HOtB8D2JNmeIf3OhUWvo04dMxRTbvoy
         FB4RIlFkxMcfWJ6Z5OXXAumViz5GscdjzOphEakNy0z/OwcnpNkMAgl3hYtX9wNwJv1b
         TmHg==
X-Gm-Message-State: AOAM531qTz7I9tKBGNg/KvX9plhnlXk+ZJXCmkPxUATlk69UTEbLzo3j
        LKN/lpJZLgzaOiXEQmI/RWF22NUJuxA=
X-Google-Smtp-Source: ABdhPJypAzoX+96mYdj49FFLRl0C/M3aeq/NT3tUTlX7hY9D3tynDhZ8H6TqLD+EOXIj6eU1tJE52w==
X-Received: by 2002:a17:906:a94b:: with SMTP id hh11mr11664516ejb.459.1614517265795;
        Sun, 28 Feb 2021 05:01:05 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id j14sm9701506eds.78.2021.02.28.05.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 05:01:05 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] docs: add a question on syncing repositories to the
 FAQ
References: <20210227191813.96148-1-sandals@crustytoothpaste.net>
 <20210227191813.96148-2-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210227191813.96148-2-sandals@crustytoothpaste.net>
Date:   Sun, 28 Feb 2021 14:01:04 +0100
Message-ID: <87eeh0l52n.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Feb 27 2021, brian m. carlson wrote:

> It is very common that users want to transport repositories with working
> trees across machines.  While this is not recommended, many users do it
> anyway and moreover, do it using cloud syncing services, which often
> corrupt their data.  The results of such are often seen in tales of woe
> on common user question fora.
>
> Let's tell users what we recommend they do in this circumstance and how
> to do it safely.  Warn them about the dangers of untrusted working trees
> and the downsides of index refreshes, as well as the problems with cloud
> syncing services.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/gitfaq.txt | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> index afdaeab850..042b11e88a 100644
> --- a/Documentation/gitfaq.txt
> +++ b/Documentation/gitfaq.txt
> @@ -241,6 +241,45 @@ How do I know if I want to do a fetch or a pull?::
>  	ignore the upstream changes.  A pull consists of a fetch followed
>  	immediately by either a merge or rebase.  See linkgit:git-pull[1].
>  
> +[[syncing-across-computers]]
> +How do I sync a Git repository across multiple computers, VMs, or operating systems?::
> +	The best way to sync a repository across computers is by pushing and fetching.
> +	This uses the native Git mechanisms to transport data efficiently and is the
> +	easiest and best way to move data across machines.  If the machines aren't
> +	connected by a network, you can use `git bundle` to create a file with your
> +	changes and then fetch or pull them from the file on the remote machine.
> +	Pushing and fetching are also the only secure ways to interact with a
> +	repository you don't own or trust.
> ++
> +However, sometimes people want to sync a repository with a working tree across
> +machines.  While this isn't recommended, it can be done with `rsync` (usually
> +over an SSH connection), but only when the repository is completely idle (that
> +is, no processes, including `git gc`, are modifying it at all).  If `rsync`
> +isn't available, you can use `tar` to create a tar archive of the repository and
> +copy it to another machine.  Zip files shouldn't be used due to their poor
> +support for permissions and symbolic links.
> ++
> +You may also use a shared file system between the two machines that is POSIX
> +compliant, such as SSHFS (SFTP) or NFSv4.  If you are using SFTP for this
> +purpose, the server should support fsync and POSIX renames (OpenSSH does).  File
> +systems that don't provide POSIX semantics, such as DAV mounts, shouldn't be
> +used.
> ++
> +Note that you must not work with untrusted working trees, since it's trivial
> +for an attacker to set configuration options that will cause arbitrary code to
> +be executed on your machine.  Also, in almost all cases when sharing a working
> +tree across machines, Git will need to re-read all files the next time you run
> +`git status` or otherwise refresh the index, which can be slow.  This generally
> +can't be avoided and is part of the reason why sharing a working tree isn't
> +recommended.
> ++
> +In no circumstances should you share a working tree or bare repository using a
> +cloud syncing service or store it in a directory managed by such a service.
> +Such services sync file by file and don't maintain the invariants required for
> +repository integrity; in addition, they can cause files to be added, removed, or
> +duplicated unexpectedly.  If you must use one of these services, use it to store
> +the repository in a tar archive instead.

I think documentation on this topic is needed, but wonder if we couldn't
make this more understandable by going to the heart of the matter, i.e.:

 * We prefer push/pull/bundle to copy/replicate .git content

 * Regardless, a .git directory can be copied across systems just fine
   if you recursively guarantee snapshot integrity, e.g. it doesn't
   depend on the endian-ness of the OS, or has anything like symlinks in
   there made by git itself.

 * Anything which copies .git data on a concurrently updated repo can
   lead to corruption, whether that's cp -R, rsync with any combination
   of flags, some cloud syncing service that expects to present that
   tree to two computers without guaranteeing POSIX fs semantics between
   the two etc.

 * A common pitfall with such copying of a .git directory is that file
   deletions are also critical, e.g. rsync without --delete is almost
   guaranteed to produce a corrupt .git if repeated enough times
   (e.g. git might prefer stale loose refs over now-packed ones).

 * It's OK to copy .git between system that differ in their support of
   symbolic links, but the work tree may be in an inconsistent state and
   need some manner of "git reset" to repair it.

And, not sure if this is correct:

 * It may be OK to edit a .git directory on a non-POSIX conforming fs
   (but perhaps validate the result with "git fsck"). But it's not OK to
   have two writing git processes work on such a repository at the same
   time. Keep in mind that certain operations and default settings (such
   as background gc, see `gc.autoDetach` in linkgit:git-config[1]) might
   result in two processes working on the directory even if you're
   changing it only in one terminal window at a time.

I.e. to go a bit beyond the docs you have of basically saying "there be
dragons in non-POSIX" and describe the particular scenarios where it can
go wrong. Something like the above still leaves the door open to users
using cloud syncing services, which they can then judge for themselves
as being OK or not. I'm sure there's some that are far from POSIX
compliance that are OK in practice if the above warnings are observed.

