From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 8/8] git submodule update: Have a dedicated helper for cloning
Date: Wed, 21 Oct 2015 15:14:55 -0700
Message-ID: <CAGZ79kZiwf7AeCFmeA+FyF8p92+K5ZCEDySx07g+VJ4Dg8MK1Q@mail.gmail.com>
References: <1445381030-23912-1-git-send-email-sbeller@google.com>
	<1445381030-23912-9-git-send-email-sbeller@google.com>
	<xmqqd1w8uewx.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaa6b49rDW204ydtY0cf4NugSKOm+sBHKBYYoEsVugVfw@mail.gmail.com>
	<xmqqvb9zudai.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 00:15:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zp1ez-00064e-S8
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 00:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754970AbbJUWPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 18:15:00 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:36613 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbbJUWO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 18:14:58 -0400
Received: by ykba4 with SMTP id a4so58714995ykb.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 15:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=X02w8CTCkB8jajloVQmI/w5Exu1XqLXg9D97yG0/e5s=;
        b=c9+ZFzK2oZXu5O8HXrKBvKRT8qCAee1wiJasIhtcb3ictR0h44XgTViUglkAFRbLDF
         bwxlHq2Juko3rQlc+fsA2agK+V7x3gr/W7HlVpK4coZvrOFN9x04ZllsRvY8irpZiyZh
         YjrhBThWzv1bFNQLdXc4nsNW7Mk8NrThnG2swI2QZg7bcXEPYjeu2KyCszVR5tFVJW2L
         9jxrDXMMmbk+oXt93vSp6a1oQQCJLLs/vpA51IOHbNCTN4uxNm3LPV+eJhw7MyWbedTw
         ulemA6VJlGUasklECKzV0PrGTa18NsZwu+pSUGg9E1tzxDSodXmRVkhhS+/CZxruAXIH
         Uv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=X02w8CTCkB8jajloVQmI/w5Exu1XqLXg9D97yG0/e5s=;
        b=PILu5CdYqJeOXjLc5Zl5XmyH+s5uUUjUBHJe0DN8vWCxnLspAIbITvZK1C/fJCHgKA
         D03bQmQcSeMKLXbY/pe8+h+yuvB6rdxYUPqQeZ60328sJLJURYxGzBDi7WOP2yWHCEEj
         vFyy4ua1mJE4v1FAC9pu90/3aC5eJ8sEszlIIn38nqhVbQkhjUnJdwhDQR4kUhx5ijQl
         qsndW4XfUptpaN2ACMk5aZVNFSR6JLtfckQdpalt3N4SyF69t9ABNvxF39YaFwt62klr
         N08lx4CxPz+D1zfFYBtXCi6qSfHpZBMdLlHs0IaMaSiewUp7cQOCfTmLsKo7ke3vrDkb
         taZA==
X-Gm-Message-State: ALoCoQnTc0b07vRq9SrR6eBjOjJzVrZd8bYwmM56GxHdJTppmfHkcjOK6QML7WwKqXXx67w4cvFF
X-Received: by 10.13.202.12 with SMTP id m12mr8852416ywd.63.1445465696020;
 Wed, 21 Oct 2015 15:14:56 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Wed, 21 Oct 2015 15:14:55 -0700 (PDT)
In-Reply-To: <xmqqvb9zudai.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280026>

On Wed, Oct 21, 2015 at 2:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> I'd like to counter your argument with quoting code from update_clone
>> method:
>>
>>      run_processes_parallel(1, get_next_task, start_failure,
>> task_finished, &pp);
>>
>>      if (pp.print_unmatched) {
>>          printf("#unmatched\n");
>>          return 1;
>>      }
>>
>>      for_each_string_list_item(item, &pp.projectlines) {
>>          utf8_fprintf(stdout, "%s", item->string);
>>      }
>>
>> So we do already all the cloning first, and then once we did all of that
>> we just put out all accumulated lines of text. (It was harder to come up with
>> a sufficient file name than just storing it in memory. I don't think
>> memory is an
>> issue here, only a few bytes per submodule. So even 1000 submodules would
>> consume maybe 100kB)
>
> That does not sound like a counter-argument; two bad design choices
> compensating each other's shortcomings, perhaps ;-)

I was phrasing it worse than I meant to. I should have pointed out the
positive aspect of having first all clones done and then the
local post processing in the downstream pipe afterwards.

>
>> Having a file though would allow us to continue after human
>> interaction fixed one problem.
>
> Yes.  That does sound like a better design.

I don't think the proposed patches make it worse than it already is.
Before we have the "submodule--helper list" which tells downpipe to
do all the things. Now we just take out the cloning and make it an
upfront action, eventually faster due to parallelism.

Also I think we should not promote "git submodule" and specially
its update sub-command to be the best command available. Ideally
we want to rather implement implicit submodule handling in the
other commands such as clone, pull, fetch, checkout, merge, rebase.
and by that I mean better defaults than just "don't touch the submodules,
as that's the safest thing to do now".

>
> This obviously depends on the impact to the other part of what
> cmd_update() does, but your earlier idea to investigate the
> feasibility and usefulness of updating "clone --recurse-submodules"
> does sound like a good thing to do, too.  That's an excellent point.

I investigated and I think it's a bad idea now :)
Because of the --recursive switch we would need to do more than just

    submodules_init()
    run_parallel(.. clone_and_checkout...);

but each cloned submodule would need to be inspected for recursive
submodules again and then we would need to add that to the list of
submodules to process.

I estimate this is about as much work as improving "git submodule update"
to do uncontroversial checkouts in the first parallel phase.
