From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSOC idea: build in scripts and cleanups
Date: Mon, 11 Apr 2011 01:34:44 -0500
Message-ID: <20110411063444.GA6608@elie>
References: <201103260141.20798.robert.david.public@gmail.com>
 <20110328142121.GB14763@sigill.intra.peff.net>
 <201103301739.12691.trast@student.ethz.ch>
 <201104040943.10030.robert.david.public@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Robert David <robert.david.public@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 08:34:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9AiB-00067x-0F
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 08:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720Ab1DKGey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 02:34:54 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34215 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079Ab1DKGex (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 02:34:53 -0400
Received: by iyb14 with SMTP id 14so5313386iyb.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 23:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=zUMUjT1UzYW8LkUO61zTvYh+zl8rh6wnHSEa01DZalM=;
        b=XntPFNaxBO5M/JBZcHAxgCITCp15VNY5NOyDREYMF2HK6NZCjMckMsBOK0GjlHcqUc
         Gz8Z9O2mEH886/gEEntPCvuc/sR/mNAjJFurL8WdqdB+JZXiAXR18cGzAiElILj3HiMd
         pA0WExQP0zwVtsFfYA0ErG+Vn/GuT5UCrbmsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YLhehHckRLyeiRbMfNGamUDgS5ACmGatO68uu3nQ5HwLU9bTIkF9u5CBzXjQ6Xdult
         y2EkeDZR4FUkH/bMkAyGE7Js1uU8okgrVyW5e5kDFK3tbEDcTXajtMbqrL/NypOWbQN9
         GAag7JoZcdpz3uNZDA/K6OpHjZ/Z94u94Byfs=
Received: by 10.43.59.12 with SMTP id wm12mr7607970icb.321.1302503693006;
        Sun, 10 Apr 2011 23:34:53 -0700 (PDT)
Received: from elie (adsl-69-209-51-92.dsl.chcgil.ameritech.net [69.209.51.92])
        by mx.google.com with ESMTPS id i26sm2908620iby.24.2011.04.10.23.34.49
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 23:34:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201104040943.10030.robert.david.public@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171309>

Hi,

Robert David wrote:

> I'm sending copy of my proposal to ml.

Thanks, and sorry for a slow response.

Full disclosure: I locally use a patch[1] to teach a --patience option
to add -p, checkout -p, etc (to use the "patience diff" algorithm).  I
never submitted it since it wasn't clear to me how to integrate it
(and other diff options) properly.  I will be very happy to see a
cleaner add--interactive.

So I'm a likely early consumer of your code, although I don't think
I'll have time to co-mentor.  Luckily there seems to be no shortage of
willing mentors.

Some quick impressions.  This is off-the-cuff; please feel free to let
me know if something sounds crazy.

> Today git code consists of the base written in C and many helper shell or PERL 
> scripts. While at a first time it is easier to write the script, final code is 
> supposed to be in C. One of these scripts is git-add--interactive. 
[...]
> But before that, it is need to clean and extend the current git-add--
> interactive, to serve user needs at the best. 

I see two goals in tension: (1) to integrate add--interactive as C
code, and (2) to clean it up and change its feature set.  Either one
could happen without the other, and for planning it would be useful to
know which is going to drive decisions (e.g., what if time is short
and something has to get cut?).

If (1) is the main goal, it might be easiest to first translate the
existing code, perhaps modulo small preparatory changes that make the
translation easier, into C and leave major changes for afterwards.
Tracking down bugs due to a major change (like switch in
implementation language) is a lot easier if the pre-change version is
well tested and well understood.

If (2) is the main goal, it might be easiest to rewrite small parts of
add--interactive in C where convenient rather than rewriting the whole
thing.  In that story, the result is a series of small patches without
any single world-changing patch. :)

[...]
> How to consider this project has success? That is pretty easy, the already 
> done functionality will be integrated in git-add and the user usage would be 
> consistent.

After each patch, the test suite should pass.  If some important
functionality is not exercised in the test suite, ideally it can be
added to the test suite.  (Though that's no replacement for trying the
changes in day-to-day use, of course.)

[...]
> The official time-line consists of 12 coding week, starting 24th May. The mid-
> evaluation is in the 8th week.
> So the plan is written in week order beginning on the first coding week. 

Jeff and Junio's advice seems sane to me.  More advice that might help
with writing a timeline: [2] and Christian's reply.

Because of the uncertainty I mentioned above, it's hard to give an
example, but an ideal proposal would include a timeline that gives a
technical plan for the summer.

Also during the bonding time or even earlier it would be nice to get
used to sending patches and reviewing them (as explained in
Documentation/SubmittingPatches) if you find time for it.

Thanks again, and hope that helps.
Jonathan

[1] http://bugs.debian.org/522361
[2] http://thread.gmane.org/gmane.comp.version-control.git/142623/focus=142877
