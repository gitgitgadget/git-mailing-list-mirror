Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0CFC433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 22:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1617E206D8
	for <git@archiver.kernel.org>; Thu, 14 May 2020 22:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oz0A79aM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgENWan (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 18:30:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54948 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbgENWam (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 18:30:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E86C5F0EE;
        Thu, 14 May 2020 18:30:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wf12Z2+yBkrpSs3XX6na3x+9q5Q=; b=oz0A79
        aMpkersfVBV96kpq8+v31Q5QC4Is7gR54GByjwvndyLc5R2jod8p1VaDXMoKEY+c
        bOYnrgACz5SHWSTJvqF/6BoPswl8J/dynVZqMzJ0NFEbtk+HXp0NVrTOjdo04ry1
        ITfula/qS44IFHCOYFuItBgQK5akAbgFFvQUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nwVKBL3cP98wXNMNPwQF88Cqj0fImUmv
        wj4ydatKH5dhC6Srsy5xA/R6xP7xfKSedGplWGFHFVW3kwsifWEkr3iioGBKDIZo
        KzfoOW3hozSN+gwTmUJf74BF9xHkWneWc/Ls2Ebc9srPKM1A/bp5yBLWaAADhlsf
        D9B5k7xzbGY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 776165F0ED;
        Thu, 14 May 2020 18:30:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EC9D35F0EC;
        Thu, 14 May 2020 18:30:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Caleb Gray <hey@calebgray.com>
Cc:     git@vger.kernel.org
Subject: Re: Add a "Flattened Cache" to `git --clone`?
References: <CAGjfG9a-MSg7v6+wynR1gL0zoe+Kv8HZfR8oxe+a3r59cGhEeg@mail.gmail.com>
        <20200514203326.2aqxolq5u75jx64q@chatter.i7.local>
        <20200514210501.GY1596452@mit.edu>
        <CAGjfG9bsQh2C6WP242v4LoiaSdghZDPuqns0VO82Txe-V54_KA@mail.gmail.com>
        <xmqqmu6ap4dw.fsf@gitster.c.googlers.com>
        <CAGjfG9akT+KG-tttRWEX_ZqxrqPoY_4Ed7Pymt4DkV5Rgc1CEA@mail.gmail.com>
Date:   Thu, 14 May 2020 15:30:39 -0700
In-Reply-To: <CAGjfG9akT+KG-tttRWEX_ZqxrqPoY_4Ed7Pymt4DkV5Rgc1CEA@mail.gmail.com>
        (Caleb Gray's message of "Thu, 14 May 2020 15:04:46 -0700")
Message-ID: <xmqqeermp2sw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A3B00B2-9632-11EA-B2F7-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Caleb Gray <hey@calebgray.com> writes:

> Actually those are the steps that I'm explicitly hoping can be
> skipped, both on server and client, after the first successful clone
> request transaction. The cache itself would be of the end resulting
> `.git` directory (client side)... unless I have misconceptions about

If you look at .git/objects/pack/ directory in your repository that
is a clone of somebody else, most likely you'd find even number of
files in there, those whose filename ends with .pack and their
counterparts whose filename ends with .idx extension.  Both files
must exist to perform any local operation, but during the initial
cloning, only the bits in the former are transferred, and the
contents of the latter must be constructed from the bits in the
former.

You can introduce a new protocol that copies the contents of the
.idx, but the contents of that file MUST be validated on the
receiving end, which entails the same amount of computation as our
clients currently spend to construct it out of .pack, so in the end,
you'd be wasting more bandwidth to transfer .idx which is redundant
information without saving processing cycles.
