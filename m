Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53A3C433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 20:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8901961A0D
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 20:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbhCXUCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 16:02:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62292 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238132AbhCXUBr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 16:01:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 268A2134FDC;
        Wed, 24 Mar 2021 16:01:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=c8C4zBMT4lXT
        P0XsAaUxloErDJM=; b=KMGggDlJfrKfiorI0sIUvB8ZlX8qk0SwyVjAxem1+pYc
        1rflaCppaa2MYkheTs4H0A11xlrbDzVmlV3wxsaHAaeZwQGH+6QX96hg/bS5Yk3M
        XNduYwU6TcpKko5qxvQAPs/F9ViBA7CRhwENQpw91p5H/trW7LNmf7oqbFYOq0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=L5tGy2
        DiW6dDrfI3WlKo1cB+abubo/qySZUTUzoQF7w+L9khacCokqCsbPhiz/BcQE9/gp
        3gdBOGnW8gkHNHvJGqUkFeUn5Ez610K4R9gDkXnH64kgyg/iXQ2q9kHSMgasDT28
        fJ61N5NDFka/b6YcFB4MDVZywIPOjO2D6CjAs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1FCC6134FDB;
        Wed, 24 Mar 2021 16:01:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E24B8134FDA;
        Wed, 24 Mar 2021 16:01:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git <git@vger.kernel.org>, jost.schulte@tutanota.com
Subject: Re: Configure default merge message
References: <MW_aJot--3-2@tutanota.com>
Date:   Wed, 24 Mar 2021 13:01:42 -0700
In-Reply-To: <MW_aJot--3-2@tutanota.com> (jost schulte's message of "Wed, 24
        Mar 2021 19:57:29 +0100 (CET)")
Message-ID: <xmqqk0pwxqvt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C1A41F3E-8CDB-11EB-90A0-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

jost.schulte@tutanota.com writes:

> Hello all,
>
> I'm using git mainly with BitBucket repositories. When I pull from a re=
mote, the default commit message will be "Merge branch 'source-branch-nam=
e' of=C2=A0https://bitbucket.org/ <https://bitbucket.org/jibbletech/jibbl=
e-2.0-client-web>repository-name into destination-branch-name".
>
> I'd like to configure git to omit the "of=C2=A0https://bitbucket.org/re=
pository-name" part. How can I do that?
>
> Regards
> Jost

=C3=86var, is this something we recently made it impossible with 4e168333
(shortlog: remove unused(?) "repo-abbrev" feature, 2021-01-12), or
is there more to it than resurrecting that "feature" to do what Jost
seems to want?

Thanks.
