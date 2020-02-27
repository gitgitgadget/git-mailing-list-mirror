Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15234C11D3D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 16:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E010A246B9
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 16:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VagD7xSn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbgB0QXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:23:12 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52645 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730002AbgB0QXL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 11:23:11 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 353F5BF863;
        Thu, 27 Feb 2020 11:23:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DQ4owcgGztsByqI46di09MTAbsQ=; b=VagD7x
        SnwfD13ei4SxtV+Boa5R9SByAVL9ReQCcPa1calHqwJuFhBiAWLvARQhgpuGSwnB
        KBUQ6dyH+bN2AZGmb5igCd0mioR1JFJt+nrZmYh6eN2jR6UR7Oq/bELq2vcGjdLv
        Z7EATCNj1c/tmduDdIBqYBwO7ma9yJDjYfMC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GVgpZ8L74FigY9I7nBjGbs07gTkAbdTs
        oGYO3IXOOT4XQnebYm3UQjNLIiq7ZJGW4Th7yEEdKqKscaF7XkzPs6TcN5PsRqnU
        OsqcD0I15emKyG7bKVm5MpZdNRob6RvEsedAcW0qA6z81106BfOjxQTNqC16JsXY
        QrVpFULfNfI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2BF5EBF862;
        Thu, 27 Feb 2020 11:23:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 488F5BF861;
        Thu, 27 Feb 2020 11:23:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 6/6] Reftable support for git-core
References: <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
        <pull.539.v7.git.1582706986.gitgitgadget@gmail.com>
        <a622d8066c7fe27accc5101c3341c30bf706dae1.1582706986.git.gitgitgadget@gmail.com>
        <xmqq8skpjjyz.fsf@gitster-ct.c.googlers.com>
        <CAFQ2z_PikWsjFizg8=e9+YunkiaciD64BDks8=J55185NC5oQg@mail.gmail.com>
        <xmqqv9nti0gl.fsf@gitster-ct.c.googlers.com>
        <CAFQ2z_PGgQ19uyjaEaJ4XMuvbkzW5fvJng3r2vYHDz4Z6pT3Aw@mail.gmail.com>
Date:   Thu, 27 Feb 2020 08:23:05 -0800
In-Reply-To: <CAFQ2z_PGgQ19uyjaEaJ4XMuvbkzW5fvJng3r2vYHDz4Z6pT3Aw@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Thu, 27 Feb 2020 17:03:51 +0100")
Message-ID: <xmqq5zfsgfti.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7099F5A6-597D-11EA-8765-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> So, the ref backend should manage the HEAD ref, but iteration should
> not produce the HEAD ref.

Yeah, as there is a dedicated API function head_ref().

Things like ORIG_HEAD and MERGE_HEAD have always been curiosity
outside the official API, but IIRC read_ref() and friends are
prepared to read them [*1*], so the vocabulary may be unbounded [*2*].

These won't be listed in for_each_ref() iteration, either (think of
for_each_ref() as a filtered "ls -R .git/refs/" output).

Thanks.


[Footnotes]

*1* I do not offhand know if these *_HEAD pseudo-refs are written
via the refs API---it probably is the safest to arrange the ref
backends in such a way that they always go to the files backend,
even if HEAD and refs/* are managed by a backend different from the
files one.

*2* I vaguely recall that back when ref-backend infrastructure was
introduced, we had discussion on declaring that "^[A-Z_]*HEAD$"
directly under $GIT_DIR/ are these special refs (and nothing else
directly under $GIT_DIR/ is).  I do not recall what happend to the
discussion, though other folks may.
