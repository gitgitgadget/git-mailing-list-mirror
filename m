From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC] Refspec patterns with * in the middle
Date: Sun, 1 Mar 2009 18:42:34 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0903011820590.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 02 00:44:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdvKG-0000N8-ML
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 00:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757173AbZCAXmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 18:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757112AbZCAXmh
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 18:42:37 -0500
Received: from iabervon.org ([66.92.72.58]:46658 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756351AbZCAXmg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 18:42:36 -0500
Received: (qmail 25421 invoked by uid 1000); 1 Mar 2009 23:42:34 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Mar 2009 23:42:34 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111896>

I've got an annoying repository where all of the branches upstream[*] have 
names, for a project "my-proj" like:

some/constant/stuff/$VERSION/junk/my-proj

I'd like to be able to use refspecs like:

 fetch = some/constant/stuff/*/junk/my-proj:refs/remotes/origin/*

I've written an implementation (which mainly involved having only one 
place do the matching and replacement for pattern refspecs, and then 
making that one place a little more clever), so that's not hard. But we 
currently prohibit refspecs like this, and I think we may want to prohibit 
some patterns of this general form, in order to keep typos from doing 
surprising things.

My use case is actually, more precisely:

some/constant/stuff/$PROJ-$NUMBER/junk/my-proj

Where $NUMBER is the version number, and $PROJ is usually, but not quite 
always "my-proj"; the exception being that it might be effectively a 
superproject. So I'd like to have:

 fetch = some/constant/stuff/my-proj-*/junk/my-proj:refs/remotes/origin/*

But I can live with remote branches like "my-proj-2.4" instead of "2.4".

I think it would make sense, and limit typo damage, to say that the * can 
only expand to something with a '/' in it if the star has a slash or the 
end of the string on each side.

What are other people's thoughts? Should I have a config option for how 
flexible matching is permitted? Any particular constraints I should have 
in general?

[*]
(This is actually a Perforce upstream, but I want to keep the mapping from 
Perforce into git simple and not grow another pattern-matching format, so 
I'm just copying Perforce paths as ref names, and then I want the match 
them with the usual code)

	-Daniel
*This .sig left intentionally blank*
