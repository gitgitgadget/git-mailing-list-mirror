From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] fix overslow :/no-such-string-ever-existed diagnostics
Date: Tue, 10 May 2011 22:41:25 +0200
Message-ID: <vpqfwomffuy.fsf@bauges.imag.fr>
References: <7vhb92jujt.fsf@alter.siamese.dyndns.org>
	<7vzkmuidk1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 22:41:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJtkQ-0005tb-L7
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 22:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702Ab1EJUld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 16:41:33 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51655 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225Ab1EJUlc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 16:41:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p4AKfN4q017537
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 10 May 2011 22:41:23 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QJtkD-0004nX-Mu; Tue, 10 May 2011 22:41:25 +0200
In-Reply-To: <7vzkmuidk1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 10 May 2011 12:02:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 10 May 2011 22:41:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p4AKfN4q017537
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1305664885.83267@mlgy8nVtk/CmXIUxMV6EBw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173361>

Junio C Hamano <gitster@pobox.com> writes:

> On my box, the command spends ~1.8 seconds without the patch to make the
> report; with the patch it spends ~1.12 seconds.

Nice improvement.

>  * Yes, we often say "this is an error path and paying the price in
>    performance for a better diagnosis is worth", and it is correct.
>    But it is not an excuse to spend unnecessary cycles.

Right. When I introduced the second call with gently=0, I was thinking
of cases where the function is fast, but :/blah has to walk through
history, and we don't want that twice (especially since the conclusion
is to give generic and not-so-helpfull message!).

>    We may want to add a guard at the beginning of die_verify_filename() to
>    omit the extra call to get_sha1_with_mode_1(only_to_die=1) when arg
>    looks like a magic pathspec, i.e. ":" followed by anything !isalnum().

Is this a complement or an alternative? It seems to me that your other
patch makes this first one useless (in the sense that the second call is
always cheap), and avoids complexifying the code of get_sha1_with_mode_1
for the first call.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
