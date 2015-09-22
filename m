From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 1/3] worktree: add top-level worktree.c
Date: Mon, 21 Sep 2015 21:05:34 -0400
Message-ID: <CAPig+cQjhoVhQtP4_ZYTyLX3-GBXRx2eKM8Yv1=i=pSg=ZuM=Q@mail.gmail.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
	<1441402769-35897-2-git-send-email-rappazzo@gmail.com>
	<CAPig+cQRx-uKZnnx2O0pG34HkcEdg1GbGNFd9PHdw+m0O3aJEA@mail.gmail.com>
	<CANoM8SWP9YrZoUx5w9Do18uZf=5RrCV_ShvyaPQF4=9-vuFVbg@mail.gmail.com>
	<CAPig+cRPbFw8oTQ63rPtp1cyKms9zi0QkZNvkOWZoxb+mnpZrA@mail.gmail.com>
	<CANoM8SWV0r9sHUTk3Rfu=psZLKmnjD19Dn_atCuDmc=41420-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 03:05:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeC1c-0005zz-RH
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 03:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757534AbbIVBFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 21:05:36 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:35034 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756290AbbIVBFf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 21:05:35 -0400
Received: by vkao3 with SMTP id o3so76293252vka.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 18:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=aehbHzMJL3m5VYuugXExRF78k3ebuXEkfTenTx42QPw=;
        b=xh/phxGZ+gKTjFI3o6QOK3esz8BJ8ZwTsFAU221/DY7Q98w312SQ4/wyKp+ES920EK
         vM8NDv+bl2zXdBdGHkjFabrpP9OtQM0rNr8IZ74YaKn7ulVHH++It6FP/fJwKnICcBDq
         L4rMmlzoSrIv/Ps7CqJ+gWZC+YhPEXnZZHL1k/suuo7OMsbbet7PNRmIB0qISDMEaZHc
         DJ41WhQpuOmYGBqNVnrL50EgPyV8L0qK9DB5V4OcYKHJLfwz+GjH/0JWu/0fQimbwVeG
         N05lxq1D8quv+3Du22FEs25fbkp94iY24y2Ao0t3sw1vd74+5JmgxSXdfGlX6QxWrVZc
         5yxQ==
X-Received: by 10.31.131.141 with SMTP id f135mr15409213vkd.37.1442883934677;
 Mon, 21 Sep 2015 18:05:34 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Mon, 21 Sep 2015 18:05:34 -0700 (PDT)
In-Reply-To: <CANoM8SWV0r9sHUTk3Rfu=psZLKmnjD19Dn_atCuDmc=41420-w@mail.gmail.com>
X-Google-Sender-Auth: frn4TsqMEACeCiYPtms35Zok9ns
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278370>

On Wed, Sep 16, 2015 at 4:49 PM, Mike Rappazzo <rappazzo@gmail.com> wrote:
> On Wed, Sep 16, 2015 at 4:32 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Mon, Sep 14, 2015 at 8:20 AM, Mike Rappazzo <rappazzo@gmail.com> wrote:
>>> On Sat, Sep 12, 2015 at 10:39 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> I don't care too strongly, but an alternate approach (which I probably
>>>> would have taken) would be to have get_worktrees() simply return an
>>>> array of 'struct worktree' objects, hence no need for the additional
>>>> 'struct worktree_list'. The slight complication with this approach,
>>>> though, is that get_worktrees() either also needs to return the length
>>>> of the array, or the array should end with some sort of end-of-array
>>>> sentinel. An obvious sentinel would be path==NULL or git_dir==NULL or
>>>> all of the above.
>>>>
>>>> Client iteration is just about the same with the array approach as
>>>> with the linked-list approach.
>>>
>>> I can't see what benefit this would provide.  I would sooner change
>>> the returned list into
>>> an array-backed list struct.  Alternatively, I think adding a
>>> list_head pointer to this structure
>>> could benefit client code.
>>
>> The benefit is a reduction in complexity, which is an important goal.
>> Linked lists are inherently more complex than arrays, requiring extra
>> effort, and especially extra care, to manage the head, each "next"
>> pointer (and possibly a tail pointer). Arrays are used often in Git,
>> thus are familiar in this code-base, and Git has decent support for
>> making their management relatively painless. Your suggestions of
>> changing into "an array-backed list structure" or "adding list_head
>> pointer" increase complexity, rather than reduce it.
>>
>> Aside from the complexity issue, arrays allow random access, whereas
>> linked lists allow only sequential access. While this limitation may
>> not impact your current, planned use of get_worktrees(), it places a
>> potentially unnecessary restriction on future clients.
>>
>> And, as noted, client iteration is at least as convenient with arrays,
>> if not moreso, due to the reduction in noise ("p++" rather than "p =
>> p->next").
>>
>>     struct worktree *p;
>>     for (p = get_worktrees(); p->path; p++)
>>         blarp(p);
>>
>> There are cases where linked lists are an obvious win, but this
>> doesn't seem to be such a case. On the other hand, there are obvious
>> benefits to making this an array, such as reduced complexity and
>> removal of the sequential-access-only restriction.
>
> What you are suggesting makes sense, but I feel it falls short when it
> comes to the "sentinel".  Would the last element in the list be a
> dummy worktree?  I would sooner add a NULL to the end.  Would that be
> an acceptable implementation?

The sentinel would indeed be a dummy worktree structure, which may be
very slightly ugly, however, it's dead simple, both in implementation
and from client viewpoint, whereas other approaches increase
complexity.

Making the last entry a NULL means get_worktrees() would have to
return an array of pointers rather than an array of structures, which
is more syntactically noisy, and complex since it's harder to reason
about pointer-to-pointer. In my mind, at least, the simplicity of the
array of structures approach (even with the slight ugliness of the
dummy sentinel) outweighs the complexity of the array-of-pointers
approach.
