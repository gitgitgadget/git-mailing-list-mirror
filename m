From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Storing state in $GIT_DIR
Date: Fri, 26 Aug 2005 18:43:26 +1200
Message-ID: <46a038f905082523431c3b577f@mail.gmail.com>
References: <46a038f905082420323b025e3b@mail.gmail.com>
	 <Pine.LNX.4.58.0508251053000.3317@g5.osdl.org>
	 <46a038f905082518306e9d7d2a@mail.gmail.com>
	 <Pine.LNX.4.58.0508252051400.3317@g5.osdl.org>
	 <46a038f90508252115415acc04@mail.gmail.com>
	 <7v3boxl3o1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 10:06:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8XxG-0005ci-Eb
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 08:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbVHZGn3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 02:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbVHZGn3
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 02:43:29 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:27216 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932527AbVHZGn2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 02:43:28 -0400
Received: by rproxy.gmail.com with SMTP id i8so512428rne
        for <git@vger.kernel.org>; Thu, 25 Aug 2005 23:43:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KNnuHO2sp2Frlm5CMpN3eTfYX7XwBEGnWflG18aaeF5sa//eNoXucTF2yNlW82jdcc2Pzhwh7EFoHIGranM2Pd1Rq8tTrfHG3fbx0JingkQdV9CIOZyEOyGDLfy1VAByXVPmU25vdSv4LvcFaLdQIhpPFJuQ6sTGgVhHGy1gNsE=
Received: by 10.38.101.2 with SMTP id y2mr1572581rnb;
        Thu, 25 Aug 2005 23:43:26 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Thu, 25 Aug 2005 23:43:26 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3boxl3o1.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7775>

On 8/26/05, Junio C Hamano <junkio@cox.net> wrote:
> > Hmmm. That repo is in sync, but there are no guarantees that they will
> > travel together to a different repo. In fact, the push/pull
> > infrastructure wants to push/pull one head at a time.
> 
> Wrong as of last week ;-), and definitely wrong since this morning.

Haven't had time to learn what the new conventions are for push/pull
scenarios. Will try and read up...

> > And if they are not in sync, I have no way of knowing. Hmpf. I lie:
> > the arch metadata could keep track of what it expects the last head
> > commits to be, and complain bitterly if something smells rotten.
> 
> What Linus suggests is doable by using an object that can hold
> a pointer to at least one commit---you used that to record the
> head commit of the corresponding git branch that the arch
> metainfo represents.

Yes. If I have my "arch-metadata" head, I can have several files
there, one of them containing a list of head "names" and the sha we
expect them to correspond to. If the thing doesn't match, we crash and
burn because we are out of sync.

Now, during import I'll have to be extra careful at commit-time, and
update and commit the arch-metadata head immediately after I commit
the head I'm importing, with strong error-handling. This should
minimize the out-of-sync situation.

If we _are_ out-of-sync, I could have a recovery mode that rewinds the
heads to the 'last known good' position and replays things forward. If
my script is stable, the results should be stable too...

> You only pull arch metainfo branch; the objects associated with
> the corresponding git branch head will be pulled together when
> you pull it.  You do not have to tell git to pull git-part of
> the commit chain.  There is no need to worry about version skew
> when you use git this way.

>From here onwards, you lost me, mate ;)

cheers,


martin
