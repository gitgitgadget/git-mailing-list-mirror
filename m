From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv4 4/4] t7510: test verify-commit
Date: Fri, 27 Jun 2014 22:26:55 +0200
Message-ID: <cf4cc867-7626-4981-898b-7de29d8c701f@email.android.com>
References: <xmqqoaxjb9rr.fsf@gitster.dls.corp.google.com> <02b475e94770ed809e18e6258d593242abd23569.1403877431.git.git@drmicha.warpmail.net> <xmqqk382173l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 22:27:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0cjh-00082F-FT
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 22:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbaF0U1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 16:27:00 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60690 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751496AbaF0U1A (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jun 2014 16:27:00 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 51E89222F8;
	Fri, 27 Jun 2014 16:26:59 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 27 Jun 2014 16:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=in-reply-to:references:mime-version
	:content-transfer-encoding:content-type:subject:from:date:to:cc
	:message-id; s=smtpout; bh=MyJRDtX2jSRLg+WBxZrI+0drwwg=; b=Wg70T
	Y1H2lZxt0R+SGIy+AoAijoTIdS8lNrC78bITgZxMPSP9VGDQYSbjOgJOzdZv+nsP
	D7pvdS2SWlDE2YK/SjzgeAxYxwhpJYz/Kn01jWrCtX/sP6hgU0woRnr4vozMhnDR
	EN1OryX7yFYlwy8nMM8Nu/inlE8C1LeUMyjBPU=
X-Sasl-enc: GalvSfMLP16Zhbqegt4tvw2gmvjwf1xYVkGbAMo9G2Su 1403900818
Received: from SevenOfNexus.fritz.box (unknown [92.76.167.160])
	by mail.messagingengine.com (Postfix) with ESMTPA id 638A468018D;
	Fri, 27 Jun 2014 16:26:58 -0400 (EDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqqk382173l.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252579>



On 27. Juni 2014 21:32:30 MESZ, Junio C Hamano <gitster@pobox.com> wrote:
>Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>>  	sed -e "s/seventh/7th forged/" raw >forged1 &&
>>  	git hash-object -w -t commit forged1 >forged1.commit &&
>> +	! git verify-commit $(cat forged1.commit) &&
>
>test_must_fail git verify-commit ... &&
>
>>  	git show --pretty=short --show-signature $(cat forged1.commit)
>>actual1 &&
>>  	grep "BAD signature from" actual1 &&
>>  	! grep "Good signature from" actual1
>> @@ -94,6 +110,7 @@ test_expect_success GPG 'detect fudged signature
>with NUL' '
>>  	cat raw >forged2 &&
>>  	echo Qwik | tr "Q" "\000" >>forged2 &&
>>  	git hash-object -w -t commit forged2 >forged2.commit &&
>> +	! git verify-commit $(cat forged2.commit) &&
>
>test_must_fail git verify-commit ... &&

Sorry for missing or mis-rebasing these. I meant to cover them all.

>
>>  	git show --pretty=short --show-signature $(cat forged2.commit)
>>actual2 &&
>>  	grep "BAD signature from" actual2 &&
>>  	! grep "Good signature from" actual2
>> @@ -102,6 +119,7 @@ test_expect_success GPG 'detect fudged signature
>with NUL' '
>>  test_expect_success GPG 'amending already signed commit' '
>>  	git checkout fourth-signed^0 &&
>>  	git commit --amend -S --no-edit &&
>> +	git verify-commit HEAD &&
>>  	git show -s --show-signature HEAD >actual &&
>>  	grep "Good signature from" actual &&
>>  	! grep "BAD signature from" actual
>
>Most of the tests, unlike "git show --show-signature" tests, do not
>seem to check the output from the command.  Is it because its
>primary interface to scripts is its exit status [*1*]?
>
>[Footnote]
>
>*1* "Yes" is totally an acceptable answer and a justification for
>not checking the output in many of these tests.

Yes, the idea was to check the exit status in all cases (the loopy subtests) and the textual output in a few exemplary ones. I didn't want to bloat the test unnecessarily.

Michael
