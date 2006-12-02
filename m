X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: correctly access repos when only given partial read permissions
Date: Sat, 2 Dec 2006 14:24:33 -0800
Message-ID: <20061202222433.GA21171@localdomain>
References: <11644366982320-git-send-email-normalperson@yhbt.net> <4571F6E7.4050809@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 2 Dec 2006 22:24:42 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <4571F6E7.4050809@vilain.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33061>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqdHj-0007Md-67 for gcvg-git@gmane.org; Sat, 02 Dec
 2006 23:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424470AbWLBWYg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 17:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424471AbWLBWYg
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 17:24:36 -0500
Received: from hand.yhbt.net ([66.150.188.102]:17561 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1424470AbWLBWYf (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 17:24:35 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 098652DC034; Sat,  2 Dec 2006 14:24:34 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 02 Dec 2006
 14:24:33 -0800
To: Sam Vilain <sam@vilain.net>
Sender: git-owner@vger.kernel.org

Sam Vilain <sam@vilain.net> wrote:
> Eric Wong wrote:
> > Sometimes users are given only read access to a subtree inside a
> > repository, and git-svn could not read log information (and thus
> > fetch commits) when connecting a session to the root of the
> > repository.  We now start an SVN::Ra session with the full URL
> > of what we're tracking, and not the repository root as before.
> > 
> > This change was made much easier with a cleanup of
> > repo_path_split() usage as well as improving the accounting of
> > authentication batons.
> 
> This broke mirroring file:/// URIs;
> 
> eg, if I have ~/.svk/local as a SVN repository, which has a complete
> mirror of a URL under mirror/fai, and I want to copy the revisions into
> git using git-svn, I use:
> 
> perl ~/src/git/git-svn multi-init -t tags -T trunk \
>      file:///home/samv/.svk/local/mirror/fai
> 
> I now get this error:
> 
> Filesystem has no item: File not found: revision 8514, path
> '/mirror/fai/tags/mirror/fai/tags' at /home/samv/src/git/git-svn line 3236

This should be fixed in 1ca7558dd838e82f6f6b8611b981654fa4ecde2b in
Junio's master: "git-svn: fix multi-init".

> (next, I'll make git-svn correctly look at the svm:* revprops to get the
> upstream repo URL and revision number for the commit message)

Cool.  While you're at it, would you mind looking into supporting some
of the merge revprops that I've heard about, too?  Thanks.

-- 
