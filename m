From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] New kind of upstream branch: base branch
Date: Wed, 15 May 2013 18:32:32 -0500
Message-ID: <CAMP44s3AwODeOE-D+xYyBQzu4TQfbs1P1N6tG4CW9w5LPH424A@mail.gmail.com>
References: <5193efe6.c42ab60a.0319.5f2c@mx.google.com>
	<7vzjvvanro.fsf@alter.siamese.dyndns.org>
	<CAMP44s1kWkNgFMAvThczCvTZppWGca0YvGv=CQ15GtViA1zy_Q@mail.gmail.com>
	<7vr4h7al9k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 16 01:32:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UclBX-0007RF-3X
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 01:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875Ab3EOXce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 19:32:34 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:52354 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408Ab3EOXcd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 19:32:33 -0400
Received: by mail-lb0-f171.google.com with SMTP id v20so2501441lbc.30
        for <git@vger.kernel.org>; Wed, 15 May 2013 16:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=J3asSz92s6bCyC04dR4XxYcz0i42/BEQ1WKavJ3l2Ns=;
        b=R4WErqoK6naXg7j7Y+bNXcnlRu6Ntko6U5xnMFcVjiX+pMCgzo57vPpjqVbShZH+K2
         L5vkbFST1DXOSQsWi5MehWdy7QY3Pd/NVDNVI5Y0YkYUsM2y+iiSwhpidFCNogANajIx
         Ow4hpGa5C2U25/csl+Mh0dmBx4OqvkZmsVJt8q2/iBEKQ2RfwxZ7QWiwCRHO5z1vGnSW
         yCeS821Gn9L03zYvASjOeueACIy8J71Tfl8rtIORXrD9z8Xx53ZxSIYNvBYaA0CI9sO5
         fPxshCa6eQRNGBlcbw3d7lRh7qmAZFyqblO6wg4EAGhMEdAnrrIIl0VK0V3d7Q9cCeTa
         Q+BA==
X-Received: by 10.112.125.130 with SMTP id mq2mr18511945lbb.103.1368660752243;
 Wed, 15 May 2013 16:32:32 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Wed, 15 May 2013 16:32:32 -0700 (PDT)
In-Reply-To: <7vr4h7al9k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224457>

On Wed, May 15, 2013 at 6:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Exactly the same as 'git pull' does right now.
>
> You set
>
>         [branch 'foobar']
>                 base = refs/heads/master
>
> then 'git pull [--rebase]' will go to 'origin' due to the default,
> but then what branch from the 'origin' are you integrating with?

The same as if you didn't have 'branch.foobar.base': none. You get an
error because there's no upstream.

> Do you mean you are also setting both remote and upstream, perhaps
> like this, for all of your branches?
>
>         [remote "origin"]
>                 url = github.com:maintainer/hisproject
>                 fetch = +refs/heads/*:refs/remotes/origin/*
>
>         [remote "github"]
>                 url = github.com:felipec/myproject
>                 fetch = +refs/heads/*:refs/remotes/github/*
>
>         [branch 'foobar']
>                 base = refs/heads/master
>                 remote = github ;# or is it origin???
>                 upstream = refs/heads/foobar
>
> Then your 'git pull' will fetch from remote 'origin' and integrate
> with its 'foobar' and 'push' may go to update 'foobar' at 'github'.
>
> Perhaps that is what you meant.

That's what I described in my example.

>> 'base' has absolutely nothing to do with pulling or pushing.
>
> I agree it shouldn't have anything to do with pushing, but given
> that 'git pull [--rebase]' is a way to do a 'merge' or 'rebase' with
> what you 'git fetch', introducing something that 'merge' or 'rebase'
> pays attention to that does not have anything to do with 'pull'
> sounds like it breaks existing end user expectation.

But it's already broken.

'git pull' is not the same as 'git fetch'+'git merge'. That *only*
works  when merge.defaulttoupstream is set.

> But that does not mean it is a bad idea. The behaviour changes only
> when you have branch.$name.base, so I suspect that we do not need to
> worry about "what if the user has both?" case you mentioned in your
> first message.

Indeed. It wouldn't be an intrusive change; it would only affect 'git
rebase', and nothing more.

But I'm wondering if the behavior of 'git fecth' should change as
well. And in fact it should be the other way around.

> I think I misunderstood what you meant.  If it is the norm to have
> both base and upstream/remote in branch.$name (as opposed to "have
> only branch.$name.base and not branch.$name.remote to force fetch to
> go to the default 'origin'), then 'git pull' will not break and I
> can see how many things would work naturally (admittedly I can only
> say 'many things', not 'everything', at this point, as I haven't
> thought things through).

But I think the norm would be to have only 'base', because a lot of
people don't manually set an upstream branch.

In the end it all boils down to; which is the upstream
'origin/master', or 'github/master'? Well, it is 'origin/master', so
'upstream' should point there, but I don't want to push to the
'upstream', I want to push somewhere else by default.

-- 
Felipe Contreras
