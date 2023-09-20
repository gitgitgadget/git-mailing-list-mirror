Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34ABC04FFE
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 21:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjITVIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 17:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjITVIo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 17:08:44 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D69EC6
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 14:08:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c4ec85ea9so4113107b3.0
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 14:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695244115; x=1695848915; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CdAKOYVjUEPSpotRLSfP9L9mULSgkw8wQtRtWIGEXFg=;
        b=13ZSWlQdtc6gBczTC5tqYsY8OHJHPGtQK+KXKPGpHUWMk0icTYTfLhpVnkZptJrixs
         9BWZu3rYrfIZqpjwmlml2XYcbCZ9gEIwH7Ac7GUcbfwm4gDLIl1ZJiZXro7FGyqfnon0
         h49GQmsblfnBKq+ze0FNPm883fFWiYLRHOf8GrTYmDXFuNw/QeDAvNptuojUy2Z10DJE
         oJm0Kg6xuB1J0MCxsVZ//hmzeOuFmTMbozHJ+PX2WKxcONvgsaz7qs9LmOwaKmVcejg3
         XNl7WAoEwne8Cc+ZWQuEaCz5P47Ni6Gz6K4eJCAcCqtzXQsMSrcDrLBUsPrav9gz6Lwr
         LXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695244115; x=1695848915;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CdAKOYVjUEPSpotRLSfP9L9mULSgkw8wQtRtWIGEXFg=;
        b=N5uPtc0fF83qH9+bnJ4zKPktbGLC2ziM8va4NJqOxbH1zVqzmNp8P7u1o4y0tqdQlr
         i7dxGdkUCP0xp/53fzzwUmlwnPQgU95/FN21lkChgdUYMlhpEHqR8Llm9B9b08mgd/ii
         kRujvAaOdYj7MEh/PcWwnjl8RydwQXToRWvcK5iPh6W0VqJJi/Mcl9vSX7uzDsONaj4f
         0h2yuYfezfDzuaGzi5CII5/Ell4FW5B3atyRBWHFHCgrwscpTRF1OsUG+bTz2DLHfvgI
         m/ztWQhoEm8aBbBbsiPg60F6zFMwVlhfHCGr9BRNAAVRpJQGdnGAHvSlAiSeZ961m04y
         rbIQ==
X-Gm-Message-State: AOJu0Yyno2/jyMp9YehHOgVAbasC93+C04Gud0MNLfBOSYzDqiGEOOIH
        XWBG/u0V4rq77G8Q6D4zTznode3sIi+0Re0r5/IW
X-Google-Smtp-Source: AGHT+IGKee9oxwNlfViVWr1cpz7yDyLn4D7FvTN7JfY2OplPUI4Yyu7isTzgEkZ/DsDoMXuw00bKwf4oVzA56vn+wN+A
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:4930:c3d9:5d10:5fbd])
 (user=jonathantanmy job=sendgmr) by 2002:a81:b602:0:b0:592:7bc7:b304 with
 SMTP id u2-20020a81b602000000b005927bc7b304mr56443ywh.8.1695244115515; Wed,
 20 Sep 2023 14:08:35 -0700 (PDT)
Date:   Wed, 20 Sep 2023 14:08:32 -0700
In-Reply-To: <20230919071956.14015-1-worldhello.net@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230920210832.2305886-1-jonathantanmy@google.com>
Subject: Re: [PATCH] pkt-line: do not chomp EOL for sideband progress info
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:
> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> 
> In the protocol negotiation stage, we need to turn on the flag
> "PACKET_READ_CHOMP_NEWLINE" to chomp EOL for each packet line from
> client or server. But when receiving data and progress information
> using sideband, we will turn off the flag "PACKET_READ_CHOMP_NEWLINE"
> to prevent mangling EOLs from data and progress information.
> 
> When both the server and the client support "sideband-all" capability,
> we have a dilemma that EOLs in negotiation packets should be trimmed,
> but EOLs in progress infomation should be leaved as is.
> 
> Move the logic of chomping EOLs from "packet_read_with_status()" to
> "packet_reader_read()" can resolve this dilemma.
> 
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>

I think the summary is that when we use the struct packet_reader with
sideband and newline chomping, we want the chomping to occur only on
sideband 1, but the current code also chomps on sidebands 2 and 3 (3
is for fatal errors so it doesn't matter as much, but for 2, it really
matters).

This makes sense to fix.

As for how this is fixed, one issue is that we now have 2 places in
which newlines can be chomped (in packet_read_with_status() and with
this patch, packet_reader_read()). The issue is that we need to check
the sideband indicator before we chomp, and packet_read_with_status()
only knows how to chomp. So we either teach packet_read_with_status()
how to sideband, or tell packet_read_with_status() not to chomp and
chomp it ourselves (like in this patch).

Of the two, I would prefer it if packet_read_with_status() was taught
how to sideband - as it is, packet_read_with_status() is used 3 times
in pkt-line.c and 1 time in remote-curl.c, and 2 of those times (in
pkt-line.c) are used with sideband. Doing this does not only solve the
problem here, but reduces code duplication.

Having said that, let me look at the code anyway.

> @@ -597,12 +597,18 @@ void packet_reader_init(struct packet_reader *reader, int fd,
>  enum packet_read_status packet_reader_read(struct packet_reader *reader)
>  {
>  	struct strbuf scratch = STRBUF_INIT;
> +	int options = reader->options;
>  
>  	if (reader->line_peeked) {
>  		reader->line_peeked = 0;
>  		return reader->status;
>  	}
>  
> +	/* Do not chomp newlines for sideband progress and error messages */
> +	if (reader->use_sideband && options & PACKET_READ_CHOMP_NEWLINE) {
> +		options &= ~PACKET_READ_CHOMP_NEWLINE;
> +	}
> +

This needs a better explanation (than what's in the comment), I think.
What this code is doing is disabling chomping because we have code that
conditionally does it later.

>  	/*
>  	 * Consume all progress packets until a primary payload packet is
>  	 * received
> @@ -615,7 +621,7 @@ enum packet_read_status packet_reader_read(struct packet_reader *reader)
>  							 reader->buffer,
>  							 reader->buffer_size,
>  							 &reader->pktlen,
> -							 reader->options);
> +							 options);

OK, we're using our own custom options that may have
PACKET_READ_CHOMP_NEWLINE unset.

> @@ -624,12 +630,19 @@ enum packet_read_status packet_reader_read(struct packet_reader *reader)
>  			break;
>  	}
>  
> -	if (reader->status == PACKET_READ_NORMAL)
> +	if (reader->status == PACKET_READ_NORMAL) {
>  		/* Skip the sideband designator if sideband is used */
>  		reader->line = reader->use_sideband ?
>  			reader->buffer + 1 : reader->buffer;
> -	else
> +
> +		if ((reader->options & PACKET_READ_CHOMP_NEWLINE) &&
> +		    reader->buffer[reader->pktlen - 1] == '\n') {
> +			reader->buffer[reader->pktlen - 1] = 0;
> +			reader->pktlen--;
> +		}

When we reach here, we have skipped all sideband-2 pkt-lines, so
unconditionally chomping it here is good. Might be better if there was
also a check that use_sideband is set, just for symmetry with the code
near the start of this function.


