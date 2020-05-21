Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40738C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 20:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D3A020826
	for <git@archiver.kernel.org>; Thu, 21 May 2020 20:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSABFZSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgEUUbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 16:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbgEUUbt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 16:31:49 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9F0C061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 13:31:49 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id c11so7777614ljn.2
        for <git@vger.kernel.org>; Thu, 21 May 2020 13:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=d0tYS2SA6tXTNHKtO/5PO0tE+Pc2VUN/A69MDA3OCa8=;
        b=WSABFZSXZHQelM1e02g8IqP0tWx0F2bghsmn27AoIwP9ij9yiaivZfNaOX0ymX1x9D
         ZQ0RK5yLTcfjmH1GkKcQNN2REqznBgSxBb+p1bjCcjIeJGqZkP6H/WH3nvU48nEABPz+
         RT2mei2qUqH2rJCDFVlW4za8YPPDxyCV8a9SRUxPi9zwOzCQbX+mS/4gfDGiDa9H+qbM
         rRA0jEDx4wrGHSMKL/ci3NBiN/iwbknVv6zghAYqZne2eXAfKECFtnQpBFhJbQ9x71Sb
         GwvhDObzfZMi8QNjThALwVXIleEAHya087YHoSoVPE6clm66FktBWUcK1UboMBfJeBuF
         696g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=d0tYS2SA6tXTNHKtO/5PO0tE+Pc2VUN/A69MDA3OCa8=;
        b=ZOsC+ywXYeeQtN+4u5cdepHlbSZNOR1o0LYAdm42cMq4nHIi4OVfGgX1pyn3uzjSM7
         4ybleRWSuw73Zh+rhfuW+QPDDKoB+SJVV3pLKCAtQ0HbnMyYUPsQih5azRLYvoHJ1kg5
         FYFddtEZ0NDA6+wsic2TmCA5hTVdhBrVfi3L/h3JFwbBRylC4Ge6Ph6a1HfVLPhylKio
         gCN4Bmh0jt+9MEyh5+ga/5WLZGNFOXFQzD32sa/tneK0HQlGT3/8e5gphrAupQZjt0/C
         xkhP07r7QW3OTWB0diKPriktOYt4MZwNNbGgXe8dxG3UA6Zi4n72zRG9cpgKLguD9X6t
         YBog==
X-Gm-Message-State: AOAM530TeGfGjvt22nQyUnSEQGcrwLz8yKUUB+zS6nDPBmsSlIemDcPc
        G2VpBJkcq1EAF4S+SG/pGIixxhrcugQfkJGtZta9YztJ
X-Google-Smtp-Source: ABdhPJwPwIdvpXqcjAZxojwEdufx7gioS8MA4VwcbTkaCEodmGWOBHVx5fhvGN1URMOAyHMjzubQBNo8EvNCkGChSUU=
X-Received: by 2002:a2e:87d2:: with SMTP id v18mr6091245ljj.121.1590093107093;
 Thu, 21 May 2020 13:31:47 -0700 (PDT)
MIME-Version: 1.0
From:   "D. Ben Knoble" <ben.knoble@gmail.com>
Date:   Thu, 21 May 2020 16:31:35 -0400
Message-ID: <CALnO6CDtGRRav8zK2GKi1oHTZWrHFTxZNmnOWu64-ab+oY3_Lw@mail.gmail.com>
Subject: libexec/git-core on PATH in editors and other subprocesses (and a fix
 for vim)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I noticed something odd today--I was working in vim and spawned a new terminal
with `:terminal`. My shell startup files, which use the location of the git
binary to reconstruct paths to things like
`etc/bash_completion.d/git-prompt.sh` and `contrib/git-jump`, suddenly choked.
The location of the git program was suddenly different than usual!

After some debugging, I came to determine that this occurred, not because of
vim, but because vim was launched from a git-invoked process (in this case,
`contrib/git-jump/git-jump`).

The salient git code is `setup_path()` in exec-cmd.c [1] and it's call in git.c
[2]. They appear to coordinate to prepend the libexec dir to PATH. This causes
the location of the git binary to be (e.g.) /usr/local/libexec/git-core/git, and
not (e.g.) /usr/local/bin/git; since I traverse up two directories from the
location of git, the former breaks my startup scripts. (You would be well
withing your rights to argue that I should not use the location of git to find
these scripts. I have my reasons.)

Anyway, the net result is that if I run, say, `git jump grep foo` and then try
to invoke `:terminal` or `:shell`, my shell complains.

Unfortunately, this modification propagates to all child processes, as this
simple test-case demonstrates:

    $ printf '%s\n' '#!/bin/sh' "printenv PATH | tr : '\n' | grep
git-core" > git-show-env
    $ chmod u+x git-show-env
    $ PATH=.:$PATH git show-env
    /usr/local/Cellar/git/2.26.2/libexec/git-core

While it would be *nice* if git didn't modify PATH in such a way that it
affected all subprocesses (i.e., if it was somehow scoped to only processes that
need it), I suspect this is at best difficult and at worst highly-error prone or
likely to break things.

In the (possibly eternal) interim, I would like to share some vimscript that
"fixes" $PATH in vim when it detects this case. The easiest use is to drop the
code in your vimrc file (usually ~/.vim/vimrc or ~/.vimrc). I've tried to keep
it portable in terms of path separators and file paths, but I do not have a
Windows box to test on.

Actually, it's a little more aggressive than I suggested; it strips out *all*
PATH entries ending in libexec/git-core, not just the first. But I never have
libexec/git-core on my PATH anyway, so I'm not bothered by that. One could
modify this function to only check the first entry (the one git would have
prepended).

Best,
Ben Knoble

P.S. Does anyone know what the libexec/git-core equivalent is on Windows? [3]
alludes to libexec\git-core, which I *think* is handled by my code.

P.P.S. If your vim is old and does not have `const`, you can use `let` instead.
You may need to change out the lambda {_, d -> ... } for a "v:val" string as
well.

[1]: https://github.com/git/git/blob/87680d32efb6d14f162e54ad3bda4e3d6c908559/exec-cmd.c#L304
[2]: https://github.com/git/git/blob/87680d32efb6d14f162e54ad3bda4e3d6c908559/git.c#L868
[3]: https://wilsonmar.github.io/git-custom-commands/

--- VIM CODE

" When git starts up, it prepends it's libexec dir to PATH to allow it to find
" external commands.
"
" Thus, if vim is invoked via a git process (such as the contrib git-jump, my
" own git-ed, or any other usage of GIT_EDITOR/VISUAL/EDITOR in git commands, be
" they scripts or internals--with the exception of manually invoking the script
" yourself, without using git: sh .../git-jump), $PATH will contain something
" like libexec/git-core.
"
" We don't generally want it in vim's $PATH, though, as it is passed down to
" *all* subprocesses, including shells started with :terminal or :shell.
function s:fix_git_path() abort
  const slash = has('win32') ? '\' : '/'
  const git_core_base = printf('libexec%sgit-core', slash)
  " optimization: early return
  if $PATH !~# '.*'.git_core_base.'.*'
    return
  endif
  const path_sep = has('win32') ? ';' : ':'
  const path = split($PATH, path_sep)
  const path_sans_libexec_git_core = filter(path, {_, d -> d !~#
'.*'.git_core_base})
  const new_path = join(path_sans_libexec_git_core, path_sep)
  let $PATH = new_path
endfunction

augroup fix_git_path
  autocmd!
  autocmd VimEnter * call s:fix_git_path()
augroup END

--- END VIM CODE
