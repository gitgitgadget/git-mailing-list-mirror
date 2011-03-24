From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH 1/1] gitweb: javascript ability to adjust time based on
 timezone
Date: Thu, 24 Mar 2011 00:21:37 -0700
Message-ID: <4D8AF101.7030709@eaglescrag.net>
References: <dab08d0ff27b0f571a17ed4f1ab0f39b@localhost>	<1300925335-3212-2-git-send-email-warthog9@eaglescrag.net> <AANLkTincAcVQQtH+T9+K7tyBd0P5S=8YxXpsfrQ=68gE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jnareb@gmail.com, gitster@pobox.com
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 08:21:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2erg-00062J-Nx
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 08:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933295Ab1CXHVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 03:21:47 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:33182 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933034Ab1CXHVq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 03:21:46 -0400
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p2O7Lbpo031446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 24 Mar 2011 00:21:37 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <AANLkTincAcVQQtH+T9+K7tyBd0P5S=8YxXpsfrQ=68gE@mail.gmail.com>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 24 Mar 2011 00:21:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169896>

Going to make some quick comments on this, try and get things more along
tomorrow (mainly just wanted to get this out today so the commentary
could start)

On 03/23/2011 10:23 PM, Kevin Cernekee wrote:
> On Wed, Mar 23, 2011 at 5:08 PM, John 'Warthog9' Hawley
> <warthog9@eaglescrag.net> wrote:
>> This patch takes the same basic goal, display the appropriate times
>> in a given timezone, and implements it in Javascript.  This requires
>> adding / using a new class, dtcommit, which is based on the
>> dtstart/dtend microformats.  Appropriate commit dates are wrapped in
>> a span with this class, and a title of the time in ISO8601 format.
> 
> John,
> 
> Thanks for coding this up.  I tested it on a couple of different
> browsers and wanted to share my observations with you.
> 
> First, the easy stuff:
> 
> 1) "git am" complains about whitespace violations

I'll take a look at that, there wasn't any when I created it...

> 2) HH:MM:SS times need zero padding; otherwise you see:
> 
> Tue, 8 Mar 2011 20:29:9 -0700

That's a bit more exciting, the specs I have say that shouldn't happen
(but then again this is Javascript so all bets are off).  Ok I see
what's wrong, the documentation isn't quite as clear - yeah may just
need to add a proper lpad() function to the common-lib.js, why that
isn't standard in Javascript...

> 3) Some of the Javascript functions are double-indented, others single-indented.

I'm not sure what you are seeing here, all of the javascript files I
have on my machine, "function" starts in column 0 of a new line, if you
are seeing anything other than that you've got something wrong somewhere
(mail client adding random spaces?)

for the record:

$ sha1sum *
56eefe528306bfa9d8e3aad9c6a379227e8d9c72  common-defs.js
c2379d9440fa471879e99317c0bfdc1607759927  common-lib.js
901c3705d0629b3836f4fab56694c4e2120cb036  cookies.js
cb220d94a5e762d2bd53af47040769e22ebf513b  date.js

If you aren't getting that, you have something wrong.

> 4) IE6 does not seem to like ISO 8601 format:
> 
> x = new Date("2011-03-09T03:29:09Z");
> 
> This sets all fields to NaN.  I suspect that getTime() values
> (milliseconds since 1970-01-01) are more portable.

That's actually an issue, my understanding (as well as the understanding
of all of the microformats that are out there) is that ISO 8601 is the
"correct" format that these things should be in.  If IE6 can't handle
that (and I'll admit I don't have trivial access to older IEs for
testing right now), then there is a *LOT* of Javascript out there that
is just broken.

Going a bit further, I would draw the line in the sand for gitweb
supporting IE as a browser somewhere around IE 7 or 8 at this point as well:

http://www.w3schools.com/browsers/browsers_explorer.asp

IE 5, 6 & 7 look to have negligible market share at best as it is, and
I'm not sure it's worth trying to go back and support IE6 or anything prior.

> I have attached a trivial patch for these four items; it applies on
> top of your original submission.

I'll dig into that tomorrow.

> Some other things that popped up:
> 
> 5) Some timezone offsets are not a whole number of hours.  Bangalore
> time is GMT +0530, for instance.

The code is capable of handling this, it's mainly an issue of interface,
which I'll bring up in response to 6 & 7

