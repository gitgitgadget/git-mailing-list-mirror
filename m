From: "Daniel Bratell" <bratell@opera.com>
Subject: Merging submodules - best merge-base
Date: Mon, 25 Feb 2013 17:44:05 +0100
Organization: Opera Software
Message-ID: <op.ws2l3rgnrbppqq@cicero.linkoping.osa>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 17:51:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA1HG-0002cu-GJ
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 17:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638Ab3BYQvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 11:51:22 -0500
Received: from smtp.opera.com ([213.236.208.81]:56854 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750903Ab3BYQvV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 11:51:21 -0500
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Feb 2013 11:51:21 EST
Received: from cicero.linkoping.osa (oslo.jvpn.opera.com [213.236.208.46])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id r1PGi6Dn030788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Mon, 25 Feb 2013 16:44:07 GMT
User-Agent: Opera Mail/12.14 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217064>

I can phrase this in two ways and I'll start with the short way:

Why does a merge of a git submodule use as merge-base the commit that was  
active in the merge-base of the parent repo, rather than the merge-base of  
the two commits that are being merged?

The long question is:

A submodule change can be merged, but only if the merge is a  
"fast-forward" which I think is a fair demand, but currently it checks if  
it's a fast-forward from a commit that might not be very interesting  
anymore.

If two branches A and B split at a point when they used submodule commit  
S1 (based on S), and both then switched to S2 (also based on S) and B then  
switched to S21, then it's today not possible to merge B into A, despite  
S21 being a descendant of S2 and you get a conflict and this warning:

warning: Failed to merge submodule S (commits don't follow merge-base)

(attempt at ASCII gfx:

Submodule tree:

S ---- S1
   \
    \ - S2 -- S21

Main tree:

A' (uses S1) --- A (uses S2)
   \
    \ --- B' (uses S2) -- B (uses S21)


I would like it to end up as:

A' (uses S1) --- A (uses S2) ------------ A+ (uses S21)
   \                                     /
    \ --- B' (uses S2) -- B (uses S21)- /

And that should be legal since S21 is a descendant of S2.

/Daniel
