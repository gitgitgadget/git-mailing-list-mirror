From: David Aguilar <davvid@gmail.com>
Subject: Re: Improving the git remote command
Date: Wed, 27 Aug 2014 09:36:18 -0700
Message-ID: <20140827163617.GA66615@gmail.com>
References: <53FC537C.4080206@gmail.com>
 <20140826124027.GE29180@peff.net>
 <CAGK7Mr7BPvV6oO_t4x_1m9sDtWBgPWUqDq+3kZx6rVYAhY+wqA@mail.gmail.com>
 <20140826163741.GA14983@peff.net>
 <xmqq7g1vjh9o.fsf@gitster.dls.corp.google.com>
 <20140826173312.GB16394@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	=?utf-8?B?UsOpbXk=?= Hubscher <hubscher.remy@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 18:36:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMgCc-0004Gp-4S
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 18:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755217AbaH0QgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 12:36:00 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:59854 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbaH0Qf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 12:35:59 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so583626pab.40
        for <git@vger.kernel.org>; Wed, 27 Aug 2014 09:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=c7keiJwM0PO9CvmNVwavW3IDBEJMvAyjka634DfiCYc=;
        b=yevXGaBs6rTU2UDNe23JcqQsSOW5pzGihSqmTLk+dTCa9a5XLIi7K9m+AlStazoXnM
         bNwh/WFiIbJmEXyp09co36zlWOfINbcFyjxBoUcNA93aYOzaG7ZkQx9nXUqEgGSxjFCB
         FE1BxEB5Dy1P+3Oi0HgL2x5ZMLwnkbG/MoFdyIn/R0Fl/5HGuuTVw06bcKToSW0BPpi9
         6vv5rvahQoPE1MIYmT3dFg8sHr947Au+M+IDGx/DdDGABg0ERUR5/VThOihZ2AGm51e3
         SAA5g9A6AdCHRGy+OkGMScjwzsbP8jtL6U0j2EC6TOCpBrQryuSP23VVBCXqa3e6DNeK
         rVNg==
X-Received: by 10.66.152.171 with SMTP id uz11mr46523705pab.96.1409157355948;
        Wed, 27 Aug 2014 09:35:55 -0700 (PDT)
Received: from gmail.com (wbucrp-gdm0a-as.bsc.disney.com. [204.238.46.100])
        by mx.google.com with ESMTPSA id im1sm921695pbb.29.2014.08.27.09.35.54
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 27 Aug 2014 09:35:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140826173312.GB16394@peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256008>

On Tue, Aug 26, 2014 at 01:33:12PM -0400, Jeff King wrote:
> On Tue, Aug 26, 2014 at 10:24:35AM -0700, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > ... But we are left with three options:
> > >
> > >   1. Add "git remote list" with verbose output. This is bad because it
> > >      differs gratuitously from "git remote".
> > >
> > >   2. Add "git remote list" with non-verbose output. This is good because
> > >      it means "git remote" is just a shortcut for "git remote list",
> > >      which is consistent with other parts of git. But it is potentially
> > >      bad if "-v" is a better output format.
> > >
> > >   3. Add "git remote list" with verbose output, and tweak "git remote"
> > >      to match. This is bad because it breaks backwards compatibility.
> > >
> > > The proposal is for (1). I think we agree that (3) is out. The question
> > > is whether (1) or (2) is the least bad.
> > 
> > I would imagine that those who want list of remotes programatically
> > would read from "git config" output and it would be with less
> > friction to change the output from "git remote", a command that is
> > solely to cater to end-user humans, to suit people's needs, so I am
> > not sure if (3) is immediately "out".
> 
> Yeah, I touched on that earlier. I would personally consider "git
> remote" to be a porcelain, and "git config" to be the appropriate
> plumbing for accessing those values. However, it's a little tricky to
> robustly get the list of remotes with "git config". So I would not be
> surprised if scripts have used "git remote" to do the same thing (I know
> for a fact that some internal scripts at GitHub did this, though I
> recently cleaned them up so I do not have a vested interest either way
> at this point).
> 
> That does not mean those scripts are right and we cannot change things,
> but it may be a matter of practicality.

We have some internal scripts at Disney Animation that rely on "git remote"
output so I would vote for #3 personally as well.

I know that "git config" is porcelain, and I can get remote.(.*).url,
but that's not obvious and I highly doubt that anyone does that.

What if we said that "git remote list --porcelain" == "git remote"
and then just leave "git remote" output as-is so that we don't have to
have a flag day when we break people's scripts?

Those that want verbose output can use "git remote list".

> > Having said that, my preference is 
> > 
> >     0. Do nothing, but document the "default to listing" better if
> >        needed.
> > 
> > and then 2. above, and then 1.
> 
> Yeah, I'd agree with that.

Ditto.
-- 
David
