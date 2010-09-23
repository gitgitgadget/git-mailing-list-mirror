From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 2/4] t7500: add tests of commit --fixup
Date: Thu, 23 Sep 2010 10:42:41 -0700
Message-ID: <7vzkv8qru6.fsf@alter.siamese.dyndns.org>
References: <1285262076-20134-1-git-send-email-patnotz@gmail.com>
 <1285262076-20134-3-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Pat Notz" <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 19:42:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oypou-0000I0-P2
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 19:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755648Ab0IWRmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 13:42:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39428 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037Ab0IWRmu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 13:42:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EEF92D8E06;
	Thu, 23 Sep 2010 13:42:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5tu0QhGzThL9A/cmojnXLbJVtbM=; b=qOLpd5
	oLkX1Qfj+nEmLAho9QQ7Aaroh/vKW4SFmGg7u04KZxv48K9+Bt8ejwWFfI47EpAx
	l6a63G0IWh+jBzto5o0ILElzqQMXZLTJKp2mZtWjItmWDhq+l+QpkE6GjwD6Ttmb
	4ldeP8CxOiUXkRuqmJ9UJ61WDkGDdyhguLUFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u0k07d9o6G7deB6iW9cuXnxmtwc0xKWr
	hIrMkYFsFJerVg4b/WUkvH4l8gA2bN7nvcvkZwPfXjAe3gr1h9v0Ij30u8zssm+b
	M0oTiN2dBZc/Tofr55UESZ1wOTEVc2n/rLTfq4Tu0S7CuUNMlv4gVgiEdhT+zXX5
	ROepomtYvg0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C8839D8E05;
	Thu, 23 Sep 2010 13:42:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CFB72D8E04; Thu, 23 Sep
 2010 13:42:43 -0400 (EDT)
In-Reply-To: <1285262076-20134-3-git-send-email-patnotz@gmail.com> (Pat
 Notz's message of "Thu\, 23 Sep 2010 11\:14\:34 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FA211704-C739-11DF-B719-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156888>

"Pat Notz" <patnotz@gmail.com> writes:

> Signed-off-by: Pat Notz <patnotz@gmail.com>
> ---
>  t/t7500-commit.sh |   33 +++++++++++++++++++++++++++++++++
>  1 files changed, 33 insertions(+), 0 deletions(-)
>
> diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
> index aa9c577..db82264 100755
> --- a/t/t7500-commit.sh
> +++ b/t/t7500-commit.sh
> @@ -215,4 +215,37 @@ test_expect_success 'Commit a message with --allow-empty-message' '
>  	commit_msg_is "hello there"
>  '
>  
> +commit_for_rebase_autosquash_setup() {

A SP after "_setup", i.e. "..._setup () {".

> +	echo "first content for testing commit messages for rebase --autosquash" >>foo &&

Did you really need this long line here?

> +	git add foo &&
> +	cat >log <<EOF &&
> +target message subject line
> +
> +target message body line 1
> +target message body line 2
> +EOF
> +	git commit -F log &&
> +	echo "second content for testing commit messages for rebase --autosquash" >>foo &&
> +	git add foo &&
> +	git commit -m "intermediate commit" &&
> +	echo "third content for testing commit messages for rebase --autosquash" >>foo &&
> +	git add foo
> +}
> +
> +test_expect_success 'commit --fixup provides correct one-line commit message' '
> +	commit_for_rebase_autosquash_setup &&
> +	git commit --fixup HEAD~1 &&
> +	commit_msg_is "fixup! target message subject line"
> +'

What should be the right output when "target message subject line" has
some metacharacters, i.e. "." (regexp) or "?" (glob)?

Don't we also want to make sure that "rebase --autosquash" correctly groks
the history you prepared in this test?

> +test_expect_success 'invalid message options when using --fixup' '
> +	echo changes >>foo &&
> +	echo "message" >log &&
> +	git add foo &&
> +	test_must_fail git commit --fixup HEAD~1 --C HEAD~2 &&
> +	test_must_fail git commit --fixup HEAD~1 --c HEAD~2 &&

Double dashes before "C" and "c" look fishy.  Don't.

> +	test_must_fail git commit --fixup HEAD~1 -m "cmdline message" &&
> +	test_must_fail git commit --fixup HEAD~1 -F log
> +'
> +
>  test_done
> -- 
> 1.7.3
