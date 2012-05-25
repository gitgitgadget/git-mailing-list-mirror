From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach ignore machinery about pattern "/"
Date: Fri, 25 May 2012 10:32:46 -0700
Message-ID: <7vlikgtbcx.fsf@alter.siamese.dyndns.org>
References: <1337950056-26491-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 19:32:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXyNi-0002mv-NS
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 19:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482Ab2EYRcu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 May 2012 13:32:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56911 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781Ab2EYRct convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 May 2012 13:32:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF4C18B07;
	Fri, 25 May 2012 13:32:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0Gt63ux5EozB
	z805LDbqgLQGxIk=; b=JSTm9dtXW/4gUYSLmyjSOf0T9YdGsEN0JPvNu+LbysvZ
	pTlooNEtKi7xXt9kgsYc+aCVmoWjxp+Te/fB+j/UGabLLgynl6376GwDzmGl59Ik
	Uu0O8TjZg5G0/Pz0Q6wCbaf3qCtuSAxMV9/0cczgoTYeu+5f8TGtzTnYybPdGOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=R0zWUa
	fwZD3R7ciz76UFbSKt1fDqyYgp0J7DqEy2zfvNWkX2AtomXPkTy6HPDjsMaLfsie
	T1iMLAmCtNOkf1b5Agu27j1o9NpC6iZgMY0OnBbJ96iReqXGypuws0KaK/cQWCaK
	2bXRXxsbSwDckvFBcGUcjlFMHLBpyZTjUPaaY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B708C8B06;
	Fri, 25 May 2012 13:32:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BDFE8B05; Fri, 25 May 2012
 13:32:48 -0400 (EDT)
In-Reply-To: <1337950056-26491-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 25 May
 2012 19:47:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A546DFAC-A68F-11E1-94BC-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198490>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Pattern "/" is ambiguous because the slash can mean "anchor the
> pattern to this location" (e.g. /path), but it can also mean
> "match directories only" (e.g. path/). Currently git interprets it as
> the latter except that 'path' is an empty string, which makes this
> pattern totally useless.

Did the old version interprete it as the former?  How does the above
observation relate to the end-user help request in the other thread?

When talking about an ambiguous expression X that can be in multiple wa=
ys
and each interpretation gives surprisingly different result, if there a=
re
ways A, B and C to unambiguously spell each and every of its possible a=
nd
useful interpretations, and if one of the interpretations C is to ignor=
e
the expression altogether, it is preferrable to either

 (1) warn if it does not trigger anything useful to write a no-op; or
 (2) just ignore it if a no-op is a meaningful behaviour

when you see X.

> On the other hand, it's intuitive to read '/' as "match root
> directory", or equivalent to "/*". (The other way to see it is "match
> all directories", which leads to the same result).

I am a bit confused about the above, especially "The other way" part.

Does this alternative interpretation view "/" as "/foo" whose "foo"
happens to be an empty string, or does it view "/" as "foo/" whose "foo=
"
happens to be an empty string?

The former would mean "ignore foo, and don't bother descending into foo=
 if
it is a directory, as everything in it is ignored", while the latter wo=
uld
mean "anywhere in this directory and its subdirectories, if we see foo
that is a directory, don't bother descending into it as everything in i=
t
is ignored."

What I am trying to get at is why you are making '/' the same as '/*' a=
s
opposed to '*/', '/*/', or even a plain '*'.

> One may wonder why bother an "ignore all" pattern. The pattern is
> useful when you want to keep just a small portion of the working
> directory. But that's still a rare case.
>
> A more popular case would be sparse checkout, where ignore rules are
> used to _include_. The thus now "include all" pattern is used to say
> "make a sparse checkout that includes everything except this and
> this".

If the "sparse checkout" hack writes "/" for whatever reason, it should=
 be
corrected to write "*" (or perhaps "/*") instead.  I do not see it as a
valid factor to affect when we decide what should be done for a possibl=
y
ambiguous "/" entry in the exclude machinery.

> Recognize this special pattern and turn it the working equivalence
> pattern "/*"

Regardless of the answer to the "is it *, /*, */ or /*/" question above=
,
I do not think silent conversion is a right solution for the ambiguity.
