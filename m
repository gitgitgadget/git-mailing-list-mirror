From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 1/3] worktree: add top-level worktree.c
Date: Wed, 16 Sep 2015 16:42:15 -0400
Message-ID: <CAPig+cQ9QpGUZCaZXG3avChVdpXGoKXbKAc9vYUCFWMSUE-B4g@mail.gmail.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
	<1441402769-35897-2-git-send-email-rappazzo@gmail.com>
	<CAPig+cQRx-uKZnnx2O0pG34HkcEdg1GbGNFd9PHdw+m0O3aJEA@mail.gmail.com>
	<CANoM8SWP9YrZoUx5w9Do18uZf=5RrCV_ShvyaPQF4=9-vuFVbg@mail.gmail.com>
	<xmqqwpvsx5ie.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mike Rappazzo <rappazzo@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 22:42:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcJX8-0001cY-Om
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 22:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbbIPUmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 16:42:18 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:35301 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652AbbIPUmR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 16:42:17 -0400
Received: by qgt47 with SMTP id 47so182525014qgt.2
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 13:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=T/s6Af2C6XgLrcZ53oxV9uApppThHkhowNwhOxSb8NY=;
        b=lB/5s0w9bE8W6QK+VRXdpPXk7+AupCzaHeUGrUmOVR5j7yMF6rwHb7ab4fRCy/BaOI
         egjnSM13G0QOXeMNe5f4YpaletgfHygVcrivfpsRWJzlzCvu8qxO/FcnxuUVDaX2V57K
         ZZn595NMrCLbxlSCCaUMCyjukLcOvBGHhe3gP2sDPd5a4puuCqvIiM6s/bCNG59apETw
         ffU4WuWUNdW3l3JqzKX9KxQJBujPN/4xpGx/HJ+fjGuUc5qGAycxZ9Iifd1+3Wvo1+K5
         32241JIBXcC8uv/Vczm9zadzE0V3i/0OursMHz2fQ/5Sa3uypk4gjmMUanjnR7AdWbar
         e4LQ==
X-Received: by 10.140.93.68 with SMTP id c62mr45976748qge.54.1442436136071;
 Wed, 16 Sep 2015 13:42:16 -0700 (PDT)
Received: by 10.55.180.130 with HTTP; Wed, 16 Sep 2015 13:42:15 -0700 (PDT)
In-Reply-To: <xmqqwpvsx5ie.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: LTeOhgozhxQDHRYqyBYk__9_cAc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278065>

On Mon, Sep 14, 2015 at 1:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Mike Rappazzo <rappazzo@gmail.com> writes:
>> On Sat, Sep 12, 2015 at 10:39 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> +struct worktree_list *get_worktree_list()
>>>
>>> Can we be more concise and call this get_worktrees()?
>>
>> I prefer 'get_worktree_list' because I also added the 'get_worktree'
>> function, and I wanted to differentiate
>> the function names.
>
> I'd say that plural can be differentiating enough; it probably is a
> matter of taste.  How often do external callers want to call
> get_worktree() and not get_worktrees()?

The shorter name, get_worktrees(), also has the minor benefit of
concision, similar to the way we use short variable names (i, j, n, p,
s) to help reveal and (often) make code structure obvious at a glance;
whereas long, noisy, wordy names tend to obscure code structure.

The "_list" suffix doesn't add any value over the shorter pluralizing
"s"; in fact, it may be (very, very slightly) detrimental in implying
too strongly that the return value must be a linked list.

>>>> +struct worktree {
>>>> +       char *path;
>>>> +       char *git_dir;
>>>> +       char *head_ref;
>>>> +       unsigned char head_sha1[20];
>>>> +       int is_detached;
>>>> +       int is_bare;
>>>> +};
>>>> +
>>>> +struct worktree_list {
>>>> +       struct worktree *worktree;
>>>> +       struct worktree_list *next;
>>>> +};
>>>
>>> I don't care too strongly, but an alternate approach (which I probably
>>> would have taken) would be to have get_worktrees() simply return an
>>> array of 'struct worktree' objects, hence no need for the additional
>>> 'struct worktree_list'.
>
> I do not think we are using this to hold thousands of worktree
> objects in core.  Adding "struct worktree *next" pointer to the
> worktree object itself would probably be sufficient for the need of
> codepaths that want to enumerate and iterate over them and that
> would be another way to lose the extra structure.

I was more concerned with the inherent (and, in this case,
unnecessary) complexity of a linked list. Being able to drop the extra
'worktree_list' structure was just an added benefit of moving to the
simpler array approach.
