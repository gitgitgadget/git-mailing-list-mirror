From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach git-gui to split hunks
Date: Wed, 12 Dec 2007 14:54:02 -0800
Message-ID: <7vbq8v7cdx.fsf@gitster.siamese.dyndns.org>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com>
	<31e9dd080712111114t2bbdba60m18b7d6210f3f9174@mail.gmail.com>
	<e5bfff550712111133j66c4b9adx9f57661cc720aa41@mail.gmail.com>
	<402731c90712111254q1cb99c6al47538971d93b4592@mail.gmail.com>
	<31e9dd080712111329j2c8b22ebs38ab727a5fbe85fb@mail.gmail.com>
	<20071212041002.GN14735@spearce.org>
	<31e9dd080712112113u44b30c62ja012951fba958c5d@mail.gmail.com>
	<20071212052329.GR14735@spearce.org>
	<31e9dd080712120702k36a959cfh3e2a5c5fb076d922@mail.gmail.com>
	<Pine.LNX.4.64.0712121814260.27959@racer.site>
	<31e9dd080712121050i45981ed5u845b71f0e73aa8e2@mail.gmail.com>
	<Pine.LNX.4.64.0712121931050.27959@racer.site>
	<7vk5nj7jkp.fsf@gitster.siamese.dyndns.org>
	<7A812021-DCEC-49D4-895B-2DCBEFA7CA2E@yahoo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jason Sewall <jasonsewall@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, David <davvid@gmail.com>,
	Marco Costalba <mcostalba@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Jean-Fran=C3=A7ois?= Veillette 
	<jean_francois_veillette@yahoo.ca>
X-From: git-owner@vger.kernel.org Wed Dec 12 23:55:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2aU0-0006OV-UV
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 23:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781AbXLLWy3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2007 17:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754773AbXLLWy2
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 17:54:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41218 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbXLLWy1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2007 17:54:27 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 927AF565D;
	Wed, 12 Dec 2007 17:54:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 863B6565B;
	Wed, 12 Dec 2007 17:54:05 -0500 (EST)
In-Reply-To: <7A812021-DCEC-49D4-895B-2DCBEFA7CA2E@yahoo.ca> (=?utf-8?Q?Je?=
 =?utf-8?Q?an-Fran=C3=A7ois?=
	Veillette's message of "Wed, 12 Dec 2007 15:50:47 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68107>

Jean-Fran=C3=A7ois Veillette <jean_francois_veillette@yahoo.ca> writes:

>> Well, the question was not very well stated.  I know what it means -=
-
>> remove that old line, without replacing with the corrected/updated
>> one.
>> The real question is how would that be useful?
>
> I often get big hunk just because I modified whitespaces around
> relevent pieces of code, the ability to segment the changes and only
> pick isolated and specific lines for a commit (not commiting
> whitespaces surrounding real code changes) would be very welcome.
> Maybe I should know better, but the actual hunk selection in git gui
> is quite good already, but the ability to be more precise on how a
> hunk is defined is a welcome change.

Oh, I wasn't questioning the usefulness of hunk splitting in general.
It is sometimes useful and that is why we have "add -i".

If you have something like this:

        @@ -j,k +l,m @@
         common 1
         common 2
        -preimage
        +postimage
         common 3
        -deleted
         common 4
         common 5

I think it makes sense to split it into two logical (overlapping) hunks=
:

        @@ -j,(k-3) +l,(m-2) @@
         common 1
         common 2
        -preimage
        +postimage
         common 3

and

        @@ -j,(k-3) +l,(m-3) @@
         common 3
        -deleted
         common 4
         common 5

and being able to apply one of them independent from the other, or
re-combine them back into one hunk.

I was just questioning if it makes sense to split a hunk like this in
the middle of -/+ lines:

	@@ -j,k +l,m @@
	 common
	 common
	-pre 1
	-pre 2
        -pre 3
        +post 1
	+post 2
	 common

You could split between "-pre 2" and "-pre 3", but I do not think that
would be so useful.  It is a different story if you allowed the above t=
o
first be transformed into this way (assuming that "pre 1" and "pre 2"
corresponds to "post 1"):

	@@ -j,k +l,m @@
	 common
	 common
	-pre 1
	-pre 2
        +post 1
        -pre 3
	+post 2
	 common

and then be split between "+post 1" and "-pre 3".  That may make sense
in some context.
