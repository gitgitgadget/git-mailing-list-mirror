From: Jeff King <peff@peff.net>
Subject: Re: Retrieving a file at a before a specified commit
Date: Wed, 29 May 2013 22:34:46 -0400
Message-ID: <20130530023446.GA19860@sigill.intra.peff.net>
References: <20130529164735.5489ab47953406745d9034ef@mega-nerd.com>
 <20130529075811.GA7204@sigill.intra.peff.net>
 <20130530104932.d7ba4bfb426044ab9653057e@mega-nerd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 04:34:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhshZ-0002Zt-M2
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 04:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967315Ab3E3Ceu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 22:34:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:44416 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965859Ab3E3Cet (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 22:34:49 -0400
Received: (qmail 8129 invoked by uid 102); 30 May 2013 02:35:29 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 May 2013 21:35:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 May 2013 22:34:46 -0400
Content-Disposition: inline
In-Reply-To: <20130530104932.d7ba4bfb426044ab9653057e@mega-nerd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225911>

On Thu, May 30, 2013 at 10:49:32AM +1000, Erik de Castro Lopo wrote:

> Look at this commit:
> 
>     git log --name-status f51ac745a6d4087cc4d77a3cee01db0412955c79
> 
> and notice that one of the files modified is "pib/chkpib2.7", so lets
> look at the parent version of that file:
> 
>     git show f51ac745a6d4087cc4d77a3cee01db0412955c79^:pib/chkpib2.7
> 
> which produces no output and exits with 0 status.
> 
> However looking at the diff for commit f51ac745a suggests that while
> the file pib/chkpib2.7 may have existed before that commit, it must
> have been empty (ie zero length).
> 
> Does this explanation make sense?

Yes, that is what I would expect git to do in such a situation. You can
inspect it further, too:

  $ git rev-parse f51ac745^:pib/chkpib2.7
  e69de29bb2d1d6434b8b29ae775ad8c2e48c5391

That's the sha1 of the blob containing the content.  You can investigate
information about that object like this:

  $ git cat-file -t e69de29b
  blob
  $ git cat-file -s e69de29b
  0
  $ git cat-file blob e69de29b

Of course since its size is 0, the last one is not that interesting. :)

You could also just look at the tree, which gives similar information:

  $ git ls-tree -lr f51ac745^ | grep pib/chkpib2.7
  100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0 pib/chkpib2.7

Hope that helps.

-Peff
