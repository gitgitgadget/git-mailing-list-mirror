Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667DBC2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 22:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C50B2080D
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 22:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g78hX6Nf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfLZWBR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 17:01:17 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60328 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfLZWBR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 17:01:17 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 871F3A913A;
        Thu, 26 Dec 2019 17:01:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x3adokvtPBpJ2Jjcsb0uackWK40=; b=g78hX6
        NfcoBT98UVufLDEjBLJS5xbTOdDTgs8ybXCtYK6jBeVi+VW3IHHrrvKD+WRIlzCk
        eUykeB1boXPVtc9T8wYBxd7Hw6a0nv+da2s739Xzk22hybtH27i08JpwVGlV7dMD
        VBGEa2di+xFOjTrTOp6awgu4yffYG4h4Y7Ew8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=grAFdUxvhur6O7v7aW7J0ZcPWCmwrI9G
        Fnaiujh5j6yDLQsANNUuTbbOMe9y91x3eNCQU35s8dfmSR3o0eoc3y1n2VK3CWLb
        cxHqYxiZUTGJvNU+K4mSDpLjJ6UU0xqzboflmwnvW0KKxSMbYVWZ2QisoWiET9o1
        rYjSyHHzKzo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D674A9138;
        Thu, 26 Dec 2019 17:01:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3C4A2A9137;
        Thu, 26 Dec 2019 17:01:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: only test index entries for backslashes, not tree entries
References: <pull.682.git.git.1577382151.gitgitgadget@gmail.com>
        <4a120fd0b32d2d6492eac6b0494ad6b1bc2ba500.1577382151.git.gitgitgadget@gmail.com>
        <20191226200316.GD170890@google.com>
        <nycvar.QRO.7.76.6.1912262221000.46@tvgsbejvaqbjf.bet>
        <20191226214245.GA186931@google.com>
Date:   Thu, 26 Dec 2019 14:01:09 -0800
In-Reply-To: <20191226214245.GA186931@google.com> (Jonathan Nieder's message
        of "Thu, 26 Dec 2019 13:42:45 -0800")
Message-ID: <xmqqfth6kaqi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3AC09CCE-282B-11EA-8A9B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Is there anything we can or should do to prevent people checking in
> new examples of paths with backslash in them (on all platforms)?

I obviously won't dictate what should happen on Windows, but I think
the overall principle for paths recorded in a tree object that can
be problematic on some of the platforms ought to be:

 * fsck and transfer.fsckobjects should be taught to notice
   offending characteristics (e.g. has a backslash in it, is one of
   the "reserved names" on some platform like LPT1).

 * if paths with the offending characteristics are *so* obviously
   useless in real life and are possible only in a crafted path that
   is only useful to attack users, the check in fsck should default
   to "reject" to help the disease spread via hosting sites.

 * otherwise, the check should be to "warn" but not "reject", so
   that projects can keep using paths that may problematic on
   platforms that do not matter to them.

I think LPT1 and friends fall into the "warning is fine" category,
and a path component that contains a backslash would fall into the
"this is an attack, just reject" category.

