From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Fri, 18 May 2007 18:02:12 -0700
Message-ID: <464E4C94.5070408@midwinter.com>
References: <200705170539.11402.andyparkins@gmail.com> <20070517215841.GB29259@mellanox.co.il> <200705180141.06862.Josef.Weidendorfer@gmx.de> <200705180857.18182.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 03:02:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpDKy-0000aH-9y
	for gcvg-git@gmane.org; Sat, 19 May 2007 03:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753995AbXESBCR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 21:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754303AbXESBCR
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 21:02:17 -0400
Received: from tater.midwinter.com ([216.32.86.90]:47573 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753995AbXESBCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 21:02:16 -0400
Received: (qmail 25008 invoked from network); 19 May 2007 01:02:14 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=m4QHogsJ0661w6/YVSnZFnGLva9p7m91TceklCkgZjk3nreBg01eWfdIdWSouWk7  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 19 May 2007 01:02:13 -0000
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <200705180857.18182.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47702>

Andy Parkins wrote:
> Bear in mind that what you're suggesting is no different in implementation 
> from what Junio is suggesting but with one difference: in Junio's option 
> the "identifier" will act as a default URL if no override is found.
>   

I don't like using the URL as the key for one simple reason: while it 
technically doesn't conflate the two cases of "I want to use a different 
code base for this subproject starting in version X of the superproject" 
and "I want to use the same code base I've been using all along, but it 
has moved" (in that you can, as you point out, simply map the old URL to 
a new one independent of the project's history) it does encourage people 
to conflate the two in their minds.

Relatively few users will look at an identifier that is a valid URL and 
think of it as anything but a URL, especially if, in the absence of any 
overrides, the software (from the user's perspective) treats it as a 
URL. The override capability is almost certain to remain obscure since 
you won't need to use it in the normal case. Therefore, when the 
submodule's home gets moved to a different host, the first thing a lot 
of people are going to think to do is not to leave the submodule's 
identifier (the original URL) alone and create a mapping config entry, 
but rather to change the submodule to use a brand-new identifier that 
happens to be the same as the new URL. At which point you're right back 
to the original problem of checking out an old version of the 
superproject and having it point to a now-nonexistent subproject.

That's why I suggested making the identifiers look nothing like URLs, 
though of course to the extent they're arbitrary strings, one could use 
a URL if one chose to. I don't object to the *capability* of using a URL 
as an identifier in a three-level scheme like I described -- it would be 
silly to forbid -- but I think it would be a dangerous convention to 
establish because it will eventually encourage people to shoot 
themselves in the foot for lack of knowing what's actually going on.

-Steve
