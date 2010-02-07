From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Sun, 07 Feb 2010 02:48:03 +0100
Message-ID: <201002070248.03855.johan@herland.net>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com>
 <cb7bb73a1002061458s5b2c1e7ere83111429473d11c@mail.gmail.com>
 <201002070220.36897.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 03:01:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdwSK-0007ZC-Om
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 03:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406Ab0BGBsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 20:48:08 -0500
Received: from smtp.getmail.no ([84.208.15.66]:53606 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751139Ab0BGBsG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Feb 2010 20:48:06 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXG0041D7O5OA90@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 07 Feb 2010 02:48:05 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXG007UL7O44C20@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 07 Feb 2010 02:48:05 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.7.13620
User-Agent: KMail/1.12.4 (Linux/2.6.32-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <201002070220.36897.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139209>

On Sunday 07 February 2010, Jakub Narebski wrote:
> On Sat, 6 Feb 2010, Giuseppe Bilotta wrote:
> > On the other hand, as mentioned by Junio, this approach is not
> > future-proof enough for any kind of fan-out schemes.
> 
> On the third hand ;-P you propose below a trick to deal with fan-out
> schemes, assuming that they use 2-character component breaking.

The current notes code (as it stands in 'pu') use only 2-character component 
breaking, and I don't see any other fanout mechanism being added anytime 
soon.

> Also, perhaps "git notes show" should acquire --batch / --batch-check
> options, similar to git-cat-file's options of the same name?

I'd much rather have support for ^{notes} (or similar) in the rev-parse 
machinery, so that you could look up deadbeef's notes by passing 
"deadbeef^{notes}" to 'git cat-file --batch'.

> > What worries me is that you're going to get fan-outs when there are
> > LOTS of notes, and that's precisely the kind of situation where you
> > _don't_ want to go through all the notes to pick the ones you're only
> > interested in.
> 
> Right.  This method would be contrary to the goals of fan-out schemes...
> well, we could use 'git ls-tree' without '-r' option, or simply
> 'git cat-file --batch' to read trees (note that we would get raw,
> unformatted tree, which is parseable with Perl, but it is not that easy),
> and go down level-by-level.

IMHO, it's much better/nicer to re-use the notes code for parsing note 
trees. See above suggestion on deadbeef^{notes}.

> > If we have a guarantee that the fan-outs follow a 2/[2/...] scheme,
> > the open2 approach might still be the best way to go, by just trying
> > not only namespace:xxxxx...xxx but also namespace:xx/xxxxx etc.
> > Horrible, but could still be coalesced in a single call. It mgiht also
> > be optimized to stop at the first successfull hit in a namespace.
> 
> Nice trick!  It seems like quite a good idea... but it would absolutely
> require using 'git cat-file --batch' rather than one git-show per try.

Still, I'd still much rather use the notes.c code itself for doing this 
since it should always be the fastest (not to mention future-proof) way of 
making lookups in the notes tree.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
