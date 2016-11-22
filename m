Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DE531FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 17:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933857AbcKVRxN (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 12:53:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58244 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933808AbcKVRxK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 12:53:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 837AA4F972;
        Tue, 22 Nov 2016 12:53:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=umXdIc//cV6ICUweVuoDeZqnlD8=; b=F7wqdh
        wImsMYYNEs8AOYFJRXGLJi6hlJEDu0jSvOQP/Ic0fKMTz4/hrC6MLT+dAk3Ri4Bl
        ssy+xJ8/lqr/Ck5Aor17zivt+cmlL1hrYEaR6u4+f6lHEVfmuXoE14z7d5ZW8MO/
        7m0dddpNwW106z6tR+I9Iz0slvqUGCyioNetE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rgJuVGRQCskm9XkdI6ra7YZXJTDhZSxW
        bgRGYU5y+cvL9mpIdHCpvxowyVbrd39jm4orMVFY1AmwXxW6Az+3k/gUrb41VqpT
        ZoMNMhAMbSyCekJWjLaGd6yrAnVyXSTwbO0Zhge9JmZnmGx0C4RHjoOob90WX5RQ
        OLKaV7ugRmk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7AE9C4F971;
        Tue, 22 Nov 2016 12:53:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ECBE24F970;
        Tue, 22 Nov 2016 12:53:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 3/3] submodule--helper: add intern-git-dir function
References: <20161121204146.13665-1-sbeller@google.com>
        <20161121204146.13665-4-sbeller@google.com>
        <xmqqy40ch6wp.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kb_4wWs_90AfsT932iPWbCXf6yRq875JUxoRZjUcsBW5A@mail.gmail.com>
        <xmqqmvgsf0wo.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kb7062abd6Cbf-ey3u0L6PXUcRf7m-og5EyCRZencOR6g@mail.gmail.com>
Date:   Tue, 22 Nov 2016 09:53:07 -0800
In-Reply-To: <CAGZ79kb7062abd6Cbf-ey3u0L6PXUcRf7m-og5EyCRZencOR6g@mail.gmail.com>
        (Stefan Beller's message of "Tue, 22 Nov 2016 09:16:36 -0800")
Message-ID: <xmqqfumjqu4c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 874A35CE-B0DC-11E6-B800-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Mon, Nov 21, 2016 at 11:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> So I guess we should test a bit more extensively, maybe
>>>
>>>     git status >expect
>>>     git submodule embedgitdirs
>>>     git status >actual
>>>     test_cmp expect actual
>>>     # further testing via
>>>     test -f ..
>>>     test -d ..
>>
>> Something along that line.  "status should succeed" does not tell
>> the readers what kind of breakage the test is expecting to protect
>> us from.  If we are expecting a breakage in embed-git-dirs would
>> somehow corrupt an existing submodule, which would lead to "status"
>> that is run in the superproject report the submodule differently,
>> then comparing output before and after the operation may be a
>> reasonable test.  Going there to the submodule working tree and
>> checking the health of the repository (of the submodule) may be
>> another sensible test.
>
> and by checking the health you mean just a status in there, or rather a
> more nuanced thing like `git rev-parse HEAD` ? I'll go with that for now.

Would fsck have caught the breakages you caused while developing it,
for example?

As the core of the "embed" operation is an non-atomic "move the .git
directory to .git/modules/$name in the superproject and then make a
gitfile pointing at it", verifying that there is no change in the
contents of .git/modules before and after the failed operation, and
verifying that the submodule working tree has the embedded .git/
directory would be good enough, I would think.
