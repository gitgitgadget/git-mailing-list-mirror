From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Fri, 18 May 2007 10:40:36 +0100
Message-ID: <200705181040.37648.andyparkins@gmail.com>
References: <200705170539.11402.andyparkins@gmail.com> <200705180857.18182.andyparkins@gmail.com> <20070518085708.GC4708@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>
To: git@vger.kernel.org, "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Fri May 18 11:40:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoyxH-00067n-BA
	for gcvg-git@gmane.org; Fri, 18 May 2007 11:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078AbXERJkv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 05:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754567AbXERJkv
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 05:40:51 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:33614 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078AbXERJku (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 05:40:50 -0400
Received: by mu-out-0910.google.com with SMTP id w1so551082mue
        for <git@vger.kernel.org>; Fri, 18 May 2007 02:40:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hA6Tn3/ZC5E5l9gfg20nMuaQJNMCeqeuwnoPF1Oq3JGP27t/c2Gmj1P25rDy8F+oV3nikqbQWhv2jGwhIeWVEF6YQdfpnv90/erHFSbgFgBJAbVSNu0UmvrmdDXDIQwi3wVNIt7+9RbWEdufobi/z/YXzRFidwmSx4OfpffC3Yo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bC4iZsEN2BqAVSDhWQWVbuqAxPE1ndprdxU0IG1EKaGRNuEVnf5ckZ9QIx1bOn+e2xVcgJiHmDVE6tQfTgBcx5VUCbZ64pJDyVhc3+mo/leEQAmKOaeZYLsQzL5VDVxtWqdznoVov88ZkXRVz3J/NmtXmjRuvL1TBJ+XcairUPA=
Received: by 10.82.123.16 with SMTP id v16mr2429110buc.1179481248086;
        Fri, 18 May 2007 02:40:48 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z40sm32732ikz.2007.05.18.02.40.42;
        Fri, 18 May 2007 02:40:45 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <20070518085708.GC4708@mellanox.co.il>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47586>

On Friday 2007 May 18, Michael S. Tsirkin wrote:

> > I think that's the wrong solution.  A change of source URL for a
> > submodule from what upstream uses to your own server is a _fork_ from
> > upstream, therefore you would fork your own branch in your supermodule
> > and alter .gitmodules to point at your server.  Everybody is happy, and
> > the fork is recorded.
>
> Why should I record it? If the content is the same, the commit name should
> be the same, it shouldn't matter where did the content came from.

Because you have changed something that the upstream repository supplied with 
no way of detecting it.  It's the same as if upstream supplied 
important_login_function.c and then you clone it; if your clone had a way of 
changing important_login_function.c to add a backdoor and passing that to 
people who clone from you without changing the commit hash that would be bad.

Submodules is the same; upstream might say
 kernel git://git.kernel.org/kernel-2.6.git
Then you clone it and use the override system to override that to
 kernel git://git.dodgykernel.org/backdoors.git
without having to change the repository.

The server should not be allowed to override the url that the client sees.  
Only the client should make that decision.

> I wouldn't be happy: I have just cloned both project and superproject,
> but to re-publish the superproject using my clone of subproject, I have
> to create a new commit, which would have a different hash from the origin.
> So how do people know they can trust my tree?

That problem exists regardless of the method of changing URL - in your method 
though the change is entirely unrecorded because you've changed something 
that upstream supplied in an out-of-band manner.

> And what happens when the original super-project pulls from me -
> it seems that his .gitmodules will now point to my server?

Now that one is a good defence.  Okay; I accept that changing .gitmodules 
won't work.  However, I don't accept that the server should be allowed to 
supply overrides to the client.  Another method is needed.

> > The override system is only there for the local repository (which always
> > takes precedence) not for the server provider to hide detail from those
> > checking the repo out.
>
> I really like it that currently, in git, there is no difference between a
> public and local repository.  If the override system is only for the local

Of course there is a difference.  .git/config is different; .git/refs is 
different; .git/info/exclude is different; etc.  These are all per-repository 
settings - and there is no way for a server to force it's version of those 
files on a client.

> So I have have cloned the supermodule and the submodule to my laptop -
> it's enough to edit .git/config and I can use the history locally - that's
> good. But now I try to clone the local tree - and a clone will try to go
> out to the URL which I cloned - bad.

Yep.  That is the problem.  In the end the only practical solution might be to 
allow the server to supply part of the .git/config (which is essentially what 
your suggestion would do); but I think that that is a big step to take and 
has potential to be abused.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
