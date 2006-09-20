From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] gitweb: Always use git-peek-remote in git_get_references
Date: Wed, 20 Sep 2006 20:13:38 +0200
Message-ID: <200609202013.38457.jnareb@gmail.com>
References: <200609191430.51252.jnareb@gmail.com> <200609191431.49641.jnareb@gmail.com> <7v64fijz90.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 20:14:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ6Zs-0008LH-Ko
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 20:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWITSNm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 14:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWITSNl
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 14:13:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:47820 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932194AbWITSNl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 14:13:41 -0400
Received: by ug-out-1314.google.com with SMTP id o38so30181ugd
        for <git@vger.kernel.org>; Wed, 20 Sep 2006 11:13:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bkk2I+lSYCLVjzzHtrWRa2Qitw9DkjgCIRDnMZubXjWOGnwDHdBG+qt1lc5+Mhmnt48+iy6e1sSN9MB2VCDX8T8vaMnACAjyBCR0O1x11Cda7abpKGD3LVGbsmQlSvszkyalc9Bpn/UwyzRH79F7gzK56suoO5mH1qfwAd2eRdI=
Received: by 10.67.89.5 with SMTP id r5mr8361436ugl;
        Wed, 20 Sep 2006 11:13:39 -0700 (PDT)
Received: from host-81-190-26-109.torun.mm.pl ( [81.190.26.109])
        by mx.gmail.com with ESMTP id o1sm113854uge.2006.09.20.11.13.37;
        Wed, 20 Sep 2006 11:13:37 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7v64fijz90.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27389>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Instead of trying to read info/refs file, which might not be present
> > (we did fallback to git-ls-remote), always use git-peek-remote in
> > git_get_references.
> >
> > It is preparation for git_get_refs_info to also return references
> > info. We cannot use info/refs for git_get_refs_info as the information
> > contained therein is usually stale.
> 
> What the patch does is sane, but I think the last sentence of
> the proposed log message is not.  If info/refs is "usually
> stale", it is a bug in the repository to have such a stale file.
> 
> The real reason for this patch is that a repository served by
> gitweb is not necessarily meant to be fetched over HTTP and
> info/refs does not have to be there.

If the repository served by gitweb is updated using push, then
info/refs updated using post-update hook is up-to-date. If repository
is "live" repository, updated also using commit, rebase and such,
info/refs is usually stale.

If there were post-commit hook, and it's contents was the default 
post-update hook, info/refs would be never stale. And we could read
from into/refs, and fallback to git-peek-remote if it doesn't exist...
but we don't know if info/refs has current info.
-- 
Jakub Narebski
Poland
