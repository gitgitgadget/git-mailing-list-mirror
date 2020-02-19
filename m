Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22FFC7619D
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 22:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89AE1208C4
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 22:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wCZMSH+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgBSWdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 17:33:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57900 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgBSWdr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 17:33:47 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 505A7493E4;
        Wed, 19 Feb 2020 17:33:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=igQQ/dJBmkUskJ+uCTE+e9OlU8o=; b=wCZMSH
        +ou4kukevqImdi9dFZJFfbSM8TFSibDp0eWib5J1GNIC7wMv/cM+TRwM7HmFntP+
        wxIo6FdtnhgJ6nUl9H3u71WKYexgwxxdwIxwISt9tTMOaBCe1yHEtf9rR9M3FTAE
        AbuiN4+Qoeg/WUqpIuQD2nn/6CA8pHm3fIhtU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fI5nbgipn+78u5Tr82RyGpviRxKJ1RKU
        +VyVKK+PtcLQv1Yi5+wVLzMYEXREkIZpkAkshAJ02k5wkvcKSFuzgF7aQoF1FMtg
        VVLI6ofSZuRJv5Wo4H11JBQHN4aYCURxdGQKqEMYYowICe9P5iJrUostHrZzVxJA
        T8cbgz5EiVk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 35CA8493E2;
        Wed, 19 Feb 2020 17:33:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5641E493DE;
        Wed, 19 Feb 2020 17:33:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v7 07/15] bugreport: add git-remote-https version
References: <20200214015343.201946-1-emilyshaffer@google.com>
        <20200214015343.201946-8-emilyshaffer@google.com>
        <nycvar.QRO.7.76.6.2002191524460.46@tvgsbejvaqbjf.bet>
        <20200219222807.GB26221@google.com>
Date:   Wed, 19 Feb 2020 14:33:42 -0800
In-Reply-To: <20200219222807.GB26221@google.com> (Emily Shaffer's message of
        "Wed, 19 Feb 2020 14:28:07 -0800")
Message-ID: <xmqqpneacim1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E26C7DD2-5367-11EA-A032-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> Also, in keeping with the existing code, we would need to use
>> `--build-options` here (this is what `git version` calls the equivalent
>> mode).
>> 
>> _However_.
>> 
>> I like your `--build-info` a lot more than `--build-options` (because the
>> latter is very misleading: the commit and the date of the build are not
>> "options" at all).
>
> Sure. Thanks for saying so.

I don't think anybody would mind introducing --build-info to "git
version" as a synonym and deprecate --build-options from it ;-)
