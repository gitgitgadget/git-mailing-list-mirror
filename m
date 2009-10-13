From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect reset: Allow resetting to any commit, not just a 
  branch
Date: Tue, 13 Oct 2009 01:33:41 -0700
Message-ID: <7vtyy3zo9m.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.10.0910121237540.2223@dr-wily.mit.edu>
 <7vr5t8coex.fsf@alter.siamese.dyndns.org> <4AD420BC.5060506@viscovery.net>
 <7v3a5n3hgn.fsf@alter.siamese.dyndns.org> <4AD43002.5080003@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anders Kaseorg <andersk@MIT.EDU>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 13 10:35:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxcrD-0007On-Lq
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 10:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759180AbZJMIeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 04:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759036AbZJMIef
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 04:34:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39530 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759007AbZJMIee (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 04:34:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7869D6F0FB;
	Tue, 13 Oct 2009 04:33:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Tb87JjuvZed43aDoaAqXeD1jFZ8=; b=UYpgby
	NSBR/pM7cK3BtIqms0MZn1wlJilhNjxYnQBtucmE+KC42BJBxFS9+/ftUcm1fKQO
	fuMcI8vpe1I4iYCprxEsZ5r6xO5s5OT2khapFuR7D5T3Brsr95y4Ow1/Y+xap+mP
	oCijHW9bFtYQRpOExbFqfTgdQAj37aNLU7Y30=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xh9HzUFI21D069q+jUllOcXi1SwGXBeu
	0xj0C7PUdynG8PfgwkHUGGttdCGp2L7SafSQNTPRU2YwWwuy1358AuBWrLF8A8dN
	Q0kMp8ehbqnfZBCC6yS68mQXv2U7X+kSITPviPjpM+lQ519NfE8ML0T5wWGkvOg6
	qUmuccPh76I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 51AD16F0F9;
	Tue, 13 Oct 2009 04:33:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1BC886F0F8; Tue, 13 Oct 2009
 04:33:42 -0400 (EDT)
In-Reply-To: <4AD43002.5080003@viscovery.net> (Johannes Sixt's message of
 "Tue\, 13 Oct 2009 09\:45\:06 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 20249060-B7D3-11DE-A49E-A730BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130145>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio C Hamano schrieb:
>> Half of the time, the commit you test in your "git bisect" section would
>> be a "good" one, and immediately after you tell it "bisect good", it tells
>> you that some _other_ commit you marked "bad" is the first bad commit.  In
>> such a case, you won't be on the commit that the bisect has found.
>
> Oh, yes, very true; but it is very close. But the commit that git bisect
> reset warps me to is perhaps 1000 steps in history away. I certainly do
> not want to go there, ever, because I want to go back near the bad commit
> right away. (Think of fewer files changed means less build time.) If git
> bisect reset would check out the bad commit, this would be *very* convenient.

I agree that "git bisect reset-and-detach-at-the-first-bad-one" would make
a lot of sense.

In my workflow, after I chased a bug in frotz, I often do

    $ git name-rev $the_bad_one_that_was_found
    
to learn what was the first tagged release that has the bug, and create a
topic from there:

    $ git checkout -b jc/maint-X.Y.Z-fix-frotz $the_bad_one_that_was_found

so that the fix I'd build on the commit can be merged initially to 'pu',
then 'next', then 'maint-X.Y.Z' and upwards to 'master', but all of that
is done after "git bisect reset" to switch back to the 'master' branch.
It is cumbersome to have to type (actually, I use the cut buffer in screen)
the commit object name of the first bad one twice.

It certainly sounds attractive if we can do:

    $ git bisect reset-and-detach-at-the-first-bad-one
    $ git name-rev HEAD
    $ git checkout -b jc/maint-X.Y.Z-fix-frotz
    $ hack hack hack
    $ git commit

But at that point we are not talking about switching to arbitrary commit
anymore.
