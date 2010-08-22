From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git-describe --contains fails on given tree
Date: Sun, 22 Aug 2010 23:58:04 +0200
Message-ID: <201008222358.04504.trast@student.ethz.ch>
References: <alpine.LSU.2.01.1008212145520.14934@obet.zrqbmnf.qr> <m3occvoi5c.fsf@localhost.localdomain> <alpine.LSU.2.01.1008212241410.23864@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, <git@vger.kernel.org>
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Sun Aug 22 23:58:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnIYd-0008Kf-6e
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 23:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727Ab0HVV6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 17:58:08 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:17018 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856Ab0HVV6H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 17:58:07 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 22 Aug
 2010 23:58:05 +0200
Received: from thomas.site (129.132.208.191) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.0.702.0; Sun, 22 Aug
 2010 23:58:05 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <alpine.LSU.2.01.1008212241410.23864@obet.zrqbmnf.qr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154196>

Jan Engelhardt wrote:
> 
> On Saturday 2010-08-21 21:55, Jakub Narebski wrote:
> >> for some reason, git-describe cannot figure out v1.17~15^2^2 in
> >> the pam_mount tree, despite me being able to actually give
> >> a description that would fit the contains syntax:
> >What does
> >
> >  $ git describe --contains --tags v1.17~15^2^2
> 
> "Cannot describe 95ce..."
> 
> Funny thing is, describing "v1.17~15^2" does work, as does "v1.17~15^1".

That's clock skew:

  $ git show -s --format="%cd" v1.17~15^2 
  Fri Jan 9 04:35:59 2009 +0100

  $ git show -s --format="%cd" v1.17~15^2^2
  Sat Jan 24 16:35:34 2009 +0100

Note how the parent commit is far newer than the child.  git-name-rev
(which is what really drives git describe --contains) concludes that
it can stop searching along this line of history.

Interestingly, --stdin disables this optimization:

  $ git rev-parse v1.17~15^2^2 | git name-rev --stdin
  95ce932690dfce8cbe50b6a3a8949e41a54c8966 (tags/v1.17~15^2^2)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
