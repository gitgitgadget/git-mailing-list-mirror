From: Andrew Walrond <andrew@walrond.org>
Subject: Bug report: stash in upstream caused remote fetch to fail
Date: Wed, 1 Feb 2012 16:59:53 +0000
Message-ID: <20120201165952.GA16263@proteus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: andrew@walrond.org
X-From: git-owner@vger.kernel.org Wed Feb 01 20:50:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsgCa-0000v4-KA
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 20:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232Ab2BATuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 14:50:39 -0500
Received: from gimli.pitney-fabs.co.uk ([87.106.140.52]:41445 "EHLO
	gimli.pitney-fabs.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756731Ab2BATuh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 14:50:37 -0500
X-Greylist: delayed 1255 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Feb 2012 14:50:36 EST
Received: from host-78-151-87-122.as13285.net ([78.151.87.122] helo=localhost.localdomain)
	by gimli.pitney-fabs.co.uk with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <walrond.andrew@gimli.pitney-fabs.co.uk>)
	id 1RsfsA-0000MG-B4
	for git@vger.kernel.org; Wed, 01 Feb 2012 19:29:40 +0000
Received: from s15972770.onlinehome-server.info ([217.160.168.67] helo=proteus)
	by gimli.pitney-fabs.co.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <walrond.andrew@gimli.pitney-fabs.co.uk>)
	id 1RsdXG-0000Ca-8w
	for andrew@walrond.org; Wed, 01 Feb 2012 16:59:55 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189532>

A bit of cut and paste will explain better than me...

LOCAL $ git remote update
    Fetching origin
    remote: Counting objects: 25, done.
    remote: Compressing objects: 100% (12/12), done.
    remote: Total 13 (delta 10), reused 0 (delta 0)
    Unpacking objects: 100% (13/13), done.
    fatal: bad object fa0da15b2ea5cc3e4eb9ed414b99d6a9d7da7864
    error: git://git.heresymail.org/lib%2Fmpfr did not send all necessary
    objects

UPSTREAM $ git fsck
    dangling blob ded848b21db04fcadf77a4a5d9f81955b4315c9f
    dangling blob 9c3976919b3cee56eabc3c9c9dfe5d223ce32686
    dangling blob e17ab25a3a91bed830ddb06da4af1132434d5ee4
    dangling blob 20a612ab361058838f680d72c1f4f8cb462ce1a2

UPSTREAM $ git gc
    Counting objects: 974, done.
    Delta compression using up to 8 threads.
    Compressing objects: 100% (954/954), done.
    Writing objects: 100% (974/974), done.
    Total 974 (delta 572), reused 0 (delta 0)

LOCAL $ git remote update
    Fetching origin
    remote: Counting objects: 25, done.
    remote: Compressing objects: 100% (10/10), done.
    remote: Total 13 (delta 3), reused 11 (delta 2)
    Unpacking objects: 100% (13/13), done.
    fatal: bad object fa0da15b2ea5cc3e4eb9ed414b99d6a9d7da7864
    error: git://git.heresymail.org/lib%2Fmpfr did not send all necessary
    objects

LOCAL $ DELETE LOCAL REPO

LOCAL $ git clone <upstream>
    Cloning into bare repository '/src/lib/mpfr'...
    remote: Counting objects: 972, done.
    remote: Compressing objects: 100% (382/382), done.
    remote: Total 972 (delta 570), reused 971 (delta 570)
    Receiving objects: 100% (972/972), 2.01 MiB, done.
    Resolving deltas: 100% (570/570), done.
    error: refs/stash does not point to a valid object!

UPSTREAM $ git stash list
    stash@{0}: WIP on (no branch): f648dd0 Import 3.1.0 from tarball

UPSTREAM $ git stash clear

LOCAL $ DELETE LOCAL REPO

LOCAL $ git clone <upstream>
    Cloning into bare repository '/src/lib/mpfr'...
    remote: Counting objects: 972, done.
    remote: Compressing objects: 100% (382/382), done.
    remote: Total 972 (delta 570), reused 971 (delta 570)
    Receiving objects: 100% (972/972), 2.01 MiB, done.
    Resolving deltas: 100% (570/570), done.

UPSTREAM $ git version
    git version 1.7.8.2

LOCAL $ git version
    git version 1.7.8.2

Hope that's useful!

Andrew Walrond
