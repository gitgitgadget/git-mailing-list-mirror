From: John Keeping <john@keeping.me.uk>
Subject: Re: Plumbing to rename a ref?
Date: Fri, 23 May 2014 18:14:07 +0100
Message-ID: <20140523171407.GB2249@serenity.lan>
References: <87ha4golck.fsf@osv.gnss.ru>
 <20140523105047.GA2249@serenity.lan>
 <xmqqvbswjuaa.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergei Organov <osv@javad.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 19:23:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WntBg-0003rj-8w
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 19:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbaEWRXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 13:23:16 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:56279 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186AbaEWRXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 13:23:16 -0400
X-Greylist: delayed 537 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 May 2014 13:23:15 EDT
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 1041921EB8;
	Fri, 23 May 2014 18:14:18 +0100 (BST)
X-Quarantine-ID: <AE8jWMrv4ndl>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AE8jWMrv4ndl; Fri, 23 May 2014 18:14:17 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id EC54922F4A;
	Fri, 23 May 2014 18:14:16 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 470AC161E2F6;
	Fri, 23 May 2014 18:14:15 +0100 (BST)
X-Quarantine-ID: <uHjVTq8jMwgc>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uHjVTq8jMwgc; Fri, 23 May 2014 18:14:14 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 452DA161E47C;
	Fri, 23 May 2014 18:14:09 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqqvbswjuaa.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250004>

On Fri, May 23, 2014 at 10:10:05AM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > On Fri, May 23, 2014 at 02:11:55PM +0400, Sergei Organov wrote:
> >> Hello,
> >> 
> >> After convertion of a project from CVS to git, I'd like to rename some
> >> references in the created git repository (before it's published, so no
> >> problems here). Is there a plumbing that would do:
> >> 
> >> git rename-ref <old_name> <new_name>
> >> 
> >> for me?
> >
> > I think the best you can get is two invocations of `git update-ref`:
> >
> > 	git update-ref <new_name> <old_name> &&
> > 	git update-ref -d <old_name>
> >
> > Although if you're scripting it the `--stdin` mode may be easier:
> >
> > 	git update-ref --stdin <<-\EOF
> > 	create <new_name> <old_name>
> > 	delete <old_name>
> > 	EOF
> >
> > Note that "<new_name>" must be a fully-qualified ref (that is, it must
> > start with "refs/", so "refs/heads/new_name" for a branch or
> > "refs/tags/new_name" for a tag).
> 
> Shouldn't <old_name> also be a full ref?

I tested this before sending the email, and it seemed to do the right
thing specifying only the branch name; so it probably /should/ be a full
ref, but it seems like it doesn't /need/ to be.
