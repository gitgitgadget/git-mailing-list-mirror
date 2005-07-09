From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Sat, 09 Jul 2005 16:46:21 -0700
Message-ID: <7vpstrv8z6.fsf@assigned-by-dhcp.cox.net>
References: <20050707144501.GG19781@pasky.ji.cz>
	<7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071158220.3293@g5.osdl.org>
	<20050707221443.GB7151@pasky.ji.cz>
	<Pine.LNX.4.58.0507071549330.25104@g5.osdl.org>
	<12c511ca05070716526954edd@mail.gmail.com>
	<Pine.LNX.4.58.0507071658460.25104@g5.osdl.org>
	<12c511ca050707170964a2cc92@mail.gmail.com>
	<Pine.LNX.4.58.0507071720330.25104@g5.osdl.org>
	<20050709225818.A31045@flint.arm.linux.org.uk>
	<20050709232955.B31045@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Tony Luck <tony.luck@gmail.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 01:47:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrP1o-0007zq-Lq
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 01:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbVGIXqa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jul 2005 19:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbVGIXqa
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jul 2005 19:46:30 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:5587 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261779AbVGIXq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2005 19:46:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050709234623.TQPX1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 9 Jul 2005 19:46:23 -0400
To: Russell King <rmk@arm.linux.org.uk>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "RK" == Russell King <rmk@arm.linux.org.uk> writes:

>> $ mv .git/objects/pack/* .git/
>> $ for i in .git/*.pack; do git-unpack-objects < $i; done
>> Unpacking 55435 objects
>> fatal: inflate returned -3
>> 
>> so it seems that the pack is corrupt... or something.
>> 
>> $ md5sum .git/*.pack
>> 2be38f2947b99bcd088c1930122aadec  .git/pack-e3117bbaf6a59cb53c3f6f0d9b17b9433f0e4135.pack

RK> Additional information: x86 box, running FC2, cogito 0.12 built from
RK> the src.rpm on kernel.org.  Lots of disk space (blocks + inodes)
RK> remaining.

Hmph, I am worried about that inflate() failure.  An x86 box,
running Debian sarge, vanilla git without Cogito built from
Linus tip.  From here, it does not look like the pack corruption
to me; unless you broke md5sum and found a collission, that is.

: siamese; type git-unpack-objects
git-unpack-objects is /home/junio/bin/Linux/git-unpack-objects
: siamese; ldd /home/junio/bin/Linux/git-unpack-objects
        libz.so.1 => /usr/lib/libz.so.1 (0xb7f8e000)
        libcrypto.so.0.9.7 =>
        /usr/lib/i686/cmov/libcrypto.so.0.9.7 (0xb7e8e000)
        libc.so.6 => /lib/tls/libc.so.6 (0xb7d59000)
        libdl.so.2 => /lib/tls/libdl.so.2 (0xb7d56000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0xb7fad000)
: siamese; cd /opt/packrat/playpen/public/in-place/git/linux-2.6/
: siamese; md5sum .git/objects/pack/pack-*.pack
2be38f2947b99bcd088c1930122aadec  .git/objects/pack/pack-e3117bbaf6a59cb53c3f6f0d9b17b9433f0e4135.pack
: siamese; cd ..
: siamese; mkdir junk
: siamese; cd junk
: siamese; git-init-db
defaulting to local storage area
: siamese; git-unpack-objects <../linux-2.6/.git/objects/pack/pack-e3117bbaf6a59cb53c3f6f0d9b17b9433f0e4135.pack
Unpacking 55435 objects  100% (55434/55435) done
