From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP PATCH 0/5] support --exclude for diff/log commands
Date: Thu, 10 Mar 2011 00:41:13 -0800
Message-ID: <7vvczr5pw6.fsf@alter.siamese.dyndns.org>
References: <1299726819-5576-1-git-send-email-pclouds@gmail.com>
 <7vmxl37bdp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 09:41:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxbR4-0008TE-5q
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 09:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239Ab1CJIlZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2011 03:41:25 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42578 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957Ab1CJIlY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 03:41:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7FDDC2CC7;
	Thu, 10 Mar 2011 03:42:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Uh24vUa85Wwm
	rP2QkZjtxyEq/3E=; b=Yz5JrcqZuu+fx/yLwCB7429TBmlWLQpOlmmrm9fNNwcx
	1LsN+E7YGrNhizTbYWmQM/4nCP6vKHkHF9tVoDJ9IjtfAXadFFTRs7dOoh42fWbf
	om71UnZfbqn67VsGbaIkUcDdWhsH8RBbIwKFcLWEnv8FZHEUGFpqZ0ZTvXiyoNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vlIfVk
	7cXqmvFgFlirIUleKU+N4/C1glzVYKiQT7wAXlnI+JXxvHhELsdPtBUxtRXI114O
	Zf7QA7+AAkj4YHzJA5bsvZj8wB3Lgusoi7e7mT4Y9dmGs2Rp48wcLMCtSewlPP+/
	xfAYai7peUBapkjAQed03nRBh6LpQ//oMst9E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4D45E2CC5;
	Thu, 10 Mar 2011 03:42:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 045102CC3; Thu, 10 Mar 2011
 03:42:43 -0500 (EST)
In-Reply-To: <7vmxl37bdp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 09 Mar 2011 22:11:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 607A1D2A-4AF2-11E0-BBDD-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168798>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> On the other hand, if we go with ':' as a mark of special pathspecs,=
 then
>>
>>  - ":/" mark pathspecs relative to worktree root
>>  - ":!" may mark negative pathspecs
> ...
>
> As the choice of the syntax goes, in the recent "grep --full-tree"
> discussion, I thought people are more or less happy with the colon
> prefixed "magic pathspec" syntax, and something along the lines of th=
e
> above two seems to be a good design.
>
> The two most important things to consider are to make sure that peopl=
e
> with funny pathnames can work it around by quoting, and the prefixing
> scheme is extensible so that other types of magic can later be introd=
uced
> with the same kind of escape hatch for people with funny pathnames th=
at
> begin with or contain new magic characters used to trigger the new ma=
gic.
>
> I said "something along the lines" above because ":/ for root, :! for
> negative" does not yet specify how the scheme would satisfy the above
> two consideration very well.

Let's step back a bit.

We chose to use ":/<regexp>" as one new form of extended SHA-1 expressi=
on
to name an object for two reasons: (1) no normal <ref> can have a colon=
 in
it, because of check-ref-format restriction; (2) ":" is an unlikely let=
ter
to appear at the beginning of a pathname, and people with such a path c=
an
work around by saying "./:frotz" or "\:xyzzy".

There is a disambiguation logic to check a list of arguments that lacks=
 an
explicit "--" separator to make sure that each element early on the lis=
t
can only be interpreted as an object name but not as a pathname that
exists on the filesystem, and all the remaining elements are pathnames
that exist on the filesystem.

If we introduce an extended syntax for pathspec and make the prefix mag=
ic
character ":", and if we choose to use ":/" as one kind of magic, I was=
 a
bit worried that this may affect the disambiguation.  The users must us=
e
an explicit "--" when feeding a pathspec with the magic so that the par=
ser
knows which kind of magic (either object name magic or pathspec magic)
they are talking about.

I however realized that it is not an issue at all, because the users
already need to disambiguate with "--" when using wildcards in their
pathspecs (e.g. "git log 'Makefil*'" will give you an ambiguity error).
Admittedly, wildcard pathspecs are lessor kind of magic, but they are
magic nevertheless.

So my tentative conclusion is that there is no problem using the same "=
:"
as the magic introducer for pathspecs, just like we do for object names=
=2E

	Side note: please point out flaws in the above train of thought
        that would make the end result non-workable.

Although I like the general approach Michael took with his "alternative
setup.c that understands tree-wide pathspec" patch (Cf. $gmane/168207),=
 I
agree ":/" would be better than saying "':' is root, and we don't allow
any other magic under ':'" for the sake of extensibility.

I am not very happy with ":!" as negative from syntactical point of vie=
w,
because traditionally "!" is a tad cumbersome to quote in shells with
history support (e.g. "csh"), but unfortunately I don't think of any go=
od
alternative that is easy to type.  Pathspecs are globs by nature, and "=
!"
is a good choice of nagation indicator for that reason (think "[!aeiou]=
"
not "[^aeiou]" the latter of which is a regexp and not glob), though.
