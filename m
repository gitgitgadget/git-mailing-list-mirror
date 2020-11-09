Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F5EC2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0EED206B6
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XMhpALjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbgKIWpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 17:45:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61604 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731474AbgKIWpe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 17:45:34 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B396292E72;
        Mon,  9 Nov 2020 17:45:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=M+zBGqTBpeKeI1w1t2s1uK5T198=; b=XMhpALjJbotl+mYwOmMl
        g+OTiHRki1MgJYqk/9x7U9HB8RZtiMfXlntKOIGdaAMUtkN3m3am/aG41biys9HY
        yF/ys6lTqUKNuU08ptP32u6HweDp54VGWNhlMMj+8vhPzC4yGLSj8o5bH+palIpT
        hJDAiG1jibpt/fRQybrG8EI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=wg2LtzSgFY/blz2FFW15ugt5zaOowU5T3jTX3C0enTHC0f
        X8JFCtTIef4nbzIJFHSgQ8obzPE0m7mGw/i3FfVC/GAAAZA7DL9iAIcmy3RzneuM
        Rz6q7OcuBy584o/KMwl5QDV3eOki9DhX7efaKRcq6o+BERRhLHP18H3N0uMRI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB98192E70;
        Mon,  9 Nov 2020 17:45:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4049F92E6F;
        Mon,  9 Nov 2020 17:45:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ryenus <ryenus@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: support comma-separated fetch specs list?
References: <CAKkAvaxrG0aYw-wo_WW7zSkX=mjU8ABgXGbbPCFOhMBa4WTJ+Q@mail.gmail.com>
        <xmqq1rh9ptka.fsf@gitster.c.googlers.com>
        <CAKkAvawVbyTPxDFQMEJMh+dzgQ_C0PXtbQKMo8xMNjgL_buGng@mail.gmail.com>
Date:   Mon, 09 Nov 2020 14:45:31 -0800
Message-ID: <xmqqsg9i9mk4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 460563B4-22DD-11EB-ABB4-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ryenus <ryenus@gmail.com> writes:

> Maybe the cause is also my ignorance or lack of carefulness to read the
> docs, but searching for "comma separated list" in Git manual would
> return hundreds of results:
> https://www.google.com/search?q=%22comma+separated%22+list+site%3Agit-scm.com
>
> So I guess it's fair to expect it to work in the fetch spec as well?

I doubt it.

The contents of these "comma separated list" are taken from a fixed
vocabulary and not from unbounded set of things the end-user can
freely come up with that allows a comma as part of values.

In other words, "--option=ours,theirs" may make sense only because
we control the vocabulary 'common', 'ours', and 'theirs', and we
make sure the vocabulary does not contain any word with comma in it.

When somebody adds a new option, we try hard during the review not
to allow "--option=thing1,thing2,thing3" as the syntax we give at
the UI level where thing$n are end-user controlled values, because
that would rob end-users from the option of having a comma in their
thing$n (for whatever reason).  Certain kind of things naturally do
not make sense to contain comma in them (e.g. list of numbers, for
example) and we may allow end-user controlled input as part of a
comma separated tuple, and when the tuple has a fixed length whose
size will never change, we may allow end-user controlled thing as
the last element of such a comma-separated tuple, but extending that
to refspec, pathspec, etc. is a bit of stretch, I would have to say.



