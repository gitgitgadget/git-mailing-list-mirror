Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CE9C433DB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 22:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BED523A56
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 22:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbhAUW2K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 17:28:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57815 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbhAUW2B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 17:28:01 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 662539F983;
        Thu, 21 Jan 2021 17:27:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1C8fOIyESqNdYvXM+EeWtN2d43E=; b=SD/Wwq
        V1yF/UGxcbbOWYfnPU8WhpDT3B4XVjnoC+ZA2/k07lWHowc0W3HTrA4XL8JkkELr
        kw9jkYg0kve9tJfVd9uUKXkfuyDw26kA56DcFXMpmHHK5fUNaNiAHrvP94SiUiR8
        Uctuse2ikKibPhUkS7HpBQKmizt83CsjhjBKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ciUKXmUBAAkWQ7VPIw5EAUUdfc0gfA6k
        u3UHTmUVTXTgq369LIdlgmAcRreb8scDIUx7dmhqDBR5O/9wrIKlpfgB34kChbgk
        Gk1nt2k8zeTaUhfpFwz2+4sZ3iyqi0dyFtlfXJuXj5rmZV/Vv+9NOEcz3O3FsULy
        G/JaE2lN22I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DD4A9F982;
        Thu, 21 Jan 2021 17:27:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D55699F981;
        Thu, 21 Jan 2021 17:27:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] rebase: add a config option for --no-fork-point
References: <20210120044435.53509-1-alexhenrie24@gmail.com>
        <xmqqturbdxi2.fsf@gitster.c.googlers.com>
        <CAMMLpeQM7JCP0=TMqf0DxDCVJvkCGDEPSKN6vYTU_xc7+QaA1Q@mail.gmail.com>
Date:   Thu, 21 Jan 2021 14:27:16 -0800
In-Reply-To: <CAMMLpeQM7JCP0=TMqf0DxDCVJvkCGDEPSKN6vYTU_xc7+QaA1Q@mail.gmail.com>
        (Alex Henrie's message of "Wed, 20 Jan 2021 16:13:35 -0700")
Message-ID: <xmqqo8hiaptn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1462EE8-5C37-11EB-BB54-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

>> > -     if (options.root && fork_point > 0)
>> > +     if (options.root && options.fork_point > 0)
>> >               die(_("cannot combine '--root' with '--fork-point'"));
>>
>> Is that because of this code?
>
> Yes. I was trying to avoid annoying the user with errors when
> rebase.forkPoint is set to "true" and --root is given on the command
> line.
>
>> If so, perhaps the configuration parser should set the .fork_point
>> to (-1), so that "[rebase] forkpoint = false" that appears in your
>> ~/.gitconfig file can be countermanded with "[rebase] forkpoint"
>> that is placed in .git/config for one particular project that you do
>> not mind using the feature?
>
> That's a great point. I will make that change and resubmit. Thanks!

By the way, is the feature itself something we can test easily?  I
think I saw the "we must interact with --root sensibly" test, but
the actual feature not being tested include

 - rebase.forkpoint set to false and then to true; does it use the
   fork-point feature (your patch as-is would have failed this test);

 - rebase.forkpoint set to false and command line says --fork-point;

 - rebase.forkpoint set to true and command line says --no-fork-point;

I offhand do not know if it is easy to observe it the fork-point
feature gets triggered, but it seems that the difference in
behaviour is big enough for you to care, so I am hoping you may
think of a way.

Thanks.
