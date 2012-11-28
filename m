From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Operations on unborn branch
Date: Tue, 27 Nov 2012 23:12:10 -0800
Message-ID: <7vd2yyi4l1.fsf@alter.siamese.dyndns.org>
References: <CANiSa6isDKAgxHWqh5XiQ-adT3-ASFtvAshp028DTcotjQxzmQ@mail.gmail.com>
 <7vd2yyn685.fsf@alter.siamese.dyndns.org>
 <CANiSa6g2UQyvOWS+nuc6y=wzfFTVJ6G8OK14KOs5DJ3f-n5vOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 08:12:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdbor-0006gs-P0
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 08:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601Ab2K1HMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 02:12:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61883 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126Ab2K1HMN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 02:12:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 314F66F0D;
	Wed, 28 Nov 2012 02:12:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n6xjzZ04mcPla56Fka+KKnNUXRA=; b=nr66Lp
	gO5WlZMOL40s6pdBlHSQ5IKUB/oq/YjO5jzw90mn1nEcTRxSiySreVlxu4Ze1GFW
	A96x7zDTQVOjWyaY9qydRtOrGPVHC2jaEPqPmIK5Ils7gWD9PVa34w19Sz/xsvb5
	FPaLrhyjGUiaiL1kyF3yjgPHXE0D+pquxSxm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VWNbglSv4et47qAh1sIWaSii6W80MlZt
	qXRzKNdupMBcJ+LvHVhELI6zwndlkfDYpt/GATiEKNQ3Z72APonY6oSdheIU1mJu
	l5EDsOIXv18Hz/2Q0Wa8xSTM2h1jP8fejUrb9Ta/TvUQIHYvRf3Wxz9RJ+FV1DzW
	ZxzE+tt1Emw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DDBB6F0C;
	Wed, 28 Nov 2012 02:12:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7AE0C6F0B; Wed, 28 Nov 2012
 02:12:12 -0500 (EST)
In-Reply-To: <CANiSa6g2UQyvOWS+nuc6y=wzfFTVJ6G8OK14KOs5DJ3f-n5vOw@mail.gmail.com> (Martin
 von Zweigbergk's message of "Tue, 27 Nov 2012 12:39:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EE5E5A0C-392A-11E2-996E-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210711>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> On Tue, Nov 27, 2012 at 12:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>>
>>> simplify a lot of things (maybe I'm biased because of the things I
>>> have happened to work on?)
>>
>> Yes.  Do not waste time on it.
>
> Yes, no way I would waste time on that; I was mostly just curious.

You have to special case the edges whichever way you go.  You can
always add such a fixed parent commit whenever you create a new root
commit, but then the codepath that currently relies on the real root
commit not having any parent start needing to notice if the parent
is the fixed fake commit and exclude it from thee history.  Or you
can create a new root commit as parent-less like we currently do,
and any history examination do not have to special case "ah, I
thought there is a parent commit, but that turns out to be the fake
one, so I need to ignore it."  Creation of a root commit is a one-time
operation in any sane history; if we have to have special cases
somewhere anyway, it is better to have them in these one-time
operation codepaths.
