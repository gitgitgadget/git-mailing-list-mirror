From: Trevor Saunders <tbsaunde@tbsaunde.org>
Subject: Re: feature request: excluding files/paths from "git grep"
Date: Mon, 2 Mar 2015 07:50:17 -0500
Message-ID: <20150302125017.GA4464@tsaunders-iceball.corp.tor1.mozilla.com>
References: <CACsJy8AM=W4f6u_7YpvmfiBwrJjqfJMJoq6CQYfKOh+qD6rF3Q@mail.gmail.com>
 <20150225143116.GA13567@peff.net>
 <xmqqk2z5on72.fsf@gitster.dls.corp.google.com>
 <20150225185128.GA16569@peff.net>
 <xmqqbnkholx9.fsf@gitster.dls.corp.google.com>
 <20150225191108.GA17467@peff.net>
 <20150227100441.GA11861@tsaunders-iceball.corp.tor1.mozilla.com>
 <xmqqvbilh0wn.fsf@gitster.dls.corp.google.com>
 <20150301130142.GA24782@tsaunders-iceball.corp.tor1.mozilla.com>
 <xmqqr3t8fgm4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Noel Grandin <noel@peralex.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 13:51:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSPot-0004tl-OX
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 13:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749AbbCBMvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 07:51:33 -0500
Received: from tbsaunde.org ([66.228.47.254]:55512 "EHLO
	paperclip.tbsaunde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754733AbbCBMv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 07:51:28 -0500
Received: from tsaunders-iceball.corp.tor1.mozilla.com (174.141.12.210.nw.nuvox.net [174.141.12.210])
	by paperclip.tbsaunde.org (Postfix) with ESMTPSA id 46946C0B1;
	Mon,  2 Mar 2015 12:51:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqr3t8fgm4.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264591>

On Sun, Mar 01, 2015 at 03:22:11PM -0800, Junio C Hamano wrote:
> Trevor Saunders <tbsaunde@tbsaunde.org> writes:
> 
> >> ...  For these "per-invocation" differences, attributes
> >> to declare permenent/inherent nature of the contents is much less
> >> suited than per-invocation inclusion/exclusion mechanism based on
> >> pathspecs, I would think.
> >
> > I think that makes some amount of sense, however typing stuff like
> > --exclude=ChangeLog all the time is not terribly easy on the hands.
> > Would it make sense to instead add a config variable grep.exclude?
> 
> I do not think it makes much more sense for at least three reasons.
> for one thing, It still goes against "per-invocation" nature of what
> is being done.  Your "for this invocation I do not want ChangeLog"
> does not have to be limited to 'grep'.  And also "I end up having to
> give these pathspecs all the time" is not limited to negative ones.

I think what is somewhat special about grep is that I want to ignore a
set of paths such a large majority of the time that I really want to
change the default.  I could see someone wanting to do the same thing
for diff or log maybe, and so adding diff.exclude, but personally I
don't have a use for it.

> We have magic pathspecs, like "This pattern is used to match the
> string case-insensitively", "This pattern specifies that the path
> should *not* match it", etc.  How about adding a new feature that
> lets you say "This is a short hand to giving these pathspecs" and
> call that "pathspec macro"?
> 
> If you get tired to keep having to type
> 
>     $ git log -- Documentation/ ':!Documentation/technical/'
> 
> every time you want to check the end-user facing documentation
> pages, you could for example say (I am using a made-up 'macro'
> pathspec magic that is introduced by ':*' followed by a <macro
> name>):
> 
>     $ git log -- ':*userdoc'
> 
> and the same macro specification could be used for all the other
> things that take pathspecs (grep, add, diff, etc.).

I can certainly see use cases for that, say
git log -- :!t/ :!foo/tests/ :!bar/testsuite/
to see what non test changes have happened in a project that doesn't
have a standardized name for test directories.

> You could then have something like this to define your own "nolog"
> macro:
> 
>     [pathspecMacro]
>         nolog = ':!ChangeLog' ':!ChangeLog.*'
> 
> to shorten your invocation of "grep" by appending it when you want
> to exclude some files, i.e.
> 
>     $ git grep -e pattern -- \*.c ':*nolog'
> 
> and the same pathspec macro can be used in other places, not just
> "grep".  Wouldn't it make more sense?

I think they solve somewhat different problems, but maybe my problem is
so specialized I should just have a wrapper around grep that changes
defaults.

Trev
