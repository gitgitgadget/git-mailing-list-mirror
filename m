From: Jeff King <peff@peff.net>
Subject: Re: Creating objects manually and repack
Date: Thu, 3 Aug 2006 23:58:03 -0400
Message-ID: <20060804035803.GA362@coredump.intra.peff.net>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 04 05:58:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8qpG-0000zS-DB
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 05:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWHDD6G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 23:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWHDD6G
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 23:58:06 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:19885 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751078AbWHDD6F (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 23:58:05 -0400
Received: (qmail 30024 invoked from network); 3 Aug 2006 23:57:29 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 3 Aug 2006 23:57:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu,  3 Aug 2006 23:58:03 -0400
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24769>

On Thu, Aug 03, 2006 at 11:43:42PM -0400, Jon Smirl wrote:

> I've made 500K object files with my cvs2svn front end. This is 500K of
> revision files and no tree files. Now I run get-repack. It says done
> counting zero objects. What needs to be update so that repack will
> find all of my objects?

git-repack starts at your heads and works its way down. You can either:
  - make a dummy commit for a tree with all of your blobs:
    $ while read sha1; do
        echo -e "100644 blob $sha1\t$sha1"
      done <list_of_sha1s | git-update-index --index-info
      tree=$(git-write-tree)
      commit=$(git-commit-tree $tree)
      git-update-ref HEAD $commit

  - call git-pack-objects directly with a list of objects
      git-pack-objects .git/objects/pack/pack <list_of_sha1s

Obviously the latter is simpler, but the former will also make
git-fsck-objects happy. Note that they're both untested, so there might
be typos.

-Peff
