Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03957C433E0
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 21:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5F8C2247F
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 21:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbhAQVKz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 16:10:55 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64196 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729936AbhAQVKs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 16:10:48 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7643811536E;
        Sun, 17 Jan 2021 16:10:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1PYesQH18257fbH/OM6LXKbGi08=; b=DBEHdG
        DR+G+Gpz3xxegSx5Rp0sTZYtYsndC0a+SNV8qTvQTNceAlQl5b+88sutZMfssoK5
        eMqDpHOrIMVSVPUgOJzQNtlDfl5OBBJECZ4bPYa4oYof2MANFWFg9av6EUmfymDJ
        uSNyoTWP08X9OA19RXAY4cWq2zunqRESpms20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=djKqVmGjj2FVrUT078wUK47CaHkUsm9t
        8yDmwOv4eN/CPgXFKY6VbHYFsPy3iAJPezFNCv8tKK/6iAyEoGc/2U6RUCd23o6h
        C3KRQeTQlaLIThWr+0Ky1Wn8rj5eM01fL0a9GMW+Fbk3EeWoa10GpvnitT4EENMV
        OKsk+fK+EXI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6FC5711536D;
        Sun, 17 Jan 2021 16:10:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9299211536C;
        Sun, 17 Jan 2021 16:10:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Marek <kmarek@pdinc.us>
Cc:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 1/2] revision: Denote root commits with '#'
References: <196101d6eab6$20714550$6153cff0$@pdinc.us>
        <20210117110337.429994-1-kmarek@pdinc.us>
        <20210117110337.429994-2-kmarek@pdinc.us>
Date:   Sun, 17 Jan 2021 13:10:01 -0800
In-Reply-To: <20210117110337.429994-2-kmarek@pdinc.us> (Kyle Marek's message
        of "Sun, 17 Jan 2021 06:03:36 -0500")
Message-ID: <xmqq7dobmfrq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DF8A2CC-5908-11EB-81C6-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Marek <kmarek@pdinc.us> writes:

> This aids in identifying where an unrelated branch history starts when
> using `git log --graph --oneline --all`
>
> Signed-off-by: Kyle Marek <kmarek@pdinc.us>
> ---
>  revision.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

No tests?

> diff --git a/revision.c b/revision.c
> index 9dff845bed..8556923de8 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -4191,9 +4191,11 @@ const char *get_revision_mark(const struct rev_info *revs, const struct commit *
>  			return "<";
>  		else
>  			return ">";
> -	} else if (revs->graph)
> +	} else if (revs->graph) {
> +		if (!commit->parents)
> +			return "#";
>  		return "*";
> -	else if (revs->cherry_mark)
> +	} else if (revs->cherry_mark)
>  		return "+";
>  	return "";
>  }

Here is what I tried to come up with, but somehow the "#" marker is
not showing for me.

The "counted plus --left-right" tests stress why a single "#" is not
good enough.  I think the patch also needs to replace "<" and ">"
for root commits that are left and right---in the tests, I used "L"
to denote "root that is on the left side" (and "R" for the right
side) instead of single "#", so that we do not to lose information.

By the way, as I already said in the original thread, I do not think
the '#' marking is a good idea; I'd rather see the root commit shown
by shifting columns.

Anyway, here is to test [1/2].

 t/t6020-rev-list-boundary.sh | 132 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git i/t/t6020-rev-list-boundary.sh w/t/t6020-rev-list-boundary.sh
new file mode 100755
index 0000000000..f25e041951
--- /dev/null
+++ w/t/t6020-rev-list-boundary.sh
@@ -0,0 +1,132 @@
+#!/bin/sh
+
+test_description='rev-list/log boundary and root'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit A &&
+	test_commit B &&
+	git reset --hard A &&
+	test_commit C &&
+
+	git checkout --orphan side &&
+	git rm -fr . &&
+	test_commit X &&
+	test_commit Y &&
+
+	test_tick && git merge --allow-unrelated-histories -m "M" B &&
+	test_tick && git merge -m "N" C &&
+	test_commit Z
+'
+
+test_expect_success 'log with boundary' '
+	git log --graph --boundary --format='%s' ^A ^X Z >actual &&
+	sed -e "s/Q$//" >expect <<-\EOF &&
+	* Z
+	*   N
+	|\  Q
+	| * C
+	* |   M
+	|\ \  Q
+	| * | B
+	| |/  Q
+	* | Y
+	o | X
+	 /  Q
+	o A
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'log --left-right with symmetric boundary' '
+	git log --graph --left-right --boundary --format='%s' B...C >actual &&
+	sed -e "s/Q$//" >expect <<-\EOF &&
+	> C
+	| < B
+	|/  Q
+	o A
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'log --left-right with asymmetric boundary' '
+	git log --graph --left-right --boundary --format='%s' ^A ^X Z >actual &&
+	sed -e "s/Q$//" >expect <<-\EOF &&
+	> Z
+	>   N
+	|\  Q
+	| > C
+	> |   M
+	|\ \  Q
+	| > | B
+	| |/  Q
+	> | Y
+	o | X
+	 /  Q
+	o A
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_failure 'log down to root' '
+	git log --graph --format='%s' Z >actual &&
+	sed -e "s/Q$//" >expect <<-\EOF &&
+	* Z
+	*   N
+	|\  Q
+	| * C
+	* |   M
+	|\ \  Q
+	| * | B
+	| |/  Q
+	| # A
+	* Y
+	# X
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_failure 'log down to root' '
+	git log --graph --format='%s' B Y >actual &&
+	sed -e "s/Q$//" >expect <<-\EOF &&
+	* Y
+	# X
+	* B
+	# A
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_failure 'log that happens to show root' '
+	git log --graph -3 --format='%s' B Y >actual &&
+	sed -e "s/Q$//" >expect <<-\EOF &&
+	* Y
+	# X
+	* B
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_failure 'log --left-right down to root' '
+	git log --graph --left-right --format='%s' B...Y >actual &&
+	sed -e "s/Q$//" >expect <<-\EOF &&
+	> Y
+	R X
+	< B
+	L A
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_failure 'log --left-right that happens to show root' '
+	git log --graph -3 --left-right --format='%s' B...Y >actual &&
+	sed -e "s/Q$//" >expect <<-\EOF &&
+	> Y
+	R X
+	< B
+	EOF
+	test_cmp expect actual
+'
+
+test_done
