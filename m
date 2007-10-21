From: Rocco Rutte <pdmef@gmx.net>
Subject: Re: [PATCH-resent] gitk: fix in procedure drawcommits
Date: Sun, 21 Oct 2007 14:12:36 +0200
Organization: Berlin University of Technology
Message-ID: <20071021121236.GA290@localhost.daprodeges.fqdn.th-h.de>
References: <20071019052823.GI14735@spearce.org> <200710191544.22228.barra_cuda@katamail.com> <18201.54648.707559.480169@cargo.ozlabs.ibm.com> <200710201802.48111.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 14:12:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjZfs-0005gY-L3
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 14:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbXJUMMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 08:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbXJUMMp
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 08:12:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:42462 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751360AbXJUMMo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 08:12:44 -0400
Received: (qmail invoked by alias); 21 Oct 2007 12:12:41 -0000
Received: from dslb-088-073-081-135.pools.arcor-ip.net (EHLO localhost.daprodeges.fqdn.th-h.de) [88.73.81.135]
  by mail.gmx.net (mp038) with SMTP; 21 Oct 2007 14:12:41 +0200
X-Authenticated: #1642131
X-Provags-ID: V01U2FsdGVkX1/Ay+ddLNbAx9RcOg8TYzJrzd7dYlUjfsdv3BhNK2
	rOyi3UREJBJAyx
Mail-Followup-To: Michele Ballabio <barra_cuda@katamail.com>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <200710201802.48111.barra_cuda@katamail.com>
X-GnuPG-Key: http://user.cs.tu-berlin.de/~pdmef/rrutte.gpg
X-Blog: http://user.cs.tu-berlin.de/~pdmef/horst.cgi?o
X-System: localhost (Darwin 8.10.2 i386)
User-Agent: Mutt/1.5.16 (2007-10-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61899>

[ No need to Cc: me as I'm on the git list, too ]

Hi,

* Michele Ballabio [07-10-20 18:02:47 +0200] wrote:

>Uh-oh. I think I just found the issue. That's probably a bug
>somewhere in the import (either fast-export or fast-import or
>the original repo, I don't know), so I'm not sure if gitk
>should be patched, but since the resulting repo seems correct
>as far as git is concerned (i.e. git fsck --full --strict
>doesn't complain), I guess something should be done.

>Here is the culprit (or so I think). One of the guilty commits is:

>	commit a3b4383d69e0754346578c85ba8ff7c05bd88705
>	tree 1bf99cd22abe97c59f8c0b7ad6b8244f0854b8af
>	parent 6d919fccf603aba995035fa0fb507aa2bd3bf0ae
>	parent 6d919fccf603aba995035fa0fb507aa2bd3bf0ae
>	author Brendan Cully <brendan@kublai.com> 1179646159 -0700
>	committer Brendan Cully <brendan@kublai.com> 1179646159 -0700

>	    Forget SMTP password if authentication fails.
>	    Thanks to Gregory Shapiro for the initial patch (I've moved the reset
>	    from smtp_auth_sasl up to smtp_auth, and used the account API
>	    instead of twiddling account bits by hand). Closes #2872.

Oh. Yes, this is a bug in the python scripts that get merges quite 
wrong. I didn't notice that earlier as git doesn't complain and the 
contents of the repo turns out as identical.

I'll push fixes (e.g. packed refs support) to the fast-export repo in 
Monday. With these changes, the mutt repo as well hg-crew (which has far 
more merges than the mutt repo) seem to work correctly (no identical 
parents and identical contents).

Thanks for tracking it down.

Still I think fast-import could warn or error out if its gets such 
content which doesn't really make sense...

Rocco
