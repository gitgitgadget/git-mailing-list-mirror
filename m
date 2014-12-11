From: Junio C Hamano <gitster@pobox.com>
Subject: Re: no-xmailer tests fail under Mac OS
Date: Thu, 11 Dec 2014 14:11:04 -0800
Message-ID: <xmqq1to5et1j.fsf@gitster.dls.corp.google.com>
References: <CAO2U3Qg3KsjvWJFza4MfiQDa2LbCpOy1Nxf9Vt3NSgXc7Bee9g@mail.gmail.com>
	<20141206053434.GF31301@peff.net>
	<CAO2U3QjkJRPrFvapK=LDU_GG5Ne6_zVD+S61JP+iV_Xi-gk5JQ@mail.gmail.com>
	<20141206063245.GA5966@peff.net>
	<CAO2U3QgDMpKwqsjzPNECpJw4z+WbboX5ug7Shu5v5ZCuPsKuGQ@mail.gmail.com>
	<20141206071234.GA6850@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>,
	Luis Henriques <henrix@camandro.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 11 23:11:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzBx5-0001ap-VU
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 23:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934267AbaLKWLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 17:11:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59886 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758460AbaLKWLL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 17:11:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2495B24DB0;
	Thu, 11 Dec 2014 17:11:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o7e3nYzZjWNjLIonvK9OZ1+vNlA=; b=PUVfFQ
	eCWnT1cpuf4nWain/STQXdgZeY/rIGStzc35HenItMH6I0wv+TRqh1zB+k74TJRw
	Z4UJcJ9iPljFBPODFtNnAo8RSrw24TWFfh5jNE7wnnoo37v2z76zf0rvYYHkgD40
	Hm4pEALs53FKMljuJmmETHUP10oiAt1GNXFGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UqqO/G+/g7OrC7MvDOEFO8HGVVrAj60Q
	byrqti/pXGL2VqZEreXqmomyEgCCmrOjPhVGHg7ykfpnlmbTkbg30N8NuUASLzhk
	AiDSDsYFa1V2MAP7q65sXcVZFkGH/9PBM28ICJAsFNoFS+gg7dWQ9Ksm/NjusuXs
	YeubeB05bMg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C47024DAF;
	Thu, 11 Dec 2014 17:11:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 64ED924DAE;
	Thu, 11 Dec 2014 17:11:07 -0500 (EST)
In-Reply-To: <20141206071234.GA6850@peff.net> (Jeff King's message of "Sat, 6
	Dec 2014 02:12:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9B016F32-8182-11E4-A3A2-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261296>

Jeff King <peff@peff.net> writes:

> On Fri, Dec 05, 2014 at 11:07:37PM -0800, Michael Blume wrote:
>
>> > Ah, right, we might be looking for 0 sometimes. The right way to do it
>> > without destroying the &&-chaining is:
>> >
>> >   { grep ^X-Mailer: out || true } &&
>> >   test_line_count = $expected mailer
>> 
>> Hmm, it doesn't look like that helper is &&-chained though? So it
>> seems like we could just do without the &&
>
> You're right, but that is IMHO a bug. We would not notice if send-email
> or format-patch barfed, and we are expecting to find no X-Mailer (we
> wouldn't, but for the wrong reason).

Let me patch this up further by amending the SQUASH??? at the tip.

 t/t9001-send-email.sh | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index bb573ef..7826aa8 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1408,18 +1408,17 @@ test_expect_success $PREREQ 'sendemail.aliasfile=~/.mailrc' '
 '
 
 do_xmailer_test() {
-	expected=$1
-	params=$2
-	git format-patch -1
+	expected=$1 params=$2 &&
+	git format-patch -1 &&
 	git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=someone@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$params \
 		0001-*.patch \
-		2>errors >out
-	test "z$(grep ^X-Mailer: out | wc -l)" = "z$expected"
-	return $?
+		2>errors >out &&
+	{ grep '^X-Mailer:' out || :; } >mailer &&
+	test_line_count = $expected mailer
 }
 
 test_expect_success $PREREQ '--[no-]xmailer without any configuration' '
