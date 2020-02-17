Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570E4C34022
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2235E207FD
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cDB+oWqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgBQR7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:59:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65343 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgBQR7t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 12:59:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D91DB5DA7C;
        Mon, 17 Feb 2020 12:59:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HoNrNP1aqaZXWp9O7N39laBpty0=; b=cDB+oW
        quX85/ouyO/Ur8MHCZaqdxygcOxDBn6xBDtyc7EJ6tcyCXdt+cu6yLHNaaWXwqqS
        GVz4yDTFIqkxO71B7oLlVTV1+YfoCYWcc/2UKJqxkNEliLeFMBS0IidChXajOrPQ
        r9ArWGFb8SlvShwaGkavKB3TMbU5MtLoF7usI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h9vQXIZwUU5pncFQrXOeFldawmhxQ6mB
        XpzlQmNRThi41rFC2ehxE862/xeqFsWL+J7/4wzideXj/4wP07wuXMVpDoi1uIpc
        p4a7kmTlQeLo8gBk8Z5YarU+DVDLtpTcF+OB1XDadEnHq1qVVDLvXnP17wbGubGe
        6nxKa0HmkW0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D00755DA7B;
        Mon, 17 Feb 2020 12:59:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3C0A25DA7A;
        Mon, 17 Feb 2020 12:59:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: [PATCH v2 2/8] rm: support the --pathspec-from-file option
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
        <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
        <7ccbab52e51423a9ba74c0cab77448ceabb9dcdc.1581345948.git.gitgitgadget@gmail.com>
        <xmqq4kvyyy5d.fsf@gitster-ct.c.googlers.com>
        <994b082b-cd86-a7cb-f70c-1753ad988abb@syntevo.com>
Date:   Mon, 17 Feb 2020 09:59:45 -0800
In-Reply-To: <994b082b-cd86-a7cb-f70c-1753ad988abb@syntevo.com> (Alexandr
        Miloslavskiy's message of "Mon, 17 Feb 2020 18:27:12 +0100")
Message-ID: <xmqqmu9hksby.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4850F804-51AF-11EA-87CD-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com> writes:

> On 10.02.2020 21:39, Junio C Hamano wrote:
>> Trailing whitespace on this line.
>
> Whitespaces fixed in V3; I have also activated pre-commit hook. Sorry!

I may not have time to read it over at least in a few days, but lack
if v3 in the title will make it cumbersome to come back to the
thread later X-<.  Thanks for a heads-up, anyway, thoguh.

