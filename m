Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9369C433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 03:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2A9661A3F
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 03:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhCZDCy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 23:02:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59677 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhCZDCd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 23:02:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD22BC950B;
        Thu, 25 Mar 2021 23:02:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G0YneWhkMwrG65pnvBoq5DqNrFQ=; b=JDfbq2
        9INyoK2yg/wbk52nC+gPDtoqMTR0GWsaO/U4UaNmjV80jNMlp9Q+qUcE7dnHbutV
        oEQ1JRJXDWWb8s00bP+k+AUi5HTYemE9bGfwoR+XiUEkR0EokvxKncu03iKzQEio
        m12OLu8jXXNI/1ZYXlLxPoBVGIyoKk5V/zj3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wGlHEnSXapsqrcWuEgaituLYqlEcTS+l
        oYUC67HnSclkaZGbvQnTKpNJbAKPGE1yLrb0cD7mEuy5Pqv4md27KhqzAv4ZSlnC
        PD6nm2fCF2fHJVBGNysGMT/Av64wE/saCzC6l08YTbIak8S+LTrN0OklvpRT85bc
        pKHFbnv59HA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A598DC950A;
        Thu, 25 Mar 2021 23:02:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 336ACC9509;
        Thu, 25 Mar 2021 23:02:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>, git <git@vger.kernel.org>,
        =?utf-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos+git@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 1/1] pathspec: warn for a no-glob entry that contains
 `**`
References: <xmqqft1iquka.fsf@gitster.g>
        <20210325233648.31162-2-stdedos+git@gmail.com>
        <xmqq35wiu4om.fsf@gitster.g>
        <CAPig+cT3xprHLxDkvfgHpHY7t5_5_A2xyGKB5S2KiqW=3Lk-TQ@mail.gmail.com>
Date:   Thu, 25 Mar 2021 20:02:31 -0700
In-Reply-To: <CAPig+cT3xprHLxDkvfgHpHY7t5_5_A2xyGKB5S2KiqW=3Lk-TQ@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 25 Mar 2021 21:32:02 -0400")
Message-ID: <xmqqtuoysjlk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B534F85E-8DDF-11EB-A8F4-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> I haven't been following the discussion, but is there a reason we need
> to penalize the user with a warning rather than helping, for instance
> by inferring ":(glob)" in the presence of `/**/` if not otherwise
> countermanded by ":(literal)" or whatnot?

Two reasons I can think of offhand are

 - How /**/ is interpreted is not the only thing that is different
   between the normal mode and the glob magic mode.  IIRC, an
   asterisk * or a question mark ? matches slash in normal mode (it
   started out as fnmatch() without FNM_PATHNAME).  Should we warn
   about ":(glob)" if somebody asks for "foo*", "*foo", or
   "foo*bar".  If not, why shouldn't?

 - Thers is no explicit magic that says "there is no magic" to
   countermand such a DWIM.

