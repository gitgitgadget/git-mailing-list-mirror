Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B27321F859
	for <e@80x24.org>; Fri, 12 Aug 2016 15:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbcHLPW1 (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 11:22:27 -0400
Received: from smtp106.iad3a.emailsrvr.com ([173.203.187.106]:50786 "EHLO
	smtp106.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752377AbcHLPW1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2016 11:22:27 -0400
Received: from smtp14.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
	by smtp14.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 51C786038B;
	Fri, 12 Aug 2016 11:22:26 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp14.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 2AAA260297;
	Fri, 12 Aug 2016 11:22:26 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.7.1);
	Fri, 12 Aug 2016 11:22:26 -0400
Subject: Re: [PATCH v5 11/12] doc: revisions: show revision expansion in
 examples
To:	Philip Oakley <philipoakley@iee.org>,
	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20160720211007.5520-1-philipoakley@iee.org>
 <20160812070749.2920-1-philipoakley@iee.org>
 <20160812070749.2920-12-philipoakley@iee.org>
Cc:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
From:	Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <f418c41b-f590-0b6a-236a-c109a7296434@xiplink.com>
Date:	Fri, 12 Aug 2016 11:22:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160812070749.2920-12-philipoakley@iee.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2016-08-12 03:07 AM, Philip Oakley wrote:
> The revisions examples show the revison arguments and the selected
> commits, but do not show the intermediate step of the expansion of
> the special 'range' notations. Extend the examples, including an
> all-parents multi-parent merge commit example.
>
> Sort the examples and fix the alignment for those unaffected
> in the next commit.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
> new
> Cc: Jakub Narębski <jnareb@gmail.com>
> ---
>  Documentation/revisions.txt | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index 70864d5..ac7dd8e 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -326,16 +326,23 @@ Revision Range Summary
>    as giving commit '<rev>' and then all its parents prefixed with
>    '{caret}' to exclude them (and their ancestors).
>
> -Here are a handful of examples:
> +Here are a handful of examples using the Loeliger illustration above:
>
> +   Args   Expansion       Selection

I think "Result" would be better than "Selection" here.

Also, shouldn't all the ^ in these examples be {caret}?  (I likely just 
don't understand the rationale for using {caret} in some places and ^ in 
others...)

>     D                G H D
>     D F              G H I J D F
>     ^G D             H D
>     ^D B             E I J F B
> -   B..C             C
> -   B...C            G H D E B C
> +   B..C   = ^B C          C
> +   B...C  = B ^F C        G H D E B C
>     ^D B C           E I J F B C
>     C                I J F C
> -   C^@              I J F
> -   C^!              C
> -   F^! D            G H D F
> +   C^@    = C^1

I have a mixed reaction to showing this "C^1" expansion, and the "B^1 
B^2 B^3" one as well.  I see the appeal of showing the parent notation, 
but really that was already explained to death in the first section. 
Here it's distracting.  I think it's clearer for the reader to remove 
these expansions and just use the node names from the illustration.

> +          = F             I J F
> +   B^@    = B^1 B^2 B^3
> +          = D E F         D G H E F I J
> +   C^!    = C ^C^1

I think this expansion might be better expressed as "C ^C^@".  It'll be 
the same for "B^! = B ^B^@" as well, which demonstrates a nice 
consistency and also helps to emphasize the meaning of the ^@ notation.

> +          = C ^F          C
> +   B^! = B ^B^1 ^B^2 ^B^3
> +       = B ^D ^E ^F       B

The layout of these last two lines doesn't match the others.  They 
should be:

    B^!    = B ^B^1 ^B^2   ^B^3
           = B ^D ^E ^F    B

I see that the next patch fixes the layout of the unchanged examples, 
but it leaves these two unaligned.

		M.

