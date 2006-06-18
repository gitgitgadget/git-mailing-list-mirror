From: linux@horizon.com
Subject: Is there such a thing as a git:// proxy?
Date: 18 Jun 2006 08:42:50 -0400
Message-ID: <20060618124250.15471.qmail@science.horizon.com>
X-From: git-owner@vger.kernel.org Sun Jun 18 16:46:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FryXL-0000Yy-EC
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 16:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWFROp6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 10:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWFROp6
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 10:45:58 -0400
Received: from science.horizon.com ([192.35.100.1]:31280 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932234AbWFROp6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 10:45:58 -0400
Received: (qmail 15472 invoked by uid 1000); 18 Jun 2006 08:42:50 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22083>

I have several machines tracking kernel.org, and I've been moving away
from downloading patch files periodically (cached very nicely by squid)
to just doing "git pull".

But it seems silly to be sucking four copies of the same data from
kernel.org.

Now, one obvious solution is to have one master copy track kernel.org
and have all the other local machines track that.  But then I have to
manually pull the local master every time.

Has anyone put together something that can automatically check
upstream for updates when someone fetches from it?

Ultimately desirable features would, I suppose include:
- Pulling over ssh as well (using auth agent forwarding to pull
  from upstream)
- Support for arbitrary projects (so the cache server can handle
  "git clone" requests), if I develop a desire to pull an -mm or
  -libata-dev or whatever kernel, it will also work.
- Using a single shared object pool for the above.
- Cache cleanup if a project hasn't been used in long enough.
  (You'd probably just time out the heads and let git-prune get
  rid of the objects.)
- Recycling the pack from the upstream server rather than regenerating it.
- Progress reporting on the upstream fetch (since the point is that
  the upstream server pipe is narrower).
- Transparent proxy support

... but I'll settle for the simple solution to start.  Perhaps it could
be as simple as a pre-upload hook invoked by git-upload-pack?

This hasn't gotten itchy enough for me to start scratching it myself,
but I figured I'd mention it and see if anyone was interested.
