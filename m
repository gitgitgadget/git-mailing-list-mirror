Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09E582047F
	for <e@80x24.org>; Mon,  7 Aug 2017 22:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbdHGWxN (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 18:53:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52438 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751761AbdHGWxM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 18:53:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 60A88A208F;
        Mon,  7 Aug 2017 18:53:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mQmF1Dq+jvk5sQPxeMyBcmOfPS4=; b=Fe6OSb
        MQIiTJ5YdXNm9+NZu50Y/g/QHUHTDo12Kic6SscOuTOQWKW5phZchB5y8RQue4mU
        OQ4VAAm7P7+uOV+673EG6UrSM+a46UMeQrtL8ni0A3t1K4DuHKvQLj0QdmIQ03oe
        Of8qO4pFI29f6GoouM4+l9vI3kQtCYQxklIIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KOeUzxgI0QEeuXaQmm8NjgmkE9NSNNrV
        nqhxZqtJpd3SpOJchmNPeyNTi+WrrTiUez4ZVH3oZIC9s//pVw0Na6EPPOaO2DrH
        W8X+U2VHGZVa/vyJsPembBDW+4jHdW0A79MockohoBop1tYrcVyvh49es9yxRujE
        +NLZc2O12r8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59CBCA208E;
        Mon,  7 Aug 2017 18:53:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BC165A208D;
        Mon,  7 Aug 2017 18:53:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Cc:     git@vger.kernel.org
Subject: Re: [suggestion] Include commit-ish in git status output
References: <CACcTrKfPKdPCVONMcGRbisK_WOt70yLdjavZnLTMMVocrwzk1w@mail.gmail.com>
        <xmqqefujwqz0.fsf@gitster.mtv.corp.google.com>
        <CACcTrKewZRZpHotZ8GpO9zFifTdjkzP2th=KqkQqTvJb_k3W9w@mail.gmail.com>
Date:   Mon, 07 Aug 2017 15:53:05 -0700
In-Reply-To: <CACcTrKewZRZpHotZ8GpO9zFifTdjkzP2th=KqkQqTvJb_k3W9w@mail.gmail.com>
        (Mahmoud Al-Qudsi's message of "Mon, 7 Aug 2017 16:41:18 -0500")
Message-ID: <xmqq4ltjng6m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D5A9E34-7BC3-11E7-9F90-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mahmoud Al-Qudsi <mqudsi@neosmart.net> writes:

> Looking back, I probably should have started with that. `git
> status` gives the status of the _relative_ current state of the
> local repository without printing any information that can be used
> as an _absolute_ reference to "frame" the results of the `git
> status` command.

Yeah, that may be a good characterization of what 'git status'
does.  Another thing is that it gives only a summary.  It may say
"this and that path were changed", but it does not exactly say "how"
they were changed.  So from that point of view, even if you know
which absolute reference the status of the working tree and the
index being reported is relative to, it still does not give you
much for you to be able to reproduce the exact state.  That is not
the purpose of the tool---it is to help the user who is aware of
where s/he started from.

> If I run `git status`, make, commit, and push some changes, then
> run `git status` once more, the output of the command can be
> identical to the previous run, _even though the actual state of
> the repo has changed_ which is... less than useful and potentially
> misleading.

I do not quite understand why it is misleading.
