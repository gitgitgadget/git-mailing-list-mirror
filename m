From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [BUG?] git-archive ignores remote .gitattributes (was: .git/info/attributes not cloned)
Date: Fri, 28 Mar 2008 06:02:02 -0700 (PDT)
Message-ID: <m3bq4zuhn5.fsf@localhost.localdomain>
References: <47EB0FAE.5000102@rea-group.com>
	<20080327033341.GB5417@coredump.intra.peff.net>
	<47EB213F.1020503@rea-group.com>
	<20080327042925.GA6426@coredump.intra.peff.net>
	<47EB271F.1050307@rea-group.com>
	<20080327045342.GC6426@coredump.intra.peff.net>
	<47EC7DD1.3060102@rea-group.com>
	<alpine.LSU.1.00.0803281321260.18259@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Toby Corkindale <toby.corkindale@rea-group.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 28 14:04:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfEFu-0007vM-GE
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 14:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758229AbYC1NCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 09:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760262AbYC1NCJ
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 09:02:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:5236 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760239AbYC1NCF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 09:02:05 -0400
Received: by ug-out-1314.google.com with SMTP id z38so695186ugc.16
        for <git@vger.kernel.org>; Fri, 28 Mar 2008 06:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=NJIOwExlmNmj3NYiSWZJvFwHXu5YXczBv9xC9QhMvDg=;
        b=CBIARdFHOqF9XKv8QpQpcZMgz8cfE6Ez6bt/BQNrOxgUrnQcABSKE9NfK0tsnxNYPxc2FS/SV3clpGtFbQJpJ0q+fDRucR2gJuhIgYQO++0RTB4stvn5ehGtRHvlMiyERKEQH/V2NHU2JCYEbGXfhvT+3GFdfSUn5GDT7zBfhq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=k2Zn48SQPJa6FmvzWn0KGItOXWYSXhd8M+3NG53vO8Ycp+Sm/ZaWV3SSSLTafySaF1i13kzjtuP3Ysj2ELnleONFo5sEDcv83cNwZcKurJ4a/kf606FPRq6b1i60rZ7ZnDIItxrRRBpFPkzdc3yit6SF3BnxIyhyX/gBL8cxiEg=
Received: by 10.67.195.14 with SMTP id x14mr3147723ugp.40.1206709323443;
        Fri, 28 Mar 2008 06:02:03 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.192.39])
        by mx.google.com with ESMTPS id 40sm3041503uge.2.2008.03.28.06.02.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Mar 2008 06:02:02 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2SD1vr1021457;
	Fri, 28 Mar 2008 14:01:57 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2SD1Y30021453;
	Fri, 28 Mar 2008 14:01:35 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LSU.1.00.0803281321260.18259@racer.site>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78402>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 28 Mar 2008, Toby Corkindale wrote:
> 
> > I submit that this is a bug, or at least undesirable behaviour:
> > 
> > "git-archive --remote=/some/repo" will ignore /some/repo/.gitattributes, 
> > but check /some/repo/info/attributes.
> > 
> > I think the problem is in the loop that looks for .gitattributes, which 
> > seems to do so by taking the current path and iterating down through it?
> 
> The problem is that "git archive --remote" operates on the remote 
> repository as if it were bare.  Which in many cases is true.
> 
> So I'd submit that this is not the usage .gitattributes is meant for, and 
> that you should clone the thing if you want to generate archives heeding 
> the .gitattributes.

This is simply caused by lacking implementation of .gitattributes
(which is quite new feature, so it is somewhat understandable).  

As I see it nothing prevents git to take and use .gitattributes from a
given tree (from a top tree of a given commit)... well, nothing except
the fact that git-check-attr, and probably also API used by attributes
code in builtins, doesn't have place to provide blob to be used as
.gitattributes (or tree to take .gitattributes from).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
