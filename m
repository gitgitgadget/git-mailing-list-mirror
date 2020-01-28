Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41292C2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 19:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F90214D8
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 19:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O0+tuhhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgA1Tfn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:35:43 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61123 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgA1Tfn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 14:35:43 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9E680BF026;
        Tue, 28 Jan 2020 14:35:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LIWchyV8nwLve+ExsPW3Hwwdrr4=; b=O0+tuh
        hxjCAJNiPpj4L7STulthJz3aanqc8FsW+C7vGykUJq483ByUSFsEYkfI+E61k+Hz
        9P6zc012l1fC8OwHL1wDpV2tUUENGlN3I9BlNpaHiUk8rU32ATwNxsmYbAJWeCIl
        FICMmQU1ekMJS1jrsC6oHuBpae0goRMtddwrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J2n1hjAyUndksKhykwoCvMtFOIdfqWNq
        m9WHSuTxLmf+NLeNa9eA+k/KXI7gYwTJO3qCRaiYc2rabO91DaNLkQXGeoD5cMvT
        YgTLd7VXujauQ+AUhv+H/GA+boDTI1EGMZd458F9juZIwJUi66lCNdXiU6XLo7CY
        4iiWD0oZ9Ds=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 969ADBF025;
        Tue, 28 Jan 2020 14:35:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B360DBF024;
        Tue, 28 Jan 2020 14:35:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 3/5] Document how ref iterators and symrefs interact
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
        <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
        <9cf185b51f45f2df0016d7b69351ec2a7656dac2.1580134944.git.gitgitgadget@gmail.com>
        <xmqqmua8a4vg.fsf@gitster-ct.c.googlers.com>
        <CAFQ2z_Oht5yCKXCP4rb+yA+u1gnK++Uy-jmyFdN5+Q6eBi5_8A@mail.gmail.com>
Date:   Tue, 28 Jan 2020 11:35:37 -0800
In-Reply-To: <CAFQ2z_Oht5yCKXCP4rb+yA+u1gnK++Uy-jmyFdN5+Q6eBi5_8A@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 28 Jan 2020 17:07:25 +0100")
Message-ID: <xmqqv9ov74s6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D66F036-4205-11EA-BED9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

>> But I wonder if we need to even say this.  Isn't it obvious from the
>> each_ref_fn API that nothing other than the refname, object id, and
>> what kind of ref it is, will be given to the user of the API, so it
>> would be natural for a caller that wants to do extra things it needs
>> to do for symrefs must act when it learns a ref is a symref?  After
>> all, that is why the flags word is one of the parameters given to an
>> each_ref_fn.
>
> Maybe it is obvious to you, but it was not obvious to me, coming from
> JGit working on the RefDatabase.

If you found each_ref_fn API docs lacking, that probably is where
the information should go (i.e. regardless of type of refs, the
object name is filled correctly).  We need to make it obvious to the
developers who needs to use and work on the code with the API
defined and described in refs.h

Thanks.


