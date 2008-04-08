From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: auto insert history info into source files, at commit?
Date: Tue, 08 Apr 2008 10:04:43 -0700 (PDT)
Message-ID: <m38wzoth0l.fsf@localhost.localdomain>
References: <16562665.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: oxcrete <oxcrete@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 19:06:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjHGG-0006RT-Ku
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 19:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754086AbYDHREr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 13:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752594AbYDHREr
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 13:04:47 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:16033 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086AbYDHREq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 13:04:46 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2772975fkr.5
        for <git@vger.kernel.org>; Tue, 08 Apr 2008 10:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=FzN4ziN2V2zjCQDVm5TRlBJ7KK7LowOZgTDcVqf2Mzs=;
        b=Ezbj/sejQhsd1h1v9hOBkrueDyna8PFwQR/YD0SwQ0nh20bi9on+5pRnyqX+9mf/LOnkJJ4X1Psm7HYq47Y99ZYhpwBB+pAjMnLECTnVTWif1rOepE1RVNFxUaWk3JPvGSomUMaUItY1yNM/OHr4lTLVO/pv0vt4XqLpuqz0yTY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=YTwJGQ/ei3lqsoCSD+FbyDAwjEl3O8HKYkzZ5aGjFmaN1hyf/0Dt4fZW35VSdSvwKyKrlBL6MZ7e5tooCmryhmVjB60BwakjBmhXUe7GRl15CLZxFg+TOX+0v43rjbJ+w9iIvm362LjS5HMsSwm/mAhC13eqmxcszyy0Xu6Q2Ns=
Received: by 10.82.120.15 with SMTP id s15mr361126buc.80.1207674284218;
        Tue, 08 Apr 2008 10:04:44 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.252.83])
        by mx.google.com with ESMTPS id n10sm13287396mue.18.2008.04.08.10.04.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Apr 2008 10:04:43 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m38H4hkw015678;
	Tue, 8 Apr 2008 19:04:44 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m38H4Rhn015672;
	Tue, 8 Apr 2008 19:04:27 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <16562665.post@talk.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79009>

oxcrete <oxcrete@yahoo.com> writes:

> How do you do this with Git? I couldn't find it in the documentation.  the
> standard $Log, $Revision... didn't seem to work. I'll take an RTFM answer if
> you can point me to the right section in the manual. Appologies, if this was
> posted before - couldn't find a good regex to search this topic.

http://git.or.cz/gitwiki/GitFaq#head-4a0afe71a2bb7734777a8b0b345e0308aefdbd40
"Does git have keyword expansion?" (and also next section, "Does git
allow arbitrary conversion of contents?")

Simply said keywords do not work well together with nonlinear history,
and especially with the way git is engineered, being content-adressed.
If you have the following history:

  A---B---C---D---E
           \
            \-F---G---H

and the file 'foo' has the same contents in both branches, in both E
and H commits (revisions), it would be noticed by git and it wouldn't
touch this file when switching branches.  It is one of the keys to git
performance.  This is important not only for switching branches, but
also for merging.

But if they have $Revision$, or $Author$ keywords, and those would be
different, it couldn't be done this way.


Therefore git supports "keyword expansion" in three ways, beginning
from simplest.

1. The `ident` attribute, which allows to expand $Id$ to 
$Id: <sha-1>$, where <sha-1> is blob (file contents) identifier.

2. The `export-subst` attribute, and/or various tricks in Makefile,
which allow embedding information about current revision (like result
of "git describe") in files when using "git archive" (atribute), or
"make" / "make dist".  This is I think the preferred way; both git and
Linux use Makefile tricks to embed version info in result of
compilation.

3. Use `filter` attribute to expand keywords when checking out file,
and removing keywords when commiting changes (but watch for binary
files!).  This would affect performance.  I also don't think that
there is any example doing keyword expansion with `filter`
gitattribute; you can be first! ;-)

-- 
Jakub Narebski
Poland
ShadeHawk on #git
