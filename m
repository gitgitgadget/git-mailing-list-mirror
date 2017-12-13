Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F12B61F407
	for <e@80x24.org>; Wed, 13 Dec 2017 19:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753616AbdLMT51 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 14:57:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62780 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753130AbdLMT51 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 14:57:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 79CF3B7BB7;
        Wed, 13 Dec 2017 14:57:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WxOv1WeFvLJfAjkd6k2U59ykefM=; b=EJZcvk
        UxlKWeErig0yQXvRIN8NpLIeUW9FtnP8r18eOrpYvPmL/JNCXgmYhHRrHQ48Oeh7
        yexyQKxsKFtsntfR/hzggDd3UbSSQvtDy80uHF4liWBvm6uKzQxMrrzDc4dAU42W
        UKVvhwdSz4Jk9Zn6WDUBfqq/ypefqcyTou4HQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YZt9xlBQsi62gBKhYefBmBvxDeJfdnd+
        JqdxR2+i7+z+lJ9MGurU5Ola15k0zPCOcQqgeSEpObjpKpGOgEYwRr27e0ssliRK
        pmhU17vskfwyMG/qzgLNjW4/vdSUekrs+F2HDOpDBlXSdrM6qRvNiKFISSh2HgnC
        0DWvV7T1+vQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 712AAB7BB6;
        Wed, 13 Dec 2017 14:57:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA9D4B7BB4;
        Wed, 13 Dec 2017 14:57:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] doc: clarify usage of XDG_CONFIG_HOME config file
References: <1513077862-165-1-git-send-email-jacob.keller@gmail.com>
        <xmqqo9n320ep.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xqR0C_Z5fJFdSBvzqCT=LU-mK0cdtaqJ=6TH5Ty60PQrg@mail.gmail.com>
        <20171213142334.oy2uvkamho4whspj@hopa.kiewit.dartmouth.edu>
Date:   Wed, 13 Dec 2017 11:57:24 -0800
In-Reply-To: <20171213142334.oy2uvkamho4whspj@hopa.kiewit.dartmouth.edu>
        (Yaroslav Halchenko's message of "Wed, 13 Dec 2017 09:23:34 -0500")
Message-ID: <xmqqmv2mwgd7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7610626-E03F-11E7-B0F2-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yaroslav Halchenko <yoh@onerussian.com> writes:

> It always read it for non--global
> ...
> and it doesn't read it for --global
> ...
> unless ~/.gitconfig is missing

Yes, this dates back to 21cf3227 ("config: read (but not write) from
$XDG_CONFIG_HOME/git/config file", 2012-06-22), around the time back
when we added support to use xdg locations and doing so without breaking
existing users.

Taken together with a later commit in the same series 0e8593dc
("config: write to $XDG_CONFIG_HOME/git/config file when
appropriate", 2012-06-22), which says:

    config: write to $XDG_CONFIG_HOME/git/config file when appropriate
    
    Teach git to write to $XDG_CONFIG_HOME/git/config if
    
     - it already exists,
     - $HOME/.gitconfig file doesn't, and
     - The --global option is used.
    
    Otherwise, write to $HOME/.gitconfig when the --global option is
    given, as before.
    
    If the user doesn't create $XDG_CONFIG_HOME/git/config, there is
    absolutely no change. Users can use this new file only if they want.
    
    If $XDG_CONFIG_HOME is either not set or empty, $HOME/.config/git/config
    will be used.
    
    Advice for users who often come back to an old version of Git: you
    shouldn't create this file.

the plan is to have either one of these and not both at the same
time.  A user who wants to live in xdg world (and wants to avoid
cluttering $HOME with .many-files) can do so by creating an empty
one there, and all writes from there on go to the xdg world; as
there will no $HOME/.gitconfig created, the read side attempting to
read from it does not matter.  Other users get $HOME/.gitconfig when
running "config --global" to write for the first time, or users who
have been using Git from olden days already have $HOME/.gitconfig,
and no write goes to xdg world, so again the read side attempting to
read from there does not matter, either.

Perhaps a doc update needs to clarify these.

Thanks.
