From: Jeff King <peff@peff.net>
Subject: Re: Using alternate working directory
Date: Tue, 24 Sep 2013 01:00:11 -0400
Message-ID: <20130924050011.GE2766@sigill.intra.peff.net>
References: <523E09D8.8090808@rachum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ram Rachum <ram@rachum.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 07:00:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOKjV-0003nJ-Ev
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 07:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724Ab3IXFAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 01:00:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:52911 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706Ab3IXFAP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 01:00:15 -0400
Received: (qmail 30927 invoked by uid 102); 24 Sep 2013 05:00:15 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Sep 2013 00:00:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Sep 2013 01:00:11 -0400
Content-Disposition: inline
In-Reply-To: <523E09D8.8090808@rachum.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235258>

On Sun, Sep 22, 2013 at 12:04:24AM +0300, Ram Rachum wrote:

> I'm making a script `gm` which lets me merge one branch into another
> without having either checked out. It works for some cases but not
> all. I'm trying to make it work for more cases.
> 
> I concluded that the best way to do it would be by using an
> alternate, temporary working directory instead of the repo itself.

Yes, otherwise you will be stomping all over the working tree of
whatever branch _is_ checked out.

> This is my script:
> 
>     https://gist.github.com/cool-RR/6575042
> 
> Now, the problem is that when I try it, it gives these errors:
> 
>     git checkout-index: my_file is not in the cache and then error:
>     my_file: cannot add to the index - missing --add option?
> 
> Anyone has any idea what to do?

Your script is quite similar to the one that is used server-side at
GitHub to generate the "this can be merged" button for each pull
request. So it should work in principle.

Just a guess, but using a relative path for the temporary index file
might be a problem. read-tree will operate from $GIT_DIR as its working
directory, for example, but I think the git-merge-one-file script will
be at the top-level of $GIT_WORK_TREE. Meaning that all of the
sub-commands it runs will see an empty index.

-Peff
