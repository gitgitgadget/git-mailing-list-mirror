From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] RFC Allow case insensitive search flag with git-grep for
 fixed-strings
Date: Mon, 16 Nov 2009 16:06:37 -0800
Message-ID: <7v639am2uq.fsf@alter.siamese.dyndns.org>
References: <B7C4E16C-B15D-4A7B-873A-B6BD0FDAD8C8@gmail.com>
 <20091116195050.6117@nanako3.lavabit.com>
 <7vocn2m48d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Brian Collins <bricollins@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 17 01:06:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NABax-0007Ql-77
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 01:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793AbZKQAGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 19:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754770AbZKQAGn
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 19:06:43 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51635 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754769AbZKQAGm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 19:06:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B4E48039E;
	Mon, 16 Nov 2009 19:06:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xIk6YUPzy1tXg3wp6FvC/gSUKOg=; b=x6ERJ4
	mLrgxoMjgJlR49sOiaoG4ixNv5M8OPhgz93NTj1FAe++e4s8vfeJJZh+rfvLpV+X
	HGLdT8okT3NpT7itQqAKrDsz+YH5FVKdtaLjt2IvBchwuMm+kYu99KChvD7Ex49V
	lHsC1mJKASsLNrZx9UuJxULosBW0OVmw/94Uk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AQ/MjZPGzPO/dU3DlgYpRHWu3GcQFaVs
	JcdyYh0KkBPhfv3kZBndB/CZCH1NCHvPhG/mvq8j8XVFQW2uCC8qtPnvY+h6qF9t
	Myr5Udvd8Z+sI2x8riyRkIbOkaY/SE1V7tyyBz9/RqLg7gncz0I5Awr0/vQTfpYh
	szdXG763qw0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E4A7B8039D;
	Mon, 16 Nov 2009 19:06:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D831680399; Mon, 16 Nov
 2009 19:06:38 -0500 (EST)
In-Reply-To: <7vocn2m48d.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 16 Nov 2009 15\:36\:50 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 16D7A83A-D30D-11DE-A068-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133041>

Junio C Hamano <gitster@pobox.com> writes:

> We got sidetracked into a larger picture issues of how to allow platform
> ports to selectively call out to external grep depending on the feature
> set supported by the external grep implementations.
>
> Later I looked at the original patch, the patch text looked fine (except
> that I would have called the field "ignorecase", not "caseless"), but it
> wasn't signed off and did not have usable log message.
>
> And then I forgot ;-)
>
> Thanks for a reminder, and thanks Jeff for a resend.

By the way, I would suggest updating the test like the attached.

By looking for rEtUrN, you will catch a bug that breaks "-i"-ness
of the grep, but your test does not catch breakages in "-F"-ness.

I am also tempted to add --no-ext-grep to this test, but that would be a
separate fix when it becomes necessary, I guess.

diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index 87b47dd..35a1e7a 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -14,6 +14,7 @@ int main(int argc, const char **argv)
 {
 	printf("Hello world.\n");
 	return 0;
+	/* char ?? */
 }
 EOF
 
@@ -346,11 +347,11 @@ test_expect_success 'grep from a subdirectory to search wider area (2)' '
 '
 
 cat >expected <<EOF
-hello.c:	return 0;
+hello.c:int main(int argc, const char **argv)
 EOF
 
 test_expect_success 'grep -Fi' '
-	git grep -Fi rEtUrN >actual &&
+	git grep -Fi "CHAR *" >actual &&
 	test_cmp expected actual
 '
 
