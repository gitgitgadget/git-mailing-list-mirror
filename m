Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13E1F20372
	for <e@80x24.org>; Wed, 11 Oct 2017 11:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbdJKLNY (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 07:13:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65252 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751979AbdJKLNX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 07:13:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 16915A5932;
        Wed, 11 Oct 2017 07:13:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CWNcQhRAuEUMJmYCByNIYyGVy58=; b=oaDTxW
        o0KGHqVJhodfRIXUJcy7fgfHx2BAzN0ufBFHT/cpg60nN/AHnOAlw2JfGeisp587
        1XsvPyyw9wrUv68qK5zo1k9cMVNPfEq+9RLtOP2ObGTFin202vQvZ1HISYWbN85O
        so3lvOMAz3U8QQHEhyztIuhptpv6G4tCd7N/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=izL3r2QDbWVDZJvWf1K7Ib2Y240kx8qr
        eOZVhK6kF6ZtcTBLznVEuBmqJciIopHS74ZwVTs7rMYYsfOfhscb0ifpoBxbAV7Q
        D6THCRpgSazKWuXXRiiveU7kmVrEIULpU8kdlheQ1C93vLFRf7zXv1kXIakLVIKs
        G26izIBsbCk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EC15A5931;
        Wed, 11 Oct 2017 07:13:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7E1CBA5930;
        Wed, 11 Oct 2017 07:13:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marius Paliga <marius.paliga@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Enhancement request: git-push: Allow (configurable) default push-option
References: <CAK7vU=0ztEwMPsGO4Cd1A5JEnxmwkF57QPKjjvjD8rBUB79dRA@mail.gmail.com>
        <CAGZ79kaBJnXW=rSiKuHpds79mXVL0Aoo+PBa0a5V-C_bop=Kbg@mail.gmail.com>
        <CAK7vU=3whGsx4L4KACSC+XDWQEbUWuZZZqTsW2R=CbF8d7rkuQ@mail.gmail.com>
        <CAK7vU=22W9mYdSnw_LP2uWYyKZuTzF0JgTVWCX+nMhUnLjQ_Cw@mail.gmail.com>
Date:   Wed, 11 Oct 2017 20:13:16 +0900
In-Reply-To: <CAK7vU=22W9mYdSnw_LP2uWYyKZuTzF0JgTVWCX+nMhUnLjQ_Cw@mail.gmail.com>
        (Marius Paliga's message of "Wed, 11 Oct 2017 09:14:14 +0200")
Message-ID: <xmqq4lr6lyyb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2EA866CE-AE75-11E7-B309-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marius Paliga <marius.paliga@gmail.com> writes:

> +    default_push_options = git_config_get_value_multi("push.optiondefault");
> +    if (default_push_options)
> +        for_each_string_list_item(item, default_push_options)
> +            if (!string_list_has_string(&push_options, item->string))
> +                string_list_append(&push_options, item->string);

One thing that is often overlooked is how to allow users to override
a multi-value configuration variable that gets some values from
lower priority configuration files (e.g. ~/.gitconfig) with
repository specific settings in .git/config, and the way we
typically do so is to define "When a variable definition with an
empty string is given, it is a signal to clear everything
accumulated so far."  E.g. if your ~/.gitconfig has

	[push]
		defaultPushOption = foo
		defaultPushOption = bar

and then you write in your .git/config something like

	[push]
		defaultPushOption =
		defaultPushOption = baz

The configuration mechanism reads from lower priority files and then
proceeds to read higher priority files, so the parser would read them
in this order:

	push.defaultPushOption = foo
	push.defaultPushOption = bar
	push.defaultPushOption = 
	push.defaultPushOption = baz

and then it would build a list ('foo'), then ('foo', 'bar'), and
clears it upon seeing an empty, and compute the final result as
('baz').

You may want to do something like that in this code.

        
