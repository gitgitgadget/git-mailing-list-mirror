Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23662C2BA19
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 21:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16B420709
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 21:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WCJT1CHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgDKVO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Apr 2020 17:14:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59148 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgDKVO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Apr 2020 17:14:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3763B41062;
        Sat, 11 Apr 2020 17:14:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oYW9DHeqzwXtnzzY97xzNnSD6lo=; b=WCJT1C
        HInz2W0w3KlpyPHBwjOxrAvUUQAOwqqJDG04FSvsrIhfiOil+0WhCUTZ9rDbhZEz
        aRS815iqoyYb3mE0PoguCOybEOsde//dkrFQ3XaYBPlCdbyDFjO3n56Ved3bSF71
        DKAverdlADh4V0OMfaE+7PYVeo/MTjjlHFoVc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q1fmXSlAleXgaP8WvtMFGgqL2HT8cASK
        uBb/oJ6Ajcj2S/Dv6vGodt9ILcbA/lyt+VrHstKjbj5hbK3WN2redjno+lkUb8Vm
        f1LUJdZMIlnMW4queYnngN+MZBbJMepNI+cS9ny2cc3p9cyFlgiKROe5jIrrZomB
        b4jDYIsb/8k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F27541061;
        Sat, 11 Apr 2020 17:14:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC0C64105F;
        Sat, 11 Apr 2020 17:14:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bryan Turner <bturner@atlassian.com>,
        Sami Boukortt <sami@boukortt.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 0/3] rebase -i: mark commits that begin empty in todo editor
References: <pull.757.git.git.1586474800276.gitgitgadget@gmail.com>
        <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com>
        <xmqqpncfhy3g.fsf@gitster.c.googlers.com>
        <xmqqd08fhvx5.fsf@gitster.c.googlers.com>
        <CABPp-BEQdK8PagqCrKCvkzaWvSQVfW9g9_RbFCNP3r3qeChbzQ@mail.gmail.com>
        <xmqqv9m7geiy.fsf@gitster.c.googlers.com>
        <CABPp-BEFKEr0hA8V4ZqEEGBCkYRbzrgNx2kyPCTvjSh3Oj25bQ@mail.gmail.com>
Date:   Sat, 11 Apr 2020 14:14:20 -0700
In-Reply-To: <CABPp-BEFKEr0hA8V4ZqEEGBCkYRbzrgNx2kyPCTvjSh3Oj25bQ@mail.gmail.com>
        (Elijah Newren's message of "Fri, 10 Apr 2020 17:07:34 -0700")
Message-ID: <xmqqr1wthgib.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 69BD7846-7C39-11EA-A342-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Apr 10, 2020 at 3:30 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > On Fri, Apr 10, 2020 at 2:29 PM Junio C Hamano <gitster@pobox.com> wrote:
>> >>
>> >> Junio C Hamano <gitster@pobox.com> writes:
>> >>
>> >> > So I am OK to rebase the other topic to v2.26.0; would that help?  I
>> >> > already saw there was some entanglement with the other topic in one
>> >> > of the patches in this series, so...
>> > ...
>> > Thanks, but wouldn't I want to base his patch on top of mine rather
>> > than vice versa?  (Since mine might be labelled bugfix, and his is a
>> > new feature?)
>>
>> If you are willing to rebase the --[no-]keep-empty so that it does
>> not depend on v2.26, that may give us a better result.  I just got
>> an impression that you somehow wanted to base your changes on the
>> newer codebase, but if you want to base both on the older codebase,
>> that is fine by me, too.
>
> Rebasing my stuff on the older codebase wouldn't make sense; the
> relevant code would be riddled with conflicts.  Rather, I was thinking
> of rebasing Jonathan's changes and building his series on top of mine
> (and then touching up the docs so the flags reference each other).

That's OK as well.  I didn't know if you wanted the "fix" to be only
for 2.26.x and forward, or wanted to be applicable to 2.25.x series
(which the other topic that is a new feature happened to also work
with).

Thanks.
