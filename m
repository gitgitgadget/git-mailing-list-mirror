From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git blame --follow
Date: Thu, 17 Mar 2011 02:59:22 -0700 (PDT)
Message-ID: <m3tyf25arl.fsf@localhost.localdomain>
References: <201103151644.44360.wolfgang@rohdewald.de>
	<7vy64g9tqs.fsf@alter.siamese.dyndns.org>
	<201103151926.58449.wolfgang@rohdewald.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Wolfgang Rohdewald <wolfgang@rohdewald.de>
X-From: git-owner@vger.kernel.org Thu Mar 17 10:59:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q09zQ-0003gu-OK
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 10:59:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082Ab1CQJ70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 05:59:26 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60331 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab1CQJ7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 05:59:24 -0400
Received: by fxm17 with SMTP id 17so2513675fxm.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 02:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=asvOD764e01AkcjrFB2hLQruRP0TnD2D4WFdxssDh/Y=;
        b=pwBtFBcmCizIEJbL5Ckp+yZe7IDjzPppzB+Ac76b46hpZBwHO5ZwR3eR6e8I82Pdx2
         O9a1vBdTOSFwN3tIxdjiIVB37QeABuyymvkQdDdSh86rCBGJSPXAOYACHX6qiS58P9fa
         JFK1MYGxJ1Cds7zkHynXcqSYEAjhxDfv3tAiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=wwfkwCzwgmVKVmAej0QQ7lF9lXRkbQU6wvRJhEYvS3eLNl/81nse4Jx1EZEnXb7SAI
         MdHjh0+GE/tLxc/GraRNODQKV7pLzsp6n69HfK5tYb3IEKZ1CBfKZ+CcF4P69PEE/Afd
         NhNEMNWXe9n9M+CE7tmlrrmCB1vsy34FNG3kk=
Received: by 10.223.149.70 with SMTP id s6mr1238554fav.66.1300355963580;
        Thu, 17 Mar 2011 02:59:23 -0700 (PDT)
Received: from localhost.localdomain (abvc119.neoplus.adsl.tpnet.pl [83.8.200.119])
        by mx.google.com with ESMTPS id j13sm410718faa.3.2011.03.17.02.59.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Mar 2011 02:59:22 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p2H9wha0007652;
	Thu, 17 Mar 2011 10:58:53 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p2H9wMC8007620;
	Thu, 17 Mar 2011 10:58:22 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <201103151926.58449.wolfgang@rohdewald.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169228>

Wolfgang Rohdewald <wolfgang@rohdewald.de> writes:

> But with my repository (which I cannot share),
> this does not happen. git blame attributes everything to 
> the renaming commit. If I checkout the commit before, git
> blame shows everything correctly.

"git blame" manpage says:

       -M|<num>|
              Detect  moved  or copied lines within a file. [...]
              [...]
              <num> is optional [...]

       -C|<num>|
              In  addition  to  -M,  detect lines moved or copied from other files
              that were modified in the same commit.

Sidenote: I wonder why we use '-M|<num>|' and not '-M[<num>]' here.

So you probably want to run "git blame -C -C <file>", not "git blame <file>".
Note that it is the same option name to turn on rename detection as is
used for for "git diff".

Note that "git gui blame" shows _two_ commits for each line: one is
result of "git blame" (and it would show commit that did code
movement, or renamed file), the other is result of "git blame -C -C -w",
which would show commit that changed line, disregarding whitespace-only
change (like e.g. reindent caused by extracting code into separate
function).

I wonder if it would be possible to generate result of "git blame"
and of "git blame -C -C -w" in a single run (with --porcelain or
--incremental)...

[...]
> And - for directories below the renamed one git log --follow 
> cannot cross this barrier either but if the "follow" logic
> is different I suppose this is not related

The implementation of "git log --follow <file>" is a bolted-on hack,
and it doesn't work in all cases; for example it doesn't cross
boundaries of subtree merge, IIRC.  Try "git log --follow gitweb/gitweb.perl"
in git repository itself...

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
