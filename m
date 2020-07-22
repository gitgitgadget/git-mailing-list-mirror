Return-Path: <SRS0=ybwr=BB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063C2C433E1
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 21:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A403C22B42
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 21:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F4sxlalZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732755AbgGVVO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:14:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51041 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgGVVO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 17:14:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 56327D3D46;
        Wed, 22 Jul 2020 17:14:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MmodF8AS7zgkLEUtOmcHKDGqtdw=; b=F4sxla
        lZ10hq0rmkwA5eCZu9PVaB9gx5Z47Afvg09yDJzXcvbsdRXZEGEzqjBgPg17XMSy
        2wU/4msPNlonrEBBqkW8Zi2QtOJbphRlpfNiM8c3A0yVwA6TiF0olerjJOjlwyeH
        asNqu7yW7saB5paHtmxjmCjF6s/ZXcMdsS64k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mTmA+TDOtEP0C60sTcgdtHcuScvAaldq
        A/OE95+NjFK1CziqFUpMSKKwNXnJMLGfO6/18i266Db1EOsQ8jxvLqI6EJ+3WXEd
        DLl8OpwIuOskEYS9CTYjQ2D4YEUMAXFSg/axLWfPBsAW1yG28bscZYuQ0x6Fj+jI
        uasuBwW+btM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E7B4D3D45;
        Wed, 22 Jul 2020 17:14:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 97754D3D44;
        Wed, 22 Jul 2020 17:14:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        "B. Stebler" <bono.stebler@gmail.com>, git@vger.kernel.org
Subject: Re: Improving merge of tricky conflicts
References: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
        <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org>
        <874kpzmhis.fsf@osv.gnss.ru>
Date:   Wed, 22 Jul 2020 14:14:25 -0700
In-Reply-To: <874kpzmhis.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
        22 Jul 2020 23:17:15 +0300")
Message-ID: <xmqqwo2v45hq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52CDBF16-CC60-11EA-9283-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Johannes Sixt <j6t@kdbg.org> writes:
>
>> Am 22.07.20 um 01:29 schrieb B. Stebler:
>>> I have been looking for a tool to display merge conflicts, that instead
>>> of showing the two versions of the conflicting section, would show the
>>> diff for that section in both conflicting commits.
>>
>> Perhaps you want to configure `merge.conflictStyle=diff3`?
>
> Is there 'git merge' command-line option for that? I failed to find one.

There isn't, unless you count

    $ git -c merge.conflictstyle=diff3 merge side-branch

as a "command line option" (which may technically is).
