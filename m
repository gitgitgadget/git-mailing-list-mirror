Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A86521F770
	for <e@80x24.org>; Wed,  2 Jan 2019 20:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfABUfy (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 15:35:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43042 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfABUfy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 15:35:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so31682709wrs.10
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 12:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=G8q9aQnp2tEd7KBqYORIjNA7zoETh4umZSYpJ9VcaoI=;
        b=o2q4IfqvvLTxAkrM6Wq+CoQ1eiV8jlKAt3zVYNMvoMlMnT/qhrca8v5Gv12+Ci/2CR
         Ry8xkppJ1Kdtoqaqu/YQBCC+BdEp2EGqn1g5Z1oKKo+ijxdsEkO3YDBlPwMzGXKNaLSJ
         6Rs7zWsTmB2byA8MEP3TRrjXFFBkw4cS2qpggUJyTMY2GiB/dZG67Su92Lq2RYIOSA6Z
         5sHYevExiCxD39ENr7BRGf+gzkKq2XrC2ZNaIIPx+iyWnLZYreBv6jEhbMf8jI2ytRfP
         kGiQVsXIrTOSonhYK4dS7ATdYZkgFGITYzBygBH/qV4s8sWjp7CrR+NUFLJJdmAN2f5H
         npkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=G8q9aQnp2tEd7KBqYORIjNA7zoETh4umZSYpJ9VcaoI=;
        b=NQ3HDMrAa2bxmSOLwKxqo/FEw2fVrb1buUAriz7CkLv/vScj5RVOgeSfS054nm/LOQ
         kKYt01vN+dapWCZ00Jd0RjK1xZcV7iHg++ulbCtjm+8uk7QISWhrz5EIcpnoIDjGKu9B
         FL90pWDT5sTR5ssUF+3CWjCSuJW++XlpxfAONqCw/esgeZXnkZ/3XLxewfNurrIvXAFh
         ovOeMbkBjjDRFJ4tZdUM9Zb1efipt3I593ypW1rGN190NTqA63i5haNHPc30qHvoR+v0
         f+CE80JSuxYBVZ9vTbJehTS6BocKEwrzKaTnMw1Vkcm1yq42lcG0uWws/rQmomXxuLNW
         K+4g==
X-Gm-Message-State: AJcUuke/gUYd3QusRDnn6ilCYMejuGM2wh6of3eDSXG5oL2yPA4ibDSs
        1bYIRUYqX4yoDhyhQK9fC84=
X-Google-Smtp-Source: ALg8bN5H2mhNh7m58QwSGI1EUNXbz47jRrHB81nm7pYF9b/H6jTW4iCQB731DnF9GKJGW8X4fmlrzw==
X-Received: by 2002:a5d:6907:: with SMTP id t7mr21405624wru.226.1546461351974;
        Wed, 02 Jan 2019 12:35:51 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u204sm66956078wmu.30.2019.01.02.12.35.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 12:35:51 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stan Hu <stanhu@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] sha1-name.c: Fix handling of revisions that contain paths with brackets
References: <20181224080651.GA12708@duynguyen.home>
        <20181229054357.11716-1-stanhu@gmail.com>
Date:   Wed, 02 Jan 2019 12:35:50 -0800
In-Reply-To: <20181229054357.11716-1-stanhu@gmail.com> (Stan Hu's message of
        "Fri, 28 Dec 2018 21:43:58 -0800")
Message-ID: <xmqqftuakdax.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stan Hu <stanhu@gmail.com> writes:

> -	if (len < 4 || name[len-1] != '}')
> +	if (len < 4)
>  		return -1;

The original does not expect any string given after the ^{<type>}
dereferencer, like :<path>, and that is why this function returns
very early for anything when name[len-1] is not a closing brace.

We do not do that anymore, because...?

This gives me a nagging feeling that the patch is barking up a wrong
tree.  Consider what happens when a path that does not have any
funny characters, e.g. "v1.4.0^{tree}:a/b/c", is given from the top
level of the request chain (e.g. "rev-parse v1.4.0^{tree}:a/b/c")?
The caller must be feeding this function "v1.4.0^{tree}" after
finding the colon before the path "a/b/c" and setting len to point
at the colon---otherwise we won't be checking for "}" at the end
like this.

When given "master^{tree}:a/b/{c}", wouldn't the caller be doing
the same stripping to find the colon and calling this function with
len pointing at the colon before the path (i.e. "master^{tree}")?

To put it another way, it is OK if this patch wants to shift the
responsibility of finding the colon that separates the tree-ish part
and the path part from the caller to this function, but then I would
expect changes to the caller, because now the caller does not have
to find ":a/b/c" in "v1.4.0^{tree}:a/b/c" and set up the len before
calling this function.  Why can the resulting code after applying
this patch be correct without such a matching change? 

>  
> -	for (sp = name + len - 1; name <= sp; sp--) {
> +	for (sp = name; sp < name + len; sp++) {
>  		int ch = *sp;
> -		if (ch == '{' && name < sp && sp[-1] == '^')
> +		if (ch == '^' && sp < name + len && sp[1] == '{')
>  			break;
>  	}

We used to scan from the tail (as we expected that the caller gives
us a (name, len) that ends with "^{<type>}".  The updated code
instead scans from the front, looking for "^{".  I do not
particularly mind the change of strategy, as long as it is correctly
done, but I suspect the function will stay simpler if the callee is
fixed instead.

The only troublesome case is the REV^{/...} syntax.  For example,

	HEAD^{/^Git 2.0}^{tree}:t/

would want to find the commit "HEAD^{/^Git 2.0}", peel it down to a
tree object with "^{tree}" and then take its "t/" subtree.  It used
to be that the caller (get_oid_with_context_1() has a loop that
finds a colon outside "{...}" and that finds ":t/" before calling
get_oid_1()) was responsible to give us "HEAD^{/^Git 2.0}^{tree}" by
stripping ":t/", and I presume that it is still happening, but the
above loop would terminate upon seeing "^{" immediately after HEAD,
without even realizing that it has ^{tree} after it.

> -	if (sp <= name)
> +
> +	if (sp == name + len)
>  		return -1;

> -	sp++; /* beginning of type name, or closing brace for empty */
> -	if (starts_with(sp, "commit}"))
> +	sp += 2; /* beginning of type name, or closing brace for empty */

And this comment indicates that the code did not expect to see ^{/^Git 2.0}
before ^{tree}.  

I do not quite follow.  How can this patch be correct?

Puzzled.

$ git rev-parse "master^{/^Git 2.0}^{tree}"
bc6ce29d1ec757d9d036532531a1046db4da0d96
$ ./git rev-parse "master^{/^Git 2.0}^{tree}"
master^{/^Git 2.0}^{tree}
fatal: ambiguous argument 'master^{/^Git 2.0}^{tree}': unknown revision or path not in the working tree.
