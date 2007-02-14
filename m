From: Junio C Hamano <junkio@cox.net>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Wed, 14 Feb 2007 09:45:14 -0800
Message-ID: <7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net>
References: <17875.13564.622087.63653@lisa.zopyra.com>
	<7vhctor78j.fsf@assigned-by-dhcp.cox.net>
	<17875.17647.74882.218627@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 18:45:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHOC1-0002cP-Iu
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 18:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbXBNRpQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 12:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbXBNRpQ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 12:45:16 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:64582 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbXBNRpP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 12:45:15 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214174515.GQKN21177.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 12:45:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PVlE1W00E1kojtg0000000; Wed, 14 Feb 2007 12:45:14 -0500
In-Reply-To: <17875.17647.74882.218627@lisa.zopyra.com> (Bill Lear's message
	of "Wed, 14 Feb 2007 11:20:47 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39701>

Bill Lear <rael@zopyra.com> writes:

> % git fsck-objects --full
> error: Packfile .git/objects/pack/pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.pack SHA1 mismatch with itself
> fatal: failed to find delta-pack base object 90bad0d280a6d7c155bbd9582b35ffcf5e3bdd27
>
>
> % /usr/bin/git --version
> git version 1.4.4.1
>
> % /usr/bin/git fsck-objects --full
> error: Packfile .git/objects/pack/pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.pack SHA1 mismatch with itself
> fatal: failed to find delta-pack base object 90bad0d280a6d7c155bbd9582b35ffcf5e3bdd27
>
> So, all I did was try to do a commit with the new git ... haven't
> recloned, or pulled from upstream...

If you haven't packed the repository lately, the above indicates
this is not an issue between 1.4.4.1 and 1.5.0, but you had a
corrupt packfile before even started.

How big is this pack, what platform are you working on and whose
SHA-1 implementation do you use?

We used to have a bug that fed really large buffer to
SHA1_Update() function of the underlying SHA-1 library,
which was discovered exactly because somebody reported that
"mismatch with itself" message.

Also, do you have a huge blob in the repository?  I do not know
if it is related but the write_sha1_file_prepare() function on
the codepath to write loose objects out would trigger the same
bug...
