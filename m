From: Tony Lindgren <tony@atomide.com>
Subject: Re: [SCRIPT] cg-rpush & locking
Date: Wed, 1 Jun 2005 09:55:02 -0700
Message-ID: <20050601165502.GB20936@atomide.com>
References: <20050531190005.GE18723@atomide.com> <Pine.LNX.4.63.0505311914550.6500@localhost.localdomain> <20050601065123.GA23358@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Wed Jun 01 18:54:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdWSV-0007iJ-EV
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 18:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVFAQzb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 12:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVFAQzb
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 12:55:31 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:11205 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261467AbVFAQzW
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Jun 2005 12:55:22 -0400
Received: from pimout7-ext.prodigy.net (pimout7-int.prodigy.net [207.115.4.147])
	by ylpvm15.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j51GtKO0015535
	for <git@vger.kernel.org>; Wed, 1 Jun 2005 12:55:26 -0400
X-ORBL: [67.117.73.34]
Received: from torttu.muru.com (adsl-67-117-73-34.dsl.sntc01.pacbell.net [67.117.73.34])
	by pimout7-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id j51Gt8KE408794;
	Wed, 1 Jun 2005 12:55:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by torttu.muru.com (Postfix) with ESMTP id 58F67BF459;
	Wed,  1 Jun 2005 09:55:08 -0700 (PDT)
Received: from torttu.muru.com ([127.0.0.1])
	by localhost (torttu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 15385-05; Wed, 1 Jun 2005 09:55:04 -0700 (PDT)
Received: from marenki.muru.com (unknown [192.168.100.15])
	by torttu.muru.com (Postfix) with ESMTP id 85E7DBF456;
	Wed,  1 Jun 2005 09:55:03 -0700 (PDT)
Received: by marenki.muru.com (Postfix, from userid 1000)
	id 00F343C048B; Wed,  1 Jun 2005 09:55:02 -0700 (PDT)
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Content-Disposition: inline
In-Reply-To: <20050601065123.GA23358@cip.informatik.uni-erlangen.de>
User-Agent: mutt-ng 1.5.9i (Linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at adsl-67-117-73-34.dsl.sntc01.pacbell.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Thomas Glanzmann <sithglan@stud.uni-erlangen.de> [050531 23:56]:
> Hello,
> 
> > Why do you need a lock at all?
> 
> > Just update your HEAD reference last when you push and get it first when 
> > you pull.
> 
> consider the following scenario: Two people push at the same time. One
> HEAD gets actually written, but both think that their changes got
> upstream. Of course the 'upstream' tree is consitent, but incomplete.
> That is why we need a lock. And the lock should be obtained before the
> remote HEAD is retrieved, I think the following scenario is how to
> handle it:
> 
> 	1. acquire remote lock
> 	2. get remote HEAD
> 	3. if remote HEAD is ahead (not included in our history) abort
> 	   and free lock.
> 	4. push objects
> 	5. update remote HEAD with local
> 	6. free remote lock.

Yes, that's basically what the script does. We have several people
committing patches.

Tony
