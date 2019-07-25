Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF6191F462
	for <e@80x24.org>; Thu, 25 Jul 2019 16:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbfGYQh7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 12:37:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58724 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729324AbfGYQh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 12:37:58 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2DD3416C0CF;
        Thu, 25 Jul 2019 12:37:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1Ct6WHgvXOqgMAv1FfLmBRYqWFs=; b=PV5IZZ
        OiOXUictq+4zGHwULh/htZvty+mq/ghRzppTW0X3UAZsDI0BcFxfDVYYULupzpRv
        qCDyYmJn2HK6Eqye2gKPuc9ywY0HO2qfmXDOHv37lGhOf+VVI8AKEKrOnpYhZqBW
        219Nc+FiQnE1HIBWxUqNOhgW4awdPfCW2eCug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RMoGM+BeinKBH9zk+w8Ny9hcsCktMgv9
        zSwkIrbmeLoDYvK2aInCpqp0W8QMn4Xmalk5M+wdzdBbOpUY/BwfgfZbKYQKaadZ
        urmC8nw+sQgo3A0TGN1GNH1ZAC7rOGs//oWCxkZNxQpqanW18hFHv5JD1Zntiv3L
        +eq0G6CS3/Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 24C4B16C0CE;
        Thu, 25 Jul 2019 12:37:56 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7FE6116C0CD;
        Thu, 25 Jul 2019 12:37:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ilya Kantor <iliakan@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [git for translators] How to always generate conflicts for merges?
References: <C9A27ED4-CBD9-4FCD-B78F-8A1010D24D06@gmail.com>
Date:   Thu, 25 Jul 2019 09:37:54 -0700
In-Reply-To: <C9A27ED4-CBD9-4FCD-B78F-8A1010D24D06@gmail.com> (Ilya Kantor's
        message of "Thu, 25 Jul 2019 16:42:48 +0300")
Message-ID: <xmqqtvbaoysd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8DC9F564-AEFA-11E9-AEE5-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ilya Kantor <iliakan@gmail.com> writes:

> We're using Git to manage translations of an open-source book, and
> most of time it works well. But there's also a problem.
>
> When we pull changes from upstream (English) to translation
> (e.g. Japanese), git auto-merges them.
>
> Sometimes there conflicts, but not all the time.
>
> For example, when a new file is added to English, it just gets
> auto-merged into Japanese.  But all new changes must be
> human-controlled, translated.
>
> Is there a way to force git always generate a conflict, even if
> changes could be auto-merged?

I am not sure what the workflow here and if it makes sense.  When
you have a file, "chapter47.txt", whose original is in English, the
translation projects (there are N of them, one for each language)
will have their own "chapter47.txt" that has translated text in the
same place?  It looks to me that, working that way, the project for
translating into e.g. Japanese have no way to keep any of the
original English version, in which case why are you even "merging"
the English version in the first place?

I would have understood if the original "chapter47.txt" is translated
into "chapter47_ja.txt" and friends, like "chapter47_fr.txt", all of
which sit next to the original "chapter47.txt".  Then merging an
updated version of the original from time to time would make perfect
sense to me---that would give you a way to see what changed in the
original (e.g. "git show --first-parent -m -p master chapter47.txt")
to guide you find the places you would need to make corresponding
changes to the variant of your language, e.g. "chapter47_??.txt".

