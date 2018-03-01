Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31F581F404
	for <e@80x24.org>; Thu,  1 Mar 2018 18:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034030AbeCASoy (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 13:44:54 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52710 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034000AbeCASou (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 13:44:50 -0500
Received: by mail-wm0-f67.google.com with SMTP id t3so14010547wmc.2
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 10:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9gcRly+wVhCh1mZJSd7jzD5LKUbE1MxizTfuREk4Z80=;
        b=f6VvfPFYeMw/vVsOyRsxPdqzCt9JEw/dt1PaHVbTjFQwkRSyK6fiCc6DyuO2SJ/+Dh
         /4RME8HZpX+43NpfM/Olw1kKGnmVc677je1k9Rb5T5VzMF3PCFimBOgAW8xuR7dcEIA3
         WA32Ph7zJq8THe98ObSXi3l5tze2g5EJ8WCw1xWi0HI4magbKyZF10zsA1JBQMvuXu6R
         EUSTsOfIDNPBQPk1tFg4G0nO4wpp9xW5YPcGwS+eyJg+QApWAVdGPotP6HZ04VJ3FgSs
         /PHbK2g+HkBfiYdVZXEv12brgdev+tXEay68vZDOjpVIIZO0DZXHJwqMFaxGHcZBTOWN
         ZZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9gcRly+wVhCh1mZJSd7jzD5LKUbE1MxizTfuREk4Z80=;
        b=W/Xk90waIACwdL98t1Me3GseEYSVn+uX9Yi2//u8tzGWPvdmkCEw0oA/hybdgBwYWS
         c+EiOHvBsiwBUzj502XOoiqcWLoGFvhsvGmXk+f5qCHlaqZnmZRul/DZr0qedF/5elwg
         f/mwUU6/WcxrbET0XMaAmG/+XZ/6UeTbn02jUW99hTonNmEzoA3aiwm1W+rKXAF6oRMG
         BkaROzqwCKHL+fmomtUbrihE3cNHYwrXkkFBW+Ehhsxfregmc38TvpF7WwPAtF7aurJ3
         G0cm53rEMMGtXvyrjJb2blb33+iZyfEv3bQ+RGk24qr/bBvQOP544u6MkPwdokimov2u
         NoZg==
X-Gm-Message-State: APf1xPD1+fGWL3w6G1Ga3mLLWb5lsVn/9JnEg0ztI095EDvsITziFpzY
        paIVg2K76wML6U/atx3h+i4=
X-Google-Smtp-Source: AG47ELt4grfTsN2EX8Yv6FyKmLhXHQhose2gal24QNlTuJghH8H6guRGFqnAvwbZFaJ0JHpJyWw+7g==
X-Received: by 10.28.191.193 with SMTP id o62mr2583124wmi.113.1519929889290;
        Thu, 01 Mar 2018 10:44:49 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q11sm5527970wrb.74.2018.03.01.10.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 10:44:48 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Sergey Organov <sorganov@gmail.com>,
        igor.d.djordjevic@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: The case for two trees in a commit ("How to make rebase less modal")
References: <CAGZ79ka6PXgs+JDicaQYWYSKgEthj0A-2bBaRcdp_0T2H+sREA@mail.gmail.com>
Date:   Thu, 01 Mar 2018 10:44:48 -0800
In-Reply-To: <CAGZ79ka6PXgs+JDicaQYWYSKgEthj0A-2bBaRcdp_0T2H+sREA@mail.gmail.com>
        (Stefan Beller's message of "Wed, 28 Feb 2018 15:30:27 -0800")
Message-ID: <xmqqh8pzhbz3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> $ git hash-object --stdin -w -t commit <<EOF
> tree c70b4a33a0089f15eb3b38092832388d75293e86
> parent 105d5b91138ced892765a84e771a061ede8d63b8
> author Stefan Beller <sbeller@google.com> 1519859216 -0800
> committer Stefan Beller <sbeller@google.com> 1519859216 -0800
> tree 5495266479afc9a4bd9560e9feac465ed43fa63a
> test commit
> EOF
> 19abfc3bf1c5d782045acf23abdf7eed81e16669
> $ git fsck |grep 19abfc3bf1c5d782045acf23abdf7eed81e16669
> $
>
> So it is technically possible to create a commit with two tree entries
> and fsck is not complaining.

The second one is merely a random unauthorized header that is not
interpreted in any way by Git.  It is merely being confusing by
starting with "tree " and having 40-hex after it, but the 40-hex
does not get interpreted as an object name, and does not participate
in reachability computation (i.e. packing, pruning and fsck).

There is not much difference between that and a line of trailer in
the commit log message (other than this one is less discoverable).
