From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v4 2/2] gitweb: introduce localtime feature
Date: Mon, 21 Mar 2011 17:01:00 +0100
Message-ID: <201103211701.01785.jnareb@gmail.com>
References: <ab54ba2199cc7487e383a31e3aa65885@localhost> <201103210120.50337.jnareb@gmail.com> <4D86B968.9030304@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Kevin Cernekee <cernekee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 17:01:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1hYH-0002RN-6l
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 17:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661Ab1CUQBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 12:01:46 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54078 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644Ab1CUQBn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 12:01:43 -0400
Received: by bwz15 with SMTP id 15so5134460bwz.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 09:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=e3JOdn+zSE9wE3qOghaf6v+6n4RJaQlMu1iagpaEl4w=;
        b=rRy58iTO3MzDkGLyctUNA0Wvpjxwxn7WjCPoOQLxIq55xHwXLaH0Jwv5E/luhqfmd2
         dyMtLx9Vx3cV1pR4BF+vCQZoFOx0TaXxIUheqnu3o+7YEho84/qRk3+eRbdVOepuw+p5
         Xj4NXht3VnjxMsyqg6hNEdSbX1Q/5ZSZ+7wIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=MaovTEzu4yrB4N9cF9bSZoM/sQkA97qD/es9o3/BN2eGPXGDUow+n3xtNcDfRyiVC4
         f/C/D47sVZ3pb0sUS8I8D1/ovxdNE1yaZ78is0APJw2LAU/6w5e+OXC+bWSnL1ueES6Q
         qxWnqX3FRkJ3VqMazea6zgfyAi1ytRiKc0rUQ=
Received: by 10.204.19.70 with SMTP id z6mr2607935bka.204.1300723273461;
        Mon, 21 Mar 2011 09:01:13 -0700 (PDT)
Received: from [192.168.1.13] (abvo154.neoplus.adsl.tpnet.pl [83.8.212.154])
        by mx.google.com with ESMTPS id u23sm4438339bkw.9.2011.03.21.09.01.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 09:01:09 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4D86B968.9030304@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169605>

On Mon, 21 Mar 2011 at 03:35, J.H. wrote:
> On 03/20/2011 05:20 PM, Jakub Narebski wrote:
>> On Sun, 20 Mar 2011, J.H. wrote:
>> 
>>>> With this feature enabled, all timestamps are shown in the local
>>>> timezone instead of GMT.  The timezone is taken from the appropriate
>>>> timezone string stored in the commit object.
>>>
>>> I'd argue there are two types of "local" time that anyone using gitweb
>>> would be looking for (particularly if this is called local time)
>>>
>>> 1) Time Local to the observer:  Specifically I don't care where every
>>> other commit has taken place, I want to know what time it was in my
>>> preferred time zone (local time zone likely)
>> 
>> This can be done only via JavaScript, otherwise how would you get user's
>> timezone?  Well, you could specify timezone via a form, save it in
>> a cookie and do conversion to timezone from cookie on server... but this
>> means more code, and would screw up with output caching if/where 
>> implemented.
> 
> I think this would screw up less caching vs. more caching w/ Javascript.
> Without doing this with Javascript having any hard coded timezone like
> what's proposed here is bad, particularly if for some reason two people
> can select different time zones for whatever reason (not an unreasonable
> extension of what's been proposed)

First, it would complicate caching, as output would depend not only purely
on URL, but can also depend on cookies.  Cache key would have to take it
into account.

Second, it would reduce effectiveness of cache, as single page would have
to have multiple versions (up to 24, one per timezone, I guess).

>>> 2) Time local to the project:  There will be instances where a project
>>> is based in a specific time zone (home office perhaps?) and you will
>>> want to see the commits from that perspective.
>> 
>> Kevin's patch assumes that geographically concentrated project means all
>> or almost all commits are generated "in office" and use the same timezone,
>> which is a timezone of a project.
>> 
>> Currently there is no way to specify _project_ timezone.  Perhaps instead
>> of 'localtime' feature, which since v2 means also per-project 
>> `gitweb.localtime' configuration variable, we would allow for 
>> `gitweb.timezone' configuration variable, which can be "gmt", "utc", or
>> "localtime" (meaning local to author / committer / tagger).
>> 
>> What do you think?
> 
> Not specifically thinking of setting a per-repo timezone, when I was
> thinking of "project" I was thinking of the entire gitweb install (I.E.
> git.kernel.org as a project or pkgs.fedoraproject.org or drupal.org as a
> project)

