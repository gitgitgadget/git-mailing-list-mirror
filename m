From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Autocompletion - commands no longer work as stand alone
Date: Fri, 20 Jan 2012 11:24:23 -0800
Message-ID: <7vwr8mdvo8.fsf@alter.siamese.dyndns.org>
References: <CAPx=Vfp_HVr5W1fFic_1k+JsKr2RAKd-RK=VkfSgo7qkb5GsAw@mail.gmail.com>
 <CAPx=Vfqj3UZuFv3Xmupy7k9arUxyZJyprm628p9QVKabdOz8cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nathan Bullock <nathanbullock@gmail.com>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jan 20 20:24:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoK4e-0001Pw-1y
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 20:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862Ab2ATTY1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jan 2012 14:24:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44561 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753412Ab2ATTY0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jan 2012 14:24:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26B88789D;
	Fri, 20 Jan 2012 14:24:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aejm5zDv6LUm
	1Av69goTDD62Egc=; b=Wi0uBkcId0lvESMlfi17R/K96g6gdB2xyml1/1cgxvCo
	0xAVH5gqRWWB3wkKjPLDLQgKrt+LgGDnkT2hSmuxFIomOaa1xZjQS6FyJwLqjyfT
	ZsWXSxAs/vUiEMB42jGa+YhAuPPPQGsrXVnEQNJaRpAjISb/SLm/N2vDcwP+LRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cBJjF+
	PONX1aMdKXIsgjCeaU/ALTmCmXU0A/Z0A3H4TkcYFAY8XwnxFTvFJ0BvTYzvkGLq
	L32ebY6cjRk8rYgOyGuLjme1P0wicVjWgxURqOH/48uOD9C9XvvYUucDjnFj3CK3
	2phyDzCwrbBevg2CBPofBa/Ei0i5+wK1M5uBs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B63D789C;
	Fri, 20 Jan 2012 14:24:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49BE9789A; Fri, 20 Jan 2012
 14:24:25 -0500 (EST)
In-Reply-To: <CAPx=Vfqj3UZuFv3Xmupy7k9arUxyZJyprm628p9QVKabdOz8cw@mail.gmail.com> (Nathan
 Bullock's message of "Fri, 20 Jan 2012 11:32:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D10514C-439C-11E1-99D9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188894>

Pinging Szeder. I personally do not think it is a crime for us to break
anything that uses an internal function whose name begins with undersco=
re,
but people more deeply involved in this part of the system may have ide=
as
to help supporting even such users.

Nathan Bullock <nathanbullock@gmail.com> writes:

> I have for a number of years had the following in my .bashrc
>
> alias br=3D"git branch"
> complete -F _git_branch br
>
> As well as similar commands for co and log.
>
> Recently though this broke, now when I type something like "br
> mas<command completion>" it will occasionally complain with messages
> like:
> bash: [: 1: unary operator expected
>
> From digging through the source it looks like this was broken back in
> April. (The commit is show at the bottom of this email.)
>
> So my questions are:
> 1. Is it reasonable for things like _git_branch to work as a
> standalone autocompletion function instead of having to go through
> _git? I certainly like it to work as a standalone function. I also us=
e
> it to add autocompletion to other bash scripts that I use frequently.
>
> 2. If I add code that verifies that the variable cword exists at the
> start of these functions and only if not call something like
> _get_comp_words_by_ref -n =3D: cur words cword prev. Would that be
> reasonable? I think this should address the performance concerns that
> caused these to be removed in the first place, but it may make the
> code uglier.
>
> I have already added wrapper functions in my bashrc so that this is n=
o
> longer a problem for me, but there may be other people who start
> hitting this as well once they start using newer versions of git.
>
> Nathan
>
>
> commit da4902a73017ad82b9926d03101ec69a2802d1e7
> Author: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> Date:   Thu Apr 28 18:01:52 2011 +0200
>
>    completion: remove unnecessary _get_comp_words_by_ref() invocation=
s
>
>    In v1.7.4-rc0~11^2~2 (bash: get --pretty=3Dm<tab> completion to wo=
rk
>    with bash v4, 2010-12-02) we started to use _get_comp_words_by_ref=
()
>    to access completion-related variables.  That was large change, an=
d to
>    make it easily reviewable, we invoked _get_comp_words_by_ref() in =
each
>    completion function and systematically replaced every occurance of
>    bash's completion-related variables ($COMP_WORDS and $COMP_CWORD) =
with
>    variables set by _get_comp_words_by_ref().
>
>    This has the downside that _get_comp_words_by_ref() is invoked sev=
eral
>    times during a single completion.  The worst offender is perhaps '=
git
>    log mas<TAB>': during the completion of 'master'
>    _get_comp_words_by_ref() is invoked no less than six times.
>
>    However, the variables $prev, $cword, and $words provided by
>    _get_comp_words_by_ref() are not modified in any of the completion
>    functions, and the previous commit ensures that the $cur variable =
is
>    not modified as well.  This makes it possible to invoke
>    _get_comp_words_by_ref() to get those variables only once in our
>    toplevel completion functions _git() and _gitk(), and all other
>    completion functions will inherit them.
>
>    Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
>    Signed-off-by: Junio C Hamano <gitster@pobox.com>
