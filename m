From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] difftool: add support for an extended revision syntax
Date: Fri, 27 Mar 2009 09:28:49 -0700
Message-ID: <20090327162849.GA2853@gmail.com>
References: <1237803348-9329-1-git-send-email-davvid@gmail.com> <m33acz2byv.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, spearce@spearce.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 17:30:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnEwD-00082I-B0
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 17:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755374AbZC0Q2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 12:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754371AbZC0Q2N
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 12:28:13 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:33935 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140AbZC0Q2M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 12:28:12 -0400
Received: by wa-out-1112.google.com with SMTP id j5so727411wah.21
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=XS2ozywrz7afLKRWi2/wkOaVBzww4STninjAXEhs1+I=;
        b=FWkP84EvLlr5yBy4Bi9gqnTsojeAZVC5Zj+MnI4rCBE83mvpqAxwGmuh6qxMkZSOoG
         xhQr8mtxFIBp+trThHY1thjKvquX1bcr0WzM9Op8l38gr7mR3pNPUHMMMCc5DZtBRAbn
         DByWOAGixLLvnvCJxfsKfKeIC4sccfogxuCIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MTTSL5oj3T+siOcalv72c+3/WT+d0pCRERLoDGfzSy0HKNW1DJ0jOMdl0EsgnO8RL0
         jcG2uznJwYPu1gwcX5u8vvkSbkwrDO6fo+u6X1R7fRgp8/iUU5zVuv/VwLGQ0t0LrpHe
         QSZwqWKO8JgAU9XDzG3QERU9CW2FJ4Smluii0=
Received: by 10.115.79.1 with SMTP id g1mr1543212wal.80.1238171290393;
        Fri, 27 Mar 2009 09:28:10 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id c26sm1725400waa.15.2009.03.27.09.28.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Mar 2009 09:28:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m33acz2byv.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114910>

On  0, Jakub Narebski <jnareb@gmail.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > This adds an extended revision syntax to git-difftool.
> > Users often ask "how do I compare a file against its
> > previous version" and the answer is typically a combination
> > of 'git log <file>' and 'git difftool <sha1> <sha1> <file>'.
> > 
> > [snip]
> > 
> > The extended revision syntax also expands revisions
> > that are suffixed with '!' as a convenient way to
> > see commit diffs.  Specifying only '!' is equivalent
> > to specifying 'HEAD!'.
> > 
> > This makes the following statements equivalent:
> > 
> > 	$ git difftool !
> > 	$ git difftool HEAD!
> > 	$ git difftool HEAD~ HEAD
> 
> Errr... there already exists such syntax, and it is called HEAD^!


Yup, this patch was a mistake ;)

^! does exactly what I needed and difftool supports it since
git-diff does.

I'm still interested in the file~<n> idea [though maybe not
that exact syntax] and have been reading revision.c (as Junio
suggested) to see if it can be done in a good way.

I'm still not sure if it is a good idea since the types of
users who would want it are probably better off with tighter
integration between gitk and difftool as opposed to a
convenient command-line syntax (tho I do see how it would be
useful every now and then).  Ideally, we'd want to select two
commits in gitk and compare them.  I think qgit can do that,
but it doesn't yet know about difftool (since, of course,
difftool is not in master yet).

I noticed that my patches for "add tests to difftool" and "add
the -y shortcut for --no-prompt" were in git.git's pu branch
the other day but aren't there anymore.  Was that intentional?



> (if git-difftool can accept a..b revision specification)... or not,
> as git-rev-parse(1) states:
> 
>   r1^! includes commit r1 but excludes all of its parents.
> 
> So depending on how "r1 --not r1^" and "r1 --not r1^1 r1^2" is
> interpreted by diff (which accpets points, not ranges) it might be, or
> might be not what you wanted by introducying '!' / <rev>:!
> specification...
> 
> -- 
> Jakub Narebski
> Poland
> ShadeHawk on #git

-- 

	David
