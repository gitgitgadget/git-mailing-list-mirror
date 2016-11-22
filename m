Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7817F1FF30
	for <e@80x24.org>; Tue, 22 Nov 2016 07:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754238AbcKVHCV (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 02:02:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61070 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752376AbcKVHCU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 02:02:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 37F0249CF0;
        Tue, 22 Nov 2016 02:02:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o1JwCvSl5Vn9rnwIHxLxsgNsvbc=; b=EBQ5wp
        IrFDWTvF0go8ykNHa6A4fTk2xBseCTfoZXJgeWuLdsbzkpf8TOvPSDeKISHeN7Cv
        hyVAjvsIoJNjUWNHNQPDdjKopSp41ETfms05BtCBG8BN2xeAVMlaORKOrIynnanA
        dA8e3pIIkV/hw3ZjjlfJLWh7jmLfCV1JzDLdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YL//TBhmNtglavJfJQennesf6xDDesKa
        /p2f5ooPgSZ4/Ct4SstVj0+bvFjcXvFXcvHbY/QgFLUJGDUTYsOwLk0iqiT2hjEg
        Bj6S7464IHy4MJZPzbwquwkih+S6YWpOalfGxc9peWDxFy3VJDxuXQNMuaHqarTd
        o5grIaYFRf0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F91F49CEE;
        Tue, 22 Nov 2016 02:02:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8385149CED;
        Tue, 22 Nov 2016 02:02:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 1/3] submodule: use absolute path for computing relative path connecting
References: <20161121204146.13665-1-sbeller@google.com>
        <20161121204146.13665-2-sbeller@google.com>
        <xmqq8tscim31.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kY=tzrsn7rS4UsRfSku_pKNNWNDc2OiTO-4-vg5h8NwWQ@mail.gmail.com>
        <CAGZ79ka60_D8xfQyBegkXxkTGW5YDMuagB7kjhiCR6NriLR8+A@mail.gmail.com>
Date:   Mon, 21 Nov 2016 23:02:17 -0800
In-Reply-To: <CAGZ79ka60_D8xfQyBegkXxkTGW5YDMuagB7kjhiCR6NriLR8+A@mail.gmail.com>
        (Stefan Beller's message of "Mon, 21 Nov 2016 16:04:47 -0800")
Message-ID: <xmqqr364f152.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B6BC08C-B081-11E6-86A1-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Mon, Nov 21, 2016 at 1:03 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Mon, Nov 21, 2016 at 1:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> Can the effect of this change demonstrated in a new test?  There
>>> must be a scenario where the current behaviour is broken and this
>>> change fixes an incorrect computation of relative path, no?
>
> I do not think the current usage exposes this bug in
> connect_work_tree_and_git_dir. It is only used in builtin/mv.c,
> which fills the second parameter `git_dir` via a call to read_gitfile,
> which itself produces an absolute path.

OK.  Fixing a potential bug as a preparatory step is good.

>   The current caller of connect_work_tree_and_git_dir passes
>   an absolute path for the `git_dir` parameter. In the future patch
>   we will also pass in relative path for `git_dir`. Extend the functionality
>   of connect_work_tree_and_git_dir to take relative paths for parameters.
>
>   We could work around this in the future patch by computing the absolute
>   path for the git_dir in the calling site, however accepting relative
>   paths for either parameter makes the API for this function easier
>   to use.

Yup, sounds sensible.  Thanks.
