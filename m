From: <uwesmail2005-git@yahoo.de>
Subject: Stronger Hashes
Date: Fri, 6 May 2005 23:05:02 +0200 (CEST)
Message-ID: <20050506210502.20956.qmail@web25608.mail.ukl.yahoo.com>
Reply-To: uwesmail2005-git@yahoo.de
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri May 06 22:59:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU9uB-0001tr-Fv
	for gcvg-git@gmane.org; Fri, 06 May 2005 22:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVEFVFK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 17:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVEFVFK
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 17:05:10 -0400
Received: from web25608.mail.ukl.yahoo.com ([217.12.10.167]:60595 "HELO
	web25608.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261222AbVEFVFE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 17:05:04 -0400
Received: (qmail 20958 invoked by uid 60001); 6 May 2005 21:05:02 -0000
Received: from [84.190.74.106] by web25608.mail.ukl.yahoo.com via HTTP; Fri, 06 May 2005 23:05:02 CEST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Cryptographic hashes are never strong enough, it seems. There are two
threats against which they have to be defended.
Defense against incidental collisions:
Can only be made by making the hash longer. Easy way to make the hash
6-times as long: pad to multiple of 6 bits (can be skipped if hash
algorithm is implemented with bit-granularity)
,create normal hash (from all bits),create hash from all even numbered
bits
,create hash from all odd numbered bits, create hash from all bits with
fully triple bit number, create hash from all bits that follow them and
last create a hash from all bit that precede a fully triple numbered
bit. Concatenate (or interleave) these 6 hashes and you're set.
The same is possible with 28. And all perfect numbers.
Defense against intentional collisions:
The mechanism by which a collision is computed uses the property of the
cryptographic hash to update an IV. If a collision was created, and
the next bytes are the same, these files will collide too. Such
computation is dependent on the concrete IV the hash starts with.
If that IV is not predictable anymore, these algorithms will break.
So the easiest way to break them is to hash 'cat file file'. More
secure
will be 'gzip -c<file|cat - file' because the starting offset of file
will probably be not aligned to the hash blocks. With
'$(hashprog)<file|cat - file' you can strike through "probably" and
replace "definitly".

Both methods can be combined. 


	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
