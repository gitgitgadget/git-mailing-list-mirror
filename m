From: Junio C Hamano <junkio@cox.net>
Subject: Re: Balanced packing strategy
Date: Sat, 12 Nov 2005 18:34:02 -0800
Message-ID: <7vveyxcm3p.fsf@assigned-by-dhcp.cox.net>
References: <1131800663.29461.11.camel@blade>
	<cae2e895f6598781f4f22b76e781684b@codefountain.com>
	<20051112135947.GC30496@pasky.or.cz>
	<b6abcb70496730705046934973221b93@codefountain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 13 03:36:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb7iK-0007jP-Ad
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 03:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbVKMCeH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 21:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbVKMCeH
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 21:34:07 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:13740 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750854AbVKMCeG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 21:34:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051113023404.KAIB9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 12 Nov 2005 21:34:04 -0500
To: Craig Schlenter <craig@codefountain.com>
In-Reply-To: <b6abcb70496730705046934973221b93@codefountain.com> (Craig
	Schlenter's message of "Sat, 12 Nov 2005 17:14:36 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11723>

Craig Schlenter <craig@codefountain.com> writes:

> Does the pack index file contain enough information to enable a client
> to send http byte range requests to grab individual objects from a pack?
> It does seem to store object offsets...

Yes, it is certainly doable; there is enough information.  I am
not sure if it is worth the complexity, though.

Many objects are stored delitified, so your byte range requests
would return delta and base object name.  After you read what
was returned and find out the base object name, you would need
to get it, which can be another delta against its base object.
This would make tangling a delta chain would become a serialized
sequence of requests.
