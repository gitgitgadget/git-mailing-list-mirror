From: linux@horizon.com
Subject: If anyone feels like hacking git-rev-list --bisect...
Date: 27 Jun 2007 14:53:37 -0400
Message-ID: <20070627185337.1107.qmail@science.horizon.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 20:53:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3ce7-0004t2-5U
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 20:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758427AbXF0Sxl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 14:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758758AbXF0Sxl
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 14:53:41 -0400
Received: from science.horizon.com ([192.35.100.1]:17884 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758427AbXF0Sxk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 14:53:40 -0400
Received: (qmail 1122 invoked by uid 1000); 27 Jun 2007 14:53:37 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51060>

I'm trying to bisect kernel bug A, but I keep running into kernel bug
B which causes a crash on boot.  (But was fixed, so I don't need to think
about it much.)

that is, my revision history is something like:

G...........G......XXXXXXXXXX.....B...............B
G = good
B = bad
X = I can't tell


While I can do things like "git-reset --hard HEAD~250" to try to get past
the problem, it's an annoying bit of guessing to find good values, and
if my problem is one some branch, I'd rather explore a different branch.

How much nicer, I couldn't help thinking, if bisection could be told
to look for a ratio other than 1/2.  Then I could ask for the 1/3 or 2/3
point instead.

That would also be helpful in cases where the "good" or "bad" cases
differ significantly in testing pain.  For example, if "bad" forces
an fsck, or if "good" takes a couple of hours of stress-testing
to be really sure.

I *think* it's just a tweak to builtin-rev-list.c:halfway(), but the
code that calls that is rather intricate.

So if anyone feels like attempting it...

Adding the relevant UI to git-bisect would be relatively straightforward.
A new command to re-bisect from the initial state would allow evading
unbuildable commits, and maybe a way to set a preferred split ratio.
