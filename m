From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 1/4] fetch-pack: new --stdin option to read refs
 from stdin
Date: Tue, 27 Mar 2012 09:59:33 -0700
Message-ID: <7vhaxaj7yi.fsf@alter.siamese.dyndns.org>
References: <loom.20120318T083216-96@post.gmane.org>
 <m3fwd550j3.fsf@localhost.localdomain>
 <20120318190659.GA24829@sigill.intra.peff.net>
 <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com>
 <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net>
 <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com>
 <20120321171423.GA13140@sigill.intra.peff.net> <4F715CF7.5070903@gmx.net>
 <4F715D55.8020109@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Ivan Todoroski <grnch@gmx.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 18:59:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCZkF-0000cT-Fo
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 18:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858Ab2C0Q7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 12:59:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43697 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754597Ab2C0Q7g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 12:59:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8DC856A8;
	Tue, 27 Mar 2012 12:59:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0oz2Prjc+HngVdG7C6VF3GwqQOA=; b=Bb4zS1
	rIn8/xuugr3SGRpebH8K0pfk3zVt/hmWlrpvgEUlmSdZgYNSJwJ11Ye/sqpAXl/y
	JFNg453V1DJwxrv/bvY9o4iGKs0LUJWlTzspkjNArjIhAwBP0T2rktn+v83mTrzH
	JlQkDTQY4+umTdxenf9MfJsYx31VjTWfs0I4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wNsYdkHtnCnUbR7jR3+ACcyQ0BM/H/VB
	V17uQMW2yCY8iV3mblsDG/lGM6daNn3l5REkzTbe4ksXqJDVCaWIRLC3IK2QdgWk
	q8OLQGP2i3TzY89tBcBoqXgeeEBEQytuyr5h792oM1GSbFHfemL1Z2pPYnG38SJf
	ZIWwjnkz83Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F25B56A7;
	Tue, 27 Mar 2012 12:59:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09B2756A6; Tue, 27 Mar 2012
 12:59:34 -0400 (EDT)
In-Reply-To: <4F715D55.8020109@gmx.net> (Ivan Todoroski's message of "Tue, 27
 Mar 2012 08:25:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3AF3F4B2-782E-11E1-A4C5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194057>

Ivan Todoroski <grnch@gmx.net> writes:

> sha=$(git rev-parse HEAD)
> for ((i=0; i<50000; i++)); do
> 	echo $sha refs/tags/artificially-long-tag-name-to-more-easily-\
> demonstrate-the-problem-$i >> .git/packed-refs
> done

This comment does not have much to the issue, but the above is better
written as

	commit=$(git rev-parse HEAD) i=0
        while test $i -le 50000
        do
        	echo $commit refs/tags/....-$i
	done >>.git/packed.refs

to stay within the usual Bourne shell.

> 4) Add option --stdin to pass the refs on stdin, one per line.
> ...
> In the end we settled on the following solution:
>
> If --stdin is specified without --stateless-rpc, fetch-pack would read
> the refs from stdin one per line, in a script friendly format.
>
> However if --stdin is specified together with --stateless-rpc,
> fetch-pack would read the refs from stdin in packetized format
> (pkt-line) with a flush packet terminating the list of refs. This way we
> can read the exact number of bytes that we need from stdin, and then
> get_remote_heads() can continue reading from the same fd without losing
> a single byte of remote protocol data.

That sounds like the right way to use pkt-line machinery.  Send stuff you
need to send, and mark it with a flush to tell the receiver that you have
finished giving one logical collection of information.

> This way the --stdin option only loses generality and scriptability when
> used together with --stateless-rpc, which is not easily scriptable
> anyway because it also uses pkt-line when talking to the remote server.
> ---

Just a gentle reminder; the final submission will need your sign off here.

> diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
> index ed1bdaacd1..1dd44fd348 100644
> --- a/Documentation/git-fetch-pack.txt
> +++ b/Documentation/git-fetch-pack.txt
> @@ -32,6 +32,16 @@ OPTIONS
>  --all::
>  	Fetch all remote refs.
>  
> +--stdin::
> +	Take the list of refs from stdin, one per line. If there
> +	are refs specified on the command line in addition to this
> +	option, then the refs from stdin are processed after those
> +	on the command line.
> ++
> +If '--stateless-rpc' is specified together with this option then
> +the list of refs must be in packet format (pkt-line) with a flush
> +packet terminating the list.
> +

It is not clear from this description alone if this is a single (possibly
giant) packet with multiple lines, each of which describes a ref, or a
series of one packet per ref with a flush at the end of the sequence.

> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index a4d3e90a86..1a90fa852f 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -972,6 +978,43 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>  	if (!dest)
>  		usage(fetch_pack_usage);
>  
> +	if (args.refs_from_stdin) {
> +		/* copy refs from cmdline to new growable list,
> +		   then append the refs from stdin */

        /*
         * We tend to format our multi-line
         * comments like this
         */

> +		int alloc_heads = nr_heads;
> +		int size = nr_heads * sizeof(*heads);
> +		heads = memcpy(xmalloc(size), heads, size);
> +		if (args.stateless_rpc) {
> +			/* in stateless RPC mode we use pkt-line to read
> +			   from stdin, until we get a flush packet */
> +			static char line[1000];

We will never have a refname that is longer than this limit?

> +			for (;;) {
> +				int n = packet_read_line(0, line, sizeof(line));
> +				if (!n)
> +					break;
> +				if (line[n-1] == '\n')
> +					line[--n] = '\0';
> +				ALLOC_GROW(heads, nr_heads + 1, alloc_heads);
> +				heads[nr_heads++] = xmemdupz(line, n);

Micronit. The use of xmemdupz() here means you do not have to replace LF
with NUL above; decrementing 'n' should be sufficient.

> +			}
> +		}
> +		else {
> +			/* read from stdin one ref per line, until EOF */
> +			struct strbuf line;
> +			strbuf_init(&line, 0);
> +			for (;;) {
> +				if (strbuf_getline(&line, stdin, '\n') == EOF)
> +					break;
> +				strbuf_trim(&line);
> +				if (!line.len)
> +					continue; /* skip empty lines */

Curious.  "stop at EOF", "trim" and "skip empty" imply that you are
catering to people who debug this from the terminal by typing (or copy
pasting).  Is that the expected use case?

Otherwise we may want to tighten this part a bit to forbid cruft (e.g. a
line with leading or trailing whitespaces).

> +				ALLOC_GROW(heads, nr_heads + 1, alloc_heads);
> +				heads[nr_heads++] = strbuf_detach(&line, NULL);
> +			}
> +			strbuf_release(&line);
> +		}
> +	}
> +
>  	if (args.stateless_rpc) {
>  		conn = NULL;
>  		fd[0] = 0;
> diff --git a/fetch-pack.h b/fetch-pack.h
> index 0608edae3f..292d69389e 100644
> --- a/fetch-pack.h
> +++ b/fetch-pack.h
> @@ -13,7 +13,8 @@ struct fetch_pack_args {
>  		verbose:1,
>  		no_progress:1,
>  		include_tag:1,
> -		stateless_rpc:1;
> +		stateless_rpc:1,
> +		refs_from_stdin:1;
>  };
>  
>  struct ref *fetch_pack(struct fetch_pack_args *args,
