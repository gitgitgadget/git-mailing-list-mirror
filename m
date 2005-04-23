From: Jeff Garzik <jgarzik@pobox.com>
Subject: Hash collision count
Date: Sat, 23 Apr 2005 16:27:47 -0400
Message-ID: <426AAFC3.800@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Apr 23 22:23:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPR9n-0005BJ-6w
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 22:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVDWU15 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 16:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVDWU15
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 16:27:57 -0400
Received: from 216-237-124-58.infortech.net ([216.237.124.58]:14991 "EHLO
	mail.dvmed.net") by vger.kernel.org with ESMTP id S261767AbVDWU1v
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 16:27:51 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.50 #1 (Red Hat Linux))
	id 1DPREE-0002c0-1V; Sat, 23 Apr 2005 20:27:51 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Ideally a hash + collision-count pair would make the best key, rather 
than just hash alone.

A collision -will- occur eventually, and it is trivial to avoid this 
problem:

	$n = 0
	attempt to store as $hash-$n
	if $hash-$n exists (unlikely)
		$n++
		goto restart
	key = $hash-$n

Tangent-as-the-reason-I-bring-this-up:

One of my long-term projects is an archive service, somewhat like 
Plan9's venti:  a multi-server key-value database, with sha1 hash as the 
key.

However, as the database grows into the terabyte (possibly petabyte) 
range, the likelihood of a collision transitions rapidly from unlikely 
-> possible -> likely.

Since it is -so- simple to guarantee that you avoid collisions, I'm 
hoping git will do so before the key structure is too ingrained.

	Jeff



