From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git commit generation numbers
Date: Fri, 15 Jul 2011 09:44:21 -0700
Message-ID: <CA+55aFw_XjWm+4XwsN6CRJnsrcEu5YEChOHSHN51UUBN6PynWw@mail.gmail.com>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
 <20110714183710.GA26820@sigill.intra.peff.net> <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
 <20110714190844.GA26918@sigill.intra.peff.net> <CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
 <20110714200144.GE26918@sigill.intra.peff.net> <69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
 <20110714203141.GA28548@sigill.intra.peff.net> <CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
 <20110715074656.GA31301@sigill.intra.peff.net> <CA+55aFzS3KDNvKt-dXvYpuAQwFwD3+GCj8y8bRQCycPvrynT8Q@mail.gmail.com>
 <CAJo=hJtuxNLhSjn_sDJxG7xu5k2wbJ_QLf_n+Z1E=o2AndAuJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 18:44:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhlVU-0004Zs-0G
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 18:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893Ab1GOQor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 12:44:47 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54874 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753852Ab1GOQoq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jul 2011 12:44:46 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p6FGih1h003626
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 15 Jul 2011 09:44:45 -0700
Received: by wwe5 with SMTP id 5so1468330wwe.1
        for <git@vger.kernel.org>; Fri, 15 Jul 2011 09:44:41 -0700 (PDT)
Received: by 10.216.38.76 with SMTP id z54mr3349164wea.102.1310748281100; Fri,
 15 Jul 2011 09:44:41 -0700 (PDT)
Received: by 10.216.158.65 with HTTP; Fri, 15 Jul 2011 09:44:21 -0700 (PDT)
In-Reply-To: <CAJo=hJtuxNLhSjn_sDJxG7xu5k2wbJ_QLf_n+Z1E=o2AndAuJQ@mail.gmail.com>
X-Spam-Status: No, hits=-102.888 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177204>

On Fri, Jul 15, 2011 at 9:18 AM, Shawn Pearce <spearce@spearce.org> wrote:
>
> What about going forward making the requirement that a new commit must
> have a committer date whose date is >= the maximum date of its
> parents?

So you suggest just making commit dates be the generation number.

I'd be ok with that. It's basically what we've been doing for the last
six years.

But in that case, we shouldn't be doing the generation count cache either.

Btw, I do agree that we probably should add a warning for the case
("your clock is wrong - your commit date is before the commit date of
your parents") and maybe require the use of "-f" or something to
override it. That would certainly be a good thing quite independently
of anything else. So regardless of generation counts, it's probably
worth it.

But if you think commit date is good enough for generation counts -
and I'm not arguing against it - then please tell me why you would
then want to have a separate generation count cache.

So I would like to repeat: I think our commit-date based hack has been
pretty successful. We've lived with it for years and years. Even the
"let's try to fix it by adding slop" code is from three years ago
(commit 7d004199d1), which means that for three years we never really
saw any serious problems. I forget what problem we actually did see -
I have this dim memory of it being Ted that had problems with a merge
because git picked a crap merge base, but that may just be my
Alzheimer's speaking.

Obviously there are cases where we miss some merge base and it doesn't
really end up mattering, so we may well have a *ton* of commits that
have bad dates, but they just haven't affected us enough for us to
care. That's fine too - I dislike how our algorithm isn't truly
reliable, but at the same time I think we're so robust that it all
works regardless.

So I think it's ugly and fairly hacky, but it has worked well enough
in practice. I dislike our commit dates, but I don't _hate_ them. I do
think it was a mistake, but not one I'm especially ashamed of.

So why do I dislike the generation count cache so much? I dislike it
exactly because

  "if the commit date isn't good enough, then dammit, we should have
just added a generation count".

And if we should have added it six years ago, then we should add it
today. Not say "oh, we made a mistake six years ago, let's work around
the mistake instead of fixing it".

That's really what it boils down to. Let's not paper over a mistake.
Either we need the generation depth or we don't. And if we do need it,
we should replace the date-based hackery with it (where "replace" may
well be "still fall back on our traditional date-based hackery in the
absense of generation counters").

But if we decide that we don't really need generation counters AT ALL,
and can just continue with the commit date hack, then I'm personally
ok with that too.

So to me, it's a "either or" situation. Either the commit dates are
good enough, or we should add generation counts to the commits.

But in *neither* case is it ok to do some external cache to work around it.

                          Linus
