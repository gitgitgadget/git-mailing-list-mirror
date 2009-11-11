From: Pascal Obry <pascal@obry.net>
Subject: Re: git-svn problem with v1.6.5
Date: Wed, 11 Nov 2009 11:28:11 +0100
Organization: Home - http://www.obry.net
Message-ID: <4AFA91BB.7050402@obry.net>
References: <4AF9E7FE.3060701@obry.net> <32541b130911101428t50038cfcsf37e3ea9edb26f64@mail.gmail.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>,
	Eric Wong <normalperson@yhbt.net>, adambrewster@gmail.com
X-From: git-owner@vger.kernel.org Wed Nov 11 11:28:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8AQk-0007c4-5f
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 11:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756199AbZKKK1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 05:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755694AbZKKK1v
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 05:27:51 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:63912 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028AbZKKK1u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 05:27:50 -0500
Received: by ewy3 with SMTP id 3so971011ewy.37
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 02:27:55 -0800 (PST)
Received: by 10.213.107.8 with SMTP id z8mr1446716ebo.32.1257935275247;
        Wed, 11 Nov 2009 02:27:55 -0800 (PST)
Received: from ?192.168.0.100? (AVelizy-154-1-81-24.w86-205.abo.wanadoo.fr [86.205.111.24])
        by mx.google.com with ESMTPS id 10sm3758252eyz.27.2009.11.11.02.27.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 02:27:54 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <32541b130911101428t50038cfcsf37e3ea9edb26f64@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132638>


Avery,

 > Is d2cf08bb67e4b7da33a250127aab784f1f2f58d3 a valid revision?  (git
 > log d2cf08bb67e4b7da33a250127aab784f1f2f58d3).

No.

 > Is refs/remotes/svn/trunk valid?  (git log refs/remotes/svn/trunk).

Yes.

 > It seems like a strange problem.

Agreed!

> You could try using git bisect to figure out which exact commit to
> git.git created the problem.

I wanted to avoid that :) Anyway, here is the culprit:


commit 6f5748e14cc5bb0a836b649fb8e2d6a5eb166f1d
Author: Adam Brewster <adambrewster@gmail.com>
Date:   Tue Aug 11 23:14:27 2009 -0400

     svn: allow branches outside of refs/remotes

     It may be convenient for some users to store svn remote tracking
     branches outside of the refs/remotes/ heirarchy.

     To accomplish this feat, this patch includes the entire path to
     the ref in $r->{'refname'} in &read_all_remotes and tries to change
     references to this entry so the new value makes sense.

     [ew: fixed backwards compatibility, long lines]

     Signed-off-by: Adam Brewster <adambrewster@gmail.com>
     Signed-off-by: Eric Wong <normalperson@yhbt.net>

  git-svn.perl                     |   83 
++++++++++++++++++++++----------------
  t/lib-git-svn.sh                 |    2 +-
  t/t9104-git-svn-follow-parent.sh |   10 ++--
  t/t9107-git-svn-migrate.sh       |   14 +++----
  t/t9143-git-svn-gc.sh            |   10 ++--
  t/t9144-git-svn-old-rev_map.sh   |   31 ++++++++++++++
  6 files changed, 96 insertions(+), 54 deletions(-)


But frankly I'm no expert on Perl... I fear that I won't be able to 
debug that!

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
