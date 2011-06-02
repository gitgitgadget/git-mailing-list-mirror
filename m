From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git clone (ssh://) skips detached HEAD
Date: Thu, 2 Jun 2011 22:02:31 +0200
Message-ID: <201106022202.33393.jnareb@gmail.com>
References: <BANLkTi=xK+hmvGTLnKREScABU=7v_SKqPQ@mail.gmail.com> <m31uzdxjf9.fsf@localhost.localdomain> <20110601225128.GB16820@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 02 22:02:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSE6R-0001i0-Kg
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 22:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540Ab1FBUCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 16:02:43 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40647 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374Ab1FBUCm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 16:02:42 -0400
Received: by wya21 with SMTP id 21so904481wya.19
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 13:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=wV4Z4Oxlu2uylSXWk1vSifMCcEv/BWCsWPLnlT6caC8=;
        b=wzzKh+e09PIX0j/SHay9sNO82owZC+sFEvZUrUjmX6wM+C6DzKl1uyni+aGJf8ItRY
         jYnFtUwwc+c7YyjbRdH9Fsmgqx3BZbTyyThjxzCEvngfVFfoeA7Ps6pY4phDsUL3fZdB
         KdcS9VMZ+D00MXZCJpfIh+Aqu/PwlpVFIkdSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=tgI9NWwQEu4CJDuAAVLDvuQfyAqtJoiBTRiOIRCg8C+dGsg9C4CX54cHiIGpO7yOKd
         1+rFhKwxF9I5djGubE6EquiFVCA25q+rHC1D3syl8u8FkPXfdfxHuJXoZ/QJ8u/RGXQ6
         1kv37E7ZAMHZ0Gj+lAlum6zwU05fjyNJU3nYY=
Received: by 10.227.196.209 with SMTP id eh17mr1132133wbb.5.1307044960921;
        Thu, 02 Jun 2011 13:02:40 -0700 (PDT)
Received: from [192.168.1.13] (abwo192.neoplus.adsl.tpnet.pl [83.8.238.192])
        by mx.google.com with ESMTPS id ge4sm590055wbb.64.2011.06.02.13.02.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Jun 2011 13:02:39 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110601225128.GB16820@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174974>

On Thu, 2 Jun 2011, Jeff King wrote:
> On Wed, Jun 01, 2011 at 03:42:58PM -0700, Jakub Narebski wrote:
> 
> > > The reason is that the default refspec on clone is:
> > > 
> > >   $ git config remote.origin.fetch
> > >   +refs/heads/*:refs/remotes/origin/*
> > > 
> > > And HEAD is not under refs/heads/.
> > 
> > Hmmm... HEAD is a bit of special case, as HEAD should really land in
> > refs/remotes/origin/HEAD from what I understand.
> 
> No, that is always supposed to be a symbolic ref. Making it a real ref
> would be confusing. I don't think fetch should look at HEAD at all; it's
> outside its refspec. However, clone does treat HEAD specially, and
> should probably convert the remote's detached HEAD into a local detached
> HEAD (we already do if it's part of referenced history).

Hmmm... in ordinary case (not on detached HEAD) "git fetch" would never
modify my local branches nor my local HEAD.  On the other hand IIRC
origin/HEAD do not follow switching branches at origin, and is staying
at the value at clone (or "git remote set-head"), isn't it?  

So what to do when HEAD on origin is detached?  Modify .git/HEAD,
or maybe .git/refs/remotes/origin/HEAD?

-- 
Jakub Narebski
Poland
