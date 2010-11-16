From: Tim Stoakes <git@stoakes.net>
Subject: Re: Using git-svn with svnsync mirror
Date: Tue, 16 Nov 2010 14:53:12 +1030
Message-ID: <20101116042312.GB24344@mail.stoakes.net>
References: <loom.20101116T030410-656@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Phillip Hutchings <sitharus@sitharus.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 05:33:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIDE3-0007uu-0t
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 05:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756716Ab0KPEcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 23:32:31 -0500
Received: from outbound-mail03.westnet.com.au ([203.10.1.244]:39942 "EHLO
	outbound-mail03.westnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755256Ab0KPEcb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Nov 2010 23:32:31 -0500
X-Greylist: delayed 552 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Nov 2010 23:32:30 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAHqV4UzKrYlp/2dsb2JhbACiWnK/PIMECII+BIpXgyY
X-IronPort-AV: E=Sophos;i="4.59,203,1288540800"; 
   d="scan'208";a="107462439"
Received: from dsl-202-173-137-105.sa.westnet.com.au (HELO mail.stoakes.net) ([202.173.137.105])
  by outbound-mail03.westnet.com.au with ESMTP/TLS/ADH-AES256-SHA; 16 Nov 2010 12:23:15 +0800
Received: from narco.pvt.stoakes.net (unknown [192.168.20.234])
	by mail.stoakes.net (Postfix) with ESMTP id 5EFB7EE4CF;
	Tue, 16 Nov 2010 14:53:31 +1030 (CST)
Received: by narco.pvt.stoakes.net (Postfix, from userid 1000)
	id AD26D1024B3; Tue, 16 Nov 2010 14:53:12 +1030 (CST)
Mail-Followup-To: Phillip Hutchings <sitharus@sitharus.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <loom.20101116T030410-656@post.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161542>

Phillip Hutchings(sitharus@sitharus.com)@161110-02:08:
> Hi,
> 
> I've got an svnsync mirror of a large repository, and I'm trying to do
> a git-svn clone from the mirror as the main server is off site. This
> works well until I try to dcommit or use git svn info.
> 
> My investigations show that working_head_info in git-svn doesn't
> account for using svnsync properties, so it cannot find a log entry
> that matches a config entry.
> 
> My perl isn't good enough to patch this yet, so I was wondering if
> anyone else had encountered it.
> 
> I could change the config URL to match, but I'm worried this will
> break things.

You want to use rewriteRoot option so that changing the URL does not
break things (the URL is stored in each git commit's log).

I use something like this all the time:
[svn-remote "svn"]
  rewriteRoot = svn://svn.foo.com/repo/blah   <-- the master
  url = svn://svn-mirror.foo.com/repo/somewhere/else/blah  <-- a slave

If you've imported from the mirror without this option, then you're
stuck I think. You could work around it by swapping the URLs in the
rewriteRoot and url fields (essentially rewriting the URLs in the wrong
order), but this is strictly 'wrong'.

Tim

-- 
Tim Stoakes
