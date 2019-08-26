Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCBDB1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 14:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732583AbfHZOiv (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 10:38:51 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57669 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731824AbfHZOiv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 10:38:51 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A9A66BC56;
        Mon, 26 Aug 2019 10:38:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fpvEPVwxqgAT2sB8i1lGoGf4Y9Y=; b=b/AcOk
        Y4FyDcZAw1jz+2TtYmrKKBKnSnJYbiJBZBTvyUtPzmxtKv4LYtBQ/8qu+0OqkeHf
        9hJXt2wrp61FcCEfhhZW1RAlX3tyVQtuKK5oqJkV9ifTOD3snLpGzdrm1NSFzo5J
        f7zXoOTySEMnctbCj7BxI30a2AHN0YrTxEdc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fXpElvwG0/CEPLhM4NEfSkK6zX98Z2QC
        UAXkq2YMcBF4Ea7nd2ULWjF3znh5IZWe3LPlu7aufIlTnw56JW7dcwofNjpuh+Lx
        y2+6HyYemZjCQVsaawpdkd4sCndxlNalrzcuMWORJ9V6W63gKZd82gsa/ntlKHe7
        gMyFT1/9HcU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 246AB6BC55;
        Mon, 26 Aug 2019 10:38:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 203326BC54;
        Mon, 26 Aug 2019 10:38:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Albert Vaca Cintora <albertvaka@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [Feature Request] Option to make .git not read-only in cloned repos
References: <CAAQViEsZW4PzHr5BrkDHU2kSd_e04n02McGPgrmXGZMpgaTePg@mail.gmail.com>
        <d31b871a-5c2d-99e7-5616-6f43759bb948@kdbg.org>
        <CAAQViEv1_YXPxLRN=eT7yQhro55K4audnouzAjjbHhJsU7pgQA@mail.gmail.com>
        <34935414-4e69-114b-7a32-f94514e3679d@iee.email>
Date:   Mon, 26 Aug 2019 07:38:45 -0700
In-Reply-To: <34935414-4e69-114b-7a32-f94514e3679d@iee.email> (Philip Oakley's
        message of "Sun, 25 Aug 2019 23:41:32 +0100")
Message-ID: <xmqq5zmkkn4a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36D4936C-C80F-11E9-8651-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> Surely (?), if we are considering our stored revisions to be
> immutable, then removing the write bit is the right thing to do.
> If I understand correctly (*) we don't separate the delete permission
> from 'no-write' permissions, so the consequence will be that such
> files are read-only.

And directories (e.g. .git/objects/) are not made read-only for
obvious reasons.  Read-only files inside a writeable directory can
be deleted just like read-write ones can be (iow, the "delete
permission" comes from the "write permission" of the containing
directory) so "rm -r .git" should "work" just fine (depending on the
definition of working, of course---it is discouraged to throw away
your work).

Perhaps Windows filesystem or file manager application behave
differently and tries to protect users from removing read-only files
in read-write folders by mistake, or something?  If that is what the
thread is complaining about, I agree that's a bit unfortunate.
Perhaps Windows port can implement "this is an immultable file---do
not write into it" slightly differently in adjust_shared_perm()?
