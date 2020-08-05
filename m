Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C97C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33D222B42
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZEPGag7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbgHEUG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:06:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50922 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgHEQeH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 12:34:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F392CE4298;
        Wed,  5 Aug 2020 11:54:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0hA0TQYj/abI5UppEA29QUR92Y0=; b=ZEPGag
        7XrbPVGoyWJr2+9dvloDVVVzQxC6RtIf384qTrN0nd8Pk70qIRjJuGYCRGKHvDBl
        yXvQw5WHP37jLsH2nvNvErge43Ax0sY5bJD0h7RTJfgNb5MmPW19qYn49ludBO3A
        yNQndsPg3v51rRNKhvGE3U6uIiYzajh5vqTWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rRh84st/8qedYl9sets9c5nv/H6NfCPZ
        V8tJl2kCn71BbaSmV/vNjAaO07xvur1ahAtxGT+XauXN6zsPOhqJk8EuUZVzWSF4
        YGA4TXsdJGlS+pmM9gm1lc+jlqZ/EO1Ng4PmQed0OkiRSqUSXLFlCcP4S0Mp0gyN
        zMtrf93coRE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EA8B4E4297;
        Wed,  5 Aug 2020 11:54:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 35E38E4294;
        Wed,  5 Aug 2020 11:54:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v3 0/3] Remove special casing for PSEUDOREF updates
References: <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
        <pull.673.v3.git.1594925141.gitgitgadget@gmail.com>
        <xmqqwo33f6xb.fsf@gitster.c.googlers.com>
        <CAFQ2z_P+L5ystTA8MjSjnUJQyEoH5Q3QtnMd0ezJpKPv_ntrgA@mail.gmail.com>
        <xmqqpn8hgca7.fsf@gitster.c.googlers.com>
        <CAFQ2z_O1sRm-_SNP=-GvgNLqB+qgf6k9YVfbF1XCAmFWdeX6Ew@mail.gmail.com>
        <xmqqh7tjv6hb.fsf@gitster.c.googlers.com>
        <xmqq1rklrhle.fsf@gitster.c.googlers.com>
        <CAFQ2z_NU4=WcUDvVY9PNs+p-WU4u5=QY+=DHonGyK29numhWoQ@mail.gmail.com>
Date:   Wed, 05 Aug 2020 08:54:01 -0700
In-Reply-To: <CAFQ2z_NU4=WcUDvVY9PNs+p-WU4u5=QY+=DHonGyK29numhWoQ@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 5 Aug 2020 12:48:21 +0200")
Message-ID: <xmqqk0ydozqe.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E28BE2D0-D733-11EA-B069-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

>> All of which means FETCH_HEAD is special and we may not want to
>> burden the special casing of it to newer backends.
>
> Can you confirm that FETCH_HEAD is the only thing that can store more
> than just a symref / SHA1 ? Based on the name, and a comment in the
> JGit source, I thought that MERGE_HEAD might contain more than one
> SHA1 at a time.

No I cannot.  I do not think MERGE_HEAD is something I added with as
deep a thought as I did with FETCH_HEAD.  If it mimics FETCH_HEAD,
then perhaps it does, but I somehow doubt it.

As can be seen in builtin/merge.c::collect_parents(), we do special
case FETCH_HEAD when grabbing what commit*S* to merge, but all
others are read with get_merge_parent() that makes a single call to
get_oid(), i.e. anything other than FETCH_HEAD cannot have more than
one object recorded.
