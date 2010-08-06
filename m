From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Decompressing a tree to a location other than the working directory
Date: Fri, 06 Aug 2010 12:58:47 -0700 (PDT)
Message-ID: <m3mxszo6na.fsf@localhost.localdomain>
References: <AANLkTi=RjcQ_-PNUt781jhYEA-8krqXpdHRenVyR_Rc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Joshua Shrader <jshrader83@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 21:58:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhT4C-0005O4-Lg
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 21:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643Ab0HFT6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 15:58:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50708 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724Ab0HFT6u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 15:58:50 -0400
Received: by fxm14 with SMTP id 14so4089600fxm.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 12:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=MhkPrArA5pNWqwUewuQ4uvjZT0M0TWfdne4Plk2cWGE=;
        b=ShoXVn+KAyMd7GMscIRhq85E7KN2MT2GcHjx1VeFq7oDgE+jGYi2nxgxRi0pM7PuK/
         k8lpEG81EKDaap1QF4vfxX3eIh0wiBCw0icnrKK+SlYDQ8Wg67s1INE12n6O7Cvwy1WM
         Xv6MKm6iNUGpM8J868mEWBOSWiZ1YluRf9XpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=JLttCtIhpLCI2Af2x3lmRjAH9ViBV7n50DK57pSCNAzAAw2vGIpCuHxfaaQyeZWH4J
         jcIbSPj+K3ZMgpCjh6U4d5eHtkcImnAi16rIXM7uhuOkrrnmfWscByNP8ej2PYBGTuNp
         yu4wM925CD7F0Eax9VTuV7BNpGaUPWioe3v4U=
Received: by 10.223.103.134 with SMTP id k6mr13456477fao.5.1281124728961;
        Fri, 06 Aug 2010 12:58:48 -0700 (PDT)
Received: from localhost.localdomain (abvu86.neoplus.adsl.tpnet.pl [83.8.218.86])
        by mx.google.com with ESMTPS id b36sm753443faq.11.2010.08.06.12.58.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 12:58:47 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o76JwTUZ027173;
	Fri, 6 Aug 2010 21:58:35 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o76JwIkM027163;
	Fri, 6 Aug 2010 21:58:18 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTi=RjcQ_-PNUt781jhYEA-8krqXpdHRenVyR_Rc4@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152808>

Joshua Shrader <jshrader83@gmail.com> writes:

> git checkout allows one to checkout a particular version of a certain
> path in the working directory.  Are there accessible plumbing commands
> that can be used to accomplish the same thing, but change the target
> directory.  For example, if I wanted to checkout a certain path, but
> wanted to check it out somewhere external to my working directory /
> repository?

Porcelain way: check out first example in git-archive(1) manpage

  EXAMPLES
  ========

  git archive --format=tar --prefix=junk/ HEAD | (cd /var/tmp/ && tar xf -)

       Create a tar archive that contains the contents of the latest commit
       on the current branch, and extract it in the /var/tmp/junk directory.

Plumbing way: after preparing index (it can be separate file than .git/index),
use "git checkout-index" as desceived in second example on manpage:

  EXAMPLES
  ========


  Using `git checkout-index` to "export an entire tree"

        The  prefix  ability  basically  makes  it trivial to use git check-
        out-index as an "export as tree" function.  Just  read  the  desired
        tree into the index, and do:

          $ git checkout-index --prefix=git-export-dir/ -a

        `git checkout-index` will "export" the index into the specified direc-
        tory.

        The final "/" is important. The exported name is literally just pre-
        fixed  with  the  specified string


-- 
Jakub Narebski
Poland
ShadeHawk on #git
