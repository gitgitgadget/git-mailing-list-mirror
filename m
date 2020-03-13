Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A009C10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 19:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B90206B7
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 19:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S3NmWF2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgCMTHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:07:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60955 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgCMTHv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 15:07:51 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17D42454A4;
        Fri, 13 Mar 2020 15:07:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xoq0vSBjhoIkeBEPFgDnZM+EQ3Y=; b=S3NmWF
        2PcipOm5puQ0vxPojosry2fp75YR7Woi5bG2Zi9wSPAw5HtY6LLWDavRE9DiWvWS
        KzgEN7TxJE3U+7xgPmEpetveZ62Oiqvx2u7Eqtd1w8reG+xYVLhUuFYoEMRIHjcz
        E8ME9nDxIZ7n0OiX8/8hGe9xe4cuHGJVjkDvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eRadGY1isiyP5HPEzVhwzqv82bxa9UwD
        39/8BXE0ASALN3PXcXckIfh+2bY9l61Mm6Ab3Vf25/i2bkznidibsO+vrgygTNZk
        laV33VQ88XvYNWikI6YfP9WP5CxteNaEjie1vxW+/EiuLuXPjKqCCV+000iuKkxU
        siaKMrBFq+s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 10044454A3;
        Fri, 13 Mar 2020 15:07:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 81B19454A2;
        Fri, 13 Mar 2020 15:07:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        git@vger.kernel.org
Subject: Re: Regression in v2.26.0-rc0 and Magit
References: <3091652.KAqcNXvZJ4@cayenne> <20200312233504.GH120942@google.com>
        <xmqqk13pdsw1.fsf@gitster.c.googlers.com>
        <xmqq36accdpt.fsf@gitster.c.googlers.com>
Date:   Fri, 13 Mar 2020 12:07:49 -0700
In-Reply-To: <xmqq36accdpt.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 13 Mar 2020 11:27:26 -0700")
Message-ID: <xmqqy2s4axa2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF116482-655D-11EA-BC4E-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> ...
> If nobody complains in the coming 4 hours or so, I'll squash this in
> to e6c57b49 ("prefix_path: show gitdir if worktree unavailable",
> 2020-03-02) and mark the topic as "ready for 'next'".
>
> Thanks.
>
>  t/t6136-pathspec-in-bare.sh | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> ...
> +test_expect_success 'log and ls-files in .git directory' '
> +	(
> +		cd .git &&
> +		test_must_fail git log -- .. &&
> +		test_must_fail git ls-files -- ..
> +	) >out 2>err &&
> +	test_i18ngrep "outside repository" err
> +'
> +
> +test_done

This is outside the scope of fixing the regression e0020b2f
("prefix_path: show gitdir when arg is outside repo", 2020-02-14)
brought in, but I wonder if this last piece should even fail in the
first place.

If you give "." instead of ".." to these commands, they behave as if
we did so from the top-level of the working tree, i.e. these are
equivalent:

    git -C .git ls-files -- .
    git -C .git/info/ ls-files -- .
    git ls-files -- .

which somehow does not sound quite right, but that is how tools
written in the past 15 years expect and is hard to change?

That does not still explain why Magit (which is sufficiently mature)
is expecting "cd .git && ls-files .." to show the entire working
tree, though.


