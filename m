From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] transport-helper: report errors properly
Date: Thu, 11 Apr 2013 11:49:11 -0500
Message-ID: <CAMP44s2-4i_tSzz8Y88_YnK5d1AjNoTqOa7eXZ0W5Vzk9Uosng@mail.gmail.com>
References: <20130410211311.GA24277@sigill.intra.peff.net>
	<20130410211552.GA3256@sigill.intra.peff.net>
	<CAMP44s02K5ydKLNi0umMkuAicoVTWyCdVfjs0yssCa2oyFShGQ@mail.gmail.com>
	<20130411161845.GA665@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 11 18:49:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQKgc-0005hj-3G
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 18:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874Ab3DKQtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 12:49:16 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:37333 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934395Ab3DKQtN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 12:49:13 -0400
Received: by mail-la0-f44.google.com with SMTP id fr10so1692247lab.3
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 09:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=o3+DBduZA3bfI4I8AJTIjBISgvEiP4RkRaUNGM5WrlY=;
        b=VwOyzTIs9Ui1QS1uts+phk8q2FYFLACwav6ymx8+U8Frsoh4H+iuXVe3ggQ7kV/T0B
         ld0MDVAucybopzKS/6Ock/IDdbiYRt1xwE2BD+h0CEp8Pqm/q7SA4JPi0TgLU4EzwmgC
         x+rl0pF5gvxrXSN2cAE0BCh0eHLV7wLRMO8jwWKE3mflsEySWk8QCigsSq0G3LlRMMT6
         yKguKVRHNeKqbunnkYZkyiLO7wAhvTu2tKUJeUBCbF5KaZJXUHtZ3eOLzecwoNNVwZ5g
         bI2kgmFPxv3xxuqI0gfM2FQ+RDT5NxEoeU9Xcg9/SFJ7+pFN/NaAzQftzLSBeNndAfmz
         GR0w==
X-Received: by 10.112.163.6 with SMTP id ye6mr3662061lbb.59.1365698951339;
 Thu, 11 Apr 2013 09:49:11 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Thu, 11 Apr 2013 09:49:11 -0700 (PDT)
In-Reply-To: <20130411161845.GA665@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220890>

On Thu, Apr 11, 2013 at 11:18 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 11, 2013 at 08:22:26AM -0500, Felipe Contreras wrote:
>
>> > We
>> > currently do so robustly when the helper uses the "done"
>> > feature (and that is what we test).  We cannot do so
>> > reliably when the helper does not use the "done" feature,
>> > but it is not even worth testing; the right solution is for
>> > the helper to start using "done".
>>
>> This doesn't help anyone, and it's not even accurate. I think it might
>> be possible enforce remote-helpers to implement the "done" feature,
>> and we might want to do that later. But of course, discussing what bad
>> things remote-helpers could do, and how we should test and babysit
>> them is not relevant here.
>>
>> If it was important to explain the subtleties and reasoning behind
>> this change, it should be a separate patch.
>
> I am OK with adding the test for import as a separate patch. What I am
> not OK with (and this goes for the rest of the commit message, too) is
> failing to explain any back-story at all for why the change is done in
> the way it is.
>
> _You_ may understand it _right now_, but that is not the primary
> audience of the message. The primary audience is somebody else a year
> from now who is wondering why this patch was done the way it was.

Who would be this person? Somebody who wonders why this test is using
"feature done"? I doubt such a person would exist, as using this
feature is standard, as can be seen below this chunk. *If* the test
was *not* using this "feature done", *then* sure, an explanation would
be needed.

But why is this test doing something expected is not a question
anybody would benefit from asking.

> When
> they are trying to find out why git does not detect errors in a helper,
> and they notice that our test for failure only check the "done" case,
> isn't it more helpful to say "we considered the other case, but it was
> not worth fixing" rather than leaving them to guess?

If you are worried about such hypothetical people, they would be
better served by a comment in the source code of the test, or even
better, the c file, or even better, to document that remote helpers
should use this feature. But wait:

---
Just like 'push', a batch sequence of one or more 'import' is
terminated with a blank line. For each batch of 'import', the remote
helper should produce a fast-import stream terminated by a 'done'
command.
---

So it's already explained, if somebody fails to follow this
documentation, it's dubious a commit message that introduces a test
would help. Surely, the writer of this bad remote helper would _never_
look there.

> I may be more verbose than necessary in some of my commit messages, but
> I would much rather err on the side of explaining too much than too
> little.

I wouldn't. The only thing an overload of information achieves is that
the reader would simply skip or skim it.

>> >         export)
>> > +               if test -n "$GIT_REMOTE_TESTGIT_FAILURE"
>> > +               then
>> > +                       # consume input so fast-export doesn't get SIGPIPE;
>>
>> I think this is explanation enough.
>>
>> > +                       # git would also notice that case, but we want
>> > +                       # to make sure we are exercising the later
>> > +                       # error checks
>>
>> I don't understand what is being said here. What is "that case"?
>
> The case that fast-export gets SIGPIPE.

If we are trying to avoid SIGPIPE wouldn't that imply that git notices
the SIGPIPE?

>   # consume input so fast-export doesn't get SIGPIPE;
>   # we do not technically need to do so in order for
>   # git to notice the failure to export, as it will
>   # detect problems either with fast-export or with
>   # the helper failing to report ref status. But since
>   # we are trying to demonstrate that the latter
>   # check works, we must avoid the SIGPIPE, which would
>   # trigger the former.

# consume input so fast-export doesn't get SIGPIPE; we want to test
the remote-helper's code after fast-export.

--
Felipe Contreras
