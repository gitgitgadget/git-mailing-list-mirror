From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [RFC PATCH] cogito --- don't overwrite metadata files in place (breaks CoW use)
Date: Tue, 12 Jul 2005 21:53:38 -0700
Message-ID: <20050713045338.GA19819@taniwha.stupidest.org>
References: <20050712190552.GA7178@taniwha.stupidest.org> <loom.20050712T233332-364@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 06:54:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsZFo-000365-7m
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 06:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbVGMExs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 00:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbVGMExs
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 00:53:48 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:47835 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262540AbVGMExr
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 00:53:47 -0400
Received: from pimout2-ext.prodigy.net (pimout2-int.prodigy.net [207.115.4.217])
	by ylpvm43.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j6D4rleC016142
	for <git@vger.kernel.org>; Wed, 13 Jul 2005 00:53:47 -0400
X-ORBL: [63.202.173.158]
Received: from stupidest.org (adsl-63-202-173-158.dsl.snfc21.pacbell.net [63.202.173.158])
	by pimout2-ext.prodigy.net (8.13.4 outbound domainkey aix/8.13.4) with ESMTP id j6D4rd7N398584;
	Wed, 13 Jul 2005 00:53:44 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 03F01529BBC; Tue, 12 Jul 2005 21:53:39 -0700 (PDT)
To: Junio C Hamano <junkio@twinsun.com>
Content-Disposition: inline
In-Reply-To: <loom.20050712T233332-364@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 12, 2005 at 09:37:00PM +0000, Junio C Hamano wrote:

> >  if [ "$newhead" ]; then
> >  	echo "Committed as $newhead."
> > -	echo $newhead >$_git/HEAD
> > +	echo_to_file $newhead $_git/HEAD
> >  	[ "$merging" ] && rm $_git/merging $_git/merging-sym $_git/merge-base
>
> Good intentions, but wouldn't the above clobber symlinked HEAD?

Yeah, but I would argue that is the right thing to do.

Symlink'd trees don't really make sense to me (they seem fragile and
somewhat pointless) but perhaps I'm missing something?

> Not a fundamental flaw, though.  You need to see if it is a symlink,
> readlink it (repeatedly until you get a regular file or dangling
> symlink target that does not exist --- immediately after git-init-db
> has such a HEAD) and run your echo_to_file on the link target.

I don't see how that's helpful.  The idea of echo_to_file is to make
the metadata self-contained to the subtree --- so we don't want to
have external links (possibly) pointing outside of it.
