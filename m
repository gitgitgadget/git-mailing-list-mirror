From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 03/10] run-command: add an asynchronous parallel child processor
Date: Fri, 18 Sep 2015 09:36:30 -0700
Message-ID: <CAGZ79kZd8nZoj3Rk+ZeSfCxhH0vqp4Oaoh2+MYvFa98rzfaNxw@mail.gmail.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
	<1442453948-9885-4-git-send-email-sbeller@google.com>
	<xmqqbnd0iuv6.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbgBOkiii6B3BFwB778DM=mNcKyOoS-KQGuLf=At7hG0g@mail.gmail.com>
	<xmqqk2ro7czy.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 18:36:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcyeL-0006N2-3K
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 18:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbbIRQgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 12:36:32 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:35175 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbbIRQgb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 12:36:31 -0400
Received: by ykdu9 with SMTP id u9so51555417ykd.2
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 09:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Vg+pgb6zoDK6pHejO75kn6UogtjQ0BUqvMYcLB9EVfs=;
        b=MqKYyEgJMaGSTzBb76/hzmeIudeGKlyfFIeghskYol65Sg7liTz3jpMhSC2UFP7TC0
         e5Sg2TZ/cnCUILJEkRYErfKamfQLLHe8mIz9UdEtAiqodkXXUUJGdFDtum69QH8riTVi
         LDY3Pr1f9dub0DvoBoQQ6yJjLjUVKct57Jeajhguux9inGRkTw9sGLd38Wz3XqkpU93Y
         w7HMIhpjAYptpteXWRYcgUF204TZgpYncCNoQcn/0DBn54Z9uQVo3OPnFlKxzy6RdKf7
         SIz/xKQWt7rwJQsCNaJCY2B8YsRah0lVj5c1xfZnpa1blB1bqCUlBMZ/CJnQ9WPcbBBc
         xt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Vg+pgb6zoDK6pHejO75kn6UogtjQ0BUqvMYcLB9EVfs=;
        b=c3sjB4CjB5JOMCpoTo0hn6cFNDetiHbtVtqFrnZgTvJrsp3XVA212sSnKG35CGp+nP
         CX2lP74qC/XZB329nrQVeK5D3Rny/gOjOZ9Ed/AXzyHrseGO0rGBAhOxkCcizN/z/VOW
         0LYcrRDQ2O/izrMTOnxVtLXTMwh8DQSU4gllAP2BTu3Dh8gMef5RfuyXM6fqXFuvYotX
         PJg4EiK5CXHY+2idkJ717qWAAXq2zel02KGtSYH47ZHE01pnJ8T8skQ1l3ogzXDe/NGb
         CVxhkEuZDwPeg0rFUGMlwdeZ5gnIvonOim18LNuVHNERlhcpHsIogdnE3ey4vBy2U6O/
         k8Gg==
X-Gm-Message-State: ALoCoQkDkzjaXigKPNisqfjUIbKo8jTqrt7JJZIYEdlxAaGU2mn7ZNBQvXQBIGdKbWIIiVa8SsK9
X-Received: by 10.129.116.84 with SMTP id p81mr5409918ywc.1.1442594190297;
 Fri, 18 Sep 2015 09:36:30 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Fri, 18 Sep 2015 09:36:30 -0700 (PDT)
In-Reply-To: <xmqqk2ro7czy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278207>

On Thu, Sep 17, 2015 at 6:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Thu, Sep 17, 2015 at 2:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> Hmm, you are relying on the fact that a valid pid can never be 0, so
>>> you can just use pp->children[i].child.pid to see if a "slot" is
>>> occupied without even using pp->slots[] (or pp->children[i].in_use).
>>
>> We could either use the pid as accessed via children[i].process.pid
>> or we could rely on the children[i].process.err != -1 as start_process
>> will set it to an actual fd, and when it's done we reset it to -1.
>>
>> I am unsure if this make it less readable though (all your other
>> suggestions improve readability a lot!)
>
> Sorry, the above was not a suggestion but merely an observation with
> a bit of thinking aloud mixed in.  I should have marked it as such
> more clearly.

Ok, I see. no harm done, I did not take that as a suggestion.

>
>>> ... and then picks a new owner of the output channel.
>>>
>>> Up to this point it looks sensible.
>>>
>>>> +                     fputs(pp->err[pp->foreground_child].buf, stderr);
>>>> +                     strbuf_reset(&pp->err[pp->foreground_child]);
>>>
>>> I do not think these two lines need to be here, especially if you
>>> follow the above advice of separating buffering and draining.
>>
>> They are outputting the buffer, if the next selected child is still running.
>> I mean it would output eventually anyway, but it would only output after
>> the next start of processes and poll() is done. Yeah maybe that's what we
>> want (starting new processes earlier is better than outputting earlier as we're
>> talking microseconds here).
>
> I am not talking about microseconds but refraining from doing the
> same thing in multiple places.

ok

>
>>> But calling start_new() unconditionally feels sloppy.  It should at
>>> least be something like
>>>
>>>         if (pp.nr_processes < pp.max_processes &&
>>>             !pp.all_task_started)
>>>                 start_new_process()
>>>
>>> no?
>>
>> That's the exact condition we have in start_new_process
>> so I don't want to repeat it here?
>
> You are advocating to have a function whose definition is "this may
> or may not start a new process and the caller should not care", and
> then make the caller keep calling it, knowing/hoping that the caller
> does not care if we spawn a new thing or not.
>
> I somehow find it a highly questionable design taste to base the
> decision on "don't want to repeat it here".
>
> Stepping back and thinking about it, what is suggested is more
> explicit in the caller.  "If we know we need a new worker and we can
> have a new worker, then start it." is the logic in the caller in the
> suggested structure, and we would have a well defined helper whose
> sole task is to start a new worker to be called from the caller.
> The helper may want to check if the request to start a new one makes
> sense (e.g. if slots[] are all full, it may even want to return an
> error), but the checks are primarily for error checking (i.e. "we
> can have max N processes, so make sure we do not exceed that limit"),
> not a semantic one (i.e. the caller _could_ choose to spawn less
> than that max when there is a good reason to do so).

I would not put the decision to spawn fewer processes in the caller either,
My understanding is to have one high level function which outlines the algorithm
like:

    loop:
        spawn_children_as_necessary
        make_sure_pipes_don't_overflow
        offer_early_output
        take_care_of_finished_children

such that the main function reads more like a bullet point list explaining
how it roughly works. Each helper function should come up with its own strategy,
so spawn_children_as_necessary could be

    spawn_children_as_necessary:
        while less than n children and there are more tasks:
            spawn_one_child

for now. Later we can add more logic if necessary there. But I'd prefer to have
these decisions put into the helpers.

Having written this, I think I'll separate the function to drain the pipes and
the early output and separate the helper to start children into two:
one to make the decision and one to actually start just one child.



>
>
