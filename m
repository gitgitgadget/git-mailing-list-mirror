From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RCF/PATCH] Makefile: move 'ifdef DEVELOPER' after config.mak* inclusion
Date: Wed, 01 Jun 2016 09:57:20 +0200
Message-ID: <vpqpos11gv3.fsf@anie.imag.fr>
References: <20160531132443.5033-1-Matthieu.Moy@imag.fr>
	<20160601073037.GA14096@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lars Schneider <larsxschneider@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 01 09:57:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8126-0005xH-2j
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 09:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbcFAH5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 03:57:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50418 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842AbcFAH5h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 03:57:37 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u517vKkF019706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 1 Jun 2016 09:57:20 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u517vKwE015268;
	Wed, 1 Jun 2016 09:57:21 +0200
In-Reply-To: <20160601073037.GA14096@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 1 Jun 2016 03:30:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Wed, 01 Jun 2016 09:57:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u517vKkF019706
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465372642.28427@9yjsy36mZIzlAxRJyBssow
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296064>

Jeff King <peff@peff.net> writes:

> Hmm. So I think this does fix some issues, but it also means that one's
> config.mak cannot use DEVELOPER as a base and then override particular
> flags.

You mean, using "make DEVELOPER=1" and then tweak CFLAGS in config.mak?

Well, you still can do "CFLAGS += ..." (the extra CFLAGS will come
before the ones added by DEVELOPER instead of after), which should cover
99% use-cases.

You can't do "CFLAGS = $(filter-out ..., $(CFLAGS))" anymore indeed. But
if you are at that level of customization, I'd say DEVELOPER isn't for
you and you should just set CFLAGS directly.

Not really serious, but we can fix that easily. Patch follows.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
