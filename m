From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Is there an agreed protocol for git repo locking?
Date: Sun, 10 May 2009 08:17:52 -0700 (PDT)
Message-ID: <m3hbztm1gi.fsf@localhost.localdomain>
References: <2cfc40320905100658i4d7ef065qe01e35f2929dd2f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 10 17:19:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3Amw-00087G-KR
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 17:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846AbZEJPR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 11:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752335AbZEJPRz
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 11:17:55 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:35650 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504AbZEJPRy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 11:17:54 -0400
Received: by bwz22 with SMTP id 22so2194387bwz.37
        for <git@vger.kernel.org>; Sun, 10 May 2009 08:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=9Ktd8mzg/DRl5daPmxJbRzvkjCWqqOIKeEoHNzzWVYA=;
        b=IQaolrNfEVan/5CUsyJYTbefVgiH8tdW9EKWAGeGdpwKkIr3GbC47/VC1uoBvdyu8o
         Mky3cHtl9VBBpQaVeMg7gmz+Kgkh8XRL8YwrTKlvaDXBs5SLnnwIdt4+RPWUrOPwk5Y/
         ZKnabSxfnq8IMnb0eMRAmFYJgDTwgMVtTCjOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=eKmc5InXxmHRscBTBZKb0B8XDQdVfiH1AFsCYz0KjlgIjQiqWyZa4s7eN9ZXvn+lzd
         7zKxIfl/YRHP1tAQZj8kuviglUMnXmzbnNrvH6pOqx5dqUjwKGTtak4xtmw++RcFywCZ
         LjIWkLUh/GRuAJkmA6peuyoJ8Re/hXi+XcXVs=
Received: by 10.103.189.15 with SMTP id r15mr3571657mup.126.1241968673057;
        Sun, 10 May 2009 08:17:53 -0700 (PDT)
Received: from localhost.localdomain (abvi64.neoplus.adsl.tpnet.pl [83.8.206.64])
        by mx.google.com with ESMTPS id y2sm195766mug.13.2009.05.10.08.17.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 May 2009 08:17:52 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4AFHqFn014201;
	Sun, 10 May 2009 17:17:52 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4AFHo98014198;
	Sun, 10 May 2009 17:17:50 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <2cfc40320905100658i4d7ef065qe01e35f2929dd2f6@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118721>

Disclaimer: please take it with a bit of salt, as I am not
and was not working on the area in question.

Jon Seymour <jon.seymour@gmail.com> writes:

> As I understand it, the normal use case for git is one in which a
> single user performs a number of git operations in sequence on a
> private repo.
> 
> As such, locking issues don't normally arise - the user is only doing
> one thing at once.
> 
> I am working on an idea which will imply the need for concurrently
> executing processes to modify the repo, in particular refs.  I
> specifically don't want to have a repo for each process precisely
> because I don't want to incur the costs of repo creation for every
> process and, in any case, I need them to share the refs.

Instead of sharing full repo (object database + refs + worktree), you
can have many worktrees for the same repository - see contrib/workdir
(object database + refs are shared), or even use alternates to share
only object database.
 
> In my use case, I may need locks that span several otherwise atomic
> operations - therefore relying on atomic locks that each git tool
> might employ for safety is not sufficient.
> 
> Is there an agreed upon locking protocol for the git repo? Is there
> tool support for this locking?
> 
> The case for adding it is that locking protocols only work if everyone
> agrees on the same protocol. The easiest way to do this would be to
> provide tools that enforce the desired locking protocol.

The C API for locking is described in Documentation/technical/api-lockfile
From what I understand git tries to avoid locking whenever possible,
using "atomic update" (create/copy + write + atomic rename), but it is
not always possible, see e.g. updating both ref and reflog for it.
Lockfiles had extension *.lock, and will have extension *..lck

-- 
Jakub Narebski
Poland
ShadeHawk on #git
