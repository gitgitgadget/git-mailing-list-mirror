From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Sources for 3.18-rc1 not uploaded
Date: Mon, 20 Oct 2014 11:28:47 -0700
Message-ID: <xmqqoat6389s.fsf@gitster.dls.corp.google.com>
References: <20141020115943.GA27144@gmail.com>
	<CA+55aFyDuHskYE66rBVL_P-T2pxg6f2m6mUicfz-mk+ysePBxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	infra-steering@kernel.org, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Oct 20 20:28:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgHhQ-0007PR-Cb
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 20:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbaJTS2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 14:28:52 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751109AbaJTS2v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 14:28:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 65901164BB;
	Mon, 20 Oct 2014 14:28:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MxI+iySoZNKjPgLx90c1dDEaksM=; b=C+jp6y
	BMz4pW3gG331sHgEb/eSCpDHPs2lSEK9dtdQofG8EyRvbl/SxfhSSG0mVUAfWIDX
	+xU3GBX5ze8ivkhzj8UvRWyjnjvxivXidbGztSD0uwYySWQrys6lRBp4ZAJk6s+j
	IdYdJjp9nslm0FLr/og7vAdISoJvjmBzS9k3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EnHiLiaHZRHQG5vGBVQrUbznHxJBEpKJ
	64FRqEsMWV7M+wJnVUTl2QjI2n4RB0vzOiBEhhfxeI39k2FxK9nT4a/iO88KE+FW
	fYp7P3TT8EOJuj3O4J/C+59GEsUrvYp6jH7KeqgK2aB+HJw/14OoQvs5UxEvO4v2
	nQNOhyRRp44=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C45D164BA;
	Mon, 20 Oct 2014 14:28:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF4BD164B9;
	Mon, 20 Oct 2014 14:28:48 -0400 (EDT)
In-Reply-To: <CA+55aFyDuHskYE66rBVL_P-T2pxg6f2m6mUicfz-mk+ysePBxg@mail.gmail.com>
	(Linus Torvalds's message of "Mon, 20 Oct 2014 08:25:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EF1EB5D6-5886-11E4-90AF-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Junio, Brian,
>
>   it seems that the stability of the "git tar" output is broken.
>
> On Mon, Oct 20, 2014 at 4:59 AM, Konstantin Ryabitsev
> <konstantin@linuxfoundation.org> wrote:
>>
>> Looks like 3.18-rc1 upload didn't work:
>>
>> This is why the front page still lists 3.17 as the latest mainline. Want
>> to try again?
>
> Ok, tried again, and failed again.
>
>> If that still doesn't work, you may have to use version 1.7 of git when
>> generating the tarball and signature -- I recall Greg having a similar
>> problem in the past.
>
> Ugh, yes, that seems to be it. Current git generates different
> tar-files than older releases do:
>
>    tar-1.7.9.7 tar-cur differ: byte 107, line 1
>
> and a quick bisection shows that it is due to commit 10f343ea814f
> ("archive: honor tar.umask even for pax headers") in the current git
> development version.
>
> Junio, quite frankly, I don't think that that fix was a good idea. I'd
> suggest having a *separate* umask for the pax headers, so that we do
> not  break this long-lasting stability of "git archive" output in ways
> that are unfixable and not compatible. kernel.org has relied (for a
> *long* time) on being able to just upload the signature of the
> resulting tar-file, because both sides can generate the same tar-fiel
> bit-for-bit.
>
> So instead of using "tar_umask", please make it use "tar_pax_umask",
> and have that default to 000. Ok?
>
> Something like the attached patch.
>
> Or just revert 10f343ea814f entirely.

My preference for this particular one however is to simply revert
it.  I do not see much point in bending backwards to treat older
implementations of tar that do not understand extended pax headers
very specially by adding a separate option or configuration, even
though I wouldn't have minded if the original implementation were to
apply the same umask for these entries that look like "dummy files"
to them.

I have to wonder why 10f343ea (archive: honor tar.umask even for pax
headers, 2014-08-03) is a problem but an earlier change v1.8.1.1~8^2
(archive-tar: split long paths more carefully, 2013-01-05), which
also should have broken bit-for-bit compatibility, went unnoticed,
though.  What I am getting at is that correcting past mistakes in
the output should not be forbidden unconditionally with a complaint
like this.

If 10f343ea were an important fix, then my preference would have
been to instead add "tar_ignore_umask_in_pax_header" to allow those
who care more about bit-for-bit compatibility with older broken
versions than correctness to conditionally disable its code.  But I
do not think it is, so my preference isn't.

Thanks.
