Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC12C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 22:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17CD064E10
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 22:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhBPWsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 17:48:24 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55187 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhBPWsW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 17:48:22 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 209D311B187;
        Tue, 16 Feb 2021 17:47:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h9A85cIvV7vgij0POTHD4xnbw3w=; b=Kqvkl+
        zQbukgEj9dyD1IFDCUchpqCV479Q/U7yZG9dpRbykjcMvMUAezRBretFX/kKNObY
        p/5zTZdkClZVZPJBi31/aLS3xy9sVdkAWJOYzXruMOMFZGdDNfR8b4avNcKtfHWW
        N606vQgYPpgc9Zbu8i+4F7Pgd4WDAHa4AjqH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vE4CJibkEe5bZq6IjSYZtS5fZVwFNFNn
        xlFqBaqwq//zXN4AQFYoACpqOAnGyXyelCzdegBDNh6R8hdR/D7xYY6c1MVYYaMn
        +WyB675tkcvbsGis6gjVBApw79M2EiXANN8T1A9oLXHpKQnx9UnOzxZKDzhFAwXO
        CZ6ftbArAkw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1957311B186;
        Tue, 16 Feb 2021 17:47:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6CC4911B184;
        Tue, 16 Feb 2021 17:47:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 00/17] propose config-based hooks (part I)
References: <20201205014607.1464119-1-emilyshaffer@google.com>
        <20201222000220.1491091-1-emilyshaffer@google.com>
        <YCwhA6VIs16uMnJG@google.com>
Date:   Tue, 16 Feb 2021 14:47:35 -0800
In-Reply-To: <YCwhA6VIs16uMnJG@google.com> (Josh Steadmon's message of "Tue,
        16 Feb 2021 11:46:11 -0800")
Message-ID: <xmqqy2fnocjc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F787AB1A-70A8-11EB-8349-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

>> Emily Shaffer (17):
>>   doc: propose hooks managed by the config
>>   hook: scaffolding for git-hook subcommand
>>   hook: add list command
>>   hook: include hookdir hook in list
>>   hook: respect hook.runHookDir
>>   hook: implement hookcmd.<name>.skip
>>   parse-options: parse into strvec
>>   hook: add 'run' subcommand
>>   hook: replace find_hook() with hook_exists()
>>   hook: support passing stdin to hooks
>>   run-command: allow stdin for run_processes_parallel
>>   hook: allow parallel hook execution
>>   hook: allow specifying working directory for hooks
>>   run-command: add stdin callback for parallelization
>>   hook: provide stdin by string_list or callback
>>   run-command: allow capturing of collated output
>>   hooks: allow callers to capture output
>> 
> Sorry for the delayed reply. I am happy with this series as-is. Thanks
> for all your work on it!
>
> Reviewed-by: Josh Steadmon <steadmon@google.com>

The topic branch has a lot more commits than these 17; I am
wondering if the reviewed-by applies only to the bottom 17, or as
the whole?  I recall that the upper half was expecting at least some
documentation updates.

Thanks.
