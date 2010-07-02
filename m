From: Junio C Hamano <gitster@pobox.com>
Subject: Re: global hooks - once again
Date: Fri, 02 Jul 2010 12:18:59 -0700
Message-ID: <7v630x1yl8.fsf@alter.siamese.dyndns.org>
References: <AANLkTikXJS5QCXMXgsOfkYn9cMBQV6o23tds5YG3A_OI@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 21:19:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUllq-0006D9-8r
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 21:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757269Ab0GBTTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 15:19:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220Ab0GBTTM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 15:19:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 69B6EC16BC;
	Fri,  2 Jul 2010 15:19:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BPwaxcmfVgeF35jt2pqkxdEkmdU=; b=Qyjxrh
	L5kqGXAyTq4sBSYmN3i0bjNYQ8M+o0CsF0Q2B9IK+tF5Y7prhpqhEpK8mu8LWD+J
	ylClaWSdk+m1h2sw27L7VJMOFXEulnU9G8fr16j4ZF2U3PIWfW14YZk2SXpHDRXy
	ljOUfA+34rtM+y4TMVefkdjEDtY/XP/EYWobQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PF8FDyRkvefEnD0ouphDU208VEb0mNWU
	qGWri8WSyEtEIZ4pA7SPtZt6jC72aLxzcCW6nqFK0ZJvDr9wcHazmuZEp0VICK+R
	Baj7IEusiDv6aVfabnGUKhfiV2U6EALGDcaoVVuAlTPl35I3SVqCTAyD0Megrg4T
	sZ1sX69EURc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 466A4C16BB;
	Fri,  2 Jul 2010 15:19:09 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 391DCC16BA; Fri,  2 Jul
 2010 15:19:06 -0400 (EDT)
In-Reply-To: <AANLkTikXJS5QCXMXgsOfkYn9cMBQV6o23tds5YG3A_OI@mail.gmail.com>
 (Eugene Sajine's message of "Fri\, 2 Jul 2010 12\:23\:42 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B0752094-860E-11DF-B38C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150150>

Eugene Sajine <euguess@gmail.com> writes:

> For example, so i could say
> $ git config --global hooks.dir ~/git/hooks

I don't think "global" hooks are useful for people who work on more than
one project, or people who interact in more than one ways to projects.
Different projects typically have different needs out of the hooks
(e.g. pre-commit policy), and different workflows typically call for
different needs out of the hooks (e.g. I would want to be able to rebase
in my private working repository but not in the repository I use for
integration of other people's branches).

So I am fairly negative on your particular example above.

But it is understandable for one to use more than one repository for the
same project and use them in the same way; in such a case, I agree that a
way to ensure that these repositories use the same set of hooks (and
non-hooks, e.g. commit templates, local ignore pattern files, etc.) is
desirable.

So I would imagine that your example without "--global" would be a
reasonable thing to do once per repository.

Now, as long as the "do once per repository" action that you need to do is
simple enough, it doesn't necessarily have to be "git config".  Perhaps

    [alias]
    set-hooks = !"sh -c 'rm -fr .git/hooks && ln -s $1 .git/hooks' -"

could also be a simple single-command solution that is "do once per
repository".

Can't we do better and make this "do nunce per repository" instead?

You first have to think how you are creating these more-than-one
repositories you would want to make sure they use the same hooks.  For
example, do you have a single "upstream" repository and everything is a
clone of it?  If so, perhaps a way to tell "clone" via $HOME/.gitconfig
that when cloning from a particular URL you would want to run a particular
post-clone script might be a better way.
