Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E1DC43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 21:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35F3C22207
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 21:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p2NMbpaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgIKVCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 17:02:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58188 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgIKVCR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 17:02:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4C441ED253;
        Fri, 11 Sep 2020 17:02:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wnJ1GDN28r+vhLbXXhigTzjS2AU=; b=p2NMbp
        aF45v9jOMZqaQrTWxYbcqJ4wyeOLQOKeMuF8irrphSWs81uvUerNqYy4a7C5ZAOY
        U0yrvQSVD1FlEePnfMTSFYvHdl0IW6TetbWnliQTY9pqc+mjKGLGX/qC5nOa+Ien
        kpR+z+zSIwqz+MH8OmhCoHPvHDZw3xeVa6laY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YYYyBReOGnke8QtWYljTAVUplfzjyj5L
        RI/asUs0h+qokfkyshwgDHQy3fo2W97o+aGxXdyDfKA/AnGlMnpYVlU+1N4Gu70M
        tYUTAfjEPEj6iyYhJqjJ/TOwy1Bq7zDmJ/2jG5NCBpfZj6DpBpx1NiF8QfxFPbEh
        KjrYPyLjpc8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 43F47ED252;
        Fri, 11 Sep 2020 17:02:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8B439ED250;
        Fri, 11 Sep 2020 17:02:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Sean Barag via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sean Barag <sean@barag.org>
Subject: Re: [PATCH 1/4] clone: add tests for --template and some disallowed option pairs
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
        <4cdcedff313751da8c91d701c095f1051e759ce2.1599848727.git.gitgitgadget@gmail.com>
        <8f864b6c-4b05-a9d6-b649-5f7c50697730@gmail.com>
Date:   Fri, 11 Sep 2020 14:02:11 -0700
In-Reply-To: <8f864b6c-4b05-a9d6-b649-5f7c50697730@gmail.com> (Derrick
        Stolee's message of "Fri, 11 Sep 2020 14:57:11 -0400")
Message-ID: <xmqqsgbom3ho.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1057A6D0-F472-11EA-AD47-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> +test_expect_success 'disallows --bare with --origin' '
>> +
>> +	test_expect_code 128 git clone -o foo --bare parent clone-bare-o 2>err &&
>> +	test_debug "cat err" &&
>> +	test_i18ngrep "\-\-bare and --origin foo options are incompatible" err
>> +
>> +'
>
> It seems that all of your tests have an extraneous newline
> at the end.

That matches the older style to make the test body stand out by
having blank lines around it.  All existing tests from the era (not
limited to this script) used to do so.

It is OK to update them to modern style, but let's not do so in the
middle of the series.

Thanks.
