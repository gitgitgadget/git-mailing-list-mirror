From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Last mile to 1.0?
Date: Sat, 16 Jul 2005 12:36:43 -0600
Message-ID: <m18y06pphg.fsf@ebiederm.dsl.xmission.com>
References: <7vwtnqhcfb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 16 20:37:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtrXV-0003WG-R5
	for gcvg-git@gmane.org; Sat, 16 Jul 2005 20:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVGPShF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jul 2005 14:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVGPShF
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jul 2005 14:37:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22999 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261813AbVGPSg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2005 14:36:59 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6GIahVr018028;
	Sat, 16 Jul 2005 12:36:43 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6GIahXa018027;
	Sat, 16 Jul 2005 12:36:43 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtnqhcfb.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 16 Jul 2005 10:46:00 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> I do not know what release plan Linus has in mind, and also
> expect things to be quieter next week during OLS and kernel
> summit, but I think we are getting really really close.
>
> Here are the things I think we would want to see before we hit
> 1.0:
>
>  - Remaining feature enhancements and fixes.
>
>    - Anonymous pull from packed archives on remote sites via
>      non-rsync, non-ssh transport.  Many people are behind
>      corporate firewalls that do not pass anything but outgoing
>      http(s) and some do not even pass outgoing ssh.  The recent
>      addition of git-daemon by Linus would greatly alleviate the
>      situation, but we may also end up wanting something HTTP
>      reachable.

For this we need a cgi script that will generate an appropriate
pack.  Although stupid http fetching may have some potential
if we ditch libcurl and use pipelining for http 1.1.  Bandwidth
wise that will never equal a custom pack because it will not do
deltas.  But in the common case of an incremental pull it should
be able to equal rsync.

Do we want to put some porcelain around, git-fsck-cache --tags?
So we can discover the tag objects in the archive and place
them someplace usable.  Jeff Garzik in his howto is still recommending:

>   git-pull-script only downloads sha1-indexed object data, and the requested remote head.
>   This misses updates to the .git/refs/tags/ and .git/refs/heads/ directories. It is
>   advisable to update your kernel .git directories periodically with a full rsync command, to
>   make sure you got everything:
>$ cd linux-2.6
>$ rsync -a --verbose --stats --progress \
>   rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ \
>   .git/

Which feels like something is missing.  Given that tags are
sha1-indexed objects we should be pulling them.  And I believe you can
have a tag as a parent of a commit, so even with the pack optimized
clients we should be pulling them now.  


Eric
