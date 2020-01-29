Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AACC2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 18:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD34D2071E
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 18:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hb2tSqqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgA2Se4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:34:56 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54095 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgA2Se4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 13:34:56 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 68953A0764;
        Wed, 29 Jan 2020 13:34:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ez1EOU5JLIh6jzfl9MhtRjtI4qo=; b=Hb2tSq
        qU8VLe2OReB5y5wIvBl94hSUpVeYrTgd93Rn3WSAqAzOaab1KOFJzw4RkHDaYbOo
        CGBQNW7H8CSUf6o8kOLJhgYNhiBJbWgDOq4SJHf9WMxZ2ZqUSiB6lzaWo/lQnpXv
        d7wT94vFI546tE31LNjhdvPETp75UkE4XkC6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iLbRiqz/mfmno590MzBE2uYVfo7Of696
        feLHnvCZQ4cSyhO3rFSDiq6uZh8XLwjIbmMZ/nx1HepIrGq/E7vTU+/8/j0umEdr
        TJDoBcdG58pmcxNHJhEq3e4PvkNIZoiaucSmxYXXj4OE9eFTqqSs8WygZLhKiJLq
        D+K/zfJ23rA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5FD1BA0762;
        Wed, 29 Jan 2020 13:34:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8EA72A0761;
        Wed, 29 Jan 2020 13:34:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 5/5] Reftable support for git-core
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
        <721201269df47dc2e406e4091ab6b18a4a59b65f.1580134944.git.gitgitgadget@gmail.com>
        <20200128073100.GA563058@coredump.intra.peff.net>
        <2215899.n3y15ba4yI@mfick-lnx>
        <20200129081259.GB601903@coredump.intra.peff.net>
Date:   Wed, 29 Jan 2020 10:34:49 -0800
In-Reply-To: <20200129081259.GB601903@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 29 Jan 2020 03:12:59 -0500")
Message-ID: <xmqqmua65cxi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 095909EA-42C6-11EA-BA81-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I was mostly thinking of hacky scripts that tried to touch .git/refs
> directly. And there are a few levels of dangerous there:
>
>   - if you're doing "echo $sha1 >.git/refs/heads/master", then you're
>     not locking properly. But it would probably work most of the time.
>
>   - if you're properly taking a lock on ".git/refs/heads/master.lock"
>     and renaming into place but not looking at packed-refs, then you
>     might overwrite somebody else's update which is in the packed file
>
>   - if you're trying to read refs and not reading packed-refs, obviously
>     you might miss some values

... but the values you read are the right ones as loose refs overlay
and trump what is in packed-refs.

 - if you're trying to delete a branch by removing a file under
   refs/, that would uncover the corresponding entry in packed-refs,
   if exists---in other words, you may resurrect an older value of a
   branch instead of deleting it.
