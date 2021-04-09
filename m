Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A3FC433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3799261165
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbhDIWaE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 18:30:04 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65430 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbhDIWaE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 18:30:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9132F137E02;
        Fri,  9 Apr 2021 18:29:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qvqDly7zWFoteTO50AKjOR7TszQ=; b=RYTYPD
        XeYu/IIKBoikl4NL/r36A/Jid3NujQghDIEl9TQq70A3F8cEMF1DpcYn382dDDXK
        YiUJVyW9CmWUQC3VJ0iIh8EF/cKYTW+7dDDBiSTlqg+trqA0+IIw3WAKSsW4M4VW
        1umDfPHYDqN7qpL3v17WszgoDwWzrb6yChzo0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w8jCNh3IXGDxpj2Q5k+ZzaSrtR95NhK4
        +tLHMyL/BXrm7QPXt0XaQCkyk47ALlJZoo5IYVPxWRlWT5rx2VSJrFRRrNTNtzpn
        S6JHdMV5avs+dGiKzVpPOF7j6E/9So5vefJT/NiGbcuk4hnPbza+Zlv6mmFCfCOg
        /zelkcZoVRM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 89726137E01;
        Fri,  9 Apr 2021 18:29:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CE9E0137DFE;
        Fri,  9 Apr 2021 18:29:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git <git@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] config: add 'config.superproject' file
References: <20210408233936.533342-1-emilyshaffer@google.com>
        <20210408233936.533342-3-emilyshaffer@google.com>
        <CAHd-oW4VoBbZHc7cLdn0LPM531qNDGOfwPZdKiKoG4BoRFaqdg@mail.gmail.com>
Date:   Fri, 09 Apr 2021 15:29:46 -0700
In-Reply-To: <CAHd-oW4VoBbZHc7cLdn0LPM531qNDGOfwPZdKiKoG4BoRFaqdg@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Fri, 9 Apr 2021 11:35:13
        -0300")
Message-ID: <xmqqk0pbm6qt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 177AE5C4-9983-11EB-ACB6-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> Hi, Emily
>
> I'm not familiar enough with this code to give a full review and I
> imagine you probably want comments more focused on the design level,
> while this is an RFC, but here are some small nitpicks I found while
> reading the patch. I Hope it helps :)
>
> On Thu, Apr 8, 2021 at 8:39 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>>
>> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
>> index 4b4cc5c5e8..a33136fb08 100644
>> --- a/Documentation/git-config.txt
>> +++ b/Documentation/git-config.txt
>> @@ -48,7 +48,7 @@ unset an existing `--type` specifier with `--no-type`.
>>
>>  When reading, the values are read from the system, global and
>>  repository local configuration files by default, and options
>> -`--system`, `--global`, `--local`, `--worktree` and
>> +`--system`, `--global`, `--superproject`, `--local`, `--worktree` and
>>  `--file <filename>` can be used to tell the command to read from only
>>  that location (see <<FILES>>).
>>
>> @@ -127,6 +127,17 @@ rather than from all available files.
>>  +
>>  See also <<FILES>>.
>>
>> +--superproject::
>> +       For writing options: write to the superproject's
>> +       `.git/config.superproject` file, even if run from a submodule of that
>> +       superproject.
>
> Hmm, I wonder what happens if a repo is both a submodule and a
> superproject (i.e. in case of nested submodules).

Another thing I am not sure about the design is that a repository
can be shared as a submodule by more than one superprojects.  The
superprojects may want their submodule checkouts at different
submodule commits, but that is something doable by having multiple
worktrees connected to a single submodule repository.

I think our design principle has been that it is perfectly OK for a
superproject to be in total control if its submodules, but
submodules should not even be aware of being used as a submodule by
a superproject, and that allows a submodule repository to be shared
by multiple superprojects.  As "write to the superproject's X file"
requires a submodule to know who THE superproject of itself is, this
feature itself (not the implementation) feels somewhat iffy.
