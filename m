Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BD4C55186
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 23:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B79320787
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 23:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="09u+XjXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgDVX1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 19:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgDVX1r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 19:27:47 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBC8C03C1AA
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 16:27:47 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x77so1960872pfc.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 16:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ICNXcnahBZDZCOPnt4nr7knR31Hz+jmoQA4latQgObI=;
        b=09u+XjXgzw1LjH7jPLinbDDqaOgIbRXt5krQSGIA9lkXkwVeC81cnWDuQH+OYhYnCB
         YGT4ciMKDY0xP2wO1HMHz212jghp8bfcjFe097RRHfTkbyHPApPLXbqXaXNCXsOnGtZa
         jteJeJIC9GpTpVsgygbLmf/Y9qnu+5rBK7/uHTPpv4W/eX/3dzMAFFwVQRtPzkl4bfl+
         WkWpsjxB3CR63AigW0VJyxeLw3v64TmDlYXP0n5i+9hdlP5o5J/ayCuoMx0WIOkHHV29
         Cg43+pAgkrjPhG5O43YBRIoaDIzoxB5lJFcwQWoBT7K1R4mXCEag/whSCa6Z8IqGM3tz
         VtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ICNXcnahBZDZCOPnt4nr7knR31Hz+jmoQA4latQgObI=;
        b=d3fj3eyAe0eR7IzHORf1n04sTgoLqDpYj0komOgG0RVmP+t6Fr2rxOIcrU6w22Ophx
         4eH02diu2Iqbw4g2W5DGfdfDXXAD1Jd2xAGCn/u16dhR2zA5Gfz0s3b+yGqFB8vtAzIh
         N0EKVJuw5/vvroA3z9gc6k3i4say9jRx4UvggFaXBPm5qG31SRn5GLmN3h5vsydlnq9O
         TkaX8uGRULtHQmy21plSWPtX5ZTwJ8K94RYG3uH2d+gpHmWzouHIgQ6tbgMfxJ5sfChh
         KEE0N6KRWgL+HFw6E7ghEre1KON9wGLsa1e+w5VpK1uVPlssRT5KIIFlloejNAiyhKB5
         Crsg==
X-Gm-Message-State: AGi0PuboRyGTMaN/BUvsWD4P7xPzPuhr7LWbkGCZLEbg8z4+yYWebIHz
        e+Z6T0UYdZXeMH9DoAlmVf/epA==
X-Google-Smtp-Source: APiQypJR6cuZj7nEl8Yxhjak4+vzjySN+ce6jmzSPHlYqUvNiozHp1YCD/eoWkZ1ahYzJnMZT2+KBQ==
X-Received: by 2002:a62:fccf:: with SMTP id e198mr903968pfh.119.1587598066992;
        Wed, 22 Apr 2020 16:27:46 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id y71sm579272pfb.179.2020.04.22.16.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 16:27:46 -0700 (PDT)
Date:   Wed, 22 Apr 2020 17:27:44 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH] fetch-pack: try harder to read an ERR packet
Message-ID: <20200422232744.GA19100@syl.local>
References: <20200422163357.27056-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200422163357.27056-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 06:33:57PM +0200, Christian Couder wrote:

It looks like this may be missing a:

  From: SZEDER Gábor <szeder.dev@gmail.com>

header.

> When the server has hung up after sending an ERR packet to the
> client, the client might still be writing, for example a "done"
> line. Therefore the client might get a write error before reading
> the ERR packet.
>
> When fetching this could result in the client displaying a
> "Broken pipe" error, instead of the more useful error sent by
> the server in the ERR packet.

All makes sense.

> Instead of immediately die()ing after write_in_full() returned an
> error, fetch should first try to read all incoming packets in the hope
> that the remote did send an ERR packet before it died, and then die
> with the error in that packet, or fall back to the current generic
> error message if there is no ERR packet (e.g. remote segfaulted or
> something similarly horrible).
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> This just formats the following patch from SZEDER Gábor:
>
> https://lore.kernel.org/git/20190830121005.GI8571@szeder.dev/
>
> I haven't tried to implement some suggestions discussed later
> in the above thread like:
>
>   - renaming send_request()

Agreed that this is probably something we should do. Maybe
'send_request_retry' or something? That name is kind of terrible.

>   - covering more code pathes

I see where Peff raised this point originally, but I think that this is
a good step forward as-is. No need to hold this up looking for complete
coverage, since this is obviously improving the situation.

>   - avoid blocking indefinitely by looking for an ERR packet
>     only if the write() resulted in ECONNRESET or EPIPE

I think that I may have addressed this point below.

