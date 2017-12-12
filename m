Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 815951F406
	for <e@80x24.org>; Tue, 12 Dec 2017 21:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbdLLVGL (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 16:06:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59365 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751949AbdLLVGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 16:06:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0515DC19C2;
        Tue, 12 Dec 2017 16:06:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tZgVPJ3IyTJINhFxmOS/fZomzjM=; b=RMw4Yj
        j26nLFyPUw3BQnggERtzs8o4HNosgM16J2OvHz7p7XTczDBTSTPYoeyHFPOlnZAR
        QIFr22eUxDkV0fVf98xpKvPPM9nDIbGLyxpCU39qLNPM6o/3YY0LDVzRJZMH/BUH
        du/2VkQV+FtgAGexucYwix5PxP2ddox5/F6no=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LrccBuA29tjhXLh2vhBUN/6TGNxDlUGU
        gZUdtXwhPZJ45bjcglu/XPOLKxU4pfWtYqxJLXpkSW0mvEMG7xtVOBsDmrjMR4h+
        EfEHyfLstktQkd/ZJVVJZCrFdwBRq/+HT5CfFAZFOZgtkvBY1rEEzCZGh8L7KzGx
        uNtCHszV3ws=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F0EF8C19C1;
        Tue, 12 Dec 2017 16:06:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5CEF7C19C0;
        Tue, 12 Dec 2017 16:06:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     dnj@google.com, git@vger.kernel.org, judge.packham@gmail.com,
        kostix+git@007spb.ru, manschwetus@cs-software-gmbh.de,
        max@max630.net, peff@peff.net, sunshine@sunshineco.com
Subject: Re: [PATCH] t/helper: ignore everything but sources
References: <xmqqbmj31zve.fsf@gitster.mtv.corp.google.com>
        <20171212205606.75581-1-sbeller@google.com>
Date:   Tue, 12 Dec 2017 13:06:07 -0800
In-Reply-To: <20171212205606.75581-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 12 Dec 2017 12:56:06 -0800")
Message-ID: <xmqqr2rzzmf4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 463243AA-DF80-11E7-9515-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Yes, there is also one lonely shell script in there, which also needs
> exclusion.

Thanks for catching them.

> +*
> +!.sh
> +!.[ch]

I'd use this instead, though.

-- >8 --
*
!*.sh
!*.[ch]
!*.gitignore
-- 8< --

In a dirty repository full of crufts but without any local
modifications, if you do

    $ git rm --cached -r t/helper
    $ git add t/helper

you should be able to make your index identical to HEAD.  The
version that was posted did not resurrect .gitignore and none
of the source files, but the replaced one should.
