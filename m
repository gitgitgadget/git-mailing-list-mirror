Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0FCC433E4
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A6B920716
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hfvyXlmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390807AbgHQSUE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:20:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61266 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390800AbgHQSTw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 14:19:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 917C8DEDAE;
        Mon, 17 Aug 2020 14:19:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Uzk8azrv9pan
        aLeCdn876qoUsmU=; b=hfvyXlmf8N4y5kR3Jeu17GHhYwgrGwtJW/4RPl2cAoFB
        Xq9UNcpN1hqayLFwKJpVxexkdWuNa/1JixUbnjpngkLS+Cj0lfpqUPV6lYlhJxEJ
        PF3wBfg3Z/db5EWg2KOuTVppLRvNvoILo+FDev0paQZjKjcgKIpL47gsfOzw/hk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=gnEBEl
        /zv88lLfk08D1ra86oGRUgRSh9cL3bDkvsT9B25Ezu62Gr5DMbuCwY+5yHDy49Wh
        HNdmAPbMAC3wf6I/9Vn3c/qZ/w5ivqnEdPYy4NH/sIbMMT1yZmsNfMI9UqNpd35K
        YInxF8mFE7SxEa/DiJa5lcatVb7KJqQ8egKn0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 897E5DEDAD;
        Mon, 17 Aug 2020 14:19:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CDA84DEDAC;
        Mon, 17 Aug 2020 14:19:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] Optionally skip linking/copying the built-ins
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
        <647f49d62e910fe8392219c3a5c6d86ac98a88e6.1597655273.git.gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 11:19:48 -0700
In-Reply-To: <647f49d62e910fe8392219c3a5c6d86ac98a88e6.1597655273.git.gitgitgadget@gmail.com>
        (Johannes Schindelin's message of "Mon, 17 Aug 2020 09:07:52 +0000")
Message-ID: <xmqq7dtx2kzf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3CE533F4-E0B6-11EA-9132-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <gitgitgadget@gmail.com> writes:

> The dashed form of the built-ins is so pass=C3=A9. To save on developme=
nt
> time, and to support the idea of eventually dropping the dashed form
> altogether, let's introduce a Makefile knob to skip generating those
> hard-links.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Makefile | 53 ++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 36 insertions(+), 17 deletions(-)

I do not know pass=C3=A9 is a good adjective to use for the past effort
of keeping the promise we made to our users, but I think in general
this as an optional installation knob is an excellent idea.

>  ### Check documentation
>  #
> -ALL_COMMANDS =3D $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS)
> +ALL_COMMANDS =3D $(ALL_PROGRAMS_AND_BUILT_INS) $(SCRIPT_LIB)
>  ALL_COMMANDS +=3D git
>  ALL_COMMANDS +=3D git-citool
>  ALL_COMMANDS +=3D git-gui

This stops "make check-docs" from ensuring that the built-in
commands are documented when skip-dashed is requested, no?
The first action in check-docs target that runs lint-docs in the
Documentation directory may notice a missing documentation when
it is referenced by somebody else, but the check in the target
itself are told that these built-ins no longer exist and triggers
"removed but listed" errors.

A mistake clike the above an become harder to make if
ALL_PROGRAMS_AND_BUILT_INS is renamed to indicate what it really is
(which would also help its primary target, the installation step).
It obviously does NOT always include $(BUILT_INS), so it is not "all
programs and built-ins" but something else (perhaps "all programs
and built-ins that are installed on a filesystem as separate
executable files"?)

Thanks.
