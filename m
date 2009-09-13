From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] git-gui: suggest gc only when counting at least 2
	objects
Date: Sun, 13 Sep 2009 23:19:25 +0200
Message-ID: <20090913211916.GA5029@localhost>
References: <20090909195158.GA12968@localhost> <20090913160637.GA15256@localhost> <7vr5uasp4a.fsf@alter.siamese.dyndns.org> <20090913184150.GA19209@localhost> <20090913204433.GA8796@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 13 23:19:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmwU2-0007Ck-0d
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 23:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163AbZIMVTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 17:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755156AbZIMVTe
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 17:19:34 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:45689 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155AbZIMVTd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 17:19:33 -0400
Received: by fxm17 with SMTP id 17so482853fxm.37
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 14:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:bcc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=zu9CSfm3Sy/+JNsBaoP7XTyipbOZ+b0K2dIRQN1mTWE=;
        b=Df7Zcma1BJs4z0J8G8TzZl3G90Yt7sa7GneeVHPAsvc+fmKdEmKaCgtPiY5Wu/sm19
         lE1nxtFhYo7DqmQfee56uJHPBZyNOALz4fkB0UJZmoCO8hpQELMGFcEvDuPKzPwJ+QGF
         1sf0Na+RIj0R3+Z+LpfYn30MhsPToCfU1U0t8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=nQVjnOYCtfArBjbZQoShLOUsmmaDIahtQ6sUIsxsV1uT3p3W2mVZ3bJCLLzEzrNRve
         QhbkYnl/P5U5c5oRJ+rZWOFjQRDlcAMGsM1VS6BS9Mdvv3T4SzfBo2yZtwWN8HA691rn
         MLjYBsyjV14glD6B5dSufhn7kcoXWy7wb5GGM=
Received: by 10.204.18.145 with SMTP id w17mr4466180bka.42.1252876775231;
        Sun, 13 Sep 2009 14:19:35 -0700 (PDT)
Received: from darc.lan (p549A51F1.dip.t-dialin.net [84.154.81.241])
        by mx.google.com with ESMTPS id 11sm6947266bwz.95.2009.09.13.14.19.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 14:19:34 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MmwTm-0001uR-0Q; Sun, 13 Sep 2009 23:19:26 +0200
Content-Disposition: inline
In-Reply-To: <20090913204433.GA8796@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128417>

On Sun, Sep 13, 2009 at 04:44:33PM -0400, Jeff King wrote:
> On Sun, Sep 13, 2009 at 08:41:50PM +0200, Clemens Buchacher wrote:
> 
> > On Sun, Sep 13, 2009 at 10:58:45AM -0700, Junio C Hamano wrote:
> > > Somebody cares to explain why this threashold number has to be different
> > > per platform in the first place? 
> > 
> > I really don't know. I vaguely remember someone claim that performance on
> > Windows suffered from many loose objects more than on other platforms. I
> > can't find any discussion of it though.
> 
> Maybe 8ff487c?

Ok. But it's been 2 years since then and if I'm not mistaken, there have
been a number of performance improvements to msysgit. So maybe it's time to
revisit that threshold.

If, on the other hand, requiring 2 objects really is too many, we should
maybe check at least two or four directories, which would greatly improve
the statistic.

For example, the probability of q directories containing q objects, for n
objects total is

n \ q	1	4
50	18%	1%
100	32%	7%
200	54%	38%
500	86%	95%

Clemens
