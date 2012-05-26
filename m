From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] Add possibility to store configuration in ~/.config/git/config file
Date: Sat, 26 May 2012 11:05:07 +0200
Message-ID: <vpqtxz3mhx8.fsf@bauges.imag.fr>
References: <1337975239-17169-1-git-send-email-nguyenhu@ensibm.imag.fr>
	<20120525203056.GC4364@sigill.intra.peff.net>
	<7vd35sq7fx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensimag.imag.fr>,
	git@vger.kernel.org,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 26 11:06:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYCwi-0004cA-BS
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 11:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730Ab2EZJFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 May 2012 05:05:23 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46825 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732Ab2EZJFV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 05:05:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4Q8v3Or010542
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 26 May 2012 10:57:03 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SYCvs-00041y-6C; Sat, 26 May 2012 11:05:08 +0200
In-Reply-To: <7vd35sq7fx.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 25 May 2012 14:25:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 26 May 2012 10:57:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4Q8v3Or010542
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1338627426.36193@j7mXzfMqViJajUVn9h/Iew
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198544>

Junio C Hamano <gitster@pobox.com> writes:

> If you read from .gitconfig and also from the new location, but update
> only the new location,

That's not exactly the proposal. First, I agree that the first questions
to be answered is what happens on reading. About writing, I don't feel
very strongly about it, but I think it's reasonable to write to the new
location if the old location doesn't exist, and the new one does. This
way, ~/.gitconfig haters will create their ~/.config/git/config, and
won't be bothered with the former.

Obviously, trying too hard to write to the new location would harm old
versions users, so for example, it would be unreasonable to write to the
new location unconditionally.

> people who use two versions of git will be in a very confusing
> situation. Randomly, some of their updates are always in effect,

Only if they created manually the new file. People unaware of the change
won't be affected at all.

Since most people don't read the docs, most people will be
unaffected ;-).

>  - If ~/.gitconfig exists, do not do anything new.  Just exercise the
>    original code.  For these users, ~/.config/ does _not_ exist as far as
>    Git is concerned.

As Jeff already pointed out, this would be very confusing for a user
having the new file, since running once "git config --global" with an
old version would shadow the whole configuration by creating an almost
empty ~/.gitconfig file.

We clearly want to read both. I'm not sure which should take precedence
when the same variable is defined in both.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
