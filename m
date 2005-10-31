From: "Luck, Tony" <tony.luck@intel.com>
Subject: git push sends more objects than it needs to
Date: Mon, 31 Oct 2005 10:23:55 -0800
Message-ID: <20051031182355.GA7368@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Oct 31 19:25:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWeK7-0000DY-5I
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 19:23:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbVJaSX4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 13:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbVJaSX4
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 13:23:56 -0500
Received: from fmr23.intel.com ([143.183.121.15]:13997 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932102AbVJaSX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 13:23:56 -0500
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr003.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j9VINtMe002756
	for <git@vger.kernel.org>; Mon, 31 Oct 2005 18:23:55 GMT
Received: from intel.com (agluck-lia64.sc.intel.com [143.183.251.239])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j9VBYQQc006423
	for <git@vger.kernel.org>; Mon, 31 Oct 2005 11:34:26 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [127.0.0.1])
	by intel.com (Postfix) with ESMTP id 928CE19F00
	for <git@vger.kernel.org>; Mon, 31 Oct 2005 10:23:55 -0800 (PST)
Received: (from aegl@localhost)
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1/Submit) id j9VINtcH007381
	for git@vger.kernel.org; Mon, 31 Oct 2005 10:23:55 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Scanned-By: MIMEDefang 2.52 on 10.3.253.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10870>

I just pulled from Linus' Linux repository ... and my
wrapper script alerted me to the fact that he had just
re-packed.

So, I logged into kernel.org and linked the new packfiles
across to my repo there, and did a "git prune-packed" to
clean away all the unneeded unpacked objects.

Back on my local box I merged all the new stuff that
had been pulled into my "release" and "test" branches.
(just a fast-forward for the release branch).

Next I used "scp" to copy Linus' new pack files to my
local objects/pack ... and ran git prune packed here.

Finally, after making sure that release and test
branches still built with all the new stuff I did
a "git push" to update my kernel repo.  I saw this:
updating 'refs/heads/test'
  from 0711c558ff3cf4d1e498a9686f4d8ce48aa8d79f
  to   2e488d3f8f299eb0ed826055bc30003e2c27d909
updating 'refs/heads/release'
  from 8a212ab6b8a4ccc6f3c3d1beba5f92655c576404
  to   581c1b14394aee60aff46ea67d05483261ed6527
Packing 10785 objects
Unpacking 10785 objects
 100% (10785/10785) done
refs/heads/test: 0711c558ff3cf4d1e498a9686f4d8ce48aa8d79f -> 2e488d3f8f299eb0ed826055bc30003e2c27d909
refs/heads/release: 8a212ab6b8a4ccc6f3c3d1beba5f92655c576404 -> 581c1b14394aee60aff46ea67d05483261ed6527

Now the "unpack" on kernel.org did the right thing and noticed
that over 9000 of the objects were already in the packfile.  But
I wonder if it couldn't have been smarter and not sent them?

Or am I just subverting the whole paradigm by hand-copying
packfiles around?

-Tony
