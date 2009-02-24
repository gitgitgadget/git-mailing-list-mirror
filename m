From: Pascal Obry <pascal@obry.net>
Subject: Re: git-svn starting with an empty svn repository
Date: Tue, 24 Feb 2009 15:19:13 +0100
Message-ID: <a2633edd0902240619v633eacq4ff7ffd20f66da04@mail.gmail.com>
References: <20090224134325.GA10719@mjollnir.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Penny Leach <penny@mjollnir.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 15:20:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lby9M-0007g7-Gy
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 15:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756423AbZBXOTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 09:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756392AbZBXOTQ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 09:19:16 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:55062 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756371AbZBXOTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 09:19:16 -0500
Received: by ey-out-2122.google.com with SMTP id 25so573595eya.37
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 06:19:13 -0800 (PST)
Received: by 10.210.29.17 with SMTP id c17mr4406612ebc.188.1235485153301; Tue, 
	24 Feb 2009 06:19:13 -0800 (PST)
In-Reply-To: <20090224134325.GA10719@mjollnir.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111289>

Penny,

I've been trying to do the exact same things. I'm using Git to import
from CVS and export into a Subversion repository.

What I have done:

- I have used cvsimport for the CVS repository (no problem)

- I have created an empty repository using svnadmin

- I have imported the svn trunk into Git

- I'm cherry-picking any new commits from my cvs-imported branch
(master) into the git-svn one (named svn-trunk)

For this last point, I'm using this code sniped:

<<
for i in $(git cherry svn-trunk master | sed -n 's/^+ //p'); do
   echo Applying $i;
   (git cherry-pick --no-commit $i &&
    git log --pretty=format:"Author: %an <%ae>%nDate  :
%ad%n%n%s%n%b" -1 $i > /tmp/cm &&
    git commit --file=/tmp/cm) || (echo Cannot commit $i; exit 1)
done
>>

I'm editing the log to properly record original author and date.

There is maybe better solutions...

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
