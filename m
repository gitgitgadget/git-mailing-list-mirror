From: Junio C Hamano <gitster@pobox.com>
Subject: Re: submodule update --force
Date: Wed, 09 May 2012 22:47:17 -0700
Message-ID: <7vobpwpoyi.fsf@alter.siamese.dyndns.org>
References: <CAHOQ7J8r4m2rz57BdkM9CADHdHE1yDFwExyF87u=DCEXjqzcqw@mail.gmail.com>
 <CAHOQ7J9xCYL=x=_nbq-3ksC2nF7L0=kxu9JX6M60xM-Bxmyfag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Thu May 10 07:47:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSMDn-0005Wq-81
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 07:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774Ab2EJFrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 01:47:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57237 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449Ab2EJFrU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 01:47:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDCC25C93;
	Thu, 10 May 2012 01:47:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z7PIN5sfn7RF0KL6miqcXClLh8E=; b=WdHB3p
	OadHH0fvrfYW6pGaq6eZmXh7llbcVRt8xfEDSnWyXjxysQ+88aB0B/tDd0f+8wiX
	u1pvzRf9FOLuf2ch8oCzMNto2J4tBEwhhsEL75/rWMwWeOm8vyfAR2c5CFKG3jJ4
	fKkHBfCv9PhxLNW7Tab72MyJqO/otghBx5il0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mxsr/uCuZJNmuzCmwZDJQL+kuClt2xQu
	2z1SVKIRt8rlu5U8RdCydFcQs41cqsFPsQ6VSPyR2eJNieAGUNjuOgwMSgJ09p/x
	Mj7bCPRavJeqOhX8bdUvoz/z1xiymqIvGjEUptk2rR0fqlfoRnqs24ypGkqhxtLK
	FE4zOWM8Voc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D578F5C92;
	Thu, 10 May 2012 01:47:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 342185C90; Thu, 10 May 2012
 01:47:19 -0400 (EDT)
In-Reply-To: <CAHOQ7J9xCYL=x=_nbq-3ksC2nF7L0=kxu9JX6M60xM-Bxmyfag@mail.gmail.com> (Stefan
 Zager's message of "Wed, 9 May 2012 16:55:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B16FE1E-9A63-11E1-96ED-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197535>

Stefan Zager <szager@google.com> writes:

> I'd like to propose amending the documentation thusly:
>
> According to the docs:
>
>        -f, --force
>            This option is only valid for add and update commands. When
> running add, allow adding an otherwise ignored
>            submodule path. When running update, throw away local
> changes in submodules when switching to a different
>            commit; if not switching to a different commit, a checkout
> to HEAD will still be run.
>
> ... and here's the patch to implement it:
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 64a70d6..8b045d9 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -536,7 +536,7 @@ Maybe you want to use 'update --init'?")"
>                         die "$(eval_gettext "Unable to find current
> revision in submodule path '\$sm_path'")"
>                 fi
>
> -               if test "$subsha1" != "$sha1"
> +               if test "$subsha1" != "$sha1" -o -n "$force"
>                 then
>                         subforce=$force
>                         # If we don't already have a -f flag and the
> submodule has never been checked out
>
> Thoughts?

Even though I admit that I do not use submodule heavily myself, I think
this is a sane thing to do.  After all, the user explicitly said "I want
to force update it", and it is a strong sign that what is in the working
tree is suspect and the user wants to make sure everything is in sync.

This is a tangent, but what strikes me odd with the code before this patch
is that the decision to recurse into the submodule repository is made
solely on the status of the submodule, and there is no way for the user to
say "I do not want it to recurse" (in other words, "--recursive" option
from the command line does not have any effect on this part of the code).

Perhaps that is because we consider submodules that have been "init"ed
always interesting, and if that is the case that may not be a big deal,
but it might not be a bad idea to allow "--no-recursive" option to mean
something stronger than not giving --recursive option, i.e. not recursing
in a situation where it normally would even when run without --recursive.
