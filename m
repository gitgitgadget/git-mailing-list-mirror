From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: Re: [PATCH] tag: add -i and --introduced modifier for --contains
Date: Fri, 18 Apr 2014 16:17:38 -0700
Message-ID: <CAB=NE6Vt8etieyR256Hxb=q6zMo7UAO2Zkm5900NrE+4=-3eXA@mail.gmail.com>
References: <1397681938-18594-1-git-send-email-mcgrof@do-not-panic.com>
 <xmqqppkhexw3.fsf@gitster.dls.corp.google.com> <CAB=NE6VvDrMQ4ybF10MpXM-2672OdUTC_Rp2mdO3a5fuo1-H1Q@mail.gmail.com>
 <xmqqfvlbga4r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
	Andreas Schwab <schwab@suse.de>, Jan Kara <jack@suse.cz>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 19 01:18:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbI2n-0004ns-UE
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 01:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495AbaDRXSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 19:18:01 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:49809 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbaDRXSA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 19:18:00 -0400
Received: by mail-lb0-f180.google.com with SMTP id 10so1753263lbg.11
        for <git@vger.kernel.org>; Fri, 18 Apr 2014 16:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=BrLcyelWazV+vcRLTy+jx2V+/w9McgEhgUX7cNJx8WM=;
        b=E9cojUG6j8x+lwgXhsIlnqILjuEpWBaDYZ4vo9mjqY97/vfg+usQszQbxVaLy4ZEMK
         vgqutw9bVNKWdiTznwZMqemR52xtsqYzj9iH8iywKU3QZ0qYHhLwkfCi18zrHCm4i+rW
         qC7n0glStVD9gkYWPjgQ0TwbodK7Pn2qfAGCPjsqaahaQmLAQSmLDp/vvJRwSkZA5qQc
         m+55XlOV+ITslzME2OSK5jcqnqMPkGKL/lPMutJcjHTCSohBlRm/cCjalTFDwNaPHtiJ
         Dw2SM9dej8L9DVD9YVl1l/7BCAH0ybgmJFWazPPyAPdppWOdN05fBi5qH4H+p10+UXP5
         3arg==
X-Received: by 10.112.85.6 with SMTP id d6mr12340282lbz.8.1397863078428; Fri,
 18 Apr 2014 16:17:58 -0700 (PDT)
Received: by 10.112.215.74 with HTTP; Fri, 18 Apr 2014 16:17:38 -0700 (PDT)
In-Reply-To: <xmqqfvlbga4r.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: eH-kQutvrveuA2Ejs-X_P5YFnu8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246487>

On Thu, Apr 17, 2014 at 10:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Luis R. Rodriguez" <mcgrof@do-not-panic.com> writes:
>
>>> And between v3.4 and v3.5-rc1, the latter is a closer anchor point
>>> for that commit (v3.5-rc1 only needs about 200 hops to reach the
>>> commit, while from v3.4 you would need close to 500 hops),
>>
>> Ah! Thanks for explaining this mysterious puzzle to me. I'm a bit
>> perplexed why still. Can I trouble you for a little elaboration here?

< Junio gives a great huge example>

Phew! Thanks for the elaborate explanation, this makes perfect sense now!

> Now, as to what *SHOULD* happen, I think the above exercise shows us
> a way to define what the desired semantics is, without resorting to
> heuristics (e.g. "which tag has older timestamp?" or "which tag's
> name sorts older under Linux version naming convention?").

I think ultimately this reveals that given that tags *can* be
arbitrary and subjective, and given that clocks can also pretty much
arbitrary 'git describe --contains' can and probably only should do
best effort (TM) and perhaps one thing to help is documenting this
issue well and provide a set of best practices that are supported for
tagging schemes. I can't describe how many libraries I've reviewed
about software versioning schemes and most of them support a huge
array of things, and funny enough the Linux versioning scheme, was not
supported well, for something so simple as versioning sort. This is
ultimately why I had to implement my own sort solution on rel-html. If
we agree on this we could just for example take on the Linux
versioning scheme as an emum and document that well both on code and a
wiki. More on this below.

With regards to timestamps: care must be taken given that we'd be
assuming that clocks are synchronized, this can likely yield incorrect
results on a distributed development environment with different time
zones, and it can also be easily cheated, which is why I was concerned
over using timestamps. Its still certainly something that can be
considered, but I've heard enough rants of a few maintainers about
crazy dates on patches which makes me believe this could actually be
an issue, specially if we speed up development and need higher degree
of resolution.

I know the above example but its perhaps worth mentioning how Linux
does not follow the above development model for merging stable fixes
or changes though, but it does not prevent folks from branching off of
older tags to do development which Linux will then pull. In Ingo's
case the issue then points then I think to another mild issue -- the
commit was developed on a v3.3 based tag, which is why 'git describe
--first-parent c5905afb' yields v3.3-rc1-41-gc5905af and not v3.4,
which *can also* be a bit perplexing if one does not understand the
above example you provided can be used for a development work flow for
code sent out to Linus. That said then, since we don't follow the
model you laid out it still reveals another issue, and I am not yet
sure I still understand why --contains yields a v3.5 tag in that case
since we ensured commits on v3.5 were already piled up on older
releases, or were being introduced newly on its own release. It smells
to me that the commit's first parent (which can be anything) is used
somehow here as a shortcut ?

This doesn't mean we can't use the work flow above for merging changes
from say a v3.4.x onto a v3.5 -- but we don't -- and perhaps as part
of the documentation about a scheme for Linux, we should advise
against such practices. In any case the closest thing I see we can use
upstream on Linux is 'git cherry-pick -x <commit-id>' but Greg doesn't
seem to use this and instead appends the commit with the respective
commit ID of the upstream gitsum. Both strategies yield different
commit IDs anyway, so neither practice should interrupt the 'git
describe --contains' practice. In the stable branches to find out when
a commit was introduced one would not rely on the commit ID on the
stable branch but instead of the commit ID of the 'upstream
reference'.

> Commit A can be described in terms of both v3.4 and v9.0,

And in the real example case, why *would* c5905afb' be be described in
terms of v3.5 instead of v3.4 ?

> and it may
> be closer to v9.0 than v3.4, and under that definition "we pick the
> closest tag", the current "describe --contains" behaviour may be
> correct, but from the human point of view, it is *WRONG*.

Yeap, if a development work flow does not follow a strict pattern
(maybe a .git/config variable?) perhaps 'git describe --contains'
should spit out a the few tags it does have?

> It is wrong because v9.0 can reach v3.4.  So perhaps the rule should
> be updated to do something like:
>
>     - find candidate tags that can be used to "describe --contains"
>       the commit A, yielding v3.4, v3.5 (not shown), and v9.0;

Sure.

>
>     - among the candidate tags, cull the ones that contain another
>       candidate tag, rejecting v3.5 (not shown) and v9.0;

Sounds good to me but that seems to stick the output to a scheme, ie,
would it support schemes without a v prefix for tags? In other words,
perhaps do this only for Linux scheme?

>     - among the surviving tags, pick the closest.
>
> Hmm?

Sounds good to me!

  Luis
