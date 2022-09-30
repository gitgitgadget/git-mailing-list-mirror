Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707A3C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 21:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiI3V3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 17:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiI3V2s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 17:28:48 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4040914B85D
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 14:28:46 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C62415D800;
        Fri, 30 Sep 2022 17:28:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QuJvrayh0Zol
        VF/9z6JYJGeA6ltOnXh5gypwBNdeXY0=; b=EVeESjqzUamQBXnHTMoQscUPkzOK
        9Z8+rHY9BtJgknWanVdJg2Ja9m1u2OXID3ELyBR/QJOdQGrNBoxUN66fAVXdLIsd
        WGN3SBNAbzK2UQ96jbTlitY0wGFOLmsZGvA8xOQkEs2IRIdgzSHEFBhN1JXvmWuX
        eNUlKkFMXeXtlUc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 940FC15D7FF;
        Fri, 30 Sep 2022 17:28:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F3ACF15D7FE;
        Fri, 30 Sep 2022 17:28:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 07/36] doc SYNOPSIS & -h: fix incorrect alternates
 syntax
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
        <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
        <patch-v3-07.36-829bdf58499-20220930T180415Z-avarab@gmail.com>
Date:   Fri, 30 Sep 2022 14:28:41 -0700
In-Reply-To: <patch-v3-07.36-829bdf58499-20220930T180415Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 30 Sep
 2022 20:07:30
        +0200")
Message-ID: <xmqq1qrsa6wm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DBB70AD6-4106-11ED-A38A-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix the incorrect "[-o | --option <argument>]" syntax, which should be
> "[(-o | --option) <argument>]", we were previously claiming that only
> the long option accepted the "<argument>", which isn't what we meant.

It depends on which way you look at it ;-) namely, if vertical bar
binds tighter than option and its argument, then "-m|--message
<message>" and "(-m|--message) <message>" would mean the same thing.

Later in the series, we start insisting that the vertical bar must
have SP on both of its sides, which makes the vertical bar less
tightly binding visually, and at that point, adding parentheses
around the choices does become needed.

As long as these become consistent, the end result is happier than
the status quo.

> -	     [-u|--include-untracked] [-a|--all] [-m|--message <message>]
> +	     [-u|--include-untracked] [-a|--all] [(-m|--message) <message>]
> -'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
> +'git stash' store [(-m|--message) <message>] [-q|--quiet] <commit>

Thanks.
