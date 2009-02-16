From: david@lang.hm
Subject: Re: disallowing push to currently checked-out branch
Date: Sun, 15 Feb 2009 17:47:37 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <20090215232013.GA11543@zakalwe.fi> <20090216000443.GB3503@coredump.intra.peff.net> <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Heikki Orsila <shdl@zakalwe.fi>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 01:44:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYrat-0008AP-0H
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 01:44:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754412AbZBPAmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 19:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754273AbZBPAmv
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 19:42:51 -0500
Received: from mail.lang.hm ([64.81.33.126]:45586 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753174AbZBPAmv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 19:42:51 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n1G0gcmS019822;
	Sun, 15 Feb 2009 16:42:38 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110104>

as I think about this more I'm puzzled as to why this is an issue.

I see mentions of it messing up the index and causing users to loose data, 
but how is it different to push into a repository that has a workdir (with 
or without dirty state in the workdir or in the index) and doing a fetch 
into that repository.

in both cases the new commits are added to the repository and the commit 
pointed to by the branch changes, but if you do the fetch your HEAD and 
the contents of the workdir and index aren't touched, why should a push do 
something different?

I believe that if you fetch into a repository and someone else fetches 
from you, they will get the content that's newer that what's in your dirty 
workdir/index (I haven't tried it, but my understanding of the git 
internals lead me to expect this to be the behavior)

a pull would try to update the index, HEAD, and workdir, but I've seen 
many discussions about how push and pull are not symetrical, but push and 
fetch are (along with the moaning about bad names for the commands and the 
historical explination of how they got that way)


If there is some reason for the normal push to try and update the HEAD, 
index, and workdir. instead of refusing the push, how about having it put 
the commits in the repository and then fail to change the HEAD, index, and 
workdir if any of them contain changes? (along with a warning that it's 
doing so).

this should be safe to do because it will only flag on the particular 
combination of events that will cause data loss rather than the broader 
prohibition of "don't push if there is a workdir" that affects legitimate 
uses as well

David Lang
