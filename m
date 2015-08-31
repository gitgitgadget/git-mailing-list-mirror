From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 1/2] worktree: add 'for_each_worktree' function
Date: Mon, 31 Aug 2015 17:37:02 -0400
Message-ID: <CAPig+cTV517TizuBUSd=NbF=-wvPtEpVLTeFVFivYLJ1dyNwLQ@mail.gmail.com>
References: <1440961839-40575-1-git-send-email-rappazzo@gmail.com>
	<1440961839-40575-2-git-send-email-rappazzo@gmail.com>
	<CAPig+cTHZrQn8LpfftcsAQhFAykgDorbR97tkcuSCFYD_ngs9g@mail.gmail.com>
	<CANoM8SUoJAPBwEO=udhaR0WcUkZropEJ5G_SESnkHVtAQHxJQQ@mail.gmail.com>
	<CAPig+cSweTu=t4vekV6ihAYSzdDHZMQdx-PRt9_+rYr9SrujPw@mail.gmail.com>
	<CANoM8SUy_MGbLzaLrkaaNxbXYiisiu8cwnWuy6QDtGvw6HCf9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 23:37:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWWlu-0001u1-TC
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 23:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678AbbHaVhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 17:37:10 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:32950 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264AbbHaVhE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 17:37:04 -0400
Received: by qkdv1 with SMTP id v1so18720081qkd.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 14:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=89PbIMZd468CvDMDLivlUSzBLrYfdzA36UQKlE3yT3M=;
        b=FcTYo9RyDdUF03BKonuP8J3JrpHV6d+zYBiSOiQdxWltSPMsGtcPGumP+2smMCBMAJ
         nAP8vWyrFD+mu1X5fy+VHdK/KoyIQeHeyvp0YXEjNmO4+N0Tp5FZBiKxMByKCJYHbuk7
         W0wpHG3w7ZSZ3NSTm6QApSNiBu2KSX3iK65zaMmpOTmGEiQhld2Dd9y0FN8eCt4WstX1
         eZlCD3vpX1L4VNOD6SWqxl2GctErf00dh8fVAnZq9Ad3BDjaj/uq6HoWk8tGTUPYCXP4
         v7K7xT2QVAs3lgZTtE6Zq7/DZiNB8IWcx7OehC9b82WwLHqBduRpfSNgSO1Uc0e7k0Xy
         g9nw==
X-Received: by 10.129.70.215 with SMTP id t206mr23947478ywa.4.1441057022519;
 Mon, 31 Aug 2015 14:37:02 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Mon, 31 Aug 2015 14:37:02 -0700 (PDT)
In-Reply-To: <CANoM8SUy_MGbLzaLrkaaNxbXYiisiu8cwnWuy6QDtGvw6HCf9w@mail.gmail.com>
X-Google-Sender-Auth: YBtQgxki8NqmwxwjbXXqo-C04dY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276946>

On Mon, Aug 31, 2015 at 3:54 PM, Mike Rappazzo <rappazzo@gmail.com> wrote:
> On Mon, Aug 31, 2015 at 3:47 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Mon, Aug 31, 2015 at 2:57 PM, Mike Rappazzo <rappazzo@gmail.com> wrote:
>>> I wasn't sure that a bare repo would be considered a worktree.  I
>>> don't think that it would be
>>> a good idea to include it.  In the same vein that I can't checkout a
>>> branch in a bare repo, it
>>> figure that it shouldn't be in the list.
>>
>> I forgot to mention in my previous response that I have the opposite
>> view, and think that a bare repo should be included in the output of
>> "git worktree list". The reason is that the intention of "git worktree
>> list" is to give the user a consolidated view of the locations of all
>> components of his "workspace". By "workspace", I mean the repository
>> (bare or not) and its worktrees.
>>
>> In the typical case, the .git directory resides within the main
>> worktree (the first item output by "git worktree list"), thus is
>> easily found, however, if "git worktree list" hides bare repos, then
>> the user will have no way to easily locate the repository (without
>> resorting to lower-level commands or peeking at configuration files).
>
> This makes sense, but would we also want to decorate it in the `git
> worktree list`
> command?  Would porcelain list output be able to differentiate it?

I don't have strong feelings about decorating the bare repository, if
by "decorate", you mean adding a "[bare]" annotation or something.
Verbose mode can certainly do so.

For porcelain mode, we can (and should) be explicit about it.
