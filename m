From: Jeff King <peff@peff.net>
Subject: Re: How to install and use a custom merge driver
Date: Wed, 28 Jan 2009 22:25:31 -0500
Message-ID: <20090129032531.GA11836@coredump.intra.peff.net>
References: <497FCC9A.9080008@gmail.com> <20090128061848.GA19165@coredump.intra.peff.net> <loom.20090128T230123-889@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alec Clews <alecclews@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 04:27:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSNYT-0006mK-CU
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 04:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593AbZA2DZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 22:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753279AbZA2DZe
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 22:25:34 -0500
Received: from peff.net ([208.65.91.99]:38812 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753249AbZA2DZe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 22:25:34 -0500
Received: (qmail 28112 invoked by uid 107); 29 Jan 2009 03:25:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 28 Jan 2009 22:25:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2009 22:25:31 -0500
Content-Disposition: inline
In-Reply-To: <loom.20090128T230123-889@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107620>

On Wed, Jan 28, 2009 at 11:04:02PM +0000, Alec Clews wrote:

> I fixed that problem -- however it did not make any difference.

Can you post an exact recipe for recreating the problem? It works just
fine here, using:

-- >8 --
commit() {
  echo $1 >file && git add file && git commit -m $1
}

mkdir repo && cd repo && git init
commit base
commit branch-master
git checkout -b other HEAD^
commit branch-other

echo '* merge=overwrite' >.git/info/attributes
cat >>.git/config <<'EOF'
[merge "overwrite"]
  name = overwrite using cp
  driver= cp %B %A
EOF

git merge master
-- 8< --

I get an automatic merge with the contents from "master" (and without
the merge config, there is obviously a conflict).

> Is there someway to enable logging to see how git is making this choice?

You can try "git check-attr merge file" to be sure that it is picking up
the attribute.

-Peff
