From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: Re: [PATCH] tag: add -i and --introduced modifier for --contains
Date: Wed, 16 Apr 2014 15:35:07 -0700
Message-ID: <CAB=NE6VvDrMQ4ybF10MpXM-2672OdUTC_Rp2mdO3a5fuo1-H1Q@mail.gmail.com>
References: <1397681938-18594-1-git-send-email-mcgrof@do-not-panic.com> <xmqqppkhexw3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>,
	Jiri Slaby <jslaby@suse.cz>, Andreas Schwab <schwab@suse.de>,
	Jan Kara <jack@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 00:35:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaYQd-0002w9-DC
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 00:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756868AbaDPWfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 18:35:31 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:61635 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbaDPWfa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 18:35:30 -0400
Received: by mail-lb0-f179.google.com with SMTP id p9so8575749lbv.38
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 15:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Kom87es6gsLjc9BgyNBw1aFOH36M8jbC6/hQSBWDjs4=;
        b=tZcYO8R0RyMqKzJLws4+5apK3irSyRr1DuLbRpZPyCXNLvh6eigKXM+WOtwBKJF2E1
         JhBz92iu/1RGCLeqxdydaZUZyvfx4gupYR+FiScquLwbFPA/kqzUjzkkLtgU9fxe6wuv
         IrdOpnRETaDLkq7X2TmTtGoGxY33rLi+lFzh4e9cKREPBAovbqptuJQ08shYUGi12oyL
         H+I2OSFXiEM9u6wJTRH7tKHNf1dn9kM3+Rv/thLxaFLYJIBtW1LQAgKrX6wk4JysB3tC
         xjyKz+1n8CrNQ0u/Oc37MsDrBEmm4Gp8X7zs8SNlOdNf1NNk5BhwvL5rpQJDrpueBrgR
         DEAg==
X-Received: by 10.112.235.229 with SMTP id up5mr726lbc.62.1397687728698; Wed,
 16 Apr 2014 15:35:28 -0700 (PDT)
Received: by 10.112.215.74 with HTTP; Wed, 16 Apr 2014 15:35:07 -0700 (PDT)
In-Reply-To: <xmqqppkhexw3.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: b2LvS8FOJU1Zf3GfQkYzc7WUKOo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246389>

On Wed, Apr 16, 2014 at 3:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Luis R. Rodriguez" <mcgrof@do-not-panic.com> writes:
>
>> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>>
>> Upstream Linux kernel commit c5905afb was introduced on v3.4 but
>> git describe --contains yields v3.5
>
> Actually, "describe --contains" should yield v3.5-rc1~120^3~76^2,
> not v3.5.

Yes, indeed thanks, sorry I should have been explicit.

> And you are right that the commit is contained in v3.4, so we also
> should be able to describe it as v3.4~479^2~9^2 as well.

That'd be swell :)

> And between v3.4 and v3.5-rc1, the latter is a closer anchor point
> for that commit (v3.5-rc1 only needs about 200 hops to reach the
> commit, while from v3.4 you would need close to 500 hops),

Ah! Thanks for explaining this mysterious puzzle to me. I'm a bit
perplexed why still. Can I trouble you for a little elaboration here?
How could one view from a commit merged on v3.4 possibly yield more
commits to v3.4 than to v3.5 ? Is it because it starts counting on the
merge's parent (v3.3) ?

> hence we
> end up picking the latter as "a better answer".
>
> Now, with the explanation of how/why this happens behind us, I see
> two possible issues with this patch:
>
>  - The reason a human-user rejects v3.5-rc1~120^3~76^2 as the
>    solution and favor v3.4~479^2~9^2 could be because of the -rc1
>    part in the answer.  Perhaps we would want an option that affects
>    which tags are to be used (and which tags are to be excluded) as
>    anchoring points?

I'd take an rc release as a blessed point too so not sure, and come to
think of it I'm not a bit perplexed why the results for my change did
not yield an rc1 as well.

>  - If we are truly interested in finding out the "earliest tag that
>    contains the given commit", shouldn't we be ignoring the tagname
>    and go with the tag with the oldest timestamp?  After all, there
>    may be a fix merged to v7.0 first on April 1st, and then on a
>    later date the same fix may be merged to the maintenance track to
>    be tagged as v6.9.1 on May 5th,

At least for Linux linux-3.X.y branches (one example linux-3.4.y) on
linux-stable has different commit IDs from patches cherry picked from
Linus' tree, and that patch just referneces the upstream commit from
Linus' tree on the commit log, but nothing more.

> and in such a case, wouldn't you  want to say that the fix first appeared on v7.0 on April 1st,
> instead of on May 5th?

Sure, but I'd expect the folks maintaining v6.9.x would just refer to
the upstream commit ID from v7.0.

  Luis
