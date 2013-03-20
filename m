From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC] Add posibility to preload stat information.
Date: Wed, 20 Mar 2013 23:19:38 +0530
Message-ID: <CALkWK0nCY3o_KW8ykq9TkzfHeVj6NKDkOFuym9UmSWLH0ZFxBw@mail.gmail.com>
References: <1363781732-11396-1-git-send-email-iveqy@iveqy.com>
 <CALkWK0=b80U5dxGMpwKwL+jFURisEuSapWuuNRFcP+5R2f3+GA@mail.gmail.com> <20130320174120.GA32426@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: spearce@spearce.org, git@vger.kernel.org, pclouds@gmail.com,
	Jeff King <peff@peff.net>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 18:50:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIN9l-0002MD-2b
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 18:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755029Ab3CTRuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 13:50:00 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:45315 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586Ab3CTRt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 13:49:58 -0400
Received: by mail-ie0-f179.google.com with SMTP id k11so2412347iea.10
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 10:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=f8QeVMjUVjKkLvq8W/pPa/kGjUxs2oDV1cbm18Rr+68=;
        b=An7hkien/u98CjmBytuMUMo34pTqA96nAhF5krFvdck9Qk5mpcCXBOaZcthVndQeFV
         V2rXvXRWIlKxsAZZU7rgLrIQH9sKkQt1B8FHzAyYwZwLX+DWZcrA+cR4vHfzuTwuNJIU
         grZY1TWEklv6jnRS4DjfIa42heA52QUeYy4jXkNRvMHSM9SEfFraHr7v3Xfv7zyaIjq5
         3J4VLTuIZ8c4N/+OHv55WHgeRYFlcGouB270g+2AKh/o9Hl4LGvotjvqC0BIEVxAYVkE
         nHN6JUchm8linz9SRIooFDN1Ehg6uQfk1w6LxD82uKsxnCaWXc+xNGSqfubGnQ5+4snc
         ZN7w==
X-Received: by 10.50.17.71 with SMTP id m7mr89766igd.14.1363801798279; Wed, 20
 Mar 2013 10:49:58 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Wed, 20 Mar 2013 10:49:38 -0700 (PDT)
In-Reply-To: <20130320174120.GA32426@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218630>

Fredrik Gustafsson wrote:
> On Wed, Mar 20, 2013 at 10:45:22PM +0530, Ramkumar Ramachandra wrote:
>> Fredrik Gustafsson wrote:
>> > When entering a git working dir, optionally run a forked process that
>> > stat all files in the whole workdir and therefore loads stat information
>> > to RAM which will speedup things like git status and so on.
>>
>> This is misleading.  You just execute the equivalent of `git status`
>> everytime I request a prompt inside a git working directory.  And this
>> is if I'm using __git_ps1() to augment my prompt, which I'm not- I use
>> ZSH's vcs_info, which is arguably better.  Also, you forgot to say how
>> to turn on the feature.
>
> The invokation place is quesionable (Junio also had some thoughts about
> that). I don't find vcs_info in the contrib/completition/. Do you have
> any suggestion about where the best way is to inwoke this kind of thing?

I think it should be a separate script in contrib/ that people can
just `eval` in their shell configs; zsh has a chpwd() function for
example, which seems like the right place to put such a thing.

> I added documentation about how to turn the feature on, in the same way
> the other features is documented. (Is there an other way/better way I
> should do this?)

No, I meant in the commit message.

>> That said, this feature is extremely gross; it thrashes my filesystem
>> and hard drive.  Modern software is written to minimize IO, not
>> maximize it!  I'm completely against the inclusion of this patch.
>
> It's extremly gross. I don't like this, _but_ it does speed up my work.
> I'm unsure if it should be included in git though (hence the RFC-tag).

Yes, I would certainly like my git startup time to be improved.  But I
don't want to trade my hard drive's life for it.

>> However, I would not mind a feature that runs `git status` the very
>> first time I enter a git working directory: when I enter my clone of
>> linux.git, it takes my first `git status` invocation a good ten
>> seconds to complete, and we can fix this pretty easily.
>
> That's the problem I try to solve. However "the first time" is
> irrelevant. We will run git status a bit before we need it. If we enter
> linux.git, do other work (in an other project) for an hour and go back
> to linux.git our cache will probably be empty. We will need to run this
> more than "the first time". But still, we don't want it to run too
> often. (Which is does now).

What I meant by "first time" is "chpwd() into the git repository, not
further chpwd()s when already inside the git repository".
