Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96FB7207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 01:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S979903AbdDYB6p (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 21:58:45 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35358 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936149AbdDYB6n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 21:58:43 -0400
Received: by mail-pf0-f193.google.com with SMTP id a188so7183454pfa.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 18:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=U87AoEYE4s+OMYBODZljdGERbcapfVf7p2qY99RhnhQ=;
        b=pPevlZCfhxCfhlGzeavrQRn5z4uQqcxaDOjzRbVyUaz851VJiC1awqGB9AQpqLX4fM
         pMxHchZ+iKTXWVXzVFakFv3mRWBMjG3T0ELiYx8R4Z/pXshEONxElBQ5eW3M19N4MM5w
         iVrsChnK4nCFHIu/DR31codI8h+dQz3WpQgZxc1Zj9VtJYfmqStLFm9N2HxXMVl9B93k
         yFnD2cHt44fb7wJ9p3rIXf6WyHNZiQbP5mCjz0a/q3+UUXG9RSkXMidMkpgtHxLSSTtm
         wAWMSUfSadQwsG0HmmZyAl8GaOq+OUNjqtkXhF80qG6wBu5eiYbYvbyWwgcC+gHippKL
         Tieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=U87AoEYE4s+OMYBODZljdGERbcapfVf7p2qY99RhnhQ=;
        b=g2BcvoEy2NzPjJkQXH1kUfyR/M7b4QTwtutVq+Wwwz9IDPezh4UtQ90echnL0O1fA3
         xrixMIqESwMm9sMBJ1C6SdHnz+kXiWJhZpoB5fqJrfvySqPDTnuTN1zBal1vqf9Mr9Z/
         yL7rf2s3u7qi5EglFPzjIwO300VoLxejw1aeuGMfIeaIA5rWs+shkao3PBfThHuLrvRG
         l6gm3ZMp1X87abGMlKOPgCxylCByGZVzeyrzIrOzJme0uV0wa4TYJiLHIOxfE+54WVsO
         gdIdLF08lJKVjWtLhchG1RaQcz16+x13PW4aRsWXFyAtOQtqVMQdJTJU3th1YSkiHkrB
         99NA==
X-Gm-Message-State: AN3rC/6BFKzfD+iupwmEP4FLLNVWGnpehzN0Iv9TMuSEHuGIjJGHM9cj
        icKnUwHUy4OnPeXrWH4=
X-Received: by 10.84.204.8 with SMTP id a8mr35474025ple.4.1493085523060;
        Mon, 24 Apr 2017 18:58:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:894:a17f:b6e3:25e8])
        by smtp.gmail.com with ESMTPSA id z24sm27108013pgc.50.2017.04.24.18.58.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 18:58:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        j6t@kdbg.org, sbeller@google.com, e@80x24.org, peff@peff.net
Subject: Re: [PATCH v6 12/11] run-command: don't try to execute directories
References: <20170424223752.GB105623@google.com>
        <20170424235042.26627-1-bmwill@google.com>
        <20170425001724.GG28740@aiede.svl.corp.google.com>
Date:   Mon, 24 Apr 2017 18:58:41 -0700
In-Reply-To: <20170425001724.GG28740@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Mon, 24 Apr 2017 17:17:24 -0700")
Message-ID: <xmqqr30hxn72.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Until we switched from using execvp to execve, the symptom was very
> subtle: it only affected the error message when a program could not be
> found, instead of affecting functionality more substantially.

Hmph, what if you had bin/ssh/ directory and bin2/ssh executable and
had bin:bin2 listed in this order in your $PATH?  Without this change
you'll get an error and that's the end of it.  With this change,
you'd be able to execute bin2/ssh executable, no?  So I am not sure
if I agree with the "this is just an error message subtlety".

What does execvp() do when bin/ssh/ directory, bin2/ssh
non-executable regular file, and bin3/ssh executable file exist and
you have bin:bin2:bin3 on your $PATH?  That is what locate_in_PATH()
should emulate, I would think.

>> +		if (!stat(buf.buf, &st) && S_ISREG(st.st_mode))
>>  			return strbuf_detach(&buf, NULL);
>
> Should this share code with help.c's is_executable()?
>
> I suppose not, since that would have trouble finding scripts without
> the executable bit set.
>
> I was momentarily nervous about what happens if this gets run on
> Windows. This is just looking for a file's existence, not
> executability, so it should be fine.

When we are looking for "ssh" with locate_in_PATH(), shouldn't we
look for "ssh.exe" on Windows, though?
