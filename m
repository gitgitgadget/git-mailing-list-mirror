Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E38DC20288
	for <e@80x24.org>; Fri, 21 Jul 2017 18:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754629AbdGUS4N (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 14:56:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59535 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751996AbdGUS4N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 14:56:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 51BC49B554;
        Fri, 21 Jul 2017 14:56:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WRGZFXKGYq1U
        Un5TH5S5knDQ5Cs=; b=ovJi4IQzF/d9DMzXwG4RSNsDtaWO8AG+nDjrTYSfmy+w
        u/sNQERJszC96f6PNZm0jcOH8KfYv23fJ1Hj/wKj/sc0cGieavgehCmQPvr693Eo
        6aMUyB+m7+pCdXgpQ95y0R3No+gRrtqcqqAfYWhA7M9EedmU4LKDXat/YQOMHGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=XwWHad
        D0gwoBcb61i4vOsP0uaqOCbnf/xNST5g0ju7F6cWzxEQhhtsvVIlVD81sa3ViwlV
        1tdjkPF42WUzRoUfJ/jAwzpQhBppFIdVYjnkghAnIbtCfXooiwWCv443XwPjBrHQ
        tw0NVlo1JQpm1pZdQ20tozfTT/83WbBjrQPUA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4968E9B553;
        Fri, 21 Jul 2017 14:56:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A59B09B552;
        Fri, 21 Jul 2017 14:56:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stas Sergeev <stsp@list.ru>
Cc:     git@vger.kernel.org
Subject: Re: git gc seems to break --symbolic-full-name
References: <234492d7-7fd6-f847-8b85-010732ff43b6@list.ru>
Date:   Fri, 21 Jul 2017 11:56:10 -0700
In-Reply-To: <234492d7-7fd6-f847-8b85-010732ff43b6@list.ru> (Stas Sergeev's
        message of "Fri, 21 Jul 2017 20:40:12 +0300")
Message-ID: <xmqqbmodhb5h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4379F46A-6E46-11E7-9E10-EFB41968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stas Sergeev <stsp@list.ru> writes:

> I do the following:
>
> $ git rev-parse --symbolic-full-name devel
> refs/heads/devel
> $ ls -l .git/`git rev-parse --symbolic-full-name devel`
> -rw-rw-r-- 1 stas stas 41 =D0=B8=D1=8E=D0=BB 21 15:05 .git/refs/heads/d=
evel
>
> This is fine. But after git gc:
>
> $ git rev-parse --symbolic-full-name devel
> refs/heads/devel
> $ LC_ALL=3DC ls -l .git/`git rev-parse --symbolic-full-name devel`
> ls: cannot access '.git/refs/heads/devel': No such file or directory

This is expected, and in the modern world (like, after year 2007),
a refname "refs/heads/foo" does *not* mean that there is a file
with such a path under .git/ directory.  "rev-parse" does not return
any "path" in the filesystem sense.

See "git pack-refs --help", and depending on what you want to learn
about the ref in question, perhaps "git show-ref refs/heads/devel"
is what you want.

