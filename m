From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2010, #06; Sat, 17)
Date: Sun, 18 Apr 2010 11:20:21 -0700
Message-ID: <7vvdbowrkq.fsf@alter.siamese.dyndns.org>
References: <7v7ho5xp3z.fsf@alter.siamese.dyndns.org>
 <20100418083641.GA17717@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Gilger <heipei@hackvalue.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 18 20:20:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3Z6l-0003Iy-Jr
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 20:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653Ab0DRSUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 14:20:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab0DRSUe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 14:20:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD0C8AC53B;
	Sun, 18 Apr 2010 14:20:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bzkEicdRafTcevZEmRAu4orqLJQ=; b=XcBA0j
	yaFG7BuEBKYnAZVRe5TMw2IoZoN0OTJZgnnDxxgbnDIQso9Lfg2ozacltbyFE7Z3
	VR/++Bs5C1Ew/BxugDtMyzrbHyw6nzGMUddgPXcKwzlIPiU0eV767AqxWLlcZM6i
	sdMBH7iHKqRN6kjLdLtBxWPE1qieWi1cIoB8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WlQw9PlgrJ3FNAJ4id5Sc+mf+93pCAPm
	bFzf2hKoLX90NJCZeIwuBtTbZTu0LzsW7+w1r9cfJE8FWYtlLS+tlyJ2NItNsOhm
	dbPUSyfM3fR2TVPKrfxClpU8PrbpJwfQPeUYGF6X2HH4RWIvplcuqSwjQaVtkK7i
	2QkEkFAqwqQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A72FAC53A;
	Sun, 18 Apr 2010 14:20:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7717AC536; Sun, 18 Apr
 2010 14:20:22 -0400 (EDT)
In-Reply-To: <20100418083641.GA17717@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 18 Apr 2010 04\:36\:41 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0FD0292C-4B17-11DF-AF6C-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145226>

Jeff King <peff@peff.net> writes:

> On Sat, Apr 17, 2010 at 11:16:00PM -0700, Junio C Hamano wrote:
>
>> * jg/auto-initialize-notes-with-percent-n-in-format (2010-04-13) 1 commit
>>  - pretty: Initialize notes if %N is used
>
> I think the last round looked good, and this would ideally go into
> v1.7.1, as it fixes a segfault. It is getting a bit late in the -rc
> cycle, though. I guess the other option is to close the segfault with a
> one-liner and just make %N a no-op for v1.7.1, and then fix it right for
> v1.7.2.  I think I would prefer to have Johannes' patch right away,
> though.

It is an assertion failure but the fix is low-impact enough to appear in
the coming release.

 t/t3301-notes.sh |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index b2e7b07..64f32ad 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -55,6 +55,15 @@ test_expect_success 'handle empty notes gracefully' '
 	git notes show ; test 1 = $?
 '
 
+test_expect_success 'show non-existent notes entry with %N' '
+	for l in A B
+	do
+		echo "$l"
+	done >expect &&
+	git show -s --format='A%n%NB' >output &&
+	test_cmp expect output
+'
+
 test_expect_success 'create notes' '
 	git config core.notesRef refs/notes/commits &&
 	MSG=b4 git notes add &&
@@ -65,6 +74,15 @@ test_expect_success 'create notes' '
 	test_must_fail git notes show HEAD^
 '
 
+test_expect_success 'show notes entry with %N' '
+	for l in A b4 B
+	do
+		echo "$l"
+	done >expect &&
+	git show -s --format='A%n%NB' >output &&
+	test_cmp expect output
+'
+
 cat >expect <<EOF
 d423f8c refs/notes/commits@{0}: notes: Notes added by 'git notes add'
 EOF
