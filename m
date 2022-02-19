Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79531C433F5
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 04:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241321AbiBSE55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 23:57:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiBSE5z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 23:57:55 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9513A56744
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 20:57:37 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id vz16so19665291ejb.0
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 20:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=w7jM20jfCk4OraZqbk0bKd72IwrOne9tJgWSH2f4nXo=;
        b=hC6GM1On1zs6Zuvln4Nb+J+GVaAQjK2fVDiarDv+gobvDDX0RAWmzl79LC9GNy1DlW
         3+tyrrtogdM6szw86fq2iaK+ArnNJbt2SmYEtKX1yNFPK/d0RyF7czgeJp5MkkXYfO7e
         OeoTeKphN1tAQ9tVPhjpN0GEHEMEdrmdo6NeQpaHC4u6eGROcHtl3HQ8YIE6ykJ9hHb6
         s7u+aIA6rqPw1GEy1J7EkYjgdhRsj5VGmxdySsDb2ywx3SOq3iGx/6BWolNQplCPg0Ff
         VDvO79ATzPjOW8y0TZW5gXGQxYFcNy5CcRGcnQivJmH2Tb8xMG+VMiyNg+Q1iwKNps1d
         cOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=w7jM20jfCk4OraZqbk0bKd72IwrOne9tJgWSH2f4nXo=;
        b=f7HrRZn0AdJTtZTaZ9++CKpBIUDEsYsazi6D4Cj4ahc+9xJJCkIrhfbN3wRvM7Aa0s
         rE9Rdc4QUcICrf7KkFGGy9CnlBuO+VyuoqIX1KbWV+AH7SV7bi7JVwxB6UKbFu01sgLc
         MGuxgrR6uHoMoZoTp9jap+1M2+Wn8beydgQ8Bfzs9VCFp0fpvi7U4192w38Z7y5CGFOi
         HTHg1Lu6sX+TP6ognHCUUbcHSQCjuyJ2X9Nz5fNoX4zjxie384IA5rqfvPQwCJBCSn57
         YXTIUgSF9Qw/2H1Yc2Fex1V6tGLjyIJYdCRPRYABGD8RVZYLwiIprRT9s3AgSt5bfUKD
         9hZA==
X-Gm-Message-State: AOAM531QVNUcwX3q1eXpg3PcIkF5KK1E+xIzw/R/q21NX/J8Im5nNMEy
        /ZxWhYWHR88FesZ+Q0PrOSmZwggYyAcWDQ==
X-Google-Smtp-Source: ABdhPJwUw3rJp/cHxiU3lHv1u+78PHcKs+qvZujbqgt/Y5dtbdA0Fe6SA625/DhgkEImXAyHry89wQ==
X-Received: by 2002:a17:907:98a8:b0:6d0:e8ad:a801 with SMTP id ju8-20020a17090798a800b006d0e8ada801mr2245734ejc.433.1645246655820;
        Fri, 18 Feb 2022 20:57:35 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 23sm2834063ejf.215.2022.02.18.20.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 20:57:35 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nLHoM-004l85-QF;
        Sat, 19 Feb 2022 05:57:34 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 2/2] hooks: fix a TOCTOU in "did we run a hook?" heuristic
Date:   Sat, 19 Feb 2022 05:48:42 +0100
References: <cover-0.2-00000000000-20220218T203834Z-avarab@gmail.com>
 <patch-2.2-d01d088073b-20220218T203834Z-avarab@gmail.com>
 <xmqq4k4vyata.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq4k4vyata.fsf@gitster.g>
Message-ID: <220219.864k4vfo75.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 18 2022, Junio C Hamano wrote:

>> -int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
>> +int run_commit_hook(int editor_is_used, const char *index_file,
>> +		    int *invoked_hook, const char *name, ...);
>>  
>
> Even though my gut feeling tells me that turning the "yes/no"
> integer into an enum that includes "there was no such hook", "I
> tried to run it, but it failed to run" [*], "I ran it and it was
> happy".  would be a more viable approach for the longer term, I
> guess this extra and ad-hoc parameter would be sufficient as a
> shorter term improvement.
>
>     Side note: optionally "failed to run" may be split into "failed
>     to even start (e.g. ENOEXEC)" and "started successfully but
>     exited with non-zero status".  There may or may not be callers
>     that wants to see them as distinct cases right now, but an
>     interface based on returned enum value would be easier to extend
>     than having to add a pointer to return variable every time we
>     need to know more details.

Yes, I debated with myself whether I should add some more generic
interface to it, and decided just to do the bare minumum of adding
something the "struct run_hooks_opt".

FWIW the "yes/no" is not that, run_commit_hook() just returns the value
of run_hooks_opt(), which is currently either an <0 error, or the status
code from the hook. I.e. what gets passed to the "task_finished_fn"
callback for run_processes_parallel_tr2(). I.e. the finish_command()
return value.

We do cover the "ENOEXEC" case in ignoring it, since if we fail on
startup we won't say we ran the hook.

I think in practice what'll matter is this "invoked_hook". I.e. if we
failed to parse our config, the hook wasn't executable or whatever
that's just a <0 error, and we didn't run the hook.

Or, if we ran it at all (even if it failed) we'll know that we need to
e.g. discard_index(), since we can't guarantee that the hook didn't get
that far that we'll need to update our own assumptions.

A caller who ares about anything else will also need to deal with a lot
more complexity once we have config-based-hooks / parallel hooks by
default. I.e. was that ENOEXEC one of N hooks, all of them, did all/one
exit non-zero etc?

Whereas "int *invoked_hook" we can just set as long as we invoked any of
them at all.
