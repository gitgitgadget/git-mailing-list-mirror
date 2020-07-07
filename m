Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AA8C433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 01:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10EC120719
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 01:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TfCHdZhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgGGBhm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jul 2020 21:37:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62380 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgGGBhl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jul 2020 21:37:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F172272644;
        Mon,  6 Jul 2020 21:37:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KdJP89FdogHA
        P+cLzong2QIGf/k=; b=TfCHdZhIvb5ZWjfjuiRhBTS0h0IqabsSRd/N7gk9yfmf
        eCYQgA32iJuNrFNWJecaA6oUGp3DypwF4BHSyDWeUxdWk9j4flVVbdYWFdKsrqdn
        VqMFMMT2IfpM7uvbZShSDzxobfDmPIHGNL5t2syE6ZWdMQYsLutgdRNNPIDxK4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=cRuPTY
        McMdGFHWWwAbDHJH1SUcen/2w1PtXPBm8nPfK/CU91aECu8dNtIr4bzw1CkiEJxr
        RElr/CDPuma7Sqje0EMYTGDOO25IiOL3v2Jl2KW07r1iHBGtvaoZv14pKwRxM7Rz
        K/JRWpSwMYfutWicwV/EbIaIuqTMpoVOuytQ8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E834A72643;
        Mon,  6 Jul 2020 21:37:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7C3DF72642;
        Mon,  6 Jul 2020 21:37:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?0JzQsNGA0LjRjyDQlNC+0LvQs9C+0L/QvtC70L7QstCw?= 
        <dolgopolovamariia@gmail.com>, git@vger.kernel.org,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH] revision: disable min_age optimization with line-log
References: <CAD6JL5SRvB_yXcqJ5HGADQaGtZAiKrtd447vtHLSagJqNGPChA@mail.gmail.com>
        <0c55e178-8f7c-ef84-e6eb-e50de9924ef6@web.de>
Date:   Mon, 06 Jul 2020 18:37:35 -0700
In-Reply-To: <0c55e178-8f7c-ef84-e6eb-e50de9924ef6@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 4 Jul 2020 14:56:32 +0200")
Message-ID: <xmqqa70c85r4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 704BC5A8-BFF2-11EA-8D19-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> If one of the options --before, --min-age or --until is given,
> limit_list() filters out younger commits early on.  Line-log needs all
> those commits to trace the movement of line ranges, though.  Skip this
> optimization if both are used together.
>
> Reported-by: =D0=9C=D0=B0=D1=80=D0=B8=D1=8F =D0=94=D0=BE=D0=BB=D0=B3=D0=
=BE=D0=BF=D0=BE=D0=BB=D0=BE=D0=B2=D0=B0 <dolgopolovamariia@gmail.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Needs careful review -- I'm not familiar with that the line-log code an=
d
> the revision traversal machinery is a bit scary.  AFAIU the min_age
> check is done again in get_commit_action(), so this patch shouldn't
> cause underage commits to be shown, but I'm not sure.  Test coverage fo=
r
> the three options is spotty. :-/

I am not familiar with the line-log code, either, but anyway.  This
starts queuing commits that are too young in the list of commits to
be processed, but later stages in the output callchain would decide
that they are too young to be shown in get_commit_action() that is
called from simplify_commit(), so the overall effect of this change
is to show these commits to the line-log machinery but filter them
out of the final output phase (with the parent rewriting, the
line-log machinery sees these commits in prepare_revision_walk(),
and without it, each of these commits is shown to the line-log
machinery immediately before get_commit_action() decides that it is
too young to be shown).  And the effect you want to gain by showing
these commits to the line-log machinery is to ensure that the range
of lines in the starting point is adjusted for the changes each of
these commits makes.

Which makes sense to me.

Thanks, will queue.

>  revision.c          | 3 ++-
>  t/t4211-line-log.sh | 8 ++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/revision.c b/revision.c
> index ebb4d2a0f2..3bdc1bbf2a 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1410,7 +1410,8 @@ static int limit_list(struct rev_info *revs)
>  				continue;
>  			break;
>  		}
> -		if (revs->min_age !=3D -1 && (commit->date > revs->min_age))
> +		if (revs->min_age !=3D -1 && (commit->date > revs->min_age) &&
> +		    !revs->line_level_traverse)
>  			continue;
>  		date =3D commit->date;
>  		p =3D &commit_list_insert(commit, p)->next;
> diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
> index 1428eae262..e186c83250 100755
> --- a/t/t4211-line-log.sh
> +++ b/t/t4211-line-log.sh
> @@ -240,10 +240,12 @@ test_expect_success 'setup for checking line-log =
and parent oids' '
>  	EOF
>  	git add file.c &&
>  	test_tick &&
> +	first_tick=3D$test_tick &&
>  	git commit -m "Add func1() and func2() in file.c" &&
>
>  	echo 1 >other-file &&
>  	git add other-file &&
> +	test_tick &&
>  	git commit -m "Add other-file" &&
>
>  	sed -e "s/F1/F1 + 1/" file.c >tmp &&
> @@ -283,4 +285,10 @@ test_expect_success 'parent oids with parent rewri=
ting' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'line-log with --before' '
> +	echo $root_oid >expect &&
> +	git log --format=3D%h --no-patch -L:func2:file.c --before=3D$first_ti=
ck >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.27.0
