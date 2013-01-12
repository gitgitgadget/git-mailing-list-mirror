From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Possible bug in `remote set-url --add --push`
Date: Fri, 11 Jan 2013 23:10:36 -0800
Message-ID: <7vliby98r7.fsf@alter.siamese.dyndns.org>
References: <CAN8TAOsnX1Mr72LPa47KKXDeUZPgSHTJ6u4YpPFPrtsK7VdN+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org
To: Jardel Weyrich <jweyrich@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 08:11:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtvF7-0002N6-BR
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 08:11:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192Ab3ALHKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 02:10:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36156 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582Ab3ALHKk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 02:10:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83EF7968E;
	Sat, 12 Jan 2013 02:10:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3tCdXNlZ9KF5Q/U1EUfcemTyhq4=; b=YyrO2q
	pmP8cNYhg5CLsf018aaQGXn5dGIDK2NO8dlKxZMmYY5/c5iRSBRukLUcAUmRwwov
	Bp14XVHnMmSx7UCudfDuR35aSuxB3Ic2qjCfhZgd3XaUbcHP75ZHR744Os4HOuh+
	qqZUeWujcXu2/34VPoGqDHrqNC7v56UXsk9gk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lLps27wCvtc6sMxSwue6LU1AGBJY5HIK
	ldAMMqttDOlhrUwcHgPl1rUI1+j3QARLJbE2f+Z4eI05dK3PwpqQe6mVETXs2vF5
	cY3N7U/i3jiCR0/1gww/1tOTb+9WI5Vi7oNZk1qUjwjnbLFURCWKSgAeHH6i3hmY
	voHRmiDloRk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7894B968C;
	Sat, 12 Jan 2013 02:10:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1E099687; Sat, 12 Jan 2013
 02:10:37 -0500 (EST)
In-Reply-To: <CAN8TAOsnX1Mr72LPa47KKXDeUZPgSHTJ6u4YpPFPrtsK7VdN+A@mail.gmail.com> (Jardel
 Weyrich's message of "Sat, 12 Jan 2013 03:44:25 -0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A95951A-5C87-11E2-8E2C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213274>

Jardel Weyrich <jweyrich@gmail.com> writes:

> I believe `remote set-url --add --push` has a bug. Performed tests
> with v1.8.0.1 and v1.8.1 (Mac OS X).
>
> Quoting the relevant part of the documentation:
>
>> set-url
>>     Changes URL remote points to. Sets first URL remote points to matching regex <oldurl> (first URL if no <oldurl> is given) to <newurl>. If <oldurl> doesn’t match any URL, error occurs and nothing is changed.
>>
>>     With --push, push URLs are manipulated instead of fetch URLs.
>>     With --add, instead of changing some URL, new URL is added.
>>     With --delete, instead of changing some URL, all URLs matching regex <url> are deleted. Trying to delete all non-push URLs is an error.
>
> Here are some steps to reproduce:
>
> 1. Show the remote URLs
>
> jweyrich@pharao:test_clone1 [* master]$ git remote -v
> origin  /Volumes/sandbox/test (fetch)
> origin  /Volumes/sandbox/test (push)
>
> 2. Add a new push URL for origin
>
> jweyrich@pharao:test_clone1 [* master]$ git remote set-url --add --push origin \
>     /Volumes/sandbox/test_clone2
>
> 3. Check what happened
>
> jweyrich@pharao:test_clone1 [* master]$ git remote -v
> origin  /Volumes/sandbox/test (fetch)
> origin  /Volumes/sandbox/test_clone2 (push)

The original pushurl was replaced with the additional one, instead
of being left and the new one getting added.  That looks certainly
wrong.

However, the result of applying the attached patch (either to
v1.7.12 or v1.8.1) still passes the test and I do not think it is
doing anything differently from what you described above.

What do you get from

	git config -l | grep '^remote\.origin'

in steps 1. and 3. in your procedure?  This question is trying to
tell if your bug is in "git remote -v" or in "git remote set-url".

-- >8 --
From 0f6cbc67db926e97707ae732b02e790b4604508e Mon Sep 17 00:00:00 2001
From: Junio C Hamano <gitster@pobox.com>
Date: Fri, 11 Jan 2013 23:04:16 -0800
Subject: [PATCH] t5505: adding one pushurl from jweyrich

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5505-remote.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index c03ffdd..b31c5bb 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -901,6 +901,25 @@ test_expect_success 'remote set-url --push --add aaa' '
 	cmp expect actual
 '
 
+test_expect_success 'remote set-url --push --add' '
+	git config remote.jweyrich.url /Volumes/sandbox/test &&
+	git config remote.jweyrich.pushurl /Volumes/sandbox/test &&
+	git config remote.jweyrich.fetch "refs/heads/*:refs/remotes/jweyrich/*" &&
+
+	added=/Volumes/sandbox/test_clone2 &&
+	{
+		git config -l | grep "^remote\.jweyrich\." &&
+		echo "remote.jweyrich.pushurl=$added"
+	} | sort >expect &&
+
+	git remote set-url --add --push jweyrich "$added" &&
+	git config -l | grep "^remote\.jweyrich\." | sort >actual &&
+
+	test_cmp expect actual &&
+
+	git remote -v | grep "^jweyrich" # this is just for debugging
+'
+
 test_expect_success 'remote set-url --push bar aaa' '
 	git remote set-url --push someremote bar aaa &&
 	echo foo >expect &&
-- 
1.8.1.421.g6236851