>   - first printing an error message with error_errno() before
>     going on to look for an ERR packet

I'm not sure what I think about this one. I'd certainly welcome all
opinions on this matter.

>   - implementing a timeout

A timeout may be a good thing to do. See what you think about my
suggestion below, first, though.

>
> as it seems to me that there was no consensus about those.
>
> It follows up from discussions in this thread:
>
> https://lore.kernel.org/git/cover.1584477196.git.me@ttaylorr.com/
>
>  fetch-pack.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 1734a573b0..63e8925e2b 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -185,14 +185,27 @@ static enum ack_type get_ack(struct packet_reader *reader,
>  }
>
>  static void send_request(struct fetch_pack_args *args,
> -			 int fd, struct strbuf *buf)
> +			 int fd, struct strbuf *buf,
> +			 struct packet_reader *reader)
>  {
>  	if (args->stateless_rpc) {
>  		send_sideband(fd, -1, buf->buf, buf->len, LARGE_PACKET_MAX);
>  		packet_flush(fd);
>  	} else {
> -		if (write_in_full(fd, buf->buf, buf->len) < 0)
> +		if (write_in_full(fd, buf->buf, buf->len) < 0) {

This makes sense; if 'write_in_full' fails, we want to go into the
error-handling case below.

But, I wonder if we could do better than re-using 'write_in_full' here.
We definitely do want to write 'buf->len' bytes overall, but what
happens when a 'write()' fails? I think it's at _that_ point we want to
try and read a packet or two off from the remote.

What if instead this looked something like:

  const char *p = buf;
  ssize_t total = 0;

  while (count > 0) {
    ssize_t written = xwrite(fd, p, count);
    if (written < 0)
      return -1;
    /* note the change on this line */
    if (!written && packet_reader_read(reader) == PACKET_READ_EOF) {
      errno = ENOSPC;
      return -1;
    }
    count -= written;
    p += written;
    total += written;
  }

  return total;

That is basically the definition of 'write_in_full', but when we didn't
get a chance to write anything, then we try to read one packet.

This way, we only read exactly as many packets as we need to when we hit
this case. I'm not sure that it matters in practice, though.

> +			int save_errno = errno;
> +			/*
> +			 * Read everything the remote has sent to us.
> +			 * If there is an ERR packet, then the loop die()s
> +			 * with the received error message.
> +			 * If we reach EOF without seeing an ERR, then die()
> +			 * with a generic error message, most likely "Broken
> +			 * pipe".
> +			 */
> +			while (packet_reader_read(reader) != PACKET_READ_EOF);
> +			errno = save_errno;
>  			die_errno(_("unable to write to remote"));
> +		}
>  	}
>  }
>
> @@ -349,7 +362,7 @@ static int find_common(struct fetch_negotiator *negotiator,
>  		const char *arg;
>  		struct object_id oid;
>
> -		send_request(args, fd[1], &req_buf);
> +		send_request(args, fd[1], &req_buf, &reader);
>  		while (packet_reader_read(&reader) == PACKET_READ_NORMAL) {
>  			if (skip_prefix(reader.line, "shallow ", &arg)) {
>  				if (get_oid_hex(arg, &oid))
> @@ -372,7 +385,7 @@ static int find_common(struct fetch_negotiator *negotiator,
>  			die(_("expected shallow/unshallow, got %s"), reader.line);
>  		}
>  	} else if (!args->stateless_rpc)
> -		send_request(args, fd[1], &req_buf);
> +		send_request(args, fd[1], &req_buf, &reader);
>
>  	if (!args->stateless_rpc) {
>  		/* If we aren't using the stateless-rpc interface
> @@ -395,7 +408,7 @@ static int find_common(struct fetch_negotiator *negotiator,
>  			int ack;
>
>  			packet_buf_flush(&req_buf);
> -			send_request(args, fd[1], &req_buf);
> +			send_request(args, fd[1], &req_buf, &reader);
>  			strbuf_setlen(&req_buf, state_len);
>  			flushes++;
>  			flush_at = next_flush(args->stateless_rpc, count);
> @@ -470,7 +483,7 @@ static int find_common(struct fetch_negotiator *negotiator,
>  	trace2_region_leave("fetch-pack", "negotiation_v0_v1", the_repository);
>  	if (!got_ready || !no_done) {
>  		packet_buf_write(&req_buf, "done\n");
> -		send_request(args, fd[1], &req_buf);
> +		send_request(args, fd[1], &req_buf, &reader);
>  	}
>  	print_verbose(args, _("done"));
>  	if (retval != 0) {
> --
> 2.17.1

Thanks,
Taylor
