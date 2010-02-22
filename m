From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Storing (hidden) per-commit metadata
Date: Mon, 22 Feb 2010 17:20:13 +0300
Message-ID: <20100222142013.GA7863@dpotapov.dyndns.org>
References: <1266687636-sup-7641@ben-laptop>
 <32541b131002201057t31fc8a6aydb0942171fe1b8c8@mail.gmail.com>
 <20100221063433.GA2840@coredump.intra.peff.net>
 <1266754646.12035.23.camel@ganieda>
 <20100222051748.GB10191@dpotapov.dyndns.org>
 <1266832607.31769.37.camel@ganieda>
 <20100222112845.GE10191@dpotapov.dyndns.org>
 <1266839972.4575.38.camel@ganieda>
 <20100222130836.GG10191@dpotapov.dyndns.org>
 <1266846289.4575.69.camel@ganieda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Avery Pennarun <apenwarr@gmail.com>,
	Ben Gamari <bgamari@gmail.com>, git <git@vger.kernel.org>
To: Jelmer Vernooij <jelmer@samba.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 15:21:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjZA2-0003oa-SI
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 15:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443Ab0BVOUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 09:20:20 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:40942 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401Ab0BVOUR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 09:20:17 -0500
Received: by fxm19 with SMTP id 19so2538205fxm.21
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 06:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=F1PmH98LOOiocoLgbmQxlL9Sod4riu0zYMbka8ktNDo=;
        b=BxN2jon/Uv3qSRDemIPAoqV/Rq98L8UUhVzYismPLxa3XG6X00YX1U5HwAHL9L4wNq
         1EBg3qt2pzumJxiJXuiWYvlTXUlVnHTSq/3veVzrp5NlA5531Wf4rJLWuLXnvwylNLeR
         xytctuPQ56DpdbNEufHg8aO6fWaqgMHB6j8Rk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UC00kbUqIuUUzIt7mvMDvCmvYFGGTF9VaIq/eiMjjVQ9CvaVKz2FatjbR3TDejzKZD
         AA1xCkTTB6umOwOlUwdTGxZGtOx8gCntVGMtUhoWzNWO3C7HLyNRzA2mqrYK1HqqQRdT
         SGPyivdYcr5P3Rr/aZ0YlkBeeqy159SwKFegM=
Received: by 10.223.29.199 with SMTP id r7mr7470627fac.73.1266848416203;
        Mon, 22 Feb 2010 06:20:16 -0800 (PST)
Received: from localhost (ppp91-77-227-64.pppoe.mtu-net.ru [91.77.227.64])
        by mx.google.com with ESMTPS id 13sm1511080fxm.14.2010.02.22.06.20.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Feb 2010 06:20:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1266846289.4575.69.camel@ganieda>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140684>

On Mon, Feb 22, 2010 at 02:44:49PM +0100, Jelmer Vernooij wrote:
> On Mon, 2010-02-22 at 16:08 +0300, Dmitry Potapov wrote:
> > I am not sure that the commit object is the right place to store that
> > metadata, but hidding this information is even more problematic. Let's
> > suppose that someone cherry-pick your Bazaar originated commit. Now when
> > you try to synchronize with Bazaar, your synchronizer will see that it
> > has some Bazaar revision ID and branch name, but, in fact, it is new
> > commit on a completely different branch...
> I don't see how the fact that the bzr-git/hg-git data is being hidden is
> the problem in the scenario you mention.

Because you can easily remove that information manually when you cherry-pick
some commit. It is more difficult to do when it is hidden.

> It'd be nice if this sort of information was discarded by "git rebase",
> but that's another good reason to treat it in a different way from the
> commit message instead.

Well, I do not see any other place in the commit object aside the commit
message where you can easily put information, and I do not think it is a
good idea for "git rebase" to edit the commit message automatically.
Maybe, you should look at git-notes. (I don't know enough about them to
tell whether they are suitable or not).


Dmitry
