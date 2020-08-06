Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEE5C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 22:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D72221E5
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 22:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s7kmR0eI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgHFWp1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 18:45:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51890 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgHFWp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 18:45:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 62D49E8D5E;
        Thu,  6 Aug 2020 18:45:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6GEnFKxoKWhgwmgTryQr3aWV38E=; b=s7kmR0
        eIG/HdWwXUoKxnXVHu1f8+LIBTUNPU2DtQSKZ+Fu1ug9jrirzOxotyZxcGh/sc8u
        S588Dw9MhVhAIl5bdz1zZYc9I6RIIZrgZIM7tTmAVs2l7sujIBLJAaEwJ31JgYPw
        M4OmGlLLbRYlT8Wyfxe0FxLHwpJUd3XiTJnqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ITrUfRwRYGrsLYC3XSVePeudvzVxQMTl
        xd/18fHHSQv9lTXUtwgnb5vhEXkJMJlSETeQ5oCF0cqDI5PoHFuIjSlqFcc7vpnK
        RtXBItBo1SWRdBwNOTXXNspHHVKQpnoACTWyffYwYW9B6+GiXb/6RDhCfTg+dESt
        gsqhjH94LUs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4D462E8D5D;
        Thu,  6 Aug 2020 18:45:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 726D8E8D5C;
        Thu,  6 Aug 2020 18:45:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, Prathamesh Chavan <pc44800@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 5/5] submodule: port submodule subcommand 'summary' from shell to C
References: <20200806164102.6707-1-shouryashukla.oo@gmail.com>
        <20200806164102.6707-6-shouryashukla.oo@gmail.com>
Date:   Thu, 06 Aug 2020 15:45:20 -0700
In-Reply-To: <20200806164102.6707-6-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Thu, 6 Aug 2020 22:11:02 +0530")
Message-ID: <xmqq5z9vjsvz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82F03D36-D836-11EA-B617-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> ...

> +			argv_array_pushl(&cp_log.args, "--pretty=  %m %s",
> +					 "--first-parent", NULL);
> +			argv_array_pushf(&cp_log.args, "%s...%s",
> +					 src_abbrev,
> +					 dst_abbrev);

> ...

> +	diff_args.argc = setup_revisions(diff_args.argc, diff_args.argv,
> +					 &rev, NULL);

Peff's jk/strvec topic will soon be in 'master', and basing the
series on top of 'master' after that happens would make these lines
to read like

			strvec_pushl(&cp_log.args, "--pretty=  %m %s",
				     "--first-parent", NULL);
			strvec_pushf(&cp_log.args, "%s...%s",
				     src_abbrev,
				     dst_abbrev);

	diff_args.nr = setup_revisions(diff_args.nr, diff_args.v,
				       &rev, NULL);

We may even be able to reduce line wrapping thanks to shortening a
few common words:

    argv_array => strvec
    argc       => nc
    argv       => v

For today's integration, I dealt with these as conflict resolution,
so let's keep review discussion going, and hope jk/strvec is in
'master' by the time this topic becomes ready.

Thanks.
