Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119BCC433C1
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 11:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9BFB61972
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 11:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhCTL3Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 07:29:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53835 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhCTL2u (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 07:28:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D62A11B4D6;
        Sat, 20 Mar 2021 01:50:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YStEqdT/3Jpthh1HwLbg0yFA25Y=; b=p430IH
        x3dIRJGeEcbp7ILOumjo6mUv9QwBIHS3lc4SAly0PuNSY6majLAjNjcXmEqEbD8o
        j8WY0sKyAaOJMFHSySsO0pqCliySslzWeIiDn/idKLxBwtAL2ooeNMgDQ1Uec48e
        6UcnGZgzDsxvK55w3ss4T1Cf/jsARUYb2KPdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vOfyqhW6TxF70WUKMb5fSLXlFxicZcsZ
        Pl7VV5ujE6GVD5F/oKEpqx/M6dJlrw6kwq3EKCTjuFSCm74p731K6wjFZnPgYTXW
        v3haOp5i+V4Cl/x47/fgzaLb4LDnLoiU41UdkngUlkxUiVuRoI9IdVegvAO4jBnU
        bJONZxfutlE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7A13A11B4D4;
        Sat, 20 Mar 2021 01:50:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B0D3C11B4D3;
        Sat, 20 Mar 2021 01:50:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: Re: [PATCH v10 2/3] interpret-trailers: add own-identity option
References: <pull.901.v9.git.1615891183320.gitgitgadget@gmail.com>
        <pull.901.v10.git.1616066156.gitgitgadget@gmail.com>
        <42590e95deeece6ba65e0432c3a59746e717fee3.1616066156.git.gitgitgadget@gmail.com>
        <xmqq1rcctgj7.fsf@gitster.g>
        <CAOLTT8RzvQzD0baWPdJzRLK3Q+WeJR_HNA4RVHMxRmwHeym9QQ@mail.gmail.com>
        <xmqq7dm3p344.fsf@gitster.g>
        <CAOLTT8TQdT1PkdfuOk92U89Lgk9o_YhdeMyHb6SrE7GW+6PQJQ@mail.gmail.com>
        <YFWCvePMGvBY/I9v@coredump.intra.peff.net>
Date:   Fri, 19 Mar 2021 22:50:46 -0700
In-Reply-To: <YFWCvePMGvBY/I9v@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 20 Mar 2021 01:06:05 -0400")
Message-ID: <xmqq4kh6l6fd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 381F64F6-8940-11EB-96F5-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If I understand Junio's suggestion correctly, it is very similar to how
> "commit --author" works. See how it calls find_author_by_nickname(),
> which finds the first commit matching the name, and then pulls out the
> full name from format_commit_message().

Yup.

But I have to warn readers that it would not be a sane approach to
simply expose find_author_by_nickname() from builtin/commit.c as if
it is a generally reusable helper function.  In a very limited
context of "git commit", what the helper does is OK to run a single
revision traversal without cleaning the parsed commit objects and
object flag bits after finding a single commit.

But generally, it would not be an approach that would scale (e.g. I
do not know if we can expect to be able to call the helper function
twice and get sensible results out of it).
