From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Correctly detecting modified paths in merge commits?
Date: Thu, 16 Dec 2010 10:33:38 -0800 (PST)
Message-ID: <m37hgdm84r.fsf@localhost.localdomain>
References: <AANLkTimsHZ543B7XWS6taa0w2Vc4huznx3UMs4Ejg3af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 16 19:33:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTIeB-0005Ok-Un
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 19:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757203Ab0LPSdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 13:33:42 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:62001 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756990Ab0LPSdl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 13:33:41 -0500
Received: by bwz16 with SMTP id 16so3905186bwz.4
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 10:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=pPz8u92LN1LF81TKyuL4t15GlhbcVCPxQ2OniH7IAMI=;
        b=jLwPM5BGrZr1okXZ7MWzBlYG7zMai0A3bDUwQK+0F52xY3tnsZXW+zQ+fC0ix8DBfd
         Mwe16XlqY1Hv1WSRdptPdHCYNT5ham3hRbmCAcghNlyno5ewBsYkTgoqshqUjZOIKKRU
         7v9/ioQ0Uu8q6iYGZlWdho2Q6uW2mYQ+GFLqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=TT1j4WJfT4iilscVTnsqPRw6UXjSzZGpZwR8QVeBgsedQ3FqYAlDG/soybuSM9HcM+
         LXH9XFgcKIXQ177x1UAWRxfIb6vr8JMijpMbJE5XZHgYdilDPAey6P+GiqquQYnS9L5d
         6GMXim7v10SChnl+lq/hr6B5gnduFXlnIAmlQ=
Received: by 10.204.126.138 with SMTP id c10mr3291069bks.156.1292524420072;
        Thu, 16 Dec 2010 10:33:40 -0800 (PST)
Received: from localhost.localdomain (abvg92.neoplus.adsl.tpnet.pl [83.8.204.92])
        by mx.google.com with ESMTPS id j11sm1336452bka.0.2010.12.16.10.33.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Dec 2010 10:33:38 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oAGIWxXi012894;
	Tue, 16 Nov 2010 19:33:11 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oAGIWrA0012889;
	Tue, 16 Nov 2010 19:32:53 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTimsHZ543B7XWS6taa0w2Vc4huznx3UMs4Ejg3af@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163810>

Dun Peal <dunpealer@gmail.com> writes:

> We wrote a post-receive hook that alerts users (via email) when
> specific paths are modified by their peers. The implementation is
> pretty simple: whenever a new commit is made, we ask git for the full
> list of files modified by that commit:
> 
>   git diff --name-only <COMMIT HASH>^!
> 
> This works well for regular commits, but breaks for merge commits.

Note that <commit>^! is *range* specifier, and 'git diff' really takes
two *endpoints*.  

>From git-diff(1) manpage.

    For a more complete list of ways to spell <commit>, see  "SPECIFYING
    REVISIONS" section in gitrevisions(1). However, "diff" is about 
    comparing two _endpoints_, not ranges, and the range notations  
    ("<commit>..<commit>"  and  "<commit>...<commit>")  do not mean a
    range as defined in the "SPECIFYING RANGES" section in gitrevisions(1).

<commit>^1 means include given commit but exclude all of its parents
(see gitrevisions(7)).

For a merge commit r1^! means r1 ^p1 ^p2 (where p1 and p2 are parents
of r1), which for git-diff probably means "git diff p1 r1".
  
 
> For example, suppose we have the following basic merge scenario:
> 
>   B
>  / \
> A   D
>  \ /
>   C
> 
> Root A was branched to B and C, then merged into commit D.
> 
> Problem is, the diff for D^! will include all the changes introduced by C.

See above.

Try 

  $ git diff-tree --name-only -c <COMMIT HADH>

instead.  '-c' is to show merge commit as combined diff (noting changes
different from both parents).  I'm not sure if this is what you want.

There is alwats '--cc' or '-m' instead of '-c'.
 
-- 
Jakub Narebski
Poland
ShadeHawk on #git
