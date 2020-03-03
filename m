Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F1AC3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 14:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3724A20838
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 14:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lFnJMah9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgCCOHs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:07:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61939 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgCCOHs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 09:07:48 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 774083FD68;
        Tue,  3 Mar 2020 09:07:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kJ9SQb1WrSwz0z+jNsMJ75EfxyE=; b=lFnJMa
        h9KVA/WjS3senTKq6FoYQFa6TsrD4qVs2JwQ0ixA7ugiH2yg426irhGAPiSUSMCh
        b06/+X4eSeRw9Dk/M6bNx+4fXegmkDU+lhVF84C1dC29RO4ARBm5ZCMKjEiAXIrU
        u1qRWOsSMq6RVRfpgEBV7YeMiZU2/0opFiafs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dDx/A6k+QcxFhZ7XjaCO0dtddDRdtfnN
        buJR62R/ZZuf1t268fP78TNXHG5T+CnsCOPMTyXq1DG0II/s0c6asZOjsj7oL6zi
        NLI085rACSDObYzl3pYmAI9kOBNzQMuuHXFOZuZyoDnbHpnz0NFmyjXRPf0lz4cZ
        nI+H1/msm5o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F5393FD67;
        Tue,  3 Mar 2020 09:07:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C40413FD66;
        Tue,  3 Mar 2020 09:07:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 5/5] bugreport: add compiler info
References: <20200302230400.107428-1-emilyshaffer@google.com>
        <20200302230400.107428-6-emilyshaffer@google.com>
Date:   Tue, 03 Mar 2020 06:07:45 -0800
In-Reply-To: <20200302230400.107428-6-emilyshaffer@google.com> (Emily
        Shaffer's message of "Mon, 2 Mar 2020 15:04:00 -0800")
Message-ID: <xmqqpndta5vy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BE142AC-5D58-11EA-B058-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +static inline void get_compiler_info(struct strbuf *info)
> +{
> + ...
> +	if (len == info->len)
> +		strbuf_addf(info, _("no compiler information available\n"));

s/addf/addstr/ to squelch https://travis-ci.org/git/git/jobs/657572439

> +}
> +
> +static inline void get_libc_info(struct strbuf *info)
> +{
> + ...
> +	if (len == info->len)
> +		strbuf_addf(info, _("no libc information available\n"));

Ditto.

> +}
> +
> +#endif /* COMPILER_H */
