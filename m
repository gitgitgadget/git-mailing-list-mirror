From: Guido Stevens <guido.stevens@cosent.net>
Subject: git-svn breakage on repository rename
Date: Fri, 04 Dec 2009 21:26:32 +0100
Organization: Cosent   -:-   s h a r i n g   m a k e s   s e n s e
Message-ID: <4B197078.6050203@cosent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: George Kuk <George.Kuk@nottingham.ac.uk>
To: normalperson@yhbt.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 21:52:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGf8U-0002D9-TT
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 21:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbZLDUvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 15:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbZLDUvF
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 15:51:05 -0500
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:48441 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932264AbZLDUvA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 15:51:00 -0500
Received: from relay2-v.mail.gandi.net (relay2-v.mail.gandi.net [217.70.178.76])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 27D83405F5
	for <git@vger.kernel.org>; Fri,  4 Dec 2009 21:27:02 +0100 (CET)
Received: from [192.168.178.24] (isis-torproxy.xs4all.nl [80.101.174.248])
	by relay2-v.mail.gandi.net (Postfix) with ESMTP id 7BC62135D8;
	Fri,  4 Dec 2009 21:26:33 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134575>

Hi Eric e.a.,

I have a weird git-svn corner case that might interest you (or not at 
all). I'd appreciate any help or hints for moving beyond this problem.

I'm using git-svn to do a full commit history analysis of the Zope + 
Plone CMS code bases as part of a research project with the University 
of Nottingham into open source knowledge dynamics.

One of the repositories I'm importing breaks with a "Checksum mismatch", 
indicating a corruption. However, this error message occurs exactly at 
the point where the repository was renamed: from "Products.CMFPlone" to 
"Plone" (22715->22716). (Yes, it's the Plone core itself that resists 
analysis :-()

The git-svn url for the later commits would be:
   http://svn-mirror.plone.org/svn/plone/Plone/trunk

Whereas an older part of the code base lives at:
   http://svn-mirror.plone.org/svn/plone/Products.CMFPlone/trunk

Funny thing is, git-svn detects this rename upfront but then breaks
anyway. Which raises the questions:

- is this breakage caused by the rename?

- or does git-svn handle the rename, and there is an actual corruption?

- is there any way I can work around this and get a valid or semi-valid
git history for this project?

I don't mind missing a few commits, since I'm not doing code development
on this repository, only statistical analysis.

Solving this would also be helpful for anyone who wants to work on Plone 
development through git rather than through raw svn.

:*CU#

----------------------------------------------------
To reconstruct this error:
----------------------------------------------------

$ git svn init https://svn-mirror.plone.org/svn/plone/Plone/trunk Plone
$ cd Plone
$ git svn fetch

... Error message: (reformatted to wrap 78 cols):

Found possible branch point:
https://svn.plone.org/svn/plone/Plone/branches/4.0 =>
https://svn.plone.org/svn/plone/Plone/trunk, 30966

Initializing parent: git-svn@30966

Found possible branch point:
https://svn.plone.org/svn/plone/Plone/branches/3.3 =>
https://svn.plone.org/svn/plone/Plone/branches/4.0, 27288

Initializing parent: git-svn@27288

Found possible branch point:
https://svn.plone.org/svn/plone/Plone/branches/3.2 =>
https://svn.plone.org/svn/plone/Plone/branches/3.3, 25119

Initializing parent: git-svn@25119

Found possible branch point:
https://svn.plone.org/svn/plone/Plone/branches/3.1 =>
https://svn.plone.org/svn/plone/Plone/branches/3.2, 22725

Initializing parent: git-svn@22725

branch_from: /Products.CMFPlone => /Products.CMFPlone/branches/3.1

Found possible branch point:
https://svn.plone.org/svn/plone/Products.CMFPlone/branches/3.1 =>
https://svn.plone.org/svn/plone/Plone/branches/3.1, 22715

Initializing parent: git-svn@22715

Found branch parent: (git-svn@22725)
e477345f83a0f2cc7e27348e01493a841c9cd587

Following parent with do_switch

Checksum mismatch: Products/CMFPlone/HISTORY.txt
expected: 69106809d879e7370dd133c7ba338670
     got: 7b1a0641d429f0c567acf7a3a4be5a45


-- 
***   Guido A.J. Stevens        ***   tel: +31.43.3618933    ***
***   guido.stevens@cosent.net  ***   Postbus 619            ***
***   http://www.cosent.nl      ***   6200 AP  Maastricht    ***

             s h a r i n g    m a k e s    s e n s e
