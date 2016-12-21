Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8073B1FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 19:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757084AbcLUTHV (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 14:07:21 -0500
Received: from smtp98.iad3a.emailsrvr.com ([173.203.187.98]:56582 "EHLO
        smtp98.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756543AbcLUTHU (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Dec 2016 14:07:20 -0500
Received: from smtp37.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp37.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id B459D59FA;
        Wed, 21 Dec 2016 14:07:19 -0500 (EST)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp37.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 90C5559C7;
        Wed, 21 Dec 2016 14:07:19 -0500 (EST)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Wed, 21 Dec 2016 14:07:19 -0500
Subject: Re: [PATCH 00/13] gitk: tweak rendering of remote-tracking references
To:     Michael Haggerty <mhagger@alum.mit.edu>,
        Paul Mackerras <paulus@samba.org>
References: <cover.1482164633.git.mhagger@alum.mit.edu>
 <97d97bc6-54f1-2ef2-fe04-7e7f144d7e51@xiplink.com>
 <046b088c-afd5-66b9-fe3c-255e42a7d768@alum.mit.edu>
Cc:     git@vger.kernel.org
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <bfbd5992-da30-b1f0-59e5-a2f36d2e3062@xiplink.com>
Date:   Wed, 21 Dec 2016 14:07:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <046b088c-afd5-66b9-fe3c-255e42a7d768@alum.mit.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2016-12-20 07:05 PM, Michael Haggerty wrote:
> On 12/20/2016 04:01 PM, Marc Branchaud wrote:
>> On 2016-12-19 11:44 AM, Michael Haggerty wrote:
>>> This patch series changes a bunch of details about how remote-tracking
>>> references are rendered in the commit list of gitk:
>>
>> Thanks for this!  I like the new, compact look very much!
>>
>> That said, I remember when I was a new git user and I leaned heavily on
>> gitk to understand how references worked.  It was particularly
>> illuminating to see the remote references distinctly labeled, and the
>> fact that they were "remotes/origin/foo" gave me an Aha! moment where I
>> came to understand that the refs hierarchy is more flexible than just
>> the conventions coded into git itself.  I eventually felt free to create
>> my own, private ref hierarchies.
>>
>> I am in no way opposed to this series.  I just wanted to point out that
>> there was some utility in those labels.  It makes me think that it might
>> be worthwhile for gitk to have a "raw-refs" mode, that shows the full
>> "refs/foo/bar/baz" paths of all the heads, tags, and whatever else.  It
>> could be a useful teaching tool for git.
>
> Yes, I understand that the longer names might be useful for beginners,
> and the full names even more so. However, I think once a user has that
> "aha!" moment, the space wasted on all the redundant words is a real
> impediment to gitk's usability. It is common to have a few references on
> a single commit (especially if you pull from multiple remotes), in which
> case the summary line is completely invisible (and therefore its context
> menu is unreachable). I don't like the idea of dumbing down the UI
> permanently based on what users need at the very beginning of their Git
> usage.

I agree.

> Would it be possible to use the short names in the UI but to add the
> full names to a tooltip or to the context menu?

I don't know -- my Tk-fu is weak.

>>> * Omit the "remote/" prefix on normal remote-tracking references. They
>>
>> If you re-roll, s:remote/:remotes/:.
>
> Thanks.
>
>>>   are already distinguished via their two-tone rendering and (usually)
>>>   longer names, and this change saves a lot of visual clutter and
>>>   horizontal space.
>>>
>>> * Render remote-tracking references that have more than the usual
>>>   three slashes like
>>>
>>>       origin/foo/bar
>>>       ^^^^^^^
>>>
>>>   rather than
>>>
>>>       origin/foo/bar (formerly remotes/origin/foo/bar)
>>>       ^^^^^^^^^^^              ^^^^^^^^^^^^^^^^^^^
>>>
>>>   , where the indicated part is the prefix that is rendered in a
>>>   different color. Usually, such a reference represents a remote
>>>   branch that contains a slash in its name, so the new split more
>>>   accurately portrays the separation between remote name and remote
>>>   branch name.
>>
>> *Love* this change!  :)
>>
>>> * Introduce a separate constant to specify the background color used
>>>   for the branch name part of remote-tracking references, to allow it
>>>   to differ from the color used for local branches (which by default
>>>   is bright green).
>>>
>>> * Change the default background colors for remote-tracking branches to
>>>   light brown and brown (formerly they were pale orange and bright
>>>   green).
>>
>> Please don't change the remotebgcolor default.
>>
>> Also, perhaps the default remoterefbgcolor should be
>>     set remoterefbgcolor $headbgcolor
>> ?
>>
>> I say this because when I applied the series, without the last patch, I
>> was miffed that the remote/ref colour had changed.
>
> This is a one-time inconvenience that gitk developers will experience. I
> doubt that users jump backwards and forwards in gitk versions very often.

In what way do you mean it's restricted to gitk developers?

Patch 12 introduces remoterefbgcolor, with a specific default value. 
Prior to that, the "ref part" of remote refs was rendered with 
headbgcolor.  Users who changed their headbgcolor are used to seeing the 
"ref part" of remote refs in the same color as their local heads. 
Applying patch 12 changes the "ref part" color of remote refs, for such 
users.

All I'm saying is that make the remoterefbgcolor default be $headbgcolor 
avoids this.

But, honestly, I don't feel strongly about it.

		M.

