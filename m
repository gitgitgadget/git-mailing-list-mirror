From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Wed, 19 Dec 2012 14:12:56 +0100
Message-ID: <87ip7yp4mf.fsf@pctrast.inf.ethz.ch>
References: <20121211153903.7522d6b0@chalon.bertin.fr>
	<7vd2yg8ngk.fsf@alter.siamese.dyndns.org>
	<20121212094432.6e1e48c8@chalon.bertin.fr>
	<7v38zb3ux0.fsf@alter.siamese.dyndns.org>
	<877goht6eu.fsf@pctrast.inf.ethz.ch>
	<20121217114058.449cbc3c@chalon.bertin.fr>
	<CAP8UFD2pkotNy=t5wTxDH-pMivQsTz-kw2y8Y7rWY42YKabp7g@mail.gmail.com>
	<m21ueo78f8.fsf@igel.home> <7vwqwgjs8f.fsf@alter.siamese.dyndns.org>
	<20121218120058.0c558ba5@chalon.bertin.fr>
	<7vehinibpc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Yann Dirson <dirson@bertin.fr>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Christian Couder <christian.couder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	git list <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 14:13:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlJSc-0005KG-5f
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 14:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723Ab2LSNNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 08:13:04 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:29934 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752327Ab2LSNNB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 08:13:01 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 19 Dec
 2012 14:12:52 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 19 Dec 2012 14:12:57 +0100
In-Reply-To: <7vehinibpc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 18 Dec 2012 08:09:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211818>

Junio C Hamano <gitster@pobox.com> writes:

> I do not understand why you even want to go in the harder route in
> the first place, only to complicate things?
>
> All you want to do is to craft a commit object that records a
> specific tree shape, has a set of parents you want, and has the log
> information you want.  Once you have the commit, you can replace an
> unwanted commit with it.
[...]
>     $ git checkout X^0 ;# detach
>     $ git reset --soft A
>     $ git commit -C X
[...]
> Is this not intuitive enough?

I still wouldn't recommend this approach in git-replace(1) for several
reasons:

* It does not generalize in any direction.  For each field you may want
  to change, you have to know a _specific_ way of getting just the
  commit you want.

* More to the point of replacing the parent lists, while the above might
  be expected of a slightly advanced git user, you get into deep magic
  the second you want to fake a merge commit with an arbitrary
  combination of parents.  (No, you don't need to tell me how.  I'm just
  saying that fooling with either MERGE_HEAD or read-tree is not for
  mere mortals.)

* The above potentially introduces clock skew into the repository, which
  can trigger bugs (like rev-list accidentally missing out on some side
  arm!) until we get around to implementing and using generation
  numbers.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
