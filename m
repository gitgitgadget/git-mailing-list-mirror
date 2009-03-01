From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rogue tree objects, how to diagnose?
Date: Sat, 28 Feb 2009 22:40:34 -0800
Message-ID: <7vvdqtagpp.fsf@gitster.siamese.dyndns.org>
References: <20090301032035.GB30384@coredump.intra.peff.net>
 <20090228.194454.05711858.davem@davemloft.net>
 <20090301034632.GA318@coredump.intra.peff.net>
 <20090228.215752.122159841.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Sun Mar 01 07:42:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdfNN-00088j-G4
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 07:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbZCAGkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 01:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752611AbZCAGkq
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 01:40:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51632 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbZCAGkp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 01:40:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4D7B9266C;
	Sun,  1 Mar 2009 01:40:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 94868266B; Sun, 
 1 Mar 2009 01:40:36 -0500 (EST)
In-Reply-To: <20090228.215752.122159841.davem@davemloft.net> (David Miller's
 message of "Sat, 28 Feb 2009 21:57:52 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E16D1B3E-062B-11DE-BB2E-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111820>

David Miller <davem@davemloft.net> writes:

> Indeed I have some serious corruption in my pack file.

Just a sanity check; did you run verify-pack on each packfile to validate
that suspicion?

> I've put this .git dir up at:
>
> 	http://vger.kernel.org/~davem/netnext26_git.tar.gz
>
> if anyone wants to have a look.
>
> davem@sunset:~/src/GIT/net-next-2.6$ git fsck --full
> error: d7d82ec12e618a3152a82f7fbd459ad285403740: invalid sha1 pointer in cache-tree
> error: 95381186c4ef9d69f56bb6a9f7334ebe81dd023c: invalid sha1 pointer in cache-tree
> error: 6bea4ad565fff638d396298cb6ee7ad6a31ca252: invalid sha1 pointer in cache-tree
> error: 3c8b516f2a9634410f6c3a0ee639627d7c4a83d2: invalid sha1 pointer in cache-tree
> error: 11f0695e84bc3f83a6eea0d6fb0af2789de351ef: invalid sha1 pointer in cache-tree
> error: 7b3c81544c3117201c160af43fa983d68c614e3d: invalid sha1 pointer in cache-tree
> error: c9ee57c5c20c3b7a2d7784a4172aef8b34c3a844: invalid sha1 pointer in cache-tree

These may only indicate that your .git/index is corrupt but the object
database may still be good.

We fixed an incorrect "missing object" diagnosis when your repository
borrows objects from another repository via the alternates mechanism
(check if .git/objects/info/alternates refers to another repository)
fairly recently.  "Missing objects" could be false alarms.
