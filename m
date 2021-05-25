Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB31C4707F
	for <git@archiver.kernel.org>; Tue, 25 May 2021 22:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB67A61408
	for <git@archiver.kernel.org>; Tue, 25 May 2021 22:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhEYW04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 18:26:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64529 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbhEYW04 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 18:26:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AD28013BB9B;
        Tue, 25 May 2021 18:25:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:cc:date:message-id:mime-version:content-type; s=sasl;
         bh=qxX8rSEU9Rim18jF7aPqR+kMaGKNtUnO7O6JF9xSv5M=; b=vmmKW7La8ryw
        K85SGxsVbXsVNCTXkk1T/I9TinQlZIDVdd74gbX2/WEXPWJq+AvzinpeZjoiCth9
        /qmdwrbt84h0K3VBEiELe8adv0GFTN3tTDHwp8xr1C+Yk+AT7efGZ1/ETQvfqqS7
        Ie4zj/8wdhZ41KYSzBot4tdFwlRKNi4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A5F0A13BB9A;
        Tue, 25 May 2021 18:25:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E608813BB96;
        Tue, 25 May 2021 18:25:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: CI: 'seen' minus a few passes tests, eh, almost 
cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Avar =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 26 May 2021 07:25:20 +0900
Message-ID: <xmqqcztecuy7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17FD7BEE-BDA8-11EB-A935-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is sad that the tip of 'seen' rarely passes all tests these days.

I excluded a few topics (chosen primarily by prejudice after looking
at which tests failed earlier, without locating exactly where and
why they fail) from 'seen' and the exclusion of them seems to have
made 'seen' finally pass the tests, eh, almost [*1*].

82b1e47 is such a "reduced" 'seen' branch, and the CI run for it can
be found here:

  https://github.com/git/git/actions/runs/876448385

Excluded are:

  ab/fsck-unexpected-type
  hn/reftable
  hn/refs-errno-cleanup
  zh/ref-filter-raw-data

Any of these may not be broken by themselves, and it could be that
the tests may still pass even if one or some of them are merged on
top of 82b1e47 and the problem may manifest only when two or more of
these topics in certain combinations are merged to 'seen'.

The CI run for 'seen' with all these four topics merged back can be
found here:

  https://github.com/git/git/actions/runs/876534959


[Footnote]

*1* Except for "git repack" segfaults only in one of the tests:

  https://github.com/git/git/runs/2669668815?check_suite_focus=true#step:5:2846
