From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Sun, 6 Feb 2011 00:40:45 +0300
Message-ID: <20110205214045.GA15668@dpotapov.dyndns.org>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102020322.00171.johan@herland.net>
 <7vpqr7xw4z.fsf@alter.siamese.dyndns.org>
 <201102050218.44325.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Feb 05 22:41:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlpsJ-00082R-NQ
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 22:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422Ab1BEVkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 16:40:52 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40000 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063Ab1BEVkv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 16:40:51 -0500
Received: by bwz15 with SMTP id 15so3826091bwz.19
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 13:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=qcDTJhnXRwyp3rYj0EeQeKLtGhOnveGmWVGdGNUY7PI=;
        b=agvIwXAttLKHdQWytBc/xisDrY/Krz8hWZ/vCcxwBT0OWfRrIuAsfZxB6/s964cAfZ
         gfzvF1eh6Ruh3mQjdz8b3PH8zZVboLSAmGHakP7H2tNpa2OCBvbOwZYPzq1auxhhP6Ra
         NdpExa8+GhPbHmWROOEyxKib26HkVhaRr434I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IBx+hhdDXyiEdjVMu1TPHXc6TINRZzxGaO8xTyCLp0xq6C82OufOFibEVIaXEM4Cll
         TOGi+s/5q27R910/B8CduyCbXs+5A1QMs5X8xIskVhNIr/d2jDN3zPcnDj4uK3j2/R7+
         gIpyNypjMGXoFerkJyAnFCwX7mduyYedAexyg=
Received: by 10.204.100.82 with SMTP id x18mr6137374bkn.20.1296942049787;
        Sat, 05 Feb 2011 13:40:49 -0800 (PST)
Received: from localhost (ppp83-237-255-32.pppoe.mtu-net.ru [83.237.255.32])
        by mx.google.com with ESMTPS id v25sm1164811bkt.6.2011.02.05.13.40.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Feb 2011 13:40:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201102050218.44325.johan@herland.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166118>

On Sat, Feb 05, 2011 at 02:18:44AM +0100, Johan Herland wrote:
> On Friday 04 February 2011, Junio C Hamano wrote:
> 
> > For some reason, many people seem to be enthused about splitting the tag
> > namespace, but I am not sure if that is a good thing in general. 
> > Branches are moving pointers for people to flip around in their local
> > repositories, and it makes sense to say "My master is a bit ahead of the
> > public one", but what would we gain by making it _easier_ to add and
> > exchange many tags with the same name (e.g. refs/remotes/*/tags/v1.7.4
> > vs refs/tags/v1.7.4), other than the extra confusion?
> 
> First, I should state that making tags into moving pointers is not something 
> I support, nor is it part of this proposal. Tags should still very much 
> refuse to be moved (except when forced).
> 
> Having said that, there are real situations where users encounter collisions 
> in the shared tag namespace. A rare (but plausible) scenario arise when two 
> developers create (and publish) conflicting tags in their repos. A more 
> common scenario that I have encountered at $dayjob, is where two parallel 
> (semi-related) projects are developed in separate repos (with different 
> versioning because of separate release schedules), and I need to interface 
> with both repos from a single local repo. Each of the remote repos have 
> their own "v1.0" tag, but my repo can only hold one such tag. Which of those 
> tags end up "winning" in my local repo depends on my fetch order.

Well, I agree that this situation requires a better diagnostic, but I
don't think that having separate namespaces is the right solution in
general. For your case, where you work on semi-related projects, it is
could be the right thing to do, but if you work on the same project and
have more than one source to fetch, then having multiple namespaces can
lead only to confusion, because tag names must be unique globally to
make sense to everyone. Actually, even if you have two semi-related
projects in the same repository, but you have more than one URL per
project, you want to group tags based on their relation to the project
and not based on the URL.


Dmitry
