From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH] Fast forward strategies only, common, fork and path
Date: Mon, 4 Feb 2008 23:32:45 -0800
Message-ID: <402c10cd0802042332i4e49cdaxf1fa1a7fc09c15b9@mail.gmail.com>
References: <402c10cd0802031654r3e0275a8s1d2163af9525e7d2@mail.gmail.com>
	 <402c10cd0802032251y626f373eke66c35b200ccf5b1@mail.gmail.com>
	 <7vwsplkwuq.fsf@gitster.siamese.dyndns.org>
	 <402c10cd0802040006yb654688l8dfc7140c507bc26@mail.gmail.com>
	 <7v8x21ku6b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 08:33:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMIJ0-0001yD-6G
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 08:33:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbYBEHcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 02:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753424AbYBEHcs
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 02:32:48 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:18358 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbYBEHcr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 02:32:47 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2147310fga.17
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 23:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=45Bw8SF8EtqVoULzTBD8Oo3fcKls1fabeiDpRK5KBBM=;
        b=e8UxusIp551HWURu7Yd4MdPm3aKZRHoIEcMV3ChA953A/RlUfwYcEEduljdrU8Lg1JEWH4FsrtI9DPpmHVKOEqRrcm+XDtnkx0Y2eyxjBjHCGKKGKvP5YbJcpiJh9hvT8LsLcPnO0swsUyq0WMEgfxTFV8jLrDhXugviTR6CcVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=xSkmxawV/fLJBin/1qCoflW4k7RUB36ne7OD+sm10Otq2X5CYuLJ0Nkp5cXJTwCkzgPuS+2yfBdfJmVo1W0o9+D7L1wKfQldy51DIm0oFAGEXb2QGRttmWkUmv8AWKvG72JXIJUJ7nPTaF57+TNAEMq/UnTiC4/vyymGbfgWI7s=
Received: by 10.82.155.10 with SMTP id c10mr14791091bue.39.1202196765990;
        Mon, 04 Feb 2008 23:32:45 -0800 (PST)
Received: by 10.82.156.13 with HTTP; Mon, 4 Feb 2008 23:32:45 -0800 (PST)
In-Reply-To: <7v8x21ku6b.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72631>

On Feb 4, 2008 12:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> The documentation updates talked about what the options do, but
> it was unclear why they could be useful in what situations and
> workflows.  At least it was not apparent to me on my cursory
> read.

Common, fork, and path only make sense where there are at least three
repositories or two plus an observer involved.

Lets explain the observer cases.

The observer is interested in changes that X, Y and Z agree upon.  He
can merge as follows:

  git merge --ff=common X Y Z

The observer is interested in changes up to the point where someone is
known to disagree.  He can merge as follows:

   git merge --ff=fork X Y Z

 The observer is interested in any give path up to one of the true
parents.  He can merge as follows:

  git merge --ff=path X Y Z

This will give priority to X then Y.

This + only are all the interesting cases for fast forward.  Some work
flows between more than two repositories in the general case would
require additional features for rebase:  Rebase on any patch, the fork
point, or common ancestor of the remote branches.  This is something I
would like to discuss at some later time.

> > --ff=never will turn this off together with fast forward.  Maybe we
> > should have --ff=traditional that is the old behavior.
>
> Sure, and I mildly suspect that it should be the default.

I would argue that it should not be the default, simply because we
already use the real parents when only two branches are involved, This
is most convenient for most users.   Exactly the same argument holds
when there are more than two branches involved.  The history may be
simplified in a similar way.   Most projects would however not care
simply because they never merge more than two branches.   It is quite
common to have one topic branch that is based on the tip of another
topic branch and if those are merged back to the main branch you would
like it to be reduced down to two real heads (or even a fast forward),
exactly as one branch would result in a fast forward if it happened to
be based on the tip of master.

-- 
Sverre Hvammen Johansen
