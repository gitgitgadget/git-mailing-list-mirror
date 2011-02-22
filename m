From: Michael Meeks <michael.meeks@novell.com>
Subject: libreoffice merge issue #2 ...
Date: Tue, 22 Feb 2011 14:20:33 +0000
Organization: Novell, Inc.
Message-ID: <1298384433.32648.161.camel@lenovo-w500>
Reply-To: michael.meeks@novell.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: kendy@novell.com, Norbert Thiebaud <nthiebaud@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 22 16:16:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrtyQ-0005WB-Df
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 16:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966Ab1BVPQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 10:16:18 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:45220 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753871Ab1BVPQR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 10:16:17 -0500
Received: from [192.168.1.4] (host81-145-110-95.range81-145.btcentralplus.com [81.145.110.95])
	by nat.nue.novell.com with ESMTP; Tue, 22 Feb 2011 16:16:15 +0100
X-Mailer: Evolution 2.32.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167551>

Hi guys,

	So - again, I'm a clueless git user :-) basically the same setup and
reproduction issue as last time, except I'm now purely using (hopefully)
a stable git: version 1.7.3.4

Setup:
        git clone git://anongit.freedesktop.org/libreoffice/libs-core
        git checkout integration/dev300_m98
	git remote add stage git://anongit.freedesktop.org/libreoffice/staging/libs-core
        git fetch stage

Reproduce:
	git merge stage/dev300

	Then have a look at:

	ucb/qa/complex/tdoc/CheckTransientDocumentsDocumentContent.java

	a file that (AFAICS) we have made no change on in our master branch,
but has had a couple of changes in dev300; I see sections like this:

import com.sun.star.ucb.XContent;
<<<<<<< HEAD
import com.sun.star.ucb.XContentAccess;
import com.sun.star.ucb.XContentIdentifier;
import com.sun.star.ucb.XContentIdentifierFactory;
import com.sun.star.ucb.XContentProvider;
=======
>>>>>>> stage/ooo/dev300

	I would expect no conflicts. These conflicts seem to come from a later
commit on the ooo/dev300 branch:

commit 01ed463f7e1ea8b5d290273203386c0a76378c08
Author: Lars Langhans <lla@openoffice.org>
Date:   Tue Jun 8 08:35:09 2010 +0200

    sb123:#i111449# cleanups in ucb qa/complex tests

	yet, this was based on the previous commit:

commit 89f7530c91745d16ab2cb59014c7b1543967e0b4
Author: Jens-Heiner Rechtien <hr@openoffice.org>
Date:   Fri Feb 12 15:01:35 2010 +0100

    changefileheader2: #i109125#: change source file copyright notice
from Sun Microsystems to Oracle; remove CVS style keywords (RCSfile,
Revision)

	That is present (although clearly with a different hash) in both
repositories.

	So if I have a branch with commits A -> F and master has commits A -> D
- (and nothing else) I would expect merging that branch to yield state
'F' without conflicts; but most likely I'm missing something, and
perhaps there is some subtle (whitespace related?) difference that I do
not see.

	Of course, this is not the only instance I see of this sort of thing,
but hopefully it is a reasonably simple one, for a file with only a
handful of commits.

	Kendy - do you think this could be caused by the application of the
de-tab-ification logic ? or do you apply that for every change ?

	Thanks,

		Michael.

-- 
 michael.meeks@novell.com  <><, Pseudo Engineer, itinerant idiot
