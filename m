Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1977220135
	for <e@80x24.org>; Wed,  8 Mar 2017 23:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754204AbdCHXhM (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 18:37:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50524 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750869AbdCHXhL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 18:37:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADDA66FC61;
        Wed,  8 Mar 2017 18:37:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KxOMlrKq9bei2KT9xLMUNb96sLY=; b=t97wdt
        yZU9HMsaAAgsQVUb5NAECFyQ+VdtU39AChuzIrnVxhTcHP5zwbgP+MCHIu+dILEW
        TqQrT/jDDAbTdt4YRMPi3anoxb4D4Irid+USSavqDx2iYzAGQIx2ysa3vFcw+XhN
        tmr9ckaSOmYIcBQYHYjHKZBovLOBJnJztMlcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xhyfVFp0ZQTiZIraQG60KlKPTszLD4g/
        56K5uacDGtMHZV/WRrGGf0H+yudb1Q4auYIEqx9iB/QMU4rZUY7NAgd3Mm/iVrJs
        wROwtMkvFEqei64Sq9rD9rm0TLbaw8ZzwyMX2909+dh9O64OsKwW0O+41p1teUZX
        bXe5+txjeYA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A57176FC60;
        Wed,  8 Mar 2017 18:37:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0F2556FC5F;
        Wed,  8 Mar 2017 18:37:09 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        David Turner <novalis@novalis.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 15/18] read-cache, remove_marked_cache_entries: wipe selected submodules.
References: <20170302004759.27852-1-sbeller@google.com>
        <20170306205919.9713-1-sbeller@google.com>
        <20170306205919.9713-16-sbeller@google.com>
        <xmqqfuio674n.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbdJa54YyKPHR9ycuJBVtyNY_2yaD7_5RPPu++Awiz5cA@mail.gmail.com>
        <xmqqlgsg4lj4.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYF63E17SNa9wt3X_28kbvjNujUBPoMct=RvDcyOeJm-w@mail.gmail.com>
Date:   Wed, 08 Mar 2017 15:37:07 -0800
In-Reply-To: <CAGZ79kYF63E17SNa9wt3X_28kbvjNujUBPoMct=RvDcyOeJm-w@mail.gmail.com>
        (Stefan Beller's message of "Wed, 8 Mar 2017 14:39:21 -0800")
Message-ID: <xmqq1su71gt8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25885BE8-0458-11E7-85E0-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Side-question:
> Is there some doc (commit message), that explains the difference
> between CE_REMOVE and CE_WT_REMOVE ?

That's something you need to ask Duy, I think, as it was introduced
at e663db2f ("unpack-trees(): add CE_WT_REMOVE to remove on worktree
alone", 2009-08-20) and was added for the sparse checkout stuff.

During my review of the series that added the feature, I only had
time to make sure that the patches do not change the behaviour when
it is not in use, ignoring the other side of "if" statement that
checked ce_skip_worktree(ce) ;-)
