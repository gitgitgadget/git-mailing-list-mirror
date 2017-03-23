Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54EC920958
	for <e@80x24.org>; Thu, 23 Mar 2017 23:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756605AbdCWXEf (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 19:04:35 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35215 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756526AbdCWXEd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 19:04:33 -0400
Received: by mail-pf0-f169.google.com with SMTP id 20so63740194pfk.2
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 16:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vzR8NNMJE+4g1YH6QNTXCQiQi8quF6+naaj06iuUH8Q=;
        b=NBxw4dXm+a1gpXfIlw+3tQaEzEnNS0+jG0MXS3Qmjp8kTKnFjrX5ARaoeK7LabfPZ1
         IXjMUxrD+unk+XnuUPvkybgLXXkVIGPtWFDjFHQrJbY7XF5zsm5iwxTLf05XMYj/hrVg
         kwLNp1Ca7PB+qD5BPNUxd7WFKneb6HiRL8tx8SEyFB4EMRtNSCAxXgsl6eVTDq5Bz5qL
         E71cCjLbDoP+wVwfaNzsJ1hMr7wyjDpBx7XE29RKtJetr3qa6yXA2Y6QwEVhZP2jc9Y6
         3f3/U86V02PBm1R1dL7RlIGOg/6a6CbUUgfGvqvZTsUhLPilvEYuP1F+SHunPYCqKTPw
         fy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vzR8NNMJE+4g1YH6QNTXCQiQi8quF6+naaj06iuUH8Q=;
        b=sOYqMsfxR8F3IGG4SkBDotYG03G6D3ZTcUrdj9zgE5tu+99/+T5shiFPMchqqesMC4
         kA8Bjf4yy81br+7jaDUIXe9lGbhpPD+90l9nywC83Uaxtqcc/SP/Zp3STDw9Xy/f5Euo
         g9CV0C/lCtydqHu7pmmld0gigMuI+YGhDHm+4nssoIPkT6FmyxuT+svWoKwpKiDufOrU
         nhP5HSTHkD9cxuChAi9TrFkdX1TDy48e9O6/kLWLoQs2BG6JsJHdeG5bPiGDsCroHA1f
         A4ulBbpsrL56K5gQ+k8adhr0VY0z/FlWpm0qqEKwndG297QIDrUefLfy9PehfJGhDCWI
         xNsA==
X-Gm-Message-State: AFeK/H3FITLtu/m/qn1s2M6R/e+hmAOS2S6Xd1iXKYBLcSDQ9MKSbP5HU1dFOf6CCS9KJoN8FsL8HY5l7bmkyN/Y
X-Received: by 10.84.136.34 with SMTP id 31mr6722124plk.52.1490310256813; Thu,
 23 Mar 2017 16:04:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Thu, 23 Mar 2017 16:04:16 -0700 (PDT)
In-Reply-To: <20170323225019.GD20794@aiede.mtv.corp.google.com>
References: <CAGZ79kZP6JhgcFQ5+Ytc6LexpA7C4EwR-7C0QZkiWhfrRCpd6g@mail.gmail.com>
 <20170323223338.32274-1-sbeller@google.com> <20170323223338.32274-3-sbeller@google.com>
 <20170323225019.GD20794@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 23 Mar 2017 16:04:16 -0700
Message-ID: <CAGZ79kYPdGVBUnTgGyiBB5ApC9eS14p7n1QjEWApSrmF38t9Rw@mail.gmail.com>
Subject: Re: [PATCH 2/7] submodule.c: convert is_submodule_modified to use strbuf_getwholeline_fd
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 3:50 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Stefan Beller wrote:
>
>> Instead of implementing line reading yet again, make use of our beautiful
>> library functions.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  submodule.c | 14 ++------------
>>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> This changes buffering behavior in two ways:
>
> - by using strbuf_getwholeline_fd instead of strbuf_read, we avoid
>   having to allocate memory for the entire child process output at
>   once.  That is, we limit maximum memory usage (good).
>
> - by using strbuf_getwholeline_fd instead of strbuf_read, we xread
>   one byte at a time instead of larger chunks.  That means more
>   overhead due to context switches (bad).

Thanks for careful reading!

>
> Some callers of getwholeline_fd need the one-byte-at-a-time thing to
> avoid waiting too long for input, and in some cases the alternative is
> deadlock.  We know this caller doesn't fall into that category because
> it was doing fine slurping the entire file at once.  As the
> getwholeline_fd API doc comment explains:
>
>  * It reads one character at a time, so it is very slow.  Do not
>  * use it unless you need the correct position in the file
>  * descriptor.
>
> Can this caller use xfdopen and strbuf_getwholeline instead to get
> back the benefit of buffering (i.e., something like the below)?

The code below makes sense to me.

>
> Another consequence of switching to streaming is that we may close
> before the child finishes.

We could have had closing before the child finished before as well:
* the first read happens with strbuf_read(&buf, cp.out, 1024);
* it contains a line indicating a modified file
* The condition breaks out of while:
        if (ignore_untracked ||
            (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED))
                break;
* after the while loop we have the close();
* but we only had one read, which is not the complete output of the child.

>  Do we have to worry about handling SIGPIPE
> in the child?  I haven't checked how this handles that --- a test
> might be useful.

This patch doesn't make it worse in that respect.

Thanks,
Stefan