Well, if we are doing it on server side, then by having 'timezone' feature
rather than 'localtime' one from Kevin patches, we would have per-repo
configuration "for free".

> I would think, if we are doing this in JavaScript, that this is an over
> complication to do on a per-repo basis.  I would guess setting a generic
> default and letting people deviate makes more sense.  Just my thought
> anyway, but I think there's a lot of extra per-repo configurations that
> add complexity with minimal gain.

It it is set _by client_, then of course it doesn't make much sense to
make it configurable per-repository.  Besides it would be difficult to
implement and store in JavaScript, I think.

Per-repository settings makes sense for _server-side_; different 
repositories may have different character: some might be geographically
distributed, some might have all contributors in single timezone.

[...]
>>> Basically the change would leave things alone should this be disabled
>>> (you are already doing this, which is good), however should this be
>>> enabled a couple of minor things change:
>>>
>>> 	1) By default gitweb will continue to display things in UTC.
>>> 	   This is a good fallback, and a reasonably safe thing to do
>>> 	   should someone have JavaScript disabled.  The reality is
>>> 	   most users with it disabled will know or understand what to
>>> 	   do with UTC times
>>>
>>> 	2) Keep the original TZ marked in the html, somewhere hidden on
>>> 	   the page is fine
>> 
>> We can use what microformats use for date, i.e. 1997-07-16T19:20:30+01:00
>> or 1997-07-16T19:20:30+0100, in 'date' or 'title' attribute (with 
>> appropriate microformat class)... or we can use raw git date, i.e. epoch
>> plus numerical timezone.
> 
> Well we already have the time in the html, it's just the original TZ
> that would need to get added.  Though it's still likely easier to store
> the timestamp + tz than use the microformats in the JS.

I agree that epoch + timezone should be easier to manipulate in JavaScript
than ISO-8601 or similar format... I think.  Note that at least with epoch
timezone is necessary only if you want to display date in author etc. zone;
if you want to use client (web browser) timezone, it is not necessary.

Note that _where and how_ timestamp is stored for JavaScript manipulation
would become gitweb API as much as its links are.  I wonder if HTML5 says
anything on attribute values used for machine-readable data; microformats
site says that using "title" for non human-readable stuff is deprecated
for accessibility reasons.

>> Note that JavaScript mangling of dates is quite independent on whether
>> dates are displayed in GMT/UTC or in author / committer / tagger timezone
>> like for current 'localtime' feature.
> 
> I wasn't intending to change the current formatting of the times we have
> in place currently.  Just allowing people to change what time was being
> displayed.

I wanted to say that JavaScript post-processing of dates is a bit 
orthogonal to David's server-side localtime (or similar) feature.

>>> 	3) Once a page is loaded attempt to execute the Javascript,
>>> 	   which will just cycle through the page and update the Date /
>>> 	   Times based on a set of possible (though user choosable
>>> 	   options):
>>> 		- Local Time (could easily default to this and
>>> 		  JavaScript can detect that from the browser)
>>> 		- Specific Timezone
>>> 		- Default / UTC
>>> 		- Original Timezone (from author / commit)
>> 
>> Hmmm... we could also automatically update relative dates to reflect
>> passing of time ;-)
> 
> Yup, which could also go into changing the "22 minutes ago" kind of
> stuff in real time (beyond just dates).  Bonus to cached pages.

...though this should probably made it into separate commit.
 
-- 
Jakub Narebski
Poland
