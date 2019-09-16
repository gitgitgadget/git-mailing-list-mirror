Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42A7A1F463
	for <e@80x24.org>; Mon, 16 Sep 2019 18:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389658AbfIPSDd (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 14:03:33 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55970 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfIPSDd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 14:03:33 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A1A60921CF;
        Mon, 16 Sep 2019 14:03:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2HFH1wVk7ImmvOAs6uxMnIXt5fY=; b=PZONr2
        lxSBjK0I+p4oWE/6lXJOJIMLWQB12j/U7CEENUeA7zo8YXJQhDVUmWcAaRguR/gb
        tj68tKJU68Zd8N8bLU/BIRUyJvVVvCHzyuACH6fv1JBGqNt3UunwxHwl4KE+oEj1
        KLjiKY1cFbyhbXLR5Q91ZOnVPWnkksJMKjTYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Hgm/wVCUKh/XACqtptlOuJY9PCcnLXIQ
        iiaoHF7eM2mXSUTBOQeAhwhen+43N9alsGpQ2bW6Dg2AA3BlfsJOWu53R6DOh/wm
        QvDSY0HsZGtaW5RcRceDiwkHiXzCnCVxMjLnvlNOkDuqcUE51rj1qJ2D5nov065s
        S/2oP5QMDp8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 99BE4921CE;
        Mon, 16 Sep 2019 14:03:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C906D921CC;
        Mon, 16 Sep 2019 14:03:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Schmidt-Cisternas <robert@schmidt-cisternas.net>
Cc:     git@vger.kernel.org
Subject: Re: GIT_OBJECT_DIRECTORY ignored when cloning submodules
References: <CAEq5TVWLxpc2a4fCch=DZfOgDWjKiu6gv0cfVHC3Wdy9581aSg@mail.gmail.com>
Date:   Mon, 16 Sep 2019 11:03:27 -0700
In-Reply-To: <CAEq5TVWLxpc2a4fCch=DZfOgDWjKiu6gv0cfVHC3Wdy9581aSg@mail.gmail.com>
        (Robert Schmidt-Cisternas's message of "Sat, 14 Sep 2019 18:07:00
        +0200")
Message-ID: <xmqq8sqoazkg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49F6AC2A-D8AC-11E9-8700-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Schmidt-Cisternas <robert@schmidt-cisternas.net> writes:

> However, when cloning a repo with submodules, the variable is cleared

GIT_OBJECT_DIRECTORY applies to the source object store, not the
target object store---clearing is very much intentional, I think.

An operation like clone, fetch and push can involve two object
stores (iow, you can do them between two repositories on the same
machine using local transport), and allowing both sides to use the
same GIT_OBJECT_DIRECTORY would probably not make much sense.
