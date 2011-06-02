From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] Added a remote helper to interact with mediawiki, pull & clone handled
Date: Fri, 03 Jun 2011 00:37:04 +0200
Message-ID: <vpqy61jami7.fsf@bauges.imag.fr>
References: <1307006911-4326-1-git-send-email-arnaud.lacurie@ensimag.imag.fr>
	<20110602170327.GA2928@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	git@vger.kernel.org,
	=?iso-8859-1?Q?J=E9r=E9mie?= Nikaes 
	<jeremie.nikaes@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Sylvain =?iso-8859-1?Q?Boulm=E9?= <sylvain.boulme@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 03 00:37:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSGW5-0002cF-FE
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 00:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458Ab1FBWhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 18:37:18 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41821 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903Ab1FBWhR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 18:37:17 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p52Mb2mr004570
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 3 Jun 2011 00:37:02 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QSGVl-0000VQ-AW; Fri, 03 Jun 2011 00:37:05 +0200
In-Reply-To: <20110602170327.GA2928@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 2 Jun 2011 13:03:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 03 Jun 2011 00:37:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p52Mb2mr004570
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1307659024.88239@eZ1dq5rsz9RQJl6TexUG9Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174982>

Jeff King <peff@peff.net> writes:

> Overall, it's looking pretty good. I like that I can resume a
> half-finished import via "git fetch". Though I do have one complaint:
> running "git fetch" fetches the metainfo for every revision of every
> page, just as it does for an initial clone. Is there something in the
> mediawiki API to say "show me revisions since N" (where N would be the
> mediawiki revision of the tip of what we imported)?

The idea is that we ultimately want to be able to import a subset of a
large wiki. In Wikipedia, for example, "show me revisions since N" will
be very large after a few minutes. OTOH, "show me revisions touching the
few pages I'm following" should be fast. And at least, it's O(imported
wiki size), not O(complete wiki size)

Ideally, there could be heuristics like

"show me how many revisions since N"
if (not many) {
    "OK, show me them all in details"
} else {
    "hmm, we'll do it another way, show me revisions touching my pages"
}

but let's not be too ambitious for now: it's a student's project,
completing one week from now, and the goal is to have something clean
and extensible. Bells and whistles will come later ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
