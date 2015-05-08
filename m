From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sequencer.c: abbreviate hashs placed in the middle of messages
Date: Fri, 08 May 2015 11:42:43 -0700
Message-ID: <xmqqtwvmlxlo.fsf@gitster.dls.corp.google.com>
References: <1431104035-2056-1-git-send-email-ralf.thielow@gmail.com>
	<CAPig+cSeNn0r7N6vp+qs4NTNwfYx5p-zUX3tkifuXLu+nB2yNQ@mail.gmail.com>
	<xmqqbnhvm1f5.fsf@gitster.dls.corp.google.com>
	<CAN0XMOKPbKUMwU5-T78m_knt=9O2GkKaqmXKViSi5k-Z7Damrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 20:42:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqnEe-0005i3-OE
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 20:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020AbbEHSmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 14:42:52 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59400 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752892AbbEHSmv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 14:42:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 54F004DDE3;
	Fri,  8 May 2015 14:42:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZW5a76+bIpk2L2ToCuIbvdn+4yA=; b=Hy4ED1
	UWoGugvMw7oa2s52aNW+cPc7UysudIB8GqoW8cbQI01idduRbbuqsP+Oq10uEqg2
	ehft3jVTT4RxSTmNMk2zZbsOgLGdBBJVfdKMt0TSIZms3CyU5b8Y4mLzN0qAUXHu
	DhreOxTbz7ce/LIfq60SBpmvLwPGHukOUtI2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sa/ejsrs3+qk2O+FlSdXaAYFsKg7sUdP
	2blcllGHz7e47C2Nz92v1mgzTjsJgAHMjz9XprJepSXV3YDsHz0OsqdBR5ZHX/Rf
	aHnCq2LREHNcDv1D82D9nbtv/8HCGaajRncDftVWpUtqpuQ9GSGDPq2ZPlZN380D
	ym8RGnw4k30=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CB464DDE2;
	Fri,  8 May 2015 14:42:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A8E4F4DDE1;
	Fri,  8 May 2015 14:42:44 -0400 (EDT)
In-Reply-To: <CAN0XMOKPbKUMwU5-T78m_knt=9O2GkKaqmXKViSi5k-Z7Damrg@mail.gmail.com>
	(Ralf Thielow's message of "Fri, 8 May 2015 19:58:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 03F1A20C-F5B2-11E4-9016-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268641>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> But I doubt the value of pointing out exact commit in the first
>> place, which leads me to say that "no -m option was given but
>> history has a merge" might be a viable alternative.
>>
>> If identifying the exact commit has value, on the other hand, we can
>> rephrase it like this:
>
> It has value since you see the hash and can check if you have
> passed a wrong commit accidently.

Let's say by mistake I applied your patch while I had 'master'
checked out, and I want to cherry-pick it to its own branch, by
doing something like

    $ git checkout -b rt/sequencer-error-messages maint
    $ git cherry-pick <branch-name-here>

and typed next by mistake instead of master in the above.  I should
get "that commit is a merge but you didn't tell me relative to which
of its parents you want the changes ported".

Does it make it any clearer to say "commit 38e707... is a merge"
compared to "commit you gave me is a merge", with or without
abbreviation?

I do not think so.  I know I said "git cherry-pick next".

> I don't see why you suggest to rephrase the messages over an
> abbreviation of the hash. Is it because I wrote "in the middle of"?

No.

I am merely making sure that the original problem is well analysed
and we looked at other possibilities before picking one, i.e. making
sure that we did not pick the one merely because it happened to be
an expedient thing to do.

And shortening the output feels to me a more expedient thing to do
because we do not have to analyse the ramification of possible
information loss (your "It has value since...").  If we analyse the
issue well, we might realize that there is little point in showing
the commit object name in hexadecimal, be it in full or in shortened
form.

If the proposal were to parrot what the user typed on the command
line, e.g. one of these (or their rephrased versions)

	error: commit 'next' is a merge but no -m option was given.
	error: no -m option was given to pick a merge 'next'.

against the above example, then I would say that would be an
improvement, but that is not what is being discussed, so...
