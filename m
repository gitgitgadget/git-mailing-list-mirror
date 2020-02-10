Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C42BC35254
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 19:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041782080C
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 19:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJFiWVyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBJTDL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:03:11 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34447 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgBJTDL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 14:03:11 -0500
Received: by mail-qt1-f194.google.com with SMTP id h12so6001727qtu.1
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 11:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CQHz0XbOjNmt+mb55mfXhPvYEk7D6DykEvUd845E8Ek=;
        b=cJFiWVykeDBhFXpFmOYFau6XuXVdiP97CBEl3PeHej365P/370mm/X8OcutzD8xjWS
         mYx+CjF4/X1040ZxPHUkqyN0fPZVnVh0WnmVvgs5xPUXBGKqaey8tEpTsx13GDyyMgBJ
         wTE2I39WNo0fJXX0XmQRCODpYTbJ33E+1YOs8SY0J0tGxlMxruEXmmcKA+mm/rBJa9qM
         t1LirdhzPD+d4Bezm9fW+8s0BmLIMpqlcnvWbV/BKT28WEvgVeJdVWUeqinQmCgt7srh
         vYfDfnewaecu4KsRb8WBULqXp2OXyb5CLb4QE5wNivcKGkncBLfsES+Ol9EtuGmitnls
         a2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CQHz0XbOjNmt+mb55mfXhPvYEk7D6DykEvUd845E8Ek=;
        b=bfVhqvmQijDW6MNpn3LfQamked3fN5DWzz7mfTFs2vp7ZkX79K9kg6PaZUpaFkfRBi
         PgrZlm0860NaeHwgjU1AfH2KxLhGAyzsRy+v47uCJ61YXWyDePI0MMg/RSdYY+e9LED6
         RYnsZ/QyKjilYgp63UfS2fVnkt5EjlQANhi/mot9I+PJBSnXtaEkqxvdIKi0poDtPgib
         hZw1iNfl0mZwqHmmpMwpmU53edINpMwlEbbNHJo9FGCMqGfE5q+w6v4vURRwHRqJRkIo
         TDamsZpLpl5skDKadyh5ZNx2I045MZlHwt/v3B7lRzLxaZneJ0r76G+meqJDeRlXCWSp
         xk7A==
X-Gm-Message-State: APjAAAXGGXRnG357wMKUjundIs3kLDkZVt2cna/rkrqqd9lIwKGntVxy
        +oy2gFBbWxwwmprj8OdETo5zIzpiYj0=
X-Google-Smtp-Source: APXvYqxD07YiMJCcHtGSbp72Bojzu99wUiXLr4fVT5RYfJuUss3EC5fJL3/2Q1f65+VNOw2WdJj+RQ==
X-Received: by 2002:aed:3302:: with SMTP id u2mr10912314qtd.156.1581361389598;
        Mon, 10 Feb 2020 11:03:09 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id x22sm623038qtq.30.2020.02.10.11.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 11:03:09 -0800 (PST)
Subject: Re: [PATCH v3 2/5] git-p4: create new function run_git_hook
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
 <pull.698.v3.git.git.1581002149.gitgitgadget@gmail.com>
 <85918a7edb6482cc1c555917075f8cfd2f18ba32.1581002149.git.gitgitgadget@gmail.com>
 <xmqqo8ubec4n.fsf@gitster-ct.c.googlers.com>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <2ab5f3cf-51f4-21d9-5741-0ec53f3035dd@gmail.com>
Date:   Mon, 10 Feb 2020 14:03:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <xmqqo8ubec4n.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2/6/2020 2:42 PM, Junio C Hamano wrote:
> "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +def run_git_hook(cmd, param=[]):
>> +    """Execute a hook if the hook exists."""
>> +    if verbose:
>> +        sys.stderr.write("Looking for hook: %s\n" % cmd)
>> +        sys.stderr.flush()
>> +
>> +    hooks_path = gitConfig("core.hooksPath")
>> +    if len(hooks_path) <= 0:
>> +        hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
> Using the .get() with default is misleading, I think (see an earlier reply).
Looking back through the original discussion, I see that it was decided that
the application uses "rev-parse --git-dir" and "rev-parse --show-cdup" 
to find
the top directory of the git repo. At least for testing, being able to 
resolve
the .git directory directly is useful.  I will modify the code to throw an
exception if neither GIT_DIR or .git resolve correctly.
>
>> +    if not isinstance(param, list):
>> +        param=[param]
>> +
>> +    # resolve hook file name, OS depdenent
>> +    hook_file = os.path.join(hooks_path, cmd)
>> +    if platform.system() == 'Windows':
>> +        if not os.path.isfile(hook_file):
>> +            # look for the file with an extension
>> +            files = glob.glob(hook_file + ".*")
>> +            if not files:
>> +                return True
>> +            files.sort()
>> +            hook_file = files[0]
>> +
>> +    if not os.path.isfile(hook_file) or not os.access(hook_file, os.X_OK):
>> +        return True
>> +
>> +    return run_hook_command(hook_file, param) == 0
>> +
>> +def run_hook_command(cmd, param):
>> +    """Executes a git hook command
>> +       cmd = the command line file to be executed. This can be
>> +       a file that is run by OS association.
>> +
>> +       param = a list of parameters to pass to the cmd command
>> +
>> +       On windows, the extension is checked to see if it should
>> +       be run with the Git for Windows Bash shell.  If there
>> +       is no file extension, the file is deemed a bash shell
>> +       and will be handed off to sh.exe. Otherwise, Windows
>> +       will be called with the shell to handle the file assocation.
>> +
>> +       For non Windows operating systems, the file is called
>> +       as an executable.
>> +    """
>> +    cli = [cmd] + param
>> +    use_shell = False
>> +    if platform.system() == 'Windows':
>> +        (root,ext) = os.path.splitext(cmd)
>> +        if ext == "":
>> +            exe_path = os.environ.get("EXEPATH")
>> +            if exe_path is None:
>> +                exe_path = ""
>> +            else:
>> +                exe_path = os.path.join(exe_path, "bin")
>> +            cli = [os.path.join(exe_path, "SH.EXE")] + cli
>> +        else:
>> +            use_shell = True
> Please ask somebody familiar with Windows to review this "if
> Windows" and the other one in run_git_hook().
>
>> +    return subprocess.call(cli, shell=use_shell)
>> +
>> +
>>   def write_pipe(c, stdin):
>>       if verbose:
>>           sys.stderr.write('Writing pipe: %s\n' % str(c))
>> @@ -4125,7 +4187,6 @@ def printUsage(commands):
>>       "unshelve" : P4Unshelve,
>>   }
>>   
>> -
>>   def main():
>>       if len(sys.argv[1:]) == 0:
>>           printUsage(commands.keys())
