From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] add: ignore only ignored files
Date: Mon, 24 Nov 2014 09:41:00 -0800
Message-ID: <xmqqzjbgwl77.fsf@gitster.dls.corp.google.com>
References: <546F5CC7.8060904@drmicha.warpmail.net>
	<b4834f562679d7ccad683463edc61db5ea962d8d.1416585536.git.git@drmicha.warpmail.net>
	<20141121180105.GB26650@peff.net> <5470A4C0.3070501@web.de>
	<20141122191932.GA13340@peff.net>
	<xmqqvbm5yehk.fsf@gitster.dls.corp.google.com>
	<20141123194624.GB16605@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 24 18:41:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsxdO-0004ZJ-Ur
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 18:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604AbaKXRlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 12:41:05 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61087 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752662AbaKXRlE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 12:41:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3400A21465;
	Mon, 24 Nov 2014 12:41:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BF9NgT+aFKujfkqdEfdDCXgcVFg=; b=YhepnL
	eodJjasHtNnWYUUekLa3VAZoLvhQ4lz6fUlBTi1h47pk6GGEzamJgmsz3v7naU/4
	NmmD3/MEwqD32XedkNdf6wzWNiUGoc00ihAMuoeDyQd0zpgq61R2DsSJmdnxlctd
	5NlxTyRP09wks1IHF41wjbzNuvWEqVZesv7rM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mzk2G14HB0mItR9YNhc0Er77RvaB3X/r
	+GoWQljWaIqenRrIQKlADULjKDo9xdVtmILTmiHMZHOSiXddNO6QkTuvMc1eawz5
	MDmHtK0pg4AhyFr8rttX8KCeEkB1jv/05avk4v/Z4CPSCeobEDObpjulRboZvHTz
	zWSDQsMppZ4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B2B821464;
	Mon, 24 Nov 2014 12:41:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B0CD21462;
	Mon, 24 Nov 2014 12:41:02 -0500 (EST)
In-Reply-To: <20141123194624.GB16605@peff.net> (Jeff King's message of "Sun,
	23 Nov 2014 14:46:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0F2E4FEA-7401-11E4-9C2E-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260132>

Jeff King <peff@peff.net> writes:

> On Sun, Nov 23, 2014 at 10:10:47AM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > ... Possibly because I do not know that those instructions
>> > are written down anywhere. We usually catch such things in review these
>> > days, but there are many inconsistent spots in the existing suite.
>> 
>> t/README has this
>> 
>>     Don't:
>> 
>>      - use '! git cmd' when you want to make sure the git command exits
>>        with failure in a controlled way by calling "die()".  Instead,
>>        use 'test_must_fail git cmd'.  This will signal a failure if git
>>        dies in an unexpected way (e.g. segfault).
>> 
>>        On the other hand, don't use test_must_fail for running regular
>>        platform commands; just use '! cmd'.
>
> Thanks, I did not actually look and relied on my memory, which was
> obviously wrong. I agree that the instructions there are sufficient.
>
>> Do we refer to t/README from CodingGuidelines where we tell the
>> developers to always write tests to prevent other people from
>> breaking tomorrow what you did today?  If not, perhaps that is what
>> needs to be added.
>
> That might make sense. It might also be that Torsten simply overlooked
> it when asking his question (i.e., there is nothing to fix,
> documentation is not always read completely, and we can move on).

We actually do not have a reference to it anywhere.  For now, this
should suffice.

 Documentation/SubmittingPatches | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index fa71b5f..a3861a6 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -57,7 +57,8 @@ change, the approach taken by the change, and if relevant how this
 differs substantially from the prior version, are all good things
 to have.
 
-Make sure that you have tests for the bug you are fixing.
+Make sure that you have tests for the bug you are fixing.  See
+t/README for guidance of writing tests.
 
 When adding a new feature, make sure that you have new tests to show
 the feature triggers the new behaviour when it should, and to show the
