From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 0/4] git-http-push improvements
Date: Fri, 4 Nov 2005 14:22:10 -0800
Message-ID: <20051104222210.GC3001@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Nov 04 23:25:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY9wt-0004ET-8m
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 23:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbVKDWWM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 17:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbVKDWWM
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 17:22:12 -0500
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:9009 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751062AbVKDWWL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 17:22:11 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jA4MMB1N017918
	for <git@vger.kernel.org>; Fri, 4 Nov 2005 14:22:11 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jA4MMAdV017916
	for git@vger.kernel.org; Fri, 4 Nov 2005 14:22:10 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11167>

This series of patches makes HTTP/DAV pushes more stable.  Locks are
handled much better and are refreshed if they are about to expire, and
remote refs with '/' in their names are supported.

Items still on my todo list:

- Process the server's lock refresh timeout response (currently it
  assumes that the original lock timeout will continue to work.)
- Verify remote commit object if branches are the same (currently
  it does no verification if the refs point to the same object.)
- Clean up temp filenames after failed PUTs (no need to leave them
  there since you can't resume.)
- Either send compressed objects directly rather than uncompressing and
  recompressing them before sending; or since we have an uncompressed
  copy, also verify the SHA1 before sending since the remote doesn't
  verify (and/or consider read after write verification.)
- Use a pack to send under what circumstances?  Perhaps allow
  min-pack-size and max-pack-size (more objects == less impact on failed
  transfer, more transfer overhead.)
- Attempt recovery if the remote ref PUT fails?
- Test against other DAV servers (I've currently tested it using only
  Apache.)

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
