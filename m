From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Wed, 06 Feb 2013 16:10:12 +0100
Message-ID: <vpqmwvhxyuj.fsf@grenoble-inp.fr>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<7v6226pdb7.fsf@alter.siamese.dyndns.org>
	<vpqa9rhaml6.fsf@grenoble-inp.fr> <876225o5mj.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michal Nazarewicz <mpn@google.com>, git@vger.kernel.org,
	Krzysztof Mazur <krzysiek@podlesie.net>,
	Michal Nazarewicz <mina86@mina86.com>
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 16:11:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U36f7-0005X6-Mj
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 16:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754987Ab3BFPL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 10:11:27 -0500
Received: from mx1.imag.fr ([129.88.30.5]:53754 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754132Ab3BFPL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 10:11:26 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r16FABbA027055
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 6 Feb 2013 16:10:11 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U36dZ-0002Ns-3L; Wed, 06 Feb 2013 16:10:13 +0100
In-Reply-To: <876225o5mj.fsf@lifelogs.com> (Ted Zlatanov's message of "Wed, 06
	Feb 2013 09:53:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 06 Feb 2013 16:10:12 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r16FABbA027055
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1360768213.88971@pBJNPKJlhcXYHTNhGHNLeA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215587>

Ted Zlatanov <tzz@lifelogs.com> writes:

> MM> [...] so the way to go for send-email is probably to libify the
> MM> credential support in git-remote-mediawiki, and to use it in send-email.
>
> I looked and that's indeed very useful.  If it's put in a library, I'd
> use credential_read() and credential_write() in my netrc credential
> helper.  But I would formalize it a little more about the token names
> and output,

Can you elaborate on this? The idea of the Perl code was to mimick a
call to the C API, keeping essentially the same names.

> and I wouldn't necessarily die() on error. 

Sure, die()ing in a library is bad.

> Maybe this can be merged with the netrc credential helper's
> read_credential_data_from_stdin() and print_credential_data()?

I don't know about the netrc credential helper, but I guess that's
another layer. The git-remote-mediawiki code is the code to call the
credential C API, that in turn may (or may not) call a credential
helper.

> Let me know if you'd like me to libify this...  I'm happy to leave it to
> Matthieu or Michal, or anyone else interested.

I'd happily let you do the job, but I can help if needed. One thing to
be careful about: git-remote-mediawiki is currently a standalone script,
so it can be installed with a plain "cp git-remote-mediawiki $somewhere/".
One consequence of libification is that it adds a dependency on the
library (e.g. Git.pm). We should be carefull to keep it easy for the
user to install it (e.g. some kind of "make install", or update the doc).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
