From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t5520 (pull): use test_config where appropriate
Date: Mon, 25 Mar 2013 08:59:31 -0700
Message-ID: <7v4nfz1ndo.fsf@alter.siamese.dyndns.org>
References: <1363955508-13368-1-git-send-email-artagnon@gmail.com>
 <1363955508-13368-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 17:00:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK9og-0005Zp-62
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 17:00:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758654Ab3CYP7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 11:59:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50874 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758592Ab3CYP7l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 11:59:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C38BAB1B4;
	Mon, 25 Mar 2013 11:59:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5wSlFwL9fo06zPQZWwVfd93bM6s=; b=uXvKGB
	JIRbld8btLD/c3YlXfkbD2hBd6yTRULhyjYfSORb8zJfUKWEHiqW4Skep59LQsw6
	/IaD0p3HBS484mxggA7i4Nyd1OamXNoi4+LMZr3nJ64bdUatCaQ3CJHp+pZjdbxZ
	6CorGB/DZI0O+xKi4vg85866NnzSgEHofjezs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XQbMGRKuU1Z/9L4GvF4fwD3I6TB6kl50
	b4VZDBLmQsEZ7B86y1A0q37pr9mrD7sytEB4T4h6DkbIz7dnJUyCt0SlKZkNdmRc
	NVgyJiQie/NiPYpenw0O4TwAohyVQgHN+P6QTBinwtkfKaKOp5G/fA0d6GmB7iUb
	BMdL6ySlIJA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8FDDB1B3;
	Mon, 25 Mar 2013 11:59:33 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F4E1B1B2; Mon, 25 Mar 2013
 11:59:32 -0400 (EDT)
In-Reply-To: <1363955508-13368-3-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Fri, 22 Mar 2013 18:01:48 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FBF158A4-9564-11E2-9312-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219041>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Configuration from test_config does not last beyond the end of the
> current test assertion, making each test easier to think about in
> isolation.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t5520-pull.sh | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index e5adee8..0fe935b 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -60,8 +60,8 @@ test_expect_success 'pulling into void does not overwrite untracked files' '
>  test_expect_success 'test . as a remote' '
>  
>  	git branch copy master &&
> -	git config branch.copy.remote . &&
> -	git config branch.copy.merge refs/heads/master &&
> +	test_config branch.copy.remote . &&
> +	test_config branch.copy.merge refs/heads/master &&
>  	echo updated >file &&
>  	git commit -a -m updated &&
>  	git checkout copy &&

I am not sure if this makes sense.  The "copy" branch this test
piece creates is used throughout the remainder of the test, and
these configuration variables establish a known default for cases
the later test checks when these various forms of "git pull" command
omits "from where" and "which branch".  It feels actively wrong to
discard that information after this test piece is done.

> @@ -96,8 +96,7 @@ test_expect_success '--rebase' '
>  '
>  test_expect_success 'pull.rebase' '
>  	git reset --hard before-rebase &&
> -	git config --bool pull.rebase true &&
> -	test_when_finished "git config --unset pull.rebase" &&
> +	test_config pull.rebase true &&
>  	git pull . copy &&
>  	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
>  	test new = $(git show HEAD:file2)
> @@ -105,8 +104,7 @@ test_expect_success 'pull.rebase' '
>  
>  test_expect_success 'branch.to-rebase.rebase' '
>  	git reset --hard before-rebase &&
> -	git config --bool branch.to-rebase.rebase true &&
> -	test_when_finished "git config --unset branch.to-rebase.rebase" &&
> +	test_config branch.to-rebase.rebase true &&
>  	git pull . copy &&
>  	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
>  	test new = $(git show HEAD:file2)
> @@ -114,10 +112,8 @@ test_expect_success 'branch.to-rebase.rebase' '
>  
>  test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
>  	git reset --hard before-rebase &&
> -	git config --bool pull.rebase true &&
> -	test_when_finished "git config --unset pull.rebase" &&
> -	git config --bool branch.to-rebase.rebase false &&
> -	test_when_finished "git config --unset branch.to-rebase.rebase" &&
> +	test_config pull.rebase true &&
> +	test_config branch.to-rebase.rebase false &&
>  	git pull . copy &&
>  	test $(git rev-parse HEAD^) != $(git rev-parse copy) &&
>  	test new = $(git show HEAD:file2)
> @@ -171,9 +167,9 @@ test_expect_success 'pull --rebase dies early with dirty working directory' '
>  	git update-ref refs/remotes/me/copy copy^ &&
>  	COPY=$(git rev-parse --verify me/copy) &&
>  	git rebase --onto $COPY copy &&
> -	git config branch.to-rebase.remote me &&
> -	git config branch.to-rebase.merge refs/heads/copy &&
> -	git config branch.to-rebase.rebase true &&
> +	test_config branch.to-rebase.remote me &&
> +	test_config branch.to-rebase.merge refs/heads/copy &&
> +	test_config branch.to-rebase.rebase true &&
>  	echo dirty >> file &&
>  	git add file &&
>  	test_must_fail git pull &&
