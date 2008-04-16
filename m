From: "Brian Foster" <brian.foster@innova-card.com>
Subject: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Wed, 16 Apr 2008 17:04:56 +0200
Message-ID: <a537dd660804160804t252d2900j33e30a01dc58979c@mail.gmail.com>
References: <200804161626.44174.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Dmitry Potapov" <dpotapov@gmail.com>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 16 17:06:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm9Cn-000055-VL
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 17:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763410AbYDPPE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 11:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754384AbYDPPE6
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 11:04:58 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:19587 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757374AbYDPPE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 11:04:58 -0400
Received: by wr-out-0506.google.com with SMTP id c48so1372735wra.1
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 08:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=BIZhlZLcCe9nyUuCXgv1grtum2WWSdI670BN2IfbQuI=;
        b=M+OVr7w8KQS6OocoGea4tHA43zD+3ePdug6eKcQ2S3CjQKSWFHo9P2yFNBu1xd5pj/r0fGMRrcHWXmUtK4F1oNL06imS8u3KSdkEYnJfBrfD8acba2FjMHsm49X2UGxBmpgSBQWFUc0AQXT4mLmTN4RsCoJNJMcg/NE/H4Q8rbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=QbIcaG/wKC8wwLS/qCQHXlFaY08dL0deFDEzipqbCkaMuyBcENk45xqzBdBeNY08abYcv/0zlX25nzXuSd0hJe/oWEhocNe5O1kYQZxoFXWLo9tjH4HUPe7Z9RCYFi9WFewM+uzHrOc7hWm2y8K6bK8qsDYxpA4KjCSDWPNJLxU=
Received: by 10.141.168.7 with SMTP id v7mr68886rvo.118.1208358296181;
        Wed, 16 Apr 2008 08:04:56 -0700 (PDT)
Received: by 10.141.123.21 with HTTP; Wed, 16 Apr 2008 08:04:56 -0700 (PDT)
In-Reply-To: <200804161626.44174.brian.foster@innova-card.com>
Content-Disposition: inline
X-Google-Sender-Auth: be2b2ed2c029bdd4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79710>

Johannes Sixt <j.sixt@viscovery.net> helpfully observes:
>  Brian Foster schrieb:
>  > Dmitry Potapov <dpotapov@gmail.com> correctly deduced:
>  >>  I suspect your original git repository has info/grafts
>  >  bingo!  YES, it does:
>[ ... ]
>  >  the goal is to put things into a sane state so any new
>  >  clones are healthy.  there's only one(?) existing clone,
>  >  which may or may not be(? become?) an issue.
>
>  Just move info/grafts out of the way and you *may* be all set. Don't
>  delete it - there might be a reason that the file exists.

Hannes & Dmitry,

 thanks for the suggestions.  I've made (and carefully protected)
 multiple backups, and am doing all my experiments on copies, and
 have taken other protective steps, so no worries about accidents.

 moving  info/grafts  out of the way causes `fsck --full' to issue
 the same complaints as it does for clones.  conversely, copying
 info/grafts  to a clone makes `fsck --full' happy.  furthermore,
 close examination of that one pre-existing clone shows it has the
 identical  info/grafts  as the bare repository.  so that seems to
 have been what was previously being done (I'm now attempting to
 confirm this, and also to find out WHY).

 however, no joy at all with the suggestion:

>  Your best bet is to run 'git filter-branch --tag-name-filter cat -- --all'
>  on *a copy* of your bare repository (with info/grafts in place).  [ ... ]

 at toplevel of (a copy of) the bare repository, with  info/grafts
 in-place, and `fsck --full' happy:

	$ git version
	1.5.3
	$ git filter-branch --tag-name-filter cat -- --all   # at bare toplevel
	fatal: Not a git repository: '.git'
	You need to run this command from the toplevel of the working tree.
	$

 at toplevel of a (not-bare) clone, with  info/grafts  in-place,
 and a happy `fsck -full' (same machine so same git version):

	$ git filter-branch --tag-name-filter cat -- --all  # at not-bare toplevel
	Rewrite 7df30811617517bc4d5ec7c190a435667228320c (168/168)
	Ref 'refs/heads/master' was rewritten
	Ref 'refs/remotes/origin/HEAD' was rewritten
	WARNING: Ref 'refs/remotes/origin/master' is unchanged
	Ref 'refs/tags/linux-2.6.15' was rewritten
	error: Ref refs/tags/linux-2.6.15 is at \
		26a33413c95dfda6c70ca4a83da49cddb7b236b9 but expected \
		2dcaaf2decd31ac9a21d616604c0a7c1fa65d5a4
	fatal: refs/tags/linux-2.6.15: cannot lock the ref
	Could not rewrite refs/tags/linux-2.6.15
	$

 in the later case, the  info/grafts  still existed at the end,
 and `fsck --full' was happy.  (I suppose this isn't surprising
 since the filter-branch was not happy.)   moving  info/grafts
 out of the way caused the same complaints from `fsck --full'.

 the missing commits are all(? mostly?) similar to this example:

	$ git remote
	origin
	$ git remote show origin
	* remote origin
	  URL: git://git.kernel.org/pub/scm/linux/kernel/git/ralf/linux.git
        [ ... ]
	$ git show dff364d8da
	commit dff364d8da15be0b856a174062fb785acb1c363e
	Merge: bc59a40... 427abfa...
	Author: Ralf Baechle <ralf@linux-mips.org>
	Date:   Sun Jun 18 03:42:49 2006 +0100
	
	    Merge tag 'v2.6.17' of
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
	
	$

 as such, is there some way of adding them back to the bare
 repository (if that even makes sense?), or whatever?  (i.e.,
 that have not been lost, is it possible to take advantage
 of that fact?)

 also (sorry!), does anyone recognise the development process
 that apparently was used?  (the one pre-existing clone has
 few-to-no clews, since it was used for some fairly trivial
 local development, not for the "merging" (if I can call it
 that) with linux-mips repository.)

cheers!
	-blf-

-- 
"How many surrealists does it take to    |  Brian Foster
 change a lightbulb?  Three.  One calms  |  somewhere in south of France
 the warthog, and two fill the bathtub   |     Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools."  |       http://www.stopesso.com
