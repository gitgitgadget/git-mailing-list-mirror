Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3CCC433E0
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 01:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B1F764DD8
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 01:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbhA3BU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 20:20:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65473 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbhA3BT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 20:19:27 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E4749B765;
        Fri, 29 Jan 2021 20:17:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3wPUIKg6M69U
        7AYEkixrYKFkl1c=; b=SP2P6LnoSGxKQ69+JtJlTHS3JZMEQvItWe+Xqb11+OWI
        g21ix5u6/qUOmDK+G1hjA+ZR/1fqvekllTrQRI5iNxlggFmyhZ0RywlrNYOLt+7F
        713D3qUYmq13GtNhMqZra3Rgx2O5AgB9BST4re96qOmUUNVohwWZv6x8X0usajM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xIpfkT
        9/rqs2GzdUFjd+a2J4eMoCTcILnTRvyYwsl4CdsqfBZ8HeLo1A5ls8aLpE7bPJgp
        xYR4fqqQntuhQVNHGmzxE9ganCU9/cPvNKLeH1wcSNhNOBNCaT91xeeWwZJZ79NB
        dBnneDbrhPjfRax/uEo2ZggfARtHicMIL+h/M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 66C359B764;
        Fri, 29 Jan 2021 20:17:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EA4F69B763;
        Fri, 29 Jan 2021 20:17:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v2 0/3] Unify trailers formatting logic for pretty.c and
 ref-filter.c
References: <pull.726.git.1599335291.gitgitgadget@gmail.com>
        <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
Date:   Fri, 29 Jan 2021 17:17:45 -0800
In-Reply-To: <pull.726.v2.git.1611954543.gitgitgadget@gmail.com> (Hariom Verma
        via GitGitGadget's message of "Fri, 29 Jan 2021 21:09:00 +0000")
Message-ID: <xmqqk0rvql3a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F596AC7A-6298-11EB-AD8D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Currently, there exists a separate logic for %(trailers) in "pretty.{c,=
h}"
> and "ref-filter.{c,h}". Both are actually doing the same thing, why not=
 use
> the same code for both of them?
>
> This is the 2nd version of the patch series that I sent few months back=
. It
> is focused on unifying the "%(trailers)" logic for both 'pretty.{c,h}' =
and
> 'ref-filter.{c,h}'. So, we can have one logic for trailers.
>
> v2 changes:
>
>  * Contains Improvements as suggested by "Ren=C3=A9 Scharfe" l.s.r@web.=
de 1
>    [https://public-inbox.org/git/bf4423d5-c0ee-6bef-59ff-fcde003ec463@w=
eb.de/]
>  * A new trailer option was introduced to pretty.c when I was absent i.=
e
>    "key_value_separator". Updated the patch series with latest changes.

ref-filter.c:74:3: error: symbol 'ref_trailer_buf' was not declared. Shou=
ld it be static?
    SP refs/packed-backend.c
    SP refs/ref-cache.c

For now, I've queued this on the tip of the topic while queuing;
running "make SPARSE_FLAGS=3D-Wsparse-error sparse" before sending
your series out may reduce embarrassment in the future.

Thanks.

 ref-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 2b1c61eadf..0e414765c1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -67,7 +67,7 @@ struct refname_atom {
 	int lstrip, rstrip;
 };
=20
-struct ref_trailer_buf {
+static struct ref_trailer_buf {
 	struct string_list filter_list;
 	struct strbuf sepbuf;
 	struct strbuf kvsepbuf;
--=20
2.30.0-540-g714779256f

