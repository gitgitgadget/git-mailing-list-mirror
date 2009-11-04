From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit -c/-C/--amend: reset timestamp and authorship to
 committer with --reset-author
Date: Tue, 03 Nov 2009 17:12:27 -0800
Message-ID: <7vd43znldw.fsf@alter.siamese.dyndns.org>
References: <1257282551-9999-1-git-send-email-erick.mattos@gmail.com>
 <20091104073822.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erick Mattos <erick.mattos@gmail.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 02:12:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5UQX-0005pt-Ar
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 02:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbZKDBMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 20:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbZKDBMe
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 20:12:34 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49952 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbZKDBMd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 20:12:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 615DF72401;
	Tue,  3 Nov 2009 20:12:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=2DSRxwRdnlbopYHdiaCmQf9BG/k=; b=xQM/NQGSMDX9DBxfigglS2R
	xnAHbsWENNUemuEdHDyULenQvpljVLlC8JCxNsZn30YeAcq0gRHhvSkJDlpuFI6w
	MctZtYAhGWMno+X2xGtzD9tuzJIUNLXCdb7Qb11nNjGgFNIG1Gr81LeunDGraRE+
	F/9KjmNl29kgsKZpmqWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=e7L9n1JbtxocsWVLmyGul2+KcZipwHBzg40RE2poh+BVwWvXg
	9aPnUsEeSpGj25Povhl3Wto53yDSr6o1Oqw+/RtxD02hCqQAk5tPQjMNnqMST9ZC
	vBaG0IK7qiQJD0I8bty88RvRX1FtLqw+04/3dMZwCx7Sdyw7b/+R0dYJFw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 34F0772400;
	Tue,  3 Nov 2009 20:12:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 492C5723FC; Tue,  3 Nov
 2009 20:12:29 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 216F440C-C8DF-11DE-A784-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132017>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> I think it is much better to replace "--mine" in gmane/131893 
> with "--reset-author" and make no other change to the test.

Heh, I would not claim my tests were perfect, even though I agree with
most of the suggestions and comments, including the parts I did not quote
that are not about the test script.

My first test did not check the message contents, but all the other ones
(except the last one that we expect the command to fail) check output from
both author_header and message_body, so that not just "--mine affects the
authorship" but also "--mine does not mangle the message contents" are
checked.

One thing you did not mention was that I made sure that the command failed
when given both --mine and --author options; I think Erick's last round
fails to test this condition.

    Side note.  When writing tests for their shiny new toy, people often
    forget to test "the other side".

    It is just human nature.  It is more fun to demonstrate what your new
    feature does, than making sure that the new feature does not kick in
    when it is not supposed to, nor it does not change what it is not
    supposed to change.

    Negative tests are not particularly hard to write.  The harder part is
    to force the habit of writing them on yourself.  Right after designing
    and implementing a new feature, the list of things it is supposed to
    do and when it is supposed to kick in are pretty clear in your mind,
    and that is what makes writing positive tests psychologically a lot
    easier.

    On the other hand, it takes concious effort to list what it is _not_
    supposed to do or when it is _not_ supposed to kick in.  That is why
    people often fail to write negative tests.

I think in addition to the obvious "s/--mine/--reset-author/g"
replacements, we would need this patch on top of mine.

 t/t7509-commit.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/t/t7509-commit.sh b/t/t7509-commit.sh
index ec13cea..1dad228 100755
--- a/t/t7509-commit.sh
+++ b/t/t7509-commit.sh
@@ -28,6 +28,10 @@ test_expect_success '-C option copies authorship and message' '
 	git commit -a -C Initial &&
 	author_header Initial >expect &&
 	author_header HEAD >actual &&
+	test_cmp expect actual &&
+
+	message_body Initial >expect &&
+	message_body HEAD >actual &&
 	test_cmp expect actual
 '
 
