From: Jeff King <peff@peff.net>
Subject: Re: How do I quickly check what heads a particular commit is in?
Date: Mon, 24 Apr 2006 00:41:38 -0400
Message-ID: <20060424044138.GA20954@coredump.intra.peff.net>
References: <46a038f90604232123r7f35660aufbb9da0f561f8ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Apr 24 06:42:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXstT-0000DU-6b
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 06:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbWDXElk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 00:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWDXElk
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 00:41:40 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:44243 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S1751511AbWDXElk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Apr 2006 00:41:40 -0400
Received: (qmail 11948 invoked from network); 24 Apr 2006 04:41:38 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 24 Apr 2006 04:41:38 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Apr 2006 00:41:38 -0400
To: Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46a038f90604232123r7f35660aufbb9da0f561f8ea@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19087>

On Mon, Apr 24, 2006 at 04:23:24PM +1200, Martin Langhoff wrote:

> Is there a practical way to ask in what heads they are?

This should work:

$ cat <<'EOF' >find-commit
#!/bin/sh
commit=$1; shift
for i in "$@"; do
  git rev-list $i | fgrep -q $commit && echo $i
done
EOF
$ sh find-commit full-40char-sha1-of-commit head1 head2 ...

You potentially end up traversing parts of the history multiple times
(if they are shared by multiple heads) but git is fast enough that
performance is fine.

I don't know of a way to do it all in a git command without the fgrep.

-Peff
