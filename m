From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Reproducible, corrupt packfile after fresh git-svn checkout
Date: Thu, 08 Aug 2013 14:38:16 +0200
Message-ID: <vpqpptofjd3.fsf@anie.imag.fr>
References: <52037F47.5010302@exxcellent.de> <52037F84.9060006@exxcellent.de>
	<f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost>
	<877gfw4byx.fsf@linux-k42r.v.cablecom.net>
	<262a9f8309a3812970f47ac9f4e4b49bb972ca49@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: gitml.jexpert@recursor.net
X-From: git-owner@vger.kernel.org Thu Aug 08 14:38:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7PU7-0008Kj-Cp
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 14:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757816Ab3HHMi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 08:38:27 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43830 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757783Ab3HHMi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 08:38:26 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r78CcFFM012510
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 8 Aug 2013 14:38:16 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V7PTs-0005vA-Mb; Thu, 08 Aug 2013 14:38:16 +0200
In-Reply-To: <262a9f8309a3812970f47ac9f4e4b49bb972ca49@localhost> (gitml
	jexpert's message of "Thu, 08 Aug 2013 14:23:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 08 Aug 2013 14:38:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r78CcFFM012510
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1376570298.47293@yac019JXjiXH9cEWODc4jw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231877>

gitml.jexpert@recursor.net writes:

>> Regardless of any possible fault in git-svn, there's an obvious bug here
>> with git-fsck.  Can you share the pack (if the project is public) or
>> compile a git-fsck without optimization and with debugging, and run it
>> under valgrind, to hopefully get us a backtrace of where the memory
>> management goes off the rails?
>
> Unfortunately I'm unable to share the pack.
>
> As Java Developer I'm note very savy, but I'd try.
> Do you have me any pointers on ".. without optimization and with
> debugging" and "run it under valgrind"?

To fetch sources and compile:

  git clone https://github.com/git/git.git
  cd git/
  make CFLAGS='-g -O0'

To run gdb:

  gdb --args ./git fsck

Then type "run" at the gdb prompt. When the program crashes, you should
get the gdb prompt back. Then, typing "bt" gives you a backtrace, and
"bt full" gives you the same with more information (be careful, there
may be private information in it).

To use valgrind, just do:

  valgrind ./git fsck

(essentially, it runs the program adding a bunch of runtime checks hence
may provide better diagnosis)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
