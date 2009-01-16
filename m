From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH take 3 0/4] color-words improvements
Date: Thu, 15 Jan 2009 17:37:50 -0800
Message-ID: <7vy6xcowsx.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de>
 <87ljtdk9b3.fsf@iki.fi> <200901142059.09005.trast@student.ethz.ch>
 <alpine.DEB.1.00.0901142258250.3586@pacific.mpi-cbg.de>
 <8763khtbfc.fsf@iki.fi>
 <alpine.DEB.1.00.0901151337080.3586@pacific.mpi-cbg.de>
 <7vmydstoys.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901151940170.3586@pacific.mpi-cbg.de>
 <adf1fd3d0901151610p41930ee2gfc7259aee7e15d73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Teemu Likonen <tlikonen@iki.fi>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 02:39:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNdgE-00083V-HD
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 02:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778AbZAPBiG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2009 20:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343AbZAPBiF
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 20:38:05 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54914 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132AbZAPBiD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2009 20:38:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A271F9063F;
	Thu, 15 Jan 2009 20:37:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5264A9063D; Thu,
 15 Jan 2009 20:37:53 -0500 (EST)
In-Reply-To: <adf1fd3d0901151610p41930ee2gfc7259aee7e15d73@mail.gmail.com>
 (Santi =?utf-8?Q?B=C3=A9jar's?= message of "Fri, 16 Jan 2009 01:10:34 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4EA80064-E36E-11DD-A66D-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105900>

Santi B=C3=A9jar <santi@agolina.net> writes:

> It may be ok and logical, but for me it is not what I want. Mmaybe I
> don't really undestand what I want or is a crazy idea but here it is
> anyway:
>
> Take a simple case with this two lines :
>
> matrix[a,b,c]
> matrix{d,b,c}
>
> there is no space so the standard color-words does not help to
> visualize that matrix, the b and c are not changed.
>
> What I currently do is to add some spaces:
>
> matrix[ a, b, c ]
> matrix{ d, b, c }
>
> then the color-words at least says that "b, c" is unchanged.
>
> What I would like is that --color-words would act as adding this
> spaces automatically (and even one after "matrix").
>
> Or another way to think it could be:
>
> a) primary words are those with alphanumerics (or a regex)
> b) secondary "words" are the other non-whitespaces characters (in thi=
s
> case "[]{} and ,"
> c) whitespaces are cruft.

Dscho and Thomas discussed and designed a way to mark "words look like
this" (and anything that are not words are crufts), and Dscho further
argues that it is Ok to discard crufts (which I think is fine).

What you seem to want in this example is "there is no cruft other than
whitespace, but there are different kinds of words".  I do not think it=
 is
incompatible with the way crufts are discarded, but it may be incompati=
ble
with the way how words are identified.

I would expect something like:

	[a-zA-Z0-9]+|[^ a-zA-Z0-9]+

should define your "two kinds of words".  That is, a run of alnums is a
word, and a run of non-alnums is a word, but "matrix[a" is not a word (=
it
is a sequence of three words "matrix", "[" and "a").
