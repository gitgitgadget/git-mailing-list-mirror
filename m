From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion.bash: add support for path completion
Date: Wed, 19 Dec 2012 14:49:59 -0800
Message-ID: <7vy5gt7j3c.fsf@alter.siamese.dyndns.org>
References: <1355693080-4765-1-git-send-email-manlio.perillo@gmail.com>
 <7vy5gxnuy1.fsf@alter.siamese.dyndns.org> <50CEFF3A.4050802@gmail.com>
 <7vzk1clb3n.fsf@alter.siamese.dyndns.org> <50D23960.4070108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 23:50:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlST1-00052h-Db
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 23:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581Ab2LSWuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 17:50:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46627 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859Ab2LSWuD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 17:50:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 427199833;
	Wed, 19 Dec 2012 17:50:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Db1OuXTkD6g45UIV3V6DP87dVjI=; b=DWRUMC
	kPvLd6qnyrqgA8HViUQh4alUBxpT/Ejxp2NWLd+6jvzzuuf/1URifurcXGmzTajF
	8ZCLkRar2V81GvA+0Fnr0j5CDIof1M1MXOqDeH4vccEKVD2uWQPCsebcm9d9UiI3
	TXJaomkZ83eCskxpYSl3Qax4dEslI+57BzUrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NhywKX/lg3PntvVqgJJx2im467i52kcP
	XJxNXj1+gQlKba96lvm1Kf2SbbDkYb2bHmH0j3cVxtMwUi88VjfmjbwqGlJlhXe0
	yDryIIuak+jHrg6z0+iTUCe3bc77u0khIrLw0whWkuVzqeSfuVZ5h5JirOwOKbHA
	dvxHaHgVaH4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CABE99832;
	Wed, 19 Dec 2012 17:50:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB3B39831; Wed, 19 Dec 2012
 17:50:00 -0500 (EST)
In-Reply-To: <50D23960.4070108@gmail.com> (Manlio Perillo's message of "Wed,
 19 Dec 2012 23:02:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B94DC8A-4A2E-11E2-9F7B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211862>

Manlio Perillo <manlio.perillo@gmail.com> writes:

>> 	git mv COPYING README X
>
> Assuming X is a new untracked directory, do you think it is an usability
> problem if an user try to do:
>
> 	git mv COPYING README <TAB>
>
> and X does not appear in the completion list?

It is hard to say.  Will it show "Documentation/" in the list?  Will
it show "git.c" in the list?

Your "git mv git.<TAB>" completing to "git mv git.c" would be an
improvement compared to the stock "less git.<TAB>" that offers
"git.c" and "git.o" as choices.  For things like "mv" and "rm", this
may not make too much of a difference, "git add <TAB>" would be a
vast improvement from the stock one.  The users will notice that the
completion knows what it is doing, and will come to depend on it.

But at that point, if "git mv COPYING README <TAB>" offers only
directories that contain tracked files, the users may get irritated,
because it is likely that the destination directory was created
immediately before the user started typing "git mv".  You will hear
"Surely I created X, it is there, why aren't you showing it to me?"

The updated completion knows what it is doing everywhere else, and
it sets the user-expectation at that level.  Uneven cleverness will
stand out like a sore thumb and hurts the user perception, which is
arguably unfair, but nothing in life is fair X-<.

I think over-showing the choices is much better than hiding some
choices, if we cannot do a perfect completion in some cases.  "You
should know that I won't be moving these files in Y, as I already
marked it to be ignored in the .gitignore file!" is less grave a
gripe than "You know I created X just a minute ago, and it is there,
why aren't you showing it to me?" because you can simply say "but Y
is there as a directory." admitting that you are less clever than
the user expects you to be, but at least you are giving the choice
to the user of not picking it.

In the ideal world (read: I am *not* saying "you should implement it
this way, or we won't look at your patch"), I think you would want
to show tracked files (because it may be the third path that the
user wants to move with the command, not the destination directory)
and any directory on the filesystem (it could be the third path that
is being moved if it has tracked files, or it could be the final
destination directory argument).
