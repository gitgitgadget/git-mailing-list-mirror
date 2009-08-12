From: Peter Krefting <peter@softwolves.pp.se>
Subject: Problems with filters and git status - reproduction steps
Date: Wed, 12 Aug 2009 09:36:22 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0908120856110.30907@ds9.cixit.se>
References: <alpine.DEB.2.00.0908092127420.17141@perkele.intern.softwolves.pp.se> <200908092252.58363.j6t@kdbg.org> <alpine.DEB.2.00.0908120751500.30907@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 10:36:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb9KM-0000dZ-W3
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 10:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbZHLIga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 04:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753465AbZHLIga
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 04:36:30 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:42194 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753094AbZHLIg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 04:36:29 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id n7C8aM4W014958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Aug 2009 10:36:22 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id n7C8aM8V014953;
	Wed, 12 Aug 2009 10:36:22 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <alpine.DEB.2.00.0908120751500.30907@ds9.cixit.se>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Wed, 12 Aug 2009 10:36:22 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125682>

Peter Krefting:

> However, as I have set the "ident" attribute, Git wants to expand it itself 
> and check in files with "$Id$". When I do a reset, it seems it records the 
> entry as clean against a version stored with just "$Id$", but the record in 
> history has an expanded "$Id$", and the entry is thus never deemed clean.

Actually, that is not the case. It seems to be the filter that causes the 
problems, all by itself. I cannot seem to reproduce this *reliably*. I tried 
setting up a minimal repository and a reproduction recipe, but I get 
different behaviour when I perform the steps manually, and when I run it 
from a shell script.

Here is the reproduction recipe:

#!/bin/bash
# Reproduction recipe for $Date$ dirty issue

ORIGINREPO=git://git.debian.org/users/peterk/gitfilterproblem.git
DESTINATIONREPO=gitfilterproblem-testrepo

# Set up repository
echo -- Cloning
git clone ${ORIGINREPO} ${DESTINATIONREPO}
cd ${DESTINATIONREPO}

# Status should be clean
echo -- After cloning, status should be clean
git status

# Set up filter
echo -- Set up filter, status should be clean
./reposetup.sh 
git status

# Create tracking branch
echo -- Create tracking branch for changed file, status should be clean
git branch --track changed-text-files origin/changed-text-files 
git status

# Merge the branch
echo -- Merge the changes from the branch, now status gets unclean
git merge changed-text-files
echo
git status
git diff

-- 
\\// Peter - http://www.softwolves.pp.se/
