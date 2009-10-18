From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 0/3] Generalized "string function" syntax
Date: Sun, 18 Oct 2009 10:24:50 +0200
Message-ID: <4ADAD0D2.504@lsrfire.ath.cx>
References: <1255681702-5215-1-git-send-email-gitster@pobox.com> <4ADA3153.7070606@lsrfire.ath.cx> <7v63ad5o8p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 18 10:25:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzR4z-00067T-Ui
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 10:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754233AbZJRIZD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Oct 2009 04:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753088AbZJRIY7
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 04:24:59 -0400
Received: from india601.server4you.de ([85.25.151.105]:46883 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777AbZJRIY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 04:24:56 -0400
Received: from [10.0.1.101] (p57B7B975.dip.t-dialin.net [87.183.185.117])
	by india601.server4you.de (Postfix) with ESMTPSA id EACF72F8065;
	Sun, 18 Oct 2009 10:24:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7v63ad5o8p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130590>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Junio C Hamano schrieb:
>>> I mentioned an idea to enhance the pretty=3Dformat language with a
>>> string function syntax that people can extend by adding new functio=
ns
>>> in one of the "What's cooking" messages earlier.  The general synta=
x
>>> would be like
>>>
>>> %[function(args...)any string here%]
>>>
>>> where "any string here" part would have the usual pretty=3Dformat
>>> strings. E.g.  git show -s --format=3D'%{w(72,8,4)%s%+b%]' should g=
ive
>>> you a line wrapped commit log message if w(width,in1,in2) is such a
>>> function.
>> I pondered line wrapping with format strings briefly a long time ago=
, and
>> I always considered it to be more similar to a colour, i.e. a state =
that
>> one can change and that is applied to all following text until the n=
ext
>> state change.  (Except that it's always reset at the end of the form=
at
>> string.)  The example above would then turn into '%w(72,8,4)%s%+b'.
>=20
> As a syntax to express "wrapping" behaviour alone, I think this is mu=
ch
> simpler and more superiour.  I guess with this if you want to wrap
> something to 72 columns and then wrap something else to 66 columns, y=
ou
> would write '%w(72,8,4)something%w(66,8,4)something else', right?

That's right.

> I used %] only for two reasons.
>=20
>  - Without an explicit "here it ends", I couldn't come up with a good=
 way
>    to express '%[w(72,8,4)something%]something else'.  IOW, how I can=
 say
>    "wrap something to 72 columns and then place something else withou=
t any
>    wrapping"?

My patch makes '%w()' reset the wrapping parameters to their defaults.

>  - When we need to support more than one string function like this, i=
t is
>    unclear what '%f()one string%g()another one' in your syntax means.
>    Does it mean '%[f()one string%]%[g()another one%]' (i.e. concatena=
te
>    the result of applying string function f to 'one string' and the r=
esult
>    of applying string function g to 'another one')?  Or does it mean
>    '%[f()one string%[g()another one%]%]' (apply 'f' to concatenation =
of
>    'one string' and the result of applying 'g' to 'another one')?

I was going to say that we already have something like that with %C, an=
d
that the natural way (to me) is to apply them both, independently.  Cas=
e
modification functions (upper, lower, capitalized) could be treated the
same way -- as state changes (like pressing caps lock when typing text)=
=2E

Which other text functions are we going to add which would break this
model?  The only thing I can think of right now is nesting such
functions themselves, e.g. when indenting a list in an indented
sub-paragraph in an indented paragraph.  Useful?

But then something else hit me: the line wrap function needs to conside=
r
colour codes as having a length of zero.  Ugh.

Ren=C3=A9
