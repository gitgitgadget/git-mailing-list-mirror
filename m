From: David Brown <git@davidb.org>
Subject: Re: NIST's policy: sha-1 until 2010, after 2010 sha-2.
Date: Fri, 28 Dec 2007 21:07:12 -0800
Message-ID: <20071229050712.GA27378@old.davidb.org>
References: <998d0e4a0712282027y6e625141jcef90bd38fb83b75@mail.gmail.com> <ee77f5c20712282045ha230f42n3e68477229deb199@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: "J.C. Pizarro" <jcpiza@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 06:08:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8TvZ-0004HQ-QE
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 06:08:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbXL2FHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 00:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbXL2FHS
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 00:07:18 -0500
Received: from mail.davidb.org ([66.93.32.219]:48091 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753AbXL2FHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 00:07:16 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1J8Tuj-0007Ib-0k; Fri, 28 Dec 2007 21:07:13 -0800
Mail-Followup-To: David Symonds <dsymonds@gmail.com>,
	"J.C. Pizarro" <jcpiza@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <ee77f5c20712282045ha230f42n3e68477229deb199@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69310>

On Sat, Dec 29, 2007 at 03:45:35PM +1100, David Symonds wrote:
>On Dec 29, 2007 3:27 PM, J.C. Pizarro <jcpiza@gmail.com> wrote:
>> Dear Linus Torvalds,
>>
>> What do you think to do when your git has to change from SHA-1 to SHA-2
>>   because of the weaker collision-resistance of SHA-1 in the next years?
>>
>>     (e.g. from an damn developer trying to commit a collisioned-SHA-1 file)
>
>It's a non-issue. The closest-to-practical attack method on SHA-1 is a
>collision-finding attack, not a second pre-image attack, which means
>you can find two messages with the same hash. As far as I know,
>there's no significant weakness known for finding a pre-image, which
>would be the most practical way of weakening Git's "security" via
>SHA-1 substitution.

<http://en.wikipedia.org/wiki/Birthday_attack> has some good background on
the "problem".

I suppose when SHA-1 is broken and people can generate arbitrary files with
the same hash, it would be possible to use this to make files that were
annoying to try and use with Git.  Git wouldn't have any problem with
normal colliding files, since it hashes the files with a prefix, so the
files would have to be generated specifically for git.

>Regardless, the use of SHA-1 in Git isn't primarily for security,
>though it is a nice side-effect. The SHA-1 is there for reliability in
>addressing and as a good hash.

Given a method for producing a colliding pair for SHA1, it would be
possible to check in a version of a file and later replace it in a
repository with the other version without detection.  The current pairs for
MD5 contain blocks of binary data, so this would be fairly obvious if it
got checked into source code.

It would also only replace the blob on a compromised machine.  Anyone who
has already pulled the blob wouldn't download the new one.

As far as a collision occurring accidentally, according to the Wiki page
(the math looks right), for a 128-bit hash, 820 billion objects would have
a 10^(-15) probability of a collision.  SHA-1 is 160 bits, so the
probability is even lower.

The possible (or even likely) breaking of SHA-1 is only for intentional
collisions.  SHA-1 as a non-colliding hash function should be good for
trillions of objects, and that's all in the same repo.

It might be worth tossing around ideas for using a larger hash in a fairly
long-term future, though.

Dave
