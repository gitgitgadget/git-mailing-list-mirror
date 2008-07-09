From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash: offer only paths after '--'
Date: Tue, 08 Jul 2008 17:06:43 -0700
Message-ID: <7vprpnq5t8.fsf@gitster.siamese.dyndns.org>
References: <279b37b20807071341k3551e61cl10c5969600ba8218@mail.gmail.com>
 <20080708044922.GD2542@spearce.org>
 <7vprppvt7a.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807081335470.4319@eeepc-johanness>
 <20080708165614.GB8224@neumann> <7vtzf0rusw.fsf@gitster.siamese.dyndns.org>
 <20080708231837.GA16895@spearce.org> <20080708235153.GD8224@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Jul 09 02:08:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGNE5-00034v-B4
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 02:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbYGIAHE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2008 20:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbYGIAHE
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 20:07:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64479 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbYGIAHD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2008 20:07:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 44C1516635;
	Tue,  8 Jul 2008 20:07:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5FC0716634; Tue,  8 Jul 2008 20:06:52 -0400 (EDT)
In-Reply-To: <20080708235153.GD8224@neumann> (SZEDER =?utf-8?Q?G=C3=A1bor'?=
 =?utf-8?Q?s?= message of "Wed, 9 Jul 2008 01:51:53 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F44E5FF0-4D4A-11DD-8AC5-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87815>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> On Tue, Jul 08, 2008 at 11:18:37PM +0000, Shawn O. Pearce wrote:
>> Junio C Hamano <gitster@pobox.com> wrote:
>> > SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>> > > +		c=3D$((++c))
>> >=20
>> > This assignment is somewhat curious, although it should work as ex=
pected
>> > either way ;-)
> ...
> Maybe an old C++ "heritage"?  In C++ it matters for class types (e.g.
> iterators), because the postfix operator might be slower than the
> prefix.

Heh, I was not talking about prefix vs postfix but about the assignment
into the variable that is incremented as a side effect of evaluating th=
e
left hand side.  If you know the variable is incremented already there =
is
no point in assigning the resulting value to it ;-)

	c=3D$(( $c + 1 ))

would have avoided such an uneasy feeling, and would have been more
portable.  Even though $((x)) and $(($x)) are supposed to evaluate the
same, some shells do not like dollar-less variable names in arithmetic
expansion, and prefix/postfix increment/decrement are not required to b=
e
supported by POSIX.

But this script being bash completion, we can use as much bashism as we
want here; perhaps I would have written:

	: $((c++))
       =20
