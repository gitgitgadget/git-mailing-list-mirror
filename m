From: Wolfgang Denk <wd@denx.de>
Subject: Re: GIT 0.99.9
Date: Sun, 30 Oct 2005 21:38:08 +0100
Message-ID: <20051030203808.A535B353E3E@atlas.denx.de>
References: <7vvezesyhi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 30 21:39:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWJxA-0006qp-Qb
	for gcvg-git@gmane.org; Sun, 30 Oct 2005 21:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbVJ3Uib (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 15:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbVJ3Uib
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 15:38:31 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:9637 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751051AbVJ3Uia (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2005 15:38:30 -0500
Received: from fwd33.aul.t-online.de 
	by mailout01.sul.t-online.com with smtp 
	id 1EWJwZ-0007J9-01; Sun, 30 Oct 2005 21:38:19 +0100
Received: from denx.de (rfk5eQZC8etqfbfpyGleXLsKOwofOWcWsLq4kikgtlSSMEg3oJzfsp@[84.150.71.90]) by fwd33.sul.t-online.de
	with esmtp id 1EWJwQ-0TjTsG0; Sun, 30 Oct 2005 21:38:10 +0100
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id EAFC742970; Sun, 30 Oct 2005 21:38:08 +0100 (MET)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id A535B353E3E;
	Sun, 30 Oct 2005 21:38:08 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
In-reply-to: Your message of "Sun, 30 Oct 2005 09:31:21 PST."
             <7vvezesyhi.fsf@assigned-by-dhcp.cox.net> 
X-ID: rfk5eQZC8etqfbfpyGleXLsKOwofOWcWsLq4kikgtlSSMEg3oJzfsp@t-dialin.net
X-TOI-MSGID: 11136b88-3072-42ba-b414-d84498a5181f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10829>

In message <7vvezesyhi.fsf@assigned-by-dhcp.cox.net> you wrote:
>
> > "make rpm" does not work for me:
> 
> I hate it when somebody tells me "it works for me", but I cannot
> help you here, sorry.  I'm no rpm expert and the "make rpm" rule
> seems to work for me.

OK, I found the problem. The key part is this:

[current directory: .../usr/share/git-core/templates/]
    (cd blt && tar cf - .) | \
    (cd '/var/tmp/git-core-0.99.9-1-root-wd/usr/share/git-core/templates/' && tar xf -)
    tar: This does not look like a tar archive
    tar: Skipping to next header
    tar: Error exit delayed from previous errors

I have CDPATH set in my  shell  environment,  and  bash  outputs  the
pathname  of  the  new  working  directory on stdout; this gets piped
together with the tarball to the "tar  xf  -",  and  the  second  tar
complains that the directory name comes unexpected. Test:

-> cd /usr/local/BUILD/git-core-0.99.9/templates
-> cd blt
/usr/local/BUILD/git-core-0.99.9/templates/blt
-> 

As a workaround I can simply unset CDPATH, and the build works  fine.
A more robust build script woul make sure that CDPATH is not set.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Testing can show the presense of bugs, but not their absence.
                                                   -- Edsger Dijkstra
