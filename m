From: Rich Fromm <richard_fromm@yahoo.com>
Subject: Re: propagating repo corruption across clone
Date: Wed, 27 Mar 2013 11:23:15 -0700 (PDT)
Message-ID: <1364408595621-7580839.post@n2.nabble.com>
References: <CAOx6V3YtM-e8-S41v1KnC+uSymYwZw8QBwiCJRYw0MYJXRjj-w@mail.gmail.com> <20130325145644.GA16576@sigill.intra.peff.net> <CACsJy8A0eOWEJ2aqPSLof_CodJM6BadFxQHy5Vb0kAwwTSTS3w@mail.gmail.com> <20130325155600.GA18216@sigill.intra.peff.net> <CAOx6V3a6vGJvJ4HEmAXdTRKKCzRJS23OYd_em1b3aQLzPNEtQA@mail.gmail.com> <20130325200752.GB3902@sigill.intra.peff.net> <CAOx6V3ZWB1ZpmXcaBeSaPOvHqmAMF3U1rTXuwinFGmEZQwFGYQ@mail.gmail.com> <20130326165553.GA7282@sigill.intra.peff.net> <1364340037755-7580771.post@n2.nabble.com> <20130327012515.GC28148@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 27 19:23:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKv0j-0003q3-8T
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 19:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639Ab3C0SXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 14:23:17 -0400
Received: from sam.nabble.com ([216.139.236.26]:49570 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159Ab3C0SXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 14:23:16 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <richard_fromm@yahoo.com>)
	id 1UKv0F-0004Ua-Or
	for git@vger.kernel.org; Wed, 27 Mar 2013 11:23:15 -0700
In-Reply-To: <20130327012515.GC28148@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219296>

Jonathan Nieder-2 wrote
> Is the "[transfer] fsckObjects" configuration on the host executing the
> clone set to true?

I hadn't been setting it at all, and according to git-config(1) it defaults
to false, so the answer is no.  It looks like setting it might be a good
idea.

But I'm still somewhat confused about what is and is not checked under what
conditions.  Consider the three statements:

# 1
git clone --mirror myuser@myhost:my_repo

# 2
git clone --mirror --config transfer.fsckObjects=true myuser@myhost:my_repo

# 3
git clone --mirror myuser@myhost:my_repo && cd my_repo.git && git-fsck

Are 2 and 3 equivalent?  Or is there an increasing level of checking that
occurs from 1 to 2, and from 2 to 3?  My guess is the latter, but perhaps
this could be clearer in the man pages.

git-config(1) says that transfer.fsckObjects essentially (if fetch... and
receive... are not explicitly set) "git-fetch-pack will check all fetched
objects" and "git-receive-pack will check all received objects."  While
git-fsck(1) says "git-fsck tests SHA1 and general object sanity, and it does
full tracking of the resulting reachability and everything else."  The
latter sounds like a stronger statement to me.  But if that's true, perhaps
should the relevant section(s) of git-config(1) explicitly note that this is
not equivalent to a full git-fsck ?



--
View this message in context: http://git.661346.n2.nabble.com/propagating-repo-corruption-across-clone-tp7580504p7580839.html
Sent from the git mailing list archive at Nabble.com.
