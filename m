Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 050211F404
	for <e@80x24.org>; Sat, 10 Feb 2018 01:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750933AbeBJBdW (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 20:33:22 -0500
Received: from grym.ekleog.org ([94.23.42.210]:55310 "EHLO smtp.gaspard.ninja"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750832AbeBJBdV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 20:33:21 -0500
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTP id a2084a78;
        Sat, 10 Feb 2018 01:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=gaspard.io; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=
        grym-20170528; bh=yE3N4yJS8XAYNFwHQoJmnPckAAE=; b=Vmmdh1s4nB462y
        A55isiR88EZzJJZlHO2RwMiXT+y83viwnMeephbfja0K2kLtDsrD54hGLduNIGA9
        ZBFAQp3TypQbf3I7awewrSSKAWM5Qd5RMRkmOegPO+LuUM2hiTLXNYJw6bMf+Kuu
        QE6bpu1Dqnc4ZOGD+zWqdpZ4bDdKw=
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTPSA id aec8e495 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sat, 10 Feb 2018 01:33:19 +0000 (UTC)
Subject: Re: Fetch-hooks
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Joey Hess <id@joeyh.name>, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>
References: <5898be69-4211-d441-494d-93477179cf0e@gaspard.io>
 <87inb8mn0w.fsf@evledraar.gmail.com>
 <c8d1eb4d-c3d2-5834-a46b-931e825315aa@gaspard.io>
 <20180208153040.GA5180@kitenet.net>
 <871af155-a159-2a29-2e48-74e7a98b60d4@gaspard.io>
 <87bmgzmbsk.fsf@evledraar.gmail.com>
 <fa470be4-75fb-76ed-ed93-5c10fcfb8842@gaspard.io>
 <87po5dbz1a.fsf@evledraar.gmail.com>
 <20180209223011.GA24578@sigill.intra.peff.net>
 <87e7c3b8-3b3c-1cb0-9b11-e4bf3044e539@gaspard.io>
 <20180210001317.GA26856@sigill.intra.peff.net>
 <3de8dec0-12c9-56e2-5902-97755f78ab50@gaspard.io>
 <xmqqvaf5tzw6.fsf@gitster-ct.c.googlers.com>
From:   Leo Gaspard <leo@gaspard.io>
Message-ID: <9ab95c53-61e5-06a3-535e-a8916b3e5ec1@gaspard.io>
Date:   Sat, 10 Feb 2018 02:33:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqvaf5tzw6.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/10/2018 02:08 AM, Junio C Hamano wrote:
> Leo Gaspard <leo@gaspard.io> writes:
> 
>> On 02/10/2018 01:13 AM, Jeff King wrote:
>>> On Sat, Feb 10, 2018 at 12:49:31AM +0100, Leo Gaspard wrote:
>>>> So the changes that are required are:
>>>>  * Adding a notification-only post-fetch hook
> 
> Maybe I missed a very early part of the discussion, but why does
> this even need a hook?  There are some numbers [*1*] of classes of
> valid reasons we may want to have hooks triggered by operations, but
> "always do something locally after doing something else locally,
> regardless of the outcome of that something else" feels like the
> most typical anti-pattern that we do not want a hook for.  If you
> are doing "git fetch" (or "git pull"), you already know you are
> doing that and you donot need a notification.  You just create a
> workflow specific script that calls fetch or pull, followed by
> whatever you want to do and use that, instead of doing "git pull",
> and that is not any extra work than writing a hook and installing
> it.
> 
> Unlike something like post-receive, which happens on the remote side
> where you may not even have an interactive access to, in response to
> the operation you locally do (i.e. "git push"), fetching and then
> doing something else in a repository you fetch into has no reason to
> be done as a hook.

I guess the very early part of the discussion you're speaking of is what
I was assuming after reading
    https://marc.info/?l=git&m=132478296309094&w=2

Then, it's always possible to just write workflow-specific scripts that
manually run git fetch then copy the refs (resp. run git fetch then copy
the refs then run git merge) to get git myfetch (resp. git mypull) [1].

But then, the question is, why is there a pre-push hook? it's already
possible to have a custom script that first runs the hook then runs git
push, for most if not all of the use cases of the pre-push hook. Yet the
possibility to not change the end-user's workflow is what makes pre-push
(or pre-commit, with which the similarity is perhaps even more obvious)
so useful.

So the reason for a post-fetch in my opinion is the same as for a
pre-push / pre-commit: not changing the user's workflow, while providing
additional features.


[1]

Which makes me notice that actually the post-fetch hook technique we
were discussing with Peff suffers the same not-updating-FETCH_HEAD issue
that was discussed in this early thread: a `git pull` would try to merge
from refs/quarantine, I guess. So things are a bit harder than we thought.

I guess the tweak-fetch hook could be left “as-is”, but with git
automatically doing the “quarantine-ing” thing transparently so that the
references that the end-user (or the hook for that matter) see are the
“curated” ones? Then it's too late for me to think efficiently right
now, so that idea may be stupid or over-complex.
