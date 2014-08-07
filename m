From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash: default listing to working-tree diff
Date: Thu, 07 Aug 2014 14:39:02 -0700
Message-ID: <xmqqk36kj7yh.fsf@gitster.dls.corp.google.com>
References: <xmqqy4v7uax0.fsf@gitster.dls.corp.google.com>
	<20140806081102.GA1646@peff.net>
	<xmqq1tsto83q.fsf@gitster.dls.corp.google.com>
	<20140806183525.GA21254@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 07 23:39:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFVP4-0007m4-1G
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 23:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253AbaHGVjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 17:39:14 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50497 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197AbaHGVjN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 17:39:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9172C2FA4C;
	Thu,  7 Aug 2014 17:39:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2IqXIuSDOwVyR3bbZu98WTFsRJs=; b=Xl2ddA
	G3DQEnQ99AbkSRLetLCIMx6HlVA5LEP3qfswFc4ItiGIx4fSFiNuQTNFnAibcFF9
	PEvYiNHZd3quaDdB29NsIMbRjRlHPYTB+e4zX1sEpd4Q82spW70algwPtKy7LY2e
	H+hhTSDb15KnzlmuGI5TUvsI41Uwa96K6hwDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZXUUB1tgkCf/zV8/5Fj3IFga+gprV48w
	AFzOyn6frnJGhBOIGKkpoMQrN47xgzBtZSz6Pib20wIRgiGJ+o5FuFBknxEyfYTW
	UcO/PguHk+r7Wqcv2lYw7NZy0IU9UMG6VdaM51/1hooJliuBToDzIJyYAO4bD56n
	8OEFxo9FYaI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 878BE2FA4B;
	Thu,  7 Aug 2014 17:39:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9D98F2FA44;
	Thu,  7 Aug 2014 17:39:03 -0400 (EDT)
In-Reply-To: <20140806183525.GA21254@peff.net> (Jeff King's message of "Wed, 6
	Aug 2014 14:35:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 404CFBC0-1E7B-11E4-BE6A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254997>

Jeff King <peff@peff.net> writes:

> See the patch below, which I think could replace the top three from
> jk/stash-list-p (or really, could replace the whole series, and the
> bottom three could go into their own topic).

Sounds sensible.  Let's split those three changes into a separate
topic (jk/pretty-empty-format) and queue this independently.

Thanks.

> -- >8 --
> Subject: stash: default listing to working-tree diff
>
> When you list stashes, you can provide arbitrary git-log
> options to change the display. However, adding just "-p"
> does nothing, because each stash is actually a merge commit.
>
> This implementation detail is easy to forget, leading to
> confused users who think "-p" is not working. We can make
> this easier by defaulting to "--first-parent -m", which will
> show the diff against the working tree. This omits the
> index portion of the stash entirely, but it's simple and it
> matches what "git stash show" provides.
>
> People who are more clueful about stash's true form can use
> "--cc" to override the "-m", and the "--first-parent" will
> then do nothing. For diffs, it only affects non-combined
> diffs, so "--cc" overrides it. And for the traversal, we are
> walking the linear reflog anyway, so we do not even care
> about the parents.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  git-stash.sh     |  2 +-
>  t/t3903-stash.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index bcc757b..9c1ba8e 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -297,7 +297,7 @@ have_stash () {
>  
>  list_stash () {
>  	have_stash || return 0
> -	git log --format="%gd: %gs" -g "$@" $ref_stash --
> +	git log --format="%gd: %gs" -g --first-parent -m "$@" $ref_stash --
>  }
>  
>  show_stash () {
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 5b79b21..1e29962 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -685,4 +685,46 @@ test_expect_success 'handle stash specification with spaces' '
>  	grep pig file
>  '
>  
> +test_expect_success 'setup stash with index and worktree changes' '
> +	git stash clear &&
> +	git reset --hard &&
> +	echo index >file &&
> +	git add file &&
> +	echo working >file &&
> +	git stash
> +'
> +
> +test_expect_success 'stash list implies --first-parent -m' '
> +	cat >expect <<-\EOF &&
> +	stash@{0}: WIP on master: b27a2bc subdir
> +
> +	diff --git a/file b/file
> +	index 257cc56..d26b33d 100644
> +	--- a/file
> +	+++ b/file
> +	@@ -1 +1 @@
> +	-foo
> +	+working
> +	EOF
> +	git stash list -p >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'stash list --cc shows combined diff' '
> +	cat >expect <<-\EOF &&
> +	stash@{0}: WIP on master: b27a2bc subdir
> +
> +	diff --cc file
> +	index 257cc56,9015a7a..d26b33d
> +	--- a/file
> +	+++ b/file
> +	@@@ -1,1 -1,1 +1,1 @@@
> +	- foo
> +	 -index
> +	++working
> +	EOF
> +	git stash list -p --cc >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
