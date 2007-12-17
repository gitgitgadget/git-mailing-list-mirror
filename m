From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Re-re-re-fix common tail optimization
Date: Mon, 17 Dec 2007 11:59:22 +0100
Message-ID: <36E62F9B-26FF-4DC0-99B8-D6DC2B960E67@wincent.com>
References: <20071215155150.GA24810@coredump.intra.peff.net> <7vprx7n90t.fsf@gitster.siamese.dyndns.org> <20071215200202.GA3334@sigill.intra.peff.net> <20071216070614.GA5072@sigill.intra.peff.net> <7v8x3ul927.fsf@gitster.siamese.dyndns.org> <7v7ijejq6j.fsf@gitster.siamese.dyndns.org> <20071216212104.GA32307@coredump.intra.peff.net> <7v3au2joo2.fsf_-_@gitster.siamese.dyndns.org> <20071216221545.GA32596@coredump.intra.peff.net> <7vtzmii8io.fsf@gitster.siamese.dyndns.org> <20071216222919.GA2260@coredump.intra.peff.net> <EBD73F46-810F-4605-972C-54EED0EF9A63@wincent.com> <Pine.LNX.4.64.0712171038130.9446@racer.site>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 17 12:01:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4DiU-0004Rh-Hq
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 12:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935628AbXLQLAE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Dec 2007 06:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935549AbXLQLAB
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 06:00:01 -0500
Received: from wincent.com ([72.3.236.74]:57938 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935453AbXLQK76 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2007 05:59:58 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBHAxNjC018926;
	Mon, 17 Dec 2007 04:59:39 -0600
In-Reply-To: <Pine.LNX.4.64.0712171038130.9446@racer.site>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68538>

El 17/12/2007, a las 11:39, Johannes Schindelin escribi=F3:

> Hi,
>
> On Mon, 17 Dec 2007, Wincent Colaiuta wrote:
>
>> El 16/12/2007, a las 23:29, Jeff King escribi?:
>>
>>> On Sun, Dec 16, 2007 at 02:23:27PM -0800, Junio C Hamano wrote:
>>>
>>>>> Aren't we using "git diff" for the second diff there nowadays?
>>>>
>>>> Some people seem to think that is a good idea, but I generally do
>>>> not like using "git diff" between expect and actual (both =20
>>>> untracked)
>>>> inside tests.  The last "diff" is about validating what git does =20
>>>> and
>>>> using "git diff" there would make the test meaningless when "git
>>>> diff" itself is broken.
>>>
>>> I think that is a valid concern. But ISTR that were some issues wit=
h
>>> using GNU diff. Commit 5bd74506 mentions getting rid of the =20
>>> dependency
>>> in all existing tests, but gives no reason.
>>
>> I'd say it's safe and sensible to use "git diff" in all tests =20
>> *except*
>> for tests of "git diff" itself.
>
> To the contrary.  It has to test "git diff", so it must use "git =20
> diff".

Obviously, you can only test "git diff" by actually running it.

> As for the reference output: we include the expected diffs as texts, =
=20
> and
> therefore do not really have to rely on having GNU diff installed.
>
> Besides, we cannot even test the goodies like "rename from" by =20
> comparing
> to GNU diff's output.

Sorry, I didn't make myself clear. That's not what I was proposing at =20
all. I was talking about this kind of example:

> +	git diff -U0 | sed -e "/^index/d" -e "s/$z2047/Z/g" >actual &&
> +	diff -u expect actual


=46irst line uses "git diff", if the second line uses "git diff" as wel=
l =20
and "git diff" happens to be broken then you're using a broken tool to =
=20
test a broken tool, as Junio already pointed out. I presumed that if =20
you had read the whole thread then that would be obvious (look at the =20
quoted section from Junio above).

In the example you're not interested in the details of the output =20
format, only in the exit status, so it is appropriate to use diff =20
instead of "git diff".

Wincent
