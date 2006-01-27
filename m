From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Refs naming after clone (was: Re: How to create and keep up to date a naked/bare repository?)
Date: Fri, 27 Jan 2006 11:30:50 +0100
Message-ID: <200601271130.50322.Josef.Weidendorfer@gmx.de>
References: <7v1wyvn9pc.fsf@assigned-by-dhcp.cox.net> <m34q3q9759.fsf@localhost.localdomain> <7vd5ie735a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 27 11:31:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2QtG-0004ru-IU
	for gcvg-git@gmane.org; Fri, 27 Jan 2006 11:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbWA0Ka6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jan 2006 05:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbWA0Ka6
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jan 2006 05:30:58 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:19353 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1030292AbWA0Ka5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2006 05:30:57 -0500
Received: from dhcp-3s-57.lrr.in.tum.de (dhcp-3s-57.lrr.in.tum.de [131.159.35.57])
	by mail.in.tum.de (Postfix) with ESMTP id 536AF2162;
	Fri, 27 Jan 2006 11:30:52 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9
In-Reply-To: <7vd5ie735a.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15180>

Hi,

On Friday 27 January 2006 04:36, Junio wrote:
> The latest git-clone.sh stopped creating both refs/heads/origin
> and remotes/origin.  The former was to prevent common mistake
> when using it as a shared repository, but removal of the latter
> might have been a mistake.  I dunno.

IMHO it is convenient if git-clone remembers the origin repository
in any case.
 
> Let's step back a bit and think about the modes of usage for a
> bare cloned repository.

It would be nice to have a default which is working nice in all cases
(not only bare ones as discussed here).

IMHO the main problem with the current default (creating master and origin
heads after cloning) is that two namespaces are mixed up:
(1) local (possible development) heads
(2) and heads tracking remote heads

Any compatibility issues aside, wouldn't it be better to have another
namespace for (2), similar to the proposed ref namespaces for subprojects,
like refs/remote/<remote-shortcut>/heads/<remote-head> ?
Clone would create a head refs/remote/origin/heads/master to track the
master of the origin remote repo.

In the case of a the mirror discussed here, you would default to
quite cumbersome long head names:
Tracking master of git://git.kernel.org/pub/scm/git/git.git in
the central mirroring repository would be done on "remote/origin/heads/master",
and tracking this mirror head in developer repos would give a head
name "remote/origin/remote/origin/heads/master".

Still, I think this is nice because everybody can see that above head
is tracking a remote head which is tracking itself another remote
head. gitk could give remote tracking heads another color.

Note that I talk only about the default setup, which of course can be
changed by changing .git/remotes/origin.
Eg. in the mirror case, you probably want local and remote namespace
being the same, ie. .git/refs/heads/* -> .git/refs/remote/origin/heads/*

Perhaps a command to rename head names, which automatically updates
pull/push lines of .git/remotes/ accordingly would be nice here.
Also a command to rename remote shortcuts (e.g. origin to gitmain),
renaming above proposed head names accordingly would be nice.

Josef
