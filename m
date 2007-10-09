From: Eyvind Bernhardsen <eyvind-git-list@orakel.ntnu.no>
Subject: Re: Problem with git-cvsimport
Date: Tue, 9 Oct 2007 21:41:01 +0200
Message-ID: <47065A5D-D170-4D11-A802-85376F97F8D2@orakel.ntnu.no>
References: <470B491F.9020306@jentro.com> <200710091447.50501.wielemak@science.uva.nl> <470B8049.1090308@samba.org>
Mime-Version: 1.0 (Apple Message framework v907)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jan Wielemaker <wielemak@science.uva.nl>,
	"Gerald (Jerry) Carter" <jerry@samba.org>
To: Thomas Pasch <thomas.pasch@jentro.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 22:03:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfLHe-0005Ko-NK
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 22:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600AbXJIUCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 16:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754445AbXJIUCQ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 16:02:16 -0400
Received: from 97.84-49-228.nextgentel.com ([84.49.228.97]:55406 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754176AbXJIUCP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 16:02:15 -0400
Received: from vredefort.d.eyvind.bernhardsens.net (vredefort.d.eyvind.bernhardsens.net [172.16.3.223])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id E4723607C7F;
	Tue,  9 Oct 2007 21:41:01 +0200 (CEST)
In-Reply-To: <470B8049.1090308@samba.org>
X-Mailer: Apple Mail (2.907)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60434>

On 9. okt.. 2007, at 15.21, Gerald (Jerry) Carter wrote:

> I would actually plug using cvs2svn to convert directly to git.
> See this thread for Michael's original announcement.
>
>   http://marc.info/?l=git&m=118592701426175&w=2

Seconded!  I've tried git-cvsimport, parsecvs, fromcvs, and cvs2svn on  
my employer's many large CVS modules, and cvs2svn is the only one that  
has never mangled an import.

That said, it is a work in progress, so there are some caveats:

* Setting up the direct conversion to git is more work than it should  
(and probably will, eventually) be.

* There is no support for incremental importing, and git-cvsimport  
_will_ mess up your git repository sooner or later if you try to use  
it for subsequent incremental imports.

* Tags each get a branch with a single commit, with the actual tag  
pointing to that commit.  This makes it harder than necessary to  
figure out what the history looks like; gitk's default view won't show  
any tags, for example, since it only shows the master branch and not  
the single-commit tag branches.

* Branches all get a useless commit at their branch point.  All  
branches from the main branch appear to be merged from the vendor  
branch (ie, the useless commit has the vendor branch as an extra  
parent), which might make sense to someone who knows what the vendor  
branch is for, but makes no sense to me.  This combined with the  
previous point makes "gitk --all" look needlessly spaghetti-like if  
you have a slightly complicated CVS history.

To sum up, cvs2svn gets the important stuff right, but has some sharp  
corners you need to watch so you don't put an eye out.

Eyvind Bernhardsen
