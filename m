From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/17] revert: Rename no_replay to record_origin
Date: Sun, 17 Jul 2011 14:36:57 -0500
Message-ID: <20110717193657.GJ27787@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-5-git-send-email-artagnon@gmail.com>
 <20110712170256.GC13578@elie>
 <CALkWK0nm-gX9-3pGxT31VO-06mimd0cg1O8xhk-0QbsbdN7aLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 17 21:37:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiX9M-0005Sx-A7
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 21:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756261Ab1GQThF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jul 2011 15:37:05 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48930 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756240Ab1GQThE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 15:37:04 -0400
Received: by iyb12 with SMTP id 12so2550260iyb.19
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 12:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=uu/lnO22PSxE98sfgSOu2Bz7m2cIiVGg7CNuDijeDlQ=;
        b=NxYLRYPcgRBo13zbArKG27SZXhltpRiFWW+A5OprkqYigVLKAoCaxAjHyIcRBA6rfD
         CW8JXXEGFB/MZ+93UvX24FjLIiJXW3V61rMlXsF7cZ0hhGhUWxhH46cOI3+X5ZT4+kGe
         RvHtPj87iwEo9QSJpJMJA4ICgEIKg0bbZwdFk=
Received: by 10.42.28.10 with SMTP id l10mr6871376icc.299.1310931423430;
        Sun, 17 Jul 2011 12:37:03 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.ameritech.net [69.209.70.6])
        by mx.google.com with ESMTPS id k16sm4028046icc.10.2011.07.17.12.37.00
        (version=SSLv3 cipher=OTHER);
        Sun, 17 Jul 2011 12:37:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0nm-gX9-3pGxT31VO-06mimd0cg1O8xhk-0QbsbdN7aLg@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177316>

Ramkumar Ramachandra wrote:

> Thanks for probing.  Found out the reason after some digging.
>
> revert: Rename no_replay to record_origin
>
> The "-x" command-line option is used to record the name of the
> original commits being picked in the commit message.  The variable
> corresponding to this option is named "no_replay" for historical
> reasons.

Heh.  I guess "for crazy historical reasons no one remembers, and it's
especially confusing because the term 'replay' is used to describe
from time to time to describe what cherry-pick does (e.g., in the
documentation for the --mainline option)" would be enough of a summary
to justify the change.

> This name was introduced in f810379 (Make builtin-revert.c
> use parse_options, 2007-10-07) to replace "replay", the opposite of
> "no_replay".  The name "replay" was introduced in 9509af6 (Make
> git-revert & git-cherry-pick a builtin, 2007-03-01).

It's actually older than that: it comes from the scripted version:

	-x|--i-really-want-to-expose-my-private-commit-object-name)
		replay=
		;;

>From v1.4.3-rc2~12 (cherry-pick: make -r the default, 2006-10-05;
it's of course older than that), we learn that this used to be the
default, disabled by a --replay option that meant

	Usually the command appends which commit was
	cherry-picked after the original commit message when
	making a commit.  This option, '--replay', causes it to
	use the original commit message intact.  This is useful
	when you are reordering the patches in your private tree
	before publishing.

or in other words, "simulate making the commit anew again, instead
of explicitly recording that this is a new commit based on that
old one".

In other words, "replay" originally essentially meant what
"cherry-pick" does now.

Thanks, that was interesting.

Cheers,
Jonathan
