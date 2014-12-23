From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH w/signoff] pre-push.sample: Remove unwanted `IFS=' '`.
Date: Mon, 22 Dec 2014 18:08:59 -0800
Message-ID: <xmqq7fxj5d8k.fsf@gitster.dls.corp.google.com>
References: <1419185665-19988-1-git-send-email-gjthill@gmail.com>
	<1419186337-20348-1-git-send-email-gjthill@gmail.com>
	<xmqqtx0obzwm.fsf@gitster.dls.corp.google.com>
	<CAEE75_0Ff7NfQYUPrA414N9E0AE6LsS2zs0kL=BJ25bjPgom_w@mail.gmail.com>
	<xmqqlhm0botq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Aaron Schrab <aaron@schrab.com>
To: Jim Hill <gjthill@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 03:09:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3EuL-0003GH-V1
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 03:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927AbaLWCJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 21:09:04 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751241AbaLWCJD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 21:09:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F68F298F3;
	Mon, 22 Dec 2014 21:09:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GMsuNw3XUOux1jdk6uvzETPnITA=; b=OTP4Gu
	MB8xSqe+eIWsKr5ujqy5VM0IjDSi6OQEMhj5YzgyNTH39DJpZ3V+i0Al/IsooyRl
	RgueAF11FrhXm31gaCrW9s+gs+Jg9nQ8lS4G746XyBoOViY2d972UIoGkHefKMgi
	j8pjBt4sN7QzzPJ058ArI8LS+JaJZPcUrvJ+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qUqxx3YaLMekzASCQ3LQIySXPHZNCS50
	ybOzwg8QxUvC3cypX/+Fu4auCc2/bnV2TFAG0g0Hu1qLSu2sLJy4xbvUwxCi7+5r
	eZ5LDS5goIJ6RbCXMUvXbc4yCfWT95uYpk89ryOLS6WMyzhEvjlKInBY9Ob9jxD8
	b+JONVT92xk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 56B9A298F2;
	Mon, 22 Dec 2014 21:09:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A8C8E298F0;
	Mon, 22 Dec 2014 21:09:00 -0500 (EST)
In-Reply-To: <xmqqlhm0botq.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sun, 21 Dec 2014 14:49:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A924F8B2-8A48-11E4-A847-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261708>

Junio C Hamano <gitster@pobox.com> writes:

> Jim Hill <gjthill@gmail.com> writes:
>
>> I call it unwanted because the default works fine with the actual
>> input and explicitly limiting whitespace this way breaks most command
>> substitution.
>
> OK.  I'd call that "unnecessary", not "unwanted", though.
>
> It becomes unwanted only when somebody cuts and pastes and changes
> what happens inside the body of the loop without thinking what IFS
> assignment is doing.
>
> Leaving it to the default is not wrong per-se, but I think it is
> better to justify this change as protecting cut-and-paste people,
> which is its primary benefit as far as I can see.
>
> Thanks for noticing.

FYI, here is what I queued for today's integration cycle (you should
be able to find it in 'pu' branch).

-- >8 --
From: Jim Hill <gjthill@gmail.com>
Date: Sun, 21 Dec 2014 11:26:00 -0800
Subject: [PATCH] pre-push.sample: remove unnecessary and misleading IFS=' '

The sample hook explicitly sets IFS to SP and nothing else so that
the "read" used in the per-ref while loop that iterates over
"<localref> SP <localsha1> SP <remoteref> SP <remotesha>" records,
where we know refs and sha1s will not have SPs, would split them
correctly.

While this is not wrong per-se, it is not necessary; because we know
these fields do not contain HT or LF, either, we can simply leave
IFS the default.

This will also prevent those who cut and paste from this sample from
getting bitten when they write things in the per-ref loop that need
splitting with the default $IFS (e.g. use $(git rev-list ...) to
produce one-record-per-line output).

Signed-off-by: Jim Hill <gjthill@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 templates/hooks--pre-push.sample | 1 -
 1 file changed, 1 deletion(-)

diff --git a/templates/hooks--pre-push.sample b/templates/hooks--pre-push.sample
index 69e3c67..6187dbf 100755
--- a/templates/hooks--pre-push.sample
+++ b/templates/hooks--pre-push.sample
@@ -24,7 +24,6 @@ url="$2"
 
 z40=0000000000000000000000000000000000000000
 
-IFS=' '
 while read local_ref local_sha remote_ref remote_sha
 do
 	if [ "$local_sha" = $z40 ]
-- 
2.2.1-321-gd161b79
