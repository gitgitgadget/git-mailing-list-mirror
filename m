Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBFAD1FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 12:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932283AbdJXMlo (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 08:41:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57800 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932185AbdJXMlo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 08:41:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 668979D69F;
        Tue, 24 Oct 2017 08:41:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Joltojuj6QgJURTXRrtHbidxlpk=; b=L417b6
        juVkbZdtAFF3J8OAbMN82rPlZOiOYd3odreoCUr++4sym+pDFEc7pKRSqX7zZP/c
        9EPP+vI5PPmh98fgrSggXsXkeLVmVKf33E9Be0Fj6vkTRnnT9En75phhAZN3F4+W
        0Bn5Za6P8BCI7lHyGkFJQpCn4eByoqKj2O65E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pJnjVdIwJ9wkmCk64RCCawwfQNn1l7Pr
        R4ce8Qhlmp4JyOn+jkSSA5bKU5OBBhySc1DOup5lhEZJeNwcz2NX6qIyIvgRFUvl
        zycaVvzx6KeYQ8bdwShsUKzg9Kp+/2kkzFLrssEKQJaqYmNb0Qylr9bR6hfL2fNl
        uh7JZGFjTYM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D1C09D69C;
        Tue, 24 Oct 2017 08:41:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B2BD89D69B;
        Tue, 24 Oct 2017 08:41:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 2/8] commit: move code to update HEAD to libgit
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
        <20170925101041.18344-3-phillip.wood@talktalk.net>
        <xmqqo9pjth92.fsf@gitster.mtv.corp.google.com>
        <7e9318b4-1281-11ce-8144-5f7e4449e2e1@talktalk.net>
Date:   Tue, 24 Oct 2017 21:41:36 +0900
In-Reply-To: <7e9318b4-1281-11ce-8144-5f7e4449e2e1@talktalk.net> (Phillip
        Wood's message of "Tue, 24 Oct 2017 11:01:45 +0100")
Message-ID: <xmqq7evklnun.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD34B16C-B8B8-11E7-A284-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

>> I suspect that it would be sufficient to make update_head() helper
>> function take the reflog action message as another parameter
>> instead to fix the above, but there may be other reasons why you
>> chose to do it this way---I cannot read it in your empty log
>> message, though.
>
> Good point, sorry I should have added some explanation about that. I
> went with using setenv() rather than passing a reflog message to
> update_head() as it meant there were no changes needed on the sequencer
> side as it already sets GIT_REFLOG_ACTION. As the sequencer already sets
> GIT_REFLOG_ACTION, and git-commit does not fork any subprocesses I don't

Doesn't "git commit" run number of hooks?  Is it just the current
code does not run any hooks (by chance) after these new setenv()
calls are made and we happen to be safe?
