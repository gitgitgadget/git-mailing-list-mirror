Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911A6C11D0C
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 19:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3B8208C4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 19:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="euDvt5zy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgBTTdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:33:36 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56751 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgBTTdg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 14:33:36 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3775FA9326;
        Thu, 20 Feb 2020 14:33:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Lbasp1dS2XoXJfGlonB58fJhV4w=; b=euDvt5
        zy/3vzbW9E57HnT89Ge7oVyqZ4aRVBtLdUayq9TEadVXbWF/XXyn2Yo5yUK8rzmZ
        p5CJ9AHtfUZ/eyluMTY1t3ie57Fpgd+gxnVTCYwGcUYeUen3E7s5zmllxhmB1C6E
        CUtcjytHl3hsoR3bec+HqZC6EtX26cPQ0VgLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v+xFqoRIcv/vaTxP7J4cTkWrNpCyNOw1
        DfwX6GuxWIkcykmAKLoOjVPEkoOkS4JXqRDhTS301da01APT7f4STierXpKZUmzZ
        5DW4MHL4vdCLbIvdikolryOv3kPMjyerJJBiqv9yIH1b73WYd1E3GOC2yw6WVZfE
        d9dpH7GjfN8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 304E2A9325;
        Thu, 20 Feb 2020 14:33:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7F5FDA9324;
        Thu, 20 Feb 2020 14:33:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 03/15] bugreport: add tool to generate debugging info
References: <20200220015858.181086-1-emilyshaffer@google.com>
        <20200220015858.181086-4-emilyshaffer@google.com>
Date:   Thu, 20 Feb 2020 11:33:26 -0800
In-Reply-To: <20200220015858.181086-4-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 19 Feb 2020 17:58:46 -0800")
Message-ID: <xmqq8skxawah.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEB1B346-5417-11EA-8B9C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +	argc = parse_options(argc, argv, "", bugreport_options,
> +			     bugreport_usage, 0);

Which one between an empty string and NULL is more appropriate to be
passed as "prefix" here?  I assume that this is *not* really a git
program, and no repository/working-tree discovery is involved, and
you won't be using OPT_FILENAME, so it would probably be OK.

> +
> +	if (option_output) {
> +		strbuf_addstr(&report_path, option_output);
> +		strbuf_complete(&report_path, '/');
> +	}
> +
> +
> +	strbuf_addstr(&report_path, "git-bugreport-");
> +	strbuf_addftime(&report_path, option_suffix, localtime(&now), 0, 0);
> +	strbuf_addstr(&report_path, ".txt");
> +
> +	if (!stat(report_path.buf, &statbuf))
> +		die("'%s' already exists", report_path.buf);

Missed i18n/l10n, but I do not think it is a useful thing for this
check to be here in the first place.

> +	switch (safe_create_leading_directories(report_path.buf)) {
> +	case SCLD_OK:
> +	case SCLD_EXISTS:
> +		break;
> +	default:
> +		die(_("could not create leading directories for '%s'"),
> +		    report_path.buf);
> +	}
> +
> +	get_bug_template(&buffer);
> +
> +	report = fopen_for_writing(report_path.buf);

fopen_for_writing() does not give good semantics for what you seem
to want to do here (i.e. to make sure you do not overwrite an
existing one).  It even has "if we cannot open it, retry after
unlinking" logic in it, which screams "this function is designed for
those who want to overwrite the file", and if you look at its
callers, they are _all_ about opening a file for writing with a well
known name like FETCH_HEAD, COMMIT_EDITMSG, etc.

Besides, a stat() that dies when a file exists would not
help---since that check, you've spent non-zero time, creating
leading directories and preparing boilerplate in the buffer,
and there is no guarantee somebody else used the same filename
in the meantime.

If you want to avoid overwriting an existing file (which I think is
a good idea---I just do not think the earlier "if (!stat()) die()"
is a good way to do so), the only sensible way to do so is to ask
your open/creat to fail if there already is a file---that is how
you'd avoid racing with another process that may be creating such a
file.  Grep for O_EXCL to find where the flag is used with O_CREAT
to see how it is done.

> +	if (report == NULL) {

Style. "if (!report)"

> +		strbuf_release(&report_path);
> +		die("couldn't open '%s' for writing", report_path.buf);

Do we see a use-after-free here?  Also missed i18n/l10n.

It is embarrassing on the reviewers' side that this (which is not
new in this round at all and hasn't changed since v6) hasn't been
caught for a few rounds X-<.

Thanks.
