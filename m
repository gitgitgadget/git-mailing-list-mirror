Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D192C433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC64820659
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YinPSbmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgEMUhj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 16:37:39 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58132 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbgEMUhj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 16:37:39 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0D494BD134;
        Wed, 13 May 2020 16:37:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZC8/TUP8dpjt
        d1xB4bjY3fXRRNI=; b=YinPSbmAdh5RH7kuZcr2S/trWYOCJn31zXcDrxyEtefz
        K/wBGzNE+GDzEF5Ym5/kr6uIEw+/jV2dzq1sR2E9HP4qtdLqk75d00N5V2HiLaXG
        FD7Yftc9IxkVcsfK1//9HoK0boQm8W7gQCwNbb46csl0wlaxsi98heWa1YbnLWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dVNMKC
        BIYN239VdxHozblc9RibKQljJUhLkH5cPP9S7xnEBFVorvki5I5hKo6tcxzbCmsl
        N88DML0k5J/gKg93TrmmkgKh7ceiip0r+hHbYcHnqckdGR8qwMTGjrVg/a9SSSz6
        ovWn8yr36Gvw1vLnqHVlfNNt6o3jFtP/4bQtU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E6C8BBD133;
        Wed, 13 May 2020 16:37:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2B3C6BD132;
        Wed, 13 May 2020 16:37:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Ed Maste <emaste@freebsd.org>
Subject: Re: [PATCH] t4210: detect REG_ILLSEQ dynamically
References: <20200513111636.30818-1-carenas@gmail.com>
        <CAPig+cTUc2-ddWQ+oww5Ez7_N9qKgCuErk8OuOgPkXNrACdppw@mail.gmail.com>
        <20200513201851.GA30804@Carlos-MBP>
Date:   Wed, 13 May 2020 13:37:32 -0700
In-Reply-To: <20200513201851.GA30804@Carlos-MBP> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 13 May 2020 13:18:51 -0700")
Message-ID: <xmqqsgg3sh9v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 932B1420-9559-11EA-80DC-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> indeed, I would rather go away with the whole prereq and set a variable
> with a nice sounding name and use it below to `if test` the right tests=
,
> would that be ok?

In a sense, a prerequisite is an overkill if the tests that need to
be guarded are very well isolated and in a single place.  Do we
expect other tests outside the context of this script may have to be
guarded by REG_ILLSEQ?
