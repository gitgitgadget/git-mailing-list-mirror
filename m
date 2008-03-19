From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git svn rebase horror
Date: Wed, 19 Mar 2008 16:39:08 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803191616240.19665@iabervon.org>
References: <c6c947f60803181151k63e9ce26oca97b36c0d542593@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 21:50:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc5Dy-000683-AS
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 21:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756995AbYCSUjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 16:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755496AbYCSUjO
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 16:39:14 -0400
Received: from iabervon.org ([66.92.72.58]:38355 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932496AbYCSUjK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 16:39:10 -0400
Received: (qmail 16770 invoked by uid 1000); 19 Mar 2008 20:39:08 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Mar 2008 20:39:08 -0000
In-Reply-To: <c6c947f60803181151k63e9ce26oca97b36c0d542593@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77544>

On Tue, 18 Mar 2008, Alexander Gladysh wrote:

> Frankly (as I'm quite a dilettante with git), I do not completely
> understand the reasons for all the conflicts. The "endpoint" version
> of code is already known -- since I've successfully merged two
> branches. All steps to get that version must be known as well -- full
> history tree is available. Except, as I think, that SHA1 for
> cherry-picked commits are different -- due to that git-svn-id: thingy.
> But perhaps merge process can be taught to handle it? Or does the
> reason for the conflicts lurk somewhere else?

The fundamental problem is that you've got:

 a - b - - - c
  \   \       \
   d - e - f - g

In 'e', you resolved conflicts between 'b' and 'd'. In 'g', you resolved 
conflicts between 'c' and 'f', but anything that changed in 'd', 'f', and 
'c' is going to be a problem, because for the replacement for 'd', you 
need something that includes 'c', includes 'd', and doesn't include 'f', 
which isn't 'e' (doesn't have 'c') or 'g' (does have 'f').

Of course, you probably don't *really* care about what goes in the new 
'd', because it's going to be replaced in 'f' anyway. But in order to have 
a complete history, you need to either make something up or squash such 
that there's no state in between like that.

	-Daniel
*This .sig left intentionally blank*
