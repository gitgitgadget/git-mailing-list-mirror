From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision: add --except option
Date: Fri, 30 Aug 2013 09:48:05 -0700
Message-ID: <xmqqeh9b15x6.fsf@gitster.dls.corp.google.com>
References: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com>
	<7vhae7k7t1.fsf@alter.siamese.dyndns.org>
	<CAMP44s1y2kvSnF3dKDMr9QtS40PNSW93DWCxFUoL658YkqYeVA@mail.gmail.com>
	<CAPc5daVSqoE74kmsobg7RpMtiL3vzKN+ckAcWEKU_Q_wF8HYuA@mail.gmail.com>
	<CAMP44s0P=XF5C8+fU2cJ-Xuq57iqcAn674Upub6N=+iiMpQK0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 18:48:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFRrr-0008SH-BY
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 18:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756641Ab3H3QsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 12:48:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57017 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756309Ab3H3QsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 12:48:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23A163CB30;
	Fri, 30 Aug 2013 16:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ij1Mgz0VaF1WYHoE6qjewIsz4xo=; b=DKu5Wj
	5ElDNLpCaQLzrhlmH1+nVKNCEJtz0G1zlBWu0+5doWNxxke5qRmENVH5MrKikGNG
	AOK3og1Yzr22v7zSLe53r2SCKGLvL0A85lvKH5TKjB9NBTG2XUnmsPmXj29ByOin
	Af+zRYTAKI1A8hFEXnSCkMJEoic4TZXl74AS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TIYS7OABrAqJstEevLIt2oRJsu5jsia4
	OaxlAUt7Qvx3Ywf7uen9bo5dLAY6W4iXjY7iiS0FU44swMX10uNg8tnZTfsuK/xb
	dVhLWzOsQ11XJUsNpJipnup8iVagau2EEhAsoqbRLenJ7gNAE+ghabqDFRKETIPE
	4V1uacgzmRo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18ECC3CB2F;
	Fri, 30 Aug 2013 16:48:08 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5BE573CB2C;
	Fri, 30 Aug 2013 16:48:07 +0000 (UTC)
In-Reply-To: <CAMP44s0P=XF5C8+fU2cJ-Xuq57iqcAn674Upub6N=+iiMpQK0g@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 30 Aug 2013 02:32:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F24722B0-1193-11E3-99F9-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233442>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>>> If you do 'master ^maint --except master', handle_commit will return
>>> three commits:
>>
>> Would the same argument apply to
>>
>>   next ^maint --except maint
>>
>> where next gets in the queue, maint in tainted, and skipped?
>
> maint is not skipped, as it's not the same as ^maint, basically it's
> the same as:
>
> next ^maint
>
> I think that's good, as there's absolutely no reason why anybody would
> want '^maint --except maint' to cancel each other out.

I do not expect anybody to say "^maint --except maint", but the
negative one can come from expansion of --branches and such.
Essentially, the semantics the patch implements is "--except applies
only to positive tips" (I have not thought about its implications on
left-right traversals; there may be some impact there as well).

Being able to exclude only positive ones is better than not being
able to exclude any, but if we consider j6t's example, I think
applying except to negative ones is equally useful.

For example, "I want to see everything I have reachable from my refs
(not just branches), but exclude those that are reachable from my
stable branches (my local branches except those whose names match
the pattern 'wip/*')" is a reasonable thing to ask.  A wip/* branch
may be based on the work in a remote tracking branch that you have
not merged to your 'maint', 'master' or 'next', and you want to view
all the commits on the remote tracking branch you haven't merged to
your stable branches, including the ones that you already use in
your WIP that are not ready.  And the request may be spelled as

	--all --not --branches --except 'wip/*'

Which means that the approach taken by the patch to only allow
exclusion of negative ones makes the idea only 50% useful compared
to its potential.  And I suspect that "we can start from 50% which
is better than 0% and later fill the other 50%" would not work in
this case, without ripping out the "SKIP on object" approach and
redoing the "--except" support from scratch, because "SKIP on
object" fundamentally cannot undo the effects of the negative ones,
because it records the information at a wrong level.

It may be a good idea to step back a bit and think of this topic as
a way to enhance the --branches option and its friends with only the
inclusive wildcard semantics.  It lets us include those that match
the pattern with "--branches=wip/*", but there is no way to say "oh
by the way, I do not want those that match this pattern included
when you expand this short-hand".  We have --branches=pattern that
is inclusive; perhaps it can be prefixed with --branches=!pattern to
pre-declare "whatever the next --branches expands to, do not include
those that match this pattern", or something, which would make the
earlier "wip" example to be:

	--all --not --branches='!wip/*' --branches
