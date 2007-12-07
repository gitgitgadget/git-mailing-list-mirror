From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 3/3] Color support for "git-add -i"
Date: Fri, 7 Dec 2007 13:34:51 +0100
Message-ID: <AEA9FB5E-1ABA-42D6-8FC5-95BAAA9B6BC8@wincent.com>
References: <475697BC.2090701@viscovery.net> <1196906706-11170-1-git-send-email-gitster@pobox.com> <1196906706-11170-2-git-send-email-gitster@pobox.com> <1196906706-11170-3-git-send-email-gitster@pobox.com> <5055E3DF-E01D-41B5-9F59-DAD69885CAE8@wincent.com> <7vejdzd1aw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 13:36:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0cQt-0001Fo-C6
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 13:35:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228AbXLGMff convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Dec 2007 07:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753270AbXLGMff
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 07:35:35 -0500
Received: from wincent.com ([72.3.236.74]:41802 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753072AbXLGMfe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Dec 2007 07:35:34 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB7CYpF2013044;
	Fri, 7 Dec 2007 06:34:52 -0600
In-Reply-To: <7vejdzd1aw.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67417>

El 6/12/2007, a las 21:18, Junio C Hamano escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> What are the other options?
>>
>> - Make git-add--interactive part of builtin-add so as to be able to
>> use the core.whitespace code directly? (ideally yes and at some poin=
t
>> in the future it seems inevitable that this will happen, but it will
>> require a fair bit of work)
>>
>> - Fork a second "git diff-files" process to capture the colorized
>> version of the output? (may set off the "kludge" alarm)
>>
>> - Something else?
>
> - Realize that whitespace clean-up can be risky and change semantics
>   depending on the material you are editing.  Do not do the clean-up
>   during "add -i", but before.  IOW, add an alias that does an
>   equivalent of:
>
> 	git diff HEAD >tmp
>        git apply -R <tmp
>        git apply --whitespace=3Dfix <tmp
>
>   then encourage users to clean-up their whitespace gotchas early (an=
d
>   test the result!), before even attempting to run "git add -i".

In principle I agree with what you're saying but I think I didn't make =
=20
myself clear; I wasn't talking about actually *cleaning-up* whitespace =
=20
problems from inside "git add -i", I was talking about *display* of =20
whitespace problems only. In other words, I don't want the situation =20
where I think it's ok to stage a hunk only because I mistakenly think =20
it's free of whitespace problems. In other words, if one part of Git =20
("git diff") says the diff is "this" and another part ("git add -i") =20
says the diff is "that" and there's a discrepancy, then that sounds =20
like a bug to me.

Seeing as speed is not a concern here (when displaying diffs the =20
bottleneck is really how fast the user can read, not how fast git =20
emits the text), correctness is important, and git-add--interactive =20
will eventually become part of builtin-add anyway, I personally think =20
the optimum solution is this one: run the diff tools twice, once =20
without color and once with; the former is used for internal =20
processing as before and the later is used for display only. This =20
approach has the advantage that the whitespace colorization provided =20
by "git diff-files" can evolve and become more sophisticated (per-path =
=20
attributes etc) and "git add -i" will automatically benefit from it.

But I wanted to throw the question out there for input first, in any =20
case, I have a patch implementing my proposal and I'll send it out in =20
a minute.

Cheers,
Wincent
