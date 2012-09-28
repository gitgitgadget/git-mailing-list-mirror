From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] completion: fix args of run_completion() test helper
Date: Fri, 28 Sep 2012 12:23:47 -0700
Message-ID: <7vzk4aj6ik.fsf@alter.siamese.dyndns.org>
References: <20120928100530.GL10144@goldbirke>
 <1348826975-2225-1-git-send-email-szeder@ira.uka.de>
 <1348826975-2225-2-git-send-email-szeder@ira.uka.de>
 <7vehlmm3ca.fsf@alter.siamese.dyndns.org> <20120928183840.GB10719@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Sep 28 21:24:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THgAN-00025E-Fn
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 21:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030476Ab2I1TXx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Sep 2012 15:23:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35354 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030388Ab2I1TXv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Sep 2012 15:23:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6416C8301;
	Fri, 28 Sep 2012 15:23:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=y6o4RF965jgZ
	Q/Ud6wBI+PpS4IE=; b=gcPmiCro4cskuW6uCOTXNMjtqRvFmSTMlVCgtuoQOQng
	g4QVAUCgiRpAjO0j2G7wWt9DTZdeFYgpZnr33Q9xqzZz0nq0gCyNTphoEtgCdNR9
	v1nhcdPZTgMqlraVmaU2UHawheBS0MMIFbTwvvkFKAoquIzF/3qDkhCK9ImcP6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=m/DvzK
	1+iZc6y2Tmu2IAfs5IWFbe69oJptiOIfzUGV5y0AsTbJbIEk9gFnplNcGpw5gQaJ
	EnIBBBKre8+CZjE5MDGRLMqvT9eFMJuiXL5NhqHsJvnZrsWi1/zU3QJgFyDJZG6h
	x5CT0yNYZ6QjHTHLGLGgmJIF5HukRrYdPcbco=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 514098300;
	Fri, 28 Sep 2012 15:23:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89AA382FF; Fri, 28 Sep 2012
 15:23:50 -0400 (EDT)
In-Reply-To: <20120928183840.GB10719@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of "Fri, 28 Sep 2012 20:38:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 08742E2A-09A2-11E2-8B6B-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206601>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> On Fri, Sep 28, 2012 at 11:04:05AM -0700, Junio C Hamano wrote:
>> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>>=20
>> > To simulate the the user hit 'git <TAB>, one of the completion tes=
ts
>
> s/the the/that the/
>
>> > sets up the rather strange command line
>> >
>> >   git ""
>> >
>> > i.e. the second word on the command line consists of two double
>> > quotes.  However, this is not what happens for real, because after
>> > 'git <TAB>' the second word on the command line is just an empty
>> > string.  Luckily, the test works nevertheless.
>> >
>> > Fix this by passing the command line to run_completion() as separa=
te
>> > words.
>> >
>> > Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
>> > ---
>> >  t/t9902-completion.sh | 8 ++++----
>> >  1 file changed, 4 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>> > index e7657537..f5e68834 100755
>> > --- a/t/t9902-completion.sh
>> > +++ b/t/t9902-completion.sh
>> > @@ -49,7 +49,7 @@ run_completion ()
>> >  {
>> >  	local -a COMPREPLY _words
>> >  	local _cword
>> > -	_words=3D( $1 )
>> > +	_words=3D( "$@" )
>> >  	(( _cword =3D ${#_words[@]} - 1 ))
>> >  	__git_wrap__git_main && print_comp
>> >  }
>> > @@ -57,7 +57,7 @@ run_completion ()
>> >  test_completion ()
>> >  {
>> >  	test $# -gt 1 && echo "$2" > expected
>> > -	run_completion "$@" &&
>> > +	run_completion $1 &&
>> >  	test_cmp expected out
>> >  }
>>=20
>> I can understand the other three hunks, but this one is fishy.
>> Shouldn't "$1" be inside a pair of dq?  I.e.
>>=20
>> 	+	run_completion "$1" &&
>
> No.  $1 holds all words on the command line.  If it was between a pai=
r
> of dq, then the whole command line would be passed to the completion
> script as a single word.

And these "words" can be split at $IFS boundaries without any
issues?  IOW, nobody would ever want to make words array in the
run_completion function to ['git' 'foo bar' 'baz']?
