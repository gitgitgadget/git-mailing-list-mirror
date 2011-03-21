From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v4 2/2] gitweb: introduce localtime feature
Date: Mon, 21 Mar 2011 01:20:49 +0100
Message-ID: <201103210120.50337.jnareb@gmail.com>
References: <ab54ba2199cc7487e383a31e3aa65885@localhost> <dab08d0ff27b0f571a17ed4f1ab0f39b@localhost> <4D8681CF.3060005@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Kevin Cernekee <cernekee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 01:21:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1Sro-0007Hs-81
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 01:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237Ab1CUAU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 20:20:59 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33765 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab1CUAU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 20:20:58 -0400
Received: by wya21 with SMTP id 21so5331285wya.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 17:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=wB9EkVaBKcaa/RSpKsuW0CYt3fsmTP/np3tB9r2UNFE=;
        b=M8Sv66QCXMSwiUQeOWa57URi2lhExnEqWpWNm3J0oTuBSzc5f6iOfI6c9HOcUQMrV+
         VFfflYJkjAg/ktEfavn3QmYiCI73VNGKj8sqvwF8sJUDTBS1WmBuzc+PyvNrZlHj3rXv
         TpLUMWS7Kz7NCCHxrTkJiMVdYq4ohVXpTQxrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=eG5kNAWetyjwaXcwA0cDhq/q0rVYekbBx38EKQ6Uot0GIQ3BAY8P++coAIr5n4dcAL
         Q5Tj8whjQqT+pmyji6xG7L59gAPOHaSbeq9gVH1RdyGOPt/8rbFGOF6zxeZpXNToniII
         PaQlKG8YlBY0hrrMbTEEmBirzZMkux+1DF92c=
Received: by 10.216.134.230 with SMTP id s80mr3238522wei.74.1300666857090;
        Sun, 20 Mar 2011 17:20:57 -0700 (PDT)
Received: from [192.168.1.13] (abwj177.neoplus.adsl.tpnet.pl [83.8.233.177])
        by mx.google.com with ESMTPS id f52sm2387861wes.11.2011.03.20.17.20.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Mar 2011 17:20:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4D8681CF.3060005@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169538>

On Sun, 20 Mar 2011, J.H. wrote:

> > With this feature enabled, all timestamps are shown in the local
> > timezone instead of GMT.  The timezone is taken from the appropriate
> > timezone string stored in the commit object.
> 
> I'd argue there are two types of "local" time that anyone using gitweb
> would be looking for (particularly if this is called local time)
> 
> 1) Time Local to the observer:  Specifically I don't care where every
> other commit has taken place, I want to know what time it was in my
> preferred time zone (local time zone likely)

This can be done only via JavaScript, otherwise how would you get user's
timezone?  Well, you could specify timezone via a form, save it in
a cookie and do conversion to timezone from cookie on server... but this
means more code, and would screw up with output caching if/where 
implemented.
 
> 2) Time local to the project:  There will be instances where a project
> is based in a specific time zone (home office perhaps?) and you will
> want to see the commits from that perspective.

Kevin's patch assumes that geographically concentrated project means all
or almost all commits are generated "in office" and use the same timezone,
which is a timezone of a project.

Currently there is no way to specify _project_ timezone.  Perhaps instead
of 'localtime' feature, which since v2 means also per-project 
`gitweb.localtime' configuration variable, we would allow for 
`gitweb.timezone' configuration variable, which can be "gmt", "utc", or
"localtime" (meaning local to author / committer / tagger).

What do you think?
 
> The patch itself (as a commit in gitweb) shows the time + TZ (which is
> somewhat useful), but there is something quite useful about the rest of
> gitweb only handling a single timezone (GMT/UTC) from the backend (I'll
> come back to this point), if for no other reason it makes for uniform
> handling of time overall.

Single timezone (currently GMT/UTC, perhaps made configurable, perhaps
made client local via JavaScript) is good to compare dates.  Author local
time is good to notice "atnight" commits.

[...]
> > This change does not affect relative timestamps (e.g. "5 hours ago"),
> > nor does it affect 'patch' and 'patches' views which already use
> > localtime because they are generated by "git format-patch".
> 
> Agreed.

[...]
> Ok, while I agree with the use case(s) I think the solution is barking
> up completely the wrong tree.  My basic complaint is that this is a
> change that effects the backend and ties the backend to a specific TZ,
> when this is a front facing / client issue.
> 
> While I don't always like JavaScript, this is a situation where I think
> it would be a much better solution than doing some extensive changes to
> time handling in gitweb.
> 
> Basically the change would leave things alone should this be disabled
> (you are already doing this, which is good), however should this be
> enabled a couple of minor things change:
> 
> 	1) By default gitweb will continue to display things in UTC.
> 	   This is a good fallback, and a reasonably safe thing to do
> 	   should someone have JavaScript disabled.  The reality is
> 	   most users with it disabled will know or understand what to
> 	   do with UTC times
> 
> 	2) Keep the original TZ marked in the html, somewhere hidden on
> 	   the page is fine

We can use what microformats use for date, i.e. 1997-07-16T19:20:30+01:00
or 1997-07-16T19:20:30+0100, in 'date' or 'title' attribute (with 
appropriate microformat class)... or we can use raw git date, i.e. epoch
plus numerical timezone.
 
Note that JavaScript mangling of dates is quite independent on whether
dates are displayed in GMT/UTC or in author / committer / tagger timezone
like for current 'localtime' feature.

> 	3) Once a page is loaded attempt to execute the Javascript,
> 	   which will just cycle through the page and update the Date /
> 	   Times based on a set of possible (though user choosable
> 	   options):
> 		- Local Time (could easily default to this and
> 		  JavaScript can detect that from the browser)
> 		- Specific Timezone
> 		- Default / UTC
> 		- Original Timezone (from author / commit)

Hmmm... we could also automatically update relative dates to reflect
passing of time ;-)

> 	   Could easily include the original timestamp / utc if
> 	   Javascript modifies it.  Easy enough to just automatically
> 	   store the choice (should one be made) in a cookie in the
> 	   browser, and give the maintainer of the site and easy way
> 	   to set a rational default given their specific environment.
> 
> The obvious advantages:
> 	- Doesn't give weird data to people behind caching proxies
> 	- Ability for people working diverse timezones to see things
> 	  in their local time zone pretty trivially
> 	- If a site is using gitweb-caching they can take advantage
> 	  of the feature
> 	- Won't break bots / scripts that may be crawling the pages or
> 	  reading the rss feeds (because the timestamps will all be the
> 	  same assuming it doesn't try to render the javascript)
> 
> If you are interested I can bang that out tomorrow (shouldn't take
> long), but I would *MUCH* rather see this done via JavaScript than to
> muddy up the backend with multiple timezones and such.

Note that we would have to write this JavaScript code...

-- 
Jakub Narebski
Poland
