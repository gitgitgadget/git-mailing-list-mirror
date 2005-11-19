From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [QUESTION] Access to a huge GIT repository.
Date: Sat, 19 Nov 2005 09:56:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511190953520.13959@g5.osdl.org>
References: <cda58cb80511160424j1acac7c6j@mail.gmail.com> 
 <Pine.LNX.4.64.0511160837000.13959@g5.osdl.org>  <cda58cb80511170236p4a7e2baay@mail.gmail.com>
  <Pine.LNX.4.64.0511170817480.13959@g5.osdl.org>  <cda58cb80511171347yef4f090g@mail.gmail.com>
  <Pine.LNX.4.64.0511171443000.13959@g5.osdl.org> <cda58cb80511190423w1e46bf5bu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 19 18:58:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdWxg-0007az-OY
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 18:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVKSR5I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 12:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbVKSR5I
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 12:57:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43156 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750727AbVKSR5H (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Nov 2005 12:57:07 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAJHv0nO010536
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 19 Nov 2005 09:57:01 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAJHuxAd004840;
	Sat, 19 Nov 2005 09:57:00 -0800
To: Franck <vagabon.xyz@gmail.com>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <cda58cb80511190423w1e46bf5bu@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12346>



On Sat, 19 Nov 2005, Franck wrote:
> 
> Then by running git-repack -a -d, I build a new small pack that
> contains only latest objects, but then the script runs
> git-redundant-pack script which erases the new small one since all its
> objects are included in the old big one. Is that correct ?

Gaah.

The git-redundant-pack logic has totally broken "git repack -a -d"

Junio, can we undo that, please? With "-a", redundant pack removal is 
trivial (and we used to do it right, exactly because it is trivial), and 
without "-a", redundant pack removal is pointless (since it will never 
pack objects that are already packed).

So "git repack" should _never_ call git-redundant-pack. It's always either 
wrong or pointless.

git-redundant-pack is great for "git prune", not for repack.

		Linus
