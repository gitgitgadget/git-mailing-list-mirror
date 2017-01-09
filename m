Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67E231FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 22:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbdAIWDX (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 17:03:23 -0500
Received: from smtp82.ord1c.emailsrvr.com ([108.166.43.82]:60460 "EHLO
        smtp82.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751283AbdAIWDW (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Jan 2017 17:03:22 -0500
Received: from smtp11.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp11.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 3CA23A0418;
        Mon,  9 Jan 2017 17:03:21 -0500 (EST)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp11.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id A75ABA039F;
        Mon,  9 Jan 2017 17:03:20 -0500 (EST)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 09 Jan 2017 17:03:21 -0500
Subject: Re: [PATCH 00/13] gitk: tweak rendering of remote-tracking references
To:     Michael Haggerty <mhagger@alum.mit.edu>,
        Paul Mackerras <paulus@samba.org>
References: <cover.1482164633.git.mhagger@alum.mit.edu>
 <97d97bc6-54f1-2ef2-fe04-7e7f144d7e51@xiplink.com>
 <046b088c-afd5-66b9-fe3c-255e42a7d768@alum.mit.edu>
 <bfbd5992-da30-b1f0-59e5-a2f36d2e3062@xiplink.com>
 <24a89c72-af53-0c87-d148-708e014ebe75@alum.mit.edu>
Cc:     git@vger.kernel.org
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <a2b38629-be34-c745-6e45-3a36123c4ef7@xiplink.com>
Date:   Mon, 9 Jan 2017 17:03:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <24a89c72-af53-0c87-d148-708e014ebe75@alum.mit.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2016-12-22 03:15 AM, Michael Haggerty wrote:
> On 12/21/2016 08:07 PM, Marc Branchaud wrote:
>> On 2016-12-20 07:05 PM, Michael Haggerty wrote:
>>> On 12/20/2016 04:01 PM, Marc Branchaud wrote:
>>>> [...]
>>>> Please don't change the remotebgcolor default.
>>>>
>>>> Also, perhaps the default remoterefbgcolor should be
>>>>     set remoterefbgcolor $headbgcolor
>>>> ?
>>>>
>>>> I say this because when I applied the series, without the last patch, I
>>>> was miffed that the remote/ref colour had changed.
>>>
>>> This is a one-time inconvenience that gitk developers will experience. I
>>> doubt that users jump backwards and forwards in gitk versions very often.
>>
>> In what way do you mean it's restricted to gitk developers?
>
> Maybe I misunderstood your objection.
>
> While developing this, I realized that the very first time your run gitk
> (i.e., when you don't already have a configuration file), it writes the
> then-current default colors into your configuration file. If you later
> switch gitk versions to a version with different default colors, the
> colors from the first-run version are preserved (unless the names of the
> variables used to hold the colors are changed).
>
> So if you would run the tip version of my branch first, then the parent
> of that version, you would continue to see the colors as modified by the
> final commit. If you then switch to the master version, the remote
> branch names go back to green (because it goes back to using
> `headbgcolor` again), but the remote prefix stays light brown. I thought
> you were unhappy about some form of this unexpected persistence problem.
> But this problem will mostly be experienced by gitk developers who jump
> back and forth between versions.
>
> A normal user probably mostly moves forward through version numbers, and
> only occasionally. Such a user, jumping from master to the tip of my
> branch (assuming they haven't customized anything), would see
>
> * local branches stay lime
> * remote branch prefixes stay pale orange (they don't change to light
> brown because the pale orange color from master is stored in their
> configuration file)
> * remote branch names change from lime to brown (because the
> `remoterefbgcolor` configuration setting didn't exist before)
>
>> Patch 12 introduces remoterefbgcolor, with a specific default value.
>> Prior to that, the "ref part" of remote refs was rendered with
>> headbgcolor.  Users who changed their headbgcolor are used to seeing the
>> "ref part" of remote refs in the same color as their local heads.
>> Applying patch 12 changes the "ref part" color of remote refs, for such
>> users.
>>
>> All I'm saying is that make the remoterefbgcolor default be $headbgcolor
>> avoids this.
>
> For somebody who thinks that most people will want local and
> remote-tracking branch names to be rendered in the same color, your
> suggestion would be an improvement.
>
> But for somebody like me who thinks it is a good idea to render
> remote-tracking branch names in a different color than local branch
> names, this is a feature, not a bug. Even a user who explicitly
> configured `headbgcolor` to, say, purple, wasn't necessarily expressing
> a wish to have remote-tracking branch names rendered in purple. Until
> now they had no choice to set these colors separately!
>
> So even for somebody who configured this setting before, I think that
> having the remote-tracking branch names change color when the user
> upgrades to this version is a good thing, because it lets the user know
> that these two things can now be colored independently. If they don't
> like the new default brown color, such a user knows where to change it
> (even to make it agree with `headbgcolor` if they want that).
>
> But I understand that this is a matter of personal preference. I have
> but one "vote" :-)

I think we understand each other, and that we disagree.  I don't feel 
strongly about it though, so if you want to go this way that's fine by me.

Your case would be helped if the various ref colours were exposed in the 
preferences dialog.  Someone who upgrades to your gitk and doesn't like 
the default remoterefbgcolor has to track down the right setting, close 
all running gitk instances, and hand-edit ~/.gitk.

But I think improving gitk's colour-preferences dialog is a bit beyond 
the scope of your topic...

		M.

