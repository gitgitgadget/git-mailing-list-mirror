Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ED32207E4
	for <e@80x24.org>; Wed, 26 Apr 2017 01:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1434423AbdDZBot (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 21:44:49 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34319 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S948356AbdDZBor (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 21:44:47 -0400
Received: by mail-pg0-f68.google.com with SMTP id t7so10831102pgt.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 18:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VY8nM+E0IXVHjYCodo4esYjudQG6IhINGnKMK6tYf5Q=;
        b=lfcg85csZdRZe44WjL7odF1NDmMKH8Mf1P9oPRKDc1vxQe/Wfqcp4T455f8eHSJweq
         ihsNAvJvShGY/8czUkxeqGumsZLCzeg0/JdlKoJ/bnoHLJtJ2f0kzjLYtvVxdMsVI/bN
         A2V1cchOXxVHt2upTwTbQL+B/xB2lIwWKtRBpWkFviMWeeGSMR/Ps/ZwP/iKjlKTm7DO
         VdPgVcSH84G9A9uUb/YNQKevTHiAhJpZy3Fk94aUgZd45MocZvW4eSkmP3G/u8TGlS3b
         AwEdaCLav1YXrBCapwpuZ/0pojBL9Jmb+ic/+3pwrn7ISzisV/RG3ifuZx0Cg/LAuXbV
         a3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VY8nM+E0IXVHjYCodo4esYjudQG6IhINGnKMK6tYf5Q=;
        b=j5VscdwkhYec1s5gOFqufOtlqA3w3Hz2eOdkT5VXwcqbYXeZqwlcithyjxbNoONBi+
         fKeBZwAf6i4t4m8LSO8nnn9sqEfM21T7+CFzmNwI1vlGOFq9CLDyKdsbpe1fDpAJn9+K
         HIAtmukAhO+xqTowdTYDAhIhpYHZbn8bLMInqXkFu/mag/zlnE7bAojspSFLqsCe5aeR
         H20Xm+hyeWISAYybwBfDc/V6255cPRa5UZqWxz1gedDnj7j7aW7ax8bBdYDLVfv8KnBN
         bwINUUhbsjhoB/AYkCwx/I6VhYZymq6e6UkmQmunSwcbxKl9IpUlxZdHl9HFedvOirNh
         nhPw==
X-Gm-Message-State: AN3rC/6xg9H/yCaGdOTnkSlGnmfOq1AsF2SIoU7FfIAVn/gynxtlL5ek
        5F5r/f8UpmYptw==
X-Received: by 10.99.96.204 with SMTP id u195mr29776638pgb.29.1493171086273;
        Tue, 25 Apr 2017 18:44:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3179:d004:20b:b383])
        by smtp.gmail.com with ESMTPSA id p7sm21428771pfb.125.2017.04.25.18.44.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 18:44:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, j6t@kdbg.org, sbeller@google.com, e@80x24.org,
        jrnieder@gmail.com, peff@peff.net
Subject: Re: [PATCH v8 2/2] run-command: restrict PATH search to executable files
References: <20170425175446.113553-1-bmwill@google.com>
        <20170425234700.194277-1-bmwill@google.com>
        <20170425234700.194277-2-bmwill@google.com>
Date:   Tue, 25 Apr 2017 18:44:44 -0700
In-Reply-To: <20170425234700.194277-2-bmwill@google.com> (Brandon Williams's
        message of "Tue, 25 Apr 2017 16:47:00 -0700")
Message-ID: <xmqqzif4t01f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> In some situations run-command will incorrectly try (and fail) to
> execute a directory instead of an executable file.  This was observed by
> having a directory called "ssh" in $PATH before the real ssh and trying
> to use ssh protoccol, reslting in the following:
>
> 	$ git ls-remote ssh://url
> 	fatal: cannot exec 'ssh': Permission denied
>
> It ends up being worse and run-command will even try to execute a
> non-executable file if it preceeds the executable version of a file on
> the PATH.  For example, if PATH=~/bin1:~/bin2:~/bin3 and there exists a
> directory 'git-hello' in 'bin1', a non-executable file 'git-hello' in
> bin2 and an executable file 'git-hello' (which prints "Hello World!") in
> bin3 the following will occur:
>
> 	$ git hello
> 	fatal: cannot exec 'git-hello': Permission denied
>
> This is due to only checking 'access()' when locating an executable in
> PATH, which doesn't distinguish between files and directories.  Instead
> use 'is_executable()' which check that the path is to a regular,
> executable file.  Now run-command won't try to execute the directory or
> non-executable file 'git-hello':
>
> 	$ git hello
> 	Hello World!

Could you add a line after this example, that says something like
"which matches what execvp() would have done with a request to
execute git-hello with such a $PATH."

That is because it can be argued that bin1/git-hello should be found
and get complaint "not an executable file", or that bin1/git-hello
should be skipped but bin2/git-hello should be found and get
complaint "not an executable file", both to help the user diagnose
and fix the broken $PATH (or director contents).  It is the easiest
to justify why we chose this other definition to skip both git-hello
in bin1 and bin2 if that is an established existing practice---we
can say "sure, what you propose also may make sense, but we match
what execvp(3) does".

The patch text looks good.

Thanks.
