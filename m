From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Test 9500 - unhelpful without Perl::CGI
Date: Tue, 14 Jun 2011 22:59:22 -0700
Message-ID: <7vmxhjk539.fsf@alter.siamese.dyndns.org>
References: <BANLkTikj0GQCN94PvZz6n6fJJb5sHMApig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 15 07:59:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWj8W-0007ir-Ah
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 07:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680Ab1FOF70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 01:59:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43754 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab1FOF7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 01:59:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 15B22441D;
	Wed, 15 Jun 2011 02:01:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EEYD2yUucgEiKLfrxbvPsaJxttU=; b=mZV033
	IJ/e5Ik0RX03H9CRTjNpi/nF45W7jmUUI9qkb8nWKdJHpdxs75L4mtYYLHpQO3BH
	LJnPNCvtktKCd5LJBPesfIDD4N6xkQhUtfDIqtMydKeTdqcX3GKHO9f87o0EvSou
	wmgYFNaHZQFmxOSGDbgGZI8CgpNnMqyLagNSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XxV99dBvbsT1KsBy0cbyA2dDVQS9uCAQ
	xMCrP3pIwfTbKi05N3bqBDf+lfxalQxlWeDXdGe1A4foSYuir1OTWez4a8Yfw++N
	VBufh2SxF5YR3emEJhX6/ftSEJFnMTYOVWnRoQ6tlSc4/b0Rs6qfOGsWNn8eKqpB
	GkIc71jF/1Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0E742441C;
	Wed, 15 Jun 2011 02:01:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6574B441B; Wed, 15 Jun 2011
 02:01:34 -0400 (EDT)
In-Reply-To: <BANLkTikj0GQCN94PvZz6n6fJJb5sHMApig@mail.gmail.com> (Linus
 Torvalds's message of "Tue, 14 Jun 2011 19:37:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC82B796-9714-11E0-906E-2C88C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175807>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> This has probably been going on forever, and the only reason I noticed
> is that I had a machine that doesn't have perl-CGI installed.
>
> I'm talking about t9500-gitweb-standalone-no-errors.
>
> Anyway, if you don't have that, the test fails at everything, and it
> does so without any clues about _why_ it fails.

Something like this would hopefully suffice.

It seems that we do test for the version of Encode, but we do not
specifically test CGI or other modules that people do not have to slurp
from CPAN?

 t/gitweb-lib.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 143eb1f..292753f 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -107,4 +107,9 @@ perl -MEncode -e '$e="";decode_utf8($e, Encode::FB_CROAK)' >/dev/null 2>&1 || {
 	test_done
 }
 
+perl -MCGI -MCGI::Util -MCGI::Carp -e 0 >/dev/null 2>&1 || {
+	skip_all='skipping gitweb tests, CGI module unusable'
+	test_done
+}
+
 gitweb_init
