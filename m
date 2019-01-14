Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 554511F62E
	for <e@80x24.org>; Mon, 14 Jan 2019 21:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfANV6I (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 16:58:08 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38731 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfANV6H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 16:58:07 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so252926pfi.5
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 13:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K4ahdT8WvvjdkNNLROQfwF89NcSJSa2RxHRT0dke7XQ=;
        b=OpkMNRndX1lYpa/igT1DVbRRO5ja3yc3WQHyK+qLPU0/7m7UlwFTWsfzj6V+DvyWUk
         2sNEdy9wEXZCYVAcP9mlqWCxs495NXHKp+P7iI40DNIMu8Ssk0MAThEfoqOvDnApnuHA
         R3GSRofhl4NPdky/9sEls9woNU+Tkmz9TPnuz0plF+Dg6ef5hGiyeSEwWPbuNSggrBAT
         m7dJTznYibM68eP5wdjDOHedn3BQNircFSqJaixUkNH7ygJsAbMMuRk3svCsU/i5syUL
         414QynLIjtFi0QBD6RtxJnMg1do3l7Qnoz0rfwXFn5GvqOonmZyxdvjaZIIFbdwgD4GX
         S3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K4ahdT8WvvjdkNNLROQfwF89NcSJSa2RxHRT0dke7XQ=;
        b=Iiz+rOdCplHtoPIMeNTyd7+vus1mgCGFBVU+jelRdDEifZq3nTAB5O5gQRAp4m9cSI
         ywoK4BzFgzSs3k/maoSuBvD0VKM673Oj7NedkXZM65PWvDhcOU+rIGUfefUWg5ZUhBLd
         VDjPwaryQkr4kOt6wnxp6k00wMWulmFQYCR8yKaZh55wyWeOVfgEncqRuYxvW08XX4s7
         rbS8gYsvIVt95pmSPmOjGljl/rzorTXb6hlJVhKJ/q13Qx7MySJr/UARtDmwtGS8s/pB
         Ew+95nQ73YT4oNCGlcg93SqrOGT7eAEPZkFgKOQ7tImwpYJdm0uDW4IClSPoFIufLCkP
         yl1Q==
X-Gm-Message-State: AJcUukcURfAWzH+I8WqEzoJOiu46KKPwB7/bCVa/t1C3FwkLjRWk8GNx
        E0sG5bL/i7horKOXIBjiWgE=
X-Google-Smtp-Source: ALg8bN7kYdt8MmlpYKGaMjp3Whj+cn/6hjlo8fQkW7BqsSLfGTHTUMFJowctTb9gayE/PfZAdmhBCA==
X-Received: by 2002:a62:c28e:: with SMTP id w14mr590594pfk.115.1547503086405;
        Mon, 14 Jan 2019 13:58:06 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id k63sm2318355pfc.76.2019.01.14.13.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 13:58:05 -0800 (PST)
Date:   Mon, 14 Jan 2019 13:58:04 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] new-workdir: Never try to recurse into submodules on the
 initial checkout.
Message-ID: <20190114215804.GE162110@google.com>
References: <20190114172702.19959-1-marcnarc@xiplink.com>
 <20190114213430.GC162110@google.com>
 <xmqqwon6ud7e.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwon6ud7e.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Marc Branchaud wrote:

>>> The new workdir is empty before the checkout, so attempts to recurse into
>>> a non-existent submodule directory fail.
>>>
>>> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
>>> ---
>>
>> Thanks for reporting.  Can you describe the error message when it fails
>> here?
[...]
> IOW, at the point in that script where we call "git checkout -f", if
> we changed it to "git checkout --recurse-submodules -f", what breaks
> and why?  Shouldn't it succeed instead?

I think that's a similar question to the one I asked.

But I have a good guess about what goes wrong.  It's related to the same
issue as the "git worktree" problem Marc described.

Inside the superproject's $GIT_DIR, we see

	config
	modules/
		a/
			config
		b/
			config
	...

The question is what to do with the modules/ directory when you have
multiple working directories making use of the refs and objects from
this $GIT_DIR.

In general, the most useful answer is that the additional working
directories should make use for modules/ from this $GIT_DIR as well.
After all, each submodule has its own refs and objects, and the same
motivation that pushes us to share the refs and objects from the
superproject would drive us to share them in the submodules as well.

However, if you do this in the most naive way, it will not work.  In
the config file, there is a core.worktree setting that ensures that
commands run from a submodule affect the correct working directory.
Which worktree should it point to?  All of them.

There's still an obvious "most useful" answer: each submodule should
contain its own worktrees/ directory with metadata specific to each
worktree.  This should work fine and is the future work that Marc and
I alluded to.  Let me call it (*), for later reference.

Anything done today is papering over the sad truth that that future
work (*) has not been done yet.

contrib/workdir is currently naive about all this: it does *not*
symlink across the modules/ directory, so each workdir gets its own
independent copy of all the submodules.  Which kind of defeats the
point of this kind of setup.

That said, it's better than nothing at all, which is why Marc proposes
making it not attempt to check out the submodules right away, instead
permitting the user to make the best of things.  I suppose another
thing that is missing is a warning message to ensure the user knows
that once (*) arrives, they need to be ready for it.  (Or not: this is
contrib/workdir, and there would be no need to make use of it in place
of "git worktree" once that moment arrives.)

To reiterate, this is all about papering over (*) not having been
done.

Marc, did I understand correctly?

Thanks,
Jonathan
