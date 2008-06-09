From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How does git store branchpoints?
Date: Mon, 09 Jun 2008 13:53:36 -0700 (PDT)
Message-ID: <m38wxewcno.fsf@localhost.localdomain>
References: <beffea8c-fd2a-44d0-a566-3ded5d09a3d2@l42g2000hsc.googlegroups.com>
	<m3hcc2wso1.fsf@localhost.localdomain>
	<fd42f577-60ba-4d26-85a3-7ca4ea8295db@a1g2000hsb.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: davetron5000 <davetron5000@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 22:54:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5oNx-0008D4-Sv
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 22:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755320AbYFIUxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 16:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755298AbYFIUxk
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 16:53:40 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:41249 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755291AbYFIUxj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 16:53:39 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1637416mue.1
        for <git@vger.kernel.org>; Mon, 09 Jun 2008 13:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=cghQ3Kq9PWJ+W+BfeY1rxppdcyfnl6S07cpEpXYoc5Y=;
        b=Dnryyt+bGvkiiwK4OIbQoBFae9udYqaVubysLr74TPuI987F1UhcRomfN5Qpuq1JjC
         8aXzyHSbmFL+xUgUy5CQ5EeNuNjEM3xfRVE1NOCdqEWL0SDaHp3zFW7jn4Vn9cVeMeDd
         MCI2OO3O8IcmFFb63l5ipnbyJJjet0ShkJ4ks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=IFmb9eqDCwCnn01zzizAi40M11GiF/P0LxRweUhciayZMCAvzPXo7TkV3zxfqrjsHP
         RUfDV34CRuclvhAcR5DhsW8DPKPgaWffIIlmkgsAnN49yZjNHRadgqc4VVHsIjIKF59M
         iuaCoSHD/tG4hnvbEcVS4Ibtsc+9/vzzPRkMo=
Received: by 10.103.228.12 with SMTP id f12mr2741146mur.28.1213044817638;
        Mon, 09 Jun 2008 13:53:37 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.243.230])
        by mx.google.com with ESMTPS id u26sm17872982mug.4.2008.06.09.13.53.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Jun 2008 13:53:36 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m59KuItP019070;
	Mon, 9 Jun 2008 22:56:29 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m59KuCaF019066;
	Mon, 9 Jun 2008 22:56:12 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <fd42f577-60ba-4d26-85a3-7ca4ea8295db@a1g2000hsb.googlegroups.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84428>

davetron5000 <davetron5000@gmail.com> writes:

> >
> > You can ask git to find branch point using "git merge-base trunk FOO",
> > which should return 'c' (actually, sha-1 of this commit).
> 
> OK, this revealed interesting results.  The commit it gave me was a
> commit right before ANOTHER SVN branch that I was originally to work
> on, but never did.  The files git-merge showed conflicts for were
> files modified since THAT branch (call it BAR) was created and before
> my branch (FOO) was created.

Could you write some ascii-art diagram showing the situation? It is
hard to grasp the situation fully only from above description.
 
> So, any ideas why git thinks that my two branches are rooted at BAR
> and not FOO?  git-svn dcommit on local-FOO commits to FOO and not BAR.

Note that the situation described below might be not related to your
problem; please view history carefully using some (graphical) history
browser like gitk.

It could happen that commits which should be identical aren't,
e.g. because of different timestamp, or different author, or lack of
svn-id: line, or something like that.  This isn't helped by the fact
that Subversion doesn't store information about merges; and even if it
does (SVK or svnmerge extensions) I'm not sure if git-svn can use it.

So the situation might be like following:

   1---2---3---4---A---B---C   <-- branch 1

   1'--2'--3'--4'--a---b---c   <-- branch 2

while you want it to be

   1---2---3---4---A---B---C   <-- branch 1
                \
                 \-a---b---c   <-- branch 2

Usually working with grafts, examining result in gitk, then commiting
grafts using git-filter-branch is the solution for such history
rewriting.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
