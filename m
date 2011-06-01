From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git clone (ssh://) skips detached HEAD
Date: Wed, 01 Jun 2011 15:42:58 -0700 (PDT)
Message-ID: <m31uzdxjf9.fsf@localhost.localdomain>
References: <BANLkTi=xK+hmvGTLnKREScABU=7v_SKqPQ@mail.gmail.com>
	<20110601220518.GA32681@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 02 00:43:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRu84-0000gS-0b
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 00:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510Ab1FAWnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 18:43:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55150 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756938Ab1FAWnA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 18:43:00 -0400
Received: by fxm17 with SMTP id 17so371231fxm.19
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 15:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=IagaENHwaK75wv1MA0a2tw7tSNhAHZDhxLqNtdGGmHA=;
        b=J1OYXgKYkaIId478hBaTACpb6fhKwCjzIXo9iB7+mUijL4GNfIhKEVGT/s1YU684ZA
         vsluwfahKiWbTjaUGEyajEaCmlDGqVm52w7AO3YU4Mk8U6cjLcPsLfsVY/Tmfj2zXIa3
         WwZVq+rzelTIk4/2QMTsCFla8QxiLfJ37PP6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=FbKOj1uV0KiVi7g8NrsPE5eSsXdMgP3hEO/FcgLzohngw2TPDMqLxWAHMc9wbETAEz
         LvAdvhPTq08wCh9n5NB5ZOFDTRlcZQbXtaFLj8oQcE4C/hlms9qY21HH/LlUj5KwznL1
         12Tt9LST6+3HcHpnASTRMqEN9eBrEGd8CmR88=
Received: by 10.223.22.130 with SMTP id n2mr39039fab.50.1306968179613;
        Wed, 01 Jun 2011 15:42:59 -0700 (PDT)
Received: from localhost.localdomain (abvc230.neoplus.adsl.tpnet.pl [83.8.200.230])
        by mx.google.com with ESMTPS id o23sm7216faa.9.2011.06.01.15.42.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Jun 2011 15:42:58 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p51Mh7Ql022244;
	Thu, 2 Jun 2011 00:43:12 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p51MgoQ1022237;
	Thu, 2 Jun 2011 00:42:50 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20110601220518.GA32681@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174913>

Jeff King <peff@peff.net> writes:

> On Thu, Jun 02, 2011 at 03:30:37AM +0600, Dmitry Ivankov wrote:
> 
> > For some reason git doesn't try to fetch detached HEAD object if it's
> > not needed by needed heads.
> 
> The reason is that the default refspec on clone is:
> 
>   $ git config remote.origin.fetch
>   +refs/heads/*:refs/remotes/origin/*
> 
> And HEAD is not under refs/heads/.

Hmmm... HEAD is a bit of special case, as HEAD should really land in
refs/remotes/origin/HEAD from what I understand.

[...] 
> > Steps to reproduce:
> > git init test && cd test
> > touch 1 && git add 1 && git commit -m 123
> > touch 2 && git add 2 && git commit -m 345
> > git reset --hard HEAD^
> > git checkout HEAD@{1}
> > 
> > cd ../
> > git clone ssh://127.0.0.1/`pwd`/test test2
> > remote: Counting objects: 3, done.
> > remote: Total 3 (delta 0), reused 0 (delta 0)
> > Receiving objects: 100% (3/3), done.
> > error: Trying to write ref HEAD with nonexistant object
> > 91dbc2403853783f637744c31036f94a66084286
> > fatal: Cannot update the ref 'HEAD'.
> 
> This is quite bad behavior. In addition to the ugly error messages, it
> actually aborts the clone. So it is impossible to clone a repo with a
> detached HEAD that is not otherwise referenced.

It _might_ be the case that the fact that git protocol doesn't have
mechanism to transfer information about symref, and ends up guessing
where HEAD points to, bites use here.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
