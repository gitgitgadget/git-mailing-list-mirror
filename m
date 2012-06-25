From: Marcin Owsiany <marcin@owsiany.pl>
Subject: Re: [PATCH/RFC] git-svn: don't create master if another head exists
Date: Mon, 25 Jun 2012 08:57:26 +0100
Message-ID: <20120625075726.GO3125@beczulka>
References: <20120624220835.GA4762@beczulka>
 <7v4nq0hrjb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 10:05:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj4Ic-0004nY-73
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 10:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553Ab2FYIFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 04:05:22 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:44081 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab2FYIFT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 04:05:19 -0400
Received: by mail-we0-f174.google.com with SMTP id u7so2596451wey.19
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 01:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=Mh3Cv/H3zBQJLfSh4WYmYPg5xBkrNsIGZkNqrNUvwGk=;
        b=AcS3wR7qFTM47ctX67TCZnX6kuhGKEsdIpSyZecWMVhgeuk3tJx2zwlZdemF1APTB2
         mjjHA5bQKH+pBfke9gls51SYGVgY5fVNiQ448/YYB8tM5vWmPE0RyNVIg0NLVR8KEQ3B
         h+YorNFHbiV9D//ZqPANXqcTyjmnVXqY92u99IhmcTYsTUtkGXsH9wl5lSk/cfyTgCj1
         LElP9izkmctAkptAwxptxkEMVqDT3LT4HO3yAfQiSg1hizGJpSKQmFkvqLXKTJG0IlEE
         JUYzI3xuB434EgchMuFjC64XB8zjLse0xgPJojBAiK3C4Mh2CE+Gni2dTbNhljCGegz7
         6U+g==
Received: by 10.216.143.223 with SMTP id l73mr5611534wej.97.1340611518237;
        Mon, 25 Jun 2012 01:05:18 -0700 (PDT)
Received: from beczulka (dhcp-172-26-143-156.dub.corp.google.com [172.26.143.156])
        by mx.google.com with ESMTPS id z8sm31480426wiy.1.2012.06.25.01.05.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jun 2012 01:05:16 -0700 (PDT)
Received: from mowsiany by beczulka with local (Exim 4.71)
	(envelope-from <marcin@owsiany.pl>)
	id 1Sj4Ao-0006na-Dt; Mon, 25 Jun 2012 08:57:26 +0100
Content-Disposition: inline
In-Reply-To: <7v4nq0hrjb.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Gm-Message-State: ALoCoQlUKCo56k74n3OMYK3hmcLpzMGvElDR421+0qD6ZzYFdW6BIWd6g4/oBd+foeGRxxufXi0b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200559>

On Sun, Jun 24, 2012 at 10:47:04PM -0700, Junio C Hamano wrote:
> Marcin Owsiany <marcin@owsiany.pl> writes:
> 
> > diff --git a/git-svn.perl b/git-svn.perl
> > index 0b074c4..90f3d06 100755
> > --- a/git-svn.perl
> > +++ b/git-svn.perl
> > @@ -1613,6 +1613,8 @@ sub post_fetch_checkout {
> >  	}
> >  
> >  	my $valid_head = verify_ref('HEAD^0');
> > +	my @heads_commits = eval { command(qw(show-ref --heads --hash)) };
> > +	return if $valid_head and grep { $_ eq $valid_head } @heads_commits;
> >  	command_noisy(qw(update-ref refs/heads/master), $gs->refname);
> >  	return if ($valid_head || !verify_ref('HEAD^0'));
> 
> This looks like a typical XY solution.

Can you please explain wha an "XY solution" is? I'm not familiar with
this expression.

>  What are you really trying
> to validate?  "HEAD" points at an existing branch and you do not
> care what branch it is?

Yes. I think.

>  HEAD may not even point at a valid branch
> but can be detached as long as it happens to point at a commit that
> is at the tip of some branch (hence building further commit on HEAD
> will break the condition you are checking in the above code)?

The more questions you ask, the less I feel I know about how git works
:-)

-- 
Marcin Owsiany <marcin@owsiany.pl>              http://marcin.owsiany.pl/
GnuPG: 2048R/02F946FC  35E9 1344 9F77 5F43 13DD  6423 DBF4 80C6 02F9 46FC

"Every program in development at MIT expands until it can read mail."
                                                              -- Unknown
