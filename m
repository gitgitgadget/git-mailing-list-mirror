From: linux@horizon.com
Subject: Re: [zooko@zooko.com: [Revctrl] colliding md5 hashes of human-meaningful
Date: 13 Jun 2005 19:50:38 -0000
Message-ID: <20050613195038.9191.qmail@science.horizon.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 21:50:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dhux6-0003u5-CK
	for gcvg-git@gmane.org; Mon, 13 Jun 2005 21:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVFMTyb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Jun 2005 15:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVFMTy1
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jun 2005 15:54:27 -0400
Received: from science.horizon.com ([192.35.100.1]:57130 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261246AbVFMTuo
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2005 15:50:44 -0400
Received: (qmail 9192 invoked by uid 1000); 13 Jun 2005 19:50:38 -0000
To: git@vger.kernel.org, torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> So the problem is totally different from the way git uses a hash. In the 
> git model, an attacker by definition cannot control both versions of a 
> file, since if he controls just _one_ version, he doesn't need to do the 
> attack in the first place!

You are insufficiently paranoid, Grasshopper.

The basic attack goes like this:

- I construct two .c files with identical hashes.  One is something
  useful; perhaps a device driver for some piece of hardware that my
  desired target has.  The other is similar, but includes a remote
  root explot.

  (With an n-bit hash and an automated way to make harmless changes
  to source files, I can generate 2^(n/2) variants of each and expect to
  get a match, even in the absence of a better attack.)

- I submit the first one to the Linux kernel.  It's valid and gets
  merged.

- A kernel release, including the "interesting" driver, gets made and
  sprinkled with holy penguin pee.  Signatures, hashes, and all that.

- Through various means (possibly just running a kernel download mirror,
  or possibly by splicing into my target's upstream Internet connection),
  I substitute the malware file for the real source code.

- My target verifies all the hashes and signatures, decides that this "Linus"
  person signing it is trustworthy, and compiles and installs the kernel.

- I walk in my back door and do suitable rude things.


The point is, it *is* possible for an attacker to control both versions of
a file.  The reason he needs to do the attack is that one version looks
legitimate and the other includes a Nasty Surprise.