> 
> 6) Most U.S. timezones honor daylight savings, so they could be
> something like -0700 for part of the year, and -0800 for the rest of
> the year.  Picking the "local" option would automatically adjust for
> this, but DST limits the usefulness of permanently storing a fixed TZ
> offset in the cookie.

If you choose local, you will always get the local that the machine is
set at.  More on that in #7 answer.

> 
> 7) Looking at a pre-DST commit after DST (or vice versa) can be a
> little confusing:
> 
> Tue, 8 Mar 2011 20:29:09 -0700 + (19:29 -0800)
> 
> I'm not sure which time to believe.  (Although it's likely that a few
> weeks after a commit, the exact hour doesn't matter.)

Ok this is a bit of an answer to questions 5, 6 & 7 - the simple thing
is, time zones are unbelievably complicated, esoteric and just a
freaking nightmare.  In the US alone there are 4 time zones + DST + a
pile of exceptions that don't follow DST or follow DST in weird ways
(like it starts an hour later, or earlier, etc).

Trying to encompass all of those rules, which change on a frequently
enough basis that I'm not sure we want to spend all of our time fixing
and updating timezone issues, but this makes things:

	1) going to be impossible (see 3)
	2) going to require a *MUCH* more complicated user interface
	3) going to require that Javascript have a date library that
	   can actually handle timezones in some sane manor.

I would wager that the most used / useful setting for most people will
be to select 'local' and run with that (which is what the default is set
to) since that can take advantage of the system's inbuilt idea of what
the correct utc offset should be.

What I've provided now is the obvious and simple interface, and while it
ignores the more esoteric situations (and dst all together), the core of
the algorithm will happily take any offset you want and it will work.
Heck at one point in my testing I accidentally was using a 5 minute
offset, which was slightly amusing.

Adding in the 1/2hr offsets would not be hard, and it was something I
had thought about earlier today in fact.  Basically in the for loop that
creates the drop down add in some special cases to get the correct half
hour offsets, but at it's core you are still choosing the offset manually.

The only way you could get all of the timezones is to more or less mimic
the interface that every OS uses to select your time zones: provide a
clickable map, or a very long list of cities to choose from.

However even if we made the user interface significantly better (I'll
admit I kinda like it's simplicity and straightforwardness) we have the
problem that Javascript's inbuilt date class is woefully inadequate, and
we would either have to build our own, or go to a 3rd party and make
this feature dependent on outside javascript libraries.

I'm ok with the later, but I'm not keen on doing the former if we can
help it.  Why?  I'm not prepared to deal with the 1722 timezones that
exist, each with their own exciting rules.

> 8) The " + " popup menu is a little quirky.  On FF 3.6 it partially
> collapses after selecting a value from the dropdown.  On IE6 it shows
> "Error in parsing value for 'display'" and does not render.  On Opera
> 11 it seemed to work OK.
> 
> Firefox breakage: http://img217.imageshack.us/f/firefoxa.png/

I hadn't seen it that badly in Chrome (what I've been testing with), but
I'll admit the way I've implemented the onclick with that can be messy.
 I need to look around and find a few more ways to handle that and see
what I can come up with.

> I'm wondering if there might be a better place on the page to put the
> TZ selection.  It isn't immediately obvious to the user what the extra
> " + " does, and it seems to cause some issues.

I haven't really come up with a better place, there's no settings
dialogue for gitweb, and I wold agree that the + isn't really indicative
(just seemed like a good way to get it in there for now).  I had thought
of using a graphical icon, maybe like the (i) for information perhaps,
but yeah, not sure how to handle that currently.

> If you decide to keep it where it is, you might want to consider
> absolute or fixed positioning so that other elements do not wrap
> around it.  IOW it would work more like the dropdown menus on many
> sites.

That actually gives me an idea on how to handle that better, well at
least one possible way.  I'm open to suggestions on how to improve that
interface, I'm a backend server person for the most part, not a UI
designer or HCI expert.

I'm happy to mock things up or try things out, but I don't have any
better suggestions for how to handle that :-/

> The timezone fixup javascript seemed to work reasonably well, except
> for the hiccup with IE6.  Maybe it would be worth splitting this into
> two patches: one to rewrite the timestamps, and a second one to add
> the TZ selection interface.

Dunno, this is a pretty small and self contained set of patches as it is
and separating the selection interface only really removes two functions
from the first commit.  I'll look into it though, see if there's a
reasonably logical way to break this up into smaller pieces.

- John
