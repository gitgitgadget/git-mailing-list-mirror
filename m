From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told to
Date: Wed, 25 Jun 2008 16:04:47 -0400
Message-ID: <32541b130806251304u39c8ffdenc52904391aebd089@mail.gmail.com>
References: <20080624222105.GA24549@dervierte>
	 <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com>
	 <7vwskea2ik.fsf@gitster.siamese.dyndns.org>
	 <48620C1A.6000509@panasas.com>
	 <alpine.DEB.1.00.0806251109380.9925@racer>
	 <486220CE.3070103@viscovery.net>
	 <alpine.DEB.1.00.0806251334060.9925@racer>
	 <20080625135100.GF20361@mit.edu>
	 <7v63rx2zwf.fsf@gitster.siamese.dyndns.org>
	 <20080625195003.GB15077@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Boaz Harrosh" <bharrosh@panasas.com>,
	"Steven Walter" <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: "Theodore Tso" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 25 22:05:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBbFU-0002To-CO
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 22:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbYFYUEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 16:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbYFYUEu
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 16:04:50 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:7899 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbYFYUEt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 16:04:49 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3367321fkq.5
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 13:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=eQISSZy8AM43Eb+IFtXPHE7Ec10Cq75Z9vpVlhSaKTI=;
        b=F4Tq37N8k3Oa/B5oSQDK4UaDpNBwXHl1b1GHM5meaOnnwM6yprKBp3gvMDRuXhA8OM
         Ioz/TPwfx9bGC4YLQhyulEoAs5cH2hVxHSLFSskZDZvmfCVY6KvH5G4HiczEt3Ut0dM2
         lNakN5tMYnQ0ZIBKty5IR81NXrwS0RLae1G2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Igv8AE2mlLE9MYKd7qKc13WXT+QBQylMpIsfPmwOCzSuSaNONcW5G17d8VZhCtC0/W
         PyOepToUmjHmkDLJ/RdNru+DfXsMrsB/6KAMOv8J3rSbE6XHUYctR+czZxLY+FPUFZYV
         hRZByby82IkSSQlMhg5pDWmCYEM9fjMYCrWEs=
Received: by 10.82.135.7 with SMTP id i7mr664183bud.42.1214424287472;
        Wed, 25 Jun 2008 13:04:47 -0700 (PDT)
Received: by 10.82.175.10 with HTTP; Wed, 25 Jun 2008 13:04:47 -0700 (PDT)
In-Reply-To: <20080625195003.GB15077@mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86333>

On 6/25/08, Theodore Tso <tytso@mit.edu> wrote:
> On Wed, Jun 25, 2008 at 10:22:08AM -0700, Junio C Hamano wrote:
>  >         exec git checkout HEAD -- "$@"
>
> Well, I think you really want this to handle filenames with spaces:
>
>  for i in $*
>  do
>     git checkout HEAD -- "$i"
>  done

"$@" notation actually handles spaces just fine.  It's magic that way.
 On the other hand, "for i in $*" does not, because all the spaces get
split as part of the unquoted $* in "for".  Beware!

>  I still think it would be nice this as a built-in for "git
>  revert-file" since this is much easier to type than "git checkout HEAD
>  -- " (all those characters and capital letters).  But if it ends up
>  being a private shell script for people who do this a lot, that's also fine.

How about making "git checkout" default to HEAD if no revision is
supplied?  There's precedent for this in, say, git-diff (and I think a
few others).

Incidentally, "checkout <filename>" was also the way to do a revert
operation in CVS.  And the way to switch branches, too, iirc.  So git
isn't being too unusual here.  That said, the commands were
deliberately renamed in svn because CVS was considered largely insane.

Have fun,

Avery
