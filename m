Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA67B208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 00:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbeHHCm6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 22:42:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36255 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeHHCm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 22:42:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9-v6so409453wro.3
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 17:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lr0bLmsTKkBCZgSK5gJEqAV6Fl/bMhzVBYxGuIt4GRM=;
        b=JNqGi56l6hDgsd0eKWRFp6HBzUmkvQattugUUTn3PAkk1X+EZz5GALHOhD82v7nHrx
         U5BJfBG5+XS2BM/g7SOPDm1x1AOYOm+Rn/YFyJopbuUYHgafgEQHvVrk/MBiXMJECmtF
         X1ZS8SGtaEIUx6yCBWTY3vPS3tMWseVrBeFhONl7+AIOrnf52nKjvdYPpJaOffw+urhy
         37vp1V7XUtca7UJJnJmZmvEMtxtgffaWfJT9AZ60Kd6FkGe60ptp7ECUDpe2cNopbroU
         94OQaWv25s+rBqLSKSkRRdPPyep64xUERUpWbWjWkvT1t2F8Pekc+3HgeREGgGZ1GZOY
         vgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lr0bLmsTKkBCZgSK5gJEqAV6Fl/bMhzVBYxGuIt4GRM=;
        b=cF//8/kPFCHNIvErAQW4uJgjadBNiMdSuf0Ae1BPHR53to11nM1VKrWWxoxB/pMpWv
         4kDsN2/LRH8z5iy7VoK9HhEnvlOAQN7/Z0mRzuaWGah2vtsxPGLLq9lRttokEkzdwfzi
         Dsrz4iIEDT2xsqk32c7Hj85TCRga2jrnjnR9zdeytdaH6JvIQm2/LbUbkEwvEmroJ4ih
         JKi6hwqStHr7zbRgTGAp0vh/LQkXtVBwMcsuPdPCJx6uxVC5n5Sw/RnbVTi963jo+gU1
         zErFDpV9lIRGZCZPHqgZf60xkviMOpHmo8zxPdwQpE77d+W+JyzHuZIyoIyfrUSkkJjE
         cK3Q==
X-Gm-Message-State: AOUpUlE0m4Pi+WYEimn/VCBAraZlwSmLTgKY9uqHS4YR7I3iyGlc+vGg
        wSPzguoCX7HmcQysIL2Togw=
X-Google-Smtp-Source: AA+uWPym5yANUELipeGkBVXeQ+Ji6wyfXFAdKH9IkBMutWY0TEPxgRZ8ygyFyHeh/M9y4rNkwiEDqg==
X-Received: by 2002:a5d:6b01:: with SMTP id v1-v6mr342633wrw.208.1533687960241;
        Tue, 07 Aug 2018 17:26:00 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p11-v6sm1867732wrs.51.2018.08.07.17.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 17:25:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] repack: repack promisor objects if -a or -A is set
References: <xmqqzhxxki84.fsf@gitster-ct.c.googlers.com>
        <20180807232304.181764-1-jonathantanmy@google.com>
Date:   Tue, 07 Aug 2018 17:25:59 -0700
In-Reply-To: <20180807232304.181764-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 7 Aug 2018 16:23:04 -0700")
Message-ID: <xmqqy3dhiu08.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> each other [*1*], so listing them in the offset order (with made-up
>> pathname information to _force_ that objects that live close
>> together in the original pack are grouped together by getting
>> similar names) might give us a better than horrible deltification.
>> I dunno.
>
> Before I write the NEEDSWORK comment, just to clarify - do you mean
> better than horrible object locality? I think deltification still occurs
> because pack-objects sorts the input when doing the windowed
> deltification, for example:

But what to delta against what else is determined by the pathname
info, which is now lost by enumerating objects without tree/history
walking.  By giving phoney pathnames to objects while enumerating
them in offset order and giving similar pathnames to objects closer
to each other, I was hoping that better bases will likely to be in
the same window.  The order in which objects are prepared and fed to
try_delta() is "group by type, and then sort by path-hash (major
key) and size (descending order, used as minor key)", so that
the largest among similarly named blobs is stored as base and other
blobs with similar name try to become delta against that one.

>   git rev-parse HEAD:fetch-pack.c HEAD HEAD^ HEAD^^ \
> 	HEAD^^^ v2.17.0:fetch-pack.c | git pack-objects --window=2 abc
>
> produces a packfile with a delta, as checked by `verify-pack -v`.

Is that interesting?  You can make the same argument that
fast-import produces a packfile with a delta.

It is known to produce horrible delta---its delta base selection
essentially is "you are giving me a new object?  let me see if it
deltas well with the object you gave me immediately before that (and
nothing else)".

