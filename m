From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] push: Correctly initialize nonfastforward in do_push.
Date: Wed, 16 Sep 2009 20:29:21 +0200
Message-ID: <vpqskemagla.fsf@bauges.imag.fr>
References: <1253119020-26547-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vpr9q24oa.fsf@alter.siamese.dyndns.org>
	<vpqfxamby33.fsf@bauges.imag.fr>
	<7vvdjizrgg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 20:29:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnzG4-00079S-Hw
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 20:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022AbZIPS31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 14:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753282AbZIPS30
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 14:29:26 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34585 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031AbZIPS3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 14:29:25 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n8GIQXXX027065
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 16 Sep 2009 20:26:33 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MnzFp-0004Aq-UZ; Wed, 16 Sep 2009 20:29:21 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MnzFp-0000HP-T3; Wed, 16 Sep 2009 20:29:21 +0200
In-Reply-To: <7vvdjizrgg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 16 Sep 2009 11\:15\:27 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 16 Sep 2009 20:26:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8GIQXXX027065
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1253730394.54865@Q/Eoheetym0LLIYUWNbOwA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128670>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Short answer: trust me, without the patch, you get the non-fast
>> forward (and valgrind tells you about conditional jump on
>> uninitialized value), with, you don't ;-).
>
> I understand valgrind one; I can trace the codepath with eyeballs without
> it, and that is why I said it looks correct to begin with.

(in case it wasn't clear, "you" in my message should have been read as
"one", no harm intended)

> My puzzlement was that the following in the log message did not seem to
> reproduce for me:
>     ... where "git push ... nonexisting-branch" was complaining about
>     non-fast forward.

It's comming from an uninitialized variable, so it may have worked
just "by chance". For me, it seems to do it reproducibly, with for
example:

$ mkdir repo
$ rm -rf repo/
$ git init repo
Initialized empty Git repository in /tmp/repo/.git/
$ cd repo; touch foo; git add .; git commit -m foo > /dev/null
$ git push . nonexisting-branch
error: src refspec nonexisting-branch does not match any.
error: failed to push some refs to '.'
To prevent you from losing history, non-fast-forward updates were rejected
Merge the remote changes before pushing again.  See the 'non-fast forward'
section of 'git push --help' for details.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
