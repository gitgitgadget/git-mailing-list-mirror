From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t4055 failure: see error
Date: Tue, 02 Oct 2012 11:52:47 -0700
Message-ID: <7v391w905c.fsf@alter.siamese.dyndns.org>
References: <7667682A-3BDB-484F-A3E4-0E5826FD2076@cs.rochester.edu>
 <7v7gr890hd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Charles Gernhardt <gernhard@cs.rochester.edu>
X-From: git-owner@vger.kernel.org Tue Oct 02 20:53:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ7aX-00057f-07
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 20:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518Ab2JBSwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 14:52:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51768 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753319Ab2JBSwu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 14:52:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFAA39CC1;
	Tue,  2 Oct 2012 14:52:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nCyuEz6dZFKR4DKcdLgbvTc2ANo=; b=HAB9Hd
	sUol+y4jaZgAcXzR77QAaZQkE0itgXGmk43LIjXOKVYeV3GBsoBXQM8xzMluCrcd
	MPrVIwxh3UMrl58/qLa8U3uZg8OOK9Pj3LE/UROwGzVH8HbeomtPwIys8DPxAAMl
	Cecxcs3scaTbDK/e0AtGBIY4pP3brXsQY4UGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=InjI2MtJU70epW4WMTZ1XX2/Jn7eGSFU
	fzX5uoGrm4JFKwPxHfyamxrt8NysCPChAeDEgrBsyEbLZqm67XlmxSPJFq3VVy+b
	Nb32F7nt6/mtTvwFCirHbvzpiSyR0qywiMmyRyaH4DOIUsKdScuQQ+QFRS0ZPaok
	bStlZa+mK/c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBCF99CC0;
	Tue,  2 Oct 2012 14:52:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2EDAF9CBF; Tue,  2 Oct 2012
 14:52:49 -0400 (EDT)
In-Reply-To: <7v7gr890hd.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 02 Oct 2012 11:45:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5CA4395E-0CC2-11E2-AB54-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206832>

Junio C Hamano <gitster@pobox.com> writes:

> Brian Charles Gernhardt <gernhard@cs.rochester.edu> writes:
>
>> Another problem caused by BSD v GNU sed, I think.
>
> Oh, that again X-<.
>
> Will patch up in a stupid-but-trivial way, unless somebody knows a
> reliable workaround.

I no longer have a BSD handy to test, so I'd appreciate it if
somebody can do a quick sanity check.

Thanks.

-- >8 --
Subject: [PATCH] t4055: avoid BSD/GNU sed incompatibilty issues

The 'a', 'i' and 'c' commands that take literal lines to be added
followed by backslash does not seem to work reliably on some BSD
systems.  Avoid it by having an extra line in a template file and
generate test vectors by deleting the line or replacing the line.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4055-diff-context.sh | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
index 3527686..97172b4 100755
--- a/t/t4055-diff-context.sh
+++ b/t/t4055-diff-context.sh
@@ -8,7 +8,7 @@ test_description='diff.context configuration'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-	cat >x <<-\EOF &&
+	cat >template <<-\EOF &&
 	firstline
 	b
 	c
@@ -16,6 +16,7 @@ test_expect_success 'setup' '
 	e
 	f
 	preline
+	TARGET
 	postline
 	i
 	j
@@ -24,17 +25,15 @@ test_expect_success 'setup' '
 	m
 	n
 	EOF
+	sed "/TARGET/d" >x <template &&
 	git update-index --add x &&
 	git commit -m initial &&
 
-	git cat-file blob HEAD:x |
-	sed "/preline/a\
-	ADDED" >x &&
+	sed "s/TARGET/ADDED/" >x <template &&
 	git update-index --add x &&
 	git commit -m next &&
 
-	git cat-file blob HEAD:x |
-	sed s/ADDED/MODIFIED/ >x
+	sed "s/TARGET/MODIFIED/" >x <template
 '
 
 test_expect_success 'the default number of context lines is 3' '
-- 
1.8.0.rc0.45.g7ce8dc5
