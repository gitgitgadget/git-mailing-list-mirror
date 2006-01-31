From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] shallow clone
Date: Tue, 31 Jan 2006 12:59:31 -0800
Message-ID: <7vr76oun9o.fsf@assigned-by-dhcp.cox.net>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xsxa70o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 22:00:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F42bA-0003UV-E0
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 21:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWAaU7f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 15:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWAaU7f
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 15:59:35 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:28599 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751397AbWAaU7e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 15:59:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060131205834.ZVUJ3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 Jan 2006 15:58:34 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <7v8xsxa70o.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 30 Jan 2006 10:46:15 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15345>

This is whacky, but another completely different strategy is to
introduce remote alternates.

If you can allow objects/info/alternates to name a repository
that is not on the local disk, we can set the original remote
repository we "clone" from as one of the alternates, and teach
read_sha1_file() to locally cache objects we read from remote
alternates.

After such a "shallow clone", the user may want to prime the
cache by something like:

	$ git-rev-list --objects v2.6.14..master |
          git-pack-objects --stdout >/dev/null

before going offline.  Obviously you can keep the resulting pack
instead of leaving things loose.

I am not seriously advocating this yet -- adding calls to http
and git transfer machinery in read_sha1_file(), which is as low
level as you can go, is not something I have guts to do at the
moment.
