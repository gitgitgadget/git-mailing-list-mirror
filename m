From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-rev-list: Don't die on a bad tag
Date: Sat, 27 Aug 2005 02:14:57 -0700
Message-ID: <7vacj3vizy.fsf@assigned-by-dhcp.cox.net>
References: <4310217D.80408@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 27 11:16:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8wmm-0004GY-FT
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 11:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbVH0JO7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Aug 2005 05:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030343AbVH0JO7
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Aug 2005 05:14:59 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:14044 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030337AbVH0JO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2005 05:14:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050827091459.ZWJN12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 27 Aug 2005 05:14:59 -0400
To: Frank Sorenson <frank@tuxrocks.com>
In-Reply-To: <4310217D.80408@tuxrocks.com> (Frank Sorenson's message of "Sat,
	27 Aug 2005 02:17:01 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7848>

Frank Sorenson <frank@tuxrocks.com> writes:

> The current cogito tree contains an invalid tag
> (junio-gpg-pub => 0918385dbd9656cab0d1d81ba7453d49bbc16250), and
> git-repack-script (and probably others) will die when git-rev-list
> tries to dump the objects.  This patch changes it to complain, but
> continue.
>
> Signed-off-by: Frank Sorenson <frank@tuxrocks.com>

I think this patch is wrong.

The check you are disabling is to see if the repository contains
an object that a tag refers to, and the user wanted to slurp the
tag, along with whatever thing it refers to, so barfing and
dying is the only right thing to do.

The repository does not have the object the tag points at.  IOW,
the repository is not fsck clean.

If it bothers you either you could drop that tag from cogito
repository (because there would not be anything that is signed
by _my_ public key anyway), or borrow the object from git.git
repository.
