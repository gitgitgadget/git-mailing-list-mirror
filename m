From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Aborting "git commit --interactive" discards updates to index
Date: Fri, 06 Jan 2012 21:08:07 -0800
Message-ID: <7vvcoogkw8.fsf@alter.siamese.dyndns.org>
References: <CANgJU+X+qLe3Aqy_ZpoSDKMuf=8=OxVvpkt0tGmSi=KVgti3HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 07 06:08:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjOWB-0002CW-La
	for gcvg-git-2@lo.gmane.org; Sat, 07 Jan 2012 06:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771Ab2AGFIL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Jan 2012 00:08:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44102 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750734Ab2AGFIK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2012 00:08:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 685226F43;
	Sat,  7 Jan 2012 00:08:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=7x3+9VmzqZOVuUtsRuA4ddCax
	Fw=; b=GhtPAk5QP7Nqzdl6qtJPnjLIPg0k+kyoY78uXwb0UvURQVv1vELlefhUB
	z7XD37bnnePJalK1WUFndJxnOc3aEgBHV54sW6dG1q0yGa0EqpdhAdl2NRrhCh54
	Goge4BuaVQlfabzI8JJteK0iio8KzLA4wDYAiRrXCgaFJYGd0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=XTPCewXLYTEybrwR4zA
	a+YY2Ce+JvRP0iWl2JHEpaDOqm1gLyRD5N5IzMZfsiF558ugUnifUGocdIg7+0Wc
	3qTcCDnVrZyabaRw+6xp7k2wbAPnr7TZPmjLrR8XLi1PyArYNSvKdt5C1ZUgluUO
	Z9iLTnujz354P0u89+389XN4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FB0E6F42;
	Sat,  7 Jan 2012 00:08:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D70C06F41; Sat,  7 Jan 2012
 00:08:08 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 96F5BB22-38ED-11E1-A324-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188064>

demerphq <demerphq@gmail.com> writes:

> On 27 June 2011 17:59, Junio C Hamano <gitster@pobox.com> wrote:
>> The latest feature release Git 1.7.6 is available at the usual
>> places:
>>
>>  http://www.kernel.org/pub/software/scm/git/
> [snip]
>>  * Aborting "git commit --interactive" discards updates to the index
>>   made during the interactive session.
>
> Hi, I am wondering why this change was made?

I wasn't directly involved in this particular part of the design of wha=
t
should happen to the index when a commit is aborted, so I would be a ba=
d
person to give you the first answer, but let's try.

If a "commit" session is aborted, it is logical to revert whatever has
been done inside that session as a single logical unit, so I do not
particularly find the current behaviour so confusing. It might even mak=
e
more sense if we update "commit -i" and "commit -a" to also revert the
index modification when the command is aborted for consistency.

You are welcome to rehash the age old discussion, though. Personally I =
do
not care very deeply either way. I would never use "commit --interactiv=
e"
myself, and I would not encourage others to use it, either, even if we =
do
not worry about the behaviour when a commit is aborted.

One thread of interest (there are others, as this change was rerolled a=
t
least a few times) may be

    http://thread.gmane.org/gmane.comp.version-control.git/173033/focus=
=3D173035

Having said all that,...

> .... I am writing this after spending about 45 minutes showing a
> colleague how to use git commit --interactive, when we realized that
> we had forgotten to add a file....

=2E.. if your partial commit is so complex that you need to spend 45 mi=
nutes
to sift what to be commited and what to be left out, you are much bette=
r
off to run "git add -i" to prepare the index, "git stash save -k" to ch=
eck
out what is to be committed (and stash away what are to be left out) so
that you can make sure what you are committing is what you thought are
committing (by asking "git diff" and "make test" for example), and afte=
r
convincing yourself that you made a good state in the index, make a com=
mit
with "git commit" (without any other arguments) and conclude it with "g=
it
stash pop" to recover the changes that you decided to leave out.

"commit --interactive" robs me from that crucial "verification" step, a=
nd
that is why I wouldn't be a user or an advocate of this "misfeature".

By the way, why did you draw =C3=86var into this discussion? I do not t=
hink he
was involved in any way with the design or implementation of this comma=
nd.
