Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95DA61F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 18:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387912AbeGJSwa (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 14:52:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38517 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733229AbeGJSw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 14:52:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id m1-v6so2959582wrg.5
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 11:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6OWkRTFSH3c+MSBylCXAXegwO5YB1K7h5gQwSTeati4=;
        b=ShW5Dw2DKaTfLE6K82JJ/mgWSnb7JSr4HEaBo46RZUrhQ/Mdv4gpS/Mj3jcV3IgNE6
         HtXnIgC3VgKYO9C6AkASjcN3rHBKkBow6Ck7EuGPSPt4HRRkPRXuJJPE8oFVAUK9JkZx
         ceBA27geWxnFOi0R9VkBchB3lHDEl1RnbtTX+vOIhhs/LO8gKnFpPwubVnS7lty2+TEQ
         y4KpS0Ok+JCUwbpoK+f/HK6WbsjWK0eVJjYufzzNivqccsnQYBReXEu7f04lhSQ8LFzo
         K8QXmPMVxpbWqrl+0pTSJJR6xLgTnbBua43gm5qDG3haNFVvsFmg3mtcvYiywOI4XWMp
         3gYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6OWkRTFSH3c+MSBylCXAXegwO5YB1K7h5gQwSTeati4=;
        b=fk2s2fOYc67LYrlWXMbavXxU4WDssM+4lL1CAExr82W+wHv+N5vQVaHKVA+23tk9Ws
         cJXKCefJvpDxONY13GABn++haUZKszSk7MpX0xt1FTBViM2BQ27xIh8SgfDr80N6Qi36
         IX+Q7eCSOUXOEFipCt4dBSIP8lb9k1VetxFU5pg49WYKHUpHPlMX4GB1+2X1d3AaSTtq
         FwFbcaHOvrBNfJj51hPjrxFyLUpjZsMzXDWLjWZIdIH6XCmUOGrYSrcNK0KRAcByGhlT
         6yn7JLem+azhXjQ1f5fy3zv/V4z4GqZYIZAEFAzh/me9wCnc/0KGbRAWTYSYLQl6fehn
         at/A==
X-Gm-Message-State: AOUpUlH1v0LPbfhdp8qtubTAEGHHD8GtvL2eqiy3N0CT+Ke0zudfg2yU
        jyxu2ncXhwQ7u7naNMlM8s8=
X-Google-Smtp-Source: AAOMgpdCIKjVTLyI9fRzzejn76rTjdbIzo1E1aFeZn63rIOp+rMfHYAoARQs7n/wWFIjDBYNxtcWrw==
X-Received: by 2002:adf:fd12:: with SMTP id e18-v6mr11248742wrr.280.1531248729692;
        Tue, 10 Jul 2018 11:52:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h4-v6sm18734066wre.89.2018.07.10.11.52.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 11:52:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v3 09/13] sequencer: change the way skip_unnecessary_picks() returns its result
References: <20180702105717.26386-1-alban.gruin@gmail.com>
        <20180710121557.6698-1-alban.gruin@gmail.com>
        <20180710121557.6698-10-alban.gruin@gmail.com>
Date:   Tue, 10 Jul 2018 11:52:08 -0700
In-Reply-To: <20180710121557.6698-10-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 10 Jul 2018 14:15:53 +0200")
Message-ID: <xmqq4lh67wkn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> -	if (command == SKIP_UNNECESSARY_PICKS && argc == 1)
> -		return !!skip_unnecessary_picks();
> +	if (command == SKIP_UNNECESSARY_PICKS && argc == 1) {
> +		ret = !!skip_unnecessary_picks(&oid);
> +		if (!ret && oid)
> +			puts(oid);

Think why you wrote !! there; in other words, avoid getting into a
habit of blindly copying and pasting existing code without thinking.

The original is synthesizing an integer value that is to be used as
the final exit status from a process, which has to be a non negative
integer, out of a helper function, whose error return may be
nagative [*1*], and it knows that the caller cares only about one
bit "did we or did we not have an error?", so it turns any non-zero
return value into 1.  That is why it uses !!.

	Side note *1* The normal convention for helper functions is
        to signal an error with negative return value, and success
        with 0.  There may be different negative values used to
        signal different error conditions to the caller, depending
        on how well the API is designed.

But realize that !! is an operation that loses information, so in
general you would want to delay its application til when you need
it.  In this particular case, you do not care what kind of error
you got (or you didn't), so you can just say

	ret = skip_unnecessary_picks(&oid);
	if (!ret && oid)
		puts(oid); /* happy */

without applying !! before receiving the return value from the
helper in "ret".

> +		return ret;

And ensure that you return only 0 or 1 by applying !! here instead.

> diff --git a/sequencer.c b/sequencer.c
> index 2b6ddc6cf..676ac1320 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4392,7 +4392,7 @@ static int rewrite_file(const char *path, const char *buf, size_t len)
>  }
>  
>  /* skip picking commits whose parents are unchanged */
> -int skip_unnecessary_picks(void)
> +int skip_unnecessary_picks(const char **output_oid)
>  {
>  	const char *todo_file = rebase_path_todo();
>  	struct strbuf buf = STRBUF_INIT;
> @@ -4467,7 +4467,7 @@ int skip_unnecessary_picks(void)
>  	}
>  
>  	todo_list_release(&todo_list);
> -	printf("%s\n", oid_to_hex(oid));
> +	*output_oid = oid_to_hex(oid);

The return value of oid_to_hex() is not meant to be long-lived.
Consider writing into caller supplied buffer with oid_to_hex_r()
or something like that.
