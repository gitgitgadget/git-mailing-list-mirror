From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: Skip pack-*.keep files when cloning locally
Date: Mon, 01 Jul 2013 09:20:36 -0700
Message-ID: <7vip0ui757.fsf@alter.siamese.dyndns.org>
References: <1372430538-19216-1-git-send-email-jl@opera.com>
	<7vvc4ynkrx.fsf@alter.siamese.dyndns.org>
	<CAEef6WzAg8-QMH1c4v=1tm7TPgfeE3W3K+ue-eYgRL3pyYo6Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, johan@herland.net
To: Jens =?utf-8?Q?Lindstr=C3=B6m?= <jl@opera.com>
X-From: git-owner@vger.kernel.org Mon Jul 01 18:20:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtgqL-0002GS-IG
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 18:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966Ab3GAQUl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jul 2013 12:20:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45527 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752039Ab3GAQUk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jul 2013 12:20:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6496D2C541;
	Mon,  1 Jul 2013 16:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Go32f90ip0Go
	TMxx+aqEnuZbBjQ=; b=EMIwHqqci3/+B8veyFfKJJioDdycE3rAHqjffa5Q630m
	kjIWqwDXSnvOpI984F5RWq4EERmvKDaCz+WSz2D2GPry1OnH0ZzhGL7LkXNNwEP+
	H37+vs4h/UgYDsg7ttlAUC/j7Fb6Zb3+/04ilOgPIXEpGJdUPdoWb0tLcIeafUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VdqamA
	rx+LTG3JWG2kJNDDVpPDIYE6AKy7NZnrDhSp5F6rktfkaknGjrpIUKzfx7fBEiwQ
	+CwwFG3M5Qw+xKwkcrQ/Fh5LBOiPlwD6rVrWe8Tysvf6xKcGUxSZdCLkumB4/W2M
	GYzvb3ewbBS3E7oQhEE/DuIJk6p4qT1uQroBo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 594222C540;
	Mon,  1 Jul 2013 16:20:39 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 932DD2C53C;
	Mon,  1 Jul 2013 16:20:38 +0000 (UTC)
In-Reply-To: <CAEef6WzAg8-QMH1c4v=1tm7TPgfeE3W3K+ue-eYgRL3pyYo6Vg@mail.gmail.com>
	("Jens =?utf-8?Q?Lindstr=C3=B6m=22's?= message of "Mon, 1 Jul 2013 12:24:03
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2ABF9888-E26A-11E2-8B70-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229304>

Jens Lindstr=C3=B6m <jl@opera.com> writes:

> On Fri, Jun 28, 2013 at 8:38 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>
>>> The pack-*.keep files are temporary, and serve no purpose in the
>>> clone.
>>
>> They are not temporary, actually. A user can deliberatey create a
>> "keep" marker after packing with a good set of parameters, so that
>> the resulting pack will be kept, instead of letting a later repack
>> (with faster set of parameters) remove and replace it with less
>> optimal results.
>
> Ah, I see.  Was (obviously) not aware of that.  It would perhaps be a
> good idea to be able to differentiate between such permanent keep
> files and the temporary ones created by built-in commands.

I am not sure if we should care that deeply about them in the first
place.  For these temporary ".keep" lockfiles to matter, you have to
be doing "clone --local --no-hardlinks", which is a "cp -R" that
bypasses the usual Git transport mechanism, while there is still
activity in the source repository (a fetch is slurping new objects
into a newly created pack with such a temporary ".keep" lockfile,
the refs may not have been updated yet).  The result is expected to
have inconsistencies even if ".keep" were readable in such a copy.

> Also, even if some keep files are permanent in the source repository,
> is it always a good idea to copy them over to the clone?

The local "cheap cp -R clone" are primarily used by people copying
their own private repository that is in a quiescent state, and in
that set-up, copying ".keep" by default has been a good idea.  Of
course, after copying to a new repository, if they want to repack
with different parameters, they need to unplug ".keep" files
manually, and it can be argued that the default could have been not
to copy and we could have forced those who want to reuse a tight
pack they created earlier to manually copy or create the ".keep"
files instead.
>
> On Fri, Jun 28, 2013 at 10:38 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>
>> That is, something like this, perhaps?
>
> Comments:
>
> With this patch, it still fails with --local, when the link() call
> fails.

Oh, I wasn't even attempting to look at the hardlink codepath in the
"something like this" illustration patch ;-).

Besides, I think you can make a hardlink to a file that you cannot
read.

If you apply only the parts of the patch that adds the test, without
applying either your patch or mine to builtin/clone.c, and remove
"--no-hardlinks" to force the hardlink codepath, what happens?  We
create an unreadable $keepname in strictsrc repository and I think
the local clone (which is not "cp -R" but something like "find"
piped to "cpio -pluadm") would make a "copy" of it just fine.
