From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Avoid unportable nested double- and backquotes in shell
 scripts.
Date: Sat, 8 Jan 2011 10:48:25 -0600
Message-ID: <20110108164825.GC28898@burratino>
References: <20110108090105.GB14536@gmx.de>
 <20110108161441.GA28898@burratino>
 <20110108162353.GB4786@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 08 17:48:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pbby1-0004Fd-Mn
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 17:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328Ab1AHQsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 11:48:33 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47178 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab1AHQsc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 11:48:32 -0500
Received: by iwn9 with SMTP id 9so18061004iwn.19
        for <git@vger.kernel.org>; Sat, 08 Jan 2011 08:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=VUmIfkFwZ9SAz1USdvgmrlyTMdk4WJWuBvCg3fSsopk=;
        b=lP7zBGo5wzAluWmJFJumcFfmjF90A/7+MymCy4q05l0udtKl1Ya0RnWqia2l7jXYFf
         3a9di2IIZx5ROVbNBcbcBfXDoRiZuF+e81CVbrstX8sucW/RieCjWad4KI51B50K0hfP
         gK/bWQjEuA8RJg3IzY5/+SIeGOpqk9wApWw3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QrNQuYNb4biu/xcdIU2RFmdd+rf68s/FVwzrHe20GWGm042rfp/dqb7j8KueLHj9LX
         5whz7WCZiiM2T9M/Wg4T2JJNEmw0jKzmv7dRkRE+tFOiStSCUQmcPKCCgEyM3aVXJMMI
         zi+PDwvZ5cm9LB9IKsySilKlDZC7P6s1qV4Bw=
Received: by 10.42.227.3 with SMTP id iy3mr2151252icb.453.1294505311528;
        Sat, 08 Jan 2011 08:48:31 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id k42sm1786265ick.8.2011.01.08.08.48.29
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 08 Jan 2011 08:48:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110108162353.GB4786@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164832>

Ralf Wildenhues wrote:

> But git makes heavy use of "no quoting needed on RHS of assignment"
> anyway, so it seems like this would be a good move nonetheless.

No disagreement there.

> And the
> testsuite uses backticks a lot,

>From a quick grep, it seems you are right:

 $ git grep -c -F -e '`' -- 't/*.sh' | cut -d: -f2 | sum
 65126     1
 $ git grep -c -F -e '$(' -- 't/*.sh' | cut -d: -f2 | sum
 64807     1
 $ git grep -c -F -e '`' -- '*.sh' | cut -d: -f2 | sum
 13350     1
 $ git grep -c -F -e '$(' -- '*.sh' | cut -d: -f2 | sum
 07810     1

Documentation/CodingGuidelines 

 - We prefer $( ... ) for command substitution; unlike ``, it
   properly nests.  It should have been the way Bourne spelled
   it from day one, but unfortunately isn't.

> it seems a move away from that should be
> done more uniformly?

I don't see why. :)  In fact, I personally would not be happy at all
to see such a high-churn patch as that, while using the $( ... )
form in new code and as part of clarifications to other parts of the
same lines would seem to me to be a welcome thing.

Having said all that, I have no strong investment in this.  Feel
free to do what works best for you.

Thanks,
Jonathan
