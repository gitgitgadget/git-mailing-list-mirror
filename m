Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 575A01F453
	for <e@80x24.org>; Thu, 21 Feb 2019 19:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfBUT1B (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 14:27:01 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:48282 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfBUT1A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 14:27:00 -0500
Received: by mail-io1-f74.google.com with SMTP id w19so2582784ioa.15
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 11:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zP3svo2/OQXB/0tdz0BZZGp/NZOr/GZwIKJWInpgnVY=;
        b=tSiIsp7l8HJzo98g2XRAoDnyYoGMrN/JgqqjNP2sM10NfBUA5LXa+RK0xoycf59p70
         PCevtzmU6LO0iBRqexbz3jbpQ6L9j2Zx2agxSik5+kPiaeJbVnc/ZoGSuB2BgELyYaac
         j7QKVdVAA8dVso7Y/5HQxLIofi+wwec9YEB1PsJuNZYbqe6P+4Iv6ZpX2mJg0Jy1ux8P
         rnt+JbdUV3dRicW+lYFF9K+VDA8CijUzGofK62gC2JVniYOXjQ3rmuQgK9dlpT4/b/rG
         cJ+aXXxCtSJq0muN8AEr6urBpybxxb/ici/KoCJkw6bXJj4RVInkHAsNkHkZ48zV7dbv
         RCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zP3svo2/OQXB/0tdz0BZZGp/NZOr/GZwIKJWInpgnVY=;
        b=eJz6gVhQdSEBEWoZOg3MikXJr86NfJCFqgjOeIOuaApOqCoNEmjxCmA8NUGybWVMt1
         EqLIyIWtrrd0zNSr4d/fqswbFIuCYfV4/Vi+LvJN3cwCvzbhIk613Z7Yk9S4PEwTfkFR
         U/hfoWf0L8YJh6K93wdRskJEu7VJRqe3Nztxb8sKtFvmE0h0E4uk0GhhmoXkAPAsVrS5
         WhmFckr1wHmnr+igxpupe4K2dtWtdmEBxNI8aAgktkRy5ujzv0wXUxqrDnNHF0UnwTg4
         nJkhJBLjmeXHh5dkgIMeuF9C7P8gxeVLikAtU16SgoP9wxUHrAcz1gJCVwMb3GwdqK+7
         2uqQ==
X-Gm-Message-State: AHQUAuZd89tyloMyw6UFn0aonfVQFpoebvknbVxTv7z/dkVQAotH/2Xj
        zWv2OVhrtBidlka8v4VYn7NxWnrK0BubY8NqDovQ
X-Google-Smtp-Source: AHgI3IYLEO7StNSgHY1rV00T03mku4jybhxfATUlSx8wwxqlbthATlR1RLbhI0cjLfIYZr539mmLEA7gmyHUhKldZ4sJ
X-Received: by 2002:a24:69c6:: with SMTP id e189mr81255itc.8.1550777219277;
 Thu, 21 Feb 2019 11:26:59 -0800 (PST)
Date:   Thu, 21 Feb 2019 11:26:55 -0800
In-Reply-To: <20190221134609.GA21406@sigill.intra.peff.net>
Message-Id: <20190221192655.106489-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190221134609.GA21406@sigill.intra.peff.net>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 5/5] remote-curl: use post_rpc() for protocol v2 also
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > diff --git a/remote-curl.c b/remote-curl.c
> > index 32c133f636..13836e4c28 100644
> > --- a/remote-curl.c
> > +++ b/remote-curl.c
> > @@ -504,6 +504,18 @@ struct rpc_state {
> >  	int any_written;
> >  	unsigned gzip_request : 1;
> >  	unsigned initial_buffer : 1;
> > +
> > +	/*
> > +	 * Whenever a pkt-line is read into buf, append the 4 characters
> > +	 * denoting its length before appending the payload.
> > +	 */
> > +	unsigned write_line_lengths : 1;
> 
> Hmm, so we read a packet, and then we "append its length" before
> appending the contents. But that would always be the length we just
> read, right? I wonder if it would be simpler to just call this option
> something like "proxy_packets" or "full_packets", teach the packet code
> to give us the full packets, and then just treat that whole buffer as a
> unit. I dunno. There might be some gotchas in practice, and it's not
> like it's that much simpler. Just a thought.

Yes, the length is the length we just read. And it might not even be
simpler - this shifts the complexity to the code that does not use the 4
characters (unless we always return 2 pointers, which seems redundant,
and which now changes the problem of ensuring that the correct pointer
is used). I think that this is a good default - proxying still seems
rarer than just consuming payloads.

I'm OK with changing the name, although I think that both "proxy" and
"full" are less clear than "write_line_lengths" - aren't you still
proxying even if you're changing the format a little, and isn't a packet
"full" even without the line lengths?

> > +	/*
> > +	 * rpc_out uses this to keep track of whether it should continue
> > +	 * reading to populate the current request. Initialize to 0.
> > +	 */
> > +	unsigned stop_reading : 1;
> 
> OK, so we need this because the v2 proxying will require us to stop
> reading but keep the channel open? Kind of awkward, but I don't see a
> way around it.

I'll improve the comments here and elsewhere in the next version. This
basically means that "we read a flush but we haven't sent the 0000 to
libcurl yet, so don't read anything more until we have sent the 0000",
and "flush_read_but_not_sent" is probably a better name.

> > @@ -531,15 +580,32 @@ static size_t rpc_out(void *ptr, size_t eltsize,
> >  	size_t max = eltsize * nmemb;
> >  	struct rpc_state *rpc = buffer_;
> >  	size_t avail = rpc->len - rpc->pos;
> > +	enum packet_read_status status;
> >  
> >  	if (!avail) {
> >  		rpc->initial_buffer = 0;
> >  		rpc->len = 0;
> > -		if (!rpc_read_from_out(rpc, &avail))
> > -			BUG("The entire rpc->buf should be larger than LARGE_PACKET_MAX");
> > -		if (!avail)
> > -			return 0;
> >  		rpc->pos = 0;
> > +		if (!rpc->stop_reading) {
> > +			if (!rpc_read_from_out(rpc, 0, &avail, &status))
> > +				BUG("The entire rpc->buf should be larger than LARGE_PACKET_MAX");
> 
> Do we actually need it to be LARGE_PACKET_MAX+4 here? I guess not,
> because LARGE_PACKET_DATA_MAX is the "-4" version. So I think this BUG()
> was perhaps already wrong?

In this patch, yes (if not, the non-chunked code is useless).
Previously, the BUG should have been LARGE_PACKET_DATA_MAX, yes. The
BUG() was introduced in patch 4 of this set - I'll update that one to
LARGE_PACKET_DATA_MAX and this one to LARGE_PACKET_MAX.

> > +			if (status == PACKET_READ_FLUSH)
> > +				/*
> > +				 * We are done reading for this request, but we
> > +				 * still need to send this line out (if
> > +				 * rpc->write_line_lengths is true) so do not
> > +				 * return yet.
> > +				 */
> > +				rpc->stop_reading = 1;
> > +		}
> > +	}
> > +	if (!avail && rpc->stop_reading) {
> > +		/*
> > +		 * "return 0" will notify Curl that this RPC request is done,
> > +		 * so reset stop_reading back to 0 for the next request.
> > +		 */
> > +		rpc->stop_reading = 0;
> > +		return 0;
> 
> OK, and here's where we handle the stop_reading thing. It is indeed
> awkward, but I think your comments make it clear what's going on.
> 
> If we get stop_reading, do we care about "avail"? I.e., shouldn't we be
> able to return non-zero to say "we got the whole input, this is not a
> too-large request"?

This code is in rpc_out(), which is a callback passed as
CURLOPT_READFUNCTION. So returning non-zero means "send these bytes",
and returning zero means EOF.

We set stop_reading when we receive a flush, as you can see from the
quoted code snippet. But this does not mean that the buffer is empty -
the buffer may contain "0000" (if rpc->write_line_lengths is true, as
the comment states). We have to let libcurl repeatedly call this
function until all of the "0000" is sent (and return non-zero each
time). But once all of the "0000" is sent - we know this by avail being
zero - and libcurl calls this function once more, we have to remember to
do nothing except to reset stop_reading and return 0 to indicate EOF.

> > +test_expect_success 'clone big repository with http:// using protocol v2' '
> > +	test_when_finished "rm -f log" &&
> > +
> > +	git init "$HTTPD_DOCUMENT_ROOT_PATH/big" &&
> > +	# Ensure that the list of wants is greater than http.postbuffer below
> > +	for i in $(seq 1 1500)
> > +	do
> > +		test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/big" "commit$i"
> > +	done &&
> 
> As Junio noted, this should be test_seq. But I think it would be nice to
> avoid looping on test_commit here at all. It kicks off at least 3
> processes; multiplying that by 1500 is going to be slow.
> 
> Making a big input is often much faster by generating a fast-import
> stream (which can often be done entirely in-shell). There's some prior
> art in t3302, t5551, t5608, and others.

OK - I'll look at generating a fast-import stream. Thanks for all your
comments.
