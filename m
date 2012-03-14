From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] Demonstrate a bug in --word-diff where
 diff.*.wordregex is "sticky"
Date: Wed, 14 Mar 2012 14:38:45 -0700
Message-ID: <7vhaxqoobe.fsf@alter.siamese.dyndns.org>
References: <3bb99e938624ae674674b304c24c48b9dc05871b.1331749299.git.trast@student.ethz.ch> <7vsjhboujp.fsf@alter.siamese.dyndns.org> <4F60F67D.9050003@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Mar 14 22:38:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7vuL-000078-FZ
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 22:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761550Ab2CNViv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 17:38:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54702 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761538Ab2CNViu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 17:38:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE2C96A14;
	Wed, 14 Mar 2012 17:38:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kszi2r6uXuL3GS4/Rs/DU7WWfVk=; b=n77H0B
	ylGjft0ez5jxe1yNojWFh9cydUvQwUZ6L4p6smyoGG9ZB7rXmSp+B1ONiTeZW5vH
	/rREBKBR5VWsNS9lnYbh8cXKKtfZh9eqJCFNA2Htukp6zMr5GttA+WAkTSgRm6WB
	eYw/JkZmRgcZ2XmLv4b3/N7Tzt65Nxt5bYwV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IBPRAse32ePvVdkgIqfBUrElChZMvcJf
	pwawhHdZQkxbAiQG4hDMbRvrdiAO8/77z9Xhn6lCchdGxHYtAbnjcxUB4D2MeQfq
	zD4zGY2hsFlFX5sOc2QvK3jfcV8lkAu7+cmkKgnQVawD6Q0V8dfOuTQbWChW4rEe
	QgPffE1P75c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C47976A13;
	Wed, 14 Mar 2012 17:38:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 448AB6A11; Wed, 14 Mar 2012
 17:38:47 -0400 (EDT)
In-Reply-To: <4F60F67D.9050003@kdbg.org> (Johannes Sixt's message of "Wed, 14
 Mar 2012 20:50:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 14AF2CB4-6E1E-11E1-849A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193164>

Johannes Sixt <j6t@kdbg.org> writes:

> The test case applies a custom wordRegex to one file in a diff, and expects
> that the default word splitting applies to the second file in the diff.
> But the custom wordRegex is also incorrectly used for the second file.
>
> Helped-by: Thomas Rast <trast@student.ethz.ch>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> Changes in this round, where I do not resend 2/3 and 3/3:
>
> - Use test_unconfig.
> - Use compare_diff_patch to check the result.
> - Fix a broken && chain at the end of the last test.
> - Name the files a.tex and z.tex as per your suggestion.

Thanks, but using a.tex and z.tex and marking only the former as tex
does not change anything in the puzzlement I mentioned in my response.

Perhaps this on top of your patch?

 t/t4034-diff-words.sh |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 9e9643e..310ace1 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -355,18 +355,18 @@ test_expect_success 'word-diff with no newline at EOF' '
 
 test_expect_success 'setup history with two files' '
 	echo "a b; c" >a.tex &&
-	echo "a b; c" >z.tex &&
-	git add a.tex z.tex &&
+	echo "a b; c" >z.txt &&
+	git add a.tex z.txt &&
 	git commit -minitial &&
 
 	# modify both
 	echo "a bx; c" >a.tex &&
-	echo "a bx; c" >z.tex &&
+	echo "a bx; c" >z.txt &&
 	git commit -mmodified -a
 '
 
 test_expect_failure 'wordRegex for the first file does not apply to the second' '
-	echo "a.tex diff=tex" >.gitattributes &&
+	echo "*.tex diff=tex" >.gitattributes &&
 	git config diff.tex.wordRegex "[a-z]+|." &&
 	cat >expect <<-\EOF &&
 		diff --git a/a.tex b/a.tex
@@ -374,9 +374,9 @@ test_expect_failure 'wordRegex for the first file does not apply to the second'
 		+++ b/a.tex
 		@@ -1 +1 @@
 		a [-b-]{+bx+}; c
-		diff --git a/z.tex b/z.tex
-		--- a/z.tex
-		+++ b/z.tex
+		diff --git a/z.txt b/z.txt
+		--- a/z.txt
+		+++ b/z.txt
 		@@ -1 +1 @@
 		a [-b;-]{+bx;+} c
 	EOF
-- 
1.7.10.rc0.65.g3445e
