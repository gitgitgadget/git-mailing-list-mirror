From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 2/2] trailer: support multiline title
Date: Wed, 26 Aug 2015 18:15:11 +0200
Message-ID: <vpqpp2akovk.fsf@anie.imag.fr>
References: <1440557461-1078-1-git-send-email-chriscool@tuxfamily.org>
	<1440557461-1078-2-git-send-email-chriscool@tuxfamily.org>
	<vpqa8tetwfi.fsf@anie.imag.fr>
	<CA+P7+xqaAKckB0P5oqFS64BWU2H1OsVX8Oq=CLLW8PMJ5fdenQ@mail.gmail.com>
	<CAP8UFD2x8i5wC9JP8d1zAH=d-2BMYWAvpaFmWnu09N5QSG==TA@mail.gmail.com>
	<xmqqk2siujak.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 18:15:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUdMN-0006OI-Ii
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 18:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757195AbbHZQPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 12:15:24 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43359 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752842AbbHZQPX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 12:15:23 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t7QGFAoZ004503
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 26 Aug 2015 18:15:10 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7QGFBv0004451;
	Wed, 26 Aug 2015 18:15:11 +0200
In-Reply-To: <xmqqk2siujak.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 26 Aug 2015 09:05:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 26 Aug 2015 18:15:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7QGFAoZ004503
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441210514.41109@RlTpr6hIoscnf5n2DqQoBw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276616>

Junio C Hamano <gitster@pobox.com> writes:

> While the reordering would certainly stop showing the comments and
> patch, I am not sure if that is a move in the right direction.  It
> will rob from the hooks information that they have traditionally
> been given---

The information given in the comments do not have a 100% stable format,
and the hook is executed after letting the user possibly edit or delete
it, so I'm tempted to say that a hook using the commit comment is
broken.

Using the diff in the hook _is_ really broken: it relies on the user
calling "git commit" with -v, and there's nothing to garantee that.

> it will break some hooks.

It will also repair some hooks that were broken, but whose breakage was
never noticed or never explained.

> After all, interpret-trailers was invented exactly because we did not
> want individual hooks to roll their own ways to detect the end of the
> message proper, so the command should know where the message ends.

Right, but you can't prevent people from writting

command-that-shows-stuff >> "$1"

in their commit-msg hook. And these people will keep wondering why their
hook "sometimes doesn't work" (that's how I considered it for a while,
it took me a few commits to notice the correlation between "-v" and lack
of sign-off).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
