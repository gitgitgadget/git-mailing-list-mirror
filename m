Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82E3F1FCC7
	for <e@80x24.org>; Sun, 12 Feb 2017 01:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751050AbdBLBlK (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Feb 2017 20:41:10 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36081 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbdBLBlK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2017 20:41:10 -0500
Received: by mail-pg0-f66.google.com with SMTP id 75so6151025pgf.3
        for <git@vger.kernel.org>; Sat, 11 Feb 2017 17:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yGPgDME17xfSxdA3xw1Nt+3pTg1t7BeGpUDTQWzAF20=;
        b=kSaVgGE9FQdN5Ti3ZmbzrjhmhmaeLpopsH4ssN6PPP00wXWP4fyq7gs1Fw+rvNRWwE
         lLWZ9MfyQ1jibF9qb30+hInMoQidAA7HhUyzAczEhnMd30Azho2yIl4CwzEswnJJEnqr
         sPHTFsCV5+PRKBsSdrtnIlx/3KBXpiH1GktwA5IBH2+6QYjhgewdP6NCW92AbRVofsob
         mTSGhlOim5uY8zvif+gFRV8a2tCWe+N/VOLIV39CxSbLiyVi7u0Aa2X3b0TMUTO2Fg8I
         yaR5PXiC8hCSCAZJwy8Mr7BxRh4LZ6hTV+YfnGMKe7cDKKIQNOVotPAelUh/LEGB6eFx
         ahXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yGPgDME17xfSxdA3xw1Nt+3pTg1t7BeGpUDTQWzAF20=;
        b=p59pUSKQ4XM6rtYaaU4MyJwXYg3i+tpNw/NNGe6ui9tw+Y8Jd6wm3a0vE6bPLTbe9h
         iGZn0fxjbLlRSoslQE2SxYWhFqa+azfvctCxtwqzto2LA7lllSmunt9OOOkhKCXiW9oq
         lX4Ghy1FtwL1gHt28fB3T9CYyhNx5tgMm0ceEd+oCGK9i7DQEdjjSMviXViGPhsLo8xL
         tzkm3NRofy0ToHH5unxObHoi22xkomHOvqEF0P2sSIs0kTxR3xOBNAsrCtCHnvNOl53g
         FqfjAgNTIzrrfmpHFRwvNl/zsy8icKVJarf77vYA+K3o6qS769NtX4oi/H5knd3PYl7e
         tGLg==
X-Gm-Message-State: AMke39knrj8IgOw+7Yi9AcHBmjNH/ZPTEhBrXiiKE3996IRyfXY7ZDhkncv7R4trzA3xQw==
X-Received: by 10.84.232.129 with SMTP id i1mr1211758plk.129.1486863669558;
        Sat, 11 Feb 2017 17:41:09 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d4bf:82d:ab5d:5a31])
        by smtp.gmail.com with ESMTPSA id u78sm6640378pfa.101.2017.02.11.17.41.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 11 Feb 2017 17:41:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [RFC] send-email: avoid duplicate In-Reply-To and References headers
References: <20170212003432.GA19519@starla>
Date:   Sat, 11 Feb 2017 17:41:08 -0800
In-Reply-To: <20170212003432.GA19519@starla> (Eric Wong's message of "Sun, 12
        Feb 2017 00:34:32 +0000")
Message-ID: <xmqq60kggp8r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> When parsing an mbox, it is possible to get existing In-Reply-To
> and References headers blindly appended into the headers of
> message we generate.   This is probably the wrong thing to do
> and we should prioritize what was given in the command-line,
> cover letter, and previously-sent messages.
>
> One example I've noticed in the wild was:
>
> https://public-inbox.org/git/20161111124541.8216-17-vascomalmeida@sapo.pt/raw
> ---
>  I'm not completely sure this is what Vasco was doing in that
>  message, so it's an RFC for now...

I think it is sensibleto give priority to the --in-reply-to option
given from the command line over the in-file one.  I am not sure if
we want to drop references, though.  Wouldn't it make more sense to
just add what we got from the command line to what we read from the
file?  I dunno.

>  git-send-email.perl | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 068d60b3e6..5ab3d8585c 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1543,7 +1543,13 @@ foreach my $t (@files) {
>  			elsif (!/^Date:\s/i && /^[-A-Za-z]+:\s+\S/) {
>  				push @xh, $_;
>  			}
> -
> +			elsif (/^(?:References|In-Reply-To):/i) {
> +				if (defined $initial_reply_to || $thread) {
> +					warn
> +"Ignoring $_ header in mbox body since it conflicts with\n
> +--in-reply-to and --thread switches\n"
> +				}
> +			}
>  		} else {
>  			# In the traditional
>  			# "send lots of email" format,
