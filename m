Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00BB6211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 04:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbeLEEKP (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 23:10:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60463 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeLEEKP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 23:10:15 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DF241185F0;
        Tue,  4 Dec 2018 23:10:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VxfA6M+ZUP+7Gq8vlNtcjhDcPNw=; b=e9HDIp
        aTmmfIXeHHHdObf48ni3AeL4BX1qyCG1lAxBPaYvpkXJ3vbz9bJ5hsmBwykwW2Gd
        SE8gslM8LV1chd4/mebxGQK+vOmrLduzJQOKpcqrwXtR1SiM1W5DkXEYmu5fN2ph
        SppyjZk3f+H9scB1DJLSzrqh2BJFFHwHOmcGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=coYnat+eDGWOvcYfVHNubOUCOasSy6du
        IbWu5oKRs+va1lSoNTA/42be/7HIq17rHHIf29O2aut1w7JJC+S9RTCo6NRx/EyD
        Q098ataaI7dhReW6OxcSUh02naevPiUtLZdET3hLxS02W/lZCaw5mSSay7N/NYRg
        chHxlD7+r34=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 65F771185EF;
        Tue,  4 Dec 2018 23:10:13 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D02A41185EE;
        Tue,  4 Dec 2018 23:10:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [WIP RFC 1/5] Documentation: order protocol v2 sections
References: <cover.1543879256.git.jonathantanmy@google.com>
        <061dacf51763bd2f72b95c382e08f44655e247a7.1543879256.git.jonathantanmy@google.com>
Date:   Wed, 05 Dec 2018 13:10:11 +0900
In-Reply-To: <061dacf51763bd2f72b95c382e08f44655e247a7.1543879256.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 3 Dec 2018 15:37:34 -0800")
Message-ID: <xmqqin08d36k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9B70BD6-F843-11E8-8FE3-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> The git command line expects Git servers to follow a specific order of

"Command line"?  It sounds like you are talking about the order of
command line arguments and options, but apparently that is not what
you are doing.  Is it "The git over-the-wire protocol"?

> +    output = acknowledgements flush-pkt |
> +	     [acknowledgments delim-pkt] [shallow-info delim-pkt]
> +	     [wanted-refs delim-pkt] packfile flush-pkt

So the output can be either 

 - acks followed by flush (and nothing else) or

 - (possibly) acks, followed by (possibly) shallow, followed by
   (possibly) wanted-refs, followed by the pack stream and flush at
   the end.

> @@ -335,9 +335,10 @@ header.
>  	       *PKT-LINE(%x01-03 *%x00-ff)
>  
>      acknowledgments section
> -	* If the client determines that it is finished with negotiations
> -	  by sending a "done" line, the acknowledgments sections MUST be
> -	  omitted from the server's response.
> +	* If the client determines that it is finished with negotiations by
> +	  sending a "done" line (thus requiring the server to send a packfile),
> +	  the acknowledgments sections MUST be omitted from the server's
> +	  response.

OK.  

>  	* Always begins with the section header "acknowledgments"
>  
> @@ -388,9 +389,6 @@ header.
>  	  which the client has not indicated was shallow as a part of
>  	  its request.
>  
> -	* This section is only included if a packfile section is also
> -	  included in the response.
> -

Earlier, we said that shallow-info is not given when packfile is not
there.  That is captured in the updated EBNF above.  We don't have a
corresponding removal of a bullet point for wanted-refs section below
but probably that is because the original did not have corresponding
bullet point to begin with.

>      wanted-refs section
>  	* This section is only included if the client has requested a
>  	  ref using a 'want-ref' line and if a packfile section is also
