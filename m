From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 0/2] bookmarks
Date: Thu, 26 Apr 2007 09:23:25 +0100
Message-ID: <200704260923.26637.andyparkins@gmail.com>
References: <200704252004.45112.andyparkins@gmail.com> <7vmz0vu1fc.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704260816480.27356@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 10:24:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgzHL-0008LN-7b
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 10:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933606AbXDZIYY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 04:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933604AbXDZIYY
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 04:24:24 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:53625 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933605AbXDZIYV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 04:24:21 -0400
Received: by mu-out-0910.google.com with SMTP id g7so527520muf
        for <git@vger.kernel.org>; Thu, 26 Apr 2007 01:24:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=b68jGV2Vcyx0Suesg9Zq62e0+Q32kxvzk68mVSL5yq644WLU+lNzA/G9Wi7X81T79KSo5TbzOFBmxqoX3Cix6S76MvtL0C2h3/xFANU6cZtYcmzlsB1KSHFaHwsCwmfq5YHfbB4p/zULuw3PbFkBvfaJokwXI76UB74Si76XKbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=RG2hdMwBUnlY7UJAQ/HfHP1hKA68wyZ8Kh3GhRXdvaEg55yDaHgnZsgdcDJmlwPIpR6Pjl0KeonIyTUg/MOZvryzWeOa6UpmJ2pljihM0MlkhVZhtjJWSPKCogfMDR1ZuF77mn4JOW9OZAYTyzOK2Rv3IMLy44EHRLOGoIehMpo=
Received: by 10.82.189.6 with SMTP id m6mr2775607buf.1177575858192;
        Thu, 26 Apr 2007 01:24:18 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z40sm115994ikz.2007.04.26.01.23.52;
        Thu, 26 Apr 2007 01:24:11 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0704260816480.27356@beast.quantumfyre.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45620>

On Thursday 2007 April 26, Julian Phillips wrote:

> > How would one find out about remote refs?  By running
> > ls-remote.  And that happens to also be how git-fetch follows
> > tags (the original issue Andy had).
>
> Surely though, what you really want is to simply not put the private refs
> into a public repo.  So the thing to be controlling is push, not fetch.

That's already taken care of by the update hook.  The default example that 
comes with git prevents the pushing of unannotated tags, and could be 
modified to prevent the pushing of any subset of refs that you wanted.

What I'm really talking about is the default functionality - we've got the 
glob syntax in the config for controlling which branches get pushed, that 
makes it easy to make branches that you don't want pushed.  For example you 
might have

 [remote "origin"]
   url = somewhere
   push = refs/heads/publish/*:refs/heads/*
   fetch = refs/heads/*:refs/remotes/origin/*

That way, only branches that I prefix with "publish/" get pushed.  All I'm 
after is a similar facility for tags.  Unfortunately, git assumes that I'm 
always going to want all tags so there is no namespace divisions I can make.

> I don't think it unreasonable to say that anything that is in a public
> repository is public, and that the way to keep things private is to not
> push them into a public repository. Or is it?

I don't think that's unreasonable at all - even though it can be worked around 
using a hook script, the problem still exists - what if I want the option to 
push a certain tag, but by default I don't want it sent.  For branches it's 
no problem - the [remote] supplies the default and I can always do 

 git push origin branch

for the extras.

> I understand that some people may wish to make their working repositories
> public, but then there isn't any way we can say for sure that things will
> remain private.  Even if ls-remote was updated, an older version would
> simply ignore the new "this is private" configuration.

No, no - I certainly don't want to make it public.  That's the point - I want 
to keep all my private things private, and hence I want to be able to control 
which branches and which tags are pushed and fetched.

> or simply expand the current push configuration to accept that syntax, so
> that you can finely control which refs get pushed to the public repo?

Yes - exactly right.  That's what I was trying to suggest (badly) with my 

[remote "origin"]
  url = whatever
  fetch = refs/tags/?:refs/tags/?

suggestion.

To say it more explicitly - perhaps tags should /not/ be auto-followed, but 
rather treated exactly as branches are?

Actually how about this: an option in the remote section to turn off 
auto-following and then add fetch and push lines for the tags too - that 
means very minimal changes and then everyone's happy (where everyone = 
me ;-)).


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
