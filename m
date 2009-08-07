From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] push: point to 'git pull' and 'git push --force' in case of non-fast forward
Date: Fri, 07 Aug 2009 21:37:20 +0200
Message-ID: <vpqvdkzwh3j.fsf@bauges.imag.fr>
References: <1249579933-1782-1-git-send-email-Matthieu.Moy@imag.fr>
	<7v7hxgk8c9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 21:38:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZVGc-0000pF-2s
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 21:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933182AbZHGTiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 15:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933171AbZHGTiH
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 15:38:07 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44235 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933159AbZHGTiG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 15:38:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n77JaRbY008912
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 7 Aug 2009 21:36:30 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MZVFg-00071L-VL; Fri, 07 Aug 2009 21:37:20 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MZVFg-0007XM-U5; Fri, 07 Aug 2009 21:37:20 +0200
In-Reply-To: <7v7hxgk8c9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 06 Aug 2009 13\:15\:02 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 07 Aug 2009 21:36:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n77JaRbY008912
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1250278593.55@JE97shBbwt+CzxckodvXTA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125212>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> 'git push' failing because of non-fast forward is a very common situation,
>> and a beginner does not necessarily understand "fast forward" immediately.
>>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>> That may be a bit verbose, but I think it's worth it.
>> ...
>> +		if (nonfastforward) {
>> +			printf("Some branch push were rejected due to non-fast forward:\n");
>> +			printf("Merge the remote changes (git pull) before pushing your's\n");
>> +			printf("or use git push --force to discard the remote changes.\n");
>> +		}
>
> Although I think the patch identified the right place to make changes, I
> am not sure about what the help message should say.
>
> If the user lacks understanding of what a fast-forward is, I do not think
> giving two choices that would produce vastly different results

Well, there are different levels of mis-understanding of
"fast-forward", and one of them is just a mis-understanding of the
wording.

My experience is that many people understand "there are changes over
there that you don't have so an explicit merge is needed", but would
not necessarily use the wording "fast-forward" for this.

The second line of my message was not only here to point to "git
pull", but had also a subliminal message stating that there are
remote changes ;-).

> Jokes aside, perhaps we could add "see git-push documentation for details"
> to the above message of yours, and add something like this to the
> documentation.

100% convinced that this section in the doc is a good idea. I'm not
totally sure the error message should point to it, because that will
make the message 4 lines long instead of 3, so it may start disturbing
gurus for whom the whole message is useless.

Right now, I have this in my tree:

  if (nonfastforward) {
  	printf("Some push were rejected because it would not result in a fast forward:\n"
  	       "Merge in the remote changes (using git pull) before pushing yours, or\n"
  	       "use git push --force to discard the remote changes.\n"
  	       "See 'non-fast forward' section of 'git push --help' for details.\n");
  }

> +Alternatively, you can rebase your change between X and B on top of A,
> +with "git pull --rebase", and push the result back.  The rebase will
> +create a new commit D that builds the change between X and B on top of
> +A.
> +
> +----------------
> +
> +      B   D
> +     /   /
> + ---X---A
> +
> +----------------
> +
> +Again, updating A with this commit will fast-forward and your push will be
> +accepted.

Maybe add something about --force ? I don't like my wording very much,
but a first try is this:

Lastly, you can decide that the B shouldn't have existed, and delete
it. This is to do with a lot of care, not only because it will discard
the changes introduced in B, but also because if B has been pulled by
someone else, he will have a view of history inconsistant with the
original repository. This is done with the --force option.

-- 
Matthieu
