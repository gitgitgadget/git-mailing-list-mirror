From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git clone - head not pointing to master
Date: Fri, 30 Dec 2011 10:45:53 -0800 (PST)
Message-ID: <m34nwhgaop.fsf@localhost.localdomain>
References: <4EFD9F11.5030309@volitionlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vibin Nair <vibin@volitionlabs.com>
X-From: git-owner@vger.kernel.org Fri Dec 30 19:46:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RghT6-0004e5-DJ
	for gcvg-git-2@lo.gmane.org; Fri, 30 Dec 2011 19:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603Ab1L3Sp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Dec 2011 13:45:56 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:53909 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019Ab1L3Spz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Dec 2011 13:45:55 -0500
Received: by eekc4 with SMTP id c4so13765084eek.19
        for <git@vger.kernel.org>; Fri, 30 Dec 2011 10:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=mXqefAQBnafsHxULWCNdV6Dvqn/v3RKchX1qcsjqRj8=;
        b=iGYCZdtR4dQml7lAb6xeGjizphXRcKbOYP2iGRrbdDua1RXk5snISyJzq8MAj9UMEN
         sZ4KJDOvOKJSXMbo1Zhr/BNeC4ExVCVqjakL/CFSVGL+rE5eWpGeEdJt0+x/H2XT5N73
         4uuFDo4/Y/E8tNG4EYr/FcdYa1uI0kzGdPMgg=
Received: by 10.213.114.84 with SMTP id d20mr10969897ebq.100.1325270753921;
        Fri, 30 Dec 2011 10:45:53 -0800 (PST)
Received: from localhost.localdomain (abvx212.neoplus.adsl.tpnet.pl. [83.8.221.212])
        by mx.google.com with ESMTPS id y12sm150192112eeb.11.2011.12.30.10.45.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Dec 2011 10:45:53 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pBUIjx4j019426;
	Fri, 30 Dec 2011 19:46:00 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pBUIjw3k019423;
	Fri, 30 Dec 2011 19:45:58 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4EFD9F11.5030309@volitionlabs.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187808>

Vibin Nair <vibin@volitionlabs.com> writes:

> Hi,
>   I am a Git beginner. Recently i started working on a codebase (that
> is checked in to a git repository) of our client, who is not very
> aware about how git works.
> The repository has multiple branches such as
> 
> origin/user1
> origin/master
> origin/user2
> 
> Now when i take a clone of this repository : git clone <repo-url>, a
> clone of the repo is created on my machine.
> 
> But when i do a : "git branch" it shows
> 
> user1 *
> 
> which means that the "HEAD" is pointing to the "user1" branch.

Where do you do "git branch"?  In clone or in original repository?
 
> The client told me that all the recent code were being merged into the
> "master" branch and hence the "user1" branch has code which is older
> than "master" branch.
> 
> I had 2 queries :
> 
> 1. Is it possible to make the "HEAD" of the remote point to "master"
> instead of "user1", so that other members of my team get the latest
> code when they try to clone the repository.

If you want "origin/HEAD" to point to "origin/master" remote-tracking
branch, so that "origin" as a branch means "origin/master", you can
use (with modern Git)

  clone$ git remote set-head origin master

or

  clone$ git remote set-head origin

if "master" is now current branch on remote.


If you want to change HEAD i.e. current branch on server (on remote),
you can use

  server$ git checkout master

if it is non-bare repository (not recommended setup), or

  server$ git symbolic-ref HEAD refs/heads/master

or equivalently

  server$ git update-ref --no-deref HEAD refs/heads/master


> 2. Is there any way to safely merge "user1" to "master".

You can check if 'user1' can be fast-forwarded to 'master'
with

  $ git checkout user1
  $ git merge --ff-only master

This would update 'user1' to 'master', but only if 'master' is just
straight advancement of 'user1'.

HTH (Hope That Helps).
-- 
Jakub Narebski
