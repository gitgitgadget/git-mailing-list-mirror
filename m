Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936B2C433E4
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 21:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 699562075D
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 21:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d4/LcBPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgGJVGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 17:06:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64817 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgGJVGM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 17:06:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 22E736BD9F;
        Fri, 10 Jul 2020 17:06:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K8hqADHzDYyySaJlgD+ShjsppPc=; b=d4/LcB
        PNb3hjhexFeF41EfQfE+eNwx0eN2V2Bv7nc/l/n+xs90PhRjgHyTUr7ay76tX/ze
        C8NNcSLllUEBWWpTXCdxsQAN9BfQvyR54iTaNgT0nIXZDLWqYwnupQJLFDnVguSQ
        BWtla19LYGV5INDKQvD7f4hh09hjm55L89uUI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vo/CSOZ1S3sMjmwBj3Uf18d04avHBgHK
        rBZFNHQ3EA6LkFycT+RcPwZ7Jlfd8Ry6pkk9rW77CdmNrN1fJrnwxFLNbxKpHkj7
        moX3YZ2uneqyYd4yyE8o7jQRjRj/6pfyKh6Rj01WHnIeDDVmaRBSS0wq6+s1Ku8y
        mB/ZiBJXReo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1916E6BD9E;
        Fri, 10 Jul 2020 17:06:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 829C96BD9D;
        Fri, 10 Jul 2020 17:06:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Junio C Hamano via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 4/4] Cleanse reflog messages in the refs.c layer
References: <pull.669.git.1593518738.gitgitgadget@gmail.com>
        <pull.669.v2.git.1594401593.gitgitgadget@gmail.com>
        <6ca5b99c8d7af1a3f35b3a7d25db284c879a2f10.1594401593.git.gitgitgadget@gmail.com>
Date:   Fri, 10 Jul 2020 14:06:07 -0700
In-Reply-To: <6ca5b99c8d7af1a3f35b3a7d25db284c879a2f10.1594401593.git.gitgitgadget@gmail.com>
        (Junio C. Hamano via GitGitGadget's message of "Fri, 10 Jul 2020
        17:19:53 +0000")
Message-ID: <xmqqtuyfrsg0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CF8097C-C2F1-11EA-AEA6-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Junio C Hamano via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Currently, the cleansing of the reflog message is done by the files
> backend, before the log is written out.  This is sufficient with the
> current code, as that is the only backend that writes reflogs.  But
> new backends can be added that write reflogs, and we'd want the
> resulting log message we would read out of "log -g" the same no
> matter what backend is used.

I _think_ there is no correctness impact, but this slightly changes
the semantics.  We used to take whatever random string from the
caller and at the lowest layer of the files backend, i.e.

>  	strbuf_addf(&sb, "%s %s %s", oid_to_hex(old_oid), oid_to_hex(new_oid), committer);
>  	if (msg && *msg)
> -		copy_reflog_msg(&sb, msg);
> +		strbuf_addstr(&sb, msg);

cleansed and added the message to strbuf.

With the updated code, normalize_reflog_message() is defined like so

> +static char *normalize_reflog_message(const char *msg)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	if (msg && *msg)
> +		copy_reflog_msg(&sb, msg);
> +	return strbuf_detach(&sb, NULL);
> +}

to always return a non-NULL but an empty string, even if the caller
gave us a NULL pointer.  We always pass a non-NULL string around,
and the updated low-level code avoids calling strbuf_addstr()
because msg is not NULL, but *msg is '\0'.

We _might_ be able to optimize by tweaking the normalizer a bit
further, perhaps like so:

    static char *normalize_reflog_message(const char *msg)
    {
            struct strbuf sb = STRBUF_INIT;

            if (msg && *msg)
                    copy_reflog_msg(&sb, msg);
            if (sb.len) {
                    return strbuf_detach(&sb, NULL);
            } else {
                    strbuf_release(&sb);
                    return NULL;
            }
    }

to avoid allocating 1 byte '\0' on the heap by strbuf_detach() when
sb here ends up being truly empty.

But it would be a premature optimization to worry about such a thing
at this point, I think.

Thanks.
