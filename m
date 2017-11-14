Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F8C21F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 14:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754507AbdKNOwh (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 09:52:37 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60787 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754400AbdKNOw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 09:52:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C15C3B3B6C;
        Tue, 14 Nov 2017 09:52:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2UuTC37LetVXgu2LaooJ1SXocw0=; b=uk8tF6
        CsLSsO7ysWYWAmnplmyb5COE1xISW1HFfBrkTlmdxWZIfuHQhI/afkTZGhQ5VADg
        KoXOGZhv+DZ+cpMh+xzW0EwZgY9RBS4munvbFTKlvnV0ToFETDnPiNaoF3cJqU1G
        YozoScpTOpeVuJeY02pdc1NZ+bEsvsorqBEEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k6Xt/uYmJDgym7KwjZ9SnmWOHyyf9zZf
        cejmujfNUHsLrdW0EweEzKlm0QJC18kR/p4x1ASMf2ENgzO6tG+LpXH1z9fq/+bV
        i1OJa+mCzXoT3fB6vJQw6xg5haeSUaYgEbR1YuMR27Ab9mOMqJ4winu/cqb9nM0N
        ykKPFNbXBcA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8D3EB3B6B;
        Tue, 14 Nov 2017 09:52:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 394E9B3B6A;
        Tue, 14 Nov 2017 09:52:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Cc:     git@vger.kernel.org
Subject: Re: [RFC 3/3] log: add an option to generate cover letter from a branch tip
References: <xmqqbmk68o9d.fsf@gitster.mtv.corp.google.com>
        <936c2b33-3432-f113-d84b-0623246ec673@suse.de>
        <xmqq7eut4cae.fsf@gitster.mtv.corp.google.com>
        <92c426bc-5ce9-da7c-5f10-66b5fc46825b@suse.de>
        <xmqqo9o52ep0.fsf@gitster.mtv.corp.google.com>
        <d4fec167-aae2-1990-4e24-faaf286f87f5@suse.de>
Date:   Tue, 14 Nov 2017 23:52:23 +0900
In-Reply-To: <d4fec167-aae2-1990-4e24-faaf286f87f5@suse.de> (Nicolas
        Morey-Chaisemartin's message of "Tue, 14 Nov 2017 14:40:34 +0100")
Message-ID: <xmqqh8tw3obc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D5AE518-C94B-11E7-AEBE-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de> writes:

>> So there probably needs a convention meant to be followed by human
>> users when writing cover letters, so a mechanical process can tell
>> which part of the text is to be made into the merge commit without
>> understanding human languages.
>
> In the long term, I agree this would be nice.  As a first step,
> could we force the --edit option when using --cover-at-tip ?  The
> basic merge message would come from the cover letter but
> can/should be edited to clear the extra stuff out.

Ah, "git merge" by default opens the editor these days, so there is
no need to do a special "force"-ing only when we are taking the
initial log message material from the empty commit at the tip.  So
that plan would work rather well, I would imagine.

Good thinking.  Thanks.
