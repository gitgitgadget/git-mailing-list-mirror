From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: Alternates and push
Date: Sun, 7 Sep 2008 19:41:18 -0400
Message-ID: <20080907234118.GA8161@mit.edu>
References: <9e4733910809060542s5ede6d6m5bdb894c958ea8b7@mail.gmail.com> <20080906162030.GT9129@mit.edu> <7viqt9rvwm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 01:42:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcTts-0008Me-Q7
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 01:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbYIGXl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 19:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbYIGXl0
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 19:41:26 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:40832 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751107AbYIGXlZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Sep 2008 19:41:25 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m87NfK12020194;
	Sun, 7 Sep 2008 19:41:20 -0400 (EDT)
Received: from closure.thunk.org (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m87NfIl8025650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 7 Sep 2008 19:41:19 -0400 (EDT)
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KcTsc-0003EF-Qs; Sun, 07 Sep 2008 19:41:18 -0400
Content-Disposition: inline
In-Reply-To: <7viqt9rvwm.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95194>

On Sat, Sep 06, 2008 at 11:06:49AM -0700, Junio C Hamano wrote:
> We could instead redefine the semantics of the existing alternates
> mechanism.  This technically *breaks* backward compatibility, but I
> suspect it won't hurt many existing installations:
> 
>  - Declare that a freestanding object store is illegal.  In other words,
>    if a directory "$D/objects" is (1) used as $GIT_OBJECT_DIRECTORY's
>    value, (2) pointed by some repository's "alternates" file, or (3)
>    listed in $GIT_ALTERNATE_OBJECT_DIRECTORIES's value, this change makes
>    it illegal for "$D" not being a proper git repository.
> 
>    This will not break your example of your repository's object store
>    borrowing from the object store inside Linus's repository.
> 
>  - When you have "$D/objects" in alternates, start relying on "$D/refs"
>    being correct (i.e. repository $D is not corrupt).  This technically
>    makes the system slightly less robust, as we are depending on _other
>    people's_ good behaviour even more when you use alternates, but you are
>    already depending on them having good objects in $D/objects anyway, so
>    it is not a big deal.

One way that wouldn't break backwards compatibility would be to use
$D/refs if it exists, but if it isn't, fall back to existing behavior
(which is to say, only use the refs in the repository, not in the
borrowed repository/object store).  Is there a reason why this would
be problematic?

							- Ted
