From: =?UTF-8?B?IkphbiBILiBTY2jDtm5oZXJyIg==?= <schnhrr@cs.tu-berlin.de>
Subject: Re: [PATCH 5/5] format-patch: tests: check rfc822+rfc2047 in to+cc
 headers
Date: Wed, 10 Oct 2012 12:44:00 +0200
Message-ID: <50755170.1080205@cs.tu-berlin.de>
References: <1349717609-4770-1-git-send-email-schnhrr@cs.tu-berlin.de> <1349717609-4770-6-git-send-email-schnhrr@cs.tu-berlin.de> <7v391nfmzn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 12:44:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLtm5-0004Fc-CE
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 12:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755758Ab2JJKoP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 06:44:15 -0400
Received: from mail.eecsit.tu-berlin.de ([130.149.17.13]:48393 "EHLO
	mail.cs.tu-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055Ab2JJKoO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 06:44:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost-12225.cs.tu-berlin.de (Postfix) with ESMTP id 4834C6D57
	for <git@vger.kernel.org>; Wed, 10 Oct 2012 12:44:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cs.tu-berlin.de (including SpamAssassin)
Received: from mailhost.cs.tu-berlin.de ([127.0.0.1])
	by localhost (mail.cs.tu-berlin.de [127.0.0.1]) (amavisd-new, port 12224)
	with ESMTP id x8Ha7M04PNHq 04513-02;
	Wed, 10 Oct 2012 12:44:00 +0200 (CEST) 13564
Received: from [130.149.91.59] (asahi.kbs.tu-berlin.de [130.149.91.59])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: schnhrr)
	by mailhost.cs.tu-berlin.de (Postfix) with ESMTPSA;
	Wed, 10 Oct 2012 12:44:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120919 Thunderbird/10.0.7
In-Reply-To: <7v391nfmzn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207398>

Am 09.10.2012 21:45, schrieb Junio C Hamano:
> Jan H. Sch=C3=B6nherr <schnhrr@cs.tu-berlin.de> writes:
>=20
>> +test_expect_failure 'additional command line cc (rfc822)' '
>> +
>> +	git config --replace-all format.headers "Cc: R E Cipient <rcipient=
@example.com>" &&
>>  	git format-patch --cc=3D"S. E. Cipient <scipient@example.com>" --s=
tdout master..side | sed -e "/^\$/q" >patch5 &&
>> -	grep "^Cc: R. E. Cipient <rcipient@example.com>,\$" patch5 &&
>> -	grep "^ *S. E. Cipient <scipient@example.com>\$" patch5
>> +	grep "^Cc: R E Cipient <rcipient@example.com>,\$" patch5 &&
>> +	grep "^ *"S. E. Cipient" <scipient@example.com>\$" patch5
>=20
> Hrm.
>=20
> As we are not in the business of parsing out whatever junk given
> with --cc or --recipient from the command line or configuration, but
> are merely parroting them to the output stream, isn't this a
> user-error in the test that gives --cc=3D'S. E. Cipient <a@ddre.ss>'
> instead of giving --cc=3D'"S. E. Cipient" <a@ddre.ss>'?  Same comment
> on the new 'expect-failure' tests.

Originally, I just wanted to emphasize, that --to and --cc are
currently handled differently than in git-send-email, where
all this quoting/encoding is done.

And it is much more convenient to add
	--cc 'Jan H. Sch=C3=B6nherr <...>'
than
	--cc '=3D?UTF-8?q?Jan=3D20H=3D2E=3D20Sch=3DC3=3DB6nherr?=3D <...>'

Even more, since I would expect git to correctly handle
addresses given in a format that is also used elsewhere
within git.


However, I agree that we are not responsible to check/quote/encode
anything when the user supplies whole headers (though we probably
could).


But if I cannot convince you, I'll just drop this patch. :)

Regards
Jan
