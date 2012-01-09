From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][RFC] git on Mac OS and precomposed unicode
Date: Mon, 09 Jan 2012 11:29:58 -0800
Message-ID: <7vty44eksp.fsf@alter.siamese.dyndns.org>
References: <201201072059.19103.tboegi@web.de>
 <7vboqehpxm.fsf@alter.siamese.dyndns.org> <4F0B196B.8010904@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 09 20:30:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkKv5-00089E-93
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 20:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933028Ab2AITaE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jan 2012 14:30:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64424 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932942Ab2AITaC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2012 14:30:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 731777E77;
	Mon,  9 Jan 2012 14:30:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FGu0fYR2vPzN
	z6Jm6Lt9Hhud+ls=; b=UcEmO/95hEIAhXWfA4CYBNstcWWJ5AIUfzLEBrQdCZl4
	v1hFQbpKqXTC/rR1YBISTNT9KKw17gdL3pdNllBBWr9bQi4LTiymIVgU2ldJTXHj
	HV99RlefRFRS2BNa/7ur3A7VDuqvRSUNYNBmDryZx9Ifpk5IyODzZljuJPvCftM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oIfu6U
	77AOHHi5VQMQAbcIg8U3kCC1AsbWvVWUSd3/nTDtHzTWa7GidbeV+lh/heKlZZO8
	XIW4X2uAAz2JJtiOuG+LU2uD+iD5f7Kw9qUU4o7TmB44bzahhp/m/dIlNi+2AENE
	ztKlxEragEM7w7bEeIabxj0MsJegjyWzy2eXE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A1087E75;
	Mon,  9 Jan 2012 14:30:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BBE647E74; Mon,  9 Jan 2012
 14:29:59 -0500 (EST)
In-Reply-To: <4F0B196B.8010904@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Mon, 09 Jan 2012 17:44:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51E0CEF2-3AF8-11E1-A458-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188183>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 08.01.12 03:46, Junio C Hamano wrote:
> ...
>> That also sounds sensible, but...
>>=20
>>> This is done in git.c by calling argv_precompose() for all commands
>>> except "git commit".
>>=20
>> ... I think it generally is a bad idea to say "all except foo". Ther=
e may
>> be a reason why "foo" happens to be special in today's code, but who=
 says
>> there won't be another command "bar" that shares the same reason wit=
h
>> "foo" to be treated specially? Or depending on the options, perhaps =
some
>> codepath of "foo" may not want the special casing and want to go thr=
ough
>> the argv_precompose(), no?
>>=20
>> After all, "git commit -- pathspec" will have to get the pathspec fr=
om the
>> command line,...
>
> Thanks Junio for catching this.
> I added a new test case as well as fixed the code.

I think you are sidestepping the real issue I raised, which is:

    What is the reason why you do not want to feed the precompose helpe=
r
    with some arguments to 'git commit', while it is OK to pass all
    arguments to other commands through precomposition?

I admit it was my fault that I did not spell it out clearly in my
response.

I understand that arguments other than pathspec and revs could be left =
in
decomposed form, but is there any harm in canonicalizing any and all
command line parameters given in decomposed form consistently into
precomposed form? What problem are you trying to solve by special casin=
g
"git commit"? That is the real question to be answered, as there may be
other commands some of whose arguments may not want to be canonicalized
due to the same reason, but you simply overlooked them. When other peop=
le
need to fix that oversight, they need a clearly written criterion what
kind of arguments should not be fixed and why.

And the reason cannot be a desire to pass the value to "--message"
argument intact [*1*]; it is not like osx cannot handle text in
precomposed form, right?

In general, I do not want to see ugly code that says "this one potentia=
lly
names a path so we add a call to fix it from decomposed form, but that
other one is not a path and we take it intact" sprinkled all over in th=
e
codebase, without a good reason.

It may seem that one alternative to munging argv[] is to have the
precomposition [*2*] applied inside get_pathspec() and have it take eff=
ect
only on the pathspecs, which after all ought to be the only place where
this matters, but I doubt it would result in maintainable code. The nam=
es
of branches and tags taken from the command line that are used as revis=
ion
names will also be compared with results from readdir in $GIT_DIR/refs/
and need to be canonicalized, for example. So I tend to agree with your
"brute force" approach to canonicalize argv[] before any real part of g=
it
sees them; that is where my suggestion to wrap main() to do so came fro=
m.

Also some commands (e.g. "rev-list --stdin") take pathspecs and revs fr=
om
their standard input stream, so you would need to be careful about them=
=2E


[Footnotes]

*1* Also as other commands like "git merge" also take textual message, =
and
you do pass the helper to canonicalize it.  No, I am not suggesting you=
 to
special case "git merge".

*2* By the way, this may need a better name if the patch touches anywhe=
re
outside compat/osx --- it is about "canonicalize pathname and pathspec
given from the command line into the form used internally by git", and
from an osx person's point of view, the only difference might be
decomposed vs precomposed, but on other odd systems it might be that
pathnames on the filesystem may be using a different encoding from what=
 is
used for pathnames in the index).
