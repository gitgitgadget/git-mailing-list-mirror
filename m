From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: finding the merge of two or more commits
Date: Fri, 30 Oct 2009 16:38:12 -0700 (PDT)
Message-ID: <m3iqdwcv17.fsf@localhost.localdomain>
References: <3a69fa7c0910291412l439f7f61vd3b55a77cd7e10b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: E R <pc88mxer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 00:40:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4152-0006zx-8o
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 00:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933072AbZJ3XiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 19:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933060AbZJ3XiL
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 19:38:11 -0400
Received: from mail-bw0-f227.google.com ([209.85.218.227]:55952 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933058AbZJ3XiK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 19:38:10 -0400
Received: by bwz27 with SMTP id 27so4179461bwz.21
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 16:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=foWqbiijJaQ0H3v1P5i9WnKCz0KnkKAJABrsEDkHwF0=;
        b=GYP5eoY68N4hbJLpGjxZWEPXROFMzIJwwUPx08P9Bl4xho3fkJq/rk1gbxKh2LgQr0
         LsVc/jcsCEL+Avehdv3OGslIutuVfgFRfm4wyvWSO8Ve8AD9/LLimMTLn5AAh3ehFCJC
         pA7IvxEHIRWmAoDpXAJuoTdCOxbV/dnkPs0fw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=R9R8EmgiRedhwgqXlVxlYzT7sZCzawDZ8g9Q/gZhdimJvrKY+k7Kzb43lXTKUR8HPI
         RBs2dpCwKW7xjxfMHq5S64fgQe6hJ4hR3/W27EyxZYrrKWzZVyfC4sMxdXZKaXgVDSAZ
         at0npv4r/EhmqA5ykf0CNiZ/0RRET8NubB4uI=
Received: by 10.103.76.34 with SMTP id d34mr921819mul.31.1256945893324;
        Fri, 30 Oct 2009 16:38:13 -0700 (PDT)
Received: from localhost.localdomain (abwo144.neoplus.adsl.tpnet.pl [83.8.238.144])
        by mx.google.com with ESMTPS id 23sm1438835mum.14.2009.10.30.16.38.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 16:38:12 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n9UNcDl0012116;
	Sat, 31 Oct 2009 00:38:13 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n9UNcCqn012113;
	Sat, 31 Oct 2009 00:38:12 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <3a69fa7c0910291412l439f7f61vd3b55a77cd7e10b5@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131777>

E R <pc88mxer@gmail.com> writes:

> Given two commits c1 and c2, is it possible to ask git if there are
> any commits in the repository that were created by either a sequence
> of commands like:
> 
> git checkout c1
> git merge c2
> 
> or:
> 
> git checkout c2
> git merge c1
> 
> with any required conflict resolution?
> 
> That is, I don't want to merge c1 and c2 myself, but I want to know if
> someone else has merged c1 and c2, performed any conflict resolution
> and committed the result.

I assume that commits c1 and c2 are not one ancestor of the other (are
not in fast-forward relation).

Translating your question into question about DAG of revisions, you
want to check if there is branch for which both c1 and c2 are
reachable from:

  c1sha=$(git rev-parse c1)
  c2sha=$(git rev-parse c2)
  git for-each-ref --format="%(refname)" refs/heads/ |
  while read refname
  do 
      b1=$(git merge-base c1 $refname)
      b2=$(git merge-base c2 $refname)
      if [ "$b1" = "$c1sha" -a "$b2" = "$c2sha" ]
      then
          print ${refname#refs/heads/}
      fi
  done

Instead of comparing git-merge-base with SHA-1 of c1 and c2
respoectively, you can count commits:

  git for-each-ref --format="%(refname)" refs/heads/ |
  while read refname
  do 
      count1=$(git rev-list c1..$refname | wc -l)
      count2=$(git rev-list c2..$refname | wc -l)
      if [ "$count1" > 0  -a  "$count2" > 0 ]
      then
          print ${refname#refs/heads/}
      fi
  done

Not tested!

-- 
Jakub Narebski
Poland
ShadeHawk on #git
