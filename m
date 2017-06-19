Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EAEC1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 20:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbdFSUHk (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 16:07:40 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36534 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbdFSUHj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 16:07:39 -0400
Received: by mail-pf0-f179.google.com with SMTP id x63so58558444pff.3
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 13:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zN/I6j1YnGwsh/mxDcUuuhdmH3rEVqcfIccG+3lomQE=;
        b=hYHDr8RCPTbYHjhOmQj+k1jdOymI39ibK2HXYfdZUZBk0gELSSzIiSxgwfcF7LA5oN
         5orVmFGaDKwNyP39Oqx1Sp7CZF2mVMf7+VyHlsI8qqMd6CkQArn9ngLxjA35UvAkTISi
         TeaiD1WAK3D++S08hOSPjMonamsIjdbg0XzSJRhdM69bYkexqxdNH7M7fkIksGp7Bjct
         sqRNqLyj1j+hpVdt1yskUhs7gdvYQbBvSypwFIoPXsnf4Za1S/ORDG+A9kbkq8UJfCws
         ImUl52aXTVLFgtT4mYPXZ/1CgCZFXc+emZhNa7HShYNiXB1rJfYEFfcJ33qgDvhuQt8e
         SPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zN/I6j1YnGwsh/mxDcUuuhdmH3rEVqcfIccG+3lomQE=;
        b=UlxYzfsdhBlckkDOTNh02wRtqeUR1A6+HokOCtW7RgbEYgeAhQq4y/lmLQMLoh9knz
         rBT9p2tA1NRODfxdYPLZlmnSwsRAlMAKzJE7HHjcfWx12VD/+kZejQSP+BL6KysprUnh
         90UDUv4HASzotI3yugrj35IKwJQnI59CpWlfcAzE8Mm+aHMhESC/rjHkW77Z+fbjoLLW
         yueIz8EH5TAd4N3pkiiWjXYjFnp3z61VAn1+EmuQkuW2t5q1eV11tAXtJTpsNs4Up9Z1
         LOyAQpw8PPKeCMmwAx7JhpxQp9Y5sk9pAWyUNt+8CV2V4W6I/bEM9UjQGS4IjBCdLgWR
         6SUQ==
X-Gm-Message-State: AKS2vOygZWBSRUoeflw15lhIbub3Nod2UaJYSjSfVGODPXlJtTyVc2sG
        e5UbI/U4thXlXGZiOvs=
X-Received: by 10.84.139.195 with SMTP id 61mr31516987plr.56.1497902858576;
        Mon, 19 Jun 2017 13:07:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:7466:3d2b:4ee9:fc7])
        by smtp.gmail.com with ESMTPSA id t82sm22571077pfe.88.2017.06.19.13.07.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 13:07:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 0/5] remote: eliminate remote->{fetch,push}_refspec and lazy parsing of refspecs
References: <20170616192837.11035-1-szeder.dev@gmail.com>
        <20170617115522.lbke5wnle5irbunj@sigill.intra.peff.net>
Date:   Mon, 19 Jun 2017 13:07:36 -0700
In-Reply-To: <20170617115522.lbke5wnle5irbunj@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 17 Jun 2017 07:55:22 -0400")
Message-ID: <xmqqmv93spvb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If we forget the "storing it twice" argument, would it make sense to
> convert the parallel arrays of items into a single array-of-struct?
> I.e.:
>
>   struct configured_refspec {
> 	const char *string;
> 	struct refspec refspec;
> 	unsigned parsed:1;
>   }
>
> I guess that may run into problems where we really need an
> array-of-refspec to pass into sub-functions. So going further, could we
> just have "struct refspec" store the text form it was parsed from?

I find this a sensible suggestion.  

I think the original "parallel" structure was anticipating that a
textual input we get from the user (either from the command line or
from the configuration) could expand to multiple parsed refspecs for
easier use by the code, but it appears that we hadn't seen a need
for that, so I think it is safe to unify them into a single struct.

Of course, that still anticipates that a parsed refspec may not be
unambiguously turned back to textual original input form; if that
will never be the case, then the approach taken by the posted
patches should also be OK.
