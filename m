From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0008: 4 tests fail with ksh88
Date: Fri, 20 May 2016 09:10:47 -0700
Message-ID: <xmqqk2iog16g.fsf@gitster.mtv.corp.google.com>
References: <CALR6jEhviK9KZxR6R6xzkZ5EAO-RjWj3xYah_DOSDXhEjYsT-A@mail.gmail.com>
	<xmqq37pchi90.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Armin Kunaschik <megabreit@googlemail.com>
X-From: git-owner@vger.kernel.org Fri May 20 18:10:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3n0q-0002cA-08
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 18:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754907AbcETQKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 12:10:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62640 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751699AbcETQKv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 12:10:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A099C194D6;
	Fri, 20 May 2016 12:10:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N1KPhsQPS8xqASgyvF/hMbGsoSU=; b=Em0rzm
	J6C/O27SHweZG05AxRgW2/P4gSwBQZkCWkZd7PaIR+Gk8Xet3CXLH+imAtlRYwOX
	eIL4oByXmcy50HgcT3SQymhEgQFWjSoRGBGGQBHmp8yisO/soeAyWV/BnvvUMHYw
	+ZnsmN72KbIhmh+8AVD/RUlKoyCqvB328BVWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xYc1NTm5lUzs373BkeOshVGL5hGtNuOu
	KhERCr6dHAp8ikF50js2IJe5dIdpgq+s6s21mh5pseugouSuu87QDuIQEII9NGWD
	AyQOcL4fTwb63EXSGrlNSTo6UyRgpwSK+cZH3d06ATCvOyxOBYKUgrVXekCgdqKg
	Dr3Kx11ZUh8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9892E194D5;
	Fri, 20 May 2016 12:10:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0D3FF194D4;
	Fri, 20 May 2016 12:10:48 -0400 (EDT)
In-Reply-To: <xmqq37pchi90.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 20 May 2016 08:16:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6ABE5260-1EA5-11E6-AE99-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295179>

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
>> index 89544dd..b425f3a 100755
>> --- a/t/t0008-ignores.sh
>> +++ b/t/t0008-ignores.sh
>> @@ -605,7 +605,7 @@ cat <<-EOF >expected-verbose
>>         a/b/.gitignore:8:!on*   a/b/one
>>         a/b/.gitignore:8:!on*   a/b/one one

The patch was whitespace-damaged and didn't apply, so I had to redo
it from scratch while updating the log message.  If this looks good
to you, there is no need to resend.

Thanks.

-- >8 --
From: Armin Kunaschik <megabreit@googlemail.com>
Date: Fri, 20 May 2016 16:31:30 +0200
Subject: [PATCH] t0008: 4 tests fail with ksh88

In t0008, we have

	cat <<-EOF
	...
	a/b/.gitignore:8:!on*	"a/b/one\"three"
	...
	EOF

ane expect that the backslash-dq is passed through literally.

ksh88 eats \ and generates a wrong expect data to compare with.

Using \\" works this around without breaking other POSIX shells
(which collapse backslash-backslash to a single backslash), and
ksh88 does so, too.

It makes it easier to read, too, because the reason why we are
writing backslash there is *not* because we think dq is special and
want to quote it (if that were the case we would have two more
backslashes on that line).  It is simply because we want a single
literal backslash there.  Since backslash is treated specially in
unquoted here-document, explicitly doubling it to quote it expresses
our intent better than relying on the character that immediately
comes after it (i.e. '"') not being a special character.

Signed-off-by: Armin Kunaschik <megabreit@googlemail.com>
Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0008-ignores.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 89544dd..b425f3a 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -605,7 +605,7 @@ cat <<-EOF >expected-verbose
 	a/b/.gitignore:8:!on*	a/b/one
 	a/b/.gitignore:8:!on*	a/b/one one
 	a/b/.gitignore:8:!on*	a/b/one two
-	a/b/.gitignore:8:!on*	"a/b/one\"three"
+	a/b/.gitignore:8:!on*	"a/b/one\\"three"
 	a/b/.gitignore:9:!two	a/b/two
 	a/.gitignore:1:two*	a/b/twooo
 	$global_excludes:2:!globaltwo	globaltwo
@@ -686,7 +686,7 @@ cat <<-EOF >expected-all
 	a/b/.gitignore:8:!on*	b/one
 	a/b/.gitignore:8:!on*	b/one one
 	a/b/.gitignore:8:!on*	b/one two
-	a/b/.gitignore:8:!on*	"b/one\"three"
+	a/b/.gitignore:8:!on*	"b/one\\"three"
 	a/b/.gitignore:9:!two	b/two
 	::	b/not-ignored
 	a/.gitignore:1:two*	b/twooo
-- 
2.8.3-625-g89e3711
