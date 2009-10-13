From: Peter Krefting <peter@softwolves.pp.se>
Subject: Changing branches in supermodule does not affect submodule?
Date: Tue, 13 Oct 2009 11:29:08 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0910131115160.14223@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 12:39:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxeiN-0001Yw-Qt
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 12:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933757AbZJMK3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 06:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756788AbZJMK3w
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 06:29:52 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:46003 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759381AbZJMK3v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 06:29:51 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id n9DAT8sW027949
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 13 Oct 2009 12:29:08 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id n9DAT8ts027942;
	Tue, 13 Oct 2009 12:29:08 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Tue, 13 Oct 2009 12:29:08 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130155>

Hi!

If I have a repository with submodules that is in a clean state, and switch 
branches in the super repository, the submodules are left in the state they 
were in before I switched branches (with 1.6.4, at least). Is this the 
expected behaviour?

--->8--8<---
#!/bin/bash
# Create supermodule.
mkdir super-$$
cd super-$$
git init

# Create submodule with commit.
mkdir sub
cd sub
git init
echo C > c.txt
echo D > d.txt
git add c.txt d.txt
git commit -m Created.
cd ..

# Create commit and branch in supermodule.
echo A > a.txt
echo B > b.txt
git add a.txt b.txt sub
git commit -m Created.
git tag branchpoint
git checkout -b branch1

# Create branch1 in submodule and commit.
cd sub
git checkout -b branch1
echo E > c.txt
echo F > d.txt
git add c.txt d.txt
git commit -m Branched.
cd ..

# Commit to a branch in the supermodule.
git add sub
git commit -m Sub-update.

# Status should now be clean.
git status

# Create a new branch in supermodule, from the original commit.
git checkout -b branch2 branchpoint

# I now expect the submodule to be up-to-date and the state clean.
git status
--->8--8<---

-- 
\\// Peter - http://www.softwolves.pp.se/
