From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Commiting changes onto more than one branch
Date: Wed, 25 Nov 2009 08:50:55 -0800 (PST)
Message-ID: <m38wdublbq.fsf@localhost.localdomain>
References: <6b4a562b0911250831q332ac3b5m6ee38f59e7a6f391@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Jarmy <mjarmy@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 17:51:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDL55-0000fS-VP
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 17:51:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227AbZKYQuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 11:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753921AbZKYQuw
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 11:50:52 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:55910 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155AbZKYQuv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 11:50:51 -0500
Received: by bwz27 with SMTP id 27so7094036bwz.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 08:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Ue5SOvPQSGjKNQOb3W16hDr/c9VzeglxQXIgETUliAA=;
        b=q6C9YLeoNebnGVTzguX9T0gZykti8ZLsemURw5xfAtsK3vkTvKkK9sSZ8LjU+g+g9m
         T1VDrUDht0hWUZTt6lcWyutFUWwBxxg+ZD1e0aO3GbJ8oc9rYIv+vYv+eMkExWyGxiSG
         gZNOp9xm1pPHBI1O6YH2NiktohwwiFFevvWoo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=SYtcklGt10Yuf1OL1+QuCeSwFNBGpTeav57gzztCnzL29NULHDgMrMNexX9ifs0CYW
         FpCuJ5rstvaEmBepQvWuVOGej3+l7j9IBesY+CBjaBlNwsOn/5vbajVkc7zvITCvHXJn
         dHOHzwL6f4LOZJzYEy08stbbgosR13ZQBN6X4=
Received: by 10.204.153.22 with SMTP id i22mr2713038bkw.123.1259167856966;
        Wed, 25 Nov 2009 08:50:56 -0800 (PST)
Received: from localhost.localdomain (abvf67.neoplus.adsl.tpnet.pl [83.8.203.67])
        by mx.google.com with ESMTPS id k29sm8910112fkk.21.2009.11.25.08.50.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 08:50:55 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nAPGoR9Y013028;
	Wed, 25 Nov 2009 17:50:38 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nAPGoHiE013024;
	Wed, 25 Nov 2009 17:50:17 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <6b4a562b0911250831q332ac3b5m6ee38f59e7a6f391@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133652>

Mike Jarmy <mjarmy@gmail.com> writes:

> My question is this:  How do I manage a checkin for a bugfix that
> affects, say, only branches v3, v4, and v5?

Take a look at "Resolving conflicts/dependencies between topic
branches early" blog post by Junio C Hamano (git maintainer) at 
http://gitster.livejournal.com/27297.html

In short the solution is to create separate topic branch for a bugfix,
branching off earliest place where it would be relevant, then merge
this bugfix branch into all development branches you need
(e.g. maint-v3, maint-v4, maint-v5, master).

This means:

  $ git checkout -b fix-frobulator--issue-1235 maint-v3
  <create commit or series of commits>
  
  $ git checkout maint-v3
  $ git merge fix-frobulator--issue-1235
  <resolve conflicts if any>

  $ git checkout maint-v4
  $ git merge fix-frobulator--issue-1235
  <resolve conflicts if any>

  [...]

-- 
Jakub Narebski
Poland
ShadeHawk on #git
