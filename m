Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747C3C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 17:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 479C861151
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 17:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237969AbhJORK4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 13:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237786AbhJORKz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 13:10:55 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6445C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 10:08:48 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id f5so9124009pgc.12
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 10:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pJEFPudyLyXJ0YR/htcbuDFMCKZL/EVXD9P4KVRUTeo=;
        b=lLBEv5IOYGv0c9MZo9bwjfP8p3QqjLpBF1HpP9z+j2V4rAUDiVZZ1VMM2/f+b3KgM+
         mBO1X5GuAdOt0ojVZ3026PrCZHrFSrqMsrYtRjXt3uEOMPhEXD3qZcvOph27LQ/zLYqm
         3d0Xn5Kiti/P4aHC4Zsc06+GKKFlB+yk2kJ/qvXXVcXGkAAz/QtJzhIszIGGpKWgmeaa
         7JqjUd+fKwaWDmc0uc2IJHd8YlcuyKzGpgU5OnHU3FpkmaFF1UmhmwgG7BoVQyNkob1m
         Wn2vE6ynJnNFIOL49kMmVlq5v4/fsRhqu+ZMTmcsW2i6lotL7/SQx4SxG5V40OUFR3EX
         QDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pJEFPudyLyXJ0YR/htcbuDFMCKZL/EVXD9P4KVRUTeo=;
        b=xYMN3dXNCHpUhE2Z8q9FTRU2mPlq72NC0W8FNc439n+UlndgMGs5dchhnYTUaWuhex
         miThc3nSZmoOoedfmK0qTUsazjzl06QCbth3V6CBeHl0JnFBNdv9TlIglyq+ufUdcrHK
         Zg1gdTEbKs66ExSucOOd4f2DqPq7Gsbmdt0NBuFrGd4SaG7CyHiwTFhwAeTlAUaWWbzl
         qGYvCRM3k+IjOvqEJTVkAxkCIMMw4BtNZTurA9TAvKdkXK9qeHpMMpoPqv+3RdEu716k
         ofiouTgldnP7aWglv2PumKxPxnA0SbXaYZy1W0+l3vz7mSvaDqnV5tt+7JQ0+nKTfkwr
         DSyg==
X-Gm-Message-State: AOAM533GD/GtbndVno3Th5jusN6aGU7To7mwzd5Ad+8jypruxm4Y1xS0
        vbUrIkxMXG99h362dvevre9fqg==
X-Google-Smtp-Source: ABdhPJxVMiq5yH+mQuzlTPSnm9Sbbg29urt9PISHKJmSMf3GFE0G319v9PGYLeiA4sUmQHaMQY5zXg==
X-Received: by 2002:a63:921e:: with SMTP id o30mr3299262pgd.328.1634317727971;
        Fri, 15 Oct 2021 10:08:47 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cc2f:afb0:ab09:f218])
        by smtp.gmail.com with ESMTPSA id y22sm11748266pjj.33.2021.10.15.10.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 10:08:47 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:08:42 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 09/13] git-p4: use 'git hook' to run hooks
Message-ID: <YWm1mksCaxJmRoFR@google.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
 <patch-v2-09.13-b1f52733e3c-20211015T093918Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-09.13-b1f52733e3c-20211015T093918Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 15, 2021 at 11:43:37AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> Instead of duplicating the behavior of run-command.h:run_hook_le() in
> Python, we can directly call 'git hook run'. We emulate the existence
> check with the --ignore-missing flag.
> 
> As this is the last hook execution in git.git to not go through "git
> hook run" or the hook.[ch] library we can now be absolutely sure that
> our assertion in hook.c that only hooks known by the generated (from
> githooks(5)) hook-list.h are permitted.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  git-p4.py | 72 ++++++-------------------------------------------------
>  1 file changed, 7 insertions(+), 65 deletions(-)
> 
> diff --git a/git-p4.py b/git-p4.py
> index 2b4500226aa..1f24cbf0bca 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -207,71 +207,13 @@ def decode_path(path):
>          return path
>  
>  def run_git_hook(cmd, param=[]):
> -    """Execute a hook if the hook exists."""
> -    if verbose:
> -        sys.stderr.write("Looking for hook: %s\n" % cmd)
> -        sys.stderr.flush()
> -
> -    hooks_path = gitConfig("core.hooksPath")
> -    if len(hooks_path) <= 0:
> -        hooks_path = os.path.join(os.environ["GIT_DIR"], "hooks")
> -
> -    if not isinstance(param, list):
> -        param=[param]
> -
> -    # resolve hook file name, OS depdenent
> -    hook_file = os.path.join(hooks_path, cmd)
> -    if platform.system() == 'Windows':
> -        if not os.path.isfile(hook_file):
> -            # look for the file with an extension
> -            files = glob.glob(hook_file + ".*")
> -            if not files:
> -                return True
> -            files.sort()
> -            hook_file = files.pop()
> -            while hook_file.upper().endswith(".SAMPLE"):
> -                # The file is a sample hook. We don't want it
> -                if len(files) > 0:
> -                    hook_file = files.pop()
> -                else:
> -                    return True
> -
> -    if not os.path.isfile(hook_file) or not os.access(hook_file, os.X_OK):
> -        return True
> -
> -    return run_hook_command(hook_file, param) == 0
> -
> -def run_hook_command(cmd, param):
> -    """Executes a git hook command
> -       cmd = the command line file to be executed. This can be
> -       a file that is run by OS association.
> -
> -       param = a list of parameters to pass to the cmd command
> -
> -       On windows, the extension is checked to see if it should
> -       be run with the Git for Windows Bash shell.  If there
> -       is no file extension, the file is deemed a bash shell
> -       and will be handed off to sh.exe. Otherwise, Windows
> -       will be called with the shell to handle the file assocation.
> -
> -       For non Windows operating systems, the file is called
> -       as an executable.
> -    """
> -    cli = [cmd] + param
> -    use_shell = False
> -    if platform.system() == 'Windows':
> -        (root,ext) = os.path.splitext(cmd)
> -        if ext == "":
> -            exe_path = os.environ.get("EXEPATH")
> -            if exe_path is None:
> -                exe_path = ""
> -            else:
> -                exe_path = os.path.join(exe_path, "bin")
> -            cli = [os.path.join(exe_path, "SH.EXE")] + cli
> -        else:
> -            use_shell = True
> -    return subprocess.call(cli, shell=use_shell)
> -
> +    """args are specified with -a <arg> -a <arg> -a <arg>"""

Ah, the comment is misleading now, since we're adding args after the --.

> +    args = ['git', 'hook', 'run', '--ignore-missing', cmd]
> +    if param:
> +        args.append("--")
> +        for p in param:
> +            args.append(p)
> +    return subprocess.call(args) == 0
>  
>  def write_pipe(c, stdin):
>      if verbose:
> -- 
> 2.33.1.1338.g20da966911a
> 
