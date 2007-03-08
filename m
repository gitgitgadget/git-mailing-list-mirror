From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: Advice on strategy for "temporary" commits
Date: Thu, 8 Mar 2007 18:02:24 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrnev0jtg.7lh.mdw@metalzone.distorted.org.uk>
References: <e1dab3980703080639i4c553e89nb931c2aea45b023b@mail.gmail.com> <20070308163239.GH22713@fieldses.org> <e1dab3980703080907v58739287p18bc2797db7d209e@mail.gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 19:02:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPMx2-0006fl-2w
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 19:02:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbXCHSCb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 13:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752390AbXCHSCb
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 13:02:31 -0500
Received: from distorted.demon.co.uk ([80.177.3.76]:30737 "HELO
	metalzone.distorted.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1752388AbXCHSCa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2007 13:02:30 -0500
Received: (qmail 1757 invoked by uid 110); 8 Mar 2007 18:02:24 -0000
Received: (qmail 1741 invoked by uid 9); 8 Mar 2007 18:02:24 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1173376944 1485 172.29.199.2 (8 Mar 2007 18:02:24 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Thu, 8 Mar 2007 18:02:24 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41767>

David Tweed <david.tweed@gmail.com> wrote:

> a-----------a-----------a-----------a
>  \          $           $           $
>   \-t---t---t---t---t---t---t---t---t
>
> AIUI neither git-branch nor git-checkout provide
> a way to do this. (Clearly the git datastructures
> can represent this situation, I'm just not sure how
> to ask the tools to do it.)

You want the raw git-commit-tree tool.  Suppose your branches are tmp
and hourly (both in refs/heads).  Something like this should make your
hourly commit:

	commit=$(
	  echo hourly-commit |
	  git commit-tree refs/heads/tmp^{tree} -p refs/heads/hourly)
	git update-ref -m "hourly commit" refs/heads/hourly $commit

It might be that you should then start basing your temporary commits on
the most recent archive, so you should also

	git update-ref -m "hourly commit" refs/heads/tmp $commit

Then what you'll end up with is something like

a-----------a-----------a-----------a
 \          $\          $\          $
  \-t---t---t \-t---t---t \-t---t---t

Does that seem sane?

-- [mdw]
