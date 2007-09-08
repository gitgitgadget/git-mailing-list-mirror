From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] HEAD, ORIG_HEAD and FETCH_HEAD are really special.
Date: Sun, 9 Sep 2007 00:20:59 +0200
Message-ID: <20070908222059.GA5035@steel.home>
References: <1189115308.30308.9.camel@koto.keithp.com> <7vsl5r8jer.fsf@gitster.siamese.dyndns.org> <1189133898.30308.58.camel@koto.keithp.com> <7vd4wu67qs.fsf_-_@gitster.siamese.dyndns.org> <46E145BF.4070403@eudaptics.com> <20070907124253.GB27754@artemis.corp> <7vabry43cg.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Johannes Sixt <j.sixt@eudaptics.com>,
	Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 00:24:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IU8il-000107-1N
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 00:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684AbXIHWVG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 18:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753868AbXIHWVF
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 18:21:05 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:54135 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbXIHWVE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 18:21:04 -0400
Received: from tigra.home (Fae2f.f.strato-dslnet.de [195.4.174.47])
	by post.webmailer.de (klopstock mo54) (RZmta 12.9)
	with ESMTP id N02830j88M2F8I ; Sun, 9 Sep 2007 00:21:00 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id BCD8B277BD;
	Sun,  9 Sep 2007 00:21:00 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 2B857BF13; Sun,  9 Sep 2007 00:20:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vabry43cg.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz1E31xFw==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58140>

Junio C Hamano, Fri, Sep 07, 2007 22:39:43 +0200:
> Pierre Habouzit <madcoder@debian.org> writes:
> 
> > I'd have added though that maybe update-ref should print a warning for
> > the references that do not match the restriction Junio added. This could
> > be done using the function Junio proposed un update_ref() in refs.c
> 
> I would even suggest making it into an error, even if we do not
> error out on the reading side (being liberal when reading but
> more strict when creating, that is).

I agree (and suggest failing even on reading), but see below

> That confused_ref() needs to be tightened further, by the way.
> It is called only when we are considering to tack the user
> string immediately below $GIT_DIR/ so the only valid cases are
> (1) the string begins with "refs/",

If that will be the case git-p4-import.bat (yes, just a script of
mine) will break because it has its namespace directly in $GIT_DIR
(i.e. .git/p4/*) and stores there backup references. It is just a
someones (ok, it is mine) script, but maybe there are others, who
expect that plumbing level git-update-ref just do what its told.

> or (2) the string is all uppercase (or underscore), especially
> without slash.

I'd suggest just check for uppercase+underscore _or_ slash. It is
plumbing after all.
