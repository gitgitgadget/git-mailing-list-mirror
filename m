Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108C9C2BA83
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 21:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9ABC21741
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 21:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W/ywOPp4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgBGVMj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 16:12:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51126 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgBGVMj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 16:12:39 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0293155C82;
        Fri,  7 Feb 2020 16:12:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yD73h2/5G91V
        c54ZYQi652pmFFo=; b=W/ywOPp4E2BTEYgAbriYvHEq5ZAXgEll7vIbglvT9zTT
        +DIjPcjiGNo1W45vfgo0Pgoh1RtJwqImkZAIIgY4DV5jZ8h0EUcGlAUI8yLeYXcn
        EF/X1dwqpOWZDz1VwQO11KvDqt4nc0Y0S6GvSqPKFKh9XJzaMElFneevzRPD/WE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=gkn4Du
        /iMw2vUV5V5GXz9vKJIHOQDKjJLqm78HxnL67b22Xl9jdsRWXhlyqqxEL4n3T3T3
        GBazRr5ozR+vhMhQ84aoADsU45Q3lH9ITinvyIzVLbdGU6tUmEPDTSNKZtbdGEdF
        5v6kzf+yo/SUWnINpv7Fgb/CHhjnaoL+IpBec=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EEF9A55C81;
        Fri,  7 Feb 2020 16:12:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C8E255C80;
        Fri,  7 Feb 2020 16:12:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Pratyush Yadav <p.yadav@ti.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org
Subject: Re: bug? illegal text in commit log
References: <20200204010524-mutt-send-email-mst@kernel.org>
        <b005193f-24b7-7b6f-f3dc-c7a98db14ed7@web.de>
        <xmqqd0arfyw8.fsf@gitster-ct.c.googlers.com>
        <20200207110216.ppf5aksfkam54bip@ti.com>
        <c67e59a2-0f81-8311-e14c-f27876e45cf0@web.de>
Date:   Fri, 07 Feb 2020 13:12:37 -0800
In-Reply-To: <c67e59a2-0f81-8311-e14c-f27876e45cf0@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 7 Feb 2020 21:31:03 +0100")
Message-ID: <xmqqh8022jay.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 91B6CC94-49EE-11EA-A870-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> That's a good idea from a usability point of view.  However, mailinfo()
> parses patches line by line.  It doesn't know the total number of lines
> until it's done.  (It would if the Lines header from RFC 1036 was
> mandatory for emails; RFC 2076 says it's "not standardized for use in
> e-mail".)  It cannot easily go back at that point.
>
> Reading the whole message into a buffer or a temporary file would be an
> option, but that would give up the nice property that patches are
> streamed.

True, but we could do a two-pass approach, perhaps?  That is

 * The first pass does exactly the same as what today's code does,
   PLUS it prepares for the case where we thought the log message
   ended because we saw "diff -" or "Index: " before seeing "---",
   by scanning for the first "---"while running handle_patch().

   If there is no such "oops, a 'diff -' in the log message fooled
   us" event, we complete with what today's code does.

 * But if we detect such a case during the first pass, we run
   ourselves again with the same input and arguments, PLUS an extra,
   new option, which tells us that "we know '---' exists in the
   input and it *is* the patchbreak.  This of course can be done
   only when the standard input is seekable, but builtin/am.c does
   store the mail in a file, so...

