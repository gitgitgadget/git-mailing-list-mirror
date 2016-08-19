Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B27711F859
	for <e@80x24.org>; Fri, 19 Aug 2016 21:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755382AbcHSVLl (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 17:11:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61844 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752435AbcHSVLl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 17:11:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CEFC835EF8;
        Fri, 19 Aug 2016 17:11:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/edzr6wBKTh3AESUNuXEkLcivZc=; b=a2KMhd
        C1+c/p95vW2F/OywoVC/qPTRLDVHdlg1ZjAiK7FH0Cl6/DY1QZoVz1PM3ajIcRmr
        0QkIbJLZuYUZDlDZ7A4W5dLH+f4AUfRTraGYITZe4QzoAs0eQgtriTO6o5C2hwu1
        C69ZUTkGagHmUV1uiqLryr1WO78LJ+PWjOpMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hy5QvDR1EUculg7W5mJYjeFzSLohyc3G
        rz0y6VWz6zfsBXjMRvEy9oSQKu0yBAEC9xBFMGCK49tZXllB+d26K5CVxMwHbeU9
        tTZNbVwPWZQKvN5XltDkOIq/lcdIQtazzDKWiXCkp7RU+A2Jzv5+I+gQJjxestCd
        Jm1CJM4yj0o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C4DF935EF7;
        Fri, 19 Aug 2016 17:11:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B93735EF6;
        Fri, 19 Aug 2016 17:11:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v8 4/8] submodule: allow add_submodule_odb to work even if path is not checked out
References: <20160819000031.24854-1-jacob.e.keller@intel.com>
        <20160819000031.24854-5-jacob.e.keller@intel.com>
        <xmqqvayw1q1z.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xrFkCbLyvXKt1PKYsdFH2rCmjdMEyB27sDEScvGhxs7XA@mail.gmail.com>
Date:   Fri, 19 Aug 2016 14:11:37 -0700
In-Reply-To: <CA+P7+xrFkCbLyvXKt1PKYsdFH2rCmjdMEyB27sDEScvGhxs7XA@mail.gmail.com>
        (Jacob Keller's message of "Fri, 19 Aug 2016 13:32:27 -0700")
Message-ID: <xmqqy43szcom.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 851F90B2-6651-11E6-A01F-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> submodule. I think we already have the complete path. Or is the name
> *not* equivalent to the path?

A submodule that is bound to top-level at "path" originally gets
"path" as its name.  If you move it elsewhere, you do not want it to
lose its identity (and its place in .git/modules/* of the
top-level).  so a submodule whose name is "path" can reside in the
new place after such a move.

> There was no empty line in the place I copied from.

Is that "because I copied from a source that is mistaken, I refuse
to make it right"?  Or just an explanation why there is a mistake?
Or something else (like "we should update the original one while we
are at it as a pure clean-up")?

> If we put them in test_expect_success setup they aren't.

Yes, that is why I said they are unnecessary.  Let's minimize the
amount of random code that sits outside the control of the test
framework (i.e. test_expect_{success,failure}).

Thanks.
