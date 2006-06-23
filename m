From: Jeff King <peff@peff.net>
Subject: Re: Is anybody actually using git-cherry.sh?
Date: Fri, 23 Jun 2006 14:06:58 -0400
Message-ID: <20060623180658.GA24022@coredump.intra.peff.net>
References: <Pine.LNX.4.63.0606231818140.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 20:07:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftq3c-0002Kv-V2
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 20:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbWFWSHB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 14:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbWFWSHB
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 14:07:01 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:28808 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751846AbWFWSHA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 14:07:00 -0400
Received: (qmail 24551 invoked from network); 23 Jun 2006 14:06:40 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 23 Jun 2006 14:06:40 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jun 2006 14:06:58 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0606231818140.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22432>

On Fri, Jun 23, 2006 at 06:22:05PM +0200, Johannes Schindelin wrote:

> from git-cherry.sh:
> 
> -- snip --
> for c in $inup
> do
>         git-diff-tree -p $c
> done | git-patch-id |
> while read id name
> do
>         echo $name >>$patch/$id
> done
> -- snap --
>
> AFAICS this _must_ be broken.  git-diff-tree -p <ent> does not emit
> "diff-tree <sha1>", and neither "commit <sha1>" lines. So this code
> would yield just one file, treating all diffs as one huge diff. A
> quick fix would be this change (without the patch I sent out earlier):

Maybe I don't understand what you're saying, but it works fine here
(using latest head of master):
  $ for c in origin origin^; do git-diff-tree -p $c; done | git-patch-id
  1511e4e276ccc98ecf0ea31dad1bc9010869fdaf f60349aa786d519368938d7b6e5bb2006eccb0cf
  86ce7eeedd87a78cd8cac79adb6d4d968ece9e53 50f575fc9836704d45a5f732125b8f58103425a4

It looks like patch-id does a flush whenever a sha1 is found at the
beginning of a line; diff-tree lines simply have the 'diff-tree ' part
ignored.

-Peff
