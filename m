Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB038C2D0DC
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 21:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41A620863
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 21:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Liy104y4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgABVlc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 16:41:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58154 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgABVlc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 16:41:32 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 308412BA74;
        Thu,  2 Jan 2020 16:41:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+PFsuYLEEto+5uqvCcDevkM0PRI=; b=Liy104
        y4K8EZgU5G9pzjg3fWZyeEx3GwyorqWWUY2ltSzy/hVaBzYjSH1JXbag/uPA2qx3
        y5si9Sj3CR/gZxNDVS20J8/L8GwGsvGDt7+GmdI73jjbrHFJiWCH95/6H/TPMiMR
        GCI2G9pz2JXwV1snSSyE5/CbKasbm1bFV4Tk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qFgxYmiOfnRi2N6QbwYTb0zYpXQ+RC47
        bzLJKVspqhnf3fgpeaZ9339asUZBeLKDVkbYnbO4iDFVnpyFO3tzTYY4EYFu3VWn
        GVWxplmAjGS/LSZ5ZLVgeHFNSQlsF3fsdzeN3C6mBpXep+IytgVgv9pgBuZNdjNL
        1IrZiJ+qWIE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 275D92BA73;
        Thu,  2 Jan 2020 16:41:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8C4682BA71;
        Thu,  2 Jan 2020 16:41:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v2] sha1-file: remove OBJECT_INFO_SKIP_CACHED
References: <20191230211027.37002-1-jonathantanmy@google.com>
        <20200102201630.180969-1-jonathantanmy@google.com>
Date:   Thu, 02 Jan 2020 13:41:27 -0800
In-Reply-To: <20200102201630.180969-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 2 Jan 2020 12:16:30 -0800")
Message-ID: <xmqqftgxedtk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2B7850E-2DA8-11EA-AB02-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> As a historical note, the function now known as repo_read_object_file()
> was taught the empty tree in 346245a1bb ("hard-code the empty tree
> object", 2008-02-13), and the function now known as oid_object_info()
> was taught the empty tree in c4d9986f5f ("sha1_object_info: examine
> cached_object store too", 2011-02-07). repo_has_object_file() was never
> updated, perhaps due to oversight. The flag OBJECT_INFO_SKIP_CACHED,
> introduced later in dfdd4afcf9 ("sha1_file: teach
> sha1_object_info_extended more flags", 2017-06-26) and used in
> e83e71c5e1 ("sha1_file: refactor has_sha1_file_with_flags", 2017-06-26),
> was introduced to preserve this difference in empty-tree handling, but
> now it can be removed.

I am not 100% sure if the implication of this change is safe to
allow us to say "now it can be".

The has_object_file() helper wanted to say "no" when given a
non-existing object registered via the pretend_object_file(),
presumably because we wanted to allow a use pattern like:

 - prepare an in-core representation of an object we tentatively
   expect, but not absolutely sure, to be necessary.

 - perform operations, using the object data obtained via
   read_object() API, which is capable of yielding data even for
   such "pretend" objects (perhaps we are creating a tentative merge
   parents during a recursive merge).

 - write out final set of objects by enumerating those that do not
   really exist yet (via has_object_file() API).

Teaching about the empty tree to has_object_file() is a good thing
(especially because we do not necessarily write an empty tree object
to our repositories), but as a collateral damage of doing so, we
make such use pattern impossible.  

It is not a large loss---the third bullet in the above list can just
be made to unconditionally call write_object_file() without
filtering with has_object_file() and write_object_file() will apply
the right optimization anyway, so it probably is OK.

Will queue.

Thanks.
