From: Johan Herland <johan@herland.net>
Subject: Getting 'git log' (or something else) to show me the relevant sub-graph?
Date: Tue, 20 Apr 2010 16:49:30 +0200
Message-ID: <201004201649.31084.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 20 16:49:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4Ell-0007qG-2X
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 16:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923Ab0DTOtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 10:49:40 -0400
Received: from smtp.opera.com ([213.236.208.81]:47864 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754892Ab0DTOtj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 10:49:39 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o3KEnVhi006952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 20 Apr 2010 14:49:37 GMT
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145380>

Hi,

Consider the following (simplified) history:

---O---O---O---O---O---O---O---O---O---O---O---O---M2--H  <-- mainline
    \                                             /
     O---O---O---O---O---O---O---M1--D---E---F---G  <-- dev-branch
              \                 /
               O---O---A---B---C  <-- topic-branch

Now, assume that I have bisected my way through to 'A', and found that 
it introduces some bug. Now, I'm interested in visualizing the path 
that this bug "travelled" to get into "mainline", i.e. the following 
sub-graph:

                          --M2--H  <-- mainline
                           /
        --M1--D---E---F---G  <-- dev-branch
         /
A---B---C  <-- topic-branch

In other words, I'm interested in the following log (with decorations):

H (mainline)
M2
G (dev-branch)
F
E
D
M1
C (topic-branch)
B
A

I have unsuccessfully dug through the 'git log' documentation to figure 
out if it can produce this log, so I'm now throwing the question to the 
almighty knowledge of the mailing list...

Here are some of my closest attempts, so far:

- git branch --contains A
	gives me "topic-branch", "dev-branch" and "mainline", which is
	relevant, but incomplete.

- git log --oneline --decorate --graph A^..mainline
	gives me a log/graph where I can search for A and then use the graph
	to trace the way back up to "mainline", but it still displays a lot of
	uninteresting commits (ancestors of M1 and M2) that I have to
	disregard. Although this is ok once in a while, the problem is common
	enough (and the real-world graphs complicated enough), that I'd like a
	better solution, if possible.

I guess what I'm looking for is something similar to --first-parent, 
except instead of the _first_ parent, it should follow the _relevant_ 
parent, as far as the relationship between A and "mainline" is 
concerned.

In set-theory terms I guess what I want is "that which is both an 
ancestor of H, and a descendant of A (inclusive)", but I don't know how 
to explain this to 'git log'.


Thanks for any help,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
