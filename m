Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897CDC433E2
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 20:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FE6620809
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 20:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hQrA61Rp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgIOUfz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 16:35:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54831 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgIOUfl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 16:35:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A222749EB;
        Tue, 15 Sep 2020 16:34:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tZQMlP3Zbp+p7C7u0+4q0hrFxDw=; b=hQrA61
        RpbA5H3GmszW0pF9/8BzATT4nkXQupof+0o9Zuqhy9h3tiRADgr2OwqGgkOTpt9s
        8ftvVn/fxKUWmsvxBG9PWSgvUJTOHi1Rle3BWBu3Kw+lXJSHGfGDbweRgXxT/v94
        Cz0p4FcSesSbZSRGO5CfD3TS+Co1VPqMLmFZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Zev2BKmP+dxk5AgPRQWqQ37pe3hK+Hna
        MqKAml/qUENunu1Rdc/fWMIsFIvnSObUSHSpeZsJp0TwG30OP/F0B+C6OHpCbYdy
        ax0ySTb5HEmC4fhJfCH26vwPnaI2/hKpiwXx3mTsE1iVSn5034OHB2LsI78UNeQw
        PtKyWUaPsCU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 41625749EA;
        Tue, 15 Sep 2020 16:34:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C4174749E9;
        Tue, 15 Sep 2020 16:34:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 1/2] t5534: new test case for atomic signed push
References: <20200915095827.52047-1-hanxin.hx@alibaba-inc.com>
Date:   Tue, 15 Sep 2020 13:34:56 -0700
In-Reply-To: <20200915095827.52047-1-hanxin.hx@alibaba-inc.com> (Han Xin's
        message of "Tue, 15 Sep 2020 17:58:26 +0800")
Message-ID: <xmqqr1r2zslr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB0084BE-F792-11EA-B905-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Xin <chiyutianyi@gmail.com> writes:

> +	cat >expect <<-EOF &&
> +	error: atomic push failed for ref refs/heads/noff. status: 2
> +	error: failed to push some refs to '"'"'dst'"'"'
> +	EOF
> +	test_i18ncmp expect actual

Another thing I forgot to say.  This expects the exact phrasing of
error message to stay the same, which is not really desirable.  We
might want to start quoting `refs/heads/noff` in the message like
other messages often do, for example, and this test will have to
match.

If you expect that the failure is not due to GPG (i.e. the updated
code in 2/2 wants to fail before asking GPG to do anything), why
not grep for what your "Fake gpg" says in the error output and make
sure that message does not appear?  That would make this test a lot
more robust, I suspect.



> +'
> +
>  test_done
