From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Wed, 3 Jun 2009 08:07:46 -0700
Message-ID: <20090603150746.GF3355@spearce.org>
References: <200905122329.15379.jnareb@gmail.com> <200906030250.01413.jnareb@gmail.com> <20090603012940.GA3355@spearce.org> <200906031121.38616.jnareb@gmail.com> <20090603144837.GE3355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 17:09:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBs5g-0005el-3U
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 17:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759134AbZFCPHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 11:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758990AbZFCPHp
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 11:07:45 -0400
Received: from george.spearce.org ([209.20.77.23]:47216 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759124AbZFCPHo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 11:07:44 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A75B9381D1; Wed,  3 Jun 2009 15:07:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090603144837.GE3355@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120613>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
> > What options besides (required?) "host=<server>[:<port>]" are supported?
> 
> Currently only host is supported.  And yea, it takes the :<port> if
> the client included the port number in the URL (git://foo:8813/path).

Ok, I'm wrong.  It *doesn't* send the port.  The reason is obtuse,
but git_tcp_connect() clobbers the port number out of the host
name string, so that later when git_connect() sends this "host=%s",
only the host name is transmitted.
 
> Actually, I just realized JGit isn't compliant here.  It doesn't
> send the :<port> like C Git would.

So, actually JGit is compliant here.
 
> > Do I understand correctly that "host=<host>" information is required
> > for core.gitProxy to work, isn't it?

If core.gitProxy or GIT_PROXY_COMMAND are set, you can lie to the
remote git daemon about the host.  E.g.:

  $ cat proxy.sh
  #!/bin/sh
  exec nc git.kernel.org 9418

  GIT_PROXY_COMMAND=proxy.sh git ls-remote git://github.com/foo.git

During that kernel.org receives "\0host=github.com\0" host header,
which is not the name you connected to it as.  :-)

In practice I doubt anyone would do that, but, you can confuse
yourself.  I guess about equally as well as url.insteadof.  :-)

-- 
Shawn.
