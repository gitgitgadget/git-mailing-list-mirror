From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add option to git-commit to allow empty log messages
Date: Tue, 06 Apr 2010 22:16:49 -0700
Message-ID: <7vsk77g7um.fsf@alter.siamese.dyndns.org>
References: <20100406055530.GE3901@coredump.intra.peff.net>
 <1270543235-8570-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 07:17:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzNdW-0002p4-K0
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 07:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965Ab0DGFRB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 01:17:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48996 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854Ab0DGFRA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 01:17:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B5C21A8946;
	Wed,  7 Apr 2010 01:16:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=d7faU4iF6ckM
	T39vsuE04IRKUPs=; b=CoDaH8PAwAyw+CIZRwxwSaFdA24ZkJ51Mvybyw9CNQvK
	fmKYEAHRzkWepgk474JDRFfrte7KST4TGvPxgp9HbvmXl9HIYvoJJIUQYHwsGYJ9
	21MyXmrqe2GddFMZgs/UytGSlJqD4AXLB3MZKa48Wi6MBHJpZfA+TT+s5o8TlYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZthRgI
	PkZcVECBrroAgmDKe2AtdGRoOqap4ItLNjov+WDW6UCebXYdymsBv7subzs9+ciy
	gJzqyAxpuTjLiZ1t4PNaEaCjIZVIjajg0dnftPIUCAZvcBuzS00HiLuJW6G1eLKv
	dNh+helwkHh6qLLgLl4Sq1iS9uA6EmKEQhQBs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CFA45A8944;
	Wed,  7 Apr 2010 01:16:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55D61A8942; Wed,  7 Apr
 2010 01:16:51 -0400 (EDT)
In-Reply-To: <1270543235-8570-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue\,  6 Apr
 2010 08\:40\:35 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C7EAC498-4204-11DF-9ECA-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144193>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> diff --git a/t/t7510-commit-allow-empty-message.sh b/t/t7510-commit-a=
llow-empty-message.sh
> new file mode 100755
> index 0000000..d7dc0da

I do not think a separate script is worth it.  I'd just add tests to t7=
500.

> +test_expect_success 'a basic commit in an empty tree should succeed'=
 '
> +	(
> +		echo content > foo &&
> +		git add foo &&
> +		git commit -m "initial commit"
> +	) &&
> +	commit_msg_is "initial commit"
> +'

No need for this, especially if this becomes part of t7500.

> +test_expect_success 'Commit no message with --allow-empty-message' '
> +	(
> +		echo "more content" >> foo &&
> +		git add foo &&
> +		printf "" | git commit --allow-empty-message
> +	) &&
> +	commit_msg_is ""
> +'

No need for subprocess, nor printf piped to the command.

> +test_expect_success 'Commit a message with --allow-empty-message' '
> +	(
> +		echo "even more content" >> foo &&
> +		git add foo &&
> +		git commit --allow-empty-message -m"hello there"
> +	) &&
> +	commit_msg_is "hello there"
> +'

Ditto.

You are falling into the same trap as everybody else does when showing =
off
your shiny new toy.  A missing but very necessary test is that "commit"
with your patch does still fail when an empty message is given without =
the
new option.

It takes a conscious effort to carefully make sure that your shiny new =
toy
does not trigger when it shouldn't, especially when you are so excited =
by
seeing it work when it should.

But that is part of the art of writing good test scripts.

 t/t7500-commit.sh |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 9f5c3ed..aa9c577 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -193,4 +193,26 @@ test_expect_success 'commit -F overrides -t' '
 	commit_msg_is "-F log"
 '
=20
+test_expect_success 'Commit without message is allowed with --allow-em=
pty-message' '
+	echo "more content" >>foo &&
+	git add foo &&
+	>empty &&
+	git commit --allow-empty-message <empty &&
+	commit_msg_is ""
+'
+
+test_expect_success 'Commit without message is no-no without --allow-e=
mpty-message' '
+	echo "more content" >>foo &&
+	git add foo &&
+	>empty &&
+	test_must_fail git commit <empty
+'
+
+test_expect_success 'Commit a message with --allow-empty-message' '
+	echo "even more content" >>foo &&
+	git add foo &&
+	git commit --allow-empty-message -m"hello there" &&
+	commit_msg_is "hello there"
+'
+
 test_done
