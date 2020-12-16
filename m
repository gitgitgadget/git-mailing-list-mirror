Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F65C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB88922D05
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgLPA2B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 19:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgLPA2A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 19:28:00 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A60C0613D3
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 16:27:19 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id e2so16368058pgi.5
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 16:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=5/eu1yZYS3yLZ5sG5z+wYNTD6gE/jRn7p2hlSmZIAxI=;
        b=Az5oA7W8Qbh4akzUAnBxsvV4c+h++Euk6D7rpyGHT+EUJik0CZo4sbsKLIA1u67MK5
         wlMbkE10gUU1c+XBL9q3Pthh6r0sJWR1JKZ/H+nVje0Ik8OKnuCVWTdscTWTCVCc+d1v
         gz0wimqG8xWo+juNNXts1fCLYQkXQOf+8+u6UbAhdcQqdTmlx/J/KVkKXAJ/h/e4M34c
         RkH2D5T4qhmxlS/TVCbjpwpolujxjXLb6PoXD2VcgaxiR4Ue7LXIzubq3hMUy+qlVDmm
         ZyqAHDZwhPpTDowjZR4KTcB6ievoBqnQ3E+QOJH8GRGn8oFY0QGg5DiCxr0MA+O+M7vF
         SO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=5/eu1yZYS3yLZ5sG5z+wYNTD6gE/jRn7p2hlSmZIAxI=;
        b=nJ3WL/9Lko0PoR/O2lsbJS93d+P6Q4/GQ3DmpUtFqZQtoSndof7PEB2nvETq6oHEl9
         HDT3wDPVz8WBHJNJeinkafrc3QUorTbNwNRaZ6S1OvDd3YWFE5JecEfzAy61xLvT/wXf
         MWXtfVwmgWLx/CH/Tw+1DaSEwtmHZHDhfMig3+biCknfKP6p2q1bry7htBLj5JGlCVQT
         tLNbTn3KYmCYFMV0YcqkRnlZ68sk9gcQUe9CX6R/CVKvbn7wwc0emE+mNg5EoNeArOPZ
         MDJneJ9jL8CTO67QBIeTKXqHfEpTYCT0leK5HwkLdNXD2uDvAK7Bpjj4oCw4GKQacP+q
         SKzQ==
X-Gm-Message-State: AOAM532q75GX36AlEvkPfgNi3cE4IgOvEMywNBtYeLqA7U3WyuwQssVV
        rPOJ43gpR1egME0WdYcd9Wff/g==
X-Google-Smtp-Source: ABdhPJwsBR/UUeG3TFSNclEuRvgsm9AA0mLUwS8GlH2lla9TOaQZOE0pHsdGNRZgEZhLAu7j7SSpIQ==
X-Received: by 2002:a65:534d:: with SMTP id w13mr30541627pgr.107.1608078439059;
        Tue, 15 Dec 2020 16:27:19 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
        by smtp.gmail.com with ESMTPSA id y24sm161768pfe.42.2020.12.15.16.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 16:27:17 -0800 (PST)
Date:   Tue, 15 Dec 2020 16:27:12 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 08/17] git-p4: use 'git hook' to run hooks
Message-ID: <20201216002712.GP36751@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20201205014945.1502660-1-emilyshaffer@google.com>
 <20201205014945.1502660-9-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201205014945.1502660-9-emilyshaffer@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.12.04 17:49, Emily Shaffer wrote:
> diff --git a/git-p4.py b/git-p4.py
> index 6ae5bbfe99..73161a56d9 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -208,70 +208,18 @@ def decode_path(path):
>  
>  def run_git_hook(cmd, param=[]):
>      """Execute a hook if the hook exists."""
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
> +    print('ESS: entering run_git_hook')

Looks like a stray debug message here?


> +    if not cmd:
>          return True
>  
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
> +    """args are specified with -a <arg> -a <arg> -a <arg>"""
> +    args = (['git', 'hook', 'run'] +
> +	    ["-a" + arg for arg in param] +
> +	    [cmd])
> +    print ('ESS: args:')

Here as well.


> +    print (args)
>  
> +    return subprocess.call(args) == 0
>  
>  def write_pipe(c, stdin):
>      if verbose:
> -- 
> 2.28.0.rc0.142.g3c755180ce-goog
> 
