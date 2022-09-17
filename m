Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15BAC6FA82
	for <git@archiver.kernel.org>; Sat, 17 Sep 2022 06:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiIQGI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Sep 2022 02:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIQGI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2022 02:08:57 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E6C9D642
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 23:08:55 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 130so35451503ybw.8
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 23:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ga67csWPikfkltEHkVOdRTynhmXTSY+5/vC2ronR/ps=;
        b=WkSMGeutao9G73wm/XOdF7Lnr8Tj726yyGhrG8XDIlpO5bcDtciFdaMW8Y6H5mNumf
         4bTOIR6WEYWVZ1CTF0s5PWqXBNMNzlgOjBD3MTt5ZzQSTf3d7USlAOq4Aa0+IHCAHY/g
         m1Femf3juplY0kM8ce9KNuwT2G9iWkmMRqS0SucV8/d/1y0uUGmes0edzBhsNXtCgx58
         LQKQcw04jAejVcAqexp0qBl3QtNqD05uzQHVQPH/RHMEzH8uAV0Xl8/dlKV+G0SWBhe0
         dQcMlCAO3btmjhlpVvE5HcHyWydmA6g8Z/qNBlAo6XsReEbkjPagXDo4ovAvdHOsBGBU
         +q3A==
X-Gm-Message-State: ACrzQf0g7l7JPHVA1iEuNcoOz0CH/oL3WIcjeWgfN67ATHm8TP4Xnc0P
        zcxxvLEjhFSZgh9SswDYwY1NRX/I8w1rOsIzJX8=
X-Google-Smtp-Source: AMsMyM4+0YqRorteukXRNmv9fgWc+StwVetMkBly97MU9Sy6fmy+sYDlm+suK0iPHSZuHiltZsJvhHax1C4UORZhUgU=
X-Received: by 2002:a25:4645:0:b0:695:b0c8:2817 with SMTP id
 t66-20020a254645000000b00695b0c82817mr7397949yba.211.1663394934716; Fri, 16
 Sep 2022 23:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com>
 <pull.1326.v8.git.1663377141.gitgitgadget@gmail.com> <ddf4e3e6442b104447154b0a5d4954f274f4b5ef.1663377141.git.gitgitgadget@gmail.com>
In-Reply-To: <ddf4e3e6442b104447154b0a5d4954f274f4b5ef.1663377141.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 17 Sep 2022 02:08:43 -0400
Message-ID: <CAPig+cQ5SMw+0Cwtw47LQM59-mQjJaOPe_LTybAC2j=3F9OywA@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] fsmonitor: add documentation for allowRemote and
 socketDir options
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 16, 2022 at 9:12 PM Eric DeCosta via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Add documentation for 'fsmonitor.allowRemote' and 'fsmonitor.socketDir'.
> Call-out experimental nature of 'fsmonitor.allowRemote' and limited file
> system support for 'fsmonitor.socketDir'.
>
> Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
> ---
> diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git-fsmonitor--daemon.txt
> @@ -70,6 +70,41 @@ the change (as happening against the super repo).  However, the client
> +By default, the fsmonitor daemon refuses to work against network-mounted
> +repositories; this my be overridden by setting `fsmonitor.allowRemote` to
> +`true`. Note, however, that the fsmonitor daemon is not guaranteed to work
> +correctly with all network-mounted repositores and such use is considered
> +experimental.

s/repositores/repositories/

> +On Mac OS, the inter-process communication (IPC) between various Git
> +commands and the fsmonitor daemon is done via a Unix domain socket (UDS).
> +Usage of UDS requires the creation of a file which, by default, is created
> +in the .git directory.  If the fsmonitor daemon detects that the .git directory

Typesetting: s/.git/`.git`/g

> +is on a network-mounted file system, it will create the UDS file in $HOME.  If

There's a gap in the explanation as to _why_ fsmonitor won't use the
.git directory for this file when on a network-mounted filesystem and
instead chooses $HOME. For the reader who is not well-versed in Unix
sockets/filesystems, it may be difficult to understand the logic
behind this. This gap is somewhat filled in a few sentences later, but
it makes for potentially confusing reading until then.

Should the reader know the name of the socket file or at least the
templated form of the name? The first question which popped into my
head upon reading this was whether it was going to pollute my home
directory with non-hidden files. If this had mentioned something along
the lines of "creation of a file named `.git-fsmonitor-*`" or
"creation of a hidden file" then I would have understood immediately
that the file would have been hidden.

> +$HOME itself is on a network-mounted file system or if $HOME is not the desired

To be consistent with formatting elsewhere in the Git documentation,
let's typeset this as `$HOME` (with backticks).

Aside: The spelling "filesystem" appears almost five times as often as
"file system" in Git documentation, however, this particular file
already uses "file system" and does so consistently, so it makes sense
to follow suit as you do here. Changing to use "filesystem" instead,
if such a task is desirable, is outside the scope of this patch
series.

> +location for the UDS file, 'fsmonitor.socketDir' may be set to any valid, local

For consistency, let's use backticks here, as well: `fsmonitor.socketDir`

> +directory on a file system with proper support.  Mac OS native file systems have

Together with the above comment about a gap in the explanation, I
found myself scratching my head about what "proper support" meant
(when pretending to read this as a person not particularly familiar
with Unix sockets or filesystems).

Also, although this explains how to work around the case when $HOME is
itself network-mounted, what happens if $HOME is network-mounted and
the user does not set `fsmonitor.socketDir`? Does it error out? Does
it simply misbehave in some way? Should it error out? (I would think
"yes".)

> +the required support.  File systems known to lack support include FAT32 and
> +NTFS.  Other file systems may or many not have the needed support; the fsmonitor

s/many/may/

> +daemon is not guaranteed to work with these file systems and such use is
> +considered experimental.

Taking the above comments into account, here's my attempt at a rewrite:

    On Mac OS, the inter-process communication (IPC) between various
    Git commands and the fsmonitor daemon occurs via a Unix domain
    socket (UDS) -- a special type of file -- which is supported by
    the native Mac OS filesystems but not by network-mounted
    filesystems, NTFS or FAT32.  Other file systems may or many not
    have the needed support; the fsmonitor daemon is not guaranteed to
    work with these file systems and such use is considered
    experimental.

    By default, the socket is created in the `.git` directory,
    however, if the `.git` directory is on a network-mounted file
    system, it will instead be created at `$HOME/.git-fsmonitor-*`
    unless `$HOME` itself is on a network-mounted file system, in
    which case you must set the configuration variable
    `fsmonitor.socketDir` to the path of a directory on a Mac OS
    native filesystem in which to create the socket file.

> +CONFIGURATION
> +-------------
> +When `core.fsmonitor` is set to `true` (see linkgit:git-config[1])
> +the fsmonitor daemon will pay attention to the following configuration
> +variables:

We probably want a blank line after the header underline and before
this paragraph.

> +fsmonitor.allowRemote::
> +       By default, the daemon refuses to work against network-mounted
> +       repositories. Setting `fsmonitor.allowRemote` to `true` overrides
> +       this behavior.
> +
> +fsmonitor.socketDir::
> +       This option is only used by the Mac OS implementation of the fsmonitor
> +       daemon. If set, 'fsmonitor.socketDir' must be set to a valid, local
> +       directory on a file system that can support Unix domain sockets (UDS).

Typeset with backticks: `fsmonitor.socketDir`

The word "valid" seems unnecessary. A possible rewrite:

    This Mac OS-specific option, if set, specifies the directory in
    which to create the Unix domain socket used for communication
    between fsmonitor and various Git commands. The directory must
    reside on a native Mac OS filesystem as discussed above.
