Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB635C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 00:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CE6206F5
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 00:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tZadAv0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgCaAV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 20:21:58 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61520 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbgCaAV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 20:21:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1FE40B268E;
        Mon, 30 Mar 2020 20:21:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vIZlwmsIgNsf9VfJwHT8tmiQj/4=; b=tZadAv
        0d2L7fY2EhzPk3cNf7yIsPIWsRODmHA3y5OivnES1fo+TyYDkvS7xhFRAP1sVxcV
        PuznKfjf09cPWyZ4J9UK97dbxR1wBvrofVppgG8lpAx8DQYuU+ospieZnX7z9a59
        wOuEnJ0AHjufI8tnGj/seiIZPcw7NaF8EghQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EGIcV64YCakBhcL1yJHcGi1ho/scyaK/
        qv06ROZbSI+oUuI1r3f37bv5gmZbrQM6CXDMXw/UULsCSQOsGncg2QZ56z/WX5ay
        0IGF6GkeNNMDscuMemKGXUpSeOMkVG15flY8QUeLKWMmnayC+d+ieZ8+A5fREAZS
        226B+j3H4pE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1843EB268D;
        Mon, 30 Mar 2020 20:21:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 608BBB268C;
        Mon, 30 Mar 2020 20:21:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v5 2/6] receive-pack: add new proc-receive hook
References: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
        <20200330165754.19195-3-worldhello.net@gmail.com>
Date:   Mon, 30 Mar 2020 17:21:51 -0700
In-Reply-To: <20200330165754.19195-3-worldhello.net@gmail.com> (Jiang Xin's
        message of "Mon, 30 Mar 2020 12:57:50 -0400")
Message-ID: <xmqqtv2574rk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F501A66-72E5-11EA-AD74-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
> new file mode 100644
> index 0000000000..aafa3e8e59
> --- /dev/null
> +++ b/t/helper/test-proc-receive.c
> @@ -0,0 +1,172 @@
> +static void proc_receive_verison(struct packet_reader *reader) {

Is that a phone company ;-)?

> +	int server_version = 0;
> +
> +	for (;;) {
> +...
> +static void proc_receive_read_commands(struct packet_reader *reader,
> +				       struct command **commands)
> +{
> +	struct command **tail = commands;
> +
> +	for (;;) {
> +		struct object_id old_oid, new_oid;
> +		struct command *cmd;
> +		const char *refname;
> +		const char *p;
> +
> +		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
> +			break;
> +		}
> +
> +		if (parse_oid_hex(reader->line, &old_oid, &p) ||
> +		    *p++ != ' ' ||
> +		    parse_oid_hex(p, &new_oid, &p) ||
> +		    *p++ != ' ')
> +			die("protocol error: expected 'old new ref', got '%s'",
> +			    reader->line);
> +		refname = p;
> +		FLEX_ALLOC_MEM(cmd, ref_name, refname, strlen(refname));

		FLEX_ALLOC_STR(cmd, ref_name, refname);

> +		oidcpy(&cmd->old_oid, &old_oid);
> +		oidcpy(&cmd->new_oid, &new_oid);
> +
> +		*tail = cmd;
> +		tail = &cmd->next;
> +	}
> +}
