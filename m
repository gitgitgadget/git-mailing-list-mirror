Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 757861FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 22:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933002AbcLGWqO (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 17:46:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56499 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932755AbcLGWqM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 17:46:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D13125643A;
        Wed,  7 Dec 2016 17:45:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MxARf+jKBWGDK1HOcGet9/7XPUc=; b=JCRgon
        ae+rJgLBm9I4NHsez+2qKEFj/i9C8sPYt8kQz5LiCCayFSsO1P7Kv+E3tm1GPnX1
        bIzdiHcSonqPdrgXh6up4uKW84yo78cxQ6Z3Xe9V6tC6vBaCY72jbgMzcmwfA+JR
        zwHVqji2VYloPs9/Bak1OMt6/NogIYNSqzyB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n/AKouJ5QJU7ErJqcmMBkfM7auMm5pCb
        qSH4tpQMEHFGUlOUVG/RE9hsO/kueUmhyeJw9eXicSMXVIiV+POYO5TQ6jyGkuR5
        XJ9Ft1vBE3cubaASm2EPgZk5ykVd6EHMpltOK7EvofUB8O83eamMWaftFZKTS7Yz
        7GOoWde4ZEc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C91CC56439;
        Wed,  7 Dec 2016 17:45:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4368856438;
        Wed,  7 Dec 2016 17:45:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCHv5 4/5] worktree: get worktrees from submodules
References: <20161207210157.18932-1-sbeller@google.com>
        <20161207210157.18932-5-sbeller@google.com>
Date:   Wed, 07 Dec 2016 14:45:29 -0800
In-Reply-To: <20161207210157.18932-5-sbeller@google.com> (Stefan Beller's
        message of "Wed, 7 Dec 2016 13:01:56 -0800")
Message-ID: <xmqqvauvuzna.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB7AA23E-BCCE-11E6-A213-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +	submodule_common_dir = strbuf_detach(&sb, NULL);
> +	ret = get_worktrees_internal(submodule_common_dir, flags);
> +
> +	free(submodule_gitdir);

This sequence felt somewhat unusual.  I would have written this
without an extra variable, i.e.

	ret = get_worktrees_internal(sb.buf, flags);
	strbuf_release(&sb);
