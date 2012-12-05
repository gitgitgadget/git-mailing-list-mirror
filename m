From: Stephen Bash <bash@genarts.com>
Subject: Re: git-svn with non-standard repository layout
Date: Wed, 5 Dec 2012 18:54:44 -0500 (EST)
Message-ID: <516524996.289805.1354751683987.JavaMail.root@genarts.com>
References: <CAA01CsoS6xA-tGPw81tYmi1ETU8sQ08+oyHGg5ou1VGYrwd_SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Carsten Fuchs <carsten.fuchs@cafu.de>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 00:55:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgOnz-00085k-VA
	for gcvg-git-2@plane.gmane.org; Thu, 06 Dec 2012 00:55:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326Ab2LEXyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 18:54:51 -0500
Received: from hq.genarts.com ([173.9.65.1]:42102 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751963Ab2LEXyv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 18:54:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id F3CFABE2511;
	Wed,  5 Dec 2012 18:54:49 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mP059OIyXQkb; Wed,  5 Dec 2012 18:54:44 -0500 (EST)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 1EE33BE21AE;
	Wed,  5 Dec 2012 18:54:44 -0500 (EST)
In-Reply-To: <CAA01CsoS6xA-tGPw81tYmi1ETU8sQ08+oyHGg5ou1VGYrwd_SQ@mail.gmail.com>
X-Mailer: Zimbra 7.2.0_GA_2669 (ZimbraWebClient - GC23 (Mac)/7.2.0_GA_2669)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211148>

----- Original Message -----
> From: "Piotr Krukowiecki" <piotr.krukowiecki@gmail.com>
> Sent: Wednesday, December 5, 2012 5:19:44 PM
> Subject: Re: git-svn with non-standard repository layout
> 
> Do you mean something like
> 
>    branches = branches/work/*/*:refs/remotes/work/*
>    branches = branches/{branch1,branch2}:refs/remotes/branches/*
> 
> instead of (currently used)
> 
>    branches = branches/work/*/*:refs/remotes/work/*
>    fetch = branches/branch1:refs/remotes/branches/branch1
>    fetch = branches/branch2:refs/remotes/branches/branch2

Essentially yes.  But I guess since you have branches at the same level as the work directory, you either have to add to the glob for each new branch or add another fetch line...  Doesn't seem like a big win to me.  Jumping on a tangent, I thought there could only be one wildcard on the left side of the ':' (and the '*' on the right).  If your work/*/* is actually working, that's quite interesting.
 
> BTW what's the difference between "fetch" and "branches" keys? I could
> only find one: "fetch" does not support glob arguments and "branches"
> do.

That's the only difference I've discovered, though someone more familiar with the code might be able to say more.

Here's my config for the Slimdevices repo I mentioned:

[svn-remote "svn"]
	url = http://svn.slimdevices.com/repos/slim

	fetch = trunk/server:refs/remotes/trunk
	fetch = 7.5/trunk/server:refs/remotes/7.5/trunk
	fetch = 7.6/trunk/server:refs/remotes/7.6/trunk
	fetch = 7.7/trunk/server:refs/remotes/7.7/trunk
	fetch = 7.8/trunk/server:refs/remotes/7.8/trunk

	branches = branches/*/server:refs/remotes/pre7/*
	branches = 7.5/branches/*/server:refs/remotes/7.5/*
	branches = 7.6/branches/*/server:refs/remotes/7.6/*
	branches = 7.7/branches/*/server:refs/remotes/7.7/*
	branches = 7.8/branches/*/server:refs/remotes/7.8/*

	tags = 7.5/tags/*/server:refs/remotes/7.5/tags/*
	tags = 7.6/tags/*/server:refs/remotes/7.6/tags/*
	tags = 7.7/tags/*/server:refs/remotes/7.7/tags/*
	tags = 7.8/tags/*/server:refs/remotes/7.8/tags/*

Lots of repetition, but now that I look at it this repo doesn't have the branches/work clash yours does, which simplifies the config.

HTH,
Stephen
