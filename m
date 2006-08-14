From: jeffpc@josefsipek.net (Josef "Jeff" Sipek)
Subject: Git network protocol
Date: Mon, 14 Aug 2006 02:21:17 -0400
Message-ID: <20060814062117.GC10476@josefsipek.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Aug 14 08:21:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCVpH-0003Md-M0
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 08:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbWHNGVZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 02:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751884AbWHNGVZ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 02:21:25 -0400
Received: from mrs.stonybrook.edu ([129.49.1.206]:7381 "EHLO
	mrs.stonybrook.edu") by vger.kernel.org with ESMTP id S1751877AbWHNGVY
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 02:21:24 -0400
Received: from relay2.stonybrook.edu (relay2 [172.30.255.14])
	by mrs.stonybrook.edu (8.13.6/8.13.6) with SMTP id k7E6LOVD000496
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 02:21:24 -0400 (EDT)
Received: from mailrelay.stonybrook.edu ([172.30.255.14])
 by relay2.stonybrook.edu (SMSSMTP 4.1.12.43) with SMTP id M2006081402212308861
 for <git@vger.kernel.org>; Mon, 14 Aug 2006 02:21:23 -0400
Received: from josefsipek.net (turing.ams.sunysb.edu [129.49.108.158])
	by mailrelay.stonybrook.edu (8.13.6/8.13.6) with ESMTP id k7E6LMLH000493
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 02:21:23 -0400 (EDT)
Received: by josefsipek.net (Postfix, from userid 1000)
	id 5C95B1C00DF0; Mon, 14 Aug 2006 02:21:17 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25322>

Hello,

I'm trying to implement the git protocol, and I am having a bit of an issue
with the lack of information available about it (please correct me if I
missed some source of information.)

I understand the basic format of the protocol, however I'm not sure what
"command" can follow what. I also noticed some odd inconsistencies (or maybe
I just don't see the pattern yet.) For example, a git-clone generates this
traffic:

C: git-upload-pack ....
S: SHA1 HEAD....
S: SHA1 refs/heads/master
S: flush
C: want SHA1...
C: want SHA1... (it wants the same SHA1 twice!)
C: flush
C: done
S: NAK
S: the pack...

Then, when it is time to git-fetch a new commit, I get:

C: git-upload-pack ....
S: SHA1 HEAD....
S: SHA1 refs/heads/master
S: flush
C: want SHA1...
C: flush
C: have SHA1
C: done
S: ACK SHA1 continue
S: ACK SHA1 (same hash)
S: the pack...

Then, if I try to git-fetch but there is nothing new, I get:

C: git-upload-pack ....
S: SHA1 HEAD....
S: SHA1 refs/heads/master
S: flush
C: flush
<client closes connection>

So, I can _assume_ that "done" tells the server that it is time to make a
pack. Why does the server use NAK during the clone operation, but ACK
during fetch? Why does the server ACK the same SHA1 twice? And why does the
client "want" the same SHA1 twice? It just seems odd.

I think it would be great if there was some kind of description somewhere
that detailed the protocol. Also, the daemon source isn't the prettiest
thing in the world.

Thanks,
Josef "Jeff" Sipek.

-- 
Reality is merely an illusion, albeit a very persistent one.
		- Albert Einstein
