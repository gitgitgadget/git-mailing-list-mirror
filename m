Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAD461F462
	for <e@80x24.org>; Fri, 26 Jul 2019 20:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfGZU1s (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 16:27:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60359 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfGZU1s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 16:27:48 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 14A84150EF3;
        Fri, 26 Jul 2019 16:27:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WFDaDQ/DcQn+
        DUFUHvdZIoRYfWo=; b=AIwPOs5F1e0zVx4HPo5R5lXhWVaqXMndJpnnCcccfSlA
        C+xp6XFLvknvWldWcjvkVqmTFsMAIZm6m6FV9lQTLVe1M+yy0KuAagad78Sd0B0U
        /CpNntuumPogBZpZqgBC/spWmFFPnN5oS1Sg1dvTB996roANzo1uHy8zRee9kgg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=CaZOHX
        4rJTyMjSwlcTsNVKBVTnOaRvs7PYG67RH7oZDhbWey0pbrTV/WQVr0Yg4pU4hHBl
        tX6af+5/QXUxCICZj6KHGeW4Hp86GKNchUp73xA9hEBbZTSC2g1MYYA5hPYQiYhj
        12lO8KdU3eoxZkiRQ6OB8gC/A+MM4DJM4T2Rc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BEFD150EF2;
        Fri, 26 Jul 2019 16:27:45 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6FBC8150EF1;
        Fri, 26 Jul 2019 16:27:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/8] grep: PCRE JIT fixes + ab/no-kwset fix
References: <20190724151415.3698-1-avarab@gmail.com>
        <20190726150818.6373-1-avarab@gmail.com>
Date:   Fri, 26 Jul 2019 13:27:43 -0700
In-Reply-To: <20190726150818.6373-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 26 Jul 2019 17:08:10 +0200")
Message-ID: <xmqqpnlwmthc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D30C411A-AFE3-11E9-80D8-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> 1-3 here are a re-roll on "next". I figured that was easier for
> everyone with the state of the in-flight patches, it certainly was for
> me. Sorry Junio if this creates a mess for you.

As long as I can just apply all of them on top of no-kwset and keep
it a single topic, it wouldn't be too much of a hassle.

> 4-8 are a "fix" for the UTF-8 matching error noted in Carlo's "grep:
> skip UTF8 checks explicitally" in
> https://public-inbox.org/git/20190721183115.14985-1-carenas@gmail.com/
>
> As noted the bug isn't fully fixed until 8/8, and that patch relies on
> unreleased PCRE v2 code. I'm hoping that with 7/8 we're in a good
> enough state to limp forward as noted in the rationale of those
> commits.

Yikes.  Perhaps we should kick the no-kwset thing out of 'next' and
start from scratch?  It does not sound that the world is ready yet.

But that is just a knee-jerk reaction before reading the actual
patches.  Let's see how they look ;-)

Thanks.

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (8):
>   grep: remove overly paranoid BUG(...) code
>   grep: stop "using" a custom JIT stack with PCRE v2
>   grep: stop using a custom JIT stack with PCRE v1
>   grep: consistently use "p->fixed" in compile_regexp()
>   grep: create a "is_fixed" member in "grep_pat"
>   grep: stess test PCRE v2 on invalid UTF-8 data
>   grep: do not enter PCRE2_UTF mode on fixed matching
>   grep: optimistically use PCRE2_MATCH_INVALID_UTF
>
>  Makefile                        |  1 +
>  grep.c                          | 68 +++++++++++----------------------
>  grep.h                          | 13 ++-----
>  t/helper/test-pcre2-config.c    | 12 ++++++
>  t/helper/test-tool.c            |  1 +
>  t/helper/test-tool.h            |  1 +
>  t/t7812-grep-icase-non-ascii.sh | 39 +++++++++++++++++++
>  7 files changed, 80 insertions(+), 55 deletions(-)
>  create mode 100644 t/helper/test-pcre2-config.c
