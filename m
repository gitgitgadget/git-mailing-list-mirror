Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D01C55179
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 18:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B9502078E
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 18:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t0CKbglL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbgKESjd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 13:39:33 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57150 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731758AbgKESjd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 13:39:33 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2B8F1100D83;
        Thu,  5 Nov 2020 13:39:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6u7ihtRckOter2FVLoCM+CgJbVg=; b=t0CKbg
        lLe1suYyuQiDZuZhvZsWwhSNz733TcYZsuXB89CkGWe0qWSEGcTvs7KHOd6rAG1J
        A0R2T8l8YnsS7SKsYgOTrPhvN3TDmSqkQyQd6m1UFz2e1hTu600Hzocdku6qtLjV
        n7//ERA1NnY25+U8UVvlYvDqi8v57CBCbB5bs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bnxbEQatnQ3zJy/qlgWJfab/tnm3TQdB
        wsCiPklWCrRxMDEPlUqrSzUDdt//UdTP4JTpRR+xaRjsbJMzbdkdKUkxGoXUptUy
        hVq0kMJG+3yI8qZ2Y84fGvjCH2Qe/UQfSM3dDzUMMzsqw2cH+tV3L/kMgbmMKuj7
        2BNML+RyS1I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 253EE100D82;
        Thu,  5 Nov 2020 13:39:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6EDFA100D81;
        Thu,  5 Nov 2020 13:39:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v19 03/10] receive-pack: add new proc-receive hook
References: <20200824174202.11710-1-worldhello.net@gmail.com>
        <20200827154551.5966-4-worldhello.net@gmail.com>
        <nycvar.QRO.7.76.6.2011042236270.18437@tvgsbejvaqbjf.bet>
        <CANYiYbFcXN_ARmZ70GQkrQ=uFaf7YPObYcopEOFseON6TQzNpQ@mail.gmail.com>
Date:   Thu, 05 Nov 2020 10:39:26 -0800
In-Reply-To: <CANYiYbFcXN_ARmZ70GQkrQ=uFaf7YPObYcopEOFseON6TQzNpQ@mail.gmail.com>
        (Jiang Xin's message of "Thu, 5 Nov 2020 22:54:05 +0800")
Message-ID: <xmqqo8kbk5r5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C738FD2-1F96-11EB-913F-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> I think this is the right way to fix this issue, even though I cannot
> reproduce this issue in my laptop.

Perhaps it depends on the size of the pipe buffer and timing of the
processes getting scheduled?

This is a tangent but I very much like the way comments on a set of
changes below is given interspersed, explaining why the change in
each hunk is done next to it.

> 1. In the `run_proc_receive_hook()` function of "receive-pack", should
> close the input (proc.in) before reading result from "proc-receive":
>
> --  snip --
> @@ -1196,11 +1197,12 @@ static int run_proc_receive_hook(struct
> command *commands,
>                 packet_flush(proc.in);
>         }
>
> +       close(proc.in);
> +
>         /* Read result from proc-receive */
>         code = read_proc_receive_report(&reader, commands, &errmsg);
>
>  cleanup:
> -       close(proc.in);
>         close(proc.out);
>         if (use_sideband)
>                 finish_async(&muxer);
> -- snap --
>
> 2. test helper for proc-receive should consume the input stream before
> die earlier:
>
> -- snip --
> @@ -79,9 +79,11 @@ static void proc_receive_read_commands(struct
> packet_reader *reader,
>                     *p++ != ' ' ||
>                     parse_oid_hex(p, &new_oid, &p) ||
>                     *p++ != ' ' ||
> -                   die_readline)
> +                   die_readline) {
> +                       while (packet_reader_read(reader) != PACKET_READ_EOF);
>                         die("protocol error: expected 'old new ref', got '%s'",
> -                           reader->line);
> +                               die_readline? "<call with
> --die-readline>": reader->line);
> +               }
>                 refname = p;
>                 FLEX_ALLOC_STR(cmd, ref_name, refname);
>                 oidcpy(&cmd->old_oid, &old_oid);
> @@ -136,7 +138,7 @@ int cmd__proc_receive(int argc, const char **argv)
>                 usage_msg_opt("Too many arguments.",
> proc_receive_usage, options);
>         packet_reader_init(&reader, 0, NULL, 0,
>                            PACKET_READ_CHOMP_NEWLINE |
> -                          PACKET_READ_DIE_ON_ERR_PACKET);
> +                          PACKET_READ_GENTLE_ON_EOF);
>
>         sigchain_push(SIGPIPE, SIG_IGN);
>         proc_receive_verison(&reader);
> -- snap --
>
> I will send a standalone patch using git-send-email command line later.
>
> --
> Jiang Xin
