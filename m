Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E166C433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 15:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85CC207D8
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 15:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YGlQ2uZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgFDPDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:03:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52874 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbgFDPDi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 11:03:38 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9303D7694D;
        Thu,  4 Jun 2020 11:03:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Dw4ZwU/5aaYgFfrazhRzLNVXDrU=; b=YGlQ2u
        Z7lW/GaYrCODg84xxUwczFR4r18f/OcUGueMNvFd3+qkN1IVsPa7kpk/EZzPQm6Q
        AoSsOsMoTGIirxbdDAnJQi1w7iHRszer+48OyxPE3PVi1cfeCtF0ts8+P+kI1lBG
        3rUQIrxI+ROUo4ji8rmkq1FQ8ad7agZptwvA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vpvGuVDjUsA++xF09fkOFLVuVBavEUmA
        AhA8M0pW3G3pfThvyiLRROqZxKJnnj/aZwo/ahU8uFjyDZeCfTONcfJxprETXr/A
        cOoBkMp6n2V+gVxDGghj44EVQo++jS0esKbStgvTg9WTAndgTXlsnhST/4HH1Jrr
        KdEMtcEdrrs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8840E7694C;
        Thu,  4 Jun 2020 11:03:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DDCF07694B;
        Thu,  4 Jun 2020 11:03:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     congdanhqx@gmail.com, Johannes.Schindelin@gmx.de,
        christian.couder@gmail.com, git@vger.kernel.org,
        kaartic.sivaraam@gmail.com, liu.denton@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [GSoC][PATCH v5] submodule: port subcommand 'set-branch' from shell to C
References: <20200523163929.7040-1-shouryashukla.oo@gmail.com>
        <20200602163523.7131-1-shouryashukla.oo@gmail.com>
        <xmqqzh9ls622.fsf@gitster.c.googlers.com>
        <20200603001225.GB2222@danh.dev>
        <xmqqtuzrrk8r.fsf@gitster.c.googlers.com>
        <20200604071719.GC8686@konoha>
Date:   Thu, 04 Jun 2020 08:03:33 -0700
In-Reply-To: <20200604071719.GC8686@konoha> (Shourya Shukla's message of "Thu,
        4 Jun 2020 12:47:19 +0530")
Message-ID: <xmqqd06erhyy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F53E99A-A674-11EA-AE80-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> On 03/06 01:02, Junio C Hamano wrote:
>> I'd expect that when that day with no scripted parts of "git
>> submodule" remains comes, the main entry point functions in
>> builtin/submodule--helper.c (like module_list(), update_clone(),
>> module_set_branch(), etc.) will become helper functions that live in
>> submodule-lib.c and would be called from builtin/submodule.c.  And
>> the conversion would rip out calls to parse_options() in each of
>> these functions that would migrate to submodule-lib.c
>> 
>>     Side note: instead of adding submodule-lib.c, you could add them
>>     directly to submodule.c if they are small enough.  I am however
>>     modeling after how the "diff" family was converted to C; the
>>     diff-lib.c layer is "library-ish helpers that get pre-parsed
>>     command line arguments and performs a single unit of work" that
>>     utilizes service routines at the lower layer that are in diff.c
>>     and submodule-lib.c and submodule.c will be in a similar kind of
>>     relationship.
>
> There does exist a `submodule.c` outside of `builtin/` which has various
> helper functions. Will that require renaming to `submodule-lib.c`?

No, that is different from what I wrote above.  Just like there is
the middle-layer diff-lib.c between the top-layer builtin/diff.c and
the low-level helper sets in diff.c, I envision that between the
top-layer builtin/submodule.c and the low-level helper sets in
submodule.c, there would be the middle layer submodule-lib.c.

If a single cmd_submodule_set_url() function implements the whole of
"git submoduel set-url" (by calling helper routines in submodule.c
and those currently in builtin/submodule--helper.c), I would expect
it to reside in builtin/submodule.c.


