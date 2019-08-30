Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 412941F461
	for <e@80x24.org>; Fri, 30 Aug 2019 16:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfH3Q1E (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 12:27:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51307 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbfH3Q1E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 12:27:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B6AF176E8F;
        Fri, 30 Aug 2019 12:27:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4Lt6CmDV3LKN
        LHXu+Q+M/6dgczU=; b=O8nb7R07EbJe0+OELsrIc+k5WxSCVaKgVCl9zWTTw2rQ
        jpy7/zfnricyVB3fPkLrYTp83SpI9/td7QgPZhYH69H+MGS6kL3nBuPjTNVj7Vat
        yq04IyqXLuaJV4MNCSeuRICcVrogvyHhL6Igt5Ok7LbHIReW0pKlO1RnwmNKGmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vzg0Is
        /wKkA3ePdrKqnXyjI3v7K7huoGZ83HmqFyAbtOQb3FYIM162wKdbNPfCWb70q9Eb
        LLacEWp2A1wzJytIMBWKHBvJqmMkgzCFMHNIQ54DT14VYfjFDPAYs6N9erZaOe+R
        GWsETYPuGLF4TGzk0D1CFWhjNvHyZMM9TrWq0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 527A8176E8D;
        Fri, 30 Aug 2019 12:27:01 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EE4B4176E8C;
        Fri, 30 Aug 2019 12:26:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Dmitry Nikulin <pastafariant@gmail.com>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: git-diff passes <rev>:<path> args to GIT_EXTERNAL_DIFF incorrectly?
References: <CAH53SykX12SN83=gey8KS_x3cGkXH758sfEieskXnnvos8DMcA@mail.gmail.com>
        <xmqqtva0zkvu.fsf@gitster-ct.c.googlers.com>
        <CAH53SymNwjrh_CzXVVtU5xABuGQWMsXhRDYyRzyHEwuxLWA2NQ@mail.gmail.com>
        <9c280a3f-6a1a-61d1-a255-1dcf0671d39c@gmail.com>
        <CAH53SykQWLtjt0gWVrz5KyH-9WyqaQ0GtkhmyLt09QEqcAS_dw@mail.gmail.com>
        <20190830142932.GJ8571@szeder.dev>
Date:   Fri, 30 Aug 2019 09:26:58 -0700
In-Reply-To: <20190830142932.GJ8571@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Fri, 30 Aug 2019 16:29:32 +0200")
Message-ID: <xmqqlfvazkj1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FDEC5F9E-CB42-11E9-8CDE-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> Another Python 2 vs 3 issue, perhaps?
>
>   # Python2, good:
>    ...
>    'f8fd6737fbe5a45c97ba9c9de495dc46ff11eccd',
>    '100644',
>    'file1-mv.txt',
>    'similarity index 90%\nrename from file1.txt\nrename to
>   file1-mv.txt\nindex 2bef330..f8fd673 100644\n']
>   # Python3, bad:
>   ...
>    'f8fd6737fbe5a45c97ba9c9de495dc46ff11eccd',
>    '100644',
>    'file1-mv.txt',
>    'similarity index 90%\n'
>    'rename from file1.txt\n'
>    'rename to file1-mv.txt\n'
>    'index 2bef330..f8fd673 100644\n']
>
> Let's just stick to plain old printf for now, as suggested by Phillip
> earlier, to reduce unnecessary confusion.

I notice that the latter is pretty-printed.  Pay attention to the
last few lines that end without a trailing comma.  Literal string
concatenation taking place to form a single string here, in which
case both are giving us the same string?

By the way, sorry for an earlier response based on what I
misremembered, which may have confused the discussion unnecessarily.
Ever since 65056021 ("built-in diff.", 2006-04-28) made "git diff" a
built-in, we had used (or at least attempted to use) <path> from
<treeish>:<path>, so it is not unexpected to see paths in two blob
diff output.
