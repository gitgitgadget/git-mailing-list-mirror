Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EE332018A
	for <e@80x24.org>; Mon, 27 Jun 2016 16:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbcF0QtJ (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 12:49:09 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:35461 "EHLO
	mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbcF0QtH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 12:49:07 -0400
Received: by mail-it0-f46.google.com with SMTP id g127so69383350ith.0
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 09:49:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=virdVk5OM8zsj8SW0J/WvmjqQ5WMhXKrjCUuK9qYOqQ=;
        b=iOMv+2ASGMwdUtz6muyQHBjY9qee8YSoEIDsKHwWE3cwyYEFGU2CncQ9vGa/aRB9Jf
         S0qQXAmp8bS/aD5ebp0Z01W5S++7QeF5l1GzFE9FZMrpV491uZYQcZNco4TxjweTlK4m
         Je/zcxlYiIPizNKvvpqh4NNV8yi+zWClKQphQ6wcCKFxArH7EIfiiNHwNplIEF5Dc9E8
         3hCqk6a4ZHuAIoX19XIAnKT4l1DDOqK+P8uYFQ6JioLWIizdbcoxc112Y9XUInmQKiy0
         FYmcqtfRb+QBR6vQ0vuJ/FFPgQYNZ4a8E4XBAR1vDLq96wsp8hmauqUb/k4cTjC9rmki
         InLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=virdVk5OM8zsj8SW0J/WvmjqQ5WMhXKrjCUuK9qYOqQ=;
        b=WIpWWy73ZgHM4egNMDXOp6divItgE3m3QpDXAzjWCygGQ4s2kUWfpXx62YMq07yNPb
         lbItrOh4S1aAjY5Dm1890C/tKZ8GN2/aiLcJ/f+gYKO+NAtDf+AApjEg0sXLSqo7IfMe
         7H1h6RdbpUCcxc9Zb/yyqB2Z6kI0KVLMrjnzRY8wbXmt3gns3w0TxjVXv4iYWI8d4P4c
         Zj/0YgdtBwygUD7rnoCDhxa88alsSm66uwwu0XoxxzrtMxZGuI7fJsOwQeDoLHFBQ4Rs
         2nizaukvrS6Bh9pGjAAs3KXEHLItLSDyA5Z6USoJozpMosudx8GI4Tux/sLC/WYw81i2
         TMzQ==
X-Gm-Message-State: ALyK8tLuOBvqM0COt2ndA/F3Ak0+JwBREMpL9wD9ApCZJUkjwL63dpnLrDako85J74/Wxw8BMDRIxYJJO5m5HMJ7
X-Received: by 10.36.29.81 with SMTP id 78mr9176014itj.97.1467046146636; Mon,
 27 Jun 2016 09:49:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Mon, 27 Jun 2016 09:49:06 -0700 (PDT)
In-Reply-To: <20160627143648.GA2618@sigill.intra.peff.net>
References: <20160626232112.721-1-e@80x24.org> <20160626232112.721-2-e@80x24.org>
 <20160626234251.GA21668@sigill.intra.peff.net> <xmqqoa6mdbu3.fsf@gitster.mtv.corp.google.com>
 <20160627143648.GA2618@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 27 Jun 2016 09:49:06 -0700
Message-ID: <CAGZ79kZ94PaOfq3GimWiHULbTE7ihMzL9S=Y+npQ4F5gGwFrsA@mail.gmail.com>
Subject: Re: [PATCH 1/2] xread: retry after poll on EAGAIN/EWOULDBLOCK
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 7:36 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 27, 2016 at 06:02:12AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > I also wondered how we managed to miss such an obvious point in review
>> > of the original patch. Sadly, we _did_ notice it[1] but it looks like we
>> > never fixed the problem. That is even more disturbing.
>>
>> Yes indeed.
>>
>> I try to pay attention to "this is broken because..."  comments in
>> discussions to make a note in my copy of "What's cooking" report for
>> a problematic topic, as that is where I work from when merging
>> topics down, but apparently that procedure failed work in this case.
>> There needs a stronger mechanism to stop a known-buggy patch from
>> going thru, but I am not sure offhand what that should be.
>
> I was the one who saw the bug. I could have followed the series more
> closely to make sure my concern was addressed. Or possibly pointed out
> the bug more prominently than an in a "PS" as part of the discussion.

I thought I would have fixed that bug, but apparently I did not.
(I agreed on the bug being there at the time of discussion [1], so I
guess I can be
blamed most for this failure)

[1] http://thread.gmane.org/gmane.comp.version-control.git/282514/focus=282694

>
> I think part of the problem was that this particular series was
> large-ish and involved a lot of re-rolls, and I got sick of looking at
> it. I dunno.

I haven't send patches to git for quite a while now, but writing smaller patches
is the way to go for me. (I am currently looking at the repo tool,
that has no test
suite, so there too I try to make very small patches.)

>
> It's also true that our error rate will never be 0%. So some bugs will
> always slip through, some review comments will be forgotten, etc. Eric
> did find and fix the bug just now, so the "many eyes" theory did work
> here eventually.

Eric, thanks for catching and fixing the bug!

Quite a while ago, when I started doing code reviews professionally, I wondered
if the code review procedure can be semi-automated, as automation helps keeping
the error rate low. By that I mean having a check list which I can
check off each point
for each patch. That seems to be very good in theory, but when trying
it I was finding
myself doing a lot of unneeded work as some points of such a check
list just do not
apply for a specific patch. So I did not follow through with that.

Thanks,
Stefan
