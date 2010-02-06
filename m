From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [RFC PATCH 00/10] gitweb: Simple file based output caching
Date: Fri, 05 Feb 2010 16:51:17 -0800
Message-ID: <4B6CBD05.6040604@eaglescrag.net>
References: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net> <cover.1264198194.git.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "John 'Warthog9' Hawley" <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 01:52:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdYu8-0006xC-M4
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 01:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933118Ab0BFAwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 19:52:01 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:52567 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755417Ab0BFAwA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 19:52:00 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o160pHNl001645
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Fri, 5 Feb 2010 16:51:17 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.1
In-Reply-To: <cover.1264198194.git.jnareb@gmail.com>
X-Enigmail-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Fri, 05 Feb 2010 16:51:17 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139131>

> Table of contents:
> ~~~~~~~~~~~~~~~~~~
>  [RFC PATCH 01/10] gitweb: Print to explicit filehandle (preparing
>                    for caching)

This looks fine, I did some quick testing to verify that this would work
- and it does.

The only caveat that needs to be aware is that if the layer is going to
output binary data it needs to flip the whole stream to :raw before
outputting (this is going to be more specific to the caching layer).

One advantage to having the file handles separate is that it's easier to
distinguish if the data is going to need to be binary data that will
need to be flipped properly.

Also means you could cache the binary data differently than textual data.

I.E. binary data gets saved to disk, but page data gets saved to memcached.

Just food for thought, I'm not sure which way makes more sense
personally, though I would have a tendency to err on the side of
flexibility and have both.

>  [RFC PATCH 02/10] gitweb: href(..., -path_info => 0|1)

note: delaying additional comment till I've finished reading through the
basics of the following patches.

>  [RFC PATCH 03/10] gitweb/cache.pm - Very simple file based caching

Ok this is quite the departure from what I had, I'm unsure that it's the
right way to go, but it obviously has merits (I.E. much simpler addition
of any Cache::Cache or CHI compatible caching layer)

This patch itself looks fine, and as it states it borrows heavily from
my basic implementation - just wraps it differently.  I might have some
thoughts on extending this a bit to be a bit more flushed out from a
basic standpoint.

Need to dig through it some more, but I'm generally ok with it.

>  [RFC PATCH 04/10] gitweb/cache.pm - Stat-based cache expiration

Looks fine to me, though the note about getting the errors should get
moved to previous patch, as it says.

Note: I'm going to stop here as the following are WIP and I want to play
around with this particular direction on my own a little more before
further comment.  There's some ideas running around I want to try and
get down in code first.  Me moving on and trying these other ideas is
not a reflection on the following patches, just some alternative
thinking before I discuss some other ideas on the following patches.

Also I've been sitting on this e-mail in this state for almost a week
while I've been playing with this and having to fight other fires and I
know that Jakub has been looking for commentary on this.

>  [RFC PATCH 05/10] gitweb: Use Cache::Cache compatibile (get, set)
>                    output caching (WIP)
>  [RFC PATCH 06/10] gitweb/cache.pm - Adaptive cache expiration time (WIP)
>  [RFC PATCH 07/10] gitweb: Use CHI compatibile (compute method) caching (WIP)
>  [RFC PATCH 08/10] gitweb/cache.pm - Use locking to avoid 'stampeding herd'
>                    problem (WIP)
>  [RFC PATCH 09/10] gitweb/cache.pm - Serve stale data when waiting for
>                    filling cache (WIP)
>  [RFC PATCH 10/10] gitweb: Show appropriate "Generating..." page when
>                    regenerating cache (WIP)
