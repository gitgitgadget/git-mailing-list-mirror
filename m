From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Windows symlinks
Date: Wed, 25 Jun 2008 01:29:56 +0200
Message-ID: <200806250129.56271.robin.rosenberg.lists@dewire.com>
References: <911589C97062424796D53B625CEC0025E4618F@USCOBRMFA-SE-70.northamerica.cexp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Patrick.Higgins@cexp.com
X-From: git-owner@vger.kernel.org Wed Jun 25 01:35:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBI2G-0002UV-Q6
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 01:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbYFXXd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 19:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbYFXXd5
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 19:33:57 -0400
Received: from av9-2-sn2.hy.skanova.net ([81.228.8.180]:57957 "EHLO
	av9-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbYFXXd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 19:33:56 -0400
Received: by av9-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id 4DE9C38026; Wed, 25 Jun 2008 01:33:55 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av9-2-sn2.hy.skanova.net (Postfix) with ESMTP
	id 2780437E70; Wed, 25 Jun 2008 01:33:55 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id DB56837E45;
	Wed, 25 Jun 2008 01:33:54 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <911589C97062424796D53B625CEC0025E4618F@USCOBRMFA-SE-70.northamerica.cexp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86182>

onsdagen den 25 juni 2008 00.42.49 skrev Patrick.Higgins@cexp.com:
> It looks like one of the bigger (biggest?) hurdles for git adoption at my company is going to be handling symlinks on Windows. We may be able to sidestep the issue entirely by having developers run Linux in a virtual machine (or better yet, Windows in a VM) because we deploy to Linux and thus can make a very strong argument that developers should develop on Linux, too. That run into an image problem where people might start blaming git for needing to have an extra operating system around just for revision control.

Right, they could use only Linux and not have an extra OS for email..
> 
> We currently use Clearcase snapshot views on Windows and it has some kind of magic to be able to deal with symlinks. I haven't actually used the Windows version of Clearcase so I don't know how it does it, but my understanding is that it handles them with copies, and I guess it somehow knows to update all the copies when a change is made.

It is one of the few sane things clearcase does. msysgit's approach is just unusable. I've not come up with the patches yet. Clearcase makes copies
instead of the symlinks and updates them on checkout/checkin and update.
Git could do one step better by updating copies when index is updated, avoiding an unnecessary commit (which is pretty annoying in CC).
Invalid symlinks, i.e. pointing at non-existent objects or outside then VOB (repository in Git parlance, don't show up at all in snapshot views. Git could do the same thereby making the workdir usable
when it contains and depends on symlinks.

> Has anyone thought about a way for git to handle symlinks? Vista seems to have added native symlinks, but you need have elevated privilege to create
> them. NTFS junction points seem helpful for older versions of Windows, but don't work for anything except directories, and seem to be dangerous to use with tools that do recursive deletes. Neither junction points nor native symlinks sound like great options. 
Obviously one could make this a switchable feature and enable it when the
file system supports it. As for junction points i'd say no too. What little testing I did on symlinks in vista they seem capable of most sane uses.

> Cygwin's clever symlink trick seems to work pretty well in practice. I'm not exactly sure what it's doing, but it seems to create a shortcut that it's own programs understand. Some other non-Cygwin programs seem to understand them, too, but Java does not which is a big problem for me.
> 
> I just don't see any good solutions here. Does anyone have any better ideas?

No, copies. If you have a patch I can test it and then implement it for jgit, which doesn't have symlinks either.

-- robin
