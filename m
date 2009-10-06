From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch 
 when appropriate to do so
Date: Tue, 06 Oct 2009 13:33:47 -0700
Message-ID: <7vzl84xnx0.fsf@alter.siamese.dyndns.org>
References: <237967ef0910060241q671baafav93fe6402a4c510c5@mail.gmail.com>
 <0016e68fd0123a175304754694b4@google.com>
 <76c5b8580910060943k6172e3a5waee2f92c403e5cc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mikael Magnusson <mikachu@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 22:38:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvGnx-0004uN-PK
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 22:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933207AbZJFUek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2009 16:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933185AbZJFUek
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 16:34:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42088 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933184AbZJFUej (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 16:34:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AEAB66D5F4;
	Tue,  6 Oct 2009 16:33:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DSAUmZpVQ9P75CHY1pN6Nme4A1E=; b=lDmuKp
	DmqhHEWF6uM0Dn/Mu1FW7dpao9tDfI3rxNOneAdY58CJ06oZ3j0W9ClQXb5058pM
	Kks3diihopoqOt/yvcAl2lkf/SnMsVE8Ik0M6dj5t8thenjtCubfea+m+jj1wbkd
	O78ICcEbz+N77VLtqNN1n26byR+fZLRIUmets=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jDY9kdFMAGE+g0URlXD5ri3Qmxd0FCS4
	AzEk0BrY1j3zh6CjZAAECIKT1R4KmOEukK6OaBlRWoYdqJas6tx557KhpAnJuKBF
	acvZST8dY+GIrIpG/LSNjqNmRWJ1iNlW1Dm2JRjy/oVkqxLZvJMQWPs3UF9DWS0m
	/5xLlHzLDB0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 845A96D5F2;
	Tue,  6 Oct 2009 16:33:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 357C06D5F1; Tue,  6 Oct 2009
 16:33:48 -0400 (EDT)
In-Reply-To: <76c5b8580910060943k6172e3a5waee2f92c403e5cc3@mail.gmail.com>
 (Eugene Sajine's message of "Tue\, 6 Oct 2009 12\:43\:28 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9028124A-B2B7-11DE-87B4-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129635>

Eugene Sajine <euguess@gmail.com> writes:

>  As for the solution i would choose the "simplest thing that will work" - so
>  i think that we just have to notify user about his suicide attempt to
>  checkout nonlocal branch and offer him a correct syntax to go with.

We already do that, without going interactive, for warning unintended
detachment:

    $ git checkout origin/next
    Note: moving to 'origin/next' which isn't a local branch
    If you want to create a new branch from this checkout, you may do so
    (now or later) by using -b with the checkout command again. Example:
      git checkout -b <new_branch_name>
    ...

As to Mikael's scenario:

>>> I can imagine this happening:
>>> % git clone git://git.git git
>>> % git checkout next
>>> do you want to checkout origin/next? y
>>> # a few days later
>>> % git fetch
>>> % git checkout next
>>> [freenode] /join #git
>>> [#git] i did git checkout next but my files are still the same?

No amount of sugarcoating the checkout syntax changes the fact that in the
user's repository there _are_ two distinct refs, origin/next and next, and
the "fetch few days later" updates only the former but never the latter.
It can only be fixed by injecting a bit of clue to the user, in a way
Dscho suggested in the thread.
