From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 1/2] reset: handle submodule with trailing slash
Date: Wed, 11 Sep 2013 19:22:33 +0100
Message-ID: <20130911182233.GW2582@serenity.lan>
References: <cover.1378840318.git.john@keeping.me.uk>
 <c7e026f44f9ccbf5736b72e728a360b31887a50f.1378840318.git.john@keeping.me.uk>
 <52300838.5040703@kdbg.org>
 <20130911082042.GR2582@serenity.lan>
 <CACsJy8BgEM3eEDo8wOgkqYTL1fkh9azZNqbogxBubp9g5KRNbQ@mail.gmail.com>
 <xmqqwqmnthfh.fsf@gitster.dls.corp.google.com>
 <20130911172705.GV2582@serenity.lan>
 <xmqq8uz3tece.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 20:22:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJp3x-0001iD-77
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 20:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300Ab3IKSWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 14:22:45 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:38105 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543Ab3IKSWo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 14:22:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 4317A6064CC;
	Wed, 11 Sep 2013 19:22:44 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lBMvNIMnG+eO; Wed, 11 Sep 2013 19:22:43 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 43BA26064F3;
	Wed, 11 Sep 2013 19:22:43 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 37A50161E0AD;
	Wed, 11 Sep 2013 19:22:43 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WrGgaPBgC5oq; Wed, 11 Sep 2013 19:22:42 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 7DC78161E4A0;
	Wed, 11 Sep 2013 19:22:35 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqq8uz3tece.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234591>

On Wed, Sep 11, 2013 at 11:14:57AM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > On Wed, Sep 11, 2013 at 10:08:18AM -0700, Junio C Hamano wrote:
> >> Duy Nguyen <pclouds@gmail.com> writes:
> >> 
> >> > reset --soft does not go through these code paths (i.e. it does not
> >> > need index at all). If we fail to load index index in "reset --soft" I
> >> > think it's ok to die(). Corrupt index is fatal anyway.
> >> 
> >> Do I smell a breakage here?  Isn't "reset --soft HEAD" (or some
> >> known good commit) a way to recover from a corrupt index?
> >> 
> >> If that is the case, I do not think it is OK at all.  What do we
> >> suggest as an alternative?  "rm .git/index && read-tree"?
> >
> > Duy's suggestion below is necessary to avoid this then I think - we'll
> > die if the user has a corrupt index and gives a path with a trailing
> > slash, but without that path we won't try to load the index.
> 
> Sorry, but I don't quite follow.  Isn't "git reset --soft <path>" a
> nonsense, with or without a trailing slash at the end of <path>?

Yes, but my point was that providing the user doesn't give a path with a
trailing slash we will get past the option parser if we take the
approach below.

However, I think we do do a read_cache when using "reset --soft" since
we go through builtin/reset.c::die_if_unmerged_cache() which dies if
read_cache fails.  So I don't think we are losing anything by moving
this check earlier.

> >> > But "reset
> >> > --soft" now has to pay the cost to load index, which could be slow
> >> > when the index is big. Assuming nobody does "reset --soft" that often
> >> > I think this is OK.
> >> >
> >> > Alternatively we could load index lazily in _CHEAP code only when we
> >> > see trailing slashes, then replace these read_cache() with
> >> > read_cache_unless_its_already_loaded_earlier() or something.
