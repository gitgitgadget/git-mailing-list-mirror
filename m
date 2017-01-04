Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19DBF20798
	for <e@80x24.org>; Wed,  4 Jan 2017 13:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030698AbdADNei (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 08:34:38 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:34144 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030695AbdADNeh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 08:34:37 -0500
Received: by mail-it0-f66.google.com with SMTP id q186so2114258itb.1
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 05:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HOWTq+SI7f8sTRAADBqTLWeeED+5F6QsE59lkEfbeic=;
        b=V6w/j6ws5b1gdizHBLkunaEi7UynA0Pc0jxtFcEjE0Jv1nuQjfbC5lc8BFzF7HQeM9
         boqDFZjUP4ntMkahSK0gFoCoe9F2x9t4VgFLP1YSQ4iARCRqAtDSBcqgXPJ1TrRFzZt0
         uW72/fhK1NPbffF0I1QwOzBGckF1Dv3azI2jpom7UVXUYQkbfkBJjgNSCzoJmfCJNYrf
         aFaSYpTlONGUVxWfTSnlIL9v7NM02lBh54rPZQZ99AHEcnHaNlFNUmT0957TPy5PNjZn
         8vTeAViTUG97uL5mwJm7EubgcQqKD4QNnmVjsIbbAU0iRVTRJMbQWsbd6/cMiNLtAwba
         jslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HOWTq+SI7f8sTRAADBqTLWeeED+5F6QsE59lkEfbeic=;
        b=CLOs19KwYNndBahKubiP7sYTYGH7Dbmw7vTdoKuDPVtItR1XN250lcmef+Q6PIgXrD
         W1RJXmLXba5J4WN84BD7XNPN+rls+r6jl+/AoMnAenNj/bEO7JK41SGEDAOHn36fZ2M1
         0nBr//sw1HtLxvLSPWRVeRjNKbFgzFmI1C2vXCe/mch7kZ6Y/8Q7um8nU7IZLvYdurqq
         F8gmYILmzk/7L3nRwi72/IJqwcPDe/G/oF9iFx7he9pf5xxRVuL+GEtQRnrZA6Egw9xg
         RmCQV45DMDsBJdaVz0cAIdBteL8KZdI2q+ozywQqXvgU/V8iQ4ZRo0KQmb/J4gMQkVqh
         1ERA==
X-Gm-Message-State: AIkVDXJyoa2up0sAdVC4MC047zT+bDfbD3pcmUlQmVXvB0IQs21+PU4q8dirSGuS8AjupXWIiabd0xAnctQN7Q==
X-Received: by 10.36.184.194 with SMTP id m185mr52226355ite.3.1483536876197;
 Wed, 04 Jan 2017 05:34:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Wed, 4 Jan 2017 05:34:05 -0800 (PST)
In-Reply-To: <CAGZ79kZoiFfi9+-yqHZmF3Ofp3X-CV6s0qg1bm2CRpN-ETbDLw@mail.gmail.com>
References: <20161219215709.24620-1-sbeller@google.com> <20161219215709.24620-3-sbeller@google.com>
 <20161219222551.GA41080@google.com> <CAGZ79kZoiFfi9+-yqHZmF3Ofp3X-CV6s0qg1bm2CRpN-ETbDLw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 4 Jan 2017 20:34:05 +0700
Message-ID: <CACsJy8DJtKw+gH+GJTHwGBJ=Bpc=xoN-ck56qNNPLTZ=mC++Lw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dir.c: add retry logic to relocate_gitdir
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 20, 2016 at 6:19 AM, Stefan Beller <sbeller@google.com> wrote:
>> On 12/19, Stefan Beller wrote:
> This code is heavily inspired by refs/files-backend.c which upon
> closer inspection only retries directory things within the git directory
> (which is assumed to be accessed in parallel by different invocations
> of Git)

I take inspiration from lock/temp files on the other hand. Could we
keep some sort of "undo journal" as we move along and clear it when
the "transaction" is completed? The good thing about lock files is,
even if you die() or SIGTERM'd, rolling back can still take place (but
it has to be something very simple, like removing or renaming because
you don't want to do big things in a signal handler).

If things turn out to be complicated and risky to be executed in an
unknown context, we could still print a helpful message like "yeah
you're in trouble, maybe try this and this, or consult git mailing
list. We apologise for the inconvenience,"
-- 
Duy
