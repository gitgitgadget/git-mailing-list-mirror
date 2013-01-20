From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] git rm -u
Date: Sun, 20 Jan 2013 12:32:14 +0100
Message-ID: <vpq622s9jk1.fsf@grenoble-inp.fr>
References: <50FB1196.2090309@gmail.com> <20130119214921.GE4009@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric James Michael Ritz <lobbyjones@gmail.com>,
	git@vger.kernel.org, Tomas Carnecky <tomas.carnecky@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 12:32:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Twt8h-0003NU-0v
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 12:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887Ab3ATLcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 06:32:18 -0500
Received: from mx1.imag.fr ([129.88.30.5]:45734 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751809Ab3ATLcR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 06:32:17 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r0KBWD3g001890
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 20 Jan 2013 12:32:13 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Twt8I-0004g1-OR; Sun, 20 Jan 2013 12:32:14 +0100
In-Reply-To: <20130119214921.GE4009@elie.Belkin> (Jonathan Nieder's message of
	"Sat, 19 Jan 2013 13:49:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 20 Jan 2013 12:32:13 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0KBWD3g001890
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1359286334.74339@Z5msNIem+ylZIIPP4S0drg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214007>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Eric James Michael Ritz wrote:
>
>> When I came to my senses and realized that does not work I began to
>> wonder if `git rm -u` should exist.  If any deleted, tracked files are
>> not part of the index to commit then `git rm -u` would add that change
>> to the index.
>
> I like it.  If you have time to write such a patch, I'll be happy to
> read it.

I can leave with "git add -u", but a "git rm -u" that would only look at
deletions, and not stage existing files changes would make sense.

One thing to be careful about is what to do when the command is called
from a subdirectory. In general, Git commands use this convention:

* git foo   => tree-wide command
* git foo . => restrict to current directory

"git add -u" is one of the only exceptions (with "git grep"). I consider
this as a bug, and think this should be changed. This has been discussed
several times here, but no one took the time to actually do the change
(changing is easy, but having a correct migration plan wrt backward
compatibility is not).

Implementing "git rm -u" as a tree-wide command would create a
discrepancy with "git add -u". Implementing it as a "current directory"
command would make the migration harder if we eventually try to change
"git add -u". Perhaps "git rm -u" should be forbidden from a
subdirectory (with an error message pointing to "git rm -u :/" and "git
rm -u ."), waiting for a possible "git add -u" change.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
