From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1501: fix test with split index
Date: Tue, 24 Mar 2015 10:58:21 -0700
Message-ID: <xmqqa8z26zwi.fsf@gitster.dls.corp.google.com>
References: <1427218501-4644-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 18:58:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaT6A-00037n-KQ
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 18:58:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbbCXR6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 13:58:25 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50904 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752921AbbCXR6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 13:58:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E19641D06;
	Tue, 24 Mar 2015 13:58:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vZJXEjvN40hlNXaGm+9rtNvNpNg=; b=KVJy+R
	d0+YdBmQJnoFwdeEG9TXBIDaVhBQ7CmyE0oKxNK9p61Anjw5J4wyqHWzGKyutcA6
	E/z2OQXpC04GeEbm8MEf7PqP2i9Vt/6sL3ZVOuNf9L0cQhCFjhnz09PtRqPCHjUV
	cNugqOHUfcbYVv/G2HL1bWFM9R5jEsKBsLyC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LpB5+pKIkrAPt5LUDiT+IAw96LmGt9lK
	1+yJc48JeAsMWS0tVht+x3bau5Rz2Gxz8zpXco10uniXFpuaByT41TN8Fz+5km43
	de5JM//7Nu1cCf7KgIlc9fudXHDsBcld7SGLoRT7SAwoqn3pmiUCtewovQq0dwcE
	0HOE8p6mtD0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 54F7641D05;
	Tue, 24 Mar 2015 13:58:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C85F541D02;
	Tue, 24 Mar 2015 13:58:22 -0400 (EDT)
In-Reply-To: <1427218501-4644-1-git-send-email-t.gummerer@gmail.com> (Thomas
	Gummerer's message of "Tue, 24 Mar 2015 18:35:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5CC0BE4E-D24F-11E4-B0D2-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266215>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> t1501-worktree.sh does not copy the shared index in the "relative
> $GIT_WORK_TREE and git subprocesses" test, which makes the test fail
> when GIT_TEST_SPLIT_INDEX is set.  Copy the shared index as well in
> order to fix this.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>
> This applies on top of nd/multiple-work-trees.  Sorry for not catching it
> earlier, but I haven't tried to run the test-suite for the next branch
> then, where this appears.
>
>  t/t1501-worktree.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
> index 4df7a2f..ce5c654 100755
> --- a/t/t1501-worktree.sh
> +++ b/t/t1501-worktree.sh
> @@ -350,6 +350,7 @@ test_expect_success 'Multi-worktree setup' '
>  	mkdir work &&
>  	mkdir -p repo.git/repos/foo &&
>  	cp repo.git/HEAD repo.git/index repo.git/repos/foo &&
> +	( cp repo.git/sharedindex.* repo.git/repos/foo 2>/dev/null || : ) &&

Is this a good place to use "test-might-fail", e.g.

	test_might_fail cp repo.git/sharedindex.* repo.git/repos/foo &&

or something?

>  	sane_unset GIT_DIR GIT_CONFIG GIT_WORK_TREE
>  '
