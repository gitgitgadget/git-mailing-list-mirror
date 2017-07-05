Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAB9F202A7
	for <e@80x24.org>; Wed,  5 Jul 2017 17:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752137AbdGEReH (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 13:34:07 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33276 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbdGEReG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 13:34:06 -0400
Received: by mail-pf0-f195.google.com with SMTP id e199so36850701pfh.0
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 10:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ulVGgbMpkF4A1+BrdAloEk/68YqR9NMAUsCg+Pm6Imk=;
        b=oYPQN9JHm054pLPaXNYfGcAR3k2N5X4rSwc2lw9n3wBBV/QBLiMAcIDXSZkmJwm0jZ
         VWfg7NKmSTrnUpvzdMYzPXGprYypyqHcHx9DNnot7Scr9peguQWxmX/OxB1YwpwsedeE
         KJe0Cu0CXy4Pmy5kPiHBPjJCHqUN8qUkBVCTpMiEPwMEbvA31P9e7grMdLUyZaJDYl1J
         jQv7sqZV8XxVQYqTCOJIlxrfhjLP/3iBnR4jGpqt5MfXqC1r2jatqACgAcUY/Sthn2LA
         Q1dHSS8sxgPnn+B2qKE76r385wA3DNVRyYgj2iu13Yr0QYhbqxYTwGrVRdEr99/OWAOe
         jNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ulVGgbMpkF4A1+BrdAloEk/68YqR9NMAUsCg+Pm6Imk=;
        b=T0Uz9/n97Lzg9oH4doh5rj2QWfNKl9+rugQalFOSnJ6i4ruwRzhI6s/TYw2++GRGA5
         PcfdNn77Sc1i5HRf5F6ndCMZOuB3EAoet5MSRoRihhrEnLKPHPzHJCa3FPCZvK672Ml3
         mSt7de6U+dnlFxVl5Ufk9h77MAoRldMhTbJiMH3jjihi51uPBM43SmcKdEG9EAkT/1rc
         SXBTWcVV46w98YjTk09F3tn4j8rY0VGwmIwsr0ZeFqCP+GxkXN5//b4O4quXctcdiDZp
         DxGjK5UzBHIGXJ1fR88g/iTtVwJ/NK4VYLlJTWmrAwo/ZpOQ5/vVOrb+KrWK90N0/1l0
         y/jQ==
X-Gm-Message-State: AIVw1100mS0wUKDx580/KXIyJepPsCD8Dm8NMe5q62Y4Lw1PTV0dtjJs
        3CFOD1YRPfuw1g==
X-Received: by 10.101.70.137 with SMTP id h9mr22304156pgr.50.1499276045535;
        Wed, 05 Jul 2017 10:34:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ad13:9505:c2bc:e887])
        by smtp.gmail.com with ESMTPSA id d24sm54467062pfk.43.2017.07.05.10.34.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Jul 2017 10:34:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>
Subject: Re: [PATCH 1/6] reflog-walk: skip over double-null oid due to HEAD rename
References: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
        <20170705075737.6qsotqkzxdxofni6@sigill.intra.peff.net>
Date:   Wed, 05 Jul 2017 10:34:03 -0700
In-Reply-To: <20170705075737.6qsotqkzxdxofni6@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 5 Jul 2017 03:57:37 -0400")
Message-ID: <xmqqo9syiy9g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Since 39ee4c6c2f (branch: record creation of renamed branch
> in HEAD's log, 2017-02-20), a rename on the currently
> checked out branch will create two entries in the HEAD
> reflog: one where the branch goes away (switching to the
> null oid), and one where it comes back (switching away from
> the null oid).
> ...
> The resulting behavior may not be the _best_ thing to do in
> the long run (for example, we show both reflog entries each
> with the same commit id), but it's a simple way to fix the
> problem without risking further regressions.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I do still think it would be worth looking into making this rename
> create a single reflog entry, but that's largely orthogonal to making
> the display code sane(r).

I agree with this assessment.

>  reflog-walk.c     |  2 ++
>  t/t3200-branch.sh | 11 +++++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/reflog-walk.c b/reflog-walk.c
> index ed99437ad2..b7e489ad32 100644
> --- a/reflog-walk.c
> +++ b/reflog-walk.c
> @@ -259,6 +259,8 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
>  		/* a root commit, but there are still more entries to show */
>  		reflog = &commit_reflog->reflogs->items[commit_reflog->recno];
>  		logobj = parse_object(&reflog->noid);
> +		if (!logobj)
> +			logobj = parse_object(&reflog->ooid);
>  	}

For the current 'maint', this would need to be backported to the
uchar[20] interface (which is trivial to do, and merging it upwards
while adjusting it back to "struct object_id" is also trivial; there
is no need to resend).

Thanks.  Will queue.

>  	if (!logobj || logobj->type != OBJ_COMMIT) {
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 48d152b9a9..dd37ac47c5 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -162,6 +162,17 @@ test_expect_success 'git branch -M baz bam should add entries to .git/logs/HEAD'
>  	grep "^0\{40\}.*$msg$" .git/logs/HEAD
>  '
>  
> +test_expect_success 'resulting reflog can be shown by log -g' '
> +	oid=$(git rev-parse HEAD) &&
> +	cat >expect <<-EOF &&
> +	HEAD@{0} $oid $msg
> +	HEAD@{1} $oid $msg
> +	HEAD@{2} $oid checkout: moving from foo to baz
> +	EOF
> +	git log -g --format="%gd %H %gs" -3 HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'git branch -M baz bam should succeed when baz is checked out as linked working tree' '
>  	git checkout master &&
>  	git worktree add -b baz bazdir &&
