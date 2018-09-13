Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F9CA1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 14:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeIMUIB (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 16:08:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35641 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbeIMUIA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 16:08:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so6160293wre.2
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 07:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wHuD7owPat9lt5SOKUH9wajQMdZDYPc7m7YVsKVEN44=;
        b=kwGDRMuH8ZKbtLmOlbRCIJJFr3gL8yNuAIGj1TrBptWoZB6AXDOM9ZMSJqlZiXVVb/
         OoXwxvBIh5acpsO8YOjHDEZ+WfZaXr6MF9aCk2bkgk/an99z5A3SWiotSsFfkQEfWTJx
         nR9Zwokit3Tp+PHiOsl6j0E/mwA43ivYAygXzi4WoNNmAAwLxcSnerpg6++WeSD3aXtI
         K/IBMOUwAA9ECxjyr7tsajez1831+HUhNo7TSsf5vDpzdPU8CQ/izK+6MCiHTEn2+PEd
         2PRIM0QMnGHZLf8OPlADAIs3qxnSHKsgMGkMjZ09gAxYg2X0mMTePRzLrEn3ukjyOboG
         DciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wHuD7owPat9lt5SOKUH9wajQMdZDYPc7m7YVsKVEN44=;
        b=s/uOoSYwsdMB0uiiZAJyQNQS8F0D0pm+U3g8svd9lpazg3QBR7Ck/LcQsNZNX4xPJq
         4p5Qf8uT7I/n3zBUblmpuS18irqvEdQ9Cxm5dADm+EJEDU4UNclR3Y5NAaPVRrRvyx8O
         h5JoIEHYMQjk2pZFvu15tWzXZR2oi6ZAlx+VYcL0zMAii70HM51Ur5fn5NcrtIfTak+1
         aK/fDYVuwLFb245igAUNq8gbe92OcR03sP04auj4I5CJdJu5/ofa2Fad/f4Xs50K4sWF
         JG5M3yFzHCPWj7SzoMRCO4Cpf+RyLP1BtqMmBSu6P0Vx/4r+PwZB7U+WleeoPCG0BakJ
         LW4w==
X-Gm-Message-State: APzg51BuKXXbLpU/xOpgMSwabDcqGuYGC80VvyfxiJjFTwaiVO1rmgNw
        i4wgN8B1cQ9pE8iz96fVnRM=
X-Google-Smtp-Source: ANB0VdaTdskvQpwlTrMGK+I3SHw4sc0xNXiNDGUIVIyll5BgxBXwtHFKPO1IGFMY/9UyCyp1dZnFTg==
X-Received: by 2002:a5d:4152:: with SMTP id c18-v6mr5966745wrq.61.1536850686552;
        Thu, 13 Sep 2018 07:58:06 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c19-v6sm5606357wre.86.2018.09.13.07.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 07:58:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH 1/3] archive: use packet_reader for communications
References: <20180912053519.31085-1-steadmon@google.com>
        <20180912053519.31085-2-steadmon@google.com>
Date:   Thu, 13 Sep 2018 07:58:05 -0700
In-Reply-To: <20180912053519.31085-2-steadmon@google.com> (Josh Steadmon's
        message of "Tue, 11 Sep 2018 22:35:17 -0700")
Message-ID: <xmqqr2hxigw2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Using packet_reader will simplify version detection and capability
> handling, which will make implementation of protocol v2 support in
> git-archive easier.

Is this meant as a change in implementation without any change in
behaviour?

> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  builtin/archive.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/archive.c b/builtin/archive.c
> index e74f67539..e54fc39ad 100644
> --- a/builtin/archive.c
> +++ b/builtin/archive.c
> @@ -27,10 +27,11 @@ static int run_remote_archiver(int argc, const char **argv,
>  			       const char *remote, const char *exec,
>  			       const char *name_hint)
>  {
> -	char *buf;
>  	int fd[2], i, rv;
>  	struct transport *transport;
>  	struct remote *_remote;
> +	struct packet_reader reader;
> +	enum packet_read_status status;
>  
>  	_remote = remote_get(remote);
>  	if (!_remote->url[0])
> @@ -38,6 +39,8 @@ static int run_remote_archiver(int argc, const char **argv,
>  	transport = transport_get(_remote, _remote->url[0]);
>  	transport_connect(transport, "git-upload-archive", exec, fd);
>  
> +	packet_reader_init(&reader, fd[0], NULL, 0, PACKET_READ_CHOMP_NEWLINE);
> +
>  	/*
>  	 * Inject a fake --format field at the beginning of the
>  	 * arguments, with the format inferred from our output
> @@ -53,18 +56,20 @@ static int run_remote_archiver(int argc, const char **argv,
>  		packet_write_fmt(fd[1], "argument %s\n", argv[i]);
>  	packet_flush(fd[1]);
>  
> -	buf = packet_read_line(fd[0], NULL);
> -	if (!buf)
> +	status = packet_reader_read(&reader);
> +
> +	if (status == PACKET_READ_FLUSH)
>  		die(_("git archive: expected ACK/NAK, got a flush packet"));

It is true that packet_read_line() returns a NULL on flush, but the
function also returns NULL on other conditions for which underlying
packet_read() returns 0 (or negative) length.  EOF, normal data with
zero length (i.e. packet length itself is 4), and DELIM packets
would all have led to this die() in the original code.  We fail to
notice that we got something unexpected when we were expecting to
get a normal packet with ACK or NACK on it.

> -	if (strcmp(buf, "ACK")) {
> -		if (starts_with(buf, "NACK "))
> -			die(_("git archive: NACK %s"), buf + 5);
> -		if (starts_with(buf, "ERR "))
> -			die(_("remote error: %s"), buf + 4);
> +	if (strcmp(reader.buffer, "ACK")) {

The way I read packet_reader_read()'s implementation and existing
callers (like the ones in fetch-pack.c) tells me that consumers
should not be looking at "reader.buffer"; they should instead be
reading from "reader.line".

> +		if (starts_with(reader.buffer, "NACK "))
> +			die(_("git archive: NACK %s"), reader.buffer + 5);
> +		if (starts_with(reader.buffer, "ERR "))
> +			die(_("remote error: %s"), reader.buffer + 4);
>  		die(_("git archive: protocol error"));
>  	}
>  
> -	if (packet_read_line(fd[0], NULL))
> +	status = packet_reader_read(&reader);
> +	if (status != PACKET_READ_FLUSH)
>  		die(_("git archive: expected a flush"));

This makes me wonder what happens if we got an EOF instead.  We fail
to notice protocol error here, but do the code after this part
correctly handle the situation?

>  	/* Now, start reading from fd[0] and spit it out to stdout */
