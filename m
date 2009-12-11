From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to selectively recreate merge state?
Date: Thu, 10 Dec 2009 16:28:50 -0800 (PST)
Message-ID: <m38wdae4k4.fsf@localhost.localdomain>
References: <76718490912101556o3e2911e8t32b48c0b735fd98c@mail.gmail.com>
	<7v8wda8jg3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 01:28:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NItNS-0007DZ-OI
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 01:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756690AbZLKA2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 19:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753409AbZLKA2q
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 19:28:46 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:44783 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbZLKA2p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 19:28:45 -0500
Received: by fxm21 with SMTP id 21so511346fxm.1
        for <git@vger.kernel.org>; Thu, 10 Dec 2009 16:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Ii4ZZMM0V5420vXvaxghcKRKYyv5h3p16AfstTVpNQs=;
        b=owsrb7i9a6LUwyp9mFqJUdB7fNi8/bRHHxzHuLnPgobVoSKUnvo6a69ZSClEgxPnfD
         /oBDaINef9N/kDuDFDsI21+S2J8LRPEfeybqcTt9wqsTyXk7L5h9a+TF3l/nbak+YOmE
         dB18oWlOLrKhnOMAKJIJM7GHUrmqjP+cMHq8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=tla+jhO0Km/OaO5bNBHWFW7unzRyWF/2mZqOdcCB3YK9FVKYeH3HptSo8GbcbDKfDN
         Aj56abzZXj2JcGtVrweK9EnvAYXHEvXJeGRj85DGEruGY6mz6THzRG0J72Cb2n+uyWwH
         meePCYliy4tRkTgUH+4aqpX1HgAqrixCRSH3c=
Received: by 10.223.5.25 with SMTP id 25mr698321fat.38.1260491331535;
        Thu, 10 Dec 2009 16:28:51 -0800 (PST)
Received: from localhost.localdomain (abvy165.neoplus.adsl.tpnet.pl [83.8.222.165])
        by mx.google.com with ESMTPS id z10sm2123289fka.0.2009.12.10.16.28.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Dec 2009 16:28:50 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nBB0TmA8025329;
	Fri, 11 Dec 2009 01:29:53 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nBB0TWPL025325;
	Fri, 11 Dec 2009 01:29:32 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v8wda8jg3.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135061>

Junio C Hamano <gitster@pobox.com> writes:

> Jay Soffian <jaysoffian@gmail.com> writes:
> 
> > Let's say you initiate a merge:
> >
> > $ git merge topic
> >
> > And this merge results in conflicts in two files, foo and bar. You
> > resolve the conflicts in both files, but then decide you don't like
> > how you resolved bar.
> >
> > How do you set the index and working-copy back to the state it was
> > immediately after doing the merge for bar, while leaving the merge
> > resolution alone for foo?
> 
> Before you "git add bar", you can say "git checkout --conflict=merge bar"
> (or --conflict=diff3).

Or (if I understand manpage correctly) just "git checkout --conflict bar".
 
> After "git add bar", you can't.  Save what you have resolved so far in a
> separate file (e.g. "cp foo foo.resolved"), reset to the previous state
> and redo the merge.

Hmmm... isn't it what "git update-index --unresolve bar" is for?

  --unresolve::
        Restores the 'unmerged' or 'needs updating' state of a
        file during a merge if it was cleared by accident.

Unless "git add foo" not only adds current contents of foo at stage 0,
but also removes higher stages from index...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
