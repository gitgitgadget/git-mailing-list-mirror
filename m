From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git-status does not propagate -uall to submodules
Date: Fri, 17 Feb 2012 23:11:06 +0100
Message-ID: <4F3ED07A.8090508@web.de>
References: <874nupq0la.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Feb 18 02:29:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyZ6k-0005ZB-4V
	for gcvg-git-2@plane.gmane.org; Sat, 18 Feb 2012 02:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086Ab2BRB2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 20:28:32 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:36055 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab2BRB2c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 20:28:32 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate01.web.de (Postfix) with ESMTP id 6AAD61ABEF007
	for <git@vger.kernel.org>; Fri, 17 Feb 2012 23:11:09 +0100 (CET)
Received: from [192.168.178.48] ([91.3.177.47]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0LqlAw-1SSbyJ02dO-00e29X; Fri, 17 Feb 2012 23:11:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <874nupq0la.fsf@thomas.inf.ethz.ch>
X-Provags-ID: V02:K0:8tl7zSq0Sz13kE7yeyMieyOk4QlJBcm0FvLB7iJhIUj
 yE1UNILuIxB3hLjda6QNBlT1OX9+SQ7/Tbult44EZQYd483Lqj
 KvEV1Ux6d8Rubljel0tSfJlGfhFOfEQ6pQBd+Kb+5e6FFLFCGj
 Ecij2jn0RTmFJ10JhLzDTYXOATESD2/ogzV7K4fMtq4DS8hmRl
 TXXdcP5wetGZZHGBe/9dQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190991>

Am 17.02.2012 10:18, schrieb Thomas Rast:
> Hi,
> 
> While helping with the submodule display on #git I noticed that if you
> have a submodule with status.showuntrackedfiles=no, and run 'git status
> -uall' from the superproject, then this does not propagate into the
> submodule's status.  In code:
> 
>   $ (cd bar && git config status.showuntrackedfiles)                  
>   no                                                                                                 
>   $ git ls-files -s                                                   
>   100644 926c01b7259c489a422442a8dc5cb5ea7c58f60c 0       .gitmodules                                
>   160000 eb5af46e1a938d064c9f7bae9561013654a43316 0       bar                                        
>   $ (cd bar && git status -s -unormal)
>   ?? otheruntracked                                                                                  
>   ?? untracked
>   $ git status
>   # On branch master
>   nothing to commit (working directory clean)
> 
> So far that's expected; after all the submodule is configured not to
> display untracked files.  But with -uall:
> 
>   $ git status -uall
>   # On branch master
>   nothing to commit (working directory clean)
> 
> Shouldn't the -uall propagate, since the user is explicitly asking for
> it?  That is, the display should summarize what git-status *with the
> same arguments* would show inside the submodules?

Yes, that makes sense. In 3bfc45047 (git status: ignoring untracked
files must apply to submodules too) I added that using -uno will
propagate into submodules. But -uall (and I suspect -unormal too)
should also be passed to the status commands forked inside the
submodules (even though in both cases -unormal should suffice as only
the presence or absence of untracked files will be shown anyway).

But opposed to -uno, which overrides any diff.ignoreSubmodules or
submodule.<name>.ignore settings for the submodules, what should
-unormal and -uall do? These options are used to override the
status.showuntrackedfiles setting, so I suspect even when these
options are given submodules which are configured to ignore untracked
files via diff.ignoreSubmodules or submodule.<name>.ignore should
still be dropped, right?
