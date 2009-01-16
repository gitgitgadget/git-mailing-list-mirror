From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH take 3 0/4] color-words improvements
Date: Fri, 16 Jan 2009 01:10:34 +0100
Message-ID: <adf1fd3d0901151610p41930ee2gfc7259aee7e15d73@mail.gmail.com>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de>
	 <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de>
	 <87ljtdk9b3.fsf@iki.fi> <200901142059.09005.trast@student.ethz.ch>
	 <alpine.DEB.1.00.0901142258250.3586@pacific.mpi-cbg.de>
	 <8763khtbfc.fsf@iki.fi>
	 <alpine.DEB.1.00.0901151337080.3586@pacific.mpi-cbg.de>
	 <7vmydstoys.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0901151940170.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 16 01:13:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNcJd-0000fq-27
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 01:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967AbZAPAKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 19:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbZAPAKi
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 19:10:38 -0500
Received: from mu-out-0910.google.com ([209.85.134.185]:1729 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbZAPAKh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 19:10:37 -0500
Received: by mu-out-0910.google.com with SMTP id g7so707305muf.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 16:10:35 -0800 (PST)
Received: by 10.103.226.20 with SMTP id d20mr951221mur.8.1232064634908; Thu, 
	15 Jan 2009 16:10:34 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901151940170.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105896>

2009/1/15 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> On Thu, 15 Jan 2009, Junio C Hamano wrote:
>> I didn't see the semantics of color-words documented in the original
>> either,
>

[...]

>> E.g. when these two are compared:
>>
>>   bbb aaa bb aa b
>>   ccc aaa cc
>>
>> what should happen?  We would want to say "aa" was removed by showing it
>> in red, but on what background should it be displayed?  cc <red>aa</red>
>> b?
>
> If we are only ever interested in the 'a's, I'd say that the output should
> only reflect that.  In other words, what the current code does (ccc
> aaa<red>aa</red> cc) is okay IMHO.  After all, we said we're interested in
> the 'a's, so we should not complain that it did not show us the removal of
> 'b's.

It may be ok and logical, but for me it is not what I want. Mmaybe I
don't really undestand what I want or is a crazy idea but here it is
anyway:

Take a simple case with this two lines :

matrix[a,b,c]
matrix{d,b,c}

there is no space so the standard color-words does not help to
visualize that matrix, the b and c are not changed.

What I currently do is to add some spaces:

matrix[ a, b, c ]
matrix{ d, b, c }

then the color-words at least says that "b, c" is unchanged.

What I would like is that --color-words would act as adding this
spaces automatically (and even one after "matrix").

Or another way to think it could be:

a) primary words are those with alphanumerics (or a regex)
b) secondary "words" are the other non-whitespaces characters (in this
case "[]{} and ,"
c) whitespaces are cruft.

(having two regexp to specify what is a words but they cannot mix).

If everything works as I think (it's late night :-) with the above two lines:

matrix[a,b,c]
matrix{d,b,c}

the word diff would be

matrix<RED>[<GREEN>{<RED>a<GREEN>d<RESET>,b,c<RED>]<GREEN>}<RED>

Santi
