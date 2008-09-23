From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] add GIT_FAST_STAT mode for Cygwin
Date: Tue, 23 Sep 2008 21:12:09 +0400
Message-ID: <20080923171209.GP21650@dpotapov.dyndns.org>
References: <20080923140144.GN21650@dpotapov.dyndns.org> <20080923153148.GI3669@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 23 19:13:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiBRx-00037G-Te
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 19:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbYIWRMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 13:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbYIWRMQ
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 13:12:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:45211 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbYIWRMP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 13:12:15 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1667852ugf.37
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 10:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/Lx5i2xV6xc7uN2/ffNeylZBFdpGAgej1Wqy0xGxf0c=;
        b=P+lUr6tywxIBtt8GC+0dS7O5l9bGDdSPfewc2uzJyuvcP00HkwEUjd5yCU5iy6JBK5
         ivUIRyByPs/Hx+tYi9K8afeVKOp3slmTu/k4bfHYSQWdXHQ9rD7yw20knFzoNkXECH02
         pGEYX+zp3tqCgqh7g74PtLB1wfi7Byk4KOzuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YwPdY6ZvdW9goVEZyMbL0xfzsEFY1pZHHpG5O8E5xOY+a6aiTLoY0o7x26q9ed6WFl
         TmK9qMyaz03GtAa2kOvyJO2bvm7o4wQBcZCAUE1SHoVs8BWWaZdiJO9zaGdqV13pl+zd
         0+kOobtDhnlxCTBZDi+umpwDg6j5wubNKphiI=
Received: by 10.86.58.3 with SMTP id g3mr1546166fga.17.1222189933162;
        Tue, 23 Sep 2008 10:12:13 -0700 (PDT)
Received: from localhost (ppp85-140-168-121.pppoe.mtu-net.ru [85.140.168.121])
        by mx.google.com with ESMTPS id 4sm9200854fge.8.2008.09.23.10.12.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Sep 2008 10:12:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080923153148.GI3669@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96578>

On Tue, Sep 23, 2008 at 08:31:48AM -0700, Shawn O. Pearce wrote:
> 
> I wonder, should this be controlled by an environment variable?
> 
> Given your description of the feature it seems to be more a property
> of the specific repository, as it is based upon where the repository
> lives within the Cygwin namespace.  Should this be controlled instead
> by say a "core.cygwinnativestat = true" configuration property?

I am not sure that you will find many people who will want to set this
option per repository, yet Git has the configuration file, and I agree
it is better to place it there.

However, this option is Cygwin specific, so I am not sure where it
should be read. Should I place it in git_default_core_config like
this:

#ifdef __CYGWIN__
	if (!strcmp(var, "core.cygwinnativestat")) {
		cygwin_native_stat = git_config_bool(var, value);
		return 0;
	}
#endif

So far, we have not had any system specific options here. So, perhaps,
it is better to leave git_default_core_config alone and just replace
get_env(GIT_FAST_STAT) with git_config_bool() in the cygwin specific
code.


Dmitry
